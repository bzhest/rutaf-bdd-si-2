package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.AdvanceSearchPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.ThirdPartyOverviewPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.AdvanceSearchResultsData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ThirdPartyData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.ADVANCE_SEARCH_RESULTS;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_DATA_CONTEXT;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.REACT_FORMAT;
import static com.refinitiv.asts.test.utils.FileUtil.getLastDownloadedFile;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertTrue;

public class AdvanceSearchSteps extends BaseSteps {

    private final AdvanceSearchPage advanceSearchPage;
    private final ThirdPartyOverviewPage thirdPartyOverviewPage;

    private final String PRESENT = "present";

    public AdvanceSearchSteps(ScenarioCtxtWrapper context) {
        super(context);
        advanceSearchPage = new AdvanceSearchPage(this.driver, this.context);
        thirdPartyOverviewPage = new ThirdPartyOverviewPage(this.driver, this.context);
    }

    @When("^User adds search criteria parameter - (.*), value - (.*) on (\\d+)(?:st|nd|rd|th) line$")
    public void enterParameterAndValueForLine(String parameter, String value, int lineNumber) {
        advanceSearchPage.selectSearchCriteriaParameter(parameter, lineNumber);
        advanceSearchPage.selectSearchCriteriaValue(value, lineNumber);
    }

    @When("^User adds search parameter - (.*) on (\\d+)(?:st|nd|rd|th) line$")
    public void enterParameterForLine(String parameter, int lineNumber) {
        advanceSearchPage.selectSearchCriteriaParameter(parameter, lineNumber);
    }

    @When("^User adds search value - (.*) on (\\d+)(?:st|nd|rd|th) line$")
    public void enterValueForLine(String value, int lineNumber) {
        advanceSearchPage.selectSearchCriteriaValue(value, lineNumber);
    }

    @When("User fills search value field with previously created Third-party name on line {int}")
    public void enterCreatedThirdPartyNameInValueField(int lineNumber) {
        advanceSearchPage.fillValueFieldWithCreatedThirdPartyName(lineNumber);
    }

    @When("User clicks 'Add' new parameter button")
    public void clickAddNewParameterButton() {
        advanceSearchPage.clickAddButton();
    }

    @When("^User selects (All|Any) value in 'Search for Third-party Match' dropdown$")
    public void selectSearchFilterValue(String value) {
        advanceSearchPage.expandDropdownFilter();
        advanceSearchPage.selectFilterValue(value);
    }

    @When("User clicks 'Search' button on Advance Search screen")
    public void clickSearchButton() {
        advanceSearchPage.clickSearchButton();
    }

    @When("User clicks 'Search' button on Advance Search screen without waiter")
    public void clickSearchButtonWithoutWaiter() {
        advanceSearchPage.clickSearchButtonWithoutWaiter();
    }

    @When("User clicks 'Clear Search' button")
    public void clickClearSearchButton() {
        advanceSearchPage.clickClearSearchButton();
    }

    @When("^User clicks 'Delete' button for (\\d*)(?:st|nd) line$")
    public void clickDeleteButtonForLine(int lineNumber) {
        advanceSearchPage.clickDeleteButton(lineNumber);
    }

    @When("User clicks Export to Excel button")
    public void clickExportToExcel() {
        advanceSearchPage.clickExportToExcel();
    }

    @When("User clicks on first found third-party in advance search results")
    public void clickOnFirstFoundSupplier() {
        advanceSearchPage.clickOnFirstFoundSupplier();
    }

    @When("User waits for 'Advance Search' page to load")
    public void advanceSearchPageIsLoaded() {
        advanceSearchPage.waitSearchPageIsLoaded();
    }

    @When("User clears search value field on line {int}")
    public void clearValueField(int lineNumber) {
        advanceSearchPage.clearValueField(lineNumber);
    }

    @Then("User saves Advanced Search Results to context")
    public void saveResultsToContext() {
        AdvanceSearchResultsData results = advanceSearchPage.getAllResultsValuesList();
        context.getScenarioContext().setContext(ADVANCE_SEARCH_RESULTS, results);
    }

