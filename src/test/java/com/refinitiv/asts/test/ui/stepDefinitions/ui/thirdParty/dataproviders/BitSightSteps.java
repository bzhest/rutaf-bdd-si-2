package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.dataproviders;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.dataproviders.BitSightPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import static org.testng.AssertJUnit.assertEquals;
import static org.testng.AssertJUnit.assertTrue;

public class BitSightSteps extends BaseSteps {
    BitSightPage bitSightPage;

    public BitSightSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.bitSightPage = new BitSightPage(this.driver);
    }

    @When("User clicks BitSight tab")
    public void userClicksBitSightTab() {
        bitSightPage.clickBitSightTab();
    }

    @Then("BitSight Tab is displayed")
    public void isBitSightTabDisplayed() {
        assertTrue("BitSight tab is NOT displayed", bitSightPage.isBitSightTabDisplayed());
    }

    @Then("BitSight Run Button is displayed")
    public void isBitSightRunButtonDisplayed() {
        assertTrue("BitSight Run Button is NOT displayed", bitSightPage.isBitSightRunButtonDisplayed());
    }

    @Then("BitSight Search Date value is {string}")
    public void isBitSightTabDisplayed(String searchDate) {
        assertEquals("BitSight search date is incorrect", bitSightPage.getSearchDateValue(), searchDate);
    }

    @Then("BitSight Status value is {string}")
    public void isBitSightStatusDisplayed(String status) {
        assertEquals("BitSight status is incorrect", bitSightPage.getStatusValue(), status);
    }

    @Then("BitSight Run Button is enabled")
    public void bitSightRunButtonIsEnabled() {
        assertTrue("BitSight Run button is NOT enabled",
                bitSightPage.isBitSightRunButtonEnabled());
    }
}