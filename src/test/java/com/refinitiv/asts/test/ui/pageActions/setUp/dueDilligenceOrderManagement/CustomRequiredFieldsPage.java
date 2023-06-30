package com.refinitiv.asts.test.ui.pageActions.setUp.dueDilligenceOrderManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.dueDilligenceOrder.CustomRequiredFieldsPO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;

import static com.refinitiv.asts.test.ui.constants.Pages.CUSTOM_REQUIRED_FIELDS_PATH;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;

public class CustomRequiredFieldsPage extends BasePage<CustomRequiredFieldsPage> {

    private final CustomRequiredFieldsPO customRequiredFieldsPO;

    public CustomRequiredFieldsPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        customRequiredFieldsPO = new CustomRequiredFieldsPO(driver);
    }

    public void navigateToCustomRequiredFieldsPage() {
        driver.get(URL + CUSTOM_REQUIRED_FIELDS_PATH);
        waitShort.until(ExpectedConditions.visibilityOfElementLocated(customRequiredFieldsPO.getFieldNameColumn()));
    }

    public void tickCustomRequiredFieldCheckbox(String fieldName) {
        By elementToTick = xpath(format(customRequiredFieldsPO.getRequiredCheckbox(), fieldName));
        scrollIntoView(elementToTick);
        clickOn(elementToTick);
    }

    public boolean isRequiredCheckboxChecked(String fieldName) {
        return isCheckboxChecked(customRequiredFieldsPO.getRequiredCheckbox(), fieldName);
    }

    public void clickSaveButton() {
        clickOn(customRequiredFieldsPO.getSaveCustomFieldsButton());
    }

    @Override
    protected ExpectedCondition<CustomRequiredFieldsPage> getPageLoadCondition() {
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

}
