package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.dueDiligenceOrderManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.OrderApproval;
import com.refinitiv.asts.test.ui.constants.APIConstants;
import com.refinitiv.asts.test.ui.pageActions.setUp.dueDilligenceOrderManagement.DueDiligenceOrderApprovalPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.openqa.selenium.Keys;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getUserGroupNamesByStatus;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.getOrderApproval;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.postOrderApproval;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.GroupFields.GROUP_NAME;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.UserFields.FIRST_NAME;
import static com.refinitiv.asts.test.ui.enums.UserFields.LAST_NAME;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.*;
import static freemarker.template.utility.StringUtil.capitalize;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertEquals;

public class DueDiligenceOrderApprovalSteps extends BaseSteps {

    private final DueDiligenceOrderApprovalPage dueDiligenceOrderApprovalPage;

    private static final String ACTIVE_STATUS = "true";
    public static final String RESPONSIBLE_PARTY = "responsible-party";
    private static final String USER = "user";
    private static final String USER_GROUP = "userGroup";
    private String firstName;
    private String lastName;
    private String groupName;

    public DueDiligenceOrderApprovalSteps(ScenarioCtxtWrapper context) {
        super(context);
        dueDiligenceOrderApprovalPage = new DueDiligenceOrderApprovalPage(driver);
    }

    private List<String> getActiveUsers() {
        return getUsers(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, DEFAULT_SORT_BY, DEFAULT_SORT)
                .getPayload().getData().stream()
                .filter(userData -> userData.getStatus().equals(ACTIVE.getStatus()) &&
                        userData.getUserType().equals(INTERNAl_USER_TYPE) && nonNull(userData.getUsername()) &&
                        nonNull(userData.getRole()))
                .map(user -> format(USER_FORMAT_WITH_EMAIL, user.getFirstName(), user.getLastName(),
                                    user.getUsername()))
                .limit(20)
                .collect(Collectors.toList());
    }

    @When("User creates {int} rules for DDO Approval")
    public void createMultipleDDOApprovalRules(Integer numberOfRules) {
        for (int i = 1; i <= numberOfRules; i++) {
            dueDiligenceOrderApprovalPage.selectRandomRule(i);
            dueDiligenceOrderApprovalPage.selectRandomSubtype(i);
            dueDiligenceOrderApprovalPage.selectRuleRadio(i, USER_GROUP);
            dueDiligenceOrderApprovalPage.selectRandomUserGroupApprover(i);
            dueDiligenceOrderApprovalPage.clickAddRulesButton();
        }
    }

    @When("User selects {string} for {string} in DDO Approval Approver dropdown for rule {int}")
    public void selectValueForApprovalRule(String value, String chosenRadioButton, Integer ruleNumber) {
        switch (chosenRadioButton) {
            case USER:
                if (value.equals(VALUE_TO_REPLACE)) {
                    value = getAllActiveInternalUsersStream(APIConstants.DESC).map(UserData::getName).findFirst()
                            .orElse(null);
                }
                dueDiligenceOrderApprovalPage.selectUserApproverForRule(value, ruleNumber);
                break;
            case USER_GROUP:
                dueDiligenceOrderApprovalPage.selectUserGroupApproverForRule(value, ruleNumber);
                break;
            default:
                throw new IllegalArgumentException(
                        "Error! Radio Button - " + chosenRadioButton + " is not supported!");
        }

    }

    @When("User deletes all rules except default on DDO Approval page")
    public void deleteAllRulesOnDdoPage() {
        dueDiligenceOrderApprovalPage.deleteAllRulesExceptDefault();
    }

    @When("User clicks Reset button on DDO Approval page")
    public void clickResetButtonOnDdoApprovalPage() {
        dueDiligenceOrderApprovalPage.clickResetButton();
    }

    @When("User deletes values for rule {int} on DDO Approver page")
    public void deleteValuesForRule(Integer number) {
        dueDiligenceOrderApprovalPage.deleteRuleValueIcons(number);
    }

    @When("User clicks {string} for DDO Approval rule {int} radio button")
    public void clicksDefaultApproverRadioButton(String radioButtonName, Integer ruleNumber) {
        dueDiligenceOrderApprovalPage.selectRuleRadio(ruleNumber, radioButtonName);
    }

