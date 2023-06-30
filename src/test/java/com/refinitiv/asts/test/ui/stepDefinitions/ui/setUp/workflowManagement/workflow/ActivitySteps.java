package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.workflowManagement.workflow;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.WorkflowApi;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.ObjectsItem;
import com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse.ActivitiesItem;
import com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse.WorkFlowItem;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.Colors;
import com.refinitiv.asts.test.ui.enums.QuestionnaireType;
import com.refinitiv.asts.test.ui.pageActions.SearchSectionPage;
import com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow.ActivityPage;
import com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow.ApproverPage;
import com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow.ReviewerPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.approvalProcess.ApprovalProcessData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowActivityData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowReviewerApproverData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.netty.karate.util.internal.StringUtil;
import org.assertj.core.api.SoftAssertions;

import java.util.*;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getGroupIdByName;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getUserGroupNamesByStatus;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getFirstActiveUsers;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.ADD_REVIEWER_TAB;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.NOT;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.WORKFLOW_ACTIVITY;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.WORKFLOW_REVIEWER;
import static com.refinitiv.asts.test.ui.enums.ProcessRuleTypes.REVIEW;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.Status.INACTIVE;
import static com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow.ActivityPage.*;
import static com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowActivityData.newInstance;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static java.util.UUID.randomUUID;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;

public class ActivitySteps extends BaseSteps {

    private static final String ACTIVE_STATUS = "true";
    public static final String USER = "user";
    public static final String GROUP = "group";
    private static final String USER_GROUP = "user group";
    public static final String RESPONSIBLE_PARTY = "responsible party";
    private final ActivityPage activityPage;
    private final ApproverPage approverTabPage;
    private final ReviewerPage reviewerTabPage;
    private final List<WorkflowReviewerApproverData> reviewerDataList = new ArrayList<>();
    private final List<WorkflowReviewerApproverData> approverDataList = new ArrayList<>();
    private final SearchSectionPage searchPage;

