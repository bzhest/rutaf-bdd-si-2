package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.screeningManagement.ScreeningManagementRequestDTO;
import com.refinitiv.asts.test.ui.pageActions.setUp.ScreeningManagementPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.Assertions;

import java.util.List;

import static com.refinitiv.asts.test.ui.api.SIPublicApi.patchScreeningManagement;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.OFF;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.ON;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.DISABLED;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.*;

public class ScreeningManagementSteps extends BaseSteps {

    private final ScreeningManagementPage screeningManagementPage;

    public ScreeningManagementSteps(ScenarioCtxtWrapper context) {
        super(context);
        screeningManagementPage = new ScreeningManagementPage(driver, context);
    }

    @When("User navigates 'Set Up' block 'Screening Management' section")
    public void openSetupBlockUserSection() {
        screeningManagementPage.navigateToScreeningManagementPage();
    }

    @When("User clicks on Enable screening when adding new associated party toggle")
    public void clickEnableAssociatedParty() {
        screeningManagementPage.clickEnableAssociatedParty();
    }

    @When("User clicks on Enable screening when adding new third-party toggle")
    public void clickEnableThirdParty() {
        screeningManagementPage.clickEnableThirdParty();
    }

    @When("User clicks on Enable World-Check and Custom Watchlist Ongoing Screening toggle")
    public void clickEnableOngoingScreening() {
        screeningManagementPage.clickEnableOngoingScreening();
    }

    @When("User clicks cancel button")
    public void clickCancel() {
        screeningManagementPage.clickCancel();
    }

    @When("User clicks save button")
    public void clickSave() {
        screeningManagementPage.clickSave();
    }

    @When("User sets up default Screening Management parameters via API")
    public void turnOnAllScreeningManagementParametersViaAPI() {
        ScreeningManagementRequestDTO requestDTO = new ScreeningManagementRequestDTO()
                .setDefaultEnableScreeningNewAssociatedParty(false)
                .setDefaultEnableScreeningNewThirdParty(true)
                .setDefaultEnableWC1AndCustomWatchlistOGS(false);
        patchScreeningManagement(requestDTO);
    }

    @Then("^Screening Settings \"((.*))\" is turned \"(On|Off)\"$")
    public void screeningSettingsIsTurned(String screeningName, String expectedState) {
        boolean isScreeningSettingIsTurnedOn = screeningManagementPage.screeningSettingsIsTurnedOn(screeningName);
        switch (expectedState) {
            case ON:
                assertTrue(screeningName + "is turned OFF", isScreeningSettingIsTurnedOn);
                break;
            case OFF:
                assertFalse(screeningName + "is turned ON", isScreeningSettingIsTurnedOn);
                break;
            default:
                throw new IllegalArgumentException("State: " + expectedState + " is incorrect");
        }
    }

    @Then("Screening Management toggle buttons are present")
    public void screeningManagementButtonArePresent(List<String> buttonsNames) {
        buttonsNames.forEach(name -> Assertions.assertThat(screeningManagementPage.isToggleButtonPresent(name))
                .as("%s toggle button is not present", name)
                .isTrue());
    }

    @Then("^Cancel button is \"(enabled|disabled)\"$")
    public void cancelButtonState(String expectedState) {
        boolean isCancelButtonDisabled = screeningManagementPage.isCancelButtonDisabled();
        switch (expectedState) {
            case ENABLED:
                assertFalse("Cancel button is not " + ENABLED, isCancelButtonDisabled);
                break;
            case DISABLED:
                assertTrue("Cancel button is not " + DISABLED, isCancelButtonDisabled);
                break;
            default:
                throw new IllegalArgumentException("State: " + expectedState + " is incorrect");
        }
    }

    @Then("^Save button is \"(enabled|disabled)\"$")
    public void saveButtonState(String expectedState) {
        boolean isSaveButtonDisabled = screeningManagementPage.isSaveButtonDisabled();
        switch (expectedState) {
            case ENABLED:
                assertFalse("Save button is not " + ENABLED, isSaveButtonDisabled);
                break;
            case DISABLED:
                assertTrue("Save button is not " + DISABLED, isSaveButtonDisabled);
                break;
            default:
                throw new IllegalArgumentException("State: " + expectedState + " is incorrect");
        }
    }

    @Then("Alert message {string} is displayed")
    public void isAlertMessageDisplayed(String expectedText) {
        assertEquals("Alert message is not displayed", expectedText,
                     screeningManagementPage.getAlertMessage());
    }

    @Then("{string} position is under Due Diligence Order Management")
    public void isScreeningManagementPositionBefore(String settingName) {
        screeningManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertEquals(settingName + "position is not under Due Diligence Order Management ", settingName,
                     screeningManagementPage.isScreeningManagementUnderDDOrder());
    }

    @Then("Screening Management page is displayed")
    public void isScreeningManagementHeaderDisplayed() {
        assertThat(screeningManagementPage.isScreeningManagementHeaderDisplayed())
                .as("Screening Management header is not displayed")
                .isTrue();
    }

}
