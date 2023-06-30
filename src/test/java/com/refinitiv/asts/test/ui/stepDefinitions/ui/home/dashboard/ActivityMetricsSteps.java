package com.refinitiv.asts.test.ui.stepDefinitions.ui.home.dashboard;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.SIPublicApi;
import com.refinitiv.asts.test.ui.api.model.activityFilters.ActivityMetricsFiltersRequest;
import com.refinitiv.asts.test.ui.api.model.activityFilters.Filters;
import com.refinitiv.asts.test.ui.api.model.activityFilters.Pagination;
import com.refinitiv.asts.test.ui.api.model.metricsActivities.ActivityItem;
import com.refinitiv.asts.test.ui.api.model.metricsDueDiligence.DueDiligenceItem;
import com.refinitiv.asts.test.ui.api.model.metricsQuestionnaires.QuestionnaireRecords;
import com.refinitiv.asts.test.ui.pageActions.home.dashboard.ActivityMetricsPage;
import com.refinitiv.asts.test.ui.pageActions.home.dashboard.ThirdPartyMetricsPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.utils.DateUtil;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.testng.asserts.SoftAssert;

import java.util.*;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.*;
import static com.refinitiv.asts.test.ui.api.AppApi.EXTERNAL_USER_TYPE;
import static com.refinitiv.asts.test.ui.api.AppApi.INTERNAl_USER_TYPE;
import static com.refinitiv.asts.test.ui.api.DashboardApi.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.API_ACTIVITY_REPORT_TYPE;
import static com.refinitiv.asts.test.ui.constants.DashboardConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.COMPLETED;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.DONE;
import static com.refinitiv.asts.test.ui.constants.Pages.ACTIVITY_METRICS_REPORTS_PAGE;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static java.lang.String.valueOf;
import static java.util.Objects.nonNull;
import static java.util.stream.IntStream.range;
import static org.apache.logging.log4j.util.Strings.isNotEmpty;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertEquals;

public class ActivityMetricsSteps extends BaseSteps {

    public static final String DATE = "DATE";
    public static final String LESS_THAN = "lessThan";
    public static final String GREATER_THAN_OR_EQUAL = "greaterThanOrEqual";
    private static final int DUE_WITHIN_SEVEN_DAYS = 7;
    private static final int DUE_WITHIN_FOURTEEN_DAYS = 14;
    private static final int CURRENT_DATE = 0;
    private static final int ONE = 1;
    private static final int TEN = 10;
    private final ActivityMetricsPage activityMetricsPage;
    private final ThirdPartyMetricsPage thirdPartyMetrics;
    private final Double defaultCompletionsDaysNumber = 0.0;

    public ActivityMetricsSteps(ScenarioCtxtWrapper context) {
        this.context = context;
        activityMetricsPage = new ActivityMetricsPage(this.driver, context);
        thirdPartyMetrics = new ThirdPartyMetricsPage(driver);
    }

    @When("User selects Activity Metrics Tab")
    public void selectActivityMetricsTab() {
        activityMetricsPage.selectActivityMetricsTab();
    }

    @When("User clicks Due Diligence Activity section {string} column value")
    public void clickDueDiligenceActivitySectionColumnValue(String columnName) {
        activityMetricsPage.waitWhilePreloadProgressbarIsDisappeared();
        activityMetricsPage.clickOnDueDiligenceValue(columnName);
    }

    @When("^User clicks (?:All Activities|Questionnaire) section \"(.*)\" row \"(.*)\" column value$")
    public void clickActivitiesSectionColumnValue(String rowName, String columnName) {
        activityMetricsPage.waitWhilePreloadProgressbarIsDisappeared();
        activityMetricsPage.clickOnActivityMetricsTableValue(rowName.toUpperCase(), columnName.toUpperCase());
    }

    @Then("^Click on (All Third-party|My Third-party) Activity Metrics table cells make redirect to reports page$")
    public void checkActivityMetricsClickableCellsDoCorrectRedirect(String option) {
        SoftAssertions soft = new SoftAssertions();
        int cellsNumber = thirdPartyMetrics.getElements(activityMetricsPage.getActivityMetricsClickableCells()).size();
        range(0, cellsNumber).forEach(cell -> {
            activityMetricsPage.navigateToActivityMetricsPage();
            thirdPartyMetrics.selectThirdPartyDropdown(option);
            String cellCount = thirdPartyMetrics.getElementText(
                    thirdPartyMetrics.getElements(activityMetricsPage.getActivityMetricsClickableCells()).get(cell));
            thirdPartyMetrics.getElements(activityMetricsPage.getActivityMetricsClickableCells()).get(cell).click();
            soft.assertThat(driver.getCurrentUrl())
                    .as("Activity Metric cell with count '%s' makes incorrect redirect when clicked", cellCount)
                    .contains(ACTIVITY_METRICS_REPORTS_PAGE);
        });
        soft.assertAll();
    }

