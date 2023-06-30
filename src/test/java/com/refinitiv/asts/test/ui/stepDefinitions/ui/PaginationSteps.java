package com.refinitiv.asts.test.ui.stepDefinitions.ui;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.PaginationPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.testng.SkipException;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.ConnectApi.getCountryChecklistsList;
import static com.refinitiv.asts.test.ui.constants.APIConstants.DESC;
import static com.refinitiv.asts.test.ui.constants.APIConstants._ID;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.PAGE_NUMBER;
import static com.refinitiv.asts.test.ui.constants.TestConstants.DISABLED;
import static com.refinitiv.asts.test.ui.constants.TestConstants.VALUE_TO_REPLACE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.*;
import static com.refinitiv.asts.test.ui.utils.PaginationUtil.getCurrentPageSize;
import static com.refinitiv.asts.test.ui.utils.PaginationUtil.getTotalPages;
import static java.lang.Integer.parseInt;
import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class PaginationSteps extends BaseSteps {

    private final PaginationPage paginationPage;
    private int currentPage = 0;
    private String selectedPagination;

    public PaginationSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.paginationPage = new PaginationPage(this.driver, translator, context);
    }

    @When("User selects {string} items per page")
    public void selectItemsPerPage(String paginationOption) {
        selectedPagination = paginationOption;
        paginationPage.waitWhilePreloadProgressbarIsDisappeared();
        if (paginationPage.itemsPerPageDropdownIsDisplayed()) {
            paginationPage.clickItemsPerPage();
            if (paginationOption.equals(MAX)) {
                paginationPage.selectMaxRowsPerPage();
            } else {
                paginationPage.clickItemsPerPageOption(paginationOption);
            }
        }
    }

    @When("User selects {string} items per page or max value")
    public void selectItemsPerPageOrMaxValue(String paginationOption) {
        selectedPagination = paginationOption;
        paginationPage.waitWhilePreloadProgressbarIsDisappeared();
        if (paginationPage.itemsPerPageDropdownIsDisplayed()) {
            paginationPage.clickItemsPerPage();
            if (paginationPage.isItemsPerPageOptionDisplayed(paginationOption)) {
                paginationPage.clickItemsPerPageOption(paginationOption);
            } else {
                paginationPage.selectMaxRowsPerPage();
            }
        }
    }

    @When("User clicks last page icon")
    public void clickLastPageIcon() {
        paginationPage.clickLastPage();
    }

    @When("User clicks {string} {string} pagination element")
    public void clickPaginationElement(String tableType, String pageReference) {
        clickPaginationButton(pageReference);
        if (pageReference.contains("next")) {
            currentPage += 1;
        } else if (pageReference.contains("previous")) {
            currentPage -= 1;
        } else if (pageReference.contains("first")) {
            currentPage = 0;
        } else if (pageReference.contains("last")) {
            currentPage = getTotalPages(paginationPage.getExpectedRowsCount(tableType), DEFAULT_ITEMS_PER_PAGE) - 1;
        }
    }

    @When("User clicks {string} pagination button")
    public void clickPaginationButton(String pageReference) {
        paginationPage.clickPaginationButton(pageReference);
        paginationPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks {string} pagination button if present")
    public void clickPaginationButtonIfPresent(String pageReference) {
        if (paginationPage.isPaginationPagePresent(pageReference)) {
            paginationPage.clickPaginationButton(pageReference);
            paginationPage.waitWhilePreloadProgressbarIsDisappeared();
        }
        context.getScenarioContext().setContext(PAGE_NUMBER, String.valueOf(paginationPage.getCurrentPageNumber()));
    }

    @When("User clicks pagination drop-down")
    public void clickPaginationDropDown() {
        paginationPage.clickItemsPerPage();
    }

    @Then("Pagination option {string} is selected")
    public void paginationOptionIsSelected(String paginationOption) {
        paginationPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(paginationPage.getSelectedPaginationOption())
                .as("Pagination option " + paginationOption + " is not selected")
                .isEqualTo(paginationOption);
    }

    @Then("Pagination option {string} is selected if pagination is displayed")
    public void paginationOptionIsSelectedIfDisplayed(String paginationOption) {
        if (paginationPage.isPaginationDisplayed()) {
            paginationOptionIsSelected(paginationOption);
        }
    }

    @Then("Pagination Drop-Down list is displayed with values")
    public void paginationDropDownListIsDisplayedWithValues(DataTable dataTable) {
        List<String> expectedOptions = dataTable.asList();
        assertThat(expectedOptions)
                .as("Pagination Drop-Down list is not displayed with expected values")
                .containsAll(paginationPage.getDropDownOptions());
        paginationPage.closeDropDownOptions();
    }

    @Then("^Table displayed with up to (\\d+) \"((.*))\" for first page$")
    public void tableDisplayedWithUpToItemsPerPage(int pageSize, String tableType) {
        int expectedSize = getCurrentPageSize(paginationPage.getExpectedRowsCount(tableType), pageSize, 0);
        paginationPage.waitUntilResultsLoaded(expectedSize);
        assertEquals("Table doesn't display up to " + pageSize + " items per page",
                     expectedSize, paginationPage.getTableRowsCount());
    }

    @Then("Rows dropdown contains correct options list for Country Checklist table")
    public void paginationDropdownShouldShowCorrectOption() {
        int expectedNumberOfOptionsValues = 1;
        int allTableRecordsNumber = getCountryChecklistsList(ENORMOUS_ITEMS_PER_PAGE, _ID, DESC).size();
        List<Integer> optionsValuesBiggerOrEqualToTotalRecordsNumber = paginationPage.getDropDownOptions().stream()
                .map(Integer::parseInt)
                .filter(value -> value >= allTableRecordsNumber)
                .collect(Collectors.toList());
        assertThat(optionsValuesBiggerOrEqualToTotalRecordsNumber.size())
                .as("Incorrect pagination dropdown options are shown")
                .isEqualTo(expectedNumberOfOptionsValues);
        paginationPage.closeDropDownOptions();
    }

    @Then("Table displays corresponding to pagination correct rows number")
    public void tableDisplayedCorrectRowsNumber() {
        SoftAssertions soft = new SoftAssertions();
        paginationPage.clickItemsPerPage();
        List<String> dropdownOptions = paginationPage.getDropDownOptions();
        for (String option : dropdownOptions) {
            paginationPage.clickItemsPerPage();
            paginationPage.clickItemsPerPageOption(option);
            soft.assertThat(paginationPage.getSelectedPaginationOption())
                    .as("Pagination option " + option + " is not selected")
                    .isEqualTo(option);
            paginationPage.waitUntilResultsLoaded(parseInt(option));
            soft.assertThat(paginationPage.getTableRowsCount())
                    .as("Table doesn't display up to " + option + " items per page")
                    .isLessThanOrEqualTo(parseInt(option));
        }
        soft.assertAll();
    }

    @Then("Results {string} for current page is displayed")
    public void resultsForPageIsDisplayed(String tableType) {
        int expectedCount =
                getCurrentPageSize(paginationPage.getExpectedRowsCount(tableType), DEFAULT_ITEMS_PER_PAGE, currentPage);
        paginationPage.waitUntilResultsLoaded(paginationPage.getExpectedRowsCount(tableType));
        assertEquals("Table doesn't display All items per page",
                     expectedCount, paginationPage.getTableRowsCount());
    }

    @Then("Pagination buttons should be visible")
    public void paginationButtonsShouldBeVisible(DataTable data) {
        SoftAssert softAssert = new SoftAssert();
        List<String> expectedValues = data.asList();
        if (paginationPage.isPaginationDisplayed()) {
            expectedValues.forEach(button -> softAssert
                    .assertTrue(paginationPage.paginationArrowButtonIsDisplayed(button),
                                "Button '" + button + "' is not visible"));
            softAssert.assertAll();
        }
    }

    @Then("Pagination buttons should be invisible")
    public void paginationButtonsShouldBeInvisible() {
        assertThat(paginationPage.isPaginationDisplayed()).as("Pagination buttons are displayed")
                .isFalse();
    }

    @Then("Up to {int} numbered pages are displayed")
    public void upToNumberedPagesAreDisplayed(int pageCount) {
        assertTrue("Numbered pages is unexpected", paginationPage.getNumberedPagesCount() <= pageCount);
    }

    @Then("Items per page drop-down should be displayed")
    public void checkItemPerPageDropdownIsDisplayed() {
        assertThat(paginationPage.itemsPerPageDropdownIsDisplayed())
                .as("Pagination drop-down is not displayed")
                .isTrue();
    }

    @Then("Table displayed with up to {string} rows")
    public void tableDisplayedWithUpToRows(String pageSize) {
        paginationPage.waitWhilePreloadProgressbarIsDisappeared();
        int actualRowsCount = paginationPage.getTableRowsCount();
        int expectedPageSize;
        if (actualRowsCount > 10) {
            expectedPageSize = parseInt(selectedPagination);
        } else {
            expectedPageSize = parseInt(pageSize);
        }
        assertThat(actualRowsCount).as("Table doesn't display up to " + pageSize + " items per page")
                .isLessThanOrEqualTo(expectedPageSize);
    }

    @Then("Pagination page {string} is currently selected")
    public void paginationPageIsSelected(String pageNumber) {
        if (pageNumber.equals(VALUE_TO_REPLACE)) {
            pageNumber = (String) context.getScenarioContext().getContext(PAGE_NUMBER);
        }
        assertThat(paginationPage.isPaginationPageSelected(pageNumber))
                .as("Current page is not %s", pageNumber)
                .isTrue();
    }

    @Then("^Pagination elements are (disabled|hidden) if table contains less than (\\d+) rows$")
    public void paginationElementsAreDisabledIfTableContainsLessThanRows(String state, int expectedRows) {
        SoftAssertions softAssertions = new SoftAssertions();
        if (paginationPage.getTableRowsCount() == 0) {
            assertThat(paginationPage.isPaginationSectionDisplayed())
                    .as("Pagination section is displayed for empty table")
                    .isFalse();
        } else if (paginationPage.getTableRowsCount() < expectedRows) {
            boolean isInState = state.equals(DISABLED) ?
                    paginationPage.isPaginationDropDownDisabled() && paginationPage.arePaginationButtonsDisabled() :
                    paginationPage.isPaginationDropDownHidden() && paginationPage.arePaginationButtonsHidden();
            softAssertions.assertThat(isInState)
                    .as("Pagination Drop-down and buttons are not %s", state)
                    .isTrue();
        } else {
            softAssertions.assertThat(paginationPage.isPaginationDropDownDisabled())
                    .as("Pagination Drop-down is not enabled")
                    .isFalse();
            softAssertions.assertThat(paginationPage.arePaginationButtonsDisabled())
                    .as("Pagination buttons are not enabled")
                    .isFalse();
        }
        softAssertions.assertAll();
    }

    @Then("Pagination elements are displayed if table contains more than {int} rows")
    public void paginationElementsAreExpected(int expectedRows, List<String> expectedOptions) {
        if (paginationPage.getTableRowsCount() < expectedRows) {
            assertThat(paginationPage.isPaginationSectionDisplayed())
                    .as("Pagination section is displayed for empty table")
                    .isFalse();
        } else {
            paginationPage.clickItemsPerPage();
            assertThat(expectedOptions)
                    .as("Pagination Drop-Down list is not displayed with expected values")
                    .containsAll(paginationPage.getDropDownOptions());
            paginationPage.closeDropDownOptions();
        }
    }

    @Then("Pagination section is displayed")
    public void paginationSectionIsDisplayed() {
        assertThat(paginationPage.isPaginationSectionDisplayed())
                .as("Pagination section is not displayed")
                .isTrue();
    }

    @Then("Skip further steps if pagination hidden or disabled")
    public void skipFurtherStepsIfPaginationHidden() {
        if ((paginationPage.isPaginationDropDownHidden() && paginationPage.arePaginationButtonsHidden()) ||
                paginationPage.getTableRowsCount() < 10) {
            throw new SkipException("Pagination is hidden");
        }
    }

}
