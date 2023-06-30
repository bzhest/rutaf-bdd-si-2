package com.refinitiv.asts.test.ui.pageObjects.home.dashboard;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class MyTasksPO extends BasePO {

    public MyTasksPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final String dashboardTable = "//*[@id='InternalUsers-DashboardTable']";
    private final By dashboardTableName = xpath(dashboardTable + "/h5");
    private final By dashboardTableRows = xpath(dashboardTable + "//tbody/tr");
    private final String dashboardTableRow =
            "//td/*[contains(., '%s')] | //td[contains(.,'%<s')] | //td/div[text()='%<s']";
    private final String dashboardTableRowWithNames =
            "//td/*[contains(., '%s')]/ancestor::tr//td/*[contains(., '%s')]";
    private final String itemToReviewRow =
            "//tr[contains(@class,'MuiTableRow-root')]//*[text()='%s']/ancestor::tr//*[text()='%s']";
    private final String widget = "//h6[contains(.,'%s')]/ancestor::div[@data-cid='DashboardWidget-root']/button";
    private final String disabledWidget =
            "//h6[contains(.,'%s')]/ancestor::div[@data-cid='DashboardWidget-root']/button[contains(@class, 'disabled')]";
    private final String assignedActivitiesWidget = "//*[@id='DashboardItem-Activities']";
    private final By assignedActivitiesButton = xpath(assignedActivitiesWidget + "//button");
    private final By assignedActivitiesCounter = xpath(assignedActivitiesWidget + "//h5");
    private final String itemsToApproveWidget = "//*[@id='DashboardItem-ItemsApprove']";
    private final By tableRow = By.xpath("//tbody/tr");
    private final By itemsToApproveButton = xpath(itemsToApproveWidget + "//button");
    private final By itemsToApproveCounter = xpath(itemsToApproveWidget + "//h5");
    private final String itemsToReviewWidget = "//*[@id='DashboardItem-ItemsReview']";
    private final By itemsToReviewButton = xpath(itemsToReviewWidget + "//button");
    private final By itemsToReviewCount = xpath(itemsToReviewWidget + "//h5");
    private final String thirdPartyForRenewalWidget = "//*[@id='DashboardItem-SuppliersRenewal']";
    private final By thirdPartyForRenewalButton = xpath(thirdPartyForRenewalWidget + "//button");
    private final By thirdPartyForRenewalCount = xpath(thirdPartyForRenewalWidget + "//h5");
    private final String dueDiligenceWidget = "//*[@id='DashboardItem-DueDiligenceOrders']";
    private final By dueDiligenceButton = xpath(dueDiligenceWidget + "//button");
    private final By dueDiligenceCounter = xpath(dueDiligenceWidget + "//h5");
    private final String pendingOrderForApprovalWidget = "//*[@id='DashboardItem-PendingOrdersForApproval']";
    private final By pendingOrderForApprovalButton = xpath(pendingOrderForApprovalWidget + "//button");
    private final By pendingOrdersForApprovalCounter = xpath(pendingOrderForApprovalWidget + "//h5");
    private final By tableColumnNameList = xpath(dashboardTable + "//table/thead/tr/th");
    private final By itemToReviewOptions = id("select-menu-standard");
    private final By myTaskTab = id("metrics-tab-0");
    private final By itemsToApproveStatus = xpath(dashboardTable + "//table/tbody/tr/td[6]");
    private final By supplierForRenewalStatus = xpath(dashboardTable + "//table/tbody/tr/td[2]");
    private final String dashboardTableRowValue = "td[%s]";
    private final By tableCount = xpath(dashboardTable + "//p/span");
    private final String columnHeader = dashboardTable + "//thead//*[text()='%s']/..";
    private final By dashboardTabs = xpath("//*[@aria-label='metrics tabs example']//button//h4");
    private final By dashboardWidgets = xpath("//*[@data-cid='DashboardWidget-root']//h6");
    private final String pendingOrderOrderIdValue = "//td[1]//*[text()='%s']";
    private final By tableCells = cssSelector("td");
    private final By dashboardChevron = cssSelector("[data-cid='toggle-widget-icon']");
    protected final By dropDownSelectedOption = xpath("//li[@role='option' and @aria-selected='true']");
    protected final By dashboardTableMessage = xpath("//*[@id='InternalUsers-DashboardTable']//h6");

}