    @Then("^Click on (All Third-party|My Third-party) Activity Metrics graphs make redirect to reports page$")
    public void checkActivityMetricsGraphsDoCorrectRedirect(String option) {
        SoftAssertions soft = new SoftAssertions();
        int graphsNumber = thirdPartyMetrics.getElements(activityMetricsPage.getActivityMetricsGraphs()).size();
        range(0, graphsNumber).forEach(graph -> {
            activityMetricsPage.navigateToActivityMetricsPage();
            thirdPartyMetrics.selectThirdPartyDropdown(option);
            thirdPartyMetrics.getElements(activityMetricsPage.getActivityMetricsGraphs()).get(graph).click();
            soft.assertThat(driver.getCurrentUrl())
                    .as("Activity Metric graph makes incorrect redirect when clicked")
                    .contains(ACTIVITY_METRICS_REPORTS_PAGE);
        });
        soft.assertAll();
    }

    @Then("Activity Metrics table is displayed with header column names")
    public void getActivityMetricsHeaderColumns(DataTable dataTable) {
        List<String> actualColumnNames = activityMetricsPage.getActivityMetricsHeaderColumns();
        List<String> expectedColumnNames = dataTable.asList();
        assertEquals("Activity Metrics table is not displayed expected header column names",
                     expectedColumnNames, actualColumnNames);
    }

    @Then("Activity Metrics table is displayed with major column names")
    public void getActivityMetricsMajorColumns(DataTable dataTable) {
        List<String> actualColumnNames = activityMetricsPage.getActivityMetricsMajorColumns();
        List<String> expectedColumnNames = dataTable.asList();
        assertEquals("Activity Metrics table is not displayed expected major column names",
                     expectedColumnNames, actualColumnNames);
    }

    @Then("Activity Metrics table is displayed with minor column names")
    public void getActivityMetricsMinorColumns(DataTable dataTable) {
        List<String> actualColumnNames = activityMetricsPage.getActivityMetricsMinorColumns();
        List<String> expectedColumnNames = dataTable.asList();
        assertEquals("Activity Metrics table is not displayed expected minor column names",
                     expectedColumnNames, actualColumnNames);
    }

    @Then("Activity Metrics update date is correct")
    public void verifyLastUpdatedLabel() {
        String actualDate = activityMetricsPage.getActivityMetricsUpdatedDateLabel();
        assertThat(isDateMatchedWithFormat(actualDate, LAST_UPDATED + ACTIVITY_METRICS_FORMAT))
                .as("Incorrect Last Updated Label")
                .isTrue();
    }

    @Then("Activity Metrics table is displayed with empty results")
    public void activityMetricsTableIsDisplayedWithEmptyResults() {
        activityMetricsPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(activityMetricsPage.areEmptyResultsDisplayed())
                .as("Activity Metrics table is not displayed with empty results")
                .isTrue();
    }

    @Then("Activity Metrics - Average Completion table row should be displayed")
    public void checkActivityMetricsAverageCompletionRowIsDisplayed() {
        activityMetricsPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(activityMetricsPage.isAverageCompletionRowDisplayed())
                .as("'Average Completion' row is not displayed")
                .isTrue();
    }

    @Then("Activity Metrics {string} displayed for following bar charts")
    public void activityMetricsDisplayedForFollowingBarCharts(String expectedMessage, List<String> barChartsList) {
        SoftAssert softAssert = new SoftAssert();
        barChartsList.forEach(barChart -> assertThat(activityMetricsPage.getBarChartText(barChart))
                .as("Activity Metrics %s bar chart doesn't contain text '%s", barChart, expectedMessage)
                .isEqualTo(expectedMessage));
        softAssert.assertAll();
    }

