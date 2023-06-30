package com.refinitiv.asts.test.ui.pageObjects.setUp;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class ValueManagementPO extends BasePO {

    public ValueManagementPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final By addNewButton = cssSelector("[id*=add-new]");
    private final By addModal = xpath("//h2[contains(text(), 'Add')]");
    private final By riskScoringRangeName = cssSelector("[name='name']");
    private final By from = cssSelector("[name='min']");
    private final By to = cssSelector("[name='max']");
    private final By cancelCurrencyButton = id("simple-value-cancel");
    private final String riskScoringRangeNameInGrid = "//span[contains(text(), '%s')]";
    private final String valueManagementItem = "//span[text()='%s']";
    private final By values = xpath("//ul/li");
    private final By columns = xpath("//thead//th");
    private final String value = "//li[text()='%s']";
    private final String valueManagementBreadcrumb =
            "//li[contains(@class, 'MuiBreadcrumbs')]//h6[text()='%s']|//li[contains(@class, 'MuiBreadcrumbs')]//h6[text()='%s']/ancestor::ol/li";
    private final By valueManagementView = xpath("//h6[text()='Value Management']");
    private final String columnName = "//th//*[contains(., '%s')]";
    private final String valueManagementRows = "//tbody/tr";
    private final By rowNames = xpath(valueManagementRows + "/td[1]");
    private final String tableRowValue = "td[%s]";
    private final String rowWithName = "//*[text()=\"%s\"]/ancestor::tr";
    private final String editRowButtons = "//*[contains(@aria-label, 'edit') or contains(@class, 'Svg')]";
    private final String deleteRowButtons = "//*[contains(@aria-label, 'delete')]";
    private final String editRowButton = rowWithName + editRowButtons;
    private final String deleteRowButton = rowWithName + deleteRowButtons;
    private final String valueNameInput =
            "//*[@role='dialog']//textarea[not(@aria-hidden='true')] | //*[@role='dialog']//input";
    private final By valueNameErrorMessage = xpath(valueNameInput + "/../following-sibling::p");
    private final String buttonWithText = "//span[contains(., '%s')]/ancestor::button";
    private final By modalNotice = xpath("//*[@role='dialog']//p");
    private final String requiredFieldSymbol = "//span[text()='%s']/../following-sibling::span[text()='*']";
    private final By fieldValidationMessage = xpath("//p[contains(@class, 'MuiFormHelperText')]");
    private final By addModalIconButton = id("value-management-add-assessment");
    private final String assessmentInput = "(//*[@aria-label='Activity Type Assessment']/input)[%s]";
    private final String assessmentInputClose =
            assessmentInput + "/following-sibling::*[@aria-label='Delete Assessment']";
    private final By activeCheckbox = xpath("//input/ancestor::*[@aria-label='Active']");
    private final By emptyTableMessage = xpath("//*[contains(@class, 'MuiTableContainer')]//h6");
    private final By valueManagementTab = xpath("//p[text()='Value Management']");
    private final By riskModelDropDown = xpath("//*[@data-testid='risk scoring range-set-up-filter-select']");
    protected final By dropDownOptions = cssSelector("li[role=option]");
    private final String dropDownValuesList = " //ul[@role='listbox']/li[contains(text(), '%s')]";
    private final By applyRiskModelButton = id("SetUp-MainPage-Footer-ApplyButton");
    private final By riskModelCancelButton = id("SetUp-MainPage-Footer-CancelButton");
    private final By riskScoringColorButton = cssSelector("[id^=RiskScoring] button");
    private final By riskScoringColorMedium = cssSelector(".sketch-picker [title=Medium]");
    protected final By availableCountriesOptions = xpath("//*[text()='Available Countries']/..//li");
    protected final By selectedCountriesOptions = xpath("//*[text()='Selected Countries']/..//li");

}
