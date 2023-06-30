package com.refinitiv.asts.test.ui.stepDefinitions.ui.home.dashboard;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.dashboard.OnboardingMatrixResponse;
import com.refinitiv.asts.test.ui.api.model.dashboard.RenewalMatrixResponse;
import com.refinitiv.asts.test.ui.constants.DashboardConstants;
import com.refinitiv.asts.test.ui.pageActions.home.dashboard.ThirdPartyMetricsPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang3.StringUtils;
import org.assertj.core.api.SoftAssertions;
import org.testng.asserts.SoftAssert;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import static com.refinitiv.asts.test.ui.api.DashboardApi.getOnboardingMatrix;
import static com.refinitiv.asts.test.ui.api.DashboardApi.getRenewalMatrix;
import static com.refinitiv.asts.test.ui.constants.APIConstants.ALL_ACTIVITIES_TYPE;
import static com.refinitiv.asts.test.ui.constants.APIConstants.MY_ACTIVITIES_TYPE;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.API_ACTIVITY_REPORT_TYPE;
import static com.refinitiv.asts.test.ui.constants.DashboardConstants.ALL_THIRD_PARTY;
import static com.refinitiv.asts.test.ui.constants.DashboardConstants.LAST_UPDATED;
import static com.refinitiv.asts.test.ui.enums.Colors.getColorRgbaFromHex;
import static com.refinitiv.asts.test.ui.utils.DateUtil.ACTIVITY_METRICS_FORMAT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.isDateMatchedWithFormat;
import static java.lang.Double.parseDouble;
import static java.lang.Integer.parseInt;
import static java.lang.String.format;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertEquals;

public class ThirdPartyMetricsSteps extends BaseSteps {

    private static final String MED_COLUMN = "Med";
    private static final String MEDIUM = "Medium";
    private static final String LONGEST = "LONGEST";
    private static final String SHORTEST = "SHORTEST";
    private static final String AVERAGE = "AVERAGE";
    private static final String COUNT = "COUNT";
    private static final String PERCENT = "PERCENT";
    private static final String NEW = "NEW";
    private static final String IN_PROGRESS = "IN PROGRESS";
    private static final String PERCENTAGE = "%";
    private static final String NINETY_DAYS = "90 DAYS";
    private static final String THIRTY_DAYS = "30 DAYS";
    private static final String RENEWING = "RENEWING";
    private static final String FOR_RENEWAL = "FOR RENEWAL";
    private static final String LAST_NINETY_DAYS = "(LAST 90 DAYS)";
    private final ThirdPartyMetricsPage thirdPartyMetrics;
    private final DecimalFormat format = new DecimalFormat("##.0");
    public static final String TOTAL = "TOTAL";

    public ThirdPartyMetricsSteps(ScenarioCtxtWrapper context) {
        this.context = context;
        thirdPartyMetrics = new ThirdPartyMetricsPage(this.driver);
    }

    @When("User selects Third-party Metrics Tab")
    public void selectThirdPartyMetricsTab() {
        thirdPartyMetrics.selectThirdPartyMetricsTab();
    }

    @When("^User selects (All Third-party|My Third-party) Third-party Metrics show option$")
    public void selectThirdPartyMetricsShowOption(String showOption) {
        thirdPartyMetrics.selectThirdPartyDropdown(showOption);
        String activityReportType = ALL_THIRD_PARTY.equals(showOption) ? ALL_ACTIVITIES_TYPE : MY_ACTIVITIES_TYPE;
        context.getScenarioContext().setContext(API_ACTIVITY_REPORT_TYPE, activityReportType);
    }

    @When("User clicks Onboarding Metrics for column {string} third-parties with {string} risk score")
    public void clickOnboardingMetrics(String columnName, String riskScore) {
        thirdPartyMetrics.clickOnOnboardingColumn(columnName, riskScore);
    }

    @When("User clicks Renewal Metrics for column {string} third-parties with {string} risk score")
    public void clickRenewalMetrics(String columnName, String riskScore) {
        thirdPartyMetrics.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        thirdPartyMetrics.clickOnRenewalColumn(columnName, riskScore);
    }

