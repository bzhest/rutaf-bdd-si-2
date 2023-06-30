package com.refinitiv.asts.test.ui.pageActions;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.enums.ProcessRuleTypes;
import com.refinitiv.asts.test.ui.pageActions.home.HomePage;
import com.refinitiv.asts.test.ui.pageObjects.commonPO.ShowAngularPO;
import com.refinitiv.asts.test.ui.pageObjects.commonPO.ShowReactPO;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.time.LocalDate;
import java.util.List;

import static com.refinitiv.asts.test.ui.api.WorkflowApi.getRecentlyProcessRules;
import static com.refinitiv.asts.test.ui.constants.TestConstants.VALUE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.DEFAULT_PAGE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.ENORMOUS_ITEMS_PER_PAGE;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ActivityInformationDisplayPage.STATUS;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static java.lang.String.format;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class ShowSectionPage extends BasePage<ShowSectionPage> {

    private final ShowAngularPO showAngularPO;
    private final ShowReactPO showReactPO;
    private final HomePage homePage;

    public ShowSectionPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        showAngularPO = new ShowAngularPO();
        showReactPO = new ShowReactPO(driver);
        homePage = new HomePage(driver, context);
    }

    @Override
    protected ExpectedCondition<ShowSectionPage> getPageLoadCondition() {
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

    public void clickShowDropDown() {
        hoverOverElement(showReactPO.getBody());
        WebElement dropDownButton = homePage.isPageOnReact() ?
                waitLong.until(visibilityOfElementLocated(showReactPO.getShowDropDownButton())) :
                waitLong.until(visibilityOfElementLocated(showAngularPO.getShowDropDownButton()));
        scrollIntoView(dropDownButton);
        clickOn(dropDownButton, waitMoment);
    }

    public void clickShowDropDownOption(String optionName) {
        clickShowDropDown();
        By dropDownOption = homePage.isPageOnReact() ?
                xpath(format(showReactPO.getShowDropDownOption(), optionName)) :
                xpath(format(showAngularPO.getShowDropDownOption(), optionName));
        try {
            clickOn(dropDownOption, waitMoment);
            waitWhilePreloadProgressbarIsDisappeared();
        } catch (TimeoutException e) {
            clickShowDropDown();
            moveToElementAndClick(driver.findElement(dropDownOption));
            waitWhilePreloadProgressbarIsDisappeared();
        }
    }

    public List<String> getDropDownOptions() {
        return homePage.isPageOnReact() ?
                getDropDownOptions(showReactPO.getShowOptions()) :
                getDropDownOptions(showAngularPO.getShowOptions());
    }

    public boolean isAllItemsDisplayedWithStatus(String showOption) {
        int statusColumnIndex = 1;
        List<WebElement> columns = driver.findElements(showAngularPO.getTableColumns());
        for (int i = 0; i < columns.size(); i++) {
            statusColumnIndex =
                    columns.get(i).getText().toUpperCase().contains(STATUS.toUpperCase()) ? i + 1 : statusColumnIndex;
        }
        List<WebElement> allStatuses =
                driver.findElements(cssSelector(format(showAngularPO.getTableRowColumnValue(), statusColumnIndex)));
        return allStatuses.stream().allMatch(status -> status.getText().equals(showOption));
    }

    public boolean isShowDropDownDisplayed() {
        return isElementDisplayed(showReactPO.getShowDropDownButton());
    }

    public boolean areAllItemsCreatedPastDaysWhereTableHasNoColumnDateCreated(int daysBeforeToday,
            ProcessRuleTypes type) {
        LocalDate lastDateToDisplayApprovalProcess = getDateTimeBeforeTodayDate(daysBeforeToday);
        return getRecentlyProcessRules(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, getCurrentDateInEpoch(),
                                       getDateBeforeInEpoch(daysBeforeToday), type)
                .getObjects()
                .stream()
                .allMatch(process ->
                                  lastDateToDisplayApprovalProcess
                                          .isBefore(getLocalDateFromEpochMillis(process.getCreateTime())) ||
                                          lastDateToDisplayApprovalProcess
                                                  .isEqual(getLocalDateFromEpochMillis(process.getCreateTime())));

    }

    public String getCurrentShowDropDownOption() {
        if (homePage.isPageOnReact()) {
            return getAttributeOrText(showReactPO.getShowDropDownCurrentOption(), VALUE);
        } else {
            return getAttributeValue(showAngularPO.getShowDropDownCurrentOption(), VALUE);
        }
    }

}
