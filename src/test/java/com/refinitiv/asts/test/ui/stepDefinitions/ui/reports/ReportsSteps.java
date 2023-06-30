package com.refinitiv.asts.test.ui.stepDefinitions.ui.reports;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.ApiRequestBuilder;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.model.SiPublicReferencesResponse;
import com.refinitiv.asts.test.ui.api.model.thirdParty.ObjectsItem;
import com.refinitiv.asts.test.ui.constants.DashboardConstants;
import com.refinitiv.asts.test.ui.pageActions.reports.ReportsPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.openqa.selenium.TimeoutException;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.getThirdPartyNameFilterRequest;
import static com.refinitiv.asts.test.ui.api.BaseApi.TEN;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getFilteredThirdParties;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getReferencesCountries;
import static com.refinitiv.asts.test.ui.constants.APIConstants.SAME_DIVISION;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_ID;
import static com.refinitiv.asts.test.ui.constants.DashboardConstants.CSV;
import static com.refinitiv.asts.test.ui.constants.DashboardConstants.ICON_INFO_LABEL;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Colors.getColorRgba;
import static com.refinitiv.asts.test.ui.enums.Colors.getColorRgbaFromHex;
import static com.refinitiv.asts.test.ui.pageActions.reports.ReportsPage.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.utils.FileUtil.*;
import static java.lang.Integer.parseInt;
import static java.util.Arrays.asList;
import static java.util.stream.Collectors.toList;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertEquals;
import static org.testng.AssertJUnit.assertTrue;

public class ReportsSteps extends BaseSteps {

    private static final String THIRD_PARTY_STATUS_SUMMARY_REPORT_NAME = "Third-party Status Summary Report";
    private static final List<String> THIRD_PARTY_SUMMARY_COLUMNS =
            asList("Third-party Name", "Workflow Name", "Status", "Total Activity Completed",
                   "Workflow Wizard Name", "Completed Activity", "Total Activity",
                   "Activity Completed Percentage");
    private static final String INVALID_DATE_FORMAT = "21/36/4321";
    private final ReportsPage reportsPage;

    public ReportsSteps(ScenarioCtxtWrapper context) {
        this.context = context;
        reportsPage = new ReportsPage(this.driver);
    }

    private String getDate(String toDate) {
        return toDate.equalsIgnoreCase(INVALID) ? INVALID_DATE_FORMAT : toDate.contains(TODAY_MINUS) ?
                getDateTimeBeforeToday(REACT_FORMAT, parseInt(toDate.replace(TODAY_MINUS, EMPTY))) :
                getDateAfterTodayDate(REACT_FORMAT, parseInt(toDate.replace(TODAY, EMPTY)));
    }

