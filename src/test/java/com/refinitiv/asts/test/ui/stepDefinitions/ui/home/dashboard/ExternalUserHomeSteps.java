package com.refinitiv.asts.test.ui.stepDefinitions.ui.home.dashboard;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.DashboardApi;
import com.refinitiv.asts.test.ui.pageActions.home.dashboard.ExternalUserHomePage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.refinitiv.asts.test.ui.constants.APIConstants.END_DATE;
import static com.refinitiv.asts.test.ui.constants.APIConstants.START_DATE;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.USER_DATA;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static org.assertj.core.api.Assertions.assertThat;

public class ExternalUserHomeSteps extends BaseSteps {

    private final String OVERDUE = "Overdue";
    private final String DUE_DAYS = "Due within 5 days";
    private final String DUE_PLUS_DAYS = "Due in 5+ days";

    ExternalUserHomePage homePage;

    public ExternalUserHomeSteps(ScenarioCtxtWrapper context) {
        this.context = context;
        homePage = new ExternalUserHomePage(this.driver);
    }

    @When("User click on {string} widget for External user")
    public void clickOverdueWidget(String widget) {
        switch (widget) {
            case OVERDUE:
                homePage.clickOverdueWidget();
                break;
            case DUE_DAYS:
                homePage.clickWithinFiveDaysWidget();
                break;
            case DUE_PLUS_DAYS:
                homePage.clickFivePlusDaysWidget();
                break;
            default:
                throw new IllegalArgumentException("Unexpected value: " + widget);
        }
    }

    @When("User clicks on My Activities {string} column")
    public void clickOnColumn(String columnName) {
        homePage.clickOnColumn(columnName);
    }

    @When("User click on the first row in My Activities table")
    public void clickOnFirstRow() {
        homePage.waitWhilePreloadProgressbarIsDisappeared();
        homePage.clickOnFirstRow();
    }

    @Then("External User Home tabs is displayed with the following widget")
    public void homeTabsIsDisplayedWithTheFollowingWidget(List<String> expectedWidgets) {
        assertThat(homePage.getDashboardWidgets()).as("Dashboard widgets are unexpected")
                .isEqualTo(expectedWidgets);
    }

    @Then("{string} widget expected activity counter is displayed")
    public void checkOverdueWidgetCounter(String widget) {
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        final String userEmail = userTestData.getUsername();
        long startDate;
        long endDate;
        String actualCounter;
        String expectedCounter;
        Map<String, Long> dates = new HashMap<>();
        int DAYS_IN_PAST_FOR_OVERDUE = 1826;
        int DUE_DAYS_IN_FUTURE = 5;
        switch (widget) {
            case OVERDUE:
                startDate = getDateBeforeInEpoch(DAYS_IN_PAST_FOR_OVERDUE);
                endDate = getCurrentDateInEpoch() - 1000;
                dates.put(END_DATE, endDate);
                dates.put(START_DATE, startDate);
                actualCounter = homePage.getOverdueWidgetCounter();
                break;
            case DUE_DAYS:
                startDate = getCurrentDateInEpoch();
                endDate = getDateAfterInEpoch(DUE_DAYS_IN_FUTURE) - 1000;
                dates.put(END_DATE, endDate);
                dates.put(START_DATE, startDate);
                actualCounter = homePage.getWithinFiveDaysCounter();
                break;
            case DUE_PLUS_DAYS:
                startDate = getDateAfterInEpoch(DUE_DAYS_IN_FUTURE);
                dates.put(START_DATE, startDate);
                actualCounter = homePage.getFivePlusDaysCounter();
                break;
            default:
                throw new IllegalArgumentException("Unexpected value: " + widget);
        }
        expectedCounter = String.valueOf(
                DashboardApi.getExternalAssignedActivities(userEmail, dates).getPayload().getPageInformation()
                        .getTotalRecords());
        assertThat(actualCounter).as("Expected %s counter is not displayed", expectedCounter)
                .isEqualTo(expectedCounter);
    }

    @Then("My Activities table is displayed")
    public void isMyActivitiesTableDisplayed() {
        assertThat(homePage.isMyActivitiesTableDisplayed()).as("My Activities table is not displayed").isTrue();
    }

    @Then("My Activities {string} widget column headers are displayed")
    public void myActivitiesTableIsDisplayedWithColumnNames(String widget, DataTable dataTable) {
        homePage.waitWhilePreloadProgressbarIsDisappeared();
        List<String> actualColumnNames = homePage.getMyActivitiesTableColumnNameList();
        List<String> expectedColumnNames = dataTable.asList();
        assertThat(actualColumnNames).as(
                        "My Activities table is not displayed with expected column names for widget %s", widget)
                .isEqualTo(expectedColumnNames);
    }

    @Then("My Activities table is sorted by {string} column in {string} order")
    public void checkMyActivitiesColumnSorting(String columnName, String order) {
        homePage.waitWhilePreloadProgressbarIsDisappeared();
        List<String> valuesList = homePage.getListValuesForColumn(columnName);
        tableIsSortedByInOrder("My Activities", columnName, order, REACT_FORMAT, valuesList, false);
    }

}
