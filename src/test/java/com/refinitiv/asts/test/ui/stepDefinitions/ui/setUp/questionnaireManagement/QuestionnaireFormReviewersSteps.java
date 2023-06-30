package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.questionnaireManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.model.Reference;
import com.refinitiv.asts.test.ui.api.model.RegionCountryRequest;
import com.refinitiv.asts.test.ui.api.model.SiPublicReferencesResponse;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RiskScoreEngineResponse;
import com.refinitiv.asts.test.ui.constants.QuestionnaireConstants;
import com.refinitiv.asts.test.ui.pageActions.setUp.questionnaireManagement.QuestionnaireReviewersPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.GenericTestData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.GroupData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowGroupData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getListOfActiveUserGroups;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.*;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.getWorkflowGroupsList;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.DISPLAYED;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.IS_NOT;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_RED;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.*;
import static com.refinitiv.asts.test.ui.pageActions.setUp.questionnaireManagement.QuestionnaireReviewersPage.*;
import static com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.workflowManagement.workflow.ActivitySteps.USER;
import static io.netty.karate.util.internal.StringUtil.isNullOrEmpty;
import static java.lang.String.format;
import static java.util.Arrays.asList;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static java.util.stream.Collectors.toList;
import static java.util.stream.IntStream.range;
import static org.apache.commons.lang3.StringUtils.LF;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertTrue;

public class QuestionnaireFormReviewersSteps extends BaseSteps {

    private static final String USERNAME = "username";
    public static final String USERS = "users";
    public static final String USER_GROUPS = "user groups";
    public static final String THIRD_PARTY_REGION = "Third-party Region";
    public static final String THIRD_PARTY_COUNTRY = "Third-party Country";
    public static final String RISK_TIER = "Risk Tier";
    public static final String THIRD_PARTY_COMMODITY_TYPE = "Third-party Commodity Type";
    public static final String THIRD_PARTY_WORKFLOW_GROUP = "Third-party Workflow Group";
    public static final String QUESTIONNAIRE_SCORE = "Questionnaire Score";
    private final QuestionnaireReviewersPage reviewersPage;

    public QuestionnaireFormReviewersSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.reviewersPage = new QuestionnaireReviewersPage(driver, context, translator);
    }

    @SuppressWarnings("unchecked")
    private List<String> getExpectedDropDownValues(String dropDownName) {
        switch (dropDownName) {
            case USERS:
                List<String> users = getUsers(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, DEFAULT_SORT_BY, DEFAULT_SORT)
                        .getPayload().getData().stream()
                        .filter(userData -> userData.getStatus().equals(ACTIVE.getStatus()) &&
                                INTERNAl_USER_TYPE.equals(userData.getUserType()) && nonNull(userData.getRole()) &&
                                nonNull(userData.getUsername()))
                        .map(user -> String.format(QuestionnaireConstants.USER_FORMAT, user.getFirstName(),
                                                   user.getLastName(),
                                                   user.getUsername()))
                        .collect(Collectors.toList());
                users.add(DROPDOWN_PLACEHOLDER);
                return users;
            case USER_GROUPS:
                return ConnectApi.getListOfActiveUserGroups().stream()
                        .map(group -> group.replace(DOUBLE_SPACE, SPACE).trim())
                        .collect(toList());
            case THIRD_PARTY_REGION:
                return getReferencesRegions().getData().stream()
                        .map(SiPublicReferencesResponse.Reference::getDescription).sorted()
                        .collect(Collectors.toList());
            case THIRD_PARTY_COUNTRY:
                return ConnectApi.getCountries().getReferences().stream()
                        .map(Reference::getDescription).collect(Collectors.toList());
            case RISK_TIER:
                return getRiskScoreEngineRanges().getData().get(0).getRanges().stream()
                        .map(RiskScoreEngineResponse.DataItem.RangesItem::getName).collect(Collectors.toList());
            case THIRD_PARTY_COMMODITY_TYPE:
                return getCommodityTypes().getData().stream()
                        .map(type -> type.getDescription().trim()).collect(Collectors.toList());
            case THIRD_PARTY_WORKFLOW_GROUP:
                return getWorkflowGroupsList(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, DEFAULT_SORT_BY, DEFAULT_SORT)
                        .stream()
                        .filter(option -> option.getStatus().equals(ACTIVE.getStatus()))
                        .map(WorkflowGroupData::getGroupName)
                        .collect(Collectors.toList());
            case QUESTIONNAIRE_SCORE:
                return context.getScenarioContext().isContains(QUESTIONNAIRE_SCORING_LIST) ?
                        ((List<QuestionnaireData>) context.getScenarioContext()
                                .getContext(QUESTIONNAIRE_SCORING_LIST)).stream().map(QuestionnaireData::getScoringName)
                                .collect(toList()) :
                        new ArrayList<>();
            default:
                throw new IllegalArgumentException("Drop-down type: " + dropDownName + " is unexpected");
        }
    }

    @When("^User selects \"((.*))\" as (Main Reviewer|Reviewer)$")
    public void selectDefaultReviewer(String reviewer, String reviewerType) {
        reviewersPage.clickOnReviewerRadioButton(reviewer, reviewerType);
    }

    @When("User fills current user name as Reviewer")
    public void fillInCurrentUserNameAsReviewer() {
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        reviewersPage.fillReviewer((String) getUserDataByEmail(userTestData.getUsername(), NAME_FILTER));
    }

    @When("User fills user {string} as Questionnaire Reviewer")
    public void fillInUserNameAsReviewer(String reviewer) {
        if (!isNullOrEmpty(reviewer)) {
            reviewersPage.fillReviewer(reviewer);
        }
    }

    @When("User fills current user name as Main Reviewer")
    public void fillInCurrentUserNameAsMainReviewer() {
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        reviewersPage.fillMainReviewer((String) getUserDataByEmail(userTestData.getUsername(), NAME_FILTER));
    }

    @When("User fills {string} value as Main Reviewer")
    public void fillUserNameAsMainReviewer(String reviewer) {
        if (reviewer.equals(VALUE_TO_REPLACE)) {
            GroupData data = (GroupData) this.context.getScenarioContext().getContext(GROUP_TEST_DATA_CONTEXT);
            reviewer = data.getGroupName();
        }
        reviewersPage.fillMainReviewer(reviewer);
    }

    @When("User selects {string} Reviewer Rules for rule {int}")
    public void selectReviewerRulesRule(String rule, int ruleNumber) {
        selectReviewerRulesRuleForReviewer(rule, ruleNumber);
    }

    @When("^User selects \"((.*))\" Reviewer Rules Reviewer Level (?:\\d+) for rule (\\d+)$")
    public void selectReviewerRulesRuleForReviewer(String rule, int ruleNumber) {
        reviewersPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        reviewersPage.selectRule(Integer.toString(ruleNumber), rule);
    }

    @When("User selects {string} as rule type Reviewer Level {int} for rule {int}")
    public void selectRuleTypesForReviewerLevel(String value, int reviewerLevel, int ruleNumber) {
        reviewersPage.selectRuleTypeForReviewer(value, reviewerLevel, ruleNumber);
    }

    @When("User selects {string} rule type for rule {int}")
    public void selectsRuleType(String ruleType, int ruleNumber) {
        reviewersPage.selectRuleType(ruleType, String.valueOf(ruleNumber));
    }

    @When("User selects {int} values as rule type for rule {int}")
    public void selectRuleTypes(int number, int ruleNumber) {
        reviewersPage.clickRuleTypeDropDownArrowIcon(String.valueOf(ruleNumber));
        List<String> available = reviewersPage.getReviewersDropDownOptions();
        List<String> selected = new ArrayList<>();
        for (int i = 0; i < number; i++) {
            reviewersPage.selectRuleType(available.get(i), String.valueOf(ruleNumber));
            selected.add(available.get(i));
        }
        this.context.getScenarioContext().setContext(QUESTIONNAIRE_SELECTED_RULE_TYPE, selected);
    }

    @When("User clicks {string} Reviewer Rule option")
    public void clickReviewerRuleOption(String reviewerOption) {
        reviewersPage.selectReviewerRuleOption(reviewerOption);
    }

    @When("User selects {string} Reviewer Rules reviewer")
    public void selectReviewerRulesReviewer(String reviewer) {
        if (!isNullOrEmpty(reviewer)) {
            reviewersPage.selectReviewer(reviewer);
        }
    }

    @When("User adds up to {int} random Reviewer Rules for expanded Level")
    public void addReviewerRule(int number) {
        Random rand = new Random();
        List<String> ruleTypes = asList("Third-party Manager",
                                        "Third-party Commodity Type",
                                        "Third-party Region",
                                        "Third-party Country",
                                        "Third-party Workflow Group",
                                        "Risk Tier");
        List<String> reviewers = asList("User",
                                        "User Group",
                                        "Responsible Party");
        for (int i = 1; i < number + 1; i++) {
            String ruleType = ruleTypes.get(rand.nextInt(ruleTypes.size()));
            String reviewerType = reviewers.get(rand.nextInt(reviewers.size()));
            logger.info(format("Rule type is %s", ruleType));
            reviewersPage.clickAddRulesButton();
            reviewersPage.selectRule(LAST_ELEMENT, ruleType);
            if (!reviewersPage.isExpandedRuleTypeInputDisabled()) {
                reviewersPage.clickRuleTypeDropDownArrowIcon(LAST_ELEMENT);
                reviewersPage.selectRuleType(reviewersPage.getReviewersDropDownOptions().get(0), LAST_ELEMENT);
                reviewersPage.selectRuleReviewer(reviewerType);
                if (reviewersPage.isReviewerDropDownEnabled()) {
                    String reviewer;
                    if (reviewerType.equalsIgnoreCase(USER)) {
                        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
                        reviewer = (String) getUserDataByEmail(userTestData.getUsername(), NAME_FILTER);
                    } else {
                        reviewersPage.clickDropDownReviewer();
                        reviewer = reviewersPage.getReviewersDropDownOptions().get(0);
                    }
                    reviewersPage.fillReviewer(reviewer);
                }
            }
            logger.info(format("Rule №%s is added", i));
        }
    }

    @When("User clicks Delete icon for Reviewer rule {int}")
    public void deleteRule(int ruleNumber) {
        reviewersPage.deleteRule(ruleNumber);
    }

    @When("User clicks Delete icon for {int} Reviewer rules")
    public void deleteSeveralRules(int ruleNumber) {
        range(0, ruleNumber).forEach(rule -> reviewersPage.deleteRule(ruleNumber - rule));
    }

    @When("User clicks Questionnaire Reviewers {string} tab")
    public void clickQuestionnaireReviewersTab(String tabName) {
        reviewersPage.waitWhilePreloadProgressbarIsDisappeared();
        reviewersPage.clicksReviewerTab(tabName);
    }

    @When("User clicks toggle {string} option on Reviewers tab")
    public void toggleReviewersOption(String optionName) {
        switch (optionName) {
            case ALLOW_TOTAL_SCORE:
                reviewersPage.toggleAllowTotalScore();
                break;
            case HIDE_TOTAL_SCORE:
                reviewersPage.toggleHideTotalScore();
                break;
            case REQUIRE_MANDATORY_COMMENT:
                reviewersPage.toggleRequireMandatoryComment();
                break;
            case HIDE_QUESTION_SCORE:
                reviewersPage.toggleHideQuestionScore();
                break;
            default:
                throw new IllegalArgumentException("Option - " + optionName + " is unknown");
        }
    }

    @When("User selects Number of Reviewer Levels {string}")
    public void selectNumberOfReviewerLevels(String level) {
        reviewersPage.selectNumberOfReviewerLevels(level);
    }

    @When("User selects Reviewers Settings {string} drop-down value {string}")
    public void selectSettingsDropDown(String dropDown, String value) {
        reviewersPage.selectSettingsDropDownValue(reviewersPage.getReviewersSettingsDropDownLocatorName(dropDown),
                                                  value);
    }

    @When("User clicks Questionnaire Reviewers Settings {string} drop-down cross icon for value {string}")
    public void clickSelectedValueCrossIcon(String dropDown, String value) {
        reviewersPage.clickSelectedValueCrossIcon(reviewersPage.getReviewersSettingsDropDownLocatorName(dropDown),
                                                  value);
    }

    @When("User fills Questionnaire Process Flow description {string} for level {int}")
    public void fillProcessFlowDescription(String value, int level) {
        reviewersPage.fillDescription(value, level);
    }

    @When("User select Questionnaire Process Flow approve next level {string} for level {int}")
    public void selectApproveNextLevel(String value, int level) {
        reviewersPage.selectApproveNextLevel(value, level);
    }

    @When("User select Questionnaire Process Flow decline next level {string} for level {int}")
    public void selectDeclineNextLevel(String value, int level) {
        reviewersPage.selectDeclineNextLevel(value, level);
    }

    @When("User clicks Reviewer Rules 'Add Rules' button for Reviewer Level {int}")
    public void clickAddRulesButton(int reviewerLevel) {
        reviewersPage.clickAddRulesButtonForLevel(reviewerLevel);
    }

    @When("User clicks Reviewer Rules {string}")
    public void expandReviewerLevel(String reviewerLevel) {
        reviewersPage.clickReviewerLevel(reviewerLevel);
    }

    @When("^User drags and drops Reviewer Rules rule (\\d+) in Reviewer Level (?:\\d+)$")
    public void dragAndDropRule(int ruleNumber) {
        reviewersPage.dragAndDropRule(ruleNumber);
    }

    @When("User deletes Questionnaire Rules Main Reviewer")
    public void deleteQuestionnaireRulesMainReviewer() {
        reviewersPage.deleteQuestionnaireRulesMainReviewer();
    }

    @When("User searches Questionnaire Rules Main Reviewer by {string} keyword")
    public void searchQuestionnaireRulesMainReviewerByKeyword(String keyWord) {
        if (keyWord.contains(USERNAME)) {
            keyWord = Config.get().value(keyWord);
        }
        reviewersPage.inputMainReviewer(keyWord);
    }

    @When("User deletes Reviewer Rules Rule value for Level {int} for rule {int}")
    public void deleteReviewerRulesReviewerLevelForRule(int level, int ruleNumber) {
        reviewersPage.clickRulesDropDownForReviewer(ruleNumber);
        reviewersPage.clickDeleteRulesRule(level, ruleNumber);
    }

    @When("User deletes Reviewer Rule Type Reviewer Level {int} for rule {int}")
    public void deleteReviewerRuleTypeReviewerLevelForRule(int level, int ruleNumber) {
        reviewersPage.clickRuleTypeDropDownForLevel(level, ruleNumber);
        reviewersPage.clickDeleteRulesRuleType(level, ruleNumber);
    }

    @When("User deletes Questionnaire Rules Reviewer")
    public void deleteQuestionnaireRulesReviewer() {
        reviewersPage.clickDropDownReviewer();
        reviewersPage.clickDeleteRulesReviewer();
    }

    @When("User clicks Questionnaire Reviewer Add Rule button")
    public void clickQuestionnaireReviewerAddRuleButton() {
        reviewersPage.clickAddRulesButton();
    }

    @When("User clicks Questionnaire Process Flow checkbox")
    public void clickQuestionnaireProcessFlowCheckbox() {
        reviewersPage.clickQuestionnaireProcessFlowCheckbox();
    }

    @Then("Main Reviewer field is displayed as required")
    public void mainReviewerFieldIsRequired() {
        assertTrue("Main Reviewer field is not displayed as required",
                   reviewersPage.getMainReviewerFieldLabel().contains(REQUIRED_INDICATOR));
    }

    @Then("Reviewer field is displayed as required")
    public void reviewerFieldIsRequired() {
        assertTrue("Reviewer field is not displayed as required",
                   reviewersPage.getReviewerFieldLabel().contains(REQUIRED_INDICATOR));
    }

    @Then("^Questionnaire Rules \"((.*))\" is selected as (Main Reviewer|Reviewer)$")
    public void reviewerIsSelected(String reviewer, String reviewerType) {
        assertThat(reviewersPage.isReviewerSelected(reviewer, reviewerType))
                .as("%s '%s' radio button is not selected", reviewerType, reviewer)
                .isTrue();
    }

    @Then("Add Rule drop-down field is displayed")
    public void addRuleDropDownFieldIsDisplayed() {
        assertThat(reviewersPage.isAddRuleFieldDisplayed()).as("Add Rule drop-down field is not displayed")
                .isTrue();
    }

    @Then("Rule Type field is displayed")
    public void ruleTypeFieldIsDisplayed() {
        assertThat(reviewersPage.isRuleTypeFieldDisplayed()).as("Rule Type field is not displayed")
                .isTrue();
    }

    @Then("Reviewer Rule options is displayed")
    public void reviewerRuleOptionsIsDisplayed(DataTable dataTable) {
        List<String> expectedRuleOptions = dataTable.asList();
        expectedRuleOptions.forEach(option -> assertThat(reviewersPage.isRuleOptionDisplayed(option))
                .as("Rule Option %s is not displayed", option).isTrue());
    }

    @Then("Reviewer {string} is selected")
    public void reviewerIsSelected(String reviewer) {
        reviewer = reviewer.isEmpty() ? null : reviewer;
        assertThat(reviewersPage.getReviewerValue()).as("Reviewer is unexpected").isEqualTo(reviewer);
    }

    @Then("Questionnaire Rules Reviewer drop-down is disabled")
    public void reviewerDropDownIsDisabled() {
        assertThat(reviewersPage.isReviewerDropDownEnabled()).as("Reviewer is enabled").isFalse();
    }

    @Then("Reviewer Rule {string} option is selected")
    public void reviewerRuleOptionIsSelected(String ruleOption) {
        assertThat(reviewersPage.isRuleOptionSelected(ruleOption)).as("%s rule option is not selected", ruleOption)
                .isTrue();
    }

    @Then("^Questionnaire Rules Reviewer drop-down contains active (users|user groups)$")
    public void reviewerDropDownContainsAllActiveUsers(String expectedValueType) {
        reviewersPage.clickDropDownReviewer();
        List<String> actualUsersInDropDown = reviewersPage.getReviewersDropDownOptions();
        List<String> expectedUsersInDropDown = getExpectedDropDownValues(expectedValueType);
        if (expectedValueType.equals(USERS)) {
            int listSizeLimit = 20;
            assertThat(expectedUsersInDropDown.size() < listSizeLimit ?
                               actualUsersInDropDown.size() == expectedUsersInDropDown.size() :
                               actualUsersInDropDown.size() == listSizeLimit + 1)
                    .as("User's drop-down list size %s is not expected", actualUsersInDropDown.size())
                    .isTrue();
        }
        assertThat(expectedUsersInDropDown)
                .as("Reviewer %s drop-down values are unexpected", expectedValueType)
                .containsAll(actualUsersInDropDown);
        reviewersPage.clickDropDownReviewer();
    }

    @Then("Reviewer drop-down contains {int} active user groups with default {string} option")
    public void reviewerDropDownContainsAllActiveUserGroups(int expectedListSize, String defaultOption) {
        List<String> expectedUsersGroupList = getListOfActiveUserGroups().stream().map(String::trim).collect(
                Collectors.toList());
        reviewersPage.clickDropDownReviewer();
        List<String> groupsInDropDown = reviewersPage.getReviewersDropDownOptions();
        expectedUsersGroupList.add(defaultOption);
        assertThat(groupsInDropDown.size())
                .as("User group's drop-down list size %s is not expected", groupsInDropDown.size())
                .isLessThanOrEqualTo(expectedListSize);
        assertThat(expectedUsersGroupList).usingRecursiveComparison().ignoringCollectionOrder().asList()
                .as("Reviewer drop-down doesn't contain all active user groups")
                .containsAll(groupsInDropDown);
    }

    @Then("Name of Rule Type drop-down is {string}")
    public void checkRuleTypeDDName(String name) {
        assertThat(reviewersPage.getRuleTypeDropDownName())
                .as("Rule Type drop-down name is not %s", name).contains(name);
    }

    @Then("{string} Rule Type drop-down contains selected values")
    @SuppressWarnings("unchecked")
    public void checkRuleTypeDDContains(String name) {
        List<String> expectedValues =
                (List<String>) this.context.getScenarioContext().getContext(QUESTIONNAIRE_SELECTED_RULE_TYPE);
        assertThat(reviewersPage.getRuleTypeDropDownValues())
                .as("%s Rule Type drop-down does not contain expected values", name).usingRecursiveComparison()
                .ignoringCollectionOrder().isEqualTo(expectedValues);
    }

    @Then("^Reviewer Rules 'Add Rules' button is (disabled|enabled)$")
    public void checkAddReviewerRuleButtonState(String state) {
        if (state.equals(DISABLED)) {
            assertThat(reviewersPage.isAddRulesButtonDisabled()).as("'Add Rules' button is not disabled!").isTrue();
        } else {
            assertThat(reviewersPage.isAddRulesButtonDisabled()).as("'Add Rules' button is not enabled!").isFalse();
        }
    }

    @Then("^Reviewer Rule with number (\\d+) is (displayed|not displayed)$")
    public void isRuleDisplayed(int ruleNumber, String state) {
        if (state.equals(DISPLAYED)) {
            assertThat(reviewersPage.isRuleDisplayed(ruleNumber))
                    .as(format("Rule on position %d is not displayed", ruleNumber)).isTrue();
        } else {
            assertThat(reviewersPage.isRuleInvisible(ruleNumber))
                    .as(format("Rule on position %d is displayed", ruleNumber)).isTrue();
        }
    }

    @Then("Delete button is displayed for Main Reviewer Questionnaire rule")
    public void checkDefaultRuleCannotBeDeleted() {
        assertThat(reviewersPage.isDeleteMainReviewerButtonDisplayed())
                .as("Delete button is displayed for Main Reviewer rule").isFalse();
    }

    @Then("Questionnaire Reviewers subtab {string} is displayed")
    public void isReviewersSubtabDisplayed(String tabName) {
        assertThat(reviewersPage.isReviewerSubtabWithNameDisplayed(tabName))
                .as("Reviewers % subtab is not displayed", tabName).isTrue();
    }

    @Then("Questionnaire Reviewers Number of Reviewer levels is {string}")
    public void checkNumberOfReviewersLevelValue(String number) {
        assertThat(reviewersPage.getNumberOfReviewerLevels()).as("Number of Reviewers level is not expected")
                .isEqualTo(number);
    }

    @Then("^Questionnaire Reviewers Settings \"((.*))\" drop-down (is required|is not required)$")
    public void isAllowedForRequired(String dropDown, String state) {
        if (state.contains(IS_NOT)) {
            assertThat(
                    reviewersPage.isSettingsDropDownRequired(
                            reviewersPage.getReviewersSettingsDropDownLocatorName(dropDown))).as(
                    "%s drop-down is required", dropDown).isFalse();
        } else {
            assertThat(
                    reviewersPage.isSettingsDropDownRequired(
                            reviewersPage.getReviewersSettingsDropDownLocatorName(dropDown))).as(
                    "%s drop-down is not required", dropDown).isTrue();
        }
    }

    @Then("Questionnaire Reviewers Settings {string} drop-down contains")
    public void checkAllowedForDropDownValues(String dropDown, List<String> expectedLevels) {
        assertThat(reviewersPage.getSettingsDropDownValues(
                reviewersPage.getReviewersSettingsDropDownLocatorName(dropDown))).as(
                "%s drop-down list is not expected", dropDown).isEqualTo(expectedLevels);
    }

    @Then("Questionnaire Reviewers Settings {string} selected values are")
    public void checkAllowedForSelectedValues(String dropDown, List<String> expectedLevels) {
        expectedLevels = isNull(expectedLevels.get(0)) ? new ArrayList<>() : expectedLevels;
        assertThat(reviewersPage.getSettingsSelectedValues(
                reviewersPage.getReviewersSettingsDropDownLocatorName(dropDown))).as(
                "%s drop-down selected values are not expected", dropDown).isEqualTo(expectedLevels);
    }

    @Then("User Questionnaire Reviewers Settings toggle {string} is enabled")
    public void toggleReviewersOptionIsEnabled(String optionName) {
        switch (optionName) {
            case ALLOW_TOTAL_SCORE:
                assertThat(reviewersPage.isAllowedTotalScoreToggleEnabled()).as(
                        "Allow total score adjustment by entering a number is not toggled").isTrue();
                break;
            case HIDE_TOTAL_SCORE:
                assertThat(reviewersPage.isHideTotalScoreToggleEnabled()).as(
                        "Hide total score from reviewers is not toggled").isTrue();
                break;
            case REQUIRE_MANDATORY_COMMENT:
                assertThat(reviewersPage.isRequireMandatoryToggleEnabled()).as(
                        "Require mandatory comment for review and changes is not toggled").isTrue();
                break;
            case HIDE_QUESTION_SCORE:
                assertThat(reviewersPage.isHideQuestionScoreToggleEnabled()).as(
                        "Hide question score from reviewers is not toggled").isTrue();
                break;
            default:
                throw new IllegalArgumentException("Option - " + optionName + " is unknown");
        }
    }

    @Then("Questionnaire Process Flow table is displayed with details")
    public void checkProcessFlowTable(List<List<String>> expectedValues) {
        List<List<String>> actualValues = reviewersPage.getProcessFlowTableValues();
        assertThat(actualValues)
                .as("Questionnaire Process Flow table contains not expected values")
                .isEqualTo(expectedValues);
    }

    @SuppressWarnings("unchecked")
    @Then("Questionnaire breadcrumb {string} is displayed")
    public void checkBreadcrumbIsDisplayed(String breadcrumb) {
        if (breadcrumb.contains(VALUE_TO_REPLACE)) {
            GenericTestData<QuestionnaireData> questionnaireTestData =
                    (GenericTestData<QuestionnaireData>) context.getScenarioContext()
                            .getContext(QUESTIONNAIRE_TEST_DATA);
            String questionnaireName = questionnaireTestData.getDataToEnter().getQuestionnaireName();
            breadcrumb = breadcrumb.replace(VALUE_TO_REPLACE, questionnaireName.toUpperCase());
        }
        assertThat(reviewersPage.getBreadcrumb()).as("Expected Breadcrumb is not displayed").isEqualTo(breadcrumb);
    }

    @Then("^Reviewer Rules \"((.*))\" is displayed for Reviewer Level (?:\\d+) and rule (\\d+)$")
    public void checkReviewerRulesValue(String value, int ruleNumber) {
        value = value.isEmpty() ? null : value;
        assertThat(reviewersPage.getReviewerRuleValueForReviewer(ruleNumber))
                .as("Reviewer Rules value is not expected")
                .isEqualTo(value);
    }

    @Then("Reviewer Rule type {string} is displayed for Reviewer Level {int} and rule {int}")
    public void checkReviewerRuleTypeValue(String value, int reviewerLevel, int ruleNumber) {
        value = value.isEmpty() ? null : value;
        assertThat(reviewersPage.getReviewerRuleTypeValueForReviewer(reviewerLevel, ruleNumber))
                .as("Reviewer Rule Type value is not expected").isEqualTo(value);
    }

    @Then("Questionnaire Reviewers Rules displays the next Reviewer Levels")
    public void checkReviewerLevels(List<String> expectedLevels) {
        assertThat(reviewersPage.getReviewersLevels()).as("Reviewer Levels are not expected").isEqualTo(expectedLevels);
    }

    @Then("Questionnaire Rules sections are displayed")
    public void questionnaireRulesSectionsAreDisplayed(List<String> expectedSections) {
        SoftAssertions softAssertions = new SoftAssertions();
        expectedSections.forEach(section -> softAssertions.assertThat(reviewersPage.isRuleSectionDisplayed(section))
                .as("Questionnaire Rules section %s is not displayed", section)
                .isTrue());
        softAssertions.assertAll();
    }

    @Then("Questionnaire Rules Main Reviewer input is disabled")
    public void questionnaireRulesMainReviewerInputIsDisabled() {
        assertThat(reviewersPage.isMainReviewerDisabled())
                .as("Questionnaire Rules Main Reviewer input is not disabled")
                .isTrue();
    }

    @Then("Questionnaire Rules Main Reviewer radio buttons are displayed")
    public void questionnaireRulesMainReviewerRadioButtonsAreDisplayed(List<String> expectedRadioButtons) {
        assertThat(reviewersPage.getMainReviewerRadioButtons())
                .as("Questionnaire Rules Main Reviewer radio buttons are unexpected")
                .isEqualTo(expectedRadioButtons);
    }

    @Then("^Questionnaire Rules Rule Reviewer radio buttons are (displayed|disabled|enabled)$")
    public void ruleReviewerRadioButtonsStatesAreExpected(String state, List<String> expectedRadioButtons) {
        if (state.equals(DISABLED) || state.equals(ENABLED)) {
            SoftAssertions softAssertions = new SoftAssertions();
            expectedRadioButtons
                    .forEach(button -> softAssertions.assertThat(reviewersPage.isReviewerRadioButtonDisabled(button))
                            .as("Reviewer button %s is not %s", button, state)
                            .isEqualTo(state.equals(DISABLED)));
            softAssertions.assertAll();
        } else {
            assertThat(reviewersPage.getReviewerRadioButtons())
                    .as("Questionnaire Rules Reviewer radio buttons are unexpected")
                    .isEqualTo(expectedRadioButtons);
        }
    }

    @Then("^Questionnaire Rules Main Reviewer drop-down contains active (users|user groups)$")
    public void questionnaireRulesMainReviewerDropDownContainsActiveUsers(String expectedValueType) {
        reviewersPage.clickDropDownMainReviewerButton();
        assertThat(getExpectedDropDownValues(expectedValueType))
                .as("Questionnaire Rules Main Reviewer %s drop-down values are unexpected", expectedValueType)
                .containsAll(reviewersPage.getReviewersDropDownOptions());
        reviewersPage.clickDropDownMainReviewerButton();
    }

    @Then("Questionnaire Rules Main Reviewer value is {string}")
    public void questionnaireRulesMainReviewerValueIs(String expectedValue) {
        expectedValue = expectedValue.isEmpty() ? null : expectedValue;
        assertThat(reviewersPage.getMainReviewerValue())
                .as("Questionnaire Rules Main Reviewer selected value is unexpected")
                .isEqualTo(expectedValue);
    }

    @Then("Questionnaire Rules Main Reviewer input is highlighted")
    public void questionnaireRulesMainReviewerInputHighlighted() {
        assertThat(reviewersPage.isMainReviewerInputHighlighted())
                .as("Questionnaire Rules Main Reviewer input is not highlighted")
                .isTrue();
    }

    @Then("Questionnaire Rules {string} input is highlighted")
    public void questionnaireRulesInputHighlighted(String fieldName) {
        assertThat(reviewersPage.isInputHighlighted(fieldName))
                .as("Questionnaire Rules %s input is not highlighted", fieldName)
                .isTrue();
    }

    @Then("Error message {string} is displayed near Questionnaire Rules Main Reviewer input")
    public void errorMessageIsDisplayedNearQuestionnaireRulesMainReviewerInput(String expectedErrorText) {
        assertThat(reviewersPage.getMainReviewerErrorMessageText())
                .as("Main Reviewer error message is not displayed")
                .isEqualTo(expectedErrorText);
    }

    @Then("Questionnaire Rules Main Reviewer drop-down contains values")
    public void questionnaireRulesMainReviewerDropDownContainsValues(List<String> expectedResult) {
        List<String> actualResult = reviewersPage.getReviewersDropDownOptions();
        actualResult.remove(DROPDOWN_PLACEHOLDER);
        if (expectedResult.get(0).contains(LF)) {
            expectedResult = expectedResult.stream().map(user -> {
                String username = user.split(LF)[1];
                return user.replace(username, Config.get().value(username));
            }).collect(toList());
        }
        assertThat(actualResult)
                .as("Main Reviewer drop-down values are unexpected")
                .containsAll(expectedResult);
    }

    @Then("Questionnaire Rules Rule drop-down contains values")
    public void questionnaireRulesRuleDropDownContainsValues(List<String> expectedResult) {
        reviewersPage.clickRulesDropDownForReviewer(1);
        assertThat(reviewersPage.getReviewersDropDownOptions())
                .as("Rule drop-down values are unexpected")
                .isEqualTo(expectedResult);
        reviewersPage.clickRulesDropDownForReviewer(1);

    }

    @Then("^Questionnaire Rule Type is (disabled|enabled)$")
    public void questionnaireRuleTypeIsDisabled(String state) {
        assertThat(reviewersPage.isExpandedRuleTypeInputDisabled())
                .as("Questionnaire Rule Type is not " + state)
                .isEqualTo(state.equals(DISABLED));
    }

    @Then("Questionnaire {string} Rule Type drop-down contains expected values")
    public void questionnaireRuleTypeForReviewerContainsExpectedValues(String rule) {
        reviewersPage.clickLastRuleTypeInputButton();
        assertThat(reviewersPage.getReviewersDropDownOptions())
                .as("Rule Type %s drop-down values are unexpected", rule)
                .isEqualTo(getExpectedDropDownValues(rule));
        reviewersPage.clickLastRuleTypeInputButton();
    }

    @Then("Questionnaire Reviewer Rules contains {int} numerated rules")
    public void questionnaireReviewerRulesContainsNumeratedRules(int numberLimit) {
        SoftAssertions softAssertions = new SoftAssertions();
        IntStream.iterate(numberLimit - 1, i -> i < 0, i -> i - 1)
                .forEach(i -> softAssertions.assertThat(reviewersPage.isRuleWithNumberPresent(i))
                        .as("Rules number %s is not displayed", i)
                        .isTrue());
        softAssertions.assertAll();
    }

    @Then("Delete button is displayed for each Reviewer Questionnaire rule")
    public void deleteButtonIsDisplayedForEachReviewerQuestionnaireRule() {
        SoftAssertions softAssertions = new SoftAssertions();
        reviewersPage.getRuleNumbers()
                .forEach(rule -> softAssertions.assertThat(reviewersPage.isDeleteRuleButtonPresent(rule))
                        .as("Delete button for rule #%s is not displayed", rule)
                        .isTrue());
        softAssertions.assertAll();
    }

    @Then("Error message {string} is displayed near Questionnaire Rules rule {string} input")
    public void errorMessageIsDisplayedNearQuestionnaireRulesRuleInput(String expectedMessage, String fieldName) {
        assertThat(reviewersPage.getRuleErrorMessageText(fieldName))
                .as("Rule %s input error message is not displayed", fieldName)
                .isEqualTo(expectedMessage);
    }

    @Then("Questionnaire Rule level {string} is highlighted")
    public void questionnaireRuleLevelIsHighlighted(String level) {
        assertThat(reviewersPage.getLevelAccordionColor(level))
                .as("Level accordion %s is not highlighted", level)
                .isEqualTo(REACT_RED.getColorRgba());
    }

    @Then("^Questionnaire Reviewer Rules \"((.*))\" is (expanded|collapsed)$")
    public void questionnaireReviewerRulesIsExpanded(String level, String state) {
        assertThat(reviewersPage.isLevelExpanded(level))
                .as("Level section %s is not %s", level, state)
                .isEqualTo(state.contains(EXPAND));
    }

    @Then("Questionnaire expanded Rule message is displayed {string}")
    public void questionnaireExpandedRuleMessageIsDisplayed(String expectedMessage) {
        assertThat(reviewersPage.getRuleMessage())
                .as("Expanded Rule message is unexpected")
                .isEqualTo(expectedMessage);
    }

    @Then("Questionnaire Process Flow checkbox is displayed")
    public void processFlowCheckboxIsDisplayed() {
        assertThat(reviewersPage.isProcessFlowCheckboxDisplayed())
                .as("Process Flow checkbox is not displayed")
                .isTrue();
    }

    @Then("Questionnaire Process Flow level {int} Description field length is {string} symbols")
    public void processFlowLevelDescriptionFieldLengthIsSymbols(int level, String expectedLength) {
        assertThat(reviewersPage.getProcessFlowDescriptionLength(level))
                .as("Process Flow Description field length is unexpected")
                .isEqualTo(expectedLength);
    }

    @Then("Questionnaire Process Flow level {int} Approve drop-down options are")
    public void processFlowLevelApproveDropDownOptionsAre(int level, List<String> expectedOptions) {
        reviewersPage.clickApproveNextLevel(level);
        assertThat(reviewersPage.getReviewersDropDownOptions())
                .as("Process Flow for level %s Approve drop-down options are unexpected", level)
                .isEqualTo(expectedOptions);
        reviewersPage.clickApproveNextLevel(level);
    }

    @Then("Questionnaire Process Flow level {int} Decline drop-down options are")
    public void processFlowLevelDeclineDropDownOptionsAre(int level, List<String> expectedOptions) {
        reviewersPage.clickDeclineNextLevel(level);
        assertThat(reviewersPage.getReviewersDropDownOptions())
                .as("Process Flow for level %s Decline drop-down options are unexpected", level)
                .isEqualTo(expectedOptions);
        reviewersPage.clickDeclineNextLevel(level);
    }

    @Then("Questionnaire Process Flow {string} input for level {int} is highlighted with error message {string}")
    public void processFlowInputIsHighlightedWithErrorMessage(String fieldName, int level, String expectedMessage) {
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(reviewersPage.getProcessFlowInputErrorMessage(fieldName, level))
                .as("Process Flow field %s for level %s error message is unexpected", fieldName, level)
                .isEqualTo(expectedMessage);
        softAssertions.assertThat(reviewersPage.getProcessFlowInputColor(fieldName, level))
                .as("Process Flow field %s for level %s is not highlighted in red", fieldName, level)
                .isEqualTo(REACT_RED.getColorRgba());
        softAssertions.assertAll();
    }

    @Then("^Questionnaire Process Flow checkbox is (unchecked|checked)$")
    public void questionnaireProcessFlowCheckboxIsUnchecked(String state) {
        assertThat(reviewersPage.isQuestionnaireProcessFlowCheckboxChecked())
                .as("Questionnaire Process Flow checkbox is not %s", state)
                .isEqualTo(state.equals(CHECKED));
    }

}
