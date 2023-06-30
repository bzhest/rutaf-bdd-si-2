package com.refinitiv.asts.test.ui.pageActions.reports;

import com.google.common.collect.Iterables;
import com.refinitiv.asts.core.framework.webelements.SelectClz;
import com.refinitiv.asts.test.ui.constants.DashboardConstants;
import com.refinitiv.asts.test.ui.constants.PageElementNames;
import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.PaginationPage;
import com.refinitiv.asts.test.ui.pageObjects.reports.ReportsPO;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.*;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.PageElementNames.CHECKS;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.UNCHECKED;
import static com.refinitiv.asts.test.ui.constants.Pages.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.DEFAULT_ITEMS_PER_PAGE;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfAllElementsLocatedBy;

public class ReportsPage extends BasePage<ReportsPage> {

    public static final String THIRD_PARTY_COUNTRY = "THIRD-PARTY COUNTRY";
    public static final String THIRD_PARTY_ID = "THIRD-PARTY ID";
    public static final String ORDER_ID = "ORDER ID";
    public static final String RISK_SCORE = "RISK SCORE";
    public static final String DECIMAL_REGEX = "(\\d.\\d|\\d)";
    private static final String SELECT_ALL = "(Select All)";
    private static final String ALL_THIRD_PARTY_LOCATOR_VALUE = "allThirdparty";
    public static final String COLUMNS = "Columns";
    private final PaginationPage paginationPage;
    private final ReportsPO reportsPO;

    public ReportsPage(WebDriver driver) {
        super(driver);
        reportsPO = new ReportsPO(driver);
        paginationPage = new PaginationPage(driver, context);
    }

