package com.refinitiv.asts.test.ui.pageActions.setUp.fieldsManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.SIPublicApi;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.ThirdPartyFieldsPO;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_MANAGEMENT_FIELDS;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;

public class ThirdPartyFieldsPage extends BasePage<ThirdPartyFieldsPage> {

    private final ThirdPartyFieldsPO thirdPartyFieldsPO;
    public static final String COUNTRY = "Country";

    public ThirdPartyFieldsPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        thirdPartyFieldsPO = new ThirdPartyFieldsPO(driver);
    }

    @Override
    protected ExpectedCondition<ThirdPartyFieldsPage> getPageLoadCondition() {
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

    public void clickThirdPartyFieldsMenuOption() {
        clickOn(thirdPartyFieldsPO.getThirdPartyFieldsSetUpMenuOption(), waitShort);
    }

    public boolean isThirdPartyFieldsHeaderDisplayed() {
        return isElementDisplayed(thirdPartyFieldsPO.getThirdPartyFieldsHeader());
    }

    public boolean isSaveButtonDisplayed() {
        return isElementDisplayed(thirdPartyFieldsPO.getSaveButton());
    }

    public boolean isResetButtonDisplayed() {
        return isElementDisplayed(thirdPartyFieldsPO.getResetButton());
    }

    public boolean isDismissButtonDisplayed() {
        return isElementDisplayed(thirdPartyFieldsPO.getDismissInformationMessageButton());
    }

    public String getInformationMessageText() {
        return getElementText(thirdPartyFieldsPO.getInformationMessage());
    }

    public boolean isInformationMessageDisplayed() {
        return isElementDisplayed(thirdPartyFieldsPO.getInformationMessage());
    }

    public List<String> getTableRowsNames(String tableName) {
        return getElementsText(xpath(format(thirdPartyFieldsPO.getTableRowName(), tableName)));
    }

    public boolean isRequiredCheckboxDisabledAndChecked(String tableName, String rowName) {
        return isReactCheckboxChecked
                (xpath(format(thirdPartyFieldsPO.getCheckboxRequiredColumn(), tableName, rowName)))
                && !isReactFieldEnabled
                (xpath(format(thirdPartyFieldsPO.getCheckboxRequiredColumn(), tableName, rowName)));
    }

    public boolean isActiveCheckboxDisabledAndChecked(String tableName, String rowName) {
        return isReactCheckboxChecked
                (xpath(format(thirdPartyFieldsPO.getCheckboxActiveColumn(), tableName, rowName)))
                && !isReactFieldEnabled
                (xpath(format(thirdPartyFieldsPO.getCheckboxActiveColumn(), tableName, rowName)));
    }

    public boolean isRequiredCheckboxChecked(String tableName, String fieldName) {
        waitUntilPageReady();
        return isReactCheckboxChecked
                (xpath(format(thirdPartyFieldsPO.getCheckboxRequiredColumn(), tableName, fieldName)));
    }

    public boolean isActiveCheckboxChecked(String tableName, String fieldName) {
        waitUntilPageReady();
        return isReactCheckboxChecked
                (xpath(format(thirdPartyFieldsPO.getCheckboxActiveColumn(), tableName, fieldName)));
    }

    public void clickDismissInformationMessageButton() {
        clickOn(thirdPartyFieldsPO.getDismissInformationMessageButton());
    }

    public void setDefaultThirdPartyFieldsManagementValues() {
        if (!context.getScenarioContext().isContains(THIRD_PARTY_MANAGEMENT_FIELDS)) {
            SIPublicApi.setThirdPartyFieldsManagementToDefault();
        }
    }

    public void clickCheckboxActiveColumn(String tableName, String fieldName) {
        clickOn(xpath(format(thirdPartyFieldsPO.getCheckboxActiveColumn(), tableName, fieldName)));
    }

    public void clickCheckboxRequiredColumn(String tableName, String fieldName) {
        clickOn(xpath(format(thirdPartyFieldsPO.getCheckboxRequiredColumn(), tableName, fieldName)));
    }

    public void clickSaveButton() {
        clickOn(thirdPartyFieldsPO.getSaveButton());
    }

    public String getToastMessageText() {
        return getElementText(thirdPartyFieldsPO.getToastMessage());
    }

}