    @Then("Activity Metrics {string} bar chart is displayed")
    public void activityMetricsBarChartIsDisplayed(String barChartsName) {
        assertThat(activityMetricsPage.isBarChartDisplayed(barChartsName))
                .as("Activity Metrics %s bar chart is not displayed", barChartsName)
                .isTrue();
    }

    @Then("Activity metrics shows only activities where user assigned as Responsible Party and share Division with logged in user")
    public void checkIfProperActivitiesAreShown() {
        String apiActivityReportType = (String) context.getScenarioContext().getContext(API_ACTIVITY_REPORT_TYPE);
        List<String> userDivisions = SIPublicApi.getUserDivisions();
        ActivityMetricsFiltersRequest requestBody = getAssignedActivitiesFiltersRequest(apiActivityReportType);
        String activitiesWithSameDivisionsCount =
                valueOf(getActivities(requestBody)
                                .getPayload().getRecords()
                                .stream()
                                .filter(record -> record.getDivision().stream()
                                        .anyMatch(userDivisions::contains)).count());
        assertThat(activityMetricsPage.getAssignedSectionValue(TOTAL_ACTIVE))
                .as("Assigned total activities count is incorrect")
                .isEqualTo(activitiesWithSameDivisionsCount);
    }

    @Then("Activity matrix Questionnaire shows only {string} types")
    public void checkInternalQuestionnaireHasCorrectTypes(String questionnaireType) {
        String apiActivityReportType = (String) context.getScenarioContext().getContext(API_ACTIVITY_REPORT_TYPE);
        ActivityMetricsFiltersRequest questionnaireFiltersRequestBody =
                getQuestionnaireFiltersRequest(questionnaireType, apiActivityReportType);
        List<QuestionnaireRecords> questionnaireRecords =
                getQuestionnaires(questionnaireFiltersRequestBody).getPayload().getRecords();

        boolean areAllQuestionnaireMatchesType = questionnaireRecords
                .stream()
                .allMatch(questionnaire -> questionnaire.getQuestionnaireType().equals(questionnaireType));

        assertThat(areAllQuestionnaireMatchesType)
                .as("Not all questionnaires are of type - " + questionnaireType)
                .isTrue();
    }

    @Then("All Activities are assigned to Assignee and not yet Done or Completed")
    public void checkAllActivitiesHasCorrectAssignee() {
        SoftAssertions soft = new SoftAssertions();
        int expectedCompletedActivities = 0;
        String apiActivityReportType = (String) context.getScenarioContext().getContext(API_ACTIVITY_REPORT_TYPE);
        ActivityMetricsFiltersRequest assignedActivitiesFiltersRequestBody =
                getAssignedActivitiesFiltersRequest(apiActivityReportType);
        List<ActivityItem> activityRecords =
                getActivities(assignedActivitiesFiltersRequestBody).getPayload().getRecords();

        List<ActivityItem> activitiesWithAssignee = activityRecords
                .stream()
                .filter(record -> isNotEmpty(record.getAssignee()))
                .collect(Collectors.toList());

        List<ActivityItem> completedActivities = activityRecords
                .stream()
                .filter(record -> record.getStatus().equals(DONE) || record.getStatus().equals(COMPLETED))
                .collect(Collectors.toList());

        soft.assertThat(completedActivities.size())
                .as("Some Activities are not in 'Done' or 'Completed' status")
                .isEqualTo(expectedCompletedActivities);

        soft.assertThat(activityMetricsPage.getAssignedSectionValue(TOTAL_ACTIVE))
                .as("Assigned total activities count is incorrect")
                .isEqualTo(valueOf(activitiesWithAssignee.size()));
        soft.assertAll();
    }