    @When("User sets up Due Diligence Order Approval Responsible Party Default Approver via API")
    public void setUpDueDiligenceOrderApprovalResponsiblePartyDefaultApproverViaAPI() {
        OrderApproval currentOrderApproval = getOrderApproval();
        currentOrderApproval.setDefaultAssignee(new OrderApproval.Assignee().setType(RESPONSIBLE_PARTY));
        postOrderApproval(currentOrderApproval);
    }

    @When("User selects values for DDO Approval rule {int} dropdown {string}")
    public void selectDdoApprovalRuleValues(Integer ruleNumber, String values) {
        if (values.equals("WorkflowGroup")) {
            dueDiligenceOrderApprovalPage.fillInRuleOptions(ruleNumber);
        } else {
            dueDiligenceOrderApprovalPage.fillInRuleOptions(ruleNumber, values);
        }
    }

    @When("User for DDO Approval selects for rule {int} type {string}")
    public void selectDDOApprovalRuleType(int ruleNumber, String ruleType) {
        dueDiligenceOrderApprovalPage.selectRuleType(ruleType, ruleNumber);
    }

    @When("User opens Due Diligence Order Approval page")
    public void openDueDiligenceOrderApprovalPage() {
        dueDiligenceOrderApprovalPage.navigateToDueDiligenceApprovalPage();
    }

    @When("User selects for DDO Approval rule {int} value {string}")
    public void openDueDiligenceOrderApprovalPage(Integer ruleNumber, String value) {
        dueDiligenceOrderApprovalPage.selectUserApproverForRule(value, ruleNumber);
    }

    @When("User clicks Default Approver Advanced Search")
    public void clickDefaultApproverAdvancedSearch() {
        dueDiligenceOrderApprovalPage.clickDefaultApproverAdvancedSearch();
        lastName = null;
        firstName = null;
        groupName = null;
    }

    @When("User fills in Default Approver Advanced search {string} input {string}")
    public void fillInDefaultApproverAdvancedSearchInput(String inputField, String value) {
        dueDiligenceOrderApprovalPage.fillInSearchValue(inputField, value);
        if (LAST_NAME.getName().equals(inputField)) {
            lastName = value;
        } else if (FIRST_NAME.getName().equals(inputField)) {
            firstName = value;
        } else if (GROUP_NAME.getField().equals(inputField)) {
            groupName = value;
        }
    }

    @When("User clicks DD Order Approval Advanced search {string} button")
    public void clickAdvancedSearchButton(String buttonName) {
        dueDiligenceOrderApprovalPage.clickAdvancedSearchButton(buttonName);
    }

    @When("User selects Default Approver Advanced search result {string}")
    public void selectDefaultApproverAdvancedSearchResult(String resultName) {
        dueDiligenceOrderApprovalPage.clickAdvancedSearchResult(resultName);
    }

    @When("User clicks {string} DD Order default approver radio button")
    public void clickDDOrderDefaultApproverRadioButton(String buttonName) {
        dueDiligenceOrderApprovalPage.clickDefaultApproverRadioButton(buttonName);
    }

    @When("User clicks DDO Approval Save button")
    public void clickDDOApprovalSaveButton() {
        dueDiligenceOrderApprovalPage.clickSaveButton();
    }

    @When("User selects {string} in DD order Default approver dropdown")
    public void selectForInDDOrderDefaultApproverDropdown(String value) {
        dueDiligenceOrderApprovalPage.selectDefaultApproverDropdown(value);
    }

    @Then("Due Diligence Order Approval page should be opened")
    public void checkDueDiligenceOrderApprovalPageIsOpened() {
        assertThat(dueDiligenceOrderApprovalPage.isPageLoaded())
                .as("Due Diligence Order Approval page wasn't opened")
                .isTrue();
    }

    @Then("Default Approver radio buttons should be displayed")
    public void isDefaultApproverRadioButtonDisplayed(DataTable table) {
        SoftAssert soft = new SoftAssert();
        List<String> expectedRadioNames = table.asList();
        expectedRadioNames.forEach(radioButton -> soft
                .assertTrue(dueDiligenceOrderApprovalPage.isDefaultApproverRadioNameDisplayed(radioButton),
                            radioButton + " - radio button is not displayed"));
    }