    @When("User navigates to Reports page")
    public void navigateToReportsPage() {
        reportsPage.navigateToReportsPage();
        reportsPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks Report panel {string}")
    public void clickAgGridTab(String panelName) {
        reportsPage.waitWhilePreloadProgressbarIsDisappeared();
        reportsPage.clickPanelTabButton(panelName);
        reportsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User selects Report Tab {string}")
    public void selectReportsTab(String reportTab) {
        reportsPage.selectReportsTab(reportTab);
    }

    @When("^User (checks|unchecks) Column Field \"((.*))\"$")
    public void clickAgColumnField(String status, String fieldName) {
        if (!fieldName.equals(NOT_APPLICABLE)) {
            reportsPage.clickAgColumnField(status, fieldName.toUpperCase());
        }
    }

    @When("User clicks Filter Field Title {string}")
    public void clickAgFilterFieldTitle(String fieldTitle) {
        reportsPage.clickAgFilterFieldTitle(fieldTitle.toUpperCase());
    }

    @When("User clicks Filter Field Label {string}")
    public void clickAgFilterFieldLabel(String fieldLabel) {
        reportsPage.clickAgFilterFieldLabel(fieldLabel);
    }

    @When("User clicks filter page button")
    public void clickFilterPageButton() {
        reportsPage.clickFilterPageButton();
    }

    @When("User inputs in Search Filter From {string}")
    public void inputSearchFiltersFrom(String fromDate) {
        fromDate = getDate(fromDate);
        reportsPage.inputSearchFiltersFrom(fromDate);
    }

    @When("User inputs text in Search Filter To {string}")
    public void inputSearchFiltersTo(String toDate) {
        toDate = getDate(toDate);
        reportsPage.inputSearchFiltersTo(toDate);
    }

    @When("^User selects (All Third-party|My Third-party) show option$")
    public void selectThirdPartyDropdown(String optionName) {
        reportsPage.selectThirdPartyDropdown(optionName);
        reportsPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks Reset All filter report button")
    public void resetAllFilter() {
        reportsPage.clickResetAll();
        reportsPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks Clear report filter button")
    public void clickClearFilterButton() {
        reportsPage.clickClearFilterButton();
    }

    @When("User clicks first Report row")
    public void clickFirstRowReport() {
        reportsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        reportsPage.clickFirstRowReport();
    }

    @When("User clicks Last Row on Report table")
    public void clickLastRowReport() {
        reportsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        reportsPage.clickLastRowReport();
        reportsPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("^User adds Reports (first|last) row \"(.*)\" value to \"(.*)\" context$")
    public void addFirstRowColumnValueToContext(String rowPosition, String columnName, String contextName) {
        if (rowPosition.equals(LAST)) {
            context.getScenarioContext().setContext(contextName, reportsPage.getLastRowColumnValue(columnName));
        } else {
            context.getScenarioContext().setContext(contextName, reportsPage.getFirstRowColumnValue(columnName));
        }
    }

    @When("User selects report category {string}")
    public void selectReportCategoryDropdown(String reportCategory) {
        reportsPage.selectReportCategoryDropdown(reportCategory);
    }

    @When("User inputs text in Risk Areas {string}")
    public void inputSearchRiskAreas(String text) {
        reportsPage.inputSearchRiskAreas(text);
    }

    @When("User clicks Generate Result Button")
    public void clickGenerateResultButton() {
        reportsPage.clickGenerateResultButton();
    }

    @When("User clicks export csv file")
    public void exportCSVFile() {
        reportsPage.waitWhilePreloadProgressbarIsDisappeared();
        reportsPage.exportCSVFile();
    }

    @When("User clicks Report Export button")
    public void clickExportButton() {
        reportsPage.clickExportButton();
    }

    @When("User clicks export xls file")
    public void exportXLSFile() {
        reportsPage.exportXLSFile();
    }

    @When("User clicks Pagination Select {string}")
    public void clickPaginationSelect(String itemsPerPage) {
        if (reportsPage.isPaginationVisible()) {
            reportsPage.selectPaginationResult(itemsPerPage);
        }
    }

    @When("User unchecks all Report columns")
    public void uncheckAllReportColumns() {
        reportsPage.uncheckAllColumns();
    }

    @When("User checks all Report columns")
    public void checkAllReportColumns() {
        reportsPage.checkAllColumns();
    }

    @When("User clicks filter option button {string}")
    public void clickFilterOptionButton(String button) {
        reportsPage.clickFilterOptionButton(button);
    }

    @When("User clicks on newly created Third-party on Report page")
    public void clickOnNewlyCreatedThirdParty() {
        String thirdPartyName = (String) this.context.getScenarioContext().getContext(THIRD_PARTY_NAME);
        reportsPage.clickStatusReportRecord(thirdPartyName);
    }

    @When("User clicks Bulk Process Type dropdown")
    public void clickBulkProcessTypeDropDown() {
        reportsPage.clickBulkProcessTypeDropDown();
    }

    @When("User clicks {string} option in Bulk Process Type dropdown")
    public void clickBulkProcessTypeDropdownOption (String option) {
        reportsPage.clickBulkProcessTypeDropdownOption(option);
    }

    @When("User clicks 'Upload File' button")
    public void clickUploadFileButton() {
        reportsPage.clickUploadFileButton();
    }

    @When("User uploads {string} file on 'Bulk Transactions' page")
    public void uploadFile(String file) {
        reportsPage.clickUploadFileButton();
        String path = getFilePath(file);
        reportsPage.uploadFile(path);
        reportsPage.waitForUploadedFileCrossButtonVisibility();
        reportsPage.clickUploadAndProceedButtonModalWindow();
    }

    @When("User waits for 'Completed' status of the record on {int} row of 'Bulk Transactions' table")
    public void waitForCompletedStatusOfRecord(int rowNumber) {
        boolean isCompleted = false;
        int numberOfAttempts = 0;
        while(!isCompleted && numberOfAttempts <= 20) {
            try {
                if (!reportsPage.getRecordStatus(rowNumber).equalsIgnoreCase(COMPLETED)) {
                    reportsPage.refreshPage();
                    numberOfAttempts++;
                } else {
                    isCompleted = true;
                }
            } catch (TimeoutException e) {
                reportsPage.refreshPage();
                numberOfAttempts++;
            }
        }
    }

    @When("User fills in Filter input value {string}")
    public void fillInFilterInputValue(String value) {
        if (value.equals(VALUE_TO_REPLACE)) {
            value = reportsPage.getFirstCheckboxValue();
            context.getScenarioContext().setContext(VALUE_TO_REPLACE, value);
        }
        reportsPage.fillInFilterInput(value);
    }

    @When("User downloads automatically generated Error File for the record on the {int} row of 'Bulk Transactions' table")
    public void clickDownloadErrorFileButton(int rowNumber) {
        reportsPage.clickDownloadErrorFileButton(rowNumber);
    }

    @When("^User updates CSV file \"((.*))\" on line (\\d+) with created (Third-party ID|Custom Field name)$")
    public void updateCsvFileWithValue(String fileName, int fileLine, String valueType) {
        if (valueType.equalsIgnoreCase(ReportsPage.THIRD_PARTY_ID)) {
            String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
            updateCsvFileContent(getCsvFileContentWithUpdatedValues(fileName, fileLine, thirdPartyId, valueType),
                                 fileName);
        } else {
            String customFieldName = (String) context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_CONTEXT);
            updateCsvFileContent(getCsvFileContentWithUpdatedValues(fileName, fileLine, customFieldName, valueType),
                                 fileName);
        }
    }

    @Then("Label for the number of returned results is expected")
    public void verifyDueDiligenceResultCount() {
        assertThat(reportsPage.getTotalCountLabel())
                .as("Unexpected the count label of activities")
                .isEqualTo(RETURNED_RESULTS + reportsPage.getTotalCount());
    }

    @Then("No Match Found report records is displayed")
    public void getActivityResultCount() {
        assertThat(reportsPage.getActivityResultCount()).as("Unmatched the number/count of found records")
                .isEqualTo(ZERO);
    }

    @Then("^Export Report Button is (disabled|enabled)$")
    public void validateExportButtonState(String state) {
        if (state.equals(DISABLED) || reportsPage.isNoMatchFoundDisplayedForReport()) {
            assertThat(reportsPage.isExportButtonDisabled())
                    .as("Export Button is enabled")
                    .isTrue();
        } else {
            assertThat(reportsPage.isExportButtonDisabled())
                    .as("Export Button is disabled")
                    .isFalse();
        }
    }

    @Then("Report 'No Available Data' is displayed")
    public void validateAvailableData() {
        reportsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(reportsPage.isNoAvailableDataExist()).as("'No Available Data' message is not displayed")
                .isTrue();
    }

    @Then("^Report Reset all Filter Button is (hidden|available)$")
    public void validateResetFilterHidden(String state) {
        if (state.equals(HIDDEN)) {
            assertThat(reportsPage.isResetFilterDisplayed(false)).as("Reset Filter Button is visible")
                    .isFalse();
        } else {
            assertThat(reportsPage.isResetFilterDisplayed(true)).as("Reset Filter Button is hidden")
                    .isTrue();
        }
    }

    @Then("Report Filters panel contains label text {string}")
    public void getAgGridTabLabel(String expectedText) {
        reportsPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(reportsPage.getFilterPanelLabelText())
                .as("Report Filters panel label")
                .isEqualTo(expectedText);
    }

    @Then("Search area is displayed")
    public void verifySearchArea() {
        assertTrue("Search Area is not displayed", reportsPage.isSearchAreaDisplayed());
    }

    @Then("Search filter fields are expected")
    public void getSearchFilterList(List<String> expectedFilterFields) {
        assertThat(reportsPage.getSearchFilterList())
                .as("Incorrect Search filter fields")
                .isEqualTo(expectedFilterFields);
    }

    @Then("Export to Excel Label is displayed")
    public void isExportToExcelDisplayed() {
        assertThat(reportsPage.getExportToExcelLabel())
                .as("Export to Excel is not available")
                .isTrue();
    }

    @Then("Search table fields are expected")
    public void isSearchTableFieldsExpected(List<String> expectedTableColumns) {
        assertThat(reportsPage.getSearchTableFieldsList())
                .as("Incorrect Search table fields")
                .isEqualTo(expectedTableColumns);
    }

    @Then("Search Result Field is expected")
    public void isSearchResultsLabelExpected() {
        assertThat(reportsPage.getSearchResultsLabel())
                .as("Incorrect Search Result Label")
                .isEqualTo(DashboardConstants.THIRD_PARTY_STATUS);
    }

    @Then("Report From date input Invalid error id displayed")
    public void getSearchFiltersCustomDateFrom() {
        assertThat(reportsPage.getSearchFiltersCustomDateFrom())
                .as("From date input Invalid error is not displayed")
                .isEqualTo(DashboardConstants.INVALID_DATE_FORMAT);
    }

    @Then("Report To date input Invalid error id displayed")
    public void getSearchFiltersCustomDateTo() {
        assertThat(reportsPage.getSearchFiltersCustomDateTo())
                .as("To date input Invalid error is not displayed")
                .isEqualTo(DashboardConstants.INVALID_DATE_FORMAT);
    }

    @Then("Risk Area Field is displayed {string}")
    public void getRiskAreasTableFields(String fieldName) {
        assertThat(reportsPage.getRiskAreasTableFields(fieldName)).as("Incorrect Risk Area Field")
                .isEqualTo(fieldName);
    }

    @Then("^(?:Activity Metrics tab|Activity Report|Third-party Report|Workflow Report?) Third-party drop down displays \"((.*))\" value$")
    public void checkThirdPartyDropDownSelectedValue(String value) {
        assertEquals("Incorrect Third-party drop-down value is displayed", value,
                     reportsPage.getThirdPartyDropdownSelectedValue());
    }

    @Then("^(?:Activity Metrics tab|Activity Report|Third-party Report|Workflow Report?) Third-party drop down has options$")
    public void checkThirdPartyDropDownOptionsList(List<String> options) {
        assertEquals("Incorrect Third-party drop down list of values is displayed", options,
                     reportsPage.getThirdPartyDropdownOptions());
    }

    @Then("^Column with name \"((.*))\" (is|is not) displayed$")
    public void isColumnWithNameDisplayed(String columnName, String state) {
        if (state.contains(NOT)) {
            assertThat(reportsPage.isColumnWithNameDisplayed(columnName)).as("Column %s is still displayed", columnName)
                    .isFalse();
        } else {
            assertThat(reportsPage.isColumnWithNameDisplayed(columnName)).as("Column %s is not displayed", columnName)
                    .isTrue();
        }
    }

    @Then("Extension options are available")
    public void checkExtensionOptions(List<String> options) {
        assertThat(reportsPage.getExtensionOptionsList())
                .as("Extension options list is not expected")
                .isEqualTo(options);
        clickExportButton();
    }

    @Then("Report Icon info contains expected data")
    public void verifyIconInfo() {
        assertThat(reportsPage.getIconInfo()).as("Incorrect AG Tab label").isEqualTo(ICON_INFO_LABEL);
    }

    @Then("{string} report page is displayed")
    public void reportPageAreDisplayed(String expectedTabName) {
        reportsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(reportsPage.isReportPageSelected(expectedTabName))
                .as("%s report page is not selected", expectedTabName)
                .isTrue();
    }

    @Then("^Report Filter Field \"((.*))\" is (selected|not selected)$")
    public void reportFilterFieldIsSelected(String expectedFieldFilter, String state) {
        reportsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (state.contains(NOT)) {
            assertThat(reportsPage.isReportFilterFieldSelected(expectedFieldFilter))
                    .as("%s report page field is selected", expectedFieldFilter)
                    .isFalse();
        } else {
            assertThat(reportsPage.isReportFilterFieldSelected(expectedFieldFilter))
                    .as("%s report page field is not selected", expectedFieldFilter)
                    .isTrue();
        }
    }

    @Then("^All Report Filter Fields are selected$")
    public void reportFilterFieldsAreSelected() {
        reportsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<String> staticCheckBoxOptions = reportsPage.getStaticCheckBoxOptions();
        SoftAssertions softAssertions = new SoftAssertions();
        staticCheckBoxOptions.forEach(
                option -> softAssertions.assertThat(reportsPage.isReportFilterFieldSelected(option))
                        .as("%s report page field is not selected", option)
                        .isTrue());
        softAssertions.assertAll();
    }

    @Then("^Report \"((.*))\" file (contains|does not contain) expected columns$")
    public void reportFileContainsExpectedColumns(String fileType, String state, List<String> expectedColumns) {
        List<String> actualColumns = fileType.equals(CSV) ?
                readCSVFile(getLastDownloadedFile()).get(0).stream()
                        .map(column -> new String(column.getBytes()).replaceAll("[^A-Z -/]", EMPTY))
                        .collect(toList()) :
                readExcelFile(getLastDownloadedFile()).get(0);
        if (state.contains(NOT)) {
            assertThat(actualColumns)
                    .as("Report table columns are unexpected")
                    .doesNotContainAnyElementsOf(expectedColumns);
        } else {
            assertThat(actualColumns)
                    .as("Report table columns are unexpected")
                    .containsAll(expectedColumns);
        }
    }

    @Then("Report {string} file contains full country name in Third-party Country field")
    public void reportFileContainsFullCountryNameInThirdPartyCountryField(String fileType) {
        List<List<String>> fileAsList = fileType.equals(CSV) ? readCSVFile(getLastDownloadedFile()) :
                readExcelFile(getLastDownloadedFile());
        int countryIndex = fileAsList.get(0).indexOf(THIRD_PARTY_COUNTRY);
        List<String> actualCountries = fileAsList.stream().skip(1).map(row -> row.get(countryIndex)).collect(toList());
        List<String> referencesCountries = getReferencesCountries().getData().stream()
                .map(SiPublicReferencesResponse.Reference::getDescription).collect(toList());
        assertThat(referencesCountries).as("Country name is unexpected")
                .containsAll(actualCountries);
    }

    @Then("Report {string} file contains decimal format in Risk Score field")
    public void reportFileContainsDecimalFormatInRiskScoreField(String fileType) {
        List<List<String>> fileAsList = fileType.equals(CSV) ? readCSVFile(getLastDownloadedFile()) :
                readExcelFile(getLastDownloadedFile());
        int riskScoreIndex = fileAsList.get(0).indexOf(RISK_SCORE);
        List<String> allRiskScores = fileAsList.stream().skip(1).map(row -> row.get(riskScoreIndex)).collect(toList());
        SoftAssertions softAssert = new SoftAssertions();
        allRiskScores.forEach(riskScore -> softAssert.assertThat(riskScore).as("Risk Score format is unexpected")
                .containsPattern(DECIMAL_REGEX));
        softAssert.assertAll();
    }

    @Then("Report csv file content is the same as report table")
    public void reportCSVFileContentIsTheSameAsReportTable() {
        List<List<String>> actualFileData = readCSVFile(getLastDownloadedFile()).stream().skip(1)
                .map(row -> row.stream().map(value -> value.equals(ZERO) ? EMPTY : value).collect(toList()))
                .collect(toList());
        List<List<String>> expectedFileData = reportsPage.getPageContent();
        assertThat(expectedFileData.size()).as("Page content is empty").isNotZero();
        assertThat(actualFileData).as("Report file content is unexpected").containsAll(expectedFileData);
    }

    @Then("Report xls file content is the same as report table")
    public void reportXLSFileContentIsTheSameAsReportTable() {
        SoftAssertions softAssert = new SoftAssertions();
        List<List<String>> actualFileData = readExcelFile(getLastDownloadedFile()).stream().skip(0)
                .collect(toList());
        List<List<String>> expectedFileData = reportsPage.getPageContent();
        softAssert.assertThat(expectedFileData.size()).as("Page content is empty").isNotZero();
        actualFileData.forEach(record -> record.sort(Comparator.naturalOrder()));
        expectedFileData.forEach(record -> record.sort(Comparator.naturalOrder()));
        softAssert.assertThat(actualFileData).as("Report file content is unexpected")
                .containsAll(expectedFileData);
        softAssert.assertAll();
    }

    @Then("^Report column \"((.*))\" is (displayed|not displayed)$")
    public void reportColumnIsDisplayed(String expectedColumnName, String state) {
        if (state.contains(NOT)) {
            assertThat(reportsPage.getReportTableColumns())
                    .as("Report table columns are unexpected")
                    .doesNotContain(expectedColumnName);
        } else {
            assertThat(reportsPage.getReportTableColumns())
                    .as("Report table columns are unexpected")
                    .contains(expectedColumnName);
        }
    }

    @Then("Report filter options contains buttons")
    public void allReportFilterOptionsContainsButtons(List<String> buttonNames) {
        assertThat(reportsPage.areButtonDisplayedForEachFilterOptions(buttonNames))
                .as("Filter buttons are not displayed")
                .isTrue();
    }

    @Then("Report table column {string} contains only values")
    @SuppressWarnings("unchecked")
    public void reportTableColumnContainsOnlyValues(String columnName, List<String> expectedValues) {
        reportsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (expectedValues.size() == 1 && expectedValues.get(0).contains(COMMA)) {
            expectedValues = Arrays.asList(expectedValues.get(0).split(COMMA + ZERO_OR_MORE_SPACES));
        } else if (expectedValues.get(0).equals(REPORT_FILTER_OPTIONS)) {
            expectedValues = (List<String>) context.getScenarioContext().getContext(REPORT_FILTER_OPTIONS);
        }
        SoftAssertions softAssertions = new SoftAssertions();
        if (!expectedValues.get(0).equals(NOT_APPLICABLE)) {
            reportsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
            for (String value : reportsPage.getReportTableColumnValues(columnName.toUpperCase())) {
                if (columnName.contains(NAME.toUpperCase())) {
                    softAssertions.assertThat(expectedValues)
                            .as("Report table column value %s is unexpected", value)
                            .contains(value);
                } else {
                    softAssertions.assertThat(asList(value.split(COMMA)))
                            .as("Report table column value %s is unexpected", value)
                            .containsAnyElementsOf(expectedValues);
                }

            }
        }
        softAssertions.assertAll();
    }

    @Then("Report table column {string} contains {string} values")
    public void reportTableColumnContainsValues(String columnName, String expectedValue) {
        reportsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssertions softAssertions = new SoftAssertions();
        if (expectedValue.equals(VALUE_TO_REPLACE)) {
            expectedValue = reportsPage.getFirstCheckboxValue();
            context.getScenarioContext().setContext(VALUE_TO_REPLACE, expectedValue);
        }
        for (String value : reportsPage.getReportTableColumnValues(columnName.toUpperCase())) {
            softAssertions.assertThat(value)
                    .as("Report table column value %s is unexpected", value)
                    .containsIgnoringCase(expectedValue);
        }
        softAssertions.assertAll();
    }

    @Then("^Report panel \"((.*))\" tool panel is (displayed|not displayed)$")
    public void reportPanelToolPanelIsDisplayed(String panelName, String state) {
        if (state.contains(NOT)) {
            assertThat(reportsPage.isReportToolPanelDisplayed(panelName))
                    .as("%s report tool panel is displayed", panelName)
                    .isFalse();
        } else {
            assertThat(reportsPage.isReportToolPanelDisplayed(panelName))
                    .as("%s report tool panel is not displayed", panelName)
                    .isTrue();
        }
    }

    @Then("^Report filter icon for column \"((.*))\" is (displayed|not displayed)$")
    public void reportFilterIconForColumnIsNotDisplayed(String columnName, String state) {
        if (state.contains(NOT)) {
            assertThat(reportsPage.isFilterIconForColumnDisplayed(columnName))
                    .as("Filter icon for %s column is displayed", columnName)
                    .isFalse();
        } else {
            assertThat(reportsPage.isFilterIconForColumnDisplayed(columnName))
                    .as("Filter icon for %s column is not displayed", columnName)
                    .isTrue();
        }
    }

    @Then("Report table column {string} date contains only values in range from {string} to {string}")
    public void reportTableColumnDateContainsOnlyValuesInRangeFromTo(String columnName, String fromDate,
            String toDate) {
        List<String> columnValues = reportsPage.getReportTableColumnValues(columnName);
        SoftAssertions softAssertions = new SoftAssertions();
        columnValues.forEach(value -> {
            Date actualDate = getDateFromStringDate(value, DATE_OF_INCORPORATION_FORMAT);
            if (!fromDate.isEmpty()) {
                LocalDate expectedFromLocalDate = fromDate.contains(TODAY_MINUS) ?
                        getDateTimeBeforeTodayDate(parseInt(fromDate.replace(TODAY_MINUS, EMPTY))) :
                        getDateTimeAfterTodayDate(parseInt(fromDate.replace(TODAY, EMPTY)));
                Date expectedFromDate =
                        Date.from(expectedFromLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
                softAssertions.assertThat(actualDate).as("Current from date is not after expected date")
                        .isAfterOrEqualTo(expectedFromDate);
            }
            LocalDate expectedToLocalDate = toDate.contains(TODAY_MINUS) ?
                    getDateTimeBeforeTodayDate(parseInt(toDate.replace(TODAY_MINUS, EMPTY))) :
                    getDateTimeAfterTodayDate(parseInt(toDate.replace(TODAY, EMPTY)));
            Date expectedToDate = Date.from(expectedToLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
            softAssertions.assertThat(actualDate).as("Current from date is not before expected date")
                    .isBeforeOrEqualTo(expectedToDate);
        });
        softAssertions.assertAll();
    }

    @Then("Bulk Transactions buttons are shown")
    public void checkBulkTransactionButtonsAreShown() {
        SoftAssertions soft = new SoftAssertions();
        soft.assertThat(reportsPage.isFlatFileTemplateButtonShown())
                .as("Flat File Template button is not shown")
                .isTrue();
        soft.assertThat(reportsPage.isInformationIconShown())
                .as("Information icon is not shown")
                .isTrue();
        soft.assertThat(reportsPage.isBulkProcessTypeDropDownShown())
                .as("Bulk Process Type dropdown is not shown")
                .isTrue();
        soft.assertThat(reportsPage.isUploadFileButtonShown())
                .as("Upload File button is not shown")
                .isTrue();
        soft.assertAll();
    }

    @Then("Search table contains only list of Responsible Party third-party")
    public void searchTableContainsOnlyListOfResponsiblePartyThirdParty() {
        UserData userData = (UserData) this.context.getScenarioContext().getContext(USER_DATA);
        List<String> apiThirdPartiesList = getFilteredThirdParties(
                getThirdPartyNameFilterRequest(ApiRequestBuilder.SUPPLIER_MANAGER,
                                               ApiRequestBuilder.EQUAL,
                                               userData.getUsername()), SAME_DIVISION, TEN)
                .stream().map(ObjectsItem::getName)
                .collect(toList());
        assertThat(apiThirdPartiesList)
                .as("Search table list is unexpected")
                .containsAll(reportsPage.getStatusReportPageTableValue(DashboardConstants.THIRD_PARTY_NAME));
    }

    @Then("Search result view {string} is {string}")
    public void searchResultViewThirdPartyStatusIs(String fieldName, String expectedResult) {
        assertThat(reportsPage.getThirdPartySearchValue(fieldName))
                .as("Search result view %s value is unexpected", fieldName)
                .isEqualTo(expectedResult);
    }

    @Then("Search result view Workflow information section contains text {string}")
    public void searchResultViewWorkflowInformationSectionContainsText(String expectedText) {
        assertThat(reportsPage.getWorkflowEmptyMessage())
                .as("Search result empty message is unexpected")
                .isEqualTo(expectedText);
    }

    @Then("Search result view {string} with {string} icon is {string}")
    public void searchResultViewWithIconIs(String fieldName, String expectedCircleColor, String expectedValue) {
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(reportsPage.getStatusFieldCircleColor(fieldName))
                .as("Status field circle color is unexpected")
                .isEqualTo(getColorRgba(expectedCircleColor));
        assertThat(reportsPage.getThirdPartySearchValueWithCircle(fieldName))
                .as("Search result view %s value is unexpected", fieldName)
                .isEqualTo(expectedValue);
        softAssertions.assertAll();
    }

    @Then("Search result Wizards block contains expected activities data")
    public void searchResultWizardsBlockContainsExpectedActivitiesData(Map<String, String> expectedData) {
        assertThat(reportsPage.getWizardsBlockData())
                .as("Search result Wizards block doesn't contain expected activities data")
                .isEqualTo(expectedData);
    }

    @Then("Search result Progress bar contains percentage {string}")
    public void searchResultProgressBarContainsPercentage(String expectedPercentage) {
        assertThat(reportsPage.getStatusCompletedPercentage())
                .as("Search result Progress bar contains percentage is unexpected")
                .contains(expectedPercentage);
    }

    @Then("Third-party Status report content is expected")
    public void thirdPartyStatusReportContentIsExpected() {
        SoftAssertions softAssertions = new SoftAssertions();
        List<List<String>> file = readExcelFile(getLastDownloadedFile());
        softAssertions.assertThat(file.get(0))
                .as("Report name is unexpected")
                .contains(THIRD_PARTY_STATUS_SUMMARY_REPORT_NAME);
        softAssertions.assertThat(file.get(1))
                .as("Report columns are unexpected")
                .containsAll(THIRD_PARTY_SUMMARY_COLUMNS);
        softAssertions.assertAll();
    }

    @Then("Third-party Status report contains all searched results")
    public void thirdPartyStatusReportContainsAllSearchedResults() {
        List<String> actualThirdParties = readExcelFile(getLastDownloadedFile()).stream().skip(2).map(row -> row.get(0))
                .filter(value -> !value.isEmpty())
                .collect(toList());
        assertThat(actualThirdParties)
                .as("Search results are unexpected")
                .isEqualTo(reportsPage.getStatusReportThirdParties());

    }

    @Then("Status report completed activity tooltip is {string}")
    public void statusReportCompletedActivityTooltipIs(String expectedText) {
        assertThat(reportsPage.getStatusTooltip())
                .as("Status report completed activity tooltip is unexpected")
                .isEqualTo(expectedText);
    }

    @Then("Risk Area names are showed in tooltips when hover on their icons")
    public void riskAreaNameIsShowedInTooltipWhenHoverOnItsIcon() {
        List<String> expectedNames = AppApi.getRiskCategoriesNameList();
        assertThat(reportsPage.getRiskAreaIconsTooltipsTexts())
                .as("Names shown in tooltip are incorrect")
                .isEqualTo(expectedNames);
    }

    @Then("Bulk Process Type Drop down list is displayed with values")
    public void bulkProcessTypeDropDownListDisplayedWithValues(DataTable dataTable) {
        List<String> expectedOptions = dataTable.asList();
        List<String> actualOptions = reportsPage.getBulkProcessTypeDropDownOptions();
        assertEquals("Bulk Process Type Drop down list is incorrect", expectedOptions, actualOptions);
    }

    @Then("All Reports columns are capitalized")
    public void allReportsColumnsAreCapitalized() {
        List<String> actualResult = reportsPage.getReportTableColumns();
        List<String> expectedCapitalizedColumnName = actualResult.stream()
                .map(String::toUpperCase).collect(toList());
        assertThat(actualResult)
                .as("Report table columns are not capitalized")
                .isEqualTo(expectedCapitalizedColumnName);
    }

    @Then("Report Risk score column displayed one decimal digit")
    public void reportRiskScoreColumnDisplayedOneDecimalDigit() {
        reportsPage.waitWhilePreloadProgressbarIsDisappeared();
        SoftAssertions softAssert = new SoftAssertions();
        reportsPage.getReportTableColumnValues(RISK_SCORE)
                .forEach(riskScore -> softAssert.assertThat(riskScore)
                        .as("Risk Score format is unexpected")
                        .containsPattern(DECIMAL_REGEX));
        softAssert.assertAll();
    }

    @Then("Report table column {string} values {string} are in expected color")
    public void reportTableColumnValuesAreInColor(String columnName, String value) {
        List<String> actualColors = reportsPage.getReportColumnValueColor(columnName, value);
        Map<String, String> riskTierColors = getRiskColors();
        assertThat(actualColors)
                .as("Column %s for %s value colors are unexpected", columnName, value)
                .containsOnly(getColorRgbaFromHex(riskTierColors.get(value)));
    }

    @Then("Report columns are displayed")
    public void reportColumnsAreDisplayed(List<String> expectedColumns) {
        reportsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssertions softAssertions = new SoftAssertions();
        expectedColumns.forEach(column ->
                                        softAssertions.assertThat(reportsPage.isColumnDisplayed(column))
                                                .as("Report column %s is not displayed").isTrue());
        softAssertions.assertAll();
    }

    @Then("Report columns could be checked and unchecked")
    public void reportColumnsCouldBeCheckAndUncheck(List<String> columnsList) {
        SoftAssertions softAssertions = new SoftAssertions();
        columnsList.forEach(column -> {
            reportsPage.clickAgColumnField(CHECKS, column.toUpperCase());
            softAssertions.assertThat(reportsPage.getReportTableColumns())
                    .as("Report table columns are unexpected")
                    .contains(column.toUpperCase());
            reportsPage.clickAgColumnField(UNCHECKS, column.toUpperCase());
            softAssertions.assertThat(reportsPage.getReportTableColumns())
                    .as("Report table columns are unexpected")
                    .doesNotContain(column.toUpperCase());
        });
        softAssertions.assertAll();
    }

    @Then("Static report filter option contains {string}")
    public void staticReportFilterOptionContains(String expectedText) {
        if (expectedText.equals(VALUE_TO_REPLACE)) {
            expectedText = (String) context.getScenarioContext().getContext(VALUE_TO_REPLACE);
        }
        SoftAssertions softAssertions = new SoftAssertions();
        List<String> staticCheckBoxOptions = reportsPage.getStaticCheckBoxOptions();
        for (String option : staticCheckBoxOptions) {
            softAssertions.assertThat(option)
                    .as("Static checkbox option does not contain %s", expectedText)
                    .containsIgnoringCase(expectedText);
        }
        softAssertions.assertAll();
        context.getScenarioContext().setContext(REPORT_FILTER_OPTIONS, staticCheckBoxOptions);
    }

    @Then("Each Report filter option contains clear button")
    public void eachReportFilterOptionContainsClearButton() {
        SoftAssertions softAssertions = new SoftAssertions();
        for (String filterOption : reportsPage.getFilterOptions()) {
            if (reportsPage.isFilterFieldTitleDisplayed(filterOption)) {
                clickAgFilterFieldTitle(filterOption);
                softAssertions.assertThat(reportsPage.isClearButtonDisplayed())
                        .as("Clear button is not displayed for field %s ", filterOption)
                        .isTrue();
                clickAgFilterFieldTitle(filterOption);
            }
        }
        softAssertions.assertAll();
    }

    @Then("Report filter options are displayed")
    public void reportFilterOptionsAreDisplayed(List<String> expectedResult) {
        assertThat(reportsPage.getFilterOptions()).as("Report filter options are unexpected")
                .containsAll(expectedResult);
    }

    @Then("Reports page contains only following tabs")
    public void reportsPageContainsFollowingTabs(DataTable reportsTabs) {
        List<String> expectedResult = reportsTabs.asList();
        assertThat(reportsPage.getReportsTabs())
                .as("Reports tabs are incorrect")
                .isEqualTo(expectedResult);
    }

    @Then("Automatically generated CSV report contains errors on line {int}")
    public void isCSVFileContainListOfErrors(int lineWithErrors, List<String> expectedErrors) {
        SoftAssertions soft = new SoftAssertions();
        List<List<String>> csvFileContent = readCSVFile(getLastDownloadedFile());
        expectedErrors.forEach(error -> {
            if (error.contains(VALUE_TO_REPLACE)) {
                String errorWithCustomFieldName = this.context.getScenarioContext()
                        .getContext(CUSTOM_FIELD_NAME_CONTEXT) + " " + error.split(" ", 2)[1];
                soft.assertThat(csvFileContent.get(lineWithErrors - 1).toString().contains(errorWithCustomFieldName))
                        .as("\"" + errorWithCustomFieldName + "\" is not present in the generated CSV report")
                        .isTrue();
            } else {
                soft.assertThat(csvFileContent.get(lineWithErrors - 1).toString().contains(error))
                        .as("\"" + error + "\" is not present in the generated CSV report")
                        .isTrue();
            }
        });
        soft.assertAll();
    }

}
