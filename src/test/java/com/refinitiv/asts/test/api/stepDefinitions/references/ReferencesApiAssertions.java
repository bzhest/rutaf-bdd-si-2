package com.refinitiv.asts.test.api.stepDefinitions.references;

import com.refinitiv.asts.test.api.dto.references.response.ReferenceResponseDTO;
import com.refinitiv.asts.test.api.dto.references.response.UserResponseDTO;
import org.assertj.core.api.SoftAssertions;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

public class ReferencesApiAssertions {

    public void verifyMessageAndNonEmptyData(ReferenceResponseDTO<?> actualResponse,
            ReferenceResponseDTO<?> expectedResponse) {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(actualResponse.getMessage())
                .as("References response message is unexpected")
                .isEqualTo(expectedResponse.getMessage());
        softAssert.assertThat(actualResponse.getData())
                .as("References response doesn't contain data items")
                .isNotEmpty();
        softAssert.assertAll();
    }

    public void verifyResponseMetaIgnoreNull(ReferenceResponseDTO<?> actualResponse,
            ReferenceResponseDTO<?> expectedResponse) {
        assertThat(actualResponse.getMeta()).usingRecursiveComparison().ignoringExpectedNullFields()
                .as("References response meta is unexpected")
                .isEqualTo(expectedResponse.getMeta());
    }

    public void verifyResponseIsEquals(ReferenceResponseDTO<?> actualResponse,
            ReferenceResponseDTO<?> expectedResponse) {
        assertThat(actualResponse).as("References response is unexpected")
                .isEqualTo(expectedResponse);
    }

    public void verifyUserListResponseFiltered(List<UserResponseDTO> actualResponse, UserResponseDTO expectedResponse) {
        SoftAssertions softAssertions = new SoftAssertions();
        actualResponse.forEach(user -> softAssertions.assertThat(user)
                .usingRecursiveComparison().ignoringExpectedNullFields()
                .as("User List response is not filtered")
                .isEqualTo(expectedResponse));
        softAssertions.assertAll();
    }

    public void verifyUserListResponseFiltered(List<UserResponseDTO> actualResponse,
            UserResponseDTO.DivisionsItem expectedResponse) {
        SoftAssertions softAssertions = new SoftAssertions();
        actualResponse.forEach(user -> softAssertions.assertThat(user.getDivisions())
                .as("User List response is not filtered by Division")
                .contains(expectedResponse));
        softAssertions.assertAll();
    }

}
