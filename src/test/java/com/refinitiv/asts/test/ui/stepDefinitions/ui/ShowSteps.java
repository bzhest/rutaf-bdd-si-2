package com.refinitiv.asts.test.ui.stepDefinitions.ui;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.SearchSectionPage;
import com.refinitiv.asts.test.ui.pageActions.ShowSectionPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.openqa.selenium.Keys.ESCAPE;

public class ShowSteps extends BaseSteps {

    private final ShowSectionPage showPage;
    private final SearchSectionPage searchPage;

    public ShowSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.showPage = new ShowSectionPage(this.driver, context);
        this.searchPage = new SearchSectionPage(this.driver);
    }

    @When("User selects {string} show option")
    public void selectShowOption(String showOption) {
        showPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        showPage.clickShowDropDownOption(showOption);
    }

    @When("User searches item by {string} keyword")
    public void searchItemByKeyword(String keyWord) {
        if (keyWord.equals(REVIEW_PROCESS_NAME)) {
            keyWord = (String) context.getScenarioContext().getContext(REVIEW_PROCESS_NAME);
        }
        if (keyWord.equals(USER_EDITED_FIRST_NAME)) {
            keyWord = (String) context.getScenarioContext().getContext(USER_EDITED_FIRST_NAME);
        }
        searchPage.searchItem(keyWord);
        context.getScenarioContext().setContext(THIRD_PARTY_SEARCH_TERM, keyWord);
    }

    @When("User clears search input field")
    public void clearSearchItem() {
        searchPage.clearSearchInput();
        context.getScenarioContext().setContext(THIRD_PARTY_SEARCH_TERM, null);
    }

    @Then("Show Drop-Down list is displayed with values")
    public void showDropDownListIsDisplayedWithValues(DataTable dataTable) {
        List<String> expectedOptions = dataTable.asList();
        showPage.clickShowDropDown();
        assertEquals("Show Drop-Down list is not displayed with expected values", expectedOptions,
                     showPage.getDropDownOptions());
        showPage.enterViaKeyboard(ESCAPE);
    }

    @Then("Table displayed with all {string} items")
    public void tableDisplayedWithForFirstPage(String showOption) {
        showPage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue("Table is not displayed with all " + showOption + " items",
                   showPage.isAllItemsDisplayedWithStatus(showOption));
    }

    @Then("Show Drop-Down current option should be {string}")
    public void checkShowDropDownCurrentOption(String currentOption) {
        showPage.waitWhilePreloadProgressbarIsDisappeared();
        assertEquals("'Show' dropdown current option is not " + currentOption,
                     showPage.getCurrentShowDropDownOption(), currentOption);
    }

    @Then("Search text field is displayed")
    public void searchTextFieldIsDisplayed() {
        assertTrue("Search text field is displayed", searchPage.isSearchInputDisplayed());
    }

    @Then("Search button is displayed")
    public void searchButtonIsDisplayed() {
        assertTrue("Search text field is displayed", searchPage.isSearchButtonDisplayed());
    }

    @Then("Show drop-down is displayed")
    public void isShowDropDownDisplayed() {
        assertThat(showPage.isShowDropDownDisplayed())
                .as("Show drop-down is not displayed")
                .isTrue();
    }

}
