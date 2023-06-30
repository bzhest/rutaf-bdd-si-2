package com.refinitiv.asts.test.ui.pageObjects.home.dashboard;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.xpath;

@Getter
public class ActivityMetricsPO extends BasePO {

    public ActivityMetricsPO(WebDriver driver) {
        super(driver);
    }

    private final By
            activityMetricsHeaderColumns = xpath("//*[@id='ActivityMetrics2-MetricsTable']/div/table/thead/tr[1]/th");
    private final By activityMetricsMajorColumns =
            xpath("//*[@id='ActivityMetrics2-MetricsTable']/div/table/thead/tr[2]/th");
    private final By activityMetricsMinorColumns =
            xpath("//*[@id='ActivityMetrics2-MetricsTable']/div/table/tbody/tr/td[1]");
    private final By activityMetricsUpdatedDateLabel =
            xpath("//*[@id='DashboardContainer-ActivityMetrics']/div/div/div/div/div/p");
    private final By activityMetricsTab = xpath("//*[@id='metrics-tab-2']");
    private final String barChart = "//*[text()='%s']/ancestor::h5/following-sibling::div";
    private final String rowValue = "//tr[%s]//td[%s]";
    private final String ddOrderRowValue = "//td//p[text()='%s']/ancestor::tr/td[7]";
    private final String assignedActivityColumn = "//tbody//p[text()='%s']/ancestor::tr/td[2]";
    private final String approvalsActivityColumn = "//tbody//p[text()='%s']/ancestor::tr/td[3]";
    private final String reviewsActivityColumn = "//tbody//p[text()='%s']/ancestor::tr/td[4]";
    private final String internalQuestionnaireColumn = "//tbody//p[text()='%s']/ancestor::tr/td[5]";
    private final String externalQuestionnaireColumn = "//tbody//p[text()='%s']/ancestor::tr/td[6]";
    private final String dueDiligenceReportsColumn = "//tbody//p[text()='%s']/ancestor::tr/td[7]";
    private final By averageCompletionRow = xpath("//tbody//p[text()='AVERAGE COMPLETION (DAYS)']");
    private final By averageCompletionAllActivitiesValue =
            xpath("//tbody//p[text()='AVERAGE COMPLETION (DAYS)']/ancestor::tr/td[2]");
    private final By averageCompletionInternalQuestionnaireValue =
            xpath("//tbody//p[text()='AVERAGE COMPLETION (DAYS)']/ancestor::tr/td[3]");
    private final By averageCompletionExternalQuestionnaireValue =
            xpath("//tbody//p[text()='AVERAGE COMPLETION (DAYS)']/ancestor::tr/td[4]");
    private final By averageCompletionDueDiligenceValue =
            xpath("//tbody//p[text()='AVERAGE COMPLETION (DAYS)']/ancestor::tr/td[5]");
    private final By activityMetricsGraphs = xpath("canvas");
    private final By activityMetricsClickableTableCells = xpath("//tbody//tr[position() < 5]/td[position() > 1]");

}
