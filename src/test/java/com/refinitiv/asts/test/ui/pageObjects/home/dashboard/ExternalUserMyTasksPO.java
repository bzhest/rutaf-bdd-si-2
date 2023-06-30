package com.refinitiv.asts.test.ui.pageObjects.home.dashboard;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;

@Getter
public class ExternalUserMyTasksPO extends BasePO {

    private final By dashboardWidgets = cssSelector("#ExternalUsers-DashboardWidgets h6");
    private final By overdueWidgetCounter = cssSelector("#overdueActivities h5");
    private final By withinFiveDaysWidgetCounter = cssSelector("#dueWithin5days h5");
    private final By fivePlusDaysWidgetCounter = cssSelector("#dueIn5plusDays h5");
    private final By overdueWidget = cssSelector("#overdueActivities button");
    private final By withinFiveDaysWidget = cssSelector("#dueWithin5days button");
    private final By fivePlusDaysWidget = cssSelector("#dueIn5plusDays button");
    private final By myActivities = xpath("//*[@id='ExternalUsers-DashboardTable']/*[text()='MY ACTIVITIES']");
    private final String columnWithName = "//thead//*[text()='%s']";
    private final By tableHeaders = xpath("//*[@id='ExternalUsers-DashboardTable']//thead//th");
    private final By tableRow = cssSelector("tbody>tr");
    private final String tableRowValue = "td[%s]";

    public ExternalUserMyTasksPO(WebDriver driver) {
        super(driver);
    }

}
