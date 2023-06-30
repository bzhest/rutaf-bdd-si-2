package com.refinitiv.asts.test.ui.pageActions;

import com.refinitiv.asts.test.ui.pageObjects.commonPO.SearchPO;
import org.openqa.selenium.Keys;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import static org.openqa.selenium.support.ui.ExpectedConditions.numberOfElementsToBeLessThan;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class SearchSectionPage extends BasePage<SearchSectionPage> {

    private final SearchPO searchPO;

    public SearchSectionPage(WebDriver driver) {
        super(driver);
        searchPO = new SearchPO();
    }

    @Override
    protected ExpectedCondition<SearchSectionPage> getPageLoadCondition() {
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

    public void searchItem(String keyWord) {
        waitWhilePreloadProgressbarIsDisappeared();
        int rowsNumber = getElements(searchPO.getTableRows()).size();
        moveToElementAndClick(waitLong.until(visibilityOfElementLocated(searchPO.getSearchField())), 100);
        clearAndInputField(searchPO.getSearchField(), keyWord);
        if (isElementDisplayed(searchPO.getSearchButton())) {
            clickOn(searchPO.getSearchButton());
        } else {
            enterViaKeyboard(Keys.ENTER);
        }
        waitWhileLoadingImageIsDisappeared();
        try {
            waitMoment.until(numberOfElementsToBeLessThan(searchPO.getTableRows(), rowsNumber));
        } catch (TimeoutException ex) {
            enterViaKeyboard(Keys.ENTER);
        }
        waitWhileLoadingImageIsDisappeared();
    }

    public void clearSearchInput() {
        WebElement searchInput = waitLong.until(visibilityOfElementLocated(searchPO.getSearchField()));
        clearText(searchInput);
        enterViaKeyboard(Keys.ENTER);
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public boolean isSearchInputDisplayed() {
        return isElementDisplayed(searchPO.getSearchField());
    }

    public boolean isSearchButtonDisplayed() {
        return isElementDisplayed(searchPO.getSearchButton());
    }

}