    @Then("Default Approver should have link Advanced Search {string}")
    public void checkAdvancedSearchState(String state) {
        switch (state) {
            case ENABLED:
                assertThat(dueDiligenceOrderApprovalPage.isDefaultApproverAdvancedSearchLinkDisabled())
                        .as("Advanced Search link is disabled").isFalse();
                break;
            case DISABLED:
                assertThat(dueDiligenceOrderApprovalPage.isDefaultApproverAdvancedSearchLinkDisabled())
                        .as("Advanced Search link is enabled").isTrue();
                break;
            default:
                throw new IllegalArgumentException("Attribute'" + state + "' is unexpected");
        }
    }

    @Then("DDO Approver rule {int} should have link Advanced Search {string}")
    public void checkDDOApproverRuleAdvancedSearchLinkEnabled(Integer ruleNumber, String attribute) {
        switch (attribute) {
            case ENABLED:
                assertThat(dueDiligenceOrderApprovalPage.isRuleAdvancedSearchLinkDisabled(ruleNumber + 1))
                        .as("Advanced Search link is disabled").isFalse();
                break;
            case DISABLED:
                assertThat(dueDiligenceOrderApprovalPage.isRuleAdvancedSearchLinkDisabled(ruleNumber + 1))
                        .as("Advanced Search link is enabled").isTrue();
                break;
            default:
                throw new IllegalArgumentException("Attribute'" + attribute + "' is unexpected");
        }
    }

    @Then("DDO default approver drop-down contains only active users")
    public void checkDefaultApproverDropDownContainsActiveUsers() {
        dueDiligenceOrderApprovalPage.cleanDefaultApproverDropdown();
        dueDiligenceOrderApprovalPage.clickDefaultApproverDropdown();
        dueDiligenceOrderApprovalPage.clickDefaultApproverDropdown();
        List<String> usersInDropDown = dueDiligenceOrderApprovalPage.getDropDownValues()
                .stream().map(item -> item.replace(ROW_DELIMITER, SPACE))
                .collect(Collectors.toList());
        usersInDropDown.remove(DROPDOWN_PLACEHOLDER);
        assertThat(usersInDropDown)
                .as("Approver\\(s) drop-down doesn't contain all active users")
                .isEqualTo(getActiveUsers());
    }

    @Then("DDO approver drop-down for rule {int} contains only active users")
    public void checkDDOApproverDropDownContainsActiveUsers(Integer ruleNumber) {
        dueDiligenceOrderApprovalPage.clickApproverDropdown(ruleNumber);
        List<String> usersInDropDown = dueDiligenceOrderApprovalPage.getDropDownValues()
                .stream().map(item -> item.replace(ROW_DELIMITER, SPACE))
                .collect(Collectors.toList());
        usersInDropDown.remove(DROPDOWN_PLACEHOLDER);
        assertThat(usersInDropDown)
                .as("Approver drop-down doesn't contain all active users")
                .isEqualTo(getActiveUsers());
    }

    @Then("Default DD order Approver drop-down contains all active user groups")
    public void approverDropDownContainsAllActiveUserGroups() {
        List<String> expectedResult = getUserGroupNamesByStatus(ACTIVE_STATUS)
                .stream().map(item -> item.replace(DOUBLE_SPACE, SPACE).trim())
                .collect(Collectors.toList());
        dueDiligenceOrderApprovalPage.cleanDefaultApproverDropdown();
        List<String> actualResult = dueDiligenceOrderApprovalPage.getDropDownValues();
        assertThat(expectedResult)
                .as("Approver drop-down doesn't contain all active user groups")
                .containsAll(actualResult);
    }

    @Then("DD Order Approver drop-down contains all active user groups in rule {int}")
    public void approverDropDownContainsAllActiveUserGroups(Integer ruleNumber) {
        List<String> expectedResult = getUserGroupNamesByStatus(ACTIVE_STATUS)
                .stream().map(item -> item.replace(DOUBLE_SPACE, SPACE).trim())
                .collect(Collectors.toList());
        dueDiligenceOrderApprovalPage.cleanApproverDropdown(ruleNumber);
        List<String> actualResult = dueDiligenceOrderApprovalPage.getDropDownValues();
        assertThat(expectedResult)
                .as("Approver drop-down doesn't contain all active user groups")
                .containsAll(actualResult);
        dueDiligenceOrderApprovalPage.enterViaKeyboard(Keys.ESCAPE);
    }

