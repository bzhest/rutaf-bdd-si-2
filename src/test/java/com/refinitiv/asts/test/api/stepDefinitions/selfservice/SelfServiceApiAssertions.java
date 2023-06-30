package com.refinitiv.asts.test.api.stepDefinitions.selfservice;

import com.refinitiv.asts.test.api.dto.selfservice.response.SelfServiceProcessIdStatusResponseDTO;
import com.refinitiv.asts.test.api.dto.selfservice.response.SelfServiceResponseDTO;
import org.assertj.core.api.SoftAssertions;

import java.util.Objects;

public class SelfServiceApiAssertions {

    public void verifyMessageAndNonEmptyData(SelfServiceResponseDTO actualResponse,
            SelfServiceResponseDTO expectedResponse) {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(actualResponse.getMessage())
                .as("References response message is unexpected")
                .isEqualTo(expectedResponse.getMessage());
        softAssert.assertThat(actualResponse.getData())
                .as("References response doesn't contain data items")
                .isNotNull();
        softAssert.assertAll();
    }

    public void verifyMessageAndNonEmptyData(SelfServiceProcessIdStatusResponseDTO actualResponse,
            SelfServiceProcessIdStatusResponseDTO expectedResponse) {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(actualResponse.getMessage())
                .as("Self-Service Process Id Status response 'message' is unexpected")
                .isEqualTo(expectedResponse.getMessage());
        softAssert.assertThat(actualResponse.getData())
                .as("Self-Service Process Id Status response 'data' doesn't contain any items")
                .isNotNull();
        softAssert.assertThat(actualResponse.getData().getStatus())
                .as("Self-Service Process Id Status response 'data.status' is not '%s'",
                    expectedResponse.getData().getStatus())
                .isEqualTo(expectedResponse.getData().getStatus());
        if (Objects.isNull(expectedResponse.getData().getSuccessResponseFile())) {
            softAssert.assertThat(actualResponse.getData().getSuccessResponseFile())
                    .as("Self-Service Process Id Status response 'data.successResponseFile' is not null")
                    .isNull();
        } else {
            softAssert.assertThat(actualResponse.getData().getSuccessResponseFile())
                    .as("Self-Service Process Id Status response 'data.successResponseFile' is null")
                    .isNotNull();
        }
        if (Objects.isNull(expectedResponse.getData().getErrorResponseFile())) {
            softAssert.assertThat(actualResponse.getData().getErrorResponseFile())
                    .as("Self-Service Process Id Status response 'data.errorResponseFile' is not null")
                    .isNull();
        } else {
            softAssert.assertThat(actualResponse.getData().getErrorResponseFile())
                    .as("Self-Service Process Id Status response 'data.errorResponseFile' is null")
                    .isNotNull();
        }
        softAssert.assertThat(actualResponse.getData().getRecordProcessed())
                .as("Self-Service Process Id Status response 'data.getRecordProcessed' is not equal to '%s'",
                    expectedResponse.getData().getRecordProcessed())
                .isEqualTo(expectedResponse.getData().getRecordProcessed());
        softAssert.assertThat(actualResponse.getData().getRecordWithErrors())
                .as("Self-Service Process Id Status response 'data.recordWithErrors' is not equal to '" +
                            expectedResponse.getData().getRecordWithErrors() + "'")
                .isEqualTo(expectedResponse.getData().getRecordWithErrors());
        softAssert.assertThat(actualResponse.getData().getProcessType())
                .as("Self-Service Process Id Status response 'data.processType' is not 'USER'")
                .isEqualTo(expectedResponse.getData().getProcessType());
        softAssert.assertAll();
    }

}