    public ActivitySteps(ScenarioCtxtWrapper scenario) {
        super(scenario);
        activityPage = new ActivityPage(driver);
        approverTabPage = new ApproverPage(driver, context);
        reviewerTabPage = new ReviewerPage(driver, context);
        searchPage = new SearchSectionPage(driver);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public ApprovalProcessData providerEntry(Map<String, String> approvalRuleData) {
        return approverTabPage.getApprovalProcessRuleValues(approvalRuleData);
    }

    private String getFirstExistingReviewProcess() {
        return WorkflowApi.getProcessRules(100, 0, REVIEW)
                .getObjects().stream()
                .filter(process -> process.getStatus().equalsIgnoreCase(ACTIVE.getStatus()))
                .map(ObjectsItem::getName).findFirst()
                .orElse("No Review Process were found!");
    }

    @When("User ticks Pending for Assignment checkbox")
    public void tickPendingForAssignmentCheckbox() {
        activityPage.tickPendingForAssignmentCheckbox();
    }

    @When("User clicks Activity {string} tab")
    public void clickActivityTab(String name) {
        activityPage.clickActivityTab(name);
    }

    @When("User fills in Activity {string} details")
    public void fillInActivityDetails(String activityReference) {
        activityPage.waitWhilePreloadProgressbarIsDisappeared();
        WorkflowActivityData activityData =
                new JsonUiDataTransfer<WorkflowActivityData>(
                        WORKFLOW_ACTIVITY)
                        .getTestData().get(activityReference)
                        .getDataToEnter();
        if (activityData.getActivityName().equals(VALUE_TO_REPLACE)) {
            activityData.setActivityName(AUTO_TEST_NAME_PREFIX + randomUUID());
        }
        if (activityData.getDueIn().equals(VALUE_TO_REPLACE)) {
            String dueIn = String.valueOf(ThreadLocalRandom.current().nextInt(1, 100));
            activityData.setDueIn(dueIn);
        }
        if (activityData.getActivityType().equals(VALUE_TO_REPLACE)) {
            List<String> typeList = getActivityTypesNameList();
            int index = ThreadLocalRandom.current().nextInt(1, typeList.size() - 1);
            activityData.setActivityType(typeList.get(index));
        }
        if (USER_FIRST_NAME.equals(activityData.getAssignee())) {
            activityData.setAssignee((String) context.getScenarioContext().getContext(USER_FIRST_NAME));
        }
        activityPage.fillInActivityData(activityData);
        context.getScenarioContext().setContext(activityReference, activityData);
    }

    @When("User fills in Activity {string} name {string} details")
    public void fillInActivityNameDetails(String activityName, String activityReference) {
        WorkflowActivityData activityData = new JsonUiDataTransfer<WorkflowActivityData>(WORKFLOW_ACTIVITY)
                .getTestData().get(activityReference).getDataToEnter();
        activityData.setActivityName(activityName);
        if (activityData.getDueIn().equals(VALUE_TO_REPLACE)) {
            String dueIn = String.valueOf(ThreadLocalRandom.current().nextInt(1, 100));
            activityData.setDueIn(dueIn);
        }
        if (activityData.getActivityType().equals(VALUE_TO_REPLACE)) {
            List<String> typeList = getActivityTypesNameList();
            int index = ThreadLocalRandom.current().nextInt(1, typeList.size() - 1);
            activityData.setActivityType(typeList.get(index));
        }
        activityPage.fillInActivityData(activityData);
        context.getScenarioContext().setContext(activityReference, activityData);
    }

    @When("User clicks Done button for Activity")
    public void clickDoneButtonForActivity() {
        activityPage.clickDone();
    }

    @When("User selects Activity Type as {string}")
    public void selectActivityType(String type) {
        activityPage.fillInActivityType(type);
    }

    @When("User populates Activity Name with {string}")
    public void fillInActivityName(String name) {
        activityPage.fillInActivityName(name);
    }

    @When("User populates Activity Description with {string}")
    public void fillInActivityDescription(String description) {
        activityPage.fillInDescription(description);
    }

    @When("User ticks User radio button")
    public void tickUserRadioBtn() {
        activityPage.pickUserRadio();
    }

    @When("User selects Workflow Assignee\\(s) as {string}")
    public void selectAssignee(String assignee) {
        if (context.getScenarioContext().isContains(assignee)) {
            assignee = ((UserData) context.getScenarioContext().getContext(assignee)).getFirstName();
        }
        activityPage.fillInAssignee(assignee, true);
    }

    @When("User populates Due In with {string}")
    public void populateDueInWith(String dueDate) {
        activityPage.fillInDueDate(dueDate);
    }

    @When("User clicks 'Add Existing Approval Process' button")
    public void clickExistingApprovalProcessButton() {
        approverTabPage.clickAddExistingApprovalProcess();
    }

    @When("User clicks Add reviewer button")
    public void clickAddReviewerButton() {
        reviewerTabPage.clickAddReviewerButton();
    }

    @When("User clicks Add approver button")
    public void clickAddApproverButton() {
        approverTabPage.clickAddApproverButton();
    }

    @When("User clicks remove icon for rule section on position {int}")
    public void clickRemoveIconForRuleSectionOnPosition(int sectionPosition) {
        reviewerTabPage.clickRemoveRuleButton(sectionPosition);
    }

    @When("User clicks remove icon for Approver rule section on position {int}")
    public void clickRemoveApproverIconForRuleSectionOnPosition(int sectionPosition) {
        approverTabPage.clickRemoveRuleButton(sectionPosition);
    }

    @When("User clicks 'Add Existing Review Process' button")
    public void clickAddExistingReviewProcessReviewerButton() {
        reviewerTabPage.clickAddExistingRuleButton();
    }

    @When("User clicks first review process row")
    public void clickFirstReviewProcessRow() {
        reviewerTabPage.clickFirstRuleRow();
    }

    @When("User selects {string} value for Default Reviewer")
    public void selectValueForDefaultReviewer(String value) {
        if (value.equals(USER_FIRST_NAME)) {
            value = (String) context.getScenarioContext().getContext(USER_FIRST_NAME);
        } else if (context.getScenarioContext().isContains(value)) {
            value = ((UserData) context.getScenarioContext().getContext(value)).getFirstName();
        }
        reviewerTabPage.fillInDefaultReviewerField(value);
    }

    @When("User selects {string} value for Default Approver")
    public void selectValueForDefaultApprover(String value) {
        if (value.equals(USER_FIRST_NAME)) {
            value = (String) context.getScenarioContext().getContext(USER_FIRST_NAME);
        } else if (context.getScenarioContext().isContains(value)) {
            value = ((UserData) context.getScenarioContext().getContext(value)).getFirstName();
        }
        approverTabPage.fillInDefaultApproverField(value);
    }

    @When("User fills {string} in Reviewer details for {int} rule section")
    public void fillInReviewerDetailsForRuleSection(String reviewerReference, int sectionPosition) {
        WorkflowReviewerApproverData reviewerData =
                new JsonUiDataTransfer<WorkflowReviewerApproverData>(WORKFLOW_REVIEWER).getTestData()
                        .get(reviewerReference)
                        .getDataToEnter();
        reviewerDataList.add(reviewerData);
        reviewerTabPage.fillInReviewerDetails(reviewerData, sectionPosition);
    }

    @When("User fills {string} in Approver details for {int} rule section")
    public void fillInApproverDetailsForRuleSection(String approverReference, int sectionPosition) {
        WorkflowReviewerApproverData approverData =
                new JsonUiDataTransfer<WorkflowReviewerApproverData>(WORKFLOW_REVIEWER).getTestData()
                        .get(approverReference)
                        .getDataToEnter();
        approverDataList.add(approverData);
        approverTabPage.fillInApproverDetails(approverData, sectionPosition);
    }

    @When("User selects Review Process with name {string}")
    public void selectReviewProcessWithName(String processName) {
        if (processName.equals(REVIEW_PROCESS_NAME)) {
            processName = (String) context.getScenarioContext().getContext(REVIEW_PROCESS_NAME);
        }
        reviewerTabPage.selectReviewProcess(processName);
    }

    @When("User updates created Workflow activity with {string} via API")
    public void updateCreatedWorkflowActivityWithViaAPI(String activityReference) {
        String workflowName = (String) this.context.getScenarioContext().getContext(WORKFLOW_NAME_CONTEXT);
        WorkflowActivityData activityData =
                new JsonUiDataTransfer<WorkflowActivityData>(WORKFLOW_ACTIVITY).getTestData().get(activityReference)
                        .getDataToEnter();
        WorkFlowItem workflowRequest = getWorkflowByName(workflowName);
        ActivitiesItem activity =
                Objects.requireNonNull(workflowRequest).getWorkflowComponents().get(0).getActivities().get(0);
        if (nonNull(activityData.getIsUserAssignee()) && activityData.getIsUserAssignee()) {
            UserData userData = getUserCredentialsByRole(activityData.getAssignee());
            activity.setAssignee(activity.getAssignee().setType(USER).setEmail(userData.getUsername())
                                         .setName(userData.getFirstName() + SPACE + userData.getLastName())
                                         .setUserGroupId(null));
        } else if (nonNull(activityData.getIsUserAssignee()) && !activityData.getIsUserAssignee()) {
            activity.setAssignee(
                    activity.getAssignee().setType(GROUP).setUserGroupId(getGroupIdByName(activityData.getAssignee()))
                            .setEmail(null).setName(null));
        }
        workflowRequest.getWorkflowComponents().get(0).setActivities(Collections.singletonList(activity));
        updateWorkflow(workflowRequest, workflowRequest.getId());
        logger.info("Workflow with name " + workflowName + " is updated!");
    }

    @When("^User clears all Activity form required fields with (User|Group) Assignee type$")
    public void clearActivityFormRequiredFields(String assigneeType) {
        activityPage.clearFormFields(assigneeType);
    }

    @When("User selects {string} Assignee type")
    public void selectAssigneeType(String assigneeType) {
        switch (assigneeType.toLowerCase()) {
            case USER:
                activityPage.pickUserRadio();
                break;
            case USER_GROUP:
                activityPage.pickGroupRadio();
                break;
            case RESPONSIBLE_PARTY:
                activityPage.pickResponsiblePartyRadio();
                break;
            default:
                throw new IllegalArgumentException(format("Radio button '%s' element is not expected!", assigneeType));
        }
    }

    @When("User clicks 'Edit' button on view Activity screen")
    public void clickViewActivityEditButton() {
        activityPage.clickEditButton();
    }

    @When("Close {string} tab 'Add Rules For' dropdown after check")
    public void closeDropDownAfterCheck(String tabName) {
        clickActivityTab(tabName);
    }

    @When("User searches review process with name {string}")
    public void searchReviewProcess(String processName) {
        switch (processName) {
            case VALUE_TO_REPLACE:
                processName = getFirstExistingReviewProcess();
                this.context.getScenarioContext().setContext(EXISTING_REVIEW_PROCESS, processName);
                break;
            case NOT_EXISTING:
                processName = getFirstExistingReviewProcess() + randomUUID();
                break;
            case REVIEW_PROCESS_NAME:
                processName = (String) context.getScenarioContext().getContext(REVIEW_PROCESS_NAME);
                break;
        }
        searchPage.searchItem(processName);
    }

    @When("User selects {string} Questionnaire Type")
    public void selectQuestionnaireType(String questionnaireType) {
        activityPage.selectQuestionnaireByType(questionnaireType);
        activityPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User selects {string} relevant questionnaire")
    public void selectRelevantQuestionnaire(String questionnaireName) {
        activityPage.fillInRelevantQuestionnaire(questionnaireName);
        activityPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User selects recommended scope as {string}")
    public void selectRecommendedScope(String scope) {
        activityPage.selectScope(scope);
    }

    @Then("Activity {string} tab is displayed")
    public void isTabWithNameDisplayed(String name) {
        assertThat(activityPage.isTabWithNameDisplayed(name))
                .as(name + " tab is not displayed")
                .isTrue();
    }

    @Then("Edit Approver tab has unfilled fields")
    public void checkEditApproverTabFieldAreUnfilled() {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(approverTabPage.isDefaultApproverSelected()).as("Default Approver is not selected")
                .isFalse();
        softAssert.assertThat(approverTabPage.isAddRulesForSelected()).as("Add Rules is not selected")
                .isFalse();
        softAssert.assertThat(approverTabPage.areActivityOwnersSelected()).as("Activity Owners are not selected")
                .isFalse();
        softAssert.assertThat(approverTabPage.areApproversSelected()).as("Approvers are not selected")
                .isFalse();
        softAssert.assertAll();
    }

    @Then("Edit Approver tab has correct values")
    public void checkEditApproverTabHasCorrectValuesInFields() {
        SoftAssertions softAssert = new SoftAssertions();
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        String userFullName = userTestData.getFirstName() + StringUtil.SPACE + userTestData.getLastName();
        softAssert.assertThat(approverTabPage.getActivityOwner())
                .as("Approver activity owner is not expected")
                .isEqualTo(userFullName);
        softAssert.assertThat(approverTabPage.getApprover())
                .as("Approver is not expected")
                .isEqualTo(userFullName);
        softAssert.assertAll();
    }

    @Then("Overview Approver tab has correct edit values where rules applied for {string}")
    public void checkEditApproverTabHasCorrectEditValuesInFields(String rules) {
        SoftAssertions softAssert = new SoftAssertions();
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        String userFullName = userTestData.getFirstName() + StringUtil.SPACE + userTestData.getLastName();
        softAssert.assertThat(approverTabPage.getActivityDefaultApprover())
                .as("Overview Default Approver is not expected")
                .isEqualTo(userFullName);
        softAssert.assertThat(approverTabPage.getAddRulesFor())
                .as("Overview Add Rule For is not expected")
                .isEqualTo(rules);
        softAssert.assertThat(approverTabPage.getEditActivityOwner())
                .as("Overview Activity Owner is not expected")
                .isEqualTo(userFullName);
        softAssert.assertThat(approverTabPage.getEditApprover())
                .as("Overview Approver is not expected")
                .isEqualTo(userFullName);
        softAssert.assertAll();
    }

    @Then("'Add Approver' tab is populated with values")
    public void addApproverTabIsPopulatedWithValues(ApprovalProcessData expectedData) {
        approverTabPage.waitForAngularPageIsLoaded();
        assertThat(approverTabPage.getApprovalProcessRuleValues())
                .as("Approval Process expected data is not equal to actual one")
                .isEqualTo(expectedData);
    }

    @Then("^(?:Add|Edit?) Activity tab is displayed with expected required fields$")
    public void addActivityTabIsDisplayedWithExpectedRequiredFields() {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(activityPage.getActivityInputRequiredIndicator(ACTIVITY_TYPE))
                .as(ACTIVITY_TYPE + " input field is not required")
                .contains(REQUIRED_INDICATOR);
        softAssert.assertThat(activityPage.getActivityInputRequiredIndicator(ACTIVITY_NAME))
                .as(ACTIVITY_NAME + " input field is not required")
                .contains(REQUIRED_INDICATOR);
        softAssert.assertThat(activityPage.getActivityInputRequiredIndicator(DESCRIPTION))
                .as(DESCRIPTION + " input field is not required")
                .contains(REQUIRED_INDICATOR);
        if (activityPage.isPickResponsiblePartyRadio()) {
            softAssert.assertThat(activityPage.getActivityInputRequiredIndicator(ASSIGNEE))
                    .as(ASSIGNEE + " input field is required")
                    .isNull();
        } else {
            softAssert.assertThat(activityPage.getActivityInputRequiredIndicator(ASSIGNEE))
                    .as(ASSIGNEE + " input field is not required")
                    .contains(REQUIRED_INDICATOR);
        }
        softAssert.assertThat(activityPage.getActivityInputRequiredIndicator(DUE_IN))
                .as(DUE_IN + " input field is not required")
                .contains(REQUIRED_INDICATOR);
        softAssert.assertThat(activityPage.getActivityInputRequiredIndicator(RISK_AREA))
                .as(RISK_AREA + " input field is required")
                .isNull();
        softAssert.assertAll();
    }

    @Then("^(?:Add|Edit?) Activity tab fields should be in correct state$")
    public void checkAddActivityTabHasFieldsInCorrectState(DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        table.asMap(String.class, String.class)
                .forEach((field, attribute) -> {
                    boolean isFieldEnabled = activityPage.isFieldEnabled((String) field);
                    if (attribute.equals(DISABLED)) {
                        soft.assertThat(isFieldEnabled).as(field + " is enabled").isFalse();
                    } else {
                        soft.assertThat(isFieldEnabled).as(field + " is disabled").isTrue();
                    }
                });
        soft.assertAll();
    }

    @Then("Activity Type drop-down list contains all the Activity types that are in the system")
    public void activityTypeDropDownListContainsAllTheActivityTypesThatAreInTheSystem() {
        activityPage.clickDropDownActivityType();
        assertThat(activityPage.getDropDownValues())
                .as("Activity Type drop-down list doesn't contain expected types")
                .isEqualTo(getActivityTypesNameList());
        activityPage.clickDropDownActivityType();
    }

    @Then("Activity Type drop-down does not contain values")
    public void activityTypeDropDownDoesNotContainValues(List<String> expectedResult) {
        activityPage.clickDropDownActivityType();
        assertThat(activityPage.getDropDownValues())
                .as("Activity Type drop-down list contains unexpected types")
                .doesNotContainAnyElementsOf(expectedResult);
        activityPage.clickDropDownActivityType();
    }

    @Then("Risk Area drop-down contains expected Risk Areas")
    public void riskAreaDropDownContainsExpectedRiskAreas() {
        activityPage.clickDropDownRiskArea();
        assertThat(activityPage.getDropDownValues())
                .as("Risk Area drop-down list doesn't contain expected areas")
                .isEqualTo(getRiskCategoriesNameList());
        activityPage.clickDropDownRiskArea();
    }

    @Then("Assignee's drop-down contains only active users")
    public void checkAssigneeDropDownContainsActiveUsers() {
        List<String> expectedResult =
                getFirstActiveUsers(20, INTERNAl_USER_TYPE).stream()
                        .filter(user -> user.getUsername() != null)
                        .map(user -> format(USER_FIRST_LAST_USERNAME_WITH_NEW_LINE, user.getFirstName(),
                                            user.getLastName(),
                                            user.getUsername()))
                        .collect(Collectors.toList());
        activityPage.clickDropDownAssignee();
        List<String> actual = activityPage.getDropDownValues();
        actual.remove(DROPDOWN_PLACEHOLDER);
        assertThat(actual)
                .as("Assignee\\(s) drop-down list doesn't contain expected values")
                .isEqualTo(expectedResult);
        activityPage.clickDropDownAssignee();
    }

    @Then("Assignee\\(s) drop-down contains all active user groups")
    public void assigneeDropDownContainsAllActiveUserGroups() {
        activityPage.clickDropDownAssignee();
        assertThat(activityPage.getDropDownValues()).usingRecursiveComparison().ignoringCollectionOrder()
                .as("Assignee\\(s) drop-down list doesn't contain expected values")
                .isEqualTo(getUserGroupNamesByStatus(ACTIVE_STATUS));
        activityPage.clickDropDownAssignee();
    }

    @Then("Assignee options are displayed")
    public void assigneeOptionsAreDisplayed() {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(activityPage.isUserRadioButtonDisplayed())
                .as("Assignee user option is not displayed")
                .isTrue();
        softAssert.assertThat(activityPage.isGroupRadioButtonDisplayed())
                .as("Assignee group option is not displayed")
                .isTrue();
        softAssert.assertAll();
    }

    @Then("The set up values are displayed in the corresponding fields")
    public void theSetUpValuesAreDisplayedInTheCorrespondingFields(List<String> expectedResult) {
        assertThat(activityPage.getAssessmentFieldsTexts())
                .as("Values are unexpected")
                .containsAll(expectedResult);
    }

    @Then("Activity {string} Detail page is shown with expected details")
    public void activityDetailPageIsShownWithExpectedDetails(String activityReference) {
        WorkflowActivityData expectedData = newInstance(
                (WorkflowActivityData) context.getScenarioContext().getContext(activityReference));
        expectedData.setIsUserAssignee(null);
        WorkflowActivityData actualData = activityPage.getActivityDetails();
        assertThat(actualData)
                .as("Activity Detail page doesn't contain expected details")
                .usingRecursiveComparison().ignoringFields("assessment").isEqualTo(expectedData);
    }

    @Then("Edit Activity {string} Detail page is shown with expected details")
    public void editActivityDetailPageIsShownWithExpectedDetails(String activityReference) {
        activityPage.waitWhilePreloadProgressbarIsDisappeared();
        WorkflowActivityData expectedData = newInstance(
                (WorkflowActivityData) context.getScenarioContext().getContext(activityReference));
        WorkflowActivityData actualData = activityPage.getEditActivityDetails(expectedData.getIsUserAssignee());
        expectedData.setIsUserAssignee(null);
        assertThat(actualData)
                .as("Activity Detail page doesn't contain expected details")
                .usingRecursiveComparison().ignoringFields("assessment").isEqualTo(expectedData);
    }

    @Then("Activity button 'Edit' should be enabled")
    public void activityButtonShouldBeEnabled() {
        assertThat(activityPage.isEditButtonEnabled())
                .as("Activity button 'Edit' is not enabled")
                .isTrue();
    }

    @Then("^Add reviewer button is (disabled|enabled)$")
    public void addReviewerButtonIsDisabled(String state) {
        boolean isButtonDisabled = reviewerTabPage.isAddReviewerButtonDisabled();
        if (state.equals(DISABLED)) {
            assertThat(isButtonDisabled)
                    .as("Add reviewer button is not disabled")
                    .isTrue();
        } else {
            assertThat(isButtonDisabled)
                    .as("Add reviewer button is not enabled")
                    .isFalse();
        }
    }

    @Then("^Add approver button is (disabled|enabled)$")
    public void addApproverButtonIsDisabled(String state) {
        boolean isButtonDisabled = approverTabPage.isAddApproverButtonDisabled();
        if (state.equals(DISABLED)) {
            assertThat(isButtonDisabled)
                    .as("Add approver button is not disabled")
                    .isTrue();
        } else {
            assertThat(isButtonDisabled)
                    .as("Add approver button is not enabled")
                    .isFalse();
        }
    }

    @Then("Review Process table is displayed")
    public void reviewProcessTableIsDisplayed() {
        reviewerTabPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(reviewerTabPage.isPageLoaded())
                .as("Review Process table is not displayed")
                .isTrue();
    }

    @Then("^Rule section on position (\\d+) (has|has not) remove icon$")
    public void ruleSectionOnPositionHasRemoveIcon(int sectionPosition, String state) {
        if (state.contains(NOT)) {
            assertThat(reviewerTabPage.isRemoveRuleButtonDisplayed(sectionPosition))
                    .as("Rule section on position %s has remove icon", sectionPosition)
                    .isFalse();
        } else {
            assertThat(reviewerTabPage.isRemoveRuleButtonDisplayed(sectionPosition))
                    .as("Rule section on position %s has not remove icon", sectionPosition)
                    .isTrue();
        }
    }

    @Then("Approver Rule section on position {int} has remove icon")
    public void approverRuleSectionOnPositionHasRemoveIcon(int sectionPosition) {
        assertThat(approverTabPage.isRemoveRuleButtonDisplayed(sectionPosition))
                .as("Approver Rule section on position %s has not remove icon", sectionPosition)
                .isTrue();
    }

    @Then("Page title is {string}")
    public void pageTitleIs(String expectedResult) {
        assertThat(reviewerTabPage.getPageTitle())
                .as("Page title is not %s", expectedResult)
                .isEqualTo(expectedResult);
    }

    @Then("Rule section on position {int} is disappeared")
    public void ruleSectionOnPositionIsDisappeared(int sectionPosition) {
        assertThat(reviewerTabPage.isRoleSectionDisplayed(sectionPosition))
                .as("Rule section on position %s is not disappeared", sectionPosition)
                .isFalse();
    }

    @Then("Approver rule section on position {int} is disappeared")
    public void approverRuleSectionOnPositionIsDisappeared(int sectionPosition) {
        assertThat(approverTabPage.isRuleSectionNumberDisplayed(sectionPosition))
                .as("Approver rule section on position %s is not disappeared", sectionPosition)
                .isFalse();
    }

    @Then("Rule section on position {string} is displayed")
    public void ruleSectionOnPositionIsDisplayed(String sectionPosition) {
        assertThat(reviewerTabPage.getRuleSectionNumber(sectionPosition))
                .as("Rule section on position %s is not displayed", sectionPosition)
                .isEqualTo(sectionPosition);
    }

    @Then("Approver rule section on position {string} is displayed")
    public void approverRuleSectionOnPositionIsDisplayed(String sectionPosition) {
        assertThat(approverTabPage.getRuleSectionNumber(sectionPosition))
                .as("Approver rule section on position %s is not displayed", sectionPosition)
                .isEqualTo(sectionPosition);
    }

    @Then("Review Process modal is disappeared")
    public void reviewProcessModalIsDisappeared() {
        assertThat(reviewerTabPage.isReviewModalDisplayed())
                .as("Review Process modal is not disappeared")
                .isFalse();
    }

    @Then("Review Process table is displayed with columns")
    public void reviewProcessTableIsDisplayedWithColumns(DataTable dataTable) {
        assertThat(reviewerTabPage.getColumnNames())
                .as("Review Process table doesn't contain expected columns")
                .isEqualTo(dataTable.asList());
    }

    @Then("All review processes containing {string} keyword in a process Review Process Name field are shown")
    public void allReviewProcessesContainingKeywordInAProcessReviewProcessNameFieldAreShown(String keyWord) {
        assertThat(reviewerTabPage.isResultsFilteredByKeyword(keyWord))
                .as("Review Process table is not filtered by '%s' keyword", keyWord)
                .isTrue();
    }

    @Then("Reviewer overview page contains expected list details")
    public void reviewerOverviewPageContainsExpectedListDetails() {
        assertThat(reviewerTabPage.getReviewerDetails())
                .as("Reviewer overview page doesn't contain expected list details")
                .isEqualTo(reviewerDataList);
    }

    @Then("Approver overview page contains expected list details")
    public void approverOverviewPageContainsExpectedListDetails() {
        assertThat(approverTabPage.getApproverDetails())
                .as("Approver overview page doesn't contain expected list details")
                .isEqualTo(approverDataList);
    }

    @Then("Reviewer overview page contains expected {string} details")
    public void reviewerOverviewPageContainsExpectedDetails(String reviewerReference) {
        WorkflowReviewerApproverData expectedData =
                new JsonUiDataTransfer<WorkflowReviewerApproverData>(WORKFLOW_REVIEWER).getTestData()
                        .get(reviewerReference)
                        .getDataToEnter();
        assertThat(reviewerTabPage.getReviewerDetails())
                .as("Reviewer overview page details are unexpected")
                .contains(expectedData);
    }

    @Then("Approver overview page contains expected {string} details")
    public void approverOverviewPageContainsExpectedDetails(String approverReference) {
        WorkflowReviewerApproverData expectedData =
                new JsonUiDataTransfer<WorkflowReviewerApproverData>(WORKFLOW_REVIEWER).getTestData()
                        .get(approverReference)
                        .getDataToEnter();
        List<WorkflowReviewerApproverData> approverDetails = approverTabPage.getApproverDetails();
        assertThat(approverDetails)
                .as("Approve overview page details are unexpected")
                .contains(expectedData);
    }

    @Then("Reviewer edit page contains expected {string} details")
    public void reviewerEditPageContainsExpectedDetails(String reviewerReference) {
        reviewerTabPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        WorkflowReviewerApproverData expectedData =
                new JsonUiDataTransfer<WorkflowReviewerApproverData>(WORKFLOW_REVIEWER).getTestData()
                        .get(reviewerReference)
                        .getDataToEnter();
        assertThat(reviewerTabPage.getReviewerDetails())
                .as("Reviewer edit page details are unexpected")
                .contains(expectedData);
    }

    @Then("Approver edit page contains expected {string} details")
    public void approverEditPageContainsExpectedDetails(String approverReference) {
        WorkflowReviewerApproverData expectedData =
                new JsonUiDataTransfer<WorkflowReviewerApproverData>(WORKFLOW_REVIEWER).getTestData()
                        .get(approverReference)
                        .getDataToEnter();
        List<WorkflowReviewerApproverData> approverEditDetails = approverTabPage.getApproverDetails();
        assertThat(approverEditDetails)
                .as("Approver edit page details are unexpected")
                .contains(expectedData);
    }

    @Then("Review Process modal {int} section is displayed with fields")
    public void reviewProcessModalSectionIsDisplayedWithFields(int sectionIndex, List<String> expectedResult) {
        assertThat(reviewerTabPage.getReviewProcessOverviewFields(sectionIndex))
                .as("Review Process fields are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Edit Activity Status field is disabled")
    public void isEditActivityStatusFieldDisabled() {
        assertThat(activityPage.isEditActivityStatusFieldDisabled())
                .as("Edit Activity Status field is not disabled")
                .isTrue();
    }

    @Then("Edit Activity {string} Assignees field is empty")
    public void isEditActivityAssigneesFieldEmpty(String assigneeType) {
        assertThat(activityPage.getEditAssigneesValue(assigneeType.equalsIgnoreCase(USER)))
                .as("Edit Activity Assignees field is not empty!")
                .isNull();
    }

    @Then("^Workflow Activity field should (be|not be) highlighted in red$")
    public void checkFieldHighlightedInRed(String state, DataTable data) {
        String fieldHighlightedRed = "be";
        SoftAssertions soft = new SoftAssertions();
        List<String> fields = data.asList();
        if (state.equals(fieldHighlightedRed)) {
            fields.forEach(field -> soft.assertThat(activityPage.isFieldHighlightedInRed(field))
                    .as(field + " is not highlighted in red")
                    .isTrue());
        } else {
            fields.forEach(field -> soft.assertThat(activityPage.isFieldHighlightedInRed(field))
                    .as(field + " is highlighted in red")
                    .isFalse());
        }
        soft.assertAll();
    }

    @Then("Error message {string} is displayed on Workflow Add Activity page for fields")
    public void errorMessageShouldBeDisplayedOnWorkflowAddActivityPage(String message, DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        table.asList().forEach(field -> soft.assertThat(activityPage.getValidationMessageForDropDownField(field))
                .as(field + " error message is incorrect")
                .isEqualTo(message));
        soft.assertAll();
    }

    @Then("Assessment fields should be disabled")
    public void checkAssessmentFieldsAreDisabled() {
        assertThat(activityPage.areAssessmentFieldDisabled())
                .as("Assessment fields are not disabled")
                .isTrue();
    }

    @Then("Assessment fields should be absent")
    public void checkAssessmentFieldsAreAbsent() {
        assertThat(activityPage.isAssessmentFieldDisplayed())
                .as("Assessments fields still displayed")
                .isFalse();
    }

    @Then("Assignee('s) field should be hidden")
    public void assigneeInputIsHidden() {
        assertThat(activityPage.isAssigneeInputHidden())
                .as("Assignee input is displayed")
                .isTrue();
    }

    @Then("^Activity \"((.*))\" tab is (disabled|enabled)$")
    public void checkActivityTabState(String tabName, String state) {
        if (state.equals(ENABLED)) {
            assertThat(activityPage.isActivityTabDisabled(tabName)).as("Activity tab: " + tabName + " is not enabled!")
                    .isFalse();
        } else {
            assertThat(activityPage.isActivityTabDisabled(tabName)).as("Activity tab: " + tabName + " is not disabled!")
                    .isTrue();
        }
    }

    @Then("Activity {string} tab is greyed")
    public void checkActivityTabGreyed(String tabName) {
        assertThat(activityPage.getActivityTabColor(tabName))
                .as(tabName + " tab is not greyed")
                .isEqualTo(Colors.DISABLE_GREY.getColorRgba());
    }

    @Then("Activity Type drop-down value makes Add Reviewer tab in state")
    public void checkAddReviewerOnActivityTypeValue(DataTable dataTable) {
        Map<String, String> activityTypeStates = dataTable.asMap(String.class, String.class);
        SoftAssertions softAssertions = new SoftAssertions();
        activityTypeStates.forEach((type, state) -> {
            activityPage.fillInActivityType(type);
            softAssertions.assertThat(activityPage.isActivityTabDisabled(ADD_REVIEWER_TAB))
                    .as(type + " tab is not " + state)
                    .isEqualTo(state.equalsIgnoreCase(DISABLED));
        });
        softAssertions.assertAll();
    }

    @Then("No Review Process Available message is displayed")
    public void isNoReviewProcessMsgDisplayed() {
        assertThat(reviewerTabPage.isNoReviewProcessMsgDisplayed())
                .as("No Review Process Available message is not displayed")
                .isTrue();
    }

    @Then("Searched Review Process {string} is shown")
    public void isReviewProcessSearched(String processName) {
        if (processName.equals(VALUE_TO_REPLACE)) {
            processName = (String) this.context.getScenarioContext().getContext(EXISTING_REVIEW_PROCESS);
        }
        assertThat(reviewerTabPage.isReviewProcessDisplayed(processName))
                .as("Review Process '%s' wasn't found", processName).isTrue();
    }

    @Then("Workflow Activity Responsible Party assignee is selected")
    public void workflowActivityResponsiblePartyAssigneeIsSelected() {
        assertThat(activityPage.isPickResponsiblePartyRadio())
                .as("Responsible Party assignee is not selected").isTrue();
    }

    @Then("Internal Relevant Questionnaires drop-down contains all internal questionnaires")
    public void relevantQuestionnairesDropDownContainsAllInternalQuestionnaires() {
        activityPage.clickRelevantQuestionnairesDropdown();
        assertThat(activityPage.getDropDownValues())
                .as("Internal Relevant Questionnaires drop-down list doesn't contain expected values")
                .containsExactlyInAnyOrderElementsOf(getFilteredQuestionnaires(true));
        activityPage.clickRelevantQuestionnairesDropdown();
    }

    @Then("External Relevant Questionnaires drop-down contains all external questionnaires")
    public void relevantQuestionnairesDropDownContainsAllExternalQuestionnaires() {
        activityPage.clickRelevantQuestionnairesDropdown();
        assertThat(activityPage.getDropDownValues())
                .as("External Relevant Questionnaires drop-down list doesn't contain expected values")
                .containsExactlyInAnyOrderElementsOf(getFilteredQuestionnaires(false));
        activityPage.clickRelevantQuestionnairesDropdown();
    }

    @Then("\"(All|Internal|External)\" Relevant Questionnaire dropdown button should be enabled$")
    public void relevantQuestionnaireDropdownButtonShouldBeEnabled(String questionnaireType) {
        switch (QuestionnaireType.valueOf(questionnaireType.toUpperCase())) {
            case INTERNAL:
                assertThat(activityPage.isInternalRelevantQuestionnairesDropdownEnabled())
                        .as("Internal Relevant Questionnaire dropdown button is not enabled")
                        .isTrue();
                break;
            case EXTERNAL:
                assertThat(activityPage.isExternalRelevantQuestionnairesDropdownEnabled())
                        .as("External Relevant Questionnaire dropdown button is not enabled")
                        .isTrue();
                break;
            default:
                throw new IllegalArgumentException(
                        format("Dropdown button '%s' element is not expected!", questionnaireType));
        }
    }

    @Then("\"((.*))\" questionnaire type radio button should be (selected|unselected)$")
    public void allQuestionnaireTypeRadioButtonShouldBeSelected(String buttonName, String state) {
        if (state.equals(SELECTED)) {
            assertThat(activityPage.isQuestionnaireTypeRadioButtonSelected(buttonName))
                    .as("%s questionnaire type radio button is not selected", buttonName)
                    .isTrue();
        } else {
            assertThat(activityPage.isQuestionnaireTypeRadioButtonSelected(buttonName))
                    .as("%s questionnaire type radio button is selected", buttonName)
                    .isFalse();
        }
    }

    @Then("Relevant Internal Questionnaire field should be empty")
    public void relevantInternalQuestionnaireIsEmpty() {
        assertThat(activityPage.getCurrentRelevantQuestionnaireDropdownValue())
                .as("Responsible Party assignee is not selected").isEqualTo(null);
    }

    @Then("Relevant External Questionnaire field should be empty")
    public void relevantExternalQuestionnaireIsEmpty() {
        assertThat(activityPage.getCurrentRelevantQuestionnaireDropdownValue())
                .as("Responsible Party assignee is not selected").isEqualTo(null);
    }

    @Then("Relevant All Questionnaire field should be empty")
    public void relevantAllQuestionnaireIsEmpty() {
        assertThat(activityPage.getCurrentRelevantQuestionnaireDropdownValue())
                .as("Responsible Party assignee is not selected").isEqualTo(RELEVANT_QUESTIONNAIRES);
    }

    @When("User selects Scope Type as {string}")
    public void selectScopeType(String type) {
        activityPage.fillInScopeType(type);
    }

    @When("User ticks Automatically order recommended scope of Due Diligence report checkbox")
    public void tickAutomaticallyOrderRecommendedScopeofDueDiligenceReportCheckbox() {
        activityPage.tickAutomaticallyOrderRecommendedScopeofDueDiligenceReportCheckbox();
    }

    @Then("User Group radio button should be disabled")
    public void checkUserGroupRadioButtonIsDisabled() {
        assertThat(activityPage.isUserGroupRadioButtonDisabled())
                .as("User Group radio button is not disabled")
                .isFalse();
    }

    @Then("Pending for Assignment checkbox is disabled")
    public void checkPendingForAssignmentCheckboxIsDisabled() {
        assertThat(activityPage.isPendingForAssignmentCheckboxDisabled())
                .as("Pending for Assignment checkbox is not disabled")
                .isFalse();
    }

    @Then("Automatically order recommended scope of Due Diligence is disabled")
    public void automaticallyOrderRecommendedScopeOfDueDiligenceIsDisabled() {
        assertThat(activityPage.isActivityCheckboxDisabled())
                .as("Recommended scope checkbox is not disabled")
                .isFalse();
    }

    @When("User ticks Retrieve the reviewer of each questionnaire setup checkbox")
    public void tickRetrieveReviewerQuestionnaireCheckbox() {
        activityPage.tickRetrieveReviewerQuestionnaireCheckbox();
    }

    @Then("Error message {string} is displayed in 'Please select the recommended scope' section")
    public void isErrorMessageDisplayed(String expectedResult) {
        assertThat(activityPage.getRecommendedScopeErrorMessage())
                .as("Recommended scope error message %s is not displayed").isEqualTo(expectedResult);

    }

    @Then("^Automatically order recommended scope of Due Diligence report checkbox is (checked|unchecked)$")
    public void automaticallyOrderRecommendedScopeofDueDiligenceReportCheckboxIsChecked(String checkboxState) {
        String expectedStatus = checkboxState.equals(CHECKED) ? ACTIVE.getStatus() : INACTIVE.getStatus();
        assertThat(activityPage.getStatus()).as("Active status is unexpected")
                .isEqualTo(expectedStatus);

    }

}