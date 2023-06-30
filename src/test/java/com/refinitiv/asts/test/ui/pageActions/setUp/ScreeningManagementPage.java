package com.refinitiv.asts.test.ui.pageActions.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.ScreeningManagementPO;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import static com.refinitiv.asts.test.ui.constants.Pages.SCREENING_MANAGEMENT_PATH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;

public class ScreeningManagementPage extends BasePage<ScreeningManagementPage> {

    private final ScreeningManagementPO screeningManagementPO;

    public ScreeningManagementPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        screeningManagementPO = new ScreeningManagementPO(driver);
    }

    @Override
    protected ExpectedCondition<ScreeningManagementPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    @Override
    public void load() {

    }

    public void navigateToScreeningManagementPage() {
        driver.get(URL + SCREENING_MANAGEMENT_PATH);
    }

    public boolean screeningSettingsIsTurnedOn(String screeningName) {
        return isElementDisplayed(
                xpath(format(screeningManagementPO.getScreeningSettingsIsTurnedOn(), screeningName)));
    }

    public boolean isToggleButtonPresent(String buttonName) {
        return isElementDisplayed(
                xpath(format(screeningManagementPO.getToggleButton(), buttonName)));
    }

    public boolean isCancelButtonDisabled() {
        return getAttributeValue(screeningManagementPO.getCancelButton(), CLASS).contains(MUI_DISABLED);
    }

    public boolean isSaveButtonDisabled() {
        return getAttributeValue(screeningManagementPO.getSaveButton(), CLASS).contains(MUI_DISABLED);
    }

    public void clickEnableAssociatedParty() {
        clickOn(screeningManagementPO.getEnableScreeningAssociatedPartyToggle());
    }

    public void clickEnableThirdParty() {
        clickOn(screeningManagementPO.getEnableScreeningThirdPartyToggle());
    }

    public void clickEnableOngoingScreening() {
        clickOn(screeningManagementPO.getEnableOngoingScreeningToggle());
    }

    public void clickCancel() {
        clickOn(screeningManagementPO.getCancelButton());
    }

    public void clickSave() {
        clickOn(screeningManagementPO.getSaveButton());
    }

    public String getAlertMessage() {
        return getElementText(waitShort, screeningManagementPO.getScreeningSettingsAlertMessage());
    }

    public String isScreeningManagementUnderDDOrder() {
        return getElementText(waitShort, screeningManagementPO.getScreeningManagementUnderDDOrder());
    }

    public boolean isScreeningManagementHeaderDisplayed() {
        return isElementDisplayed(waitShort, screeningManagementPO.getPageHeader());
    }

}