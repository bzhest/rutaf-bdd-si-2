package com.refinitiv.asts.test.ui.pageActions.myExports;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.myExports.MyExportsPO;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.Pages.MY_EXPORTS;
import static java.lang.Integer.parseInt;
import static java.lang.String.format;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;

public class MyExportsPage extends BasePage<MyExportsPage> {

    private final MyExportsPO myExportsPO;
    public static final String STATUS = "STATUS";
    public static final String COMPLETED = "Completed";
    public static final String FAILED = "Failed";

    public MyExportsPage(WebDriver driver) {
        super(driver);
        myExportsPO = new MyExportsPO(driver);
    }

    @Override
    protected ExpectedCondition<MyExportsPage> getPageLoadCondition() {
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

    public void navigateToMyExportsPage() {
        this.driver.get(URL + MY_EXPORTS);
    }

    public void clickFileLink(String expectedFullFileName) {
        clickOn(xpath(format(myExportsPO.getFileLink(), expectedFullFileName)));
    }

    public String getFileNameWithCorrectMinutes(String expectedFileNameStart) {
        return getElementText(xpath(format(myExportsPO.getFileLink(), expectedFileNameStart)));
    }

    public void clickColumnName(String columnName) {
        clickOn(xpath(format(myExportsPO.getColumn(), columnName)));
    }

    public boolean isFileLinkDisplayed(String expectedFullFileName) {
        int count = 1;
        int maxTries = 3;
        boolean isElementDisplayed = false;
        while (count++ <= maxTries && !isElementDisplayed) {
            refreshPage();
            waitWhileSeveralPreloadProgressBarsAreDisappeared();
            isElementDisplayed =
                    isElementDisplayed(waitShort, xpath(format(myExportsPO.getFileLink(), expectedFullFileName)));
        }
        return isElementDisplayed;
    }

    public boolean isValueContainsInteger(String value) {
        try {
            parseInt(value);
            return true;
        } catch (NumberFormatException ex) {
            return false;
        }
    }

    public List<String> getColumns() {
        return getElementsText(myExportsPO.getColumns());
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getColumns().indexOf(columnName) + 1;
        return getElementsText(cssSelector(format(myExportsPO.getCellsWithIndex(), columnIndex)));
    }

    public List<String> getListSummaryForColumnWithStatus(String status) {
        return getElementsText(xpath(format(myExportsPO.getSummaryForStatus(), status)));
    }

    public String getMessage() {
        return getElementText(myExportsPO.getMessage());
    }

}
