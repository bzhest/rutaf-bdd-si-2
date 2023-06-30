package com.refinitiv.asts.test.api.stepDefinitions.references;


import com.fasterxml.jackson.core.type.TypeReference;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.api.actions.ReferencesApiActions;
import com.refinitiv.asts.test.api.dataproviders.JsonApiDataTransfer;
import com.refinitiv.asts.test.api.dto.references.request.ReferencesRequestDTO;
import com.refinitiv.asts.test.api.dto.references.response.*;
import com.refinitiv.asts.test.api.stepDefinitions.ApiBaseSteps;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.util.Map;

import static com.refinitiv.asts.test.api.dataproviders.ApiDataProvider.REFERENCES_REQUEST;
import static com.refinitiv.asts.test.api.dataproviders.ApiDataProvider.REFERENCES_RESPONSE;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.WORKFLOW_GROUP_NAME_CONTEXT;
import static org.assertj.core.api.Assertions.assertThat;

public class ReferencesApiSteps extends ApiBaseSteps {

    private static final ReferencesApiAssertions assertion = new ReferencesApiAssertions();
    private ReferencesApiActions referencesApi;

    public ReferencesApiSteps(ScenarioCtxtWrapper context) {
        super(context);
        referencesApi = new ReferencesApiActions(context);
    }

    @When("User sends {string} Get request for References Workflow Group endpoint")
    public void sendGetReferencesWorkflowGroupRequest(String requestReference) {
        referencesApi.sendGetWorkflowGroup(requestReference);
    }

    @When("User sends {string} Get request for References Workflow Group endpoint with parameters")
    @SuppressWarnings("unchecked")
    public void sendGetReferencesWorkflowGroupRequestWithParameters(String requestReference,
            Map<String, String> parameters) {
        referencesApi.sendGetWorkflowGroup(requestReference, parameters);
    }

    @When("User sends {string} Get request for References Divisions endpoint")
    public void sendGetReferencesDivisionsRequest(String requestReference) {
        referencesApi.sendGetDivision(requestReference);
    }

    @When("User sends {string} Get request for References Divisions endpoint with parameters")
    @SuppressWarnings("unchecked")
    public void sendGetReferencesDivisionsRequestWithParameters(String requestReference,
            Map<String, String> parameters) {
        referencesApi.sendGetDivision(requestReference, parameters);
    }

    @When("User sends {string} Get request for References Roles endpoint")
    public void sendGetRequestForReferencesRoles(String requestReference) {
        referencesApi.sendGetRoles(requestReference);
    }

    @When("User sends {string} Get request for References Roles endpoint with parameters")
    @SuppressWarnings("unchecked")
    public void sendGetRequestForReferencesRolesWithParameters(String requestReference,
            Map<String, String> parameters) {
        referencesApi.sendGetRoles(requestReference, parameters);
    }

    @When("User sends {string} Get request for References User Group endpoint")
    public void sendGetRequestForReferencesUserGroup(String requestReference) {
        referencesApi.sendGetUserGroups(requestReference);
    }

    @When("User sends {string} Get request for References External Organisation endpoint")
    public void sendGetRequestForReferencesExternalOrganisation(String requestReference) {
        referencesApi.sendGetExternalOrganisation(requestReference);
    }

    @When("User sends {string} Get request for References Department endpoint")
    public void sendGetRequestForReferencesDepartment(String requestReference) {
        referencesApi.sendGetDepartment(requestReference);
    }

    @When("User sends {string} Get request for References Entities endpoint")
    public void sendGetRequestForReferencesEntities(String requestReference) {
        referencesApi.sendGetEntities(requestReference);
    }

    @When("User sends {string} Post request for References User List endpoint")
    public void sendPostRequestForReferencesUserList(String requestReference) {
        JsonApiDataTransfer<ReferencesRequestDTO> requestDataTransfer = new JsonApiDataTransfer<>(REFERENCES_REQUEST);
        ReferencesRequestDTO request = requestDataTransfer.getRequestJsonData(requestReference);
        referencesApi.sendPostUserList(requestReference, request);
    }