    @Then("{string} group {string} displays correct count")
    public void checkActivityMetricsCount(String activitiesMatrixColumn, String activitiesMatrixRow) {
        String apiActivityReportType = (String) context.getScenarioContext().getContext(API_ACTIVITY_REPORT_TYPE);
        switch (activitiesMatrixColumn) {
            case ALL_ACTIVITIES:
                checkActivityMatrixCellsCounts(activitiesMatrixColumn, activitiesMatrixRow, null);
            case ASSIGNED_ACTIVITIES_SECTION:
                ActivityMetricsFiltersRequest assignedActivitiesFiltersRequestBody =
                        getAssignedActivitiesFiltersRequest(apiActivityReportType);
                checkActivityMatrixCellsCounts(activitiesMatrixColumn, activitiesMatrixRow,
                                               assignedActivitiesFiltersRequestBody);
                break;
            case APPROVAL_ACTIVITIES_SECTION:
                ActivityMetricsFiltersRequest approvalsActivitiesFiltersRequestBody =
                        getApprovalsActivitiesFiltersRequest(apiActivityReportType);
                checkActivityMatrixCellsCounts(activitiesMatrixColumn, activitiesMatrixRow,
                                               approvalsActivitiesFiltersRequestBody);
                break;
            case REVIEWS_ACTIVITIES_SECTION:
                ActivityMetricsFiltersRequest reviewsActivitiesFiltersRequestBody =
                        getReviewsActivitiesFiltersRequest(apiActivityReportType);
                checkActivityMatrixCellsCounts(activitiesMatrixColumn, activitiesMatrixRow,
                                               reviewsActivitiesFiltersRequestBody);
                break;
            case INTERNAL_QUESTIONNAIRES_SECTION:
                ActivityMetricsFiltersRequest internalQuestionnaireFiltersRequestBody =
                        getQuestionnaireFiltersRequest(INTERNAl_USER_TYPE.toUpperCase(), apiActivityReportType);
                checkQuestionnaireMatrixCellsCounts(activitiesMatrixColumn, activitiesMatrixRow,
                                                    internalQuestionnaireFiltersRequestBody);
                break;
            case EXTERNAL_QUESTIONNAIRES_SECTION:
                ActivityMetricsFiltersRequest externalQuestionnaireFiltersRequestBody =
                        getQuestionnaireFiltersRequest(EXTERNAL_USER_TYPE.toUpperCase(), apiActivityReportType);
                checkQuestionnaireMatrixCellsCounts(activitiesMatrixColumn, activitiesMatrixRow,
                                                    externalQuestionnaireFiltersRequestBody);
                break;
            case DUE_DILIGENCE_REPORTS_SECTION:
                ActivityMetricsFiltersRequest dueDiligenceFiltersRequestBody =
                        getDueDiligenceFiltersRequest(apiActivityReportType);
                checkDueDiligenceReportsMatrixCellsCounts(activitiesMatrixColumn, activitiesMatrixRow,
                                                          dueDiligenceFiltersRequestBody);
                break;
            default:
                throw new IllegalArgumentException("Illegal Activity matrix column name - " + activitiesMatrixColumn);
        }

    }

    private void checkActivityMatrixCellsCounts(String activitiesMatrixColumn, String activitiesMatrixRow,
            ActivityMetricsFiltersRequest requestBody) {
        String apiActivityReportType = (String) context.getScenarioContext().getContext(API_ACTIVITY_REPORT_TYPE);
        List<ActivityItem> activitiesRecords = new ArrayList<>();
        if (nonNull(requestBody)) {
            activitiesRecords = getActivities(requestBody).getPayload().getRecords();
        }
        List<ActivityItem> filteredActivities;
        String activityMatrixValue =
                activityMetricsPage.getActivityMatrixValue(activitiesMatrixRow, activitiesMatrixColumn);
        switch (activitiesMatrixRow) {
            case TOTAL_ACTIVE:
                filteredActivities = activitiesRecords
                        .stream()
                        .filter(record -> isNotEmpty(record.getAssignee()))
                        .collect(Collectors.toList());
                assertThat(activityMatrixValue)
                        .as("Assigned 'Total Activity' count is incorrect")
                        .isEqualTo(valueOf(filteredActivities.size()));
                break;
            case PAST_DUE:
                filteredActivities = activitiesRecords
                        .stream()
                        .filter(record -> DateUtil.getDaysDifferenceWithCurrentDate(record.getDueDate()) < CURRENT_DATE)
                        .collect(Collectors.toList());
                assertThat(activityMatrixValue)
                        .as("Assigned 'Past Due' activities count is incorrect")
                        .isEqualTo(valueOf(filteredActivities.size()));
                break;
            case DUE_7:
                filteredActivities = activitiesRecords
                        .stream()
                        .filter(record -> getDaysDifferenceWithCurrentDate(record.getDueDate()) >= CURRENT_DATE &&
                                getDaysDifferenceWithCurrentDate(record.getDueDate()) < DUE_WITHIN_SEVEN_DAYS)
                        .collect(Collectors.toList());
                assertThat(activityMatrixValue)
                        .as("Assigned 'Due within 7 days' activities count is incorrect")
                        .isEqualTo(valueOf(filteredActivities.size()));
                break;
            case DUE_14:
                filteredActivities = activitiesRecords
                        .stream()
                        .filter(record ->
                                        getDaysDifferenceWithCurrentDate(record.getDueDate()) >=
                                                DUE_WITHIN_SEVEN_DAYS &&
                                                getDaysDifferenceWithCurrentDate(record.getDueDate()) <
                                                        DUE_WITHIN_FOURTEEN_DAYS)
                        .collect(Collectors.toList());
                assertThat(activityMatrixValue)
                        .as("Assigned 'Due within 7 to 14 days' activities count is incorrect")
                        .isEqualTo(valueOf(filteredActivities.size()));
                break;
            case AVERAGE_COMPLETION:
                ActivityMetricsFiltersRequest assignedBody = getAssignedActivitiesFiltersRequest(apiActivityReportType);
                ActivityMetricsFiltersRequest approvalsBody =
                        getApprovalsActivitiesFiltersRequest(apiActivityReportType);
                ActivityMetricsFiltersRequest reviewsBody = getReviewsActivitiesFiltersRequest(apiActivityReportType);
                double averageAssignedCompletionTime =
                        activityMetricsPage.getActivityCompletionTimeAverageValue(assignedBody);
                double approvalAssignedCompletionTime =
                        activityMetricsPage.getActivityCompletionTimeAverageValue(approvalsBody);
                double reviewsAssignedCompletionTime =
                        activityMetricsPage.getActivityCompletionTimeAverageValue(reviewsBody);
                double allActivitiesCompletionTimeAverageValue =
                        (averageAssignedCompletionTime + approvalAssignedCompletionTime +
                                reviewsAssignedCompletionTime) / 3;
                assertThat(activityMatrixValue).as("All Activities Completion Time Average value is incorrect")
                        .isEqualTo(valueOf((int) allActivitiesCompletionTimeAverageValue));
                break;
            default:
                throw new IllegalArgumentException("Incorrect activity group was passed - " + activitiesMatrixRow);
        }
    }

