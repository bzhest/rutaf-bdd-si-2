package com.refinitiv.asts.test.ui.pageActions.thirdParty;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.enums.Colors;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.PaginationPage;
import com.refinitiv.asts.test.ui.pageObjects.commonPO.ShowAngularPO;
import com.refinitiv.asts.test.ui.pageObjects.commonPO.ShowReactPO;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.AdvanceSearchPO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.AdvanceSearchResultsData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ThirdPartyData;
import com.refinitiv.asts.test.utils.FileUtil;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_DATA_CONTEXT;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.THIRD_PARTY_NAME_HEADER;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.AdvanceSearchResultsFields.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.*;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class AdvanceSearchPage extends BasePage<AdvanceSearchPage> {

    private final AdvanceSearchPO advanceSearchPO;
    private final PaginationPage paginationPage;
    private final ShowAngularPO showAngularPO;
    private final ShowReactPO showReactPO;

    public AdvanceSearchPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        advanceSearchPO = new AdvanceSearchPO(driver);
        showAngularPO = new ShowAngularPO();
        showReactPO = new ShowReactPO(driver);
        paginationPage = new PaginationPage(driver, context);
    }

    @Override
    protected ExpectedCondition<AdvanceSearchPage> getPageLoadCondition() {
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

    public void selectSearchCriteriaParameter(String param, int lineNumber) {
        WebElement parameterInput =
                getElement(xpath(format(advanceSearchPO.getParamDropdownRow1(), lineNumber)));
        clickOn(parameterInput);
        clearWebField(parameterInput);
        parameterInput.sendKeys(param);
        parameterInput.sendKeys(Keys.ARROW_DOWN);
        parameterInput.sendKeys(Keys.ENTER);
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void selectSearchCriteriaValue(String param, int lineNumber) {
        WebElement valueInput = getElement(xpath(format(advanceSearchPO.getParamDropdownRow2(), lineNumber)));
        clickOn(valueInput);
        valueInput.sendKeys(param);
        enterViaKeyboard(Keys.ARROW_DOWN);
        enterViaKeyboard(Keys.ENTER);
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void fillValueFieldWithCreatedThirdPartyName(int lineNumber) {
        ThirdPartyData thirdPartyData = (ThirdPartyData) this.context.getScenarioContext()
                .getContext(THIRD_PARTY_DATA_CONTEXT);
        WebElement valueInput = getElement(xpath(format(advanceSearchPO.getParamDropdownRow2(), lineNumber)));
        clickOn(valueInput);
        valueInput.sendKeys(thirdPartyData.getName());
    }

    public boolean isCreatedThirdPartyPresentInTable() {
        ThirdPartyData thirdPartyData = (ThirdPartyData) this.context.getScenarioContext()
                .getContext(THIRD_PARTY_DATA_CONTEXT);
        try {
            List<String> thirdPartyNamesPresentedInTable = getListValuesForColumn(THIRD_PARTY_NAME_HEADER);
            return thirdPartyNamesPresentedInTable.contains(thirdPartyData.getName());
        } catch (NoSuchElementException e) {
            return false;
        }
    }

    private void clearWebField(WebElement element) {
        while (!element.getAttribute(VALUE).equals(StringUtils.EMPTY)) {
            element.sendKeys(Keys.BACK_SPACE);
        }
    }

    public void clickSearchButton() {
        clickOn(advanceSearchPO.getSearchButton());
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickSearchButtonWithoutWaiter() {
        clickOn(advanceSearchPO.getSearchButton());
    }

    public void clickAddButton() {
        clickOn(advanceSearchPO.getAddButton());
    }

    public void clickDeleteButton(int lineNumber) {
        WebElement deleteIcon = getElement(xpath(format(advanceSearchPO.getDeleteButton(), lineNumber)));
        clickOn(deleteIcon);
    }

    public void clickExportToExcel() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(advanceSearchPO.getExportToExcelButton());
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickClearSearchButton() {
        clickOn(advanceSearchPO.getClearSearchButton());
    }

    public void clickOnFirstFoundSupplier() {
        WebElement firstFoundSupplier = driver.findElements(showAngularPO.getTableRows()).get(0);
        clickOn(firstFoundSupplier);
    }

    public boolean isColumnScreeningStatusDisplayed(String columnName) {
        By screeningStatusColumnLocator = By.xpath(format(advanceSearchPO.getScreeningStatusColumn(), columnName));
        waitLong.until(ExpectedConditions.visibilityOfElementLocated(screeningStatusColumnLocator));
        return isElementDisplayedNow(screeningStatusColumnLocator);
    }

    public String getFilterSelectedValue() {
        return getElementText(advanceSearchPO.getFilterDropdown());
    }

    public void expandDropdownFilter() {
        scrollIntoView(advanceSearchPO.getAdvanceSearchWindow());
        clickOn(advanceSearchPO.getFilterDropdown());
    }

    public void selectFilterValue(String value) {
        WebElement filterValue = driver.findElements(advanceSearchPO.getDropdownItems())
                .stream()
                .filter(element -> element.getAttribute(DATA_VALUE).equals(value))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException(value + " value is not found in filter dropdown"));
        clickOn(filterValue);
    }

    public List<String> getDropdownFilterValues() {
        return getDropDownOptions(advanceSearchPO.getDropdownItems());
    }

    public boolean isAddButtonEnabled(boolean shouldBeEnabled) {
        return isButtonEnabled(advanceSearchPO.getAddButton(), shouldBeEnabled);
    }

    public boolean isSearchButtonEnabled(boolean shouldBeEnabled) {
        return isButtonEnabled(advanceSearchPO.getSearchButton(), shouldBeEnabled);
    }

    private boolean isButtonEnabled(By buttonLocator, boolean shouldBeEnabled) {
        WebElement button = getElement(buttonLocator);
        return shouldBeEnabled ?
                isElementEnabled(button) && button.getCssValue(COLOR).equals(Colors.BLACK_REACT.getColorRgba()) :
                !isElementEnabled(button) && button.getCssValue(COLOR).equals(Colors.DARK_GREY.getColorRgba());
    }

    public boolean isNoDataFound() {
        try {
            WebElement noDataFound = getElement(advanceSearchPO.getNoRecordsFound());
            return noDataFound != null;
        } catch (NoSuchElementException ex) {
            return false;
        }
    }

    public boolean isLinePresent(String parameter, String value) {
        return isElementDisplayed(xpath(format(advanceSearchPO.getParameterValueLine(), parameter, value)));
    }

    public boolean isDropdownFilterPresent() {
        return isElementDisplayed(advanceSearchPO.getFilterDropdown());
    }

    public boolean isDeleteIconPresent(int lineNumber, boolean shouldBeVisible) {
        WebElement deleteIcon = getElement(xpath(format(advanceSearchPO.getDeleteButton(), lineNumber)));
        String visibilityValue = deleteIcon.getCssValue(VISIBILITY);
        return shouldBeVisible ? visibilityValue.equals(VISIBLE) : visibilityValue.equals(HIDDEN);
    }

    public boolean isClearSearchButtonPresent() {
        return isElementDisplayed(advanceSearchPO.getClearSearchButton());
    }

    public AdvanceSearchResultsData getAllResultsValuesList() {
        if (!isNoDataFound()) {
            AdvanceSearchResultsData resultsData = new AdvanceSearchResultsData();
            if (!paginationPage.isNextPageButtonVisible()) {
                return getResultsValuesOnPage();
            }
            while (paginationPage.isNextPageButtonActive()) {
                resultsData.getResultsList().addAll(getResultsValuesOnPage().getResultsList());
                paginationPage.clickNextPageButtonAndWait();
            }
            resultsData.getResultsList().addAll(getResultsValuesOnPage().getResultsList());
            return resultsData;
        }
        return new AdvanceSearchResultsData();
    }

    public AdvanceSearchResultsData getResultsValuesOnPage() {
        List<WebElement> elementsList = driver.findElements(showAngularPO.getTableRows());
        List<List<String>> elementsValues = elementsList.stream()
                .map(element -> getElementsText(element.findElements(showReactPO.getTableCells())))
                .collect(Collectors.toList());
        return new AdvanceSearchResultsData(elementsValues);
    }

    public String getNoRecordsFoundText() {
        return getElementText(advanceSearchPO.getNoRecordsFound());
    }

    public AdvanceSearchResultsData getAdvanceSearchResultsFromCSV(File file) {
        List<List<String>> listFromCsv = FileUtil.readCSVFile(file);
        List<String> headers = listFromCsv.get(0);
        return new AdvanceSearchResultsData(listFromCsv.stream().skip(1).map(list -> new ArrayList<>(Arrays.asList(
                replaceEmptyWithDash(list.get(headers.indexOf(THIRD_PARTY_NAME.getName()))),
                replaceEmptyWithDash(list.get(headers.indexOf(INDUSTRY_TYPE.getName()))),
                replaceEmptyWithDash(list.get(headers.indexOf(COUNTRY.getName()))),
                replaceEmptyWithDash(list.get(headers.indexOf(THIRD_PARTY_STATUS.getName()))),
                replaceEmptyWithDash(list.get(headers.indexOf(RISK_MODEL.getName()))),
                replaceEmptyWithDash(list.get(headers.indexOf(RISK_TIER.getName()))),
                formatDate(SI_EXPORT_FILE_FORMAT, SI_UI_LOCAL_DATE_FORMAT,
                           list.get(headers.indexOf(DATE_CREATED.getName()))),
                formatDate(SI_EXPORT_FILE_FORMAT, SI_UI_LOCAL_DATE_FORMAT,
                           list.get(headers.indexOf(LAST_UPDATED.getName()))),
                capitalize(replaceEmptyWithDash(list.get(headers.indexOf(SCREENING_STATUS.getName())))
                                   .replace(UNDERSCORE, SPACE)
                                   .toLowerCase())))
        ).collect(Collectors.toList()));
    }

    public void waitSearchPageIsLoaded() {
        ExpectedCondition<Boolean> searchButtonIsDisplayed =
                driver -> getElement(advanceSearchPO.getSearchButton())
                        .isDisplayed();
        waitLong.until(searchButtonIsDisplayed);
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    public boolean isExportToExcelButtonPresent() {
        return isElementDisplayed(advanceSearchPO.getExportToExcelButton());
    }

    private String replaceEmptyWithDash(String value) {
        return value.isEmpty() ? "-" : value.trim().replaceAll(MULTI_SPACE_REGEX, SPACE);
    }

    public boolean isAdvancedSearchTableColumnDisplayed(String columnName) {
        return isElementDisplayed(xpath(format(advanceSearchPO.getSearchResultTableColumnHeader(), columnName)));
    }

    public List<String> getTableColumnNames() {
        return getElementsText(advanceSearchPO.getColumnNames());
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getTableColumnNames().indexOf(columnName) + 1;
        return getElementsText(xpath(format(advanceSearchPO.getRowColumn(), columnIndex)));
    }

    public void clearValueField(int lineNumber){
        clearText((xpath(format(advanceSearchPO.getParamDropdownRow2(), lineNumber))));
    }

}