    @Then("References Workflow Group endpoint {string} response contains expected {string} data")
    @SuppressWarnings("unchecked")
    public void workflowGroupResponseContainsExpectedResponse(String actualReference, String expectedReference) {
        TypeReference<ReferenceResponseDTO<WorkflowGroupResponseDTO>> typeReference = new TypeReference<>() {
        };
        ReferenceResponseDTO<WorkflowGroupResponseDTO> actualResponse =
                referencesApi.getBodyFromContext(actualReference, typeReference);
        if (context.getScenarioContext().isContains(expectedReference)) {
            ReferenceResponseDTO<WorkflowGroupResponseDTO> expectedResponse =
                    referencesApi.getBodyFromContext(expectedReference, typeReference);
            assertion.verifyResponseIsEquals(actualResponse, expectedResponse);
        } else {
            JsonApiDataTransfer<ReferenceResponseDTO<WorkflowGroupResponseDTO>> workflowGroupDataTransfer =
                    new JsonApiDataTransfer<>(REFERENCES_RESPONSE);
            ReferenceResponseDTO<WorkflowGroupResponseDTO> expectedResponse =
                    workflowGroupDataTransfer.getResponseJsonData(expectedReference);
            assertion.verifyMessageAndNonEmptyData(actualResponse, expectedResponse);
        }
    }

    @Then("References Workflow Group endpoint {string} response contains created group")
    @SuppressWarnings("unchecked")
    public void workflowGroupResponseContainsGroupWithName(String actualReference) {
        String expectedName = (String) this.context.getScenarioContext().getContext(WORKFLOW_GROUP_NAME_CONTEXT);
        TypeReference<ReferenceResponseDTO<WorkflowGroupResponseDTO>> typeReference = new TypeReference<>() {
        };
        ReferenceResponseDTO<WorkflowGroupResponseDTO> actualResponse =
                (ReferenceResponseDTO<WorkflowGroupResponseDTO>) referencesApi.getBodyFromContext(actualReference,
                                                                                                  typeReference);
                .anyMatch(data -> data.getWorkflowGroupName().equals(expectedName));
        assertThat(doesResponseContains).as("Workflow Group response doesn't contain created group").isTrue();
    }

    @Then("References Workflow Group endpoint {string} response does not contain deleted group")
    @SuppressWarnings("unchecked")
    public void workflowGroupResponseDoesNotContainGroupWithName(String actualReference) {
        String expectedName = (String) this.context.getScenarioContext().getContext(WORKFLOW_GROUP_NAME_CONTEXT);
        TypeReference<ReferenceResponseDTO<WorkflowGroupResponseDTO>> typeReference = new TypeReference<>() {
        };
        ReferenceResponseDTO<WorkflowGroupResponseDTO> actualResponse =
                referencesApi.getBodyFromContext(actualReference, typeReference);
        boolean doesNotResponseContains = actualResponse.getData().stream()
                .noneMatch(data -> data.getWorkflowGroupName().equals(expectedName));
        assertThat(doesNotResponseContains).as("Workflow Group response contains created group").isTrue();
    }

    @Then("References Divisions endpoint {string} response contains expected {string} data")
    @SuppressWarnings("unchecked")
    public void divisionsResponseContainsExpectedData(String actualReference, String expectedReference) {
        TypeReference<ReferenceResponseDTO<DivisionResponseDTO>> typeReference = new TypeReference<>() {
        };
        ReferenceResponseDTO<DivisionResponseDTO> actualResponse =
                referencesApi.getBodyFromContext(actualReference, typeReference);
        if (context.getScenarioContext().isContains(expectedReference)) {
            ReferenceResponseDTO<DivisionResponseDTO> expectedResponse =
                    referencesApi.getBodyFromContext(expectedReference, typeReference);
            assertion.verifyResponseIsEquals(actualResponse, expectedResponse);
        } else {
            JsonApiDataTransfer<ReferenceResponseDTO<DivisionResponseDTO>> divisionDataTransfer =
                    new JsonApiDataTransfer<>(REFERENCES_RESPONSE);
            ReferenceResponseDTO<DivisionResponseDTO> expectedResponse =
                    divisionDataTransfer.getResponseJsonData(expectedReference);
            assertion.verifyMessageAndNonEmptyData(actualResponse, expectedResponse);
        }
    }