    private void checkQuestionnaireMatrixCellsCounts(String activitiesMatrixColumn, String activitiesMatrixRow,
            ActivityMetricsFiltersRequest requestBody) {
        int expectedValue;
        switch (activitiesMatrixRow) {
            case TOTAL_ACTIVE:
                expectedValue = getQuestionnaires(
                        requestBody.setPagination(new Pagination().setCurrentPage(ONE).setLimit(TEN))).getPayload()
                        .getPageInformation().getTotalRecords();
                break;
            case PAST_DUE:
                Filters.DueDate dueDate = new Filters.DueDate().setDateFrom(getCurrentDateInEpoch())
                        .setFilterType(DATE)
                        .setType(LESS_THAN);
                requestBody.setFilters(requestBody.getFilters().setDueDate(dueDate))
                        .setPagination(new Pagination().setCurrentPage(ONE).setLimit(TEN));
                expectedValue = getQuestionnaires(requestBody).getPayload().getPageInformation().getTotalRecords();
                break;
            case DUE_7:
                dueDate = new Filters.DueDate()
                        .setCondition1(new Filters.DueDate().setType(GREATER_THAN_OR_EQUAL).setFilterType(DATE)
                                               .setDateFrom(getCurrentDateInEpoch()))
                        .setCondition2(new Filters.DueDate().setType(LESS_THAN).setFilterType(DATE)
                                               .setDateFrom(getDateAfterInEpoch(7)))
                        .setFilterType(DATE)
                        .setOperator(AND);
                requestBody.setFilters(requestBody.getFilters().setDueDate(dueDate))
                        .setPagination(new Pagination().setCurrentPage(ONE).setLimit(TEN));
                expectedValue = getQuestionnaires(requestBody).getPayload().getPageInformation().getTotalRecords();
                break;
            case DUE_14:
                dueDate = new Filters.DueDate()
                        .setCondition1(new Filters.DueDate().setType(GREATER_THAN_OR_EQUAL).setFilterType(DATE)
                                               .setDateFrom(getDateAfterInEpoch(DUE_WITHIN_SEVEN_DAYS)))
                        .setCondition2(new Filters.DueDate().setType(LESS_THAN).setFilterType(DATE)
                                               .setDateFrom(getDateAfterInEpoch(DUE_WITHIN_FOURTEEN_DAYS)))
                        .setFilterType(DATE)
                        .setOperator(AND);
                requestBody.setFilters(requestBody.getFilters().setDueDate(dueDate))
                        .setPagination(new Pagination().setCurrentPage(ONE).setLimit(TEN));
                expectedValue = getQuestionnaires(requestBody).getPayload().getPageInformation().getTotalRecords();
                break;
            case AVERAGE_COMPLETION:
                double averageDdrCompletionTime = defaultCompletionsDaysNumber;
                try {
                    averageDdrCompletionTime = getQuestionnaires(requestBody).getPayload().getRecords().stream()
                            .filter(record -> nonNull(record.getCompletionTime()))
                            .mapToDouble(QuestionnaireRecords::getCompletionTime).average().getAsDouble();
                } catch (NoSuchElementException ignored) {
                }
                expectedValue = (int) averageDdrCompletionTime;
                break;
            default:
                throw new IllegalArgumentException("Incorrect activity group was passed - " + activitiesMatrixRow);
        }
        assertThat(activityMetricsPage.getActivityMatrixValue(activitiesMatrixRow, activitiesMatrixColumn))
                .as("%s column %s row value is unexpected", activitiesMatrixColumn, activitiesMatrixRow)
                .isEqualTo(valueOf(expectedValue));
    }

