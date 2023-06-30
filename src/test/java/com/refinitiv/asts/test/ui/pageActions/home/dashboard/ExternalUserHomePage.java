package com.refinitiv.asts.test.ui.pageActions.home.dashboard;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.home.dashboard.ExternalUserMyTasksPO;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.TestConstants.CLASS;
import static com.refinitiv.asts.test.ui.constants.TestConstants.DISABLED;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;

public class ExternalUserHomePage extends BasePage<ExternalUserHomePage> {

    private final ExternalUserMyTasksPO homePO;

    public ExternalUserHomePage(WebDriver driver) {
        super(driver);
        homePO = new ExternalUserMyTasksPO(driver);
    }

    @Override
    protected ExpectedCondition<ExternalUserHomePage> getPageLoadCondition() {
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
        this.driver.get(URL);
    }

    public List<String> getDashboardWidgets() {
        return getElementsText(homePO.getDashboardWidgets());
    }

    public String getOverdueWidgetCounter() {
        waitShort.until(ExpectedConditions.visibilityOfElementLocated(homePO.getOverdueWidget()));
        waitShort.until(driver -> !getAttributeValue(homePO.getOverdueWidget(), CLASS).contains(DISABLED));
        return getElementText(homePO.getOverdueWidgetCounter());
    }

    public String getWithinFiveDaysCounter() {
        return getElementText(homePO.getWithinFiveDaysWidgetCounter());
    }

    public String getFivePlusDaysCounter() {
        return getElementText(homePO.getFivePlusDaysWidgetCounter());
    }

    public void clickOverdueWidget() {
        clickOn(homePO.getOverdueWidget());
    }

    public void clickWithinFiveDaysWidget() {
        clickOn(homePO.getWithinFiveDaysWidget(), waitMoment);
    }

    public void clickFivePlusDaysWidget() {
        clickOn(homePO.getFivePlusDaysWidget());
    }

    public boolean isMyActivitiesTableDisplayed() {
        return isElementDisplayed(homePO.getMyActivities());
    }

    public List<String> getMyActivitiesTableColumnNameList() {
        waitMoment.until(ExpectedConditions.visibilityOfAllElementsLocatedBy(homePO.getTableHeaders()));
        return getElementsText(driver.findElements(homePO.getTableHeaders()));
    }

    public void clickOnColumn(String columnName) {
        clickOn(xpath(format(homePO.getColumnWithName(), columnName)), waitShort);
    }

    public List<String> getListValuesForColumn(String columnName) {
        waitForAngularPageIsLoaded();
        int columnIndex = getColumnTableIndex(columnName);
        return driver.findElements(homePO.getTableRow()).stream()
                .map(row -> getElementText(
                        row.findElement(xpath(format(homePO.getTableRowValue(), columnIndex)))))
                .collect(Collectors.toList());
    }

    public void clickOnFirstRow() {
        clickOn(homePO.getTableRow());
    }

    private int getColumnTableIndex(String columnName) {
        return getTableHeaders().indexOf(columnName) + 1;
    }

}