    @Then("Third-party Metrics Onboarding table is displayed with major column names")
    public void majorTableIsDisplayedWithColumnNames(DataTable dataTable) {
        List<String> actualColumnNames = thirdPartyMetrics.getTableMajorColumnNameList();
        List<String> expectedColumnNames = dataTable.asList();
        assertEquals("Third-party Metrics table is not displayed expected major column names",
                     expectedColumnNames, actualColumnNames);
    }

    @Then("Third-party Metrics Onboarding table is displayed with minor column names")
    public void minorNameTableIsDisplayedWithColumnNames(DataTable dataTable) {
        List<String> actualColumnNames = thirdPartyMetrics.getTableMinorColumnNameList();
        List<String> expectedColumnNames = dataTable.asList();
        assertEquals("Third-party Metrics table is not displayed expected major column names",
                     expectedColumnNames, actualColumnNames);
    }

    @Then("Third-party Metrics Onboarding table is displayed with risk tier column names")
    public void riskTierNameTableIsDisplayedWithColumnNames(DataTable dataTable) {
        thirdPartyMetrics.waitWhilePreloadProgressbarIsDisappeared();
        List<String> actualColumnNames = thirdPartyMetrics.getTableRiskTierColumnRowsNameList();
        List<String> expectedColumnNames = dataTable.asList();
        assertEquals("Third-party Metrics table is not displayed expected risk tier column names",
                     expectedColumnNames, actualColumnNames);
    }

    @Then("Third-party Volume Percentage is expected for risk {string}")
    public void validatePartnerVolumePercentage(String riskScore) {
        String riskScoreCount = thirdPartyMetrics.getRiskTierThirdPartyVolCount(riskScore);
        String totalCount = thirdPartyMetrics.getTotalRiskTierThirdPartyVolCount();
        String expectedResult =
                format.format((double) Math.round(parseDouble(riskScoreCount) * 100) / parseDouble(totalCount));
        String actualResult =
                thirdPartyMetrics.getRiskTierThirdPartyVolPercent(riskScore).replace(PERCENTAGE, StringUtils.EMPTY);
        assertThat(actualResult).as("Unmatched the number/count of Third-party Volume Percentage.")
                .isEqualTo(expectedResult);
    }

    @Then("Third-party metrics bar graph with label Named Third-party Volume by Risk Tier is displayed")
    public void getPartnerVolByRiskTierLabel() {
        assertThat(thirdPartyMetrics.getThirdPartyVolByRiskTierLabel()).as(
                        "Incorrect Third-party Volume by Risk Tier Label")
                .isEqualTo(DashboardConstants.THIRD_PARTY_VOLUME_BY_RISK_TIER);
    }

    @Then("Third-party metrics bar graph with label Named Onboarding Volume by Status is displayed")
    public void getOnboardingVolByStatusLabel() {
        assertThat(thirdPartyMetrics.getOnboardingVolByStatusLabel()).as("Incorrect Onboarding Volume by Status Label")
                .isEqualTo(DashboardConstants.ONBOARDING_VOLUME_BY_STATUS);
    }

    @Then("Third-party metrics bar graph with label {string} is displayed")
    public void validateBarGraphDisplayed(String labelName) {
        assertThat(thirdPartyMetrics.isBarGraphWithLabelDisplayed(labelName))
                .as("Third-party metrics bar graph with label %s is not displayed", labelName).isTrue();
    }

    @Then("Third-party Metrics Renewal table is displayed with header column names")
    public void getSupplierMetricsRenewalHeaderColumns(DataTable dataTable) {
        List<String> actualColumnNames = thirdPartyMetrics.getSupplierMetricsRenewalHeaderColumns();
        List<String> expectedColumnNames = dataTable.asList();
        assertEquals("Third-party Metrics Renewal table is not displayed expected header column names",
                     expectedColumnNames, actualColumnNames);
    }