    @Then("User should be able to see new label {string} of Screening Status as {string} {string} in AdvanceSearch")
    public void getScreeningStatus(String label, String columnName, String status) {
        thirdPartyOverviewPage.navigateToAdvanceSearch();
        advanceSearchPage.selectSearchCriteriaParameter(columnName, 1);
        advanceSearchPage.selectSearchCriteriaValue(status, 1);
        advanceSearchPage.clickSearchButton();
        assertTrue("New label: " + label + " is not displayed",
                   advanceSearchPage.isColumnScreeningStatusDisplayed(label));
    }

    @Then("'Clear Search' button is appeared")
    public void clearSearchButtonIsAppeared() {
        assertThat(advanceSearchPage.isClearSearchButtonPresent())
                .as("'Clear Search' button isn't appeared")
                .isTrue();
    }

    @Then("'Advance Search' results table contains countries")
    public void searchResultsContainsCountries(DataTable countries) {
        List<String> expectedCountries = countries.asList();
        AdvanceSearchResultsData advanceSearchResultsData = advanceSearchPage.getAllResultsValuesList();
        List<String> foundCountries = advanceSearchResultsData.getResultsList()
                .stream()
                .map(AdvanceSearchResultsData.ResultLine::getCountry)
                .collect(Collectors.toList());
        if (countries.asList().get(0).equals(VALUE_TO_REPLACE)) {
            advanceSearchResultsData =
                    (AdvanceSearchResultsData) context.getScenarioContext().getContext(ADVANCE_SEARCH_RESULTS);
            expectedCountries = advanceSearchResultsData.getResultsList().stream()
                    .map(AdvanceSearchResultsData.ResultLine::getCountry)
                    .collect(Collectors.toList());
        }
        if (advanceSearchPage.isNoDataFound()) {
            assertThat(foundCountries.size())
                    .as("Search results are not empty")
                    .isZero();
            assertThat(advanceSearchPage.getNoRecordsFoundText())
                    .as("Text of 'no records found' is incorrect")
                    .isEqualTo(countries.asList().get(0));
        } else {
            assertThat(expectedCountries.stream().anyMatch(foundCountries::contains))
                    .as("One or more countries aren't found in results table")
                    .isTrue();
        }
        context.getScenarioContext().setContext(ADVANCE_SEARCH_RESULTS, advanceSearchResultsData);
    }

    @Then("^Line with parameter - (.*) and value - (.*) is (present|not present)$")
    public void lineWithParameterAndValueIsPresent(String parameter, String value, String visibility) {
        advanceSearchPage.waitSearchPageIsLoaded();
        boolean isPresent = visibility.equals(PRESENT);
        String empty = "EMPTY";
        assertThat(advanceSearchPage.isLinePresent(
                parameter.equals(empty) ? StringUtils.EMPTY : parameter,
                value.equals(empty) ? StringUtils.EMPTY : value))
                .as("Line with parameter " + parameter + " and value " + value + " is not " + visibility)
                .isEqualTo(isPresent);
    }

    @Then("^'Search for Third-party Match' dropdown is present with selected value (Any|All)$")
    public void isSearchDropdownFilterPresent(String value) {
        assertThat(advanceSearchPage.isDropdownFilterPresent())
                .as("Search filter dropdown isn't present")
                .isTrue();
        assertThat(advanceSearchPage.getFilterSelectedValue())
                .as("Selected filter value is not " + value)
                .isEqualTo(value);
    }

    @Then("^'Search for Third-party Match' dropdown has only values to select$")
    public void onlyAllAndAnyValuesAreInDropdown(DataTable dataTable) {
        advanceSearchPage.expandDropdownFilter();
        assertThat(advanceSearchPage.getDropdownFilterValues())
                .as("Values are not present in dropdown")
                .containsAll(dataTable.asList());
        advanceSearchPage.clickOnBlankArea();
    }

    @Then("^(Add|Search) filter button is (ENABLED|DISABLED)$")
    public void addButtonIsEnabled(String buttonName, String buttonStatus) {
        boolean isEnabled = buttonStatus.equals(ENABLED.toUpperCase());
        switch (buttonName) {
            case ADD:
                assertThat(advanceSearchPage.isAddButtonEnabled(isEnabled))
                        .as(buttonName + " button is not " + buttonStatus)
                        .isTrue();
                break;
            case SEARCH:
                assertThat(advanceSearchPage.isSearchButtonEnabled(isEnabled))
                        .as(buttonName + " button is not " + buttonStatus)
                        .isTrue();
                break;
            default:
                throw new IllegalArgumentException(buttonName + " button is not found");
        }
    }