    @Then("References Roles endpoint {string} response contains expected {string} data")
    @SuppressWarnings("unchecked")
    public void rolesResponseContainsExpectedData(String actualReference, String expectedReference) {
        TypeReference<ReferenceResponseDTO<RoleResponseDTO>> typeReference = new TypeReference<>() {
        };
        ReferenceResponseDTO<RoleResponseDTO> actualResponse =
                referencesApi.getBodyFromContext(actualReference, typeReference);
        if (context.getScenarioContext().isContains(expectedReference)) {
            ReferenceResponseDTO<RoleResponseDTO> expectedResponse =
                    referencesApi.getBodyFromContext(expectedReference, typeReference);
            assertion.verifyResponseIsEquals(actualResponse, expectedResponse);
        } else {
            JsonApiDataTransfer<ReferenceResponseDTO<RoleResponseDTO>> roleDataTransfer =
                    new JsonApiDataTransfer<>(REFERENCES_RESPONSE);
            ReferenceResponseDTO<RoleResponseDTO> expectedResponse =
                    roleDataTransfer.getResponseJsonData(expectedReference);
            assertion.verifyMessageAndNonEmptyData(actualResponse, expectedResponse);
        }
    }

    @Then("References User Group endpoint {string} response contains expected {string} data")
    @SuppressWarnings("unchecked")
    public void userGroupResponseContainsExpectedData(String actualReference, String expectedReference) {
        TypeReference<ReferenceResponseDTO<UserGroupResponseDTO>> typeReference = new TypeReference<>() {
        };
        JsonApiDataTransfer<ReferenceResponseDTO<UserGroupResponseDTO>> userGroupDataTransfer =
                new JsonApiDataTransfer<>(REFERENCES_RESPONSE);
        ReferenceResponseDTO<UserGroupResponseDTO> actualResponse =
                referencesApi.getBodyFromContext(actualReference, typeReference);
        ReferenceResponseDTO<UserGroupResponseDTO> expectedResponse =
                userGroupDataTransfer.getResponseJsonData(expectedReference);
        assertion.verifyMessageAndNonEmptyData(actualResponse, expectedResponse);
    }

    @Then("References User List endpoint {string} response contains expected data")
    @SuppressWarnings("unchecked")
    public void userListResponseContainsExpectedData(String dataReference) {
        TypeReference<ReferenceResponseDTO<UserResponseDTO>> typeReference = new TypeReference<>() {
        };
        ReferenceResponseDTO<UserResponseDTO> actualResponse =
                referencesApi.getBodyFromContext(dataReference, typeReference);
        JsonApiDataTransfer<ReferenceResponseDTO<UserResponseDTO>> userDataTransfer =
                new JsonApiDataTransfer<>(REFERENCES_RESPONSE);
        ReferenceResponseDTO<UserResponseDTO> expectedResponse =
                userDataTransfer.getResponseJsonData(dataReference);
        assertion.verifyMessageAndNonEmptyData(actualResponse, expectedResponse);
        assertion.verifyResponseMetaIgnoreNull(actualResponse, expectedResponse);
    }

    @Then("References User List endpoint {string} response contains filtered data by field value")
    @SuppressWarnings("unchecked")
    public void userListResponseContainsFilteredData(String dataReference) {
        TypeReference<ReferenceResponseDTO<UserResponseDTO>> typeReference = new TypeReference<>() {
        };
        ReferenceResponseDTO<UserResponseDTO> actualResponse =
                referencesApi.getBodyFromContext(dataReference, typeReference);
        JsonApiDataTransfer<ReferenceResponseDTO<UserResponseDTO>> userDataTransfer =
                new JsonApiDataTransfer<>(REFERENCES_RESPONSE);
        ReferenceResponseDTO<UserResponseDTO> expectedResponse =
                (ReferenceResponseDTO<UserResponseDTO>) userDataTransfer.getResponseJsonData(dataReference,
                                                                                             typeReference);
        assertion.verifyUserListResponseFiltered(actualResponse.getData(), expectedResponse.getData().get(0));
    }