    private void checkDueDiligenceReportsMatrixCellsCounts(String activitiesMatrixColumn, String activitiesMatrixRow,
            ActivityMetricsFiltersRequest requestBody) {
        int expectedValue;
        switch (activitiesMatrixRow) {
            case TOTAL_ACTIVE:
                expectedValue = getDueDiligence(requestBody).getPayload().getRecords().size();
                break;
            case PAST_DUE:
                Filters.DueDate dueDate = new Filters.DueDate().setDateFrom(getCurrentDateInEpoch())
                        .setFilterType(DATE)
                        .setType(LESS_THAN);
                requestBody.setFilters(requestBody.getFilters().setDueDate(dueDate));
                expectedValue = getDueDiligence(requestBody).getPayload().getRecords().size();
                break;
            case DUE_7:
                dueDate = new Filters.DueDate()
                        .setCondition1(new Filters.DueDate().setType(GREATER_THAN_OR_EQUAL).setFilterType(DATE)
                                               .setDateFrom(getCurrentDateInEpoch()))
                        .setCondition2(new Filters.DueDate().setType(LESS_THAN).setFilterType(DATE)
                                               .setDateFrom(getDateAfterInEpoch(7)))
                        .setFilterType(DATE)
                        .setOperator(AND);
                requestBody.setFilters(requestBody.getFilters().setDueDate(dueDate));
                expectedValue = getDueDiligence(requestBody).getPayload().getRecords().size();
                break;
            case DUE_14:
                dueDate = new Filters.DueDate()
                        .setCondition1(new Filters.DueDate().setType(GREATER_THAN_OR_EQUAL).setFilterType(DATE)
                                               .setDateFrom(getDateAfterInEpoch(DUE_WITHIN_SEVEN_DAYS)))
                        .setCondition2(new Filters.DueDate().setType(LESS_THAN).setFilterType(DATE)
                                               .setDateFrom(getDateAfterInEpoch(DUE_WITHIN_FOURTEEN_DAYS)))
                        .setFilterType(DATE)
                        .setOperator(AND);
                requestBody.setFilters(requestBody.getFilters().setDueDate(dueDate));
                expectedValue = getDueDiligence(requestBody).getPayload().getRecords().size();
                break;
            case AVERAGE_COMPLETION:
                double averageDdrCompletionTime = defaultCompletionsDaysNumber;
                try {
                    averageDdrCompletionTime = getDueDiligence(requestBody).getPayload().getRecords().stream()
                            .filter(record -> nonNull(record.getCompletionTime()))
                            .mapToDouble(DueDiligenceItem::getCompletionTime).average().getAsDouble();
                } catch (NoSuchElementException ignored) {
                }
                expectedValue = (int) averageDdrCompletionTime;
                break;
            default:
                throw new IllegalArgumentException("Incorrect matrix group name was passed - " + activitiesMatrixRow);
        }
        assertThat(activityMetricsPage.getActivityMatrixValue(activitiesMatrixRow, activitiesMatrixColumn))
                .as("%s column %s row value is unexpected", activitiesMatrixColumn, activitiesMatrixRow)
                .isEqualTo(valueOf(expectedValue));
    }

}
