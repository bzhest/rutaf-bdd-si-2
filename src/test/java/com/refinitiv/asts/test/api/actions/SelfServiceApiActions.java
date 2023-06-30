package com.refinitiv.asts.test.api.actions;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.google.gson.JsonSyntaxException;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.api.client.FileUploadClient;
import com.refinitiv.asts.test.api.dto.selfservice.response.SelfServiceProcessIdStatusResponseDTO;
import com.refinitiv.asts.test.api.dto.selfservice.response.SelfServiceResponseDTO;
import io.restassured.response.Response;
import lombok.SneakyThrows;
import org.awaitility.Awaitility;

import java.io.*;
import java.util.concurrent.TimeUnit;

import static com.refinitiv.asts.test.api.constants.ApiRequestConstants.*;
import static com.refinitiv.asts.test.utils.FileUtil.*;

public class SelfServiceApiActions extends BaseApiActions<SelfServiceResponseDTO> {

    private static final String BASE_PATH = "/selfservice";
    private static final String SELFSERVICE_PROCESSID_ENDPOINT = "/";

    public SelfServiceApiActions(ScenarioCtxtWrapper context) {
        super(context);
    }

    @Override
    public SelfServiceResponseDTO getBodyFromContext(String reference,
            TypeReference<SelfServiceResponseDTO> typeReference) {
        return getResponseAsObjectFromContext(reference, typeReference);
    }

    @SneakyThrows
    public <T> T getSelfServiceProcessStatusResponseBodyFromContext(String responseReference,
            TypeReference<T> typeReference) {
        Response response = (Response) context.getScenarioContext().getContext(responseReference);
        try {
            return objectMapper.readValue(response.getBody().asString(), typeReference);
        } catch (JsonSyntaxException | JsonMappingException e) {
            throw new RuntimeException("Unexpected API response body: " + response.getBody().prettyPrint());
        }
    }

    public void sendPostUploadFlatFile(File file, String responseReference) {
        sendPostAndSaveInContext(file, responseReference);
    }

    private void sendPostAndSaveInContext(File file, String responseReference) {
        Response response =
                FileUploadClient.postFileSelfService(specBuilder.getSpecWithTenant(DX1_URL), BASE_PATH, file,
                                                     PROCESSTYPE_USER);
        context.getScenarioContext().setContext(responseReference, response);
        deleteFile(getFilePath(file.getName()));
    }

    public void sendGetProcessId(String responseReference, String previousActualRespRef) {
        sendGetAndSaveInContext(responseReference, previousActualRespRef);
    }

    /**
     * @param previousActualRespRef Invoke GET process id status until status is turns from "IN_PROGRESS"
     *                              to "COMPLETE". Note that this is repeated for maximum loop count of 40x.
     */
    private void sendGetAndSaveInContext(String responseReference, String previousActualRespRef) {
        logger.info(
                "endpoint='" + SELFSERVICE_PROCESSID_ENDPOINT + "' | DX1_URL='" + DX1_URL +
                        "' | BASE_PATH='" + BASE_PATH +
                        "'");
        TypeReference<SelfServiceResponseDTO> prevRespTypeReference = new TypeReference<>() {
        };
        SelfServiceResponseDTO previousActualResponseDTO =
                getBodyFromContext(previousActualRespRef, prevRespTypeReference);
        String processId = previousActualResponseDTO.getData().getProcessId();
        logger.info("selfServiceResponseDTO.data.processId = '" + processId + "'");
        String reqStatus;
        int loopIdx = 0;

        do {
            Response response = restClient.sendGet(specBuilder.getSpecWithTenant(DX1_URL),
                                                   BASE_PATH + SelfServiceApiActions.SELFSERVICE_PROCESSID_ENDPOINT +
                                                           processId);
            logger.debug("responseBody='" + response.getBody().prettyPrint() + "'");
            context.getScenarioContext().setContext(responseReference, response);
            TypeReference<SelfServiceProcessIdStatusResponseDTO> currProcIdStatusTypeReference = new TypeReference<>() {
            };
            SelfServiceProcessIdStatusResponseDTO currProcIdStatusActualResponseDTO =
                    getSelfServiceProcessStatusResponseBodyFromContext(
                            responseReference, currProcIdStatusTypeReference);
            reqStatus = currProcIdStatusActualResponseDTO.getData().getStatus();
            logger.info("selfServiceProcessIdStatusResponseDTO.data.status = '" + reqStatus + "'");

            loopIdx++;
            Awaitility.await()
                    .atMost(3, TimeUnit.SECONDS)
                    .until(() -> true);
        }
        while (!reqStatus.equals("COMPLETED") && loopIdx < 40);
    }

}