package com.refinitiv.asts.test.ui.stepDefinitions.ui;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.ErrorPage;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import static org.assertj.core.api.Assertions.assertThat;

public class ErrorSteps extends BaseSteps {

    private final ErrorPage errorPage;

    public ErrorSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.errorPage = new ErrorPage(this.driver);
    }

    @When("User navigates to error page")
    public void navigateToErrorPage() {
        errorPage.navigateToErrorPage();
    }

    @When("User clicks Error page link")
    public void clickErrorPageLink() {
        errorPage.clickErrorPageLink();
    }

    @Then("Error page is displayed")
    public void errorPageIsDisplayed() {
        assertThat(errorPage.isPageLoaded())
                .as("Error page is not displayed")
                .isTrue();
    }

    @Then("Error page link is displayed")
    public void errorPageLinkIsDisplayed() {
        assertThat(errorPage.isErrorPageLinkDisplayed())
                .as("Error page link is not displayed")
                .isTrue();
    }

    @Then("Error page message {string} is displayed")
    public void errorPageMessageIsDisplayed(String expectedText) {
        assertThat(errorPage.getErrorPageMessage())
                .as("Error page message is unexpected")
                .isEqualTo(expectedText);
    }

}
