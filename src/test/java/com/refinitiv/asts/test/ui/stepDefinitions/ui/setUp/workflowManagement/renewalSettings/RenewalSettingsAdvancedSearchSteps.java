package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.workflowManagement.renewalSettings;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.SIPublicApi;
import com.refinitiv.asts.test.ui.constants.APIConstants;
import com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.renewalSettings.RenewalSettingsAdvancedSearchPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.AppApi.INTERNAl_USER_TYPE;
import static com.refinitiv.asts.test.ui.api.AppApi.getUsers;
import static com.refinitiv.asts.test.ui.api.BaseApi.ALL_ITEMS;
import static com.refinitiv.asts.test.ui.constants.APIConstants.DATE_CREATED;
import static com.refinitiv.asts.test.ui.constants.APIConstants.DESC;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.*;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.DEFAULT_SORT;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertEquals;
import static org.testng.AssertJUnit.assertTrue;

public class RenewalSettingsAdvancedSearchSteps extends BaseSteps {

    private static final String INVALID_NAME = "YYYYY";
    private static final String USERS = "'Advanced Search - Users'";
    private static final String USERS_GROUP = "'Advanced Search - Users Group'";

    private final RenewalSettingsAdvancedSearchPage advancedSearchPage;

    public RenewalSettingsAdvancedSearchSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.advancedSearchPage = new RenewalSettingsAdvancedSearchPage(driver);
    }

    @When("User fills in 'Advanced Search - Users' modal First Name and Last Name with {string} and {string}")
    public void fillInRenewalSettingsFirstNameAndLastNameWith(String firstName, String lastName) {
        if (firstName.equals(VALUE_TO_REPLACE) && lastName.equals(VALUE_TO_REPLACE)) {
            firstName = getFirstValueFromUsersList(UserData::getFirstName);
            lastName = getFirstValueFromUsersList(UserData::getLastName);
        }

        if (nonNull(firstName) && firstName.equals(INVALID)
                && nonNull(lastName) && lastName.equals(INVALID)) {
            firstName = INVALID_NAME;
            lastName = INVALID_NAME;
        }
        advancedSearchPage.fillInFirstNameField(firstName);
        advancedSearchPage.fillInLastNameField(lastName);

        context.getScenarioContext().setContext(SEARCH_FIRST_NAME_CONTEXT, firstName);
        context.getScenarioContext().setContext(SEARCH_LAST_NAME_CONTEXT, lastName);
    }

    @When("^User clicks Renewal Settings (?:'Advanced Search - Users'|'Advanced Search - Users Group'?) modal Search button$")
    public void clickAdvancedSearchModalSearchButton() {
        advancedSearchPage.clickAdvancedSearchUsersModalSearchButton();
        advancedSearchPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("^User clicks Renewal Settings (?:'Advanced Search - Users'|'Advanced Search - Users Group'?) modal Cancel button$")
    public void clickAdvancedSearchModalCancelButton() {
        advancedSearchPage.clickAdvancedSearchModalCancelButton();
    }

    @When("^User selects Renewal Settings ('Advanced Search - Users'|'Advanced Search - Users Group') modal first radio button$")
    public void tickFirstAvailableRadioButton(String modalType) {
        advancedSearchPage.tickFirstAvailableRadioButton();
        switch (modalType) {
            case USERS:
                String firstUserName =
                        advancedSearchPage.getAdvanceSearchResultsUserNames().stream().findFirst().orElse(null);
                context.getScenarioContext().setContext(FIRST_SELECTED_USER_NAME_CONTEXT, firstUserName);
                break;
            case USERS_GROUP:
                String firstUserGroupName = getFirstUserGroupFromList();
                context.getScenarioContext().setContext(FIRST_SELECTED_USER_GROUP_NAME_CONTEXT, firstUserGroupName);
                break;
            default:
                throw new IllegalArgumentException("Incorrect modal name was used!");
        }
    }

    @When("^User clicks Renewal Settings (?:'Advanced Search - Users'|'Advanced Search - Users Group'?) modal Add button$")
    public void clickAdvancedSearchModalAddButton() {
        advancedSearchPage.clickAdvancedSearchModalAddButton();
    }

    @When("User fills in 'Advanced Search - Users Group' modal Group Name with {string}")
    public void fillInUserGroupField(String groupName) {
        switch (groupName) {
            case (VALUE_TO_REPLACE):
                groupName = getFirstUserGroupFromList();
                break;
            case (INVALID):
                groupName = INVALID_NAME;
                break;
            default:
                throw new IllegalArgumentException("Invalid group name is entered");
        }
        advancedSearchPage.fillInGroupNameField(groupName);
        context.getScenarioContext().setContext(SEARCH_GROUP_NAME_CONTEXT, groupName);
    }

    @Then("Renewal Settings {string} modal is displayed")
    public void isAdvancedSearchModalDisplayed(String modalName) {
        assertThat(advancedSearchPage.isAdvancedSearchModalDisplayed(modalName))
                .as("Advanced Search - Users modal is not displayed!")
                .isTrue();
    }

    @Then("Renewal Settings 'Advanced Search - Users' modal has First Name and Last Name fields")
    public void areAdvancedSearchUsersModalFirstNameAndLastNameFieldsDisplayed() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(advancedSearchPage.getFirstNameFieldActualName(),
                                "First Name", "Actual field name differs from expected 'First Name' label!");
        softAssert.assertEquals(advancedSearchPage.getLastNameFieldActualName(),
                                "Last Name", "Actual field name differs from expected 'Last Name' label!");
        softAssert.assertTrue(advancedSearchPage.isFirstNameFieldDisplayed(),
                              "First Name text input field is not displayed!");
        softAssert.assertTrue(advancedSearchPage.isLastNameFieldDisplayed(),
                              "Last Name text input field is not displayed!");
        softAssert.assertAll();
    }

    @Then("^Renewal Settings (?:'Advanced Search - Users'|'Advanced Search - Users Group'?) modal has Search and Cancel buttons$")
    public void areAdvancedSearchModalSearchAndCancelButtonsDisplayed() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(advancedSearchPage.isSearchButtonDisplayed(),
                              "Search button is not displayed!");
        softAssert.assertTrue(advancedSearchPage.isCancelButtonDisplayed(),
                              "Cancel button is not displayed!");
        softAssert.assertAll();
    }

    @Then("^'Advanced Search - Users' modal appropriate results are displayed for the next columns \"((.*))\"$")
    public void areAdvancedSearchUsersModalResultsDisplayed(String expectedColumns) {
        SoftAssertions softAssert = new SoftAssertions();
        String firstName = (String) context.getScenarioContext().getContext(SEARCH_FIRST_NAME_CONTEXT);
        String lastName = (String) context.getScenarioContext().getContext(SEARCH_LAST_NAME_CONTEXT);
        String userName = firstName + SPACE + lastName;
        List<String> expectedUsersList =
                AppApi.getAllActiveInternalUsersStream(APIConstants.DESC).map(name -> name.getName().toUpperCase())
                        .filter(name -> name.contains(userName.toUpperCase()))
                        .collect(Collectors.toList());
        String actualColumnsHeader = advancedSearchPage.getAdvanceSearchHeader().replace("\n", SPACE);
        List<String> actualUsersList =
                advancedSearchPage.getAdvanceSearchResultsUserNames().stream().map(String::toUpperCase).collect(
                        Collectors.toList());
        softAssert.assertThat(actualColumnsHeader)
                .as("Expected column names are not displayed!")
                .isEqualTo(expectedColumns);
        softAssert.assertThat(actualUsersList.get(0))
                .as("Expected search results are not displayed!")
                .isEqualTo(expectedUsersList.get(0));
        softAssert.assertAll();
    }

    @Then("All Active users are returned as a search result in 'Advanced Search - Users' modal")
    public void areAllActiveUsersReturnedAsASearchResultInAdvancedSearchUsersModal() {
        List<String> expectedUsersList = getUsers(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, DEFAULT_SORT_BY, DEFAULT_SORT)
                .getPayload().getData().stream()
                .filter(userData -> userData.getStatus().equals(ACTIVE.getStatus()) &&
                        userData.getUserType().equals(INTERNAl_USER_TYPE) && nonNull(userData.getUsername()) &&
                        nonNull(userData.getRole()))
                .map(user -> user.getFirstName() + SPACE + user.getLastName().replace(DOUBLE_SPACE, SPACE))
                .limit(10)
                .collect(Collectors.toList());
        assertThat(advancedSearchPage.getAdvanceSearchResultsUserNames())
                .as("Not all active users are returned as a search result in 'Advanced Search - Users' modal")
                .isEqualTo(expectedUsersList);
    }

    @Then("^Renewal Settings (?:'Advanced Search - Users'|'Advanced Search - Users Group'?) modal displays No Match Found Message$")
    public void isNoMatchFoundMessageDisplayed() {
        assertTrue("No Match Found Message is not displayed!", advancedSearchPage.isNoMatchFoundMessageDisplayed());
    }

    @Then("^Renewal Settings (?:'Advanced Search - Users'|'Advanced Search - Users Group'?) modal has Add button$")
    public void isAddButtonDisplayedWithExpectedName() {
        assertThat(advancedSearchPage.isModalAddButtonDisplayed())
                .as("Advanced Search modal Add button is not displayed")
                .isTrue();
    }

    @Then("Renewal Settings {string} modal disappeared")
    public void isAdvancedSearchModalDisappeared(String modalName) {
        assertTrue("Advanced Search - Users modal is still displayed!",
                   advancedSearchPage.isAdvancedSearchModalDisappeared(modalName));
    }

    @Then("^(?:'Advanced Search - Users'|'Advanced Search - Users Group'?) modal has Cancel button$")
    public void isAdvancedSearchModalCancelButtonsDisplayed() {
        assertTrue("Cancel button is not displayed!",
                   advancedSearchPage.isCancelButtonDisplayed());
    }

    @Then("Renewal Settings 'Advanced Search - Users Group' modal has Group Name field")
    public void isAdvancedSearchUsersGroupModalGroupNameDisplayed() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(advancedSearchPage.getGroupNameFieldActualName(),
                                "Group Name", "Expected field name is not displayed!");
        softAssert.assertTrue(advancedSearchPage.isGroupNameFieldDisplayed(),
                              "Group Name input field is not displayed!");
        softAssert.assertAll();
    }

    @Then("'Advanced Search - Users Group' modal appropriate results are displayed in Group Name column")
    public void areAdvancedSearchUsersGroupModalResultsDisplayed() {
        String groupName = (String) context.getScenarioContext().getContext(SEARCH_GROUP_NAME_CONTEXT);
        List<String> expectedUsersGroupList =
                ConnectApi.getListOfActiveUserGroups().stream().map(String::toUpperCase)
                        .filter(name -> name.contains(groupName.toUpperCase())).collect(Collectors.toList());
        String actualColumnsHeader = advancedSearchPage.getAdvanceSearchHeader();
        List<String> actualUsersGroupList =
                advancedSearchPage.getAdvanceSearchResults().stream().map(String::toUpperCase).collect(
                        Collectors.toList());

        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(actualColumnsHeader,
                                "GROUP NAME", "Expected column name is not displayed!");
        softAssert.assertEquals(actualUsersGroupList,
                                expectedUsersGroupList, "Expected search results are not displayed!");
        softAssert.assertAll();
    }

    @Then("All Active User Groups are returned as a search result in 'Advanced Search - Users Group' modal")
    public void areAllActiveUsersGroupReturnedInAdvancedSearchUsersGroupModal() {
        List<String> expectedUsersGroupList =
                ConnectApi.getListOfActiveUserGroups().stream().map(group -> group.replace(DOUBLE_SPACE, SPACE).trim())
                        .collect(Collectors.toList());
        List<String> actualUsersGroupList;

        if (advancedSearchPage.isRowsPerPageDisplayed()) {
            actualUsersGroupList = getActualSearchResultsInCasePaginationAppears().stream()
                    .map(group -> group.replace(DOUBLE_SPACE, SPACE).trim()).collect(Collectors.toList());
        } else {
            actualUsersGroupList = advancedSearchPage.getAdvanceSearchResults().stream()
                    .map(group -> group.replace(DOUBLE_SPACE, SPACE).trim()).collect(Collectors.toList());
        }
        assertThat(sortList(actualUsersGroupList))
                .as("Not all active user groups are returned in a search result")
                .isEqualTo(sortList(expectedUsersGroupList));
    }

    @Then("^The 'Add' button is disabled when (?:user|user group) is not selected$")
    public void addButtonIsDisabled() {
        assertThat(advancedSearchPage.isModalAddButtonEnabled())
                .as("'Add' button is enabled")
                .isFalse();
    }

    private String getFirstValueFromUsersList(Function<UserData, String> function) {
        return AppApi.getAllActiveInternalUsersStream(APIConstants.DESC).map(function).findFirst().orElse(null);
    }

    private List<String> getActualSearchResultsInCasePaginationAppears() {
        List<String> actualResults;
        advancedSearchPage.selectMaxRowsToBeDisplayed();
        advancedSearchPage.waitWhilePreloadProgressbarIsDisappeared();
        actualResults = advancedSearchPage.getAdvanceSearchResults();

        while (Objects.isNull(advancedSearchPage.getNextPageDisabledAttribute())) {
            advancedSearchPage.clickNextPage();
            advancedSearchPage.waitWhilePreloadProgressbarIsDisappeared();
            List<String> results = advancedSearchPage.getAdvanceSearchResults();
            actualResults.addAll(results);
        }
        return actualResults;
    }

    private String getFirstUserGroupFromList() {
        return ConnectApi.getListOfActiveUserGroups().stream().findFirst().orElse(null);
    }

    private List<String> sortList(List<String> listToSort) {
        return listToSort.stream().sorted().collect(Collectors.toList());
    }

}