    @Then("Third-party Metrics Renewal table is displayed with major column names")
    public void getThirdPartyMetricsMajorColumns(DataTable dataTable) {
        List<String> actualColumnNames = thirdPartyMetrics.getThirdPartyMetricsRenewalMajorColumns();
        List<String> expectedColumnNames = dataTable.asList();
        assertEquals("Third-party Metrics Renewal table is not displayed expected major column names",
                     expectedColumnNames, actualColumnNames);
    }

    @Then("Third-party Metrics Renewal table is displayed with minor column names")
    public void getSupplierMetricsMinorColumns(DataTable dataTable) {
        List<String> actualColumnNames = thirdPartyMetrics.getThirdPartyMetricsRenewalRiskTiers();
        List<String> expectedColumnNames = dataTable.asList();
        assertEquals("Third-party Metrics Renewal table is not displayed expected minor column names",
                     expectedColumnNames, actualColumnNames);
    }

    @Then("Dashboard Metrics Last Updated date is displayed in expected format")
    public void getThirdPartyMetricsUpdatedDateLabel() {
        String actualDate = thirdPartyMetrics.getThirdPartyMetricsUpdatedDateLabel();
        assertThat(isDateMatchedWithFormat(actualDate, LAST_UPDATED + ACTIVITY_METRICS_FORMAT))
                .as("Incorrect Last Updated Label")
                .isTrue();
    }

    @Then("^Onboarding Metrics for column \"((.*))\" third-parties with \"((.*))\" risk score for (USER|DIVISION) is expected$")
    public void metricsForThirdPartiesWithRiskScoreForCurrentUserIsExpected(String columnName, String riskScore,
            String filter) {
        int expectedCount = getOnboardingMatrix(filter).get(riskScore.replace(MED_COLUMN, MEDIUM).toLowerCase())
                .getOnboardedLastNDays();
        int actualCount =
                parseInt(thirdPartyMetrics.getCountForOnboardingColumnRow(columnName, riskScore.toUpperCase()));
        assertThat(actualCount)
                .as("Onboarding Metric for column %s third-parties with %s risk score for current user is unexpected",
                    columnName, riskScore).isEqualTo(expectedCount);
    }

    @Then("Third-party Onboarding Metric total count for {string} column contains values for third-parties with risk scores")
    public void metricsTotalCountForThirdPartiesIsExpected(String columnName, List<String> riskScoreList) {
        int actualCount = parseInt(thirdPartyMetrics.getCountForOnboardingColumnRow(columnName, TOTAL));
        int expectedCount = riskScoreList.stream()
                .mapToInt(riskScore -> parseInt(
                        thirdPartyMetrics.getCountForOnboardingColumnRow(columnName, riskScore.toUpperCase())))
                .sum();
        assertThat(actualCount)
                .as("Onboarding Metric total count for {string} is unexpected", columnName).isEqualTo(expectedCount);
    }

    @Then("Third-party Renewal Metric total count for {string} column contains values for third-parties with risk scores")
    public void thirdPartyRenewalMetricTotalCountForColumnContainsValuesForThirdPartiesWithRiskScores(String columnName,
            List<String> riskScoreList) {
        int actualCount = parseInt(thirdPartyMetrics.getCountForRenewalColumnRow(columnName, TOTAL));
        int expectedCount = riskScoreList.stream()
                .mapToInt(riskScore -> parseInt(
                        thirdPartyMetrics.getCountForRenewalColumnRow(columnName, riskScore.toUpperCase())))
                .sum();
        assertThat(actualCount)
                .as("Renewal Metric total count for {string} is unexpected", columnName).isEqualTo(expectedCount);
    }

