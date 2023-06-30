package com.refinitiv.asts.test.api.stepDefinitions.selfservice;

import com.fasterxml.jackson.core.type.TypeReference;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.api.actions.SelfServiceApiActions;
import com.refinitiv.asts.test.api.dataproviders.JsonApiDataTransfer;
import com.refinitiv.asts.test.api.dto.selfservice.response.SelfServiceProcessIdStatusResponseDTO;
import com.refinitiv.asts.test.api.dto.selfservice.response.SelfServiceResponseDTO;
import com.refinitiv.asts.test.api.stepDefinitions.ApiBaseSteps;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.io.File;

import static com.refinitiv.asts.test.api.data.SelfServiceFileDataUtil.createNewFileFromTemplate;
import static com.refinitiv.asts.test.api.dataproviders.ApiDataProvider.SELFSERVICE_PROCESSID_RESPONSE;
import static com.refinitiv.asts.test.api.dataproviders.ApiDataProvider.SELFSERVICE_PROCESSID_STATUS_RESPONSE;

public class SelfServiceApiSteps extends ApiBaseSteps {

    private static final SelfServiceApiAssertions selfServiceAssertion = new SelfServiceApiAssertions();
    private final SelfServiceApiActions selfServiceApi;

    public SelfServiceApiSteps(ScenarioCtxtWrapper context) {
        super(context);
        selfServiceApi = new SelfServiceApiActions(context);
    }

    @When("User uploads flat-file {string} {string} by POST request to Self-Service Internal Users Add-Update endpoint")
    public void sendPostRequestForSelfServiceBulkUploadUsersAddUpdate(String fileName, String responseReference) {
        File file = createNewFileFromTemplate(fileName, null, context);
        selfServiceApi.sendPostUploadFlatFile(file, responseReference);
    }

    @When("User uploads flat-file {string} {string} by POST request to Self-Service Internal Users Add-Update endpoint for User {string}")
    public void sendPostRequestForSelfServiceBulkUploadUsersAddUpdate(String fileName, String selfServiceUseCaseRequest,
            String userEmailContextRef) {
        File file = createNewFileFromTemplate(fileName, userEmailContextRef, context);
        selfServiceApi.sendPostUploadFlatFile(file, selfServiceUseCaseRequest);
    }

    @When("User sends {string} from {string} by GET request to Self-Service ProcessId endpoint")
    public void sendGetRequestForSelfServiceProcessId(String responseReference, String previousActualRespRef) {
        this.selfServiceApi.sendGetProcessId(responseReference, previousActualRespRef);
    }

    @Then("Self-Service USERS endpoint {string} response contains expected {string} response schema")
    public void selfServiceAddUsersSuccessResponseContainsExpectedData(String actualRef, String expectedRef) {
        TypeReference<SelfServiceResponseDTO> typeReference = new TypeReference<>() {
        };
        SelfServiceResponseDTO actualResponse = this.selfServiceApi.getBodyFromContext(actualRef, typeReference);
        logger.info("actualResponse.data.processId='" + actualResponse.getData().getProcessId() + "'");
        JsonApiDataTransfer<SelfServiceResponseDTO> serlfserviceProcessIdDataTransfer =
                new JsonApiDataTransfer<>(SELFSERVICE_PROCESSID_RESPONSE);
        SelfServiceResponseDTO expectedResponse =
                serlfserviceProcessIdDataTransfer.getResponseJsonData(expectedRef);
        selfServiceAssertion.verifyMessageAndNonEmptyData(actualResponse, expectedResponse);
    }

    @Then("Self-Service Process Id Status endpoint {string} response contains expected {string} response schema")
    public void selfServiceRetrieveProcessIdStatusResponseContainsExpectedData(String currActualRespRef,
            String currExpectedRespRef) {
        TypeReference<SelfServiceProcessIdStatusResponseDTO> currActualRespTypeReference = new TypeReference<>() {
        };
        SelfServiceProcessIdStatusResponseDTO currActualResponseDTO =
                this.selfServiceApi.getSelfServiceProcessStatusResponseBodyFromContext(
                        currActualRespRef, currActualRespTypeReference);
        JsonApiDataTransfer<SelfServiceProcessIdStatusResponseDTO> serlfserviceProcessIdDataTransfer =
                new JsonApiDataTransfer<>(SELFSERVICE_PROCESSID_STATUS_RESPONSE);
        SelfServiceProcessIdStatusResponseDTO currExpectedResponseDTO =
                serlfserviceProcessIdDataTransfer.getResponseJsonData(currExpectedRespRef);
        selfServiceAssertion.verifyMessageAndNonEmptyData(currActualResponseDTO, currExpectedResponseDTO);
    }

}
