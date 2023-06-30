package com.refinitiv.asts.test.ui.pageActions.home.dashboard;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.activityFilters.ActivityMetricsFiltersRequest;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.home.dashboard.ActivityMetricsPO;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.text.DecimalFormat;
import java.util.List;

import static com.refinitiv.asts.test.ui.api.DashboardApi.getActivities;
import static com.refinitiv.asts.test.ui.constants.DashboardConstants.*;
import static com.refinitiv.asts.test.ui.constants.Pages.*;
import static java.lang.Integer.parseInt;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static org.openqa.selenium.By.xpath;

public class ActivityMetricsPage extends BasePage<ActivityMetricsPage> {

    private final ActivityMetricsPO activityMetricsPO;

    public ActivityMetricsPage(WebDriver driver) {
        super(driver);
        activityMetricsPO = new ActivityMetricsPO(driver);
    }

    public ActivityMetricsPage(WebDriver driver, ScenarioCtxtWrapper context) {
        this(driver);
        this.context = context;
    }

    @Override
    protected ExpectedCondition<ActivityMetricsPage> getPageLoadCondition() {
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

    public void selectActivityMetricsTab() {
        clickOn(activityMetricsPO.getActivityMetricsTab());
    }

    public void clickOnDueDiligenceValue(String columnName) {
        clickOn(xpath(format(activityMetricsPO.getDdOrderRowValue(), columnName.toUpperCase())));
    }

    public List<String> getActivityMetricsHeaderColumns() {
        return getElementsText(activityMetricsPO.getActivityMetricsHeaderColumns());
    }

    public List<String> getActivityMetricsMajorColumns() {
        return getElementsText(activityMetricsPO.getActivityMetricsMajorColumns());
    }

    public List<String> getActivityMetricsMinorColumns() {
        return getElementsText(activityMetricsPO.getActivityMetricsMinorColumns());
    }

    public String getActivityMetricsUpdatedDateLabel() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementText(activityMetricsPO.getActivityMetricsUpdatedDateLabel());
    }

    public String getBarChartText(String barChart) {
        return getElementText(xpath(format(activityMetricsPO.getBarChart(), barChart)));
    }

    public boolean areEmptyResultsDisplayed() {
        int emptyValue = 0;
        List<String> activityMetricColumns = getActivityMetricsMajorColumns();
        List<String> activityMetricRows = getActivityMetricsMinorColumns();
        for (String row : activityMetricRows) {
            int columnIndex = activityMetricRows.indexOf(row) + 1;
            for (String column : activityMetricColumns) {
                int rowIndex = activityMetricColumns.indexOf(column) + 2;
                String rowValue =
                        isElementDisplayed(xpath(format(activityMetricsPO.getRowValue(), columnIndex, rowIndex))) ?
                                getElementText(xpath(format(activityMetricsPO.getRowValue(), columnIndex, rowIndex)))
                                : null;
                if (nonNull(rowValue) && parseInt(rowValue) != emptyValue) {
                    return false;
                }
            }
        }
        return true;
    }

    public boolean isBarChartDisplayed(String barChartsName) {
        return isElementDisplayed(xpath(format(activityMetricsPO.getBarChart(), barChartsName)));
    }

    public void clickOnActivityMetricsTableValue(String rowName, String columnName) {
        List<String> rowHeaders = getElementsTextsWithBlank(activityMetricsPO.getActivityMetricsMinorColumns());
        List<String> columnsHeaders = getElementsTextsWithBlank(activityMetricsPO.getActivityMetricsMajorColumns());
        int rowIndex = rowHeaders.indexOf(rowName) + 1;
        int columnIndex = columnsHeaders.indexOf(columnName) + 1;
        clickOn(xpath(format(activityMetricsPO.getRowValue(), rowIndex, columnIndex)));
    }

    public String getAssignedSectionValue(String section) {
        return getElementText(By.xpath(String.format(activityMetricsPO.getAssignedActivityColumn(), section)));
    }

    public boolean isAverageCompletionRowDisplayed() {
        return isElementDisplayed(activityMetricsPO.getAverageCompletionRow());
    }

    public String getAverageCompletionActivityMatrixValue(String columnTitle) {
        switch (columnTitle) {
            case ALL_ACTIVITIES:
                return getElementText(activityMetricsPO.getAverageCompletionAllActivitiesValue());
            case INTERNAL_QUESTIONNAIRES_SECTION:
                return getElementText(activityMetricsPO.getAverageCompletionInternalQuestionnaireValue());
            case EXTERNAL_QUESTIONNAIRES_SECTION:
                return getElementText(activityMetricsPO.getAverageCompletionExternalQuestionnaireValue());
            case DUE_DILIGENCE_REPORTS_SECTION:
                return getElementText(activityMetricsPO.getAverageCompletionDueDiligenceValue());
            default:
                throw new IllegalArgumentException("Incorrect column title - " + columnTitle);
        }
    }

    public String getActivityMatrixValue(String rowTitle, String columnTitle) {
        if (AVERAGE_COMPLETION.equals(rowTitle)) {
            return getAverageCompletionActivityMatrixValue(columnTitle);
        } else {
            switch (columnTitle) {
                case ASSIGNED_ACTIVITIES_SECTION:
                    return getElementText(
                            By.xpath(String.format(activityMetricsPO.getAssignedActivityColumn(), rowTitle)));
                case APPROVAL_ACTIVITIES_SECTION:
                    return getElementText(
                            By.xpath(String.format(activityMetricsPO.getApprovalsActivityColumn(), rowTitle)));
                case REVIEWS_ACTIVITIES_SECTION:
                    return getElementText(
                            By.xpath(String.format(activityMetricsPO.getReviewsActivityColumn(), rowTitle)));
                case INTERNAL_QUESTIONNAIRES_SECTION:
                    return getElementText(
                            By.xpath(String.format(activityMetricsPO.getInternalQuestionnaireColumn(), rowTitle)));
                case EXTERNAL_QUESTIONNAIRES_SECTION:
                    return getElementText(
                            By.xpath(String.format(activityMetricsPO.getExternalQuestionnaireColumn(), rowTitle)));
                case DUE_DILIGENCE_REPORTS_SECTION:
                    return getElementText(
                            By.xpath(String.format(activityMetricsPO.getDueDiligenceReportsColumn(), rowTitle)));
                default:
                    throw new IllegalArgumentException("Incorrect column title - " + columnTitle);
            }
        }

    }

    public Double getActivityCompletionTimeAverageValue(ActivityMetricsFiltersRequest assignedBody) {
        double average = getActivities(assignedBody).getPayload().getRecords()
                .stream()
                .filter(record -> nonNull(record.getCompletionTime()))
                .mapToDouble(record -> record.getCompletionTime()).average().getAsDouble();
        return Double.parseDouble(new DecimalFormat("#.#").format(average));
    }

    public By getActivityMetricsClickableCells() {
        waitWhilePreloadProgressbarIsDisappeared();
        return activityMetricsPO.getActivityMetricsClickableTableCells();
    }

    public By getActivityMetricsGraphs() {
        waitWhilePreloadProgressbarIsDisappeared();
        return activityMetricsPO.getActivityMetricsGraphs();
    }

    public void navigateToActivityMetricsPage() {
        driver.get(URL + ACTIVITY_METRICS_HOME_PAGE);
    }

}