    @Then("^Onboarding cycle time for (DIVISION|USER) contains expected value for all columns for all Risk Tiers$")
    public void longestColumnContainsExpectedValueForRiskTiers(String filter) {
        SoftAssert softAssert = new SoftAssert();
        Map<String, OnboardingMatrixResponse> onboardingMatrix = getOnboardingMatrix(filter);
        onboardingMatrix.keySet().forEach(
                riskTier -> {
                    String updatedRiskTier = riskTier.replace(MEDIUM.toLowerCase(), MED_COLUMN).toUpperCase();
                    double longestActualCount =
                            parseDouble(thirdPartyMetrics.getCountForOnboardingColumnRow(LONGEST, updatedRiskTier));
                    double longestExpectedCount = onboardingMatrix.get(riskTier).getOnboardingCycleTimeLongest();
                    double shortestActualCount =
                            parseDouble(thirdPartyMetrics.getCountForOnboardingColumnRow(SHORTEST, updatedRiskTier));
                    double shortestExpectedCount = onboardingMatrix.get(riskTier).getOnboardingCycleTimeShortest();
                    double averageActualCount =
                            parseDouble(thirdPartyMetrics.getCountForOnboardingColumnRow(AVERAGE, updatedRiskTier));
                    double averageExpectedCount = onboardingMatrix.get(riskTier).getOnboardingCycleTimeAverage();
                    softAssert.assertEquals(longestActualCount, longestExpectedCount,
                                            format("Longest value for %s column is unexpected", riskTier));
                    softAssert.assertEquals(shortestActualCount, shortestExpectedCount,
                                            format("Shortest value for %s column is unexpected", riskTier));
                    softAssert.assertEquals(averageActualCount, averageExpectedCount,
                                            format("Average value for %s column is unexpected", riskTier));

                }

        );
        softAssert.assertAll();
    }

    @Then("Dashboard Metrics filter drop-down contains options")
    public void thirdPartyMetricsFilterDropDownContainsOptions(List<String> expectedOptions) {
        assertThat(thirdPartyMetrics.getMetricDropdownOptions())
                .as("Third-party Metrics filter drop-down doesn't contain expected options")
                .isEqualTo(expectedOptions);
    }

    @Then("Dashboard Metrics filter drop-down option {string} is selected")
    public void thirdPartyMetricsFilterDropDownOptionIsSelected(String expectedOption) {
        assertThat(thirdPartyMetrics.getMetricDropdownSelectedOption())
                .as("Dashboard Metrics filter drop-down option %s is not selected", expectedOption)
                .isEqualTo(expectedOption);
    }

    @Then("^Third-party Volume Metrics third-parties with \"((.*))\" risk score for (USER|DIVISION) is expected$")
    public void thirdPartyVolumeMetricsThirdPartiesWithRiskScoreForUSERIsExpected(String riskScore, String filter) {
        SoftAssert softAssert = new SoftAssert();
        int expectedCount = getOnboardingMatrix(filter).get(riskScore.replace(MED_COLUMN, MEDIUM).toLowerCase())
                .getPartnerVolumeCount();
        int actualCount = parseInt(thirdPartyMetrics.getCountForOnboardingColumnRow(COUNT, riskScore.toUpperCase()));
        double expectedPercent = getOnboardingMatrix(filter).get(riskScore.replace(MED_COLUMN, MEDIUM).toLowerCase())
                .getPartnerVolumePercent();
        double actualPercent =
                parseDouble(thirdPartyMetrics.getCountForOnboardingColumnRow(PERCENT, riskScore.toUpperCase()).replace(
                        PERCENTAGE, StringUtils.EMPTY));
        softAssert.assertEquals(actualCount, expectedCount,
                                format("Count value for %s column is unexpected", riskScore));
        softAssert.assertEquals(actualPercent, expectedPercent,
                                format("Percent value for %s column is unexpected", riskScore));

        softAssert.assertAll();
    }

    @Then("^Third-party New status Metrics third-parties with \"((.*))\" risk score for (USER|DIVISION) is expected$")
    public void thirdPartyNewStatusMetricsThirdPartiesWithRiskScoreForUSERIsExpected(String riskScore, String filter) {
        int expectedCount = getOnboardingMatrix(filter).get(riskScore.replace(MED_COLUMN, MEDIUM).toLowerCase())
                .getOnboardingVolumeNew();
        int actualCount = parseInt(thirdPartyMetrics.getCountForOnboardingColumnRow(NEW, riskScore.toUpperCase()));
        assertThat(actualCount).as("Third-party New Metric for risk tier %s is unexpected", riskScore)
                .isEqualTo(expectedCount);
    }

