package com.refinitiv.asts.test.api.actions;

import com.fasterxml.jackson.core.type.TypeReference;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.api.dto.references.response.ReferenceResponseDTO;
import com.refinitiv.asts.test.api.dto.references.request.ReferencesRequestDTO;
import io.restassured.response.Response;

import java.util.Map;

public class ReferencesApiActions<T> extends BaseApiActions<ReferenceResponseDTO<T>> {

    private static final String BASE_PATH = "/references";
    private static final String WORKFLOW_GROUPS = "/workflowgroups";
    private static final String DIVISIONS = "/divisions";
    private static final String ROLES = "/roles";
    private static final String USER_GROUPS = "/user-groups";
    private static final String USER_LIST = "/user-list";
    private static final String EXTERNAL_ORGANIZATION = "/external-organization";
    private static final String DEPARTMENT = "/department";
    private static final String ENTITIES = "/entities";

    public ReferencesApiActions(ScenarioCtxtWrapper context) {
        super(context);
    }

    @Override
    public ReferenceResponseDTO<T> getBodyFromContext(String reference,
            TypeReference<ReferenceResponseDTO<T>> typeReference) {
        return getResponseAsObjectFromContext(reference, typeReference);
    }

    public void sendGetWorkflowGroup(String reference) {
        sendGetAndSaveInContext(WORKFLOW_GROUPS, reference);
    }

    public void sendGetWorkflowGroup(String reference, Map<String, String> parameters) {
        sendGetAndSaveInContext(WORKFLOW_GROUPS, reference, parameters);
    }

    public void sendGetDivision(String reference) {
        sendGetAndSaveInContext(DIVISIONS, reference);
    }

    public void sendGetDivision(String reference, Map<String, String> parameters) {
        sendGetAndSaveInContext(DIVISIONS, reference, parameters);
    }

    public void sendGetRoles(String reference) {
        sendGetAndSaveInContext(ROLES, reference);
    }

    public void sendGetRoles(String reference, Map<String, String> parameters) {
        sendGetAndSaveInContext(ROLES, reference, parameters);
    }

    public void sendGetUserGroups(String reference) {
        sendGetAndSaveInContext(USER_GROUPS, reference);
    }

    public void sendGetExternalOrganisation(String reference) {
        sendGetAndSaveInContext(EXTERNAL_ORGANIZATION, reference);
    }

    public void sendGetDepartment(String reference) {
        sendGetAndSaveInContext(DEPARTMENT, reference);
    }

    public void sendGetEntities(String reference) {
        sendGetAndSaveInContext(ENTITIES, reference);
    }

    public void sendPostUserList(String reference, ReferencesRequestDTO request) {
        Response response = restClient.sendPost(specBuilder.getSpecWithTenant(URL), BASE_PATH + USER_LIST, request);
        context.getScenarioContext().setContext(reference, response);
    }

    private void sendGetAndSaveInContext(String endpoint, String reference) {
        Response response = restClient.sendGet(specBuilder.getSpecWithTenant(URL), BASE_PATH + endpoint);
        context.getScenarioContext().setContext(reference, response);
    }

    private void sendGetAndSaveInContext(String endpoint, String reference, Map<String, String> parameters) {
        Response response = restClient.sendGet(specBuilder.getSpecWithTenant(URL), BASE_PATH + endpoint, parameters);
        context.getScenarioContext().setContext(reference, response);
    }

}
