package com.refinitiv.asts.test.ui.pageObjects.home.dashboard;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.xpath;

@Getter
public class ThirdPartyMetricsPO extends BasePO {

    public ThirdPartyMetricsPO(WebDriver driver) {
        super(driver);
    }

    private final String riskTierThirdPartyVolCount =
            "//*[@id='Supplier1-MetricsTable']/div/table/tbody/tr[%s]/td[2]//p";
    private final String riskTierThirdPartyVolPercent =
            "//*[@id='Supplier1-MetricsTable']/div/table/tbody/tr[%s]/td[3]//p";
    private final String riskTierForRenewingTotalCount =
            "//*[@id='SupplierRenewalMetrics1-MetricsTable']/div/table/tbody/tr[%s]/td[5]//p";
    private final By thirdPartyMetricsTab = xpath("//*[@id='metrics-tab-1']");
    private final By supplierMetricsMajorColumns = xpath("//*[@id='Supplier1-MetricsTable']/div/table/thead/tr[1]/th");
    private final By supplierMetricsMinorColumns = xpath("//*[@id='Supplier1-MetricsTable']/div/table/thead/tr[2]/th");
    private final String supplierMetricsMinorColumn = "//*[@id='Supplier1-MetricsTable']//p[text()='%s']/ancestor::td";
    private final By supplierMetricsRiskTierColumns =
            xpath("//*[@id='Supplier1-MetricsTable']/div/table/tbody/tr/td[1]");
    private final By supplierMetricsRenewalHeaderColumns =
            xpath("//*[@id='SupplierRenewalMetrics1-MetricsTable']/div/table/thead/tr[1]/th");
    private final By supplierMetricsRenewalMajorColumns =
            xpath("//*[@id='SupplierRenewalMetrics1-MetricsTable']/div/table/thead/tr[2]/th");
    private final By supplierMetricsRenewalMinorColumns =
            xpath("//*[@id='SupplierRenewalMetrics1-MetricsTable']/div/table/tbody/tr/td[1]");
    private final String supplierMetricsRenewalMinorColumn =
            "//*[@id='SupplierRenewalMetrics1-MetricsTable']//p[text()='%s']/ancestor::td";
    private final By dashboardFilterDropdown = xpath("//select[@id='table-category-id']");
    private final By partnerVolByRiskTierLabel = xpath("//*[@id='ChartsContainer-DoughnutChart']/h5");
    private final By onboardingVolByStatusLabel =
            xpath("//*[@id='ChartsContainer-OnboardingVolume-SimpleBarChart']/h5/div");
    private final String barGraph = "//*[text()='%1$s']/../following-sibling::div | //*[text()='%1$s']/../div";
    private final By thirdPartyMetricsUpdatedDateLabel =
            xpath("//*[@id='DashboardContainer-SupplierMetrics' or @id='DashboardContainer-ActivityMetrics']/div/div[1]/div/div/div[1]/p");
    private final String onboardingRowValue = "//*[@id='Supplier1-MetricsTable']//tr[%s]//td[%s]//p";
    private final String renewalRowValue = "//*[@id='SupplierRenewalMetrics1-MetricsTable']//tr[%s]//td[%s]//p";
    private final String barChart =
            "//*[text()='%s']/../../following-sibling::div | //*[text()='%<s']/following-sibling::div";
    private final String rowValue = "//tr[%s]//td[%s]";

}
