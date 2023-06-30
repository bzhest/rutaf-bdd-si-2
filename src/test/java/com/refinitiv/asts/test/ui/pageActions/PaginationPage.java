package com.refinitiv.asts.test.ui.pageActions;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.pageActions.home.HomePage;
import com.refinitiv.asts.test.ui.pageActions.setUp.CountryChecklistPage;
import com.refinitiv.asts.test.ui.pageObjects.commonPO.PaginationAngularPO;
import com.refinitiv.asts.test.ui.pageObjects.commonPO.PaginationReactPO;
import com.refinitiv.asts.test.ui.pageObjects.commonPO.ShowAngularPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.apache.commons.text.CaseUtils;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.function.Supplier;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getCustomFields;
import static com.refinitiv.asts.test.ui.api.DashboardApi.getScreeningItemsToReview;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getMyExports;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getAllThirdPartiesResponse;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.getProcessRules;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.getWorkflows;
import static com.refinitiv.asts.test.ui.constants.APIConstants.ALL;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.USER_DATA;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.ProcessRuleTypes.APPROVAL;
import static com.refinitiv.asts.test.ui.enums.ProcessRuleTypes.REVIEW;
import static java.lang.Integer.parseInt;
import static java.lang.String.format;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class PaginationPage extends BasePage<PaginationPage> {

    private final PaginationAngularPO paginationAngularPO;
    private final PaginationReactPO paginationReactPO;
    private final ShowAngularPO showAngularPO;
    private final HomePage homePage;
    public static final int DEFAULT_ITEMS_PER_PAGE = 10;
    public static final int ENORMOUS_ITEMS_PER_PAGE = 10000;
    public static final int DEFAULT_PAGE = 0;
    public static final String DEFAULT_SORT = "DESC";
    public static final String DEFAULT_SORT_BY = "dateCreated";
    public static final String CREATE_DATE = "createDate";
    private static final String TOTAL = "total";
    public static final String MAX = "Max";

    public PaginationPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        paginationAngularPO = new PaginationAngularPO();
        paginationReactPO = new PaginationReactPO();
        showAngularPO = new ShowAngularPO();
        homePage = new HomePage(driver, context);

    }

    public PaginationPage(WebDriver driver, LanguageConfig translator, ScenarioCtxtWrapper context) {
        super(driver, context, translator);
        paginationAngularPO = new PaginationAngularPO();
        paginationReactPO = new PaginationReactPO();
        showAngularPO = new ShowAngularPO();
        homePage = new HomePage(driver, context);
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    @Override
    public void load() {

    }

    @Override
    protected ExpectedCondition<PaginationPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    public int getCurrentPageNumber() {
        return parseInt(getElementText(paginationReactPO.getCurrentPage()));
    }

    public boolean isPaginationDisplayed() {
        return isElementDisplayed(waitMoment, homePage.isPageOnReact() ?
                paginationReactPO.getPagination() :
                paginationAngularPO.getPagination());
    }

    public void clickItemsPerPage() {
        waitWhileLoadingImageIsDisappeared();
        By itemsPerPageDropdown = homePage.isPageOnReact() ?
                paginationReactPO.getItemsPerPageDropdown() :
                paginationAngularPO.getItemsPerPageDropdown();
        clickOn(itemsPerPageDropdown);
    }

    public void clickItemsPerPageOption(String option) {
        String pageOption = homePage.isPageOnReact() ?
                paginationReactPO.getItemsPerPageDropdownOption() :
                paginationAngularPO.getItemsPerPageDropdownOption();
        clickOn(cssSelector(format(pageOption, option)));
    }

    public void clickPaginationButton(String buttonReference) {
        String button = homePage.isPageOnReact() ?
                paginationReactPO.getPaginationArrowButton() :
                paginationAngularPO.getPaginationArrowButton();
        clickOn(cssSelector(format(button, buttonReference)), waitShort);
    }

    public void clickLastPage() {
        if (isElementDisplayed(waitShort, paginationReactPO.getLastPage())) {
            clickOn(paginationReactPO.getLastPage());
            waitWhilePreloadProgressbarIsDisappeared();
        }
    }

    public void clickFirstPage() {
        if (isElementDisplayed(waitShort, paginationReactPO.getFirstPageButton())) {
            clickOn(paginationReactPO.getFirstPageButton());
            waitWhilePreloadProgressbarIsDisappeared();
        }
    }

    public void waitUntilResultsLoaded(int expectedResultsCount) {
        try {
            waitShort.until(numberOfElementsToBe(showAngularPO.getTableRows(), expectedResultsCount));
        } catch (TimeoutException e) {
            logger.error("Current count of items in table is not expected");
        }
    }

    public String getSelectedPaginationOption() {
        if (homePage.isPageOnReact()) {
            return getAttributeValue(paginationReactPO.getItemsPerPageDropdownInput(), VALUE);
        }
        String expectedOption = getAttributeValue(paginationAngularPO.getPaginationSelectedOption(), VALUE);
        return expectedOption.substring(expectedOption.indexOf(":") + 1);
    }

    public int getTableRowsCount() {
        waitWhilePreloadProgressbarIsDisappeared();
        try {
            return waitShort.until(numberOfElementsToBeMoreThan(showAngularPO.getTableRows(), 0)).size();
        } catch (TimeoutException e) {
            return 0;
        }
    }

    public int getExpectedRowsCount(String tableType) {
        switch (tableType) {
            case "users":
                return getUsers(DEFAULT_ITEMS_PER_PAGE, DEFAULT_PAGE, DEFAULT_SORT_BY, DEFAULT_SORT).getPayload()
                        .getCount();
            case "roles":
                return getAllRoles().getPayload().size();
            case "workflows":
                return getWorkflows(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_SORT_BY, DEFAULT_SORT).getTotal();
            case "approval processes":
                return getProcessRules(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, APPROVAL,
                                       CaseUtils.toCamelCase(ACTIVE, true)).getTotal();
            case "review processes":
                return getProcessRules(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, REVIEW,
                                       CaseUtils.toCamelCase(ACTIVE, true)).getTotal();
            case "user groups":
                return ConnectApi.getUserGroups().getBody().jsonPath().get(TOTAL);
            case "checklists":
                CountryChecklistPage countryChecklistPage = new CountryChecklistPage(driver, translator);
                return countryChecklistPage.getNumberOfCountryChecklistsInTable();
            case "Custom Fields":
                return getCustomFields(ENORMOUS_ITEMS_PER_PAGE, ALL).getTotal();
            case "Regions":
                return getAvailableRegionNames().size();
            case "Questionnaire Category":
            case "Relationship Type":
            case "Risk Scoring Range":
            case "Activity Type":
            case "Due Diligence Add-Ons":
            case "Question Category":
                return getRefDataPayload(getValueType(tableType).get_id()).getListValues().length;
            case "My Profile Contacts":
                String username = Config.get().value("user.external.username");
                return getMyProfileContacts(username).getPayload().getObjects().size();
            case "Screening Results To Review":
                String userName = ((UserData) context.getScenarioContext().getContext(USER_DATA)).getUsername();
                return getScreeningItemsToReview(userName).getPayload().getPageInformation().getTotalRecords();
            case "My Exports":
                return getMyExports().getParam().getTotalRecords();
            case "Third-parties":
                return getAllThirdPartiesResponse(1, ENORMOUS_ITEMS_PER_PAGE).getMeta().getTotalRecords();
            default:
                throw new IllegalArgumentException("Table type: " + tableType + " is unexpected");
        }
    }

    public int getNumberedPagesCount() {
        return driver.findElements(paginationAngularPO.getNumberedPage()).size();
    }

    public List<String> getDropDownOptions() {
        return getDropDownOptions(
                homePage.isPageOnReact() ?
                        paginationReactPO.getItemsPerPageOptions() :
                        paginationAngularPO.getItemsPerPageOptions());
    }

    public void closeDropDownOptions() {
        By options = homePage.isPageOnReact() ?
                paginationReactPO.getItemsPerPageDropdownInput() :
                paginationAngularPO.getItemsPerPageDropdown();
        clickOn(options);
    }

    public boolean paginationArrowButtonIsDisplayed(String buttonReference) {
        String button = homePage.isPageOnReact() ?
                paginationReactPO.getPaginationArrowButton() :
                paginationAngularPO.getPaginationArrowButton();
        return isElementDisplayed(waitShort, cssSelector(format(button, buttonReference)));
    }

    public boolean itemsPerPageDropdownIsDisplayed() {
        return isElementDisplayed(waitShort, homePage.isPageOnReact() ?
                paginationReactPO.getItemsPerPageDropdown() :
                paginationAngularPO.getItemsPerPageDropdown());
    }

    public boolean isItemsPerPageOptionDisplayed(String option) {
        String pageOption = homePage.isPageOnReact() ?
                paginationReactPO.getItemsPerPageDropdownOption() :
                paginationAngularPO.getItemsPerPageDropdownOption();
        return isElementDisplayed(cssSelector(format(pageOption, option)));
    }

    private void selectMaxFilterValue() {
        List<WebElement> filterValues = driver.findElements(paginationReactPO.getItemsPerPageOptions());
        WebElement lastValue = filterValues.get(filterValues.size() - 1);
        clickOn(lastValue);
    }

    public void selectMaxRowsPerPage() {
        clickPaginationDropDown();
        selectMaxFilterValue();
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickNextPageButtonAndWait() {
        clickNextPageButton();
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickNextPageButton() {
        clickOn(paginationReactPO.getNextPageButton());
    }

    public void clickPreviousPageButton() {
        clickOn(paginationReactPO.getPreviousPageButton());
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickPaginationDropDown() {
        scrollIntoView(paginationReactPO.getRowsPerPageDropdown());
        clickOn(paginationReactPO.getRowsPerPageDropdown());
    }

    public boolean isNextPageButtonActive() {
        scrollIntoView(paginationReactPO.getNextPageButton());
        return isElementEnabled(paginationReactPO.getNextPageButton());
    }

    public boolean isNextPageButtonVisible() {
        return isElementDisplayed(paginationReactPO.getNextPageButton());
    }

    public boolean isPaginationPageSelected(String pageNumber) {
        String isSelected = getAttributeValue(cssSelector(format(
                paginationReactPO.getPaginationArrowButton(), pageNumber)), ARIA_CURRENT);
        return Boolean.parseBoolean(isSelected);
    }

    public boolean isPaginationPagePresent(String pageNumber) {
        return isElementDisplayed(cssSelector(format(paginationReactPO.getPaginationArrowButton(), pageNumber)));
    }

    public boolean isPaginationDropDownDisabled() {
        return isElementAttributeContains(paginationReactPO.getRowsPerPageDropdown(), CLASS, DISABLED);
    }

    public boolean isPaginationDropDownHidden() {
        return !isElementDisplayedNow(paginationReactPO.getRowsPerPageDropdown());
    }

    public boolean arePaginationButtonsDisabled() {
        return isElementAttributeContains(paginationReactPO.getNextPageButton(), CLASS, DISABLED) &&
                isElementAttributeContains(paginationReactPO.getPreviousPageButton(), CLASS, DISABLED) &&
                isElementAttributeContains(paginationReactPO.getFirstPageButton(), CLASS, DISABLED) &&
                isElementAttributeContains(paginationReactPO.getLastPage(), CLASS, DISABLED);
    }

    public boolean arePaginationButtonsHidden() {
        return !isElementDisplayedNow(paginationReactPO.getNextPageButton()) &&
                !isElementDisplayedNow(paginationReactPO.getPreviousPageButton()) &&
                !isElementDisplayedNow(paginationReactPO.getFirstPageButton()) &&
                !isElementDisplayedNow(paginationReactPO.getLastPage());
    }

    public boolean isPaginationSectionDisplayed() {
        return isElementDisplayed(paginationReactPO.getNextPageButton()) &&
                isElementDisplayed(paginationReactPO.getPreviousPageButton()) &&
                isElementDisplayed(paginationReactPO.getFirstPageButton()) &&
                isElementDisplayed(paginationReactPO.getLastPage()) &&
                isElementDisplayed(paginationReactPO.getRowsPerPageDropdown());
    }

    public List<String> getAllTableStringResults() {
        return getAllPagesTableValues(this::getTableResults);
    }

    public <T> List<T> getAllPagesTableValues(Supplier<List<T>> onePageResults) {
        List<T> actualResults;
        if (!isNextPageButtonActive()) {
            return onePageResults.get();
        }
        selectMaxRowsPerPage();
        waitWhilePreloadProgressbarIsDisappeared();
        actualResults = onePageResults.get();
        while (isNextPageButtonActive()) {
            clickNextPageButton();
            waitWhilePreloadProgressbarIsDisappeared();
            List<T> results = onePageResults.get();
            actualResults.addAll(results);
        }
        return actualResults;
    }

    private List<String> getTableResults() {
        waitShort.ignoring(StaleElementReferenceException.class)
                .until(visibilityOfElementLocated(showAngularPO.getTableRows()));
        return getElementsText(getElements(showAngularPO.getTableRows()));
    }

}