    @Override
    protected ExpectedCondition<ReportsPage> getPageLoadCondition() {
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

    public void navigateToReportsPage() {
        waitWhilePreloadProgressbarIsDisappeared();
        this.driver.get(URL + REPORTS);
    }

    public void clickPanelTabButton(String value) {
        waitWhilePreloadProgressbarIsDisappeared();
        int agTab = value.equalsIgnoreCase(DashboardConstants.COLUMNS) ? 1 : 2;
        clickOn(xpath(format(reportsPO.getFilterPanelButton(), agTab)));
    }

    public void selectReportsTab(String reportTabName) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(reportsPO.getReportsTab(), reportTabName.toUpperCase())), waitLong);
    }

    public void clickAgColumnField(String status, String value) {
        clearAndInputField(driver.findElement(reportsPO.getColumnsSearchField()), value);
        if (status.equals(CHECKS)) {
            selectAngularCheckbox(xpath(format(reportsPO.getColumnFieldCheckbox(), value)), PageElementNames.CHECKED);
        } else {
            selectAngularCheckbox(xpath(format(reportsPO.getColumnFieldCheckbox(), value)), UNCHECKED);
        }
    }

    public void clickAgFilterFieldTitle(String value) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(reportsPO.getAgFilterFieldTitle(), value)), waitShort);
    }

    public void clickAgFilterFieldLabel(String value) {
        waitWhilePreloadProgressbarIsDisappeared();
        waitShort.until(presenceOfElementLocated(xpath(format(reportsPO.getAgFilterFieldLabel(), SELECT_ALL))));
        if (!value.equals(SELECT_ALL)) {
            clearAndInputField(driver.findElement(reportsPO.getFiltersSearchField()), value);
        }
        selectReactCheckbox(reportsPO.getAgFilterFieldLabel(), value, PageElementNames.CHECKED);
    }

    public void clickFilterPageButton() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(reportsPO.getFilterPageButton());
    }

    public void inputSearchFiltersFrom(String fromDate) {
        clearAndInputField(reportsPO.getSearchFiltersFrom(), fromDate);
    }

    public void inputSearchFiltersTo(String toDate) {
        clearAndInputField(reportsPO.getSearchFiltersTo(), toDate);
    }

    public void selectReportCategoryDropdown(String param) {
        new SelectClz(driver.findElement(reportsPO.getReportCategoryDropdown())).selectElementByText(param);
    }

    public void clickResetAll() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(reportsPO.getFilterResetAll());
    }

    public void exportCSVFile() {
        clickExportButton();
        enterViaKeyboard(Keys.ARROW_DOWN);
        enterViaKeyboard(Keys.ARROW_DOWN);
        enterViaKeyboard(Keys.ENTER);
    }

    public void clickExportButton() {
        clickOn(reportsPO.getExportButton(), waitLong);
    }

    public List<String> getExtensionOptionsList() {
        return getElementsText(reportsPO.getExportOptions());
    }

    public void exportXLSFile() {
        clickExportButton();
        enterViaKeyboard(Keys.ARROW_DOWN);
        enterViaKeyboard(Keys.ENTER);
    }

    public void selectPaginationResult(String param) {
        waitWhilePreloadProgressbarIsDisappeared();
        new SelectClz(waitShort.until(visibilityOfElementLocated(reportsPO.getPaginationSelect()))).selectElementByText(
                param);
    }

    public void inputSearchRiskAreas(String param) {
        WebElement riskArea = driver.findElement(reportsPO.getRiskAreas());
        clickOn(reportsPO.getRiskAreas());
        riskArea.sendKeys(param);
        riskArea.sendKeys(Keys.ENTER);
    }

    public void clickGenerateResultButton() {
        clickOn(reportsPO.getGenerateResultButton());
    }

    public void clickClearFilterButton() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(reportsPO.getClearFilterButton());
    }

    public void clickFirstRowReport() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(reportsPO.getFirstRowReport());
    }

    public void clickLastRowReport() {
        waitWhilePreloadProgressbarIsDisappeared();
        WebElement lastRow = Iterables.getLast(getElements(reportsPO.getRowReport()));
        clickOn(lastRow);
    }

    public void selectThirdPartyDropdown(String param) {
        waitWhilePreloadProgressbarIsDisappeared();
        new SelectClz(driver.findElement(reportsPO.getThirdPartyDropdown())).selectElementByText(param);
    }

    public void clickCancelButton() {
        clickOn(reportsPO.getCancelButton());
    }

    public void uncheckAllColumns() {
        clickOn(reportsPO.getSelectAllColumns());
        clickOn(reportsPO.getSelectAllColumns());
    }

    public void checkAllColumns() {
        clickOn(reportsPO.getSelectAllColumns());
    }

    public void clickFilterOptionButton(String button) {
        clickOn(xpath(format(reportsPO.getFilterOptionButton(), button)));
    }

    public void clickStatusReportRecord(String thirdPartyName) {
        clickOn(xpath(format(reportsPO.getStatusReportRecord(), thirdPartyName)), waitShort);
    }

    public void fillInFilterInput(String value) {
        clearAndInputField(reportsPO.getFilterValueInput(), value);
    }

    public Map<String, String> getWizardsBlockData() {
        Map<String, String> wizardsBlockData = new HashMap<>();
        for (WebElement progress : getWizardsActivityProgresses()) {
            wizardsBlockData.put(getElementText(progress.findElement(reportsPO.getWizardsComponentName())),
                                 getElementText(progress));
        }
        return wizardsBlockData;
    }

    private List<WebElement> getWizardsActivityProgresses() {
        List<WebElement> notStartedElements = getElements(reportsPO.getWizardsProgress());
        List<WebElement> startedElements = getElements(reportsPO.getWizardsGreenProgress());
        List<WebElement> wizardsElements = new ArrayList<>();
        for (int i = 0; i < notStartedElements.size(); i++) {
            if (isElementDisplayed(notStartedElements.get(i))) {
                wizardsElements.add(notStartedElements.get(i));
            } else {
                wizardsElements.add(startedElements.get(i));
            }
        }
        return wizardsElements;
    }

    public List<String> getSearchFilterList() {
        return getElementsText(reportsPO.getSearchFiltersList());
    }

    public List<String> getSearchTableFieldsList() {
        return getElementsText(reportsPO.getSearchTableFieldsList());
    }

    public List<String> getFilterOptions() {
        return getElementsText(reportsPO.getFilterOptions());
    }

    public List<String> getThirdPartyDropdownOptions() {
        waitWhilePreloadProgressbarIsDisappeared();
        return new SelectClz(driver.findElement(reportsPO.getThirdPartyDropdown())).getAllOptions();
    }

    public List<String> getReportTableColumns() {
        return getElementsTextsWithBlank(reportsPO.getTableColumns());
    }

    public List<String> getReportTableColumnValues(String columnName) {
        return getElementsText(getReportTableColumnElements(columnName));
    }

    private List<WebElement> getReportTableColumnElements(String columnName) {
        int columnIndex = getReportTableColumns().indexOf(columnName) + 1;
        return driver.findElements(xpath(format(reportsPO.getTableColumnValues(), columnIndex)));
    }

    public List<String> getReportColumnValueColor(String column, String value) {
        int columnIndex = getReportTableColumns().indexOf(column) + 1;
        return driver.findElements(xpath(format(reportsPO.getRiskScoreValues(), columnIndex))).stream()
                .filter(element -> getElementText(element).equals(value))
                .map(element -> getCssValue(element, COLOR)).collect(Collectors.toList());
    }

    public List<String> getStatusReportPageTableValue(String columnName) {
        int columnIndex = getSearchTableFieldsList().indexOf(columnName) + 1;
        return getElementsText(xpath(format(reportsPO.getStatusTableColumnValues(), columnIndex)));
    }

    public List<String> getStatusReportThirdParties() {
        List<String> names = getElementsText(reportsPO.getStatusReportThirdPartiesNames());
        while (paginationPage.isNextPageButtonVisible() && paginationPage.isNextPageButtonActive()) {
            paginationPage.clickNextPageButton();
            names.addAll(getElementsText(reportsPO.getStatusReportThirdPartiesNames()));
        }
        return names;
    }

    public List<List<String>> getPageContent() {
        List<WebElement> tableRows = driver.findElements(reportsPO.getRowReport());
        return tableRows.stream()
                .map(row -> getElementsTextsWithBlank(waitMoment.ignoring(StaleElementReferenceException.class)
                                                              .until(visibilityOfAllElements(row.findElements(
                                                                      reportsPO.getRowValue())))))
                .collect(Collectors.toList());
    }

    public String getFilterPanelLabelText() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementText(xpath(format(reportsPO.getFilterPanelButton(), 2)));
    }

    public String getSearchResultsLabel() {
        return getElementText(reportsPO.getSearchResultsLabel());
    }

    public String getSearchFiltersCustomDateFrom() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementText(reportsPO.getSearchFiltersCustomDateFrom());
    }

    public String getSearchFiltersCustomDateTo() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementText(reportsPO.getSearchFiltersCustomDateTo());
    }

    public String getRiskAreasTableFields(String value) {
        waitWhilePreloadProgressbarIsDisappeared();
        int riskAreasField =
                value.equalsIgnoreCase(DashboardConstants.THIRD_PARTY_NAME) ? 1 :
                        value.equalsIgnoreCase(DashboardConstants.INDUSTRY_TYPE) ? 2 :
                                value.equalsIgnoreCase(DashboardConstants.COUNTRY) ? 3 : 4;
        if (value.equals(DashboardConstants.AVERAGE_RISK_SCORE_PER_THIRD_PARTY)) {
            return getElementText(xpath(format(reportsPO.getRiskAreasTableField(), value)));
        } else {
            return getElementText(xpath(format(reportsPO.getRiskAreasTableFields(), riskAreasField)));
        }
    }

    public String getActivityResultCount() {
        waitWhilePreloadProgressbarIsDisappeared();
        if (!isElementDisplayed(reportsPO.getNoMatchFound())) {
            WebElement element2 = getElementByXPath(reportsPO.getActivityResultCount());
            if (element2 == null) {
                return String.valueOf(getTableReportListSize());
            } else {
                String[] value = getElementByXPath(reportsPO.getActivityResultCount()).getText().split("OF");
                return value[1].replace(StringUtils.SPACE, EMPTY);
            }
        } else {
            return ZERO;
        }
    }

    public String getTotalCountLabel() {
        waitWhilePreloadProgressbarIsDisappeared();
        if (!isElementDisplayed(reportsPO.getNoMatchFound())) {
            return getElementText(xpath(reportsPO.getActivityResultCount()));
        } else {
            return ZERO;
        }
    }

    public int getTotalCount() {
        paginationPage.clickLastPage();
        return (DEFAULT_ITEMS_PER_PAGE * (paginationPage.getCurrentPageNumber() - 1)) +
                driver.findElements(reportsPO.getRowReport()).size();
    }

    public String getThirdPartyDropdownSelectedValue() {
        waitWhilePreloadProgressbarIsDisappeared();
        String value = driver.findElement(reportsPO.getThirdPartyDropdown()).getAttribute(VALUE);
        if (value.equals(ALL_THIRD_PARTY_LOCATOR_VALUE)) {
            return DashboardConstants.ALL_THIRD_PARTY;
        } else {
            return DashboardConstants.MY_THIRD_PARTY;
        }
    }

    public String getIconInfo() {
        waitWhilePreloadProgressbarIsDisappeared();
        hoverOverElement(reportsPO.getIconButton());
        moveToElementAndClick(getElement(reportsPO.getIconButton()));
        return getElementText(reportsPO.getIconInfo());
    }

    public String getFirstRowColumnValue(String columnName) {
        List<String> reportTableColumns = getReportTableColumns();
        if (reportTableColumns.contains(columnName)) {
            int columnIndex = reportTableColumns.indexOf(columnName) + 1;
            return getElementText(driver.findElement(reportsPO.getFirstRowReport())
                                          .findElement(xpath(format(reportsPO.getTableColumnValues(), columnIndex))));
        }
        return null;
    }

    public String getLastRowColumnValue(String columnName) {
        List<String> reportTableColumns = getReportTableColumns();
        int columnIndex = reportTableColumns.indexOf(columnName);
        WebElement lastRow = Iterables.getLast(getElements(reportsPO.getRowReport()));
        return getElementText(lastRow.findElements(reportsPO.getRowValue()).get(columnIndex));
    }

    public String getThirdPartySearchValue(String fieldName) {
        return getElementText(xpath(format(reportsPO.getThirdPartyValue(), fieldName)));
    }

    public String getThirdPartySearchValueWithCircle(String fieldName) {
        return getElementText(xpath(format(reportsPO.getThirdPartyValueWithCircle(), fieldName)));
    }

    public String getWorkflowEmptyMessage() {
        return getElementText(reportsPO.getWorkflowEmptyMessage());
    }

    public String getStatusFieldCircleColor(String fieldName) {
        return getCssValue(xpath(format(reportsPO.getActivityStatusCircle(), fieldName)), COLOR);
    }

    public String getStatusCompletedPercentage() {
        return getElementText(reportsPO.getCompletionProgressbarPercentage());
    }

    public String getStatusTooltip() {
        hoverOverElement(reportsPO.getWizardsGreenProgress());
        return getElementText(reportsPO.getStatusReportTooltip());
    }

    public String getFirstCheckboxValue() {
        return getElementText(reportsPO.getFirstCheckBoxValue());
    }

    public List<String> getRiskAreaIconsTooltipsTexts() {
        List<WebElement> elements = getElements(reportsPO.getRiskAreaTableIcon());
        return elements.stream().map(this::getRiskAreaIconTooltipsTexts).collect(Collectors.toList());
    }

    public List<String> getStaticCheckBoxOptions() {
        return getElementsText(reportsPO.getStaticCheckBoxOptions());
    }

    private String getRiskAreaIconTooltipsTexts(WebElement iconElement) {
        final String[] message = {null};
        waitShort.ignoring(NoSuchElementException.class).until(driver -> {
            scrollIntoCenterView(iconElement);
            hoverOverElement(iconElement);
            message[0] = getElementText(reportsPO.getTooltip());
            return true;
        });
        return message[0];
    }

    public int getTableReportListSize() {
        return driver.findElements(reportsPO.getTableReportList()).size();
    }

    public boolean isExportButtonDisabled() {
        return !isElementEnabled(reportsPO.getExportButton());
    }

    public boolean isNoAvailableDataExist() {
        waitWhilePreloadProgressbarIsDisappeared();
        return isElementDisplayed(reportsPO.getNoAvailableData());
    }

    public boolean isResetFilterDisplayed(boolean isExpected) {
        return isExpected ? isElementDisplayed(waitShort, reportsPO.getFilterResetAll()) :
                isElementDisplayedNow(reportsPO.getFilterResetAll());
    }

    public boolean isSearchAreaDisplayed() {
        return isElementDisplayed(reportsPO.getFilterValueInput());
    }

    public boolean getExportToExcelLabel() {
        waitWhilePreloadProgressbarIsDisappeared();
        return isElementDisplayed(reportsPO.getExportToExcelLabel());
    }

    public boolean isNoMatchFoundDisplayedForReport() {
        return isElementDisplayed(reportsPO.getNoMatchFound());
    }

    public boolean isColumnWithNameDisplayed(String columnName) {
        return isElementDisplayed(xpath(format(reportsPO.getColumnName(), columnName.toUpperCase())));
    }

    public boolean isReportPageSelected(String expectedTabName) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        return isElementAttributeContains(waitLong, xpath(format(reportsPO.getReportTabButton(), expectedTabName)),
                                          CLASS, SELECTED);
    }

    public boolean isReportFilterFieldSelected(String expectedFieldFilter) {
        return isElementAttributeContains(xpath(format(reportsPO.getFilterCheckbox(), expectedFieldFilter)), CLASS,
                                          TestConstants.CHECKED);
    }

    public boolean areButtonDisplayedForEachFilterOptions(List<String> buttonNames) {
        boolean actualResult = false;
        clickOn(reportsPO.getFilterOptionOpen());
        for (String button : buttonNames) {
            actualResult = isElementDisplayed(xpath(format(reportsPO.getFilterOptionButton(), button)));
            if (!actualResult) {
                return false;
            }
        }
        return actualResult;
    }

    public boolean isReportToolPanelDisplayed(String panelName) {
        int reportPanelIndex = panelName.equals(COLUMNS) ? 1 : 2;
        return isElementDisplayed(xpath(format(reportsPO.getReportPanel(), reportPanelIndex)));
    }

    public boolean isFilterIconForColumnDisplayed(String columnName) {
        return isElementDisplayed(xpath(format(reportsPO.getFilterIcon(), columnName)));
    }

    public boolean isPaginationVisible() {
        return isElementDisplayed(reportsPO.getPaginationSelect());
    }

    public boolean isFlatFileTemplateButtonShown() {
        return isElementDisplayed(reportsPO.getFlatFileTemplateButton());
    }

    public boolean isInformationIconShown() {
        return isElementDisplayed(reportsPO.getInformationIcon());
    }

    public boolean isBulkProcessTypeDropDownShown() {
        return isElementDisplayed(reportsPO.getBulkProcessTypeDropDown());
    }

    public boolean isUploadFileButtonShown() {
        return isElementDisplayed(reportsPO.getUploadFileButton());
    }

    public void clickUploadFileButton() {
        clickOn(reportsPO.getUploadFileButton());
    }

    public void uploadFile(String path) {
        driver.findElement(reportsPO.getUploadFileInput()).sendKeys(path);
    }

    public void clickUploadAndProceedButtonModalWindow() {
        for (int i = 0; i < 5; i++) {
            try {
                if (isElementDisplayed(reportsPO.getUploadModalWindow())) {
                    clickOn(reportsPO.getUploadButtonModalWindow());
                }
            } catch (StaleElementReferenceException | org.openqa.selenium.NoSuchElementException e) {
                break;
            }
        }
    }

    public String getRecordStatus(int rowNumber) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        waitShort.until(visibilityOfAllElementsLocatedBy
                                (xpath(format(reportsPO.getStatusValueBulkTransactionsTable(), rowNumber - 1))));
        return getElementText(xpath(format(reportsPO.getStatusValueBulkTransactionsTable(), rowNumber - 1)));
    }

    public void clickBulkProcessTypeDropDown() {
        clickOn(reportsPO.getBulkProcessTypeDropDown());
    }

    public void clickBulkProcessTypeDropdownOption(String option) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(reportsPO.getBulkProcessTypeDropdownOption(), option)));
    }

    public void waitForUploadedFileCrossButtonVisibility() {
        waitShort.until(visibilityOfAllElementsLocatedBy(reportsPO.getUploadFileCrossButton()));
    }

    public List<String> getBulkProcessTypeDropDownOptions() {
        return getElementsText(reportsPO.getDropDownValuesList());
    }

    public boolean isColumnDisplayed(String column) {
        boolean isDisplayed = isElementDisplayed(xpath(format(reportsPO.getTableColumn(), column)));
        if (!isDisplayed) {
            ((JavascriptExecutor) driver).executeScript(SCROLL_LEFT_SCRIPT,
                                                        getElement(reportsPO.getHorizontalScroll()));
            return isElementDisplayed(xpath(format(reportsPO.getTableColumn(), column)));
        }
        return isDisplayed;
    }

    public boolean isClearButtonDisplayed() {
        return isElementDisplayed(waitMoment, reportsPO.getClearFilterButton());
    }

    public boolean isFilterFieldTitleDisplayed(String value) {
        return isElementDisplayed(xpath(format(reportsPO.getAgFilterFieldTitle(), value)));
    }

    public List<String> getReportsTabs() {
        return getElementsText(reportsPO.getReportsTabs());
    }

    public void clickDownloadErrorFileButton(int rowNumber) {
        clickOn(xpath(format(reportsPO.getErrorFileButtonBulkTransactionsTable(), rowNumber - 1)));
    }

}
