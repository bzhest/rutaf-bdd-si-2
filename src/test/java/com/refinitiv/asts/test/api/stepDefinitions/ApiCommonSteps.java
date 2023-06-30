package com.refinitiv.asts.test.api.stepDefinitions;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import io.cucumber.java.en.Then;
import io.restassured.response.Response;

import static org.assertj.core.api.Assertions.assertThat;

public class ApiCommonSteps extends ApiBaseSteps {

    public ApiCommonSteps(ScenarioCtxtWrapper context) {
        super(context);
    }

    @Then("Response {string} status code is {int}")
    public void validateStatusCode(String responseReference, int expectedStatusCode) {
        Response actualResponse = (Response) context.getScenarioContext().getContext(responseReference);
        assertThat(actualResponse.getStatusCode())
                .as("Response status code is unexpected")
                .isEqualTo(expectedStatusCode);
    }

}