    @Then("^'Delete' button is (visible|not visible) for (\\d*)(?:st|nd) filter line$")
    public void deleteButtonIsVisible(String visibility, int lineNumber) {
        boolean isVisible = visibility.equals(VISIBLE);
        assertThat(advanceSearchPage.isDeleteIconPresent(lineNumber, isVisible))
                .as("'Delete button is not " + visibility)
                .isTrue();
    }

    @Then("^Export to Excel button is (present|hidden)")
    public void exportToExcelButtonIsPresent(String buttonStatus) {
        boolean shouldBePresent = buttonStatus.equals(PRESENT);
        assertThat(advanceSearchPage.isExportToExcelButtonPresent())
                .as("Export to Excel button is not " + buttonStatus)
                .isEqualTo(shouldBePresent);
    }

    @Then("CSV file contains expected values")
    public void CSVFileContainsValues() {
        AdvanceSearchResultsData expectedValues =
                (AdvanceSearchResultsData) context.getScenarioContext().getContext(ADVANCE_SEARCH_RESULTS);
        AdvanceSearchResultsData actualValues = advanceSearchPage.getAdvanceSearchResultsFromCSV(getLastDownloadedFile());
        assertThat(actualValues.getResultsList())
                .as("File not found or isn't equal to expected one")
                .usingRecursiveComparison()
                .isEqualTo(expectedValues.getResultsList());
    }

    @Then("^\"((.*))\" column is (displayed|not displayed) in the 'Third-party Advanced Search' result table$")
    public void isAdvancedSearchTableColumnDisplayed(String columnName, String state) {
        advanceSearchPage.waitSearchPageIsLoaded();
        if (state.contains(NOT)) {
            assertThat(advanceSearchPage.isAdvancedSearchTableColumnDisplayed(columnName))
                    .as(columnName + "column is displayed in the 'Third-party Advanced Search' result table")
                    .isFalse();
        } else {
            assertThat(advanceSearchPage.isAdvancedSearchTableColumnDisplayed(columnName))
                    .as(columnName + "column is not displayed in the 'Third-party Advanced Search' result table")
                    .isTrue();
        }
    }

    @Then("Advanced search result table is sorted by {string} in {string} order")
    public void myOrganisationTableIsSortedByInOrder(String columnName, String sortOrder) {
        List<String> valuesList = advanceSearchPage.getListValuesForColumn(columnName.toUpperCase());
        tableIsSortedByInOrder("Advanced Search", columnName, sortOrder, REACT_FORMAT, valuesList, false);
    }

    @Then("^Previously created Third-party is (displayed|not displayed) in the Advanced Search table$")
    public void isCreatedThirdPartyPresentInTable(String state) {
        if (state.contains(NOT)) {
            assertThat(advanceSearchPage.isCreatedThirdPartyPresentInTable())
                    .as("Created Third-party is displayed in the Advanced Search table")
                    .isFalse();
        } else {
            assertThat(advanceSearchPage.isCreatedThirdPartyPresentInTable())
                    .as("Created Third-party is not displayed in the Advanced Search table")
                    .isTrue();
        }
    }

    @Then("{int} previously created Third-parties with similar names is displayed in the Advanced Search table")
    public void severalThirdPartiesWithSimilarNameArePresentInTable(int expectedCount) {
        ThirdPartyData thirdPartyData = (ThirdPartyData) this.context.getScenarioContext()
                .getContext(THIRD_PARTY_DATA_CONTEXT);
        List<String> thirdPartyNamesPresentedInTable = advanceSearchPage.getListValuesForColumn(THIRD_PARTY_NAME_HEADER);
        long actualCount = thirdPartyNamesPresentedInTable.stream()
                .filter(name -> name.equals(thirdPartyData.getName())).count();
        assertThat(actualCount)
                .as("Searched Third-parties count is unexpected")
                .isEqualTo(expectedCount);

    }

}
