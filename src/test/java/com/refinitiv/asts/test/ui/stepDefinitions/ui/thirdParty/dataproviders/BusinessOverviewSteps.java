package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.dataproviders;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.dataproviders.BusinessOverviewPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import io.cucumber.java.en.Then;

import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertEquals;
import static org.testng.AssertJUnit.assertTrue;

public class BusinessOverviewSteps extends BaseSteps {
    BusinessOverviewPage businessOverviewPage;

    public BusinessOverviewSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.businessOverviewPage = new BusinessOverviewPage(this.driver);
    }

    @Then("Business Overview Tab is displayed")
    public void isBusinessOverviewTabDisplayed() {
        assertTrue("Business Overview tab is NOT displayed", businessOverviewPage.isBusinessOverviewTabDisplayed());
    }

    @Then("Business Overview Run Button is displayed")
    public void isBusinessOverviewRunButtonDisplayed() {
        assertTrue("Business Overview Run Button is NOT displayed", businessOverviewPage.isBusinessOverviewRunButtonDisplayed());
    }

    @Then("Business Overview Search Date value is {string}")
    public void isBusinessOverviewTabDisplayed(String searchDate) {
        assertEquals("Business Overview search date is incorrect", businessOverviewPage.getSearchDateValue(), searchDate);
    }

    @Then("Business Overview Run Button is enabled")
    public void businessOverviewRunButtonIsEnabled() {
        assertTrue("Business Over Run button is NOT enabled",
                businessOverviewPage.isBusinessOverviewRunButtonEnabled());
    }

    @Then("Business Overview {string} message is displayed")
    public void isBusinessOverviewMessageDisplayed(String message) {
        assertThat(businessOverviewPage.isBusinessOverviewMessageDisplayed(message))
                .as("Business Overview '%s' message is not displayed", message).isTrue();
    }

}
