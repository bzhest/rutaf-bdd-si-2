package com.refinitiv.asts.test.ui.pageActions.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.ConfirmationWindowPage;
import com.refinitiv.asts.test.ui.pageActions.PaginationPage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.ValueManagementPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.ValueData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.Pages.VALUE_MANAGEMENT_ACTIVITY_TYPE;
import static com.refinitiv.asts.test.ui.constants.Pages.VALUE_MANAGEMENT_PATH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static io.netty.karate.util.internal.StringUtil.SPACE;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.LF;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class ValueManagementPage extends BasePage<ValueManagementPage> {

    private final ValueManagementPO valueManagementPO;
    private final PaginationPage paginationPage;
    private final ConfirmationWindowPage confirmationWindowPage;
    public static final String VALUE = "Value";
    public static final String NAME = "Name";
    public static final String SCORING_RANGE = "Scoring Range";
    public static final String DATE_CREATED = "Date Created";
    public static final String LAST_UPDATED = "Last Updated";
    public static final String RISK_SCORING_RANGE_NAME = "Risk Scoring Range Name";
    public static final String ACTIVITY_TYPE_NAME = "Activity Type Name";
    public static final String ADD_ONS_NAME = "Add-On Name";
    public static final String FROM = "From";
    public static final String TO = "To";

    public ValueManagementPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        valueManagementPO = new ValueManagementPO(driver, translator);
        paginationPage = new PaginationPage(driver, context);
        confirmationWindowPage = new ConfirmationWindowPage(driver);
    }

    @Override
    protected ExpectedCondition<ValueManagementPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(valueManagementPO.getValueManagementView());
    }

    public boolean isValueOverviewPageDisplayed(String valuePage) {
        return isElementDisplayed(waitShort, xpath(format(valueManagementPO.getValueManagementBreadcrumb(), valuePage,
                                                          valuePage.toLowerCase())));
    }

    public String getBreadcrumbText() {
        return getElementText(valueManagementPO.getBreadcrumbs()).replace(LF, StringUtils.SPACE);
    }

    public boolean isCancelButtonDisplayed() {
        return isElementDisplayed(valueManagementPO.getCancelCurrencyButton());
    }

    public boolean isCancelButtonActive() {
        return isElementEnabled(valueManagementPO.getCancelCurrencyButton());
    }

    public boolean isAddModalDisplayed() {
        return isElementDisplayed(waitMoment, valueManagementPO.getAddModal());
    }

    public boolean isRiskScoringRangeDisplayed(String name) {
        return isElementDisplayed(waitShort, xpath(format(valueManagementPO.getValueManagementItem(), name)));
    }

    public boolean isValueActive(String currencyName) {
        return isElementAttributeContains(xpath(format(valueManagementPO.getValue(), currencyName)), CLASS,
                                          SPACE + ACTIVE);
    }

    public boolean isEditButtonDisplayedForEachRow() {
        return driver.findElements(xpath(valueManagementPO.getValueManagementRows())).stream()
                .allMatch(row -> isElementDisplayed(row.findElement(xpath(valueManagementPO.getEditRowButtons()))));
    }

    public boolean isDeleteButtonDisplayedForEachRow() {
        return driver.findElements((xpath(valueManagementPO.getValueManagementRows()))).stream()
                .allMatch(row -> isElementDisplayed(row.findElement(xpath(valueManagementPO.getDeleteRowButtons()))));
    }

    public boolean isEditButtonDisplayedForRow(String value) {
        return isElementDisplayed(xpath(format(valueManagementPO.getEditRowButton(), value)));
    }

    public boolean isDeleteButtonDisplayedForRow(String value) {
        return isElementDisplayed(xpath(format(valueManagementPO.getDeleteRowButton(), value)));
    }

    public boolean isValueManagementButtonDisabled(String buttonName) {
        return isElementAttributeContains(waitShort, xpath(format(valueManagementPO.getButtonWithText(), buttonName)),
                                          CLASS, DISABLED);
    }

    public boolean isValueManagementButtonDisplayed(String buttonName) {
        return isElementDisplayed(xpath(format(valueManagementPO.getButtonWithText(), buttonName)));
    }

    public List<String> getAvailableCountriesOptions() {
        return getElementsText(valueManagementPO.getAvailableCountriesOptions());
    }

    public List<String> getSelectedCountriesOptions() {
        return getElementsText(valueManagementPO.getSelectedCountriesOptions());
    }

    public boolean isValueNameInputDisplayed() {
        return isElementDisplayed(waitShort, xpath(valueManagementPO.getValueNameInput()));
    }

    public boolean isRiskScoringNameInputDisplayed() {
        return isElementDisplayed(valueManagementPO.getRiskScoringRangeName());
    }

    public boolean isRiskScoringFromDisplayed() {
        return isElementDisplayed(valueManagementPO.getFrom());
    }

    public boolean isRiskScoringToDisplayed() {
        return isElementDisplayed(valueManagementPO.getTo());
    }

    public boolean isRequiredFieldSymbolDisplayed(String fieldName) {
        return isElementDisplayed(xpath(format(valueManagementPO.getRequiredFieldSymbol(), fieldName)));
    }

    public boolean isActiveCheckboxDisplayed() {
        return isElementDisplayed(valueManagementPO.getActiveCheckbox());
    }

    public boolean isAddIconDisplayed() {
        return isElementDisplayed(valueManagementPO.getAddModalIconButton());
    }

    public boolean isAddIconDisabled() {
        return isElementAttributeContains(waitMoment, valueManagementPO.getAddModalIconButton(), CLASS, DISABLED);
    }

    public boolean isAssessmentCloseIconDisplayed(int fieldIndex) {
        return isElementDisplayed(xpath(format(valueManagementPO.getAssessmentInputClose(), fieldIndex)));
    }

    public boolean isAssessmentFieldDisplayed() {
        return isElementDisplayed(waitMoment, xpath(format(valueManagementPO.getAssessmentInput(), 1)));
    }

    public boolean isEmptyTableMessageDisplayed() {
        return isElementDisplayed(valueManagementPO.getEmptyTableMessage());
    }

    @Override
    public void load() {

    }

    public void clickItem(String fieldName) {
        clickOn(xpath(format(valueManagementPO.getValueManagementItem(), fieldName)), waitLong);
    }

    public void navigateToValueManagement() {
        this.driver.get(URL + VALUE_MANAGEMENT_PATH);
    }

    public void navigateToValueManagementActivityType(String activityTypeId) {
        this.driver.get(URL + format(VALUE_MANAGEMENT_ACTIVITY_TYPE, activityTypeId));
    }

    public void clickAddNewButton() {
        clickOn(valueManagementPO.getAddNewButton(), waitShort);
    }

    public void clickAddIconButton() {
        clickOn(valueManagementPO.getAddModalIconButton(), waitShort);
    }

    public void setRiskScoringRange(String from, String to) {
        clearAndInputField(valueManagementPO.getFrom(), from);
        clearAndInputField(valueManagementPO.getTo(), to);
    }

    public void clickCancelButton() {
        clickOn(valueManagementPO.getCancelCurrencyButton());
    }

    public void clickColumnName(String columnName) {
        clickOn(xpath(format(valueManagementPO.getColumnName(), columnName)));
    }

    public void fillInValueName(String name) {
        driver.findElement(xpath(valueManagementPO.getValueNameInput())).sendKeys(name);
    }

    public void clearAndFillInValueName(String name) {
        clearInputAndEnterField(xpath(valueManagementPO.getValueNameInput()), name);
    }

    public void clearValueName() {
        clearText(xpath(valueManagementPO.getValueNameInput()));
    }

    public void clickButton(String buttonName) {
        clickOn(xpath(format(valueManagementPO.getButtonWithText(), buttonName)));
    }

    public void clickEditButtonForRow(String valueName) {
        clickOn(waitShort.until(
                visibilityOfElementLocated(xpath(format(valueManagementPO.getEditRowButton(), valueName)))));
    }

    public void clickDeleteButtonForRow(String valueName) {
        clickOn(waitShort.until(
                visibilityOfElementLocated(xpath(format(valueManagementPO.getDeleteRowButton(), valueName)))));
    }

    public void fillInAssessment(int fieldIndex, String value) {
        clearAndInputField(xpath(format(valueManagementPO.getAssessmentInput(), fieldIndex)), value);
    }

    public void clickCloseAssessmentField(int fieldIndex) {
        clickOn(xpath(format(valueManagementPO.getAssessmentInputClose(), fieldIndex)));
    }

    public void clickActiveCheckbox() {
        clickOn(valueManagementPO.getActiveCheckbox());
    }

    public void clickBreadcrumb(String valuePage) {
        clickOn(xpath(format(valueManagementPO.getValueManagementBreadcrumb(), valuePage, valuePage.toLowerCase())));
    }

    public void deleteAllValuesInTable() {
        while (getElements(xpath(valueManagementPO.getDeleteRowButtons())).size() > 0) {
            clickOn(xpath(valueManagementPO.getDeleteRowButtons()), waitMoment);
            confirmationWindowPage.clickConfirmModalButton();
            waitWhileSeveralPreloadProgressBarsAreDisappeared();
        }
    }

    public void clickValueManagementTab() {
        clickOn(valueManagementPO.getValueManagementTab());
    }

    public List<String> getValuesList() {
        if (paginationPage.isPaginationDropDownDisabled()) {
            paginationPage.selectMaxRowsPerPage();
        }
        return getListValuesForFirstColumn();
    }

    public List<String> getValuesContainerList() {
        return getElementsText(valueManagementPO.getValues());
    }

    public List<String> getColumnNames() {
        return getElementsText(valueManagementPO.getColumns());
    }

    public List<String> getTableRowNames() {
        if (paginationPage.isPaginationDropDownDisabled()) {
            paginationPage.selectMaxRowsPerPage();
        }
        return getElementsText(valueManagementPO.getRowNames());
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getColumnIndex(columnName, getColumnNames());
        return driver.findElements(xpath(valueManagementPO.getValueManagementRows())).stream()
                .map(row -> getElementText(
                        row.findElement(xpath(format(valueManagementPO.getTableRowValue(), columnIndex)))))
                .collect(Collectors.toList());
    }

    public List<String> getListValuesForFirstColumn() {
        return getElementsText(valueManagementPO.getRowNames());
    }

    public List<ValueData> getValueTableData() {
        List<String> columnNames = getColumnNames();
        return driver.findElements(xpath(valueManagementPO.getValueManagementRows())).stream()
                .map(row -> new ValueData()
                        .setValue(getRowValue(row, VALUE, columnNames))
                        .setLastUpdate(getRowValue(row, LAST_UPDATED, columnNames))
                        .setDateCreated(getRowValue(row, DATE_CREATED, columnNames))
                        .setName(getRowValue(row, NAME, columnNames))
                        .setScoringRange(getRowValue(row, SCORING_RANGE, columnNames))
                ).collect(Collectors.toList());
    }

    private int getColumnIndex(String columnName, List<String> columnNames) {
        return columnNames.indexOf(columnName.toUpperCase()) + 1;
    }

    public String getRowValue(WebElement row, String columnName, List<String> columnNames) {
        int columnNameIndex = getColumnIndex(columnName.toUpperCase(), columnNames);
        return columnNameIndex == 0 ? null :
                getElementText(row.findElement(xpath(format(valueManagementPO.getRowColumn(), columnNameIndex))));
    }

    public String getErrorMessage() {
        return getElementText(valueManagementPO.getValueNameErrorMessage());
    }

    public String getErrorMessageElementCSS(String cssValue) {
        return driver.findElement(valueManagementPO.getValueNameErrorMessage()).getCssValue(cssValue);
    }

    public String getModalNotice() {
        return getElementText(valueManagementPO.getModalNotice());
    }

    public String getFieldValidationMessage() {
        return getElementText(valueManagementPO.getFieldValidationMessage());
    }

    public String getEmptyTableMessage() {
        return getElementText(waitShort, valueManagementPO.getEmptyTableMessage());
    }

    public String getAddValueManagementButtonText() {
        return getElementText(valueManagementPO.getAddNewButton());
    }

    public int getRowsCount() {
        if (isElementDisplayed(xpath(valueManagementPO.getValueManagementRows()))) {
            return driver.findElements(xpath(valueManagementPO.getValueManagementRows())).size();
        } else {
            return 0;
        }
    }

    public boolean isRiskModelDropDownDisplayed() {
        return isElementDisplayed(valueManagementPO.getRiskModelDropDown());
    }

    public void clickRiskModelDropDown() {
        clickOn(valueManagementPO.getRiskModelDropDown());
    }

    public List<String> getRiskModelDropDownOptions() {
        return getDropDownOptions(valueManagementPO.getDropDownOptions());
    }

    public String getRiskModel() {
        return getAttributeOrText(valueManagementPO.getRiskModelDropDown(), VALUE);
    }

    public void selectFromRiskModelDropDown(String value) {
        clickOn(xpath(format(valueManagementPO.getDropDownValuesList(), value)));
    }

    public void clickApplyRiskModelButton() {
        clickOn(valueManagementPO.getApplyRiskModelButton());
    }

    public void clickRiskModelCancelButton() {
        clickOn(valueManagementPO.getRiskModelCancelButton());
    }

    public boolean isApplyRiskModelButtonDisplayed() {
        return isElementDisplayed(valueManagementPO.getApplyRiskModelButton());
    }

    public boolean isRiskModelCancelButtonDisplayed() {
        return isElementDisplayed(valueManagementPO.getRiskModelCancelButton());
    }

    public void clickRiskScoringColorButton() {
        clickOn(valueManagementPO.getRiskScoringColorButton());
    }

    public void selectMiddleRiskScoringColor() {
        clickOn(valueManagementPO.getRiskScoringColorMedium());
    }

    public boolean isActivityTypeNameFieldDisabled() {
        return isElementAttributeContains(xpath(format(valueManagementPO.getValueNameInput())), CLASS, DISABLED);
    }

}