    @Then("^Third-party In Progress status Metrics third-parties with \"((.*))\" risk score for (USER|DIVISION) is expected$")
    public void thirdPartyInProgressStatusMetricsThirdPartiesWithRiskScoreIsExpected(String riskScore,
            String filter) {
        int expectedCount = getOnboardingMatrix(filter).get(riskScore.replace(MED_COLUMN, MEDIUM).toLowerCase())
                .getOnboardingVolumeInProgress();
        int actualCount =
                parseInt(thirdPartyMetrics.getCountForOnboardingColumnRow(IN_PROGRESS, riskScore.toUpperCase()));
        assertThat(actualCount).as("Third-party In Progress Metric for risk tier %s is unexpected", riskScore)
                .isEqualTo(expectedCount);
    }

    @Then("^Third-party Renewal \"((.*))\" Metrics third-parties with \"((.*))\" risk score for (DIVISION|USER) is expected$")
    public void renewalMetricsThirdPartiesIsExpected(String columnName, String riskScore, String filter) {
        int expectedCount;
        RenewalMatrixResponse renewalResponse =
                getRenewalMatrix(filter).get(riskScore.replace(MED_COLUMN, MEDIUM).toLowerCase());
        switch (columnName) {
            case THIRTY_DAYS:
                expectedCount = renewalResponse.getFirstNDays();
                break;
            case NINETY_DAYS:
                expectedCount = renewalResponse.getSecondNDays();
                break;
            case RENEWING:
                expectedCount = renewalResponse.getRenewingVolumeRenewing();
                break;
            case FOR_RENEWAL:
                expectedCount = renewalResponse.getRenewingVolumeForRenewal();
                break;
            case LAST_NINETY_DAYS:
                expectedCount = renewalResponse.getRenewedLastNDays();
                break;
            default:
                throw new IllegalArgumentException("Column name: " + columnName + " is unexpected");
        }
        int actualCount = parseInt(thirdPartyMetrics.getCountForRenewalColumnRow(columnName, riskScore.toUpperCase()));
        assertThat(actualCount).as("Third-party %s Metric for risk tier %s is unexpected", columnName, riskScore)
                .isEqualTo(expectedCount);
    }

    @Then("^Renewal cycle time for (DIVISION|USER) contains expected value for all columns for all Risk Tiers$")
    public void renewalColumnsContainExpectedValueForRiskTiers(String filter) {
        SoftAssert softAssert = new SoftAssert();
        Map<String, RenewalMatrixResponse> renewalMatrix = getRenewalMatrix(filter);
        renewalMatrix.keySet().forEach(
                riskTier -> {
                    String updatedRiskTier = riskTier.replace(MEDIUM.toLowerCase(), MED_COLUMN).toUpperCase();
                    double longestActualCount =
                            parseDouble(thirdPartyMetrics.getCountForRenewalColumnRow(LONGEST, updatedRiskTier));
                    double longestExpectedCount = renewalMatrix.get(riskTier).getRenewingCycleTimeLongest();
                    double shortestActualCount =
                            parseDouble(thirdPartyMetrics.getCountForRenewalColumnRow(SHORTEST, updatedRiskTier));
                    double shortestExpectedCount = renewalMatrix.get(riskTier).getRenewingCycleTimeShortest();
                    double averageActualCount =
                            parseDouble(thirdPartyMetrics.getCountForRenewalColumnRow(AVERAGE, updatedRiskTier));
                    double averageExpectedCount = renewalMatrix.get(riskTier).getRenewingCycleTimeAverage();
                    softAssert.assertEquals(longestActualCount, longestExpectedCount,
                                            format("Longest value for %s column is unexpected", riskTier));
                    softAssert.assertEquals(shortestActualCount, shortestExpectedCount,
                                            format("Shortest value for %s column is unexpected", riskTier));
                    softAssert.assertEquals(averageActualCount, averageExpectedCount,
                                            format("Average value for %s column is unexpected", riskTier));

                }

        );
        softAssert.assertAll();
    }