    @Then("References User List endpoint {string} response contains filtered Division data by field value")
    @SuppressWarnings("unchecked")
    public void userListResponseContainsFilteredDivisionData(String dataReference) {
        TypeReference<ReferenceResponseDTO<UserResponseDTO>> typeReference = new TypeReference<>() {
        };
        ReferenceResponseDTO<UserResponseDTO> actualResponse =
                referencesApi.getBodyFromContext(dataReference, typeReference);
        JsonApiDataTransfer<ReferenceResponseDTO<UserResponseDTO>> userDataTransfer =
                new JsonApiDataTransfer<>(REFERENCES_RESPONSE);
        ReferenceResponseDTO<UserResponseDTO> expectedResponse =
                (ReferenceResponseDTO<UserResponseDTO>) userDataTransfer.getResponseJsonData(dataReference,
                                                                                             typeReference);
        assertion.verifyUserListResponseFiltered(actualResponse.getData(),
                                                 expectedResponse.getData().get(0).getDivisions().get(0));
    }

    @Then("References External Organisation endpoint {string} response contains expected {string} data")
    @SuppressWarnings("unchecked")
    public void externalOrganisationResponseContainsExpectedData(String actualReference,
            String expectedReference) {
        TypeReference<ReferenceResponseDTO<ExternalOrganisationResponseDTO>> typeReference = new TypeReference<>() {
        };
        JsonApiDataTransfer<ReferenceResponseDTO<ExternalOrganisationResponseDTO>> externalDataTransfer =
                new JsonApiDataTransfer<>(REFERENCES_RESPONSE);
        ReferenceResponseDTO<ExternalOrganisationResponseDTO> expectedResponse =
                externalDataTransfer.getResponseJsonData(expectedReference);
        ReferenceResponseDTO<ExternalOrganisationResponseDTO> actualResponse =
                referencesApi.getBodyFromContext(actualReference, typeReference);
        assertion.verifyMessageAndNonEmptyData(actualResponse, expectedResponse);
    }

    @Then("References Department endpoint {string} response contains expected {string} data")
    @SuppressWarnings("unchecked")
    public void departmentResponseContainsExpectedData(String actualReference,
            String expectedReference) {
        TypeReference<ReferenceResponseDTO<DepartmentResponseDTO>> typeReference = new TypeReference<>() {
        };
        JsonApiDataTransfer<ReferenceResponseDTO<DepartmentResponseDTO>> departmentDataTransfer =
                new JsonApiDataTransfer<>(REFERENCES_RESPONSE);
        ReferenceResponseDTO<DepartmentResponseDTO> expectedResponse =
                departmentDataTransfer.getResponseJsonData(expectedReference);
        ReferenceResponseDTO<DepartmentResponseDTO> actualResponse =
                referencesApi.getBodyFromContext(actualReference, typeReference);
        assertion.verifyMessageAndNonEmptyData(actualResponse, expectedResponse);
    }

    @Then("References Entities endpoint {string} response contains expected {string} data")
    @SuppressWarnings("unchecked")
    public void entitiesResponseContainsExpectedData(String actualReference, String expectedReference) {
        TypeReference<ReferenceResponseDTO<EntityResponseDTO>> typeReference = new TypeReference<>() {
        };
        JsonApiDataTransfer<ReferenceResponseDTO<EntityResponseDTO>> departmentDataTransfer =
                new JsonApiDataTransfer<>(REFERENCES_RESPONSE);
        ReferenceResponseDTO<EntityResponseDTO> expectedResponse =
                departmentDataTransfer.getResponseJsonData(expectedReference);
        ReferenceResponseDTO<EntityResponseDTO> actualResponse =
                referencesApi.getBodyFromContext(actualReference, typeReference);
        assertion.verifyMessageAndNonEmptyData(actualResponse, expectedResponse);
    }

}