    @Then("DDO Approver rule {int} should have options")
    public void checkRuleOptions(Integer ruleNumber, DataTable table) {
        List<String> expectedOptions = table.asList();
        List<String> actualOptions = dueDiligenceOrderApprovalPage.getRuleOptions(ruleNumber);
        assertThat(actualOptions).as("Rule dropdown options are incorrect: " + actualOptions)
                .isEqualTo(expectedOptions);
    }

    @Then("DDO Approval should have link Add Rules {string}")
    public void checkDDOApprovalAddRulesLink(String attribute) {
        switch (attribute) {
            case ENABLED:
                assertThat(dueDiligenceOrderApprovalPage.isAddRulesButtonDisabled())
                        .as("Add Rule button is disabled").isFalse();
                break;
            case DISABLED:
                assertThat(dueDiligenceOrderApprovalPage.isAddRulesButtonDisabled())
                        .as("Add Rule button is enabled").isTrue();
                break;
            default:
                throw new IllegalArgumentException("Attribute'" + attribute + "' is unexpected");
        }
    }

    @Then("Under {string} dropdown there is an error message: {string}")
    public void verifyDropdownErrorMessage(String fieldName, String errorMessage) {
        assertEquals("Dropdown error message isn't matched with expected one",
                     dueDiligenceOrderApprovalPage.getDropdownErrorText(fieldName), errorMessage);
    }

    @Then("Approver Rules contains {int} rules")
    public void approverRulesContainsRules(int expectedRulesCount) {
        assertThat(dueDiligenceOrderApprovalPage.getApproverRulesCount())
                .as("Approver Rules count is unexpected")
                .isEqualTo(expectedRulesCount);
    }

    @Then("Delete button is not displayed for default approval rule")
    public void deleteButtonIsNotDisplayedForDefaultApprovalRule() {
        assertThat(dueDiligenceOrderApprovalPage.isDeleteButtonDisplayed(1))
                .as("Delete button is displayed for default approval rule")
                .isFalse();
    }

    @Then("Advanced search form {string} appears")
    public void advancedSearchFormAppears(String formName) {
        dueDiligenceOrderApprovalPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(dueDiligenceOrderApprovalPage.getDialogTitle())
                .as("Advanced search form %s is not displayed", formName)
                .isEqualTo(formName);
    }

    @Then("Default Approver Advanced search contains results")
    public void defaultApproverAdvancedSearchContainsResults(List<UserData> expectedResult) {
        assertThat(dueDiligenceOrderApprovalPage.getSearchResults())
                .as("Default Approver Advanced search doesn't contain expected results")
                .containsAll(expectedResult);
    }

    @Then("Default Approver {string} for DD order is selected")
    public void defaultApproverIsSelected(String expectedValue) {
        assertThat(dueDiligenceOrderApprovalPage.getDefaultApproverValue())
                .as("Expected Default Approver is not selected")
                .isEqualTo(expectedValue);
    }

    @Then("Default Approver Advanced search {string} is displayed")
    public void defaultApproverAdvancedSearchIsDisplayed(String emptyResultText) {
        assertThat(dueDiligenceOrderApprovalPage.getAdvancedSearchEmptyResult())
                .as("%s is not displayed", emptyResultText)
                .isEqualTo(emptyResultText);
    }

    @Then("Results that match the search request are shown")
    public void resultsThatMatchTheSearchRequestAreShown() {
        assertThat(dueDiligenceOrderApprovalPage.isSearchResultMatchRequest(firstName, lastName, groupName))
                .as("Search results doesn't match the search request")
                .isTrue();
    }

    @Then("Clear Default approver button is displayed")
    public void clearDefaultApproverButtonIsDisplayed() {
        assertThat(dueDiligenceOrderApprovalPage.isClearButtonDisplayed())
                .as("Clear Default approver button is not displayed")
                .isTrue();
    }

    @Then("Default Approver Advanced search table contains sortable columns")
    public void defaultApproverAdvancedSearchTableContainsSortableColumns(List<String> expectedColumns) {
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(dueDiligenceOrderApprovalPage.getSearchResultTableColumns())
                .as("Advanced search table columns are not expected")
                .containsAll(expectedColumns);
        expectedColumns.forEach(
                column -> softAssertions.assertThat(dueDiligenceOrderApprovalPage.isColumnSortable(capitalize(column)))
                        .as("Column %s is not sortable", column)
                        .isTrue());
        softAssertions.assertAll();
    }

}
