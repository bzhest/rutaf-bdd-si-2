package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.workflowManagement.renewalSettings;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.SIPublicApi;
import com.refinitiv.asts.test.ui.api.model.SiPublicReferencesResponse;
import com.refinitiv.asts.test.ui.constants.APIConstants;
import com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.renewalSettings.WorkflowManagementRenewalPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowGroupData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.logging.log4j.util.Strings;
import org.assertj.core.api.SoftAssertions;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getReferencesUserGroups;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.getWorkflowGroupsList;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Colors.*;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.ValueTypeName.*;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.*;
import static java.util.stream.Collectors.toList;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.*;

public class WorkflowManagementRenewalSteps extends BaseSteps {

    private static final String FIELD_NAME = "fieldName";
    private static final String INPUT_TYPE = "inputType";
    private static final String IS_DISABLED = "isDisabled";
    private static final String VALUE_TO_REPLACE_ADVANCED_SEARCH_USER = "toBeReplacedAdvancedSearchUser";
    private static final String VALUE_TO_REPLACE_ADVANCED_SEARCH_USER_GROUP = "toBeReplacedAdvancedSearchUserGroup";
    private static final String USER = "User";
    private static final String USER_GROUP = "User Group";
    private static final String RULE_DROPDOWN_NAME = "Rule";
    private static final String ASSIGNEE_DROPDOWN_NAME = "Assignee";
    private static final String ATTRIBUTE_VALUE_RADIO = "radio";
    private static final String NEXT_RENEWAL_DATE = "next renewal date";
    private static final String DAYS_BEFORE_RENEWAL = "days before renewal";
    private static final String COUNTRIES = "countries";
    private static final String ACTIVE_WORKFLOW_GROUPS = "active workflow groups";
    private static final String COMMODITY_TYPES = "commodity types";
    private static final String DO_NOT_CHECK = "do not check";
    private static final int MAX_ALLOWED_RULES = 20;
    private static final String ACTIVE_STATUS = "true";

    private final WorkflowManagementRenewalPage renewalSettingsPage;

    public WorkflowManagementRenewalSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.renewalSettingsPage = new WorkflowManagementRenewalPage(driver);
    }

    @When("User clicks Workflow Management Renewal Settings submenu in Set Up menu")
    public void clickWorkflowManagementSubmenuRenewalSettings() {
        renewalSettingsPage.clickWorkflowManagementSubmenuRenewalSettings();
        renewalSettingsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User navigates to Workflow Management Renewal Settings page")
    public void navigateWorkflowManagementSubmenuRenewalSettingsPage() {
        renewalSettingsPage.navigateToWorkflowRenewalSettings();
        renewalSettingsPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks {string} default assignee radio button")
    public void clicksDefaultAssigneeRadioButton(String radioButtonName) {
        renewalSettingsPage.clickDefaultAssigneeRadioButton(radioButtonName);
    }

    @When("User selects {string} for {string} in Default Assignee dropdown")
    public void selectValueFromDefaultAssigneeDropdown(String value, String chosenRadioButton) {
        switch (chosenRadioButton) {
            case USER:
                if (value.equals(VALUE_TO_REPLACE)) {
                    value = getAllActiveInternalUsersStream(APIConstants.DESC).map(UserData::getName).findFirst()
                            .orElse(null);
                    context.getScenarioContext().setContext(RENEWAL_SETTINGS_USER_DEFAULT_ASSIGNEE, value);
                }
                renewalSettingsPage.selectValueFromDefaultAssigneeDropdown(value);
                break;
            case USER_GROUP:
                if (value.equals(VALUE_TO_REPLACE)) {
                    value = ConnectApi.getUserGroupNamesByStatus(ACTIVE_STATUS).stream().findFirst().orElse(null);
                }
                renewalSettingsPage.selectValueFromDefaultAssigneeDropdown(value);
                context.getScenarioContext().setContext(RENEWAL_SETTINGS_USER_GROUP_DEFAULT_ASSIGNEE, value);
                break;
            default:
                throw new IllegalArgumentException(
                        "Error! Radio Button - " + chosenRadioButton + " is not supported!");
        }

    }

    @When("User deletes previously created rule {string}")
    public void deletePreviouslyCreatedRule(String ruleNumber) {
        if (ruleNumber.equals(VALUE_TO_REPLACE)) {
            int numberOfExistingRules = renewalSettingsPage.getAddedAssigneeRulesCount();
            if (numberOfExistingRules > 0) {
                ruleNumber = String.valueOf(numberOfExistingRules);
            } else {
                throw new IllegalArgumentException(numberOfExistingRules + " Rule cannot be deleted!");
            }
        }
        renewalSettingsPage.clickRemoveRuleIconForRuleWithIndex(ruleNumber);
        renewalSettingsPage.clickSaveButton();
        context.getScenarioContext().setContext(RENEWAL_SETTINGS_DELETED_RULE, ruleNumber);
    }

    @When("^User clicks Renewal Settings Save button")
    public void clickRenewalSettingsSaveButton() {
        renewalSettingsPage.closeAlertIconIfDisplayed();
        renewalSettingsPage.clickSaveButton();
    }

    @When("User clicks Default Assignee section Advance Search link")
    public void clickDefaultAssigneeSectionAdvanceSearchLink() {
        renewalSettingsPage.clickDefaultAssigneeSectionAdvanceSearchLink();
    }

    @When("User clicks 'Rule' dropdown for last added rule")
    public void clickRuleDropDownForLastAddedRule() {
        renewalSettingsPage.clickRuleDropDownOfLastAddedRule();
    }

    @When("User selects {string} from 'Rule' dropdown of last added rule")
    public void selectValueFromRuleDropDownOfLastAddedRule(String value) {
        renewalSettingsPage.selectValueFromRuleDropDownOfLastAddedRule(value);
    }

    @When("User selects {int} value\\(s) from Rule Value dropdown of last added rule")
    public void selectRandomValuesInRuleValueDropDownOfLastAddedRule(int number) {
        renewalSettingsPage.selectRandomValuesInRuleValueDropDownForLastAddedRule(number);
    }

    @When("User selects for rule {string} assignee {string}")
    public void selectAssigneeForRule(String number, String assignee) {
        if (!assignee.equalsIgnoreCase(NOT_APPLICABLE)) {
            renewalSettingsPage.selectRuleAssignee(assignee, number);
        }
    }

    @When("User selects rule {string}")
    public void selectAssigneeForRule(String rule) {
        renewalSettingsPage.selectValueFromValueDropdown(rule);
    }

    @When("User selects for rule {string} value {string}")
    public void selectValueForRule(String number, String ruleValue) {
        renewalSettingsPage.selectRuleValue(ruleValue, number);
    }

    @When("User deletes values for rule {string}")
    public void deleteValuesForRule(String number) {
        renewalSettingsPage.deleteRuleValueIcons(number);
    }

    @When("User removes {int} value from Rule Value dropdown of last added rule")
    public void removeRandomValuesFromRuleValueDropDownOfLastAddedRule(int number) {
        renewalSettingsPage.removeRandomValuesFromRuleValueDropDownOfLastAddedRule(number);
    }

    @When("User selects Assignee Rule {string} radio button of last added rule")
    public void selectAssigneeRuleRadioOfLastAddedRule(String name) {
        renewalSettingsPage.selectAssigneeRulesRadioOfLastAddedRule(name);
    }

    @When("User makes sure that Assignee Rule with default setup is added")
    public void addDefaultAssigneeRule() {
        if (renewalSettingsPage.isAddRulesButtonEnabled()) {
            renewalSettingsPage.clickAddRulesButton();
            context.getScenarioContext()
                    .setContext(RENEWAL_SETTINGS_LAST_ADDED_RULE, renewalSettingsPage.getIndexNumberOfLastAddedRule());
        }
    }

    @When("User clicks 'Add Rules' button")
    public void clickAddRulesButton() {
        renewalSettingsPage.clickAddRulesButton();
    }

    @When("User adds {int} Renewal Assignee Rules")
    public void addNumberOfAssigneeRules(int numberOfRules) {
        if (numberOfRules < MAX_ALLOWED_RULES) {
            context.getScenarioContext().setContext(RENEWAL_SETTINGS_RULES_COUNTER, numberOfRules);
        } else if (numberOfRules == MAX_ALLOWED_RULES) {
            int numberOfExistingRules = renewalSettingsPage.getAddedAssigneeRulesCount();
            numberOfRules = numberOfRules - numberOfExistingRules;
        } else {
            throw new IllegalArgumentException("Exceeded max allowed number of rules(max=20)!");
        }
        addRules(numberOfRules);
    }

    @When("^User clicks (Next Renewal Date|Days Before Renewal) radio button$")
    public void clickRenewalTriggerByRadioButton(String radioName) {
        switch (radioName.toLowerCase()) {
            case NEXT_RENEWAL_DATE:
                renewalSettingsPage.clickNextRenewalDateRadio();
                break;
            case DAYS_BEFORE_RENEWAL:
                renewalSettingsPage.clickDaysBeforeRenewalRadio();
                break;
            default:
                throw new IllegalArgumentException("Radio button name - " + radioName + " is unknown");
        }
    }

    @When("User fills in 'Days Before Renewal' text input with {string}")
    public void fillInDaysBeforeRenewalText(String daysNumber) {
        renewalSettingsPage.fillInDaysBeforeRenewalText(daysNumber);
    }

    @When("User deletes all renewal rules except one")
    public void deleteAllRenewalRulesExceptOne() {
        int numberOfExistingRules = renewalSettingsPage.getAddedAssigneeRulesCount();
        if (numberOfExistingRules > 1) {
            for (int i = numberOfExistingRules; i > 1; i--) {
                renewalSettingsPage.clickRemoveRuleIconForRuleWithIndex(String.valueOf(i));
            }
        }
    }

    @Then("Renewal Settings page is displayed")
    public void isRenewalSettingsPageDisplayed() {
        assertTrue("Renewal Setting Header is not displayed!", renewalSettingsPage.isRenewalSettingsPageDisplayed());
    }

    @Then("Renewal Settings page has {string} section")
    public void renewalSettingsPageHasSectionWithName(String sectionName) {
        assertTrue("Section with name " + sectionName + " is not displayed!",
                   renewalSettingsPage.isSectionWithNameDisplayed(sectionName));
    }

    @Then("Renewal Settings page Default Assignee section has the following fields")
    public void renewalSettingsPageSectionHasTheFollowingFields(DataTable data) {
        SoftAssert softAssert = new SoftAssert();
        List<Map<String, String>> expectedData = data.asMaps();
        expectedData.forEach(value -> {
            softAssert.
                    assertTrue(renewalSettingsPage.isDefaultAssigneeRadioButtonDisplayedWithName(value.get(FIELD_NAME)),
                               "Radio button with name: '" + value.get(FIELD_NAME) + "' is not displayed!");
            softAssert.
                    assertEquals(renewalSettingsPage.getDefaultAssigneeRadioButtonTypeAttribute(value.get(FIELD_NAME)),
                                 value.get(INPUT_TYPE),
                                 value.get(FIELD_NAME) + " radio button does not have expected type: " +
                                         value.get(INPUT_TYPE));
            softAssert.
                    assertEquals(
                            renewalSettingsPage.getDefaultAssigneeRadioButtonEnabledAttribute(value.get(FIELD_NAME)),
                            value.get(IS_DISABLED),
                            value.get(FIELD_NAME) + " radio button is not enabled!");
            softAssert.assertAll();
        });
    }

    @Then("Default Assignee section Default Assignee dropdown is displayed")
    public void isRenewalSettingsDefaultAssigneeDropdownDisplayed() {
        assertTrue("Default Assignee dropdown is not displayed!",
                   renewalSettingsPage.isRenewalSettingsDefaultAssigneeDropdownDisplayed());
    }

    @Then("Default Assignee dropdown becomes enabled")
    public void isDefaultAssigneeDropdownEnabled() {
        assertFalse("Default Assignee dropdown is not enabled!",
                    renewalSettingsPage.isDefaultAssigneeDropdownDisabled());
    }

    @Then("Default Assignee dropdown becomes disabled")
    public void isDefaultAssigneeDropdownDisabled() {
        assertTrue("Default Assignee dropdown is not disabled!",
                   renewalSettingsPage.isDefaultAssigneeDropdownDisabled());
    }

    @Then("Alert Icon for Renewal Settings page is displayed with text")
    public void alertIconIsDisplayedWithText(DataTable dataTable) {
        alertIconIsDisplayedWithText(renewalSettingsPage, dataTable);
        renewalSettingsPage.closeAlertIconIfDisplayed();
    }

    @Then("Default Assignee dropdown contains 20 Active Internal users")
    public void doesDefaultAssigneeDropdownContains20ActiveInternalUsers() {
        List<String> expectedUsersList = getTop20ActiveInternalUsersList();
        List<String> actualUsersList = renewalSettingsPage.getListOfValuesFromDefaultAssigneeDropDown();
        removeEmailsFromList(actualUsersList);
        actualUsersList.remove(DROPDOWN_PLACEHOLDER);
        assertEquals("Default Assignee dropdown contains not expected list of Internal Users!",
                     sortListInNaturalOrder(expectedUsersList),
                     sortListInNaturalOrder(actualUsersList));
    }

    @Then("Default Assignee dropdown contains all Active Internal user groups")
    public void doesDefaultAssigneeDropdownContainsAllActiveInternalUserGroups() {
        List<String> userGroupsList = ConnectApi.getListOfActiveUserGroups();
        List<String> expectedUserGroupsList =
                userGroupsList.stream().map(userGroup -> userGroup.trim().replace(DOUBLE_SPACE, SPACE)).sorted()
                        .collect(Collectors.toList());
        List<String> actualUserGroupsList =
                renewalSettingsPage.getListOfValuesFromDefaultAssigneeDropDown().stream().sorted()
                        .collect(Collectors.toList());
        assertThat(actualUserGroupsList).as(
                        "Default Assignee dropdown does not contain all Active Internal user groups")
                .isEqualTo(expectedUserGroupsList);
    }

    @Then("Renewal Settings page has Save button")
    public void isSaveButtonDisplayed() {
        assertTrue("Save button is not displayed!", renewalSettingsPage.isSaveButtonDisplayed());
    }

    @Then("Value in Default Assignee dropdown is cleared")
    public void isDefaultAssigneeDropdownEmpty() {
        assertTrue("Default Assignee dropdown is not cleared!", renewalSettingsPage.isDefaultAssigneeDropdownEmpty());
    }

    @Then("Error message {string} with red border is displayed for Default Assignee dropdown")
    public void isErrorMessageWithRedBorderDisplayed(String errorMessage) {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(renewalSettingsPage.getErrorMessageText())
                .as("Default Assignee dropdown error message is not displayed")
                .isEqualTo(errorMessage);
        softAssert.assertThat(renewalSettingsPage.doesDefaultAssigneeDropdownContainError())
                .as("Default Assignee dropdown doesn't contain errors")
                .isTrue();
        softAssert.assertThat(renewalSettingsPage.getDefaultAssigneeFieldErrorMessageElementCSS(COLOR))
                .as("Default Assignee dropdown error message is not red")
                .containsPattern(REACT_RED_PATTERN.getColorRgba());
        softAssert.assertAll();
    }

    @Then("{string} default assignee radio button is checked")
    public void isDefaultAssigneeRadioButtonChecked(String radioButtonName) {
        assertTrue(radioButtonName + " radio button is not checked!",
                   renewalSettingsPage.isDefaultAssigneeRadioButtonChecked(radioButtonName));
    }

    @Then("Default Assignee dropdown is displayed with value {string}")
    public void isDefaultAssigneeDropdownDisplayedWithValue(String value) {
        if (value.equals(VALUE_TO_REPLACE)) {
            value = (String) context.getScenarioContext().getContext(RENEWAL_SETTINGS_USER_DEFAULT_ASSIGNEE);
        }
        if (value.equals(VALUE_TO_REPLACE_ADVANCED_SEARCH_USER)) {
            value = (String) context.getScenarioContext().getContext(FIRST_SELECTED_USER_NAME_CONTEXT);
        }
        if (value.equals(VALUE_TO_REPLACE_ADVANCED_SEARCH_USER_GROUP)) {
            value = (String) context.getScenarioContext().getContext(FIRST_SELECTED_USER_GROUP_NAME_CONTEXT);
        }
        assertEquals("Default Assignee dropdown is not displayed with value", value,
                     renewalSettingsPage.getDefaultAssigneeDropdownValue());
    }

    @Then("Default Assignee section Advance Search link is displayed")
    public void isDefaultAssigneeSectionAdvanceSearchLinkDisplayed() {
        assertTrue("Advance Search Link is not displayed!",
                   renewalSettingsPage.isDefaultAssigneeSectionAdvanceSearchLinkDisplayed());
    }

    @Then("'Renewal Settings Rules' section is displayed")
    public void isRenewalSettingsRulesSectionDisplayed() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(renewalSettingsPage.isRenewalSettingsRulesSectionHeaderDisplayed(),
                              "Renewal Settings Rules section Header is not displayed!");
        softAssert.assertTrue(renewalSettingsPage.isRenewalSettingsRulesSectionDisplayed(),
                              "Renewal Settings Rules section is not displayed!");
        softAssert.assertAll();
    }

    @Then("'Renewal Settings Rules' section 'Add Rules' button is displayed")
    public void isAddRulesButtonDisplayed() {
        assertTrue("Renewal Settings Rules section Add Rules button is not displayed!",
                   renewalSettingsPage.isAddRulesButtonDisplayed());
    }

    @Then("'Renewal Settings Rules' section has default enabled Rule dropdown")
    public void isDefaultRuleDropDownDisplayedAndEnabled() {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(renewalSettingsPage.isRuleDropDownOfLastAddedRuleDisplayed())
                .as("Rule dropdown is not displayed!")
                .isTrue();
        softAssert.assertThat(renewalSettingsPage.getRuleDropDownActualNameOfLastAddedRule())
                .as("Rule dropdown is displayed with name: " +
                            renewalSettingsPage.getRuleDropDownActualNameOfLastAddedRule())
                .isEqualTo(RULE_DROPDOWN_NAME);
        softAssert.assertThat(renewalSettingsPage.isRuleDropDownEnabledOfLastAddedRule())
                .as("Rule dropdown is not enabled!")
                .isTrue();
        softAssert.assertAll();
    }

    @Then("'Renewal Settings Rules' section has default disabled Rule Value dropdown")
    public void isDefaultRuleValueDropDownDisplayedAndDisabled() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(renewalSettingsPage.isRuleValueDropDownOfLastAddedRuleDisplayed(),
                              "Rule Value dropdown is not displayed!");
        softAssert.assertFalse(renewalSettingsPage.isRuleValueDropDownOfLastAddedRuleEnabled(),
                               "Rule Value dropdown is not disabled!");
        softAssert.assertAll();
    }

    @Then("'Renewal Settings Rules' section has default disabled Assignee dropdown")
    public void isDefaultAssigneeDropDownDisplayedAndDisabled() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(renewalSettingsPage.isAssigneeDropDownOfLastAddedRuleDisplayed(),
                              "Assignee dropdown is not displayed!");
        softAssert.assertEquals(renewalSettingsPage.getAssigneeDropDownActualNameOfLastAddedRule(),
                                ASSIGNEE_DROPDOWN_NAME,
                                "Assignee dropdown is displayed with not expected name!");
        softAssert.assertFalse(renewalSettingsPage.isAssigneeDropDownOfLastAddedRuleEnabled(),
                               "Assignee dropdown is not disabled!");
        softAssert.assertAll();
    }

    @Then("'Renewal Settings Rules' section has default disabled {string} radio button")
    public void isDefaultRadioButtonDisplayedAndDisabled(String name) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(renewalSettingsPage.isRulesRadioButtonOfLastAddedRuleDisplayed(name),
                              name + " radio button is not displayed!");
        softAssert.assertFalse(renewalSettingsPage.isRulesRadioButtonOfLastAddedRuleEnabled(name),
                               name + " radio button is not disabled!");
        softAssert.assertAll();
    }

    @Then("'Rule' dropdown of last added rule contains {string} value")
    public void isRuleDropDownOfLastAddedRuleContainsValue(String value) {
        assertTrue("Rule dropdown does not contain value: " + value,
                   renewalSettingsPage.isRuleDropDownOfLastAddedRuleContainsValue(value));
    }

    @Then("'Rule value' dropdown of last added rule becomes enabled")
    public void isRuleValueDropDownOfLastAddedRuleEnabled() {
        assertTrue("Rule Value dropdown is not enabled!",
                   renewalSettingsPage.isRuleValueDropDownOfLastAddedRuleEnabled());
    }

    @Then("{string} radio button of last added rule becomes enabled")
    public void isRadioButtonOfLastAddedRuleEnabled(String name) {
        assertTrue("Radio button '" + name + " is not enabled!",
                   renewalSettingsPage.isRulesRadioButtonOfLastAddedRuleEnabled(name));
    }

    @Then("{int} selected value\\(s) is\\(are) displayed in Rule Value dropdown of last added rule")
    public void areNumberOfSelectedValuesOfLastAddedRuleDisplayed(int number) {
        assertEquals("Number of displayed values selected in Rule Value dropdown is less/more than expected!", number,
                     renewalSettingsPage.getNumberOfValuesSelectedInRuleValueOfLastAddedRule());
    }

    @Then("Assignee dropdown of last added rule becomes enabled")
    public void isAssigneeDropDownOfLastAddedRuleEnabled() {
        assertTrue("Assignee dropdown is not enabled!",
                   renewalSettingsPage.isAssigneeDropDownOfLastAddedRuleEnabled());
    }

    @Then("Assignee dropdown contains 20 Active Internal Users")
    public void are20ActiveInternalUsersListedInAssigneeDD() {
        List<String> expectedUsersList = getTop20ActiveInternalUsersList();
        List<String> actualUsersList = getActualListOfValuesFromAssigneeDropDown();
        removeEmailsFromList(actualUsersList);
        actualUsersList.remove(DROPDOWN_PLACEHOLDER);
        assertEquals("Assignee dropdown contains not expected list of Internal Users!",
                     sortListInNaturalOrder(expectedUsersList),
                     sortListInNaturalOrder(actualUsersList));
    }

    @Then("Assignee dropdown contains all Active User Groups")
    public void areAllActiveUserGroupsListedInAssigneeDD() {
        List<String> expectedUserGroupsList =
                getReferencesUserGroups().getData().stream().map(SiPublicReferencesResponse.Reference::getGroupName)
                        .sorted()
                        .collect(toList());
        List<String> actualUserGroupsList = getActualListOfValuesFromAssigneeDropDown().stream()
                .map(group -> group.replace(DOUBLE_SPACE, SPACE).trim()).collect(Collectors.toList());
        assertEquals("Assignee dropdown contains not expected list of User Groups!", expectedUserGroupsList,
                     actualUserGroupsList);
    }

    @Then("Assignee dropdown of last added rule becomes disabled")
    public void isAssigneeDropDownOfLastAddedRuleDisabled() {
        assertFalse("Assignee dropdown is still enabled!",
                    renewalSettingsPage.isAssigneeDropDownOfLastAddedRuleEnabled());
    }

    @Then("Assignee dropdown of last added rule is empty")
    public void isAssigneeDropDownOfLastAddedRuleEmpty() {
        assertEquals("Assignee dropdown is not empty!", Strings.EMPTY,
                     renewalSettingsPage.getAssigneeDropdownValueOfLastAddedRule());
    }

    @Then("Error message {string} with red border is displayed for Rule Value dropdown of last added rule")
    public void isErrorMessageWithRedBorderDisplayedForRuleValueOfLastAddedRule(String errorMessage) {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(renewalSettingsPage.getErrorMessageTextOfLastAddedRuleRuleValueDropDown())
                .as("Rule Value dropdown error message is not displayed")
                .isEqualTo(errorMessage);
        softAssert.assertThat(renewalSettingsPage.doesRuleValueDropDownOfLastAddedRuleContainError())
                .as("Rule Value dropdown doesn't contain errors")
                .isTrue();
        softAssert.assertThat(renewalSettingsPage.getRuleValueErrorMessageElementCSSOfLastAddedRule(COLOR))
                .as("Rule Value dropdown error message is not red")
                .contains(REACT_RED.getColorRgba());
        softAssert.assertAll();

    }

    @Then("Error message {string} with red border is displayed for Assignee dropdown of last added rule")
    public void isErrorMessageWithRedBorderDisplayedForAssigneeOfLastAddedRule(String errorMessage) {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(renewalSettingsPage.getErrorMessageTextOfLastAddedRuleAssigneeDropDown())
                .as("Assignee dropdown error message is not displayed")
                .isEqualTo(errorMessage);
        softAssert.assertThat(renewalSettingsPage.doesAssigneeDropDownOfLastAddedRuleContainError())
                .as("Assignee dropdown doesn't contain errors")
                .isTrue();
        softAssert.assertThat(renewalSettingsPage.getAssigneeErrorMessageElementCSSOfLastAddedRule(COLOR))
                .as("Assignee dropdown error message is not red")
                .containsPattern(REACT_RED_PATTERN.getColorRgba());
        softAssert.assertAll();
    }

    @Then("{string} Assignee Rule radio button of last added rule is ticked")
    public void isAssigneeRuleRadioButtonOfLastAddedRuleChecked(String name) {
        assertTrue(name + " radio button is not displayed!",
                   renewalSettingsPage.isRulesRadioButtonOfLastAddedRuleDisplayed(name));
    }

    @Then("Renewal Trigger By section has 'Next Renewal Date' radio button")
    public void isNextRenewalDateRadioDisplayed() {
        String nextRenewalDateRadioName = "Next renewal date";
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(renewalSettingsPage.isNextRenewalDateRadioDisplayed(),
                              "'Next Renewal Date' radio button is not displayed!");
        softAssert.assertEquals(renewalSettingsPage.getNextRenewalDateRadioName(), nextRenewalDateRadioName,
                                "'Next Renewal Date' radio button actual name is not expected!");
        softAssert.assertEquals(renewalSettingsPage.getNextRenewalDateRadioTypeAttribute(), ATTRIBUTE_VALUE_RADIO,
                                "'Next Renewal Date' is not a radio button!");
        softAssert.assertAll();
    }

    @Then("Renewal Trigger By section has 'Days Before Renewal' radio button with text input field")
    public void isDaysBeforeRenewalRadioAndTextDisplayed() {
        String daysBeforeRenewalRadioName = "Days Before Renewal";
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(renewalSettingsPage.isDaysBeforeRenewalRadioDisplayed(),
                              "'Days Before Renewal' radio button is not displayed!");
        softAssert.assertEquals(renewalSettingsPage.getDaysBeforeRenewalRadioName(), daysBeforeRenewalRadioName,
                                "'Days Before Renewal' radio button actual name is not expected!");
        softAssert.assertEquals(renewalSettingsPage.getDaysBeforeRenewalRadioTypeAttribute(), ATTRIBUTE_VALUE_RADIO,
                                "'Days Before Renewal' is not a radio button!");
        softAssert.assertTrue(renewalSettingsPage.isDaysBeforeRenewalTextInputDisplayed(),
                              "'Days Before Renewal' text input is not displayed!");

        softAssert.assertAll();
    }

    @Then("^'Days Before Renewal' text input is (enabled|disabled)$")
    public void isDaysBeforeRenewalEnabled(String textInputState) {
        if (textInputState.equals(ENABLED)) {
            assertThat(renewalSettingsPage.isDaysBeforeRenewalTextDisabled())
                    .as("'Days Before Renewal' text input is not enabled!").isFalse();
        } else {
            assertThat(renewalSettingsPage.isDaysBeforeRenewalTextDisabled())
                    .as("'Days Before Renewal' text input is not disabled!").isTrue();
        }
    }

    @Then("'Days Before Renewal' text input is empty")
    public void isDaysBeforeRenewalTextEmpty() {
        assertThat(renewalSettingsPage.isDaysBeforeRenewalTextEmpty())
                .as("'Days Before Renewal' text input is not empty!").isTrue();
    }

    @Then("'Days Before Renewal' text input is highlighted RED with message {string}")
    public void isDaysBeforeRenewalTextHighlightedWithMessage(String msg) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(msg, renewalSettingsPage.getDaysBeforeRenewalTextErrorMessage(),
                                "'This is a required field and needs a valid value' is not displayed!");
        softAssert.assertTrue(
                renewalSettingsPage.getDaysBeforeRenewalErrorMessageCSS(COLOR).contains(RED.getColorRgba()),
                "'Days Before Renewal' text is not highlighted in red!");

    }

    @Then("^'Next Renewal Date' radio button is \"(checked|unchecked)\"$")
    public void isNextRenewalDateRadioChecked(String radioState) {
        if (radioState.equals(CHECKED)) {
            assertThat(renewalSettingsPage.isNextRenewalDateRadioChecked())
                    .as("'Next Renewal Date' radio button is not checked").isTrue();
        } else {
            assertThat(renewalSettingsPage.isNextRenewalDateRadioChecked())
                    .as("'Next Renewal Date' radio button is not unchecked").isFalse();
        }

    }

    @Then("'Rule value' dropdown contains all {string}")
    public void doesRuleValueDropDownContainsExpectedListOfValues(String typeOfValues) {
        List<String> actualValues = renewalSettingsPage.getRuleValueDropDownValuesForLastAddedRule();
        switch (typeOfValues.toLowerCase()) {
            case COUNTRIES:
                List<String> expectedListOfCountries =
                        AppApi.getListOfNamesForValueManagementType(getValueTypeId(COUNTRY));
                assertThat(actualValues).as("Rule value dropdown does not contain all the Countries in the system!")
                        .isEqualTo(expectedListOfCountries);
                break;
            case ACTIVE_WORKFLOW_GROUPS:
                List<String> expectedListOfActiveWorkflowGroups =
                        getWorkflowGroupsList(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, DEFAULT_SORT_BY, DEFAULT_SORT)
                                .stream()
                                .filter(option -> option.getStatus().equals(ACTIVE.getStatus()))
                                .map(WorkflowGroupData::getGroupName)
                                .collect(Collectors.toList());
                assertThat(actualValues).as("Rule value dropdown does not contain all the Active Workflow Groups!")
                        .isEqualTo(expectedListOfActiveWorkflowGroups);
                break;
            case COMMODITY_TYPES:
                List<String> expectedListOfCommodityTypes =
                        AppApi.getListOfNamesForValueManagementType(getValueTypeId(COMMODITY_TYPE));
                assertThat(actualValues)
                        .as("Rule value dropdown does not contain all the Supplier Commodity Types in the system!")
                        .isEqualTo(expectedListOfCommodityTypes);
                break;
            case DO_NOT_CHECK:
                break;
            default:
                throw new IllegalArgumentException("Value type -" + typeOfValues + "is invalid!");
        }
    }

    @Then("'Rule value' dropdown contains all Regions in the system")
    public void doesRuleValueDropDownContainAllRegions() {
        List<String> actualValues = renewalSettingsPage.getRuleValueDropDownValuesForLastAddedRule();
        List<String> expectedListOfRegions =
                AppApi.getListOfNamesForValueManagementType(getValueTypeId(REGION));
        assertThat(actualValues).as("Rule value dropdown does not contain all the Countries in the system!")
                .hasSameElementsAs(expectedListOfRegions);
    }

    @Then("{int} Renewal Assignee Rules are displayed")
    public void areNumberOfAssigneeRulesDisplayed(int numberOfRules) {
        int actualNumberOfAlreadyAddedAssigneeRules = renewalSettingsPage.getAddedAssigneeRulesCount();
        assertThat(actualNumberOfAlreadyAddedAssigneeRules).as(numberOfRules + " expected rules are not displayed!")
                .isEqualTo(numberOfRules);
    }

    @Then("Rule {string} is not displayed")
    public void isRuleWithNumberNotDisplayed(String number) {
        if (number.equals(VALUE_TO_REPLACE)) {
            number = (String) context.getScenarioContext().getContext(RENEWAL_SETTINGS_DELETED_RULE);
        }
        assertThat(renewalSettingsPage.isRuleDropDownWithIndexDisplayed(number)).as(number + " Rule is displayed!")
                .isFalse();

    }

    private List<String> getActualListOfValuesFromAssigneeDropDown() {
        return renewalSettingsPage.getListOfValuesFromAssigneeDropDownOfLastAddedRule().stream().sorted()
                .collect(Collectors.toList());
    }

    private List<String> sortListInNaturalOrder(List<String> list) {
        return list.stream().sorted().collect(Collectors.toList());
    }

    private List<String> getTop20ActiveInternalUsersList() {
        return SIPublicApi.getFirstActiveUsers(ALL_ITEMS, INTERNAl_USER_TYPE).stream()
                .map(user -> String.format(USER_FORMAT, user.getFirstName(), user.getLastName())
                        .replace(DOUBLE_SPACE, SPACE)).collect(Collectors.toList()).subList(0, 20);
    }

    private void addAssigneeRuleWithRequiredFieldsToEnableAddRuleButton(List<String> availableValuesInRuleDropDown) {
        renewalSettingsPage.clickAddRulesButton();
        int randomRuleValue = new Random().nextInt(availableValuesInRuleDropDown.size());
        renewalSettingsPage.selectValueFromRuleDropDownOfLastAddedRule(
                availableValuesInRuleDropDown.get(randomRuleValue));
        renewalSettingsPage.selectRandomValuesInRuleValueDropDownForLastAddedRule(1);
    }

    private void addRules(int numberOfRules) {
        clickRuleDropDownForLastAddedRule();
        List<String> availableValuesInRuleDropDown = renewalSettingsPage.getRuleDropDownValuesOfLastAddedRule();
        clickRuleDropDownForLastAddedRule();
        for (int i = 1; i <= numberOfRules; i++) {
            addAssigneeRuleWithRequiredFieldsToEnableAddRuleButton(availableValuesInRuleDropDown);
            context.getScenarioContext().setContext(RENEWAL_SETTINGS_ADDED_RULE_NUMBER + i,
                                                    renewalSettingsPage.getIndexNumberOfLastAddedRule());
        }
    }

    @Then("The max value for 'Days Before Renewal' field is {int} digits")
    public void verifyMaxValueForDaysBeforeRenewal(int maxCount) {
        String digit = "9";
        String outOfBounds = digit.repeat(10);
        fillInDaysBeforeRenewalText(outOfBounds);
        assertThat(renewalSettingsPage.getDaysBeforeRenewalInputValue())
                .as("The max value for 'Days Before Renewal' field is higher than %s", maxCount)
                .isEqualTo(digit.repeat(maxCount));
    }

    @Then("'Delete' button is hidden if there is only one Renewal rule present")
    public void deleteButtonIsHiddenIfOnlyOneRulePresent() {
        int rulesCount = renewalSettingsPage.getAddedAssigneeRulesCount();
        assertThat(rulesCount).as("Rules count is not 1").isEqualTo(1);
        assertThat(renewalSettingsPage.isDeleteRuleIconPresent(String.valueOf(rulesCount)))
                .as("Delete icon is present")
                .isFalse();
    }

}
