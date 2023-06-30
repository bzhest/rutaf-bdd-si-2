package com.refinitiv.asts.test.ui.stepDefinitions.ui.myExports;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.myExports.MyExportsPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.CSV_FULL_FILE_NAME;
import static com.refinitiv.asts.test.ui.pageActions.myExports.MyExportsPage.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static java.lang.String.format;
import static org.assertj.core.api.Assertions.assertThat;

public class MyExportsSteps extends BaseSteps {

    private final MyExportsPage myExportsPage;

    public MyExportsSteps(ScenarioCtxtWrapper context) {
        super(context);
        myExportsPage = new MyExportsPage(this.driver);
    }

    @When("User navigates to My Exports page")
    public void navigateToMyExportsPage() {
        myExportsPage.navigateToMyExportsPage();
    }

    @When("User clicks file with name {string} and date format {string}")
    public void clickFileWithNameAndDateFormat(String name, String date) {
        String expectedFullFileName = context.getScenarioContext().isContains(CSV_FULL_FILE_NAME)
                ? (String) context.getScenarioContext().getContext(CSV_FULL_FILE_NAME)
                : format(name, getTodayDate(date));
        myExportsPage.clickFileLink(expectedFullFileName);
    }

    @When("User clicks My Export table {string} column")
    public void clickMyExportTableColumn(String columnName) {
        myExportsPage.clickColumnName(columnName);
    }

    @Then("My Exports table contains file with name {string} and date format {string}")
    public void myExportsTableContainsFileWithNameAndDateFormat(String name, String date) {
        myExportsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String expectedFullFileName = format(name, getTodayDate(date));
        context.getScenarioContext().setContext(CSV_FULL_FILE_NAME, expectedFullFileName);
        assertThat(myExportsPage.isFileLinkDisplayed(expectedFullFileName))
                .as("My Export table does not contain %s", expectedFullFileName)
                .isTrue();
    }

    @Then("My Exports table contains columns")
    public void myExportsTableContainsColumns(DataTable expectedColumns) {
        assertThat(myExportsPage.getColumns()).as("My Exports table columns are unexpected")
                .isEqualTo(expectedColumns.asList());
    }

    @Then("My Export date columns contains format {string}")
    public void myExportDateColumnsContainsFormat(String expectedFormat, List<String> columns) {
        SoftAssertions softAssert = new SoftAssertions();
        columns.forEach(column -> {
            List<String> columnValues = myExportsPage.getListValuesForColumn(column);
            softAssert.assertThat(
                            columnValues.stream().allMatch(value -> isDateMatchedWithFormat(value, expectedFormat)))
                    .as("%s column date format is unexpected", column)
                    .isTrue();
        });
        softAssert.assertAll();
    }

    @Then("My Export Status column contains values")
    public void myExportStatusColumnContainsValues(List<String> expectedStatuses) {
        assertThat(myExportsPage.getListValuesForColumn(STATUS))
                .as("Status column values are unexpected")
                .containsAnyElementsOf(expectedStatuses);
    }

    @Then("My Export Summary column contains expected value for status")
    public void myExportSummaryColumnContainsExpectedValueForStatus(List<String> statuses) {
        SoftAssertions softAssert = new SoftAssertions();
        statuses.forEach(status -> {
            List<String> columnValuesForStatus = myExportsPage.getListSummaryForColumnWithStatus(status);
            if (status.equals(COMPLETED) && !columnValuesForStatus.isEmpty()) {
                softAssert.assertThat(columnValuesForStatus.stream().allMatch(myExportsPage::isValueContainsInteger))
                        .as("Status %s values are unexpected", status)
                        .isTrue();
            } else if (status.equals(FAILED) && !columnValuesForStatus.isEmpty()) {
                softAssert.assertThat(columnValuesForStatus.stream().allMatch(myExportsPage::isValueContainsInteger))
                        .as("Status %s values are unexpected", status)
                        .isFalse();
            }
        });
        softAssert.assertAll();
    }

    @Then("My Export page contains message {string}")
    public void myExportPageContainsMessage(String expectedMessage) {
        assertThat(myExportsPage.getMessage())
                .as("My Export page message is unexpected")
                .isEqualTo(expectedMessage);
    }

    @Then("{string} table records sorted by {string} column in {string} order")
    public void tableRecordsSortedByColumnInOrder(String tableName, String columnName, String sortOrder) {
        myExportsPage.waitWhilePreloadProgressbarIsDisappeared();
        List<String> valuesList = myExportsPage.getListValuesForColumn(columnName);
        tableIsSortedByInOrder(tableName, columnName, sortOrder, EXPORT_DATE_FORMAT, valuesList, true);
    }

}