    @Then("Third-party Metrics table is displayed with empty results")
    public void thirdPartyMetricsTableIsDisplayedWithEmptyResults() {
        thirdPartyMetrics.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(thirdPartyMetrics.areOnboardingEmptyResultsDisplayed(),
                              "Third-party Onboarding Metrics table is not displayed with empty results");
        softAssert.assertTrue(thirdPartyMetrics.arePendingEmptyResultsDisplayed(),
                              "Third-party Renewal Metrics table is not displayed with empty results");
        softAssert.assertAll();
    }

    @Then("Third-party Metrics {string} displayed for following bar charts")
    public void thirdPartyMetricsDisplayedForFollowingBarCharts(String expectedMessage, List<String> barChartsList) {
        SoftAssert softAssert = new SoftAssert();
        barChartsList.forEach(
                barChart -> softAssert.assertEquals(thirdPartyMetrics.getBarChartText(barChart), expectedMessage,
                                                    format("Third-party Metrics %s bar chart doesn't contain text '%s",
                                                           barChart, expectedMessage)));
        softAssert.assertAll();
    }

    @Then("Onboarding Metrics table TOTAL is displayed with empty expected values")
    public void onboardingMetricsTableTotalIsDisplayedWithEmptyValues(Map<String, String> dataMap) {
        SoftAssert softAssert = new SoftAssert();
        dataMap.keySet().forEach(columnName -> softAssert.assertEquals(
                thirdPartyMetrics.getCountForOnboardingColumnRow(columnName, TOTAL), dataMap.get(columnName),
                format("Onboarding Metrics table TOTAL for '%s' column doesn't contains expected value", columnName)));
        softAssert.assertAll();
    }

    @Then("Renewal Metrics table TOTAL is displayed with empty expected values")
    public void renewalMetricsTableTotalIsDisplayedWithEmptyValues(Map<String, String> dataMap) {
        SoftAssert softAssert = new SoftAssert();
        dataMap.keySet().forEach(columnName -> softAssert.assertEquals(
                thirdPartyMetrics.getCountForRenewalColumnRow(columnName, TOTAL), dataMap.get(columnName),
                format("Renewal Metrics table TOTAL for '%s' column doesn't contains expected value", columnName)));
        softAssert.assertAll();
    }

    @Then("Third-party Metrics Onboarding table Risk Tier columns color are expected")
    public void thirdPartyMetricsOnboardingTableRiskTierColumnsColorAreExpected(List<String> columnNames) {
        thirdPartyMetrics.waitWhilePreloadProgressbarIsDisappeared();
        Map<String, String> riskTierColors = getRiskColors();
        SoftAssertions softAssertions = new SoftAssertions();
        columnNames.forEach(column -> assertThat(thirdPartyMetrics.getOnboardingRiskTierColumnColor(column))
                .as("Onboarding Risk Tier %s color is incorrect", column)
                .isEqualTo(getColorRgbaFromHex(riskTierColors.get(column.equals(MED_COLUMN) ? MEDIUM : column)))
        );
        softAssertions.assertAll();
    }

    @Then("Third-party Metrics Renewal table Risk Tier columns color are expected")
    public void thirdPartyMetricsRenewalTableRiskTierColumnsColorAreExpected(List<String> columnNames) {
        thirdPartyMetrics.waitWhilePreloadProgressbarIsDisappeared();
        Map<String, String> riskTierColors = getRiskColors();
        SoftAssertions softAssertions = new SoftAssertions();
        columnNames.forEach(column -> assertThat(thirdPartyMetrics.getRenewalRiskTierColumnColor(column))
                .as("Renewal Risk Tier %s color is incorrect", column)
                .isEqualTo(getColorRgbaFromHex(riskTierColors.get(column.equals(MED_COLUMN) ? MEDIUM : column))));
        softAssertions.assertAll();
    }

}
