package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.workflowManagement.workflow;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.SIPublicApi;
import com.refinitiv.asts.test.ui.api.WorkflowApi;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RefDataResponse;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RiskScoreEngineResponse;
import com.refinitiv.asts.test.ui.api.model.valueManagement.Value;
import com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse.WorkFlowItem;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.Status;
import com.refinitiv.asts.test.ui.enums.ValueTypeName;
import com.refinitiv.asts.test.ui.enums.WorkflowManagementWorkflowColumns;
import com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow.ReviewerPage;
import com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow.WorkflowPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowActivityData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowGroupData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowReviewerApproverData;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.netty.karate.util.internal.StringUtil;
import org.apache.commons.lang.RandomStringUtils;
import org.assertj.core.api.SoftAssertions;
import org.testng.SkipException;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.AppApi.getRiskScoringList;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getTenantFeatureManagement;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.*;
import static com.refinitiv.asts.test.ui.constants.APIConstants.ASC;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.*;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_RED;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.*;
import static com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow.WorkflowPage.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static java.lang.String.format;
import static java.lang.String.valueOf;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static java.util.UUID.randomUUID;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.assertj.core.api.Assertions.assertThat;

public class WorkflowSteps extends BaseSteps {

    private final WorkflowPage workflowPage;
    private final ActivitySteps activitySteps;
    private final ReviewerPage reviewerTabPage;
    private int componentPosition = 0;
    private String workflowName;
    private String updatedWorkflowName;

    public WorkflowSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.workflowPage = new WorkflowPage(this.driver, translator);
        this.activitySteps = new ActivitySteps(this.context);
        this.reviewerTabPage = new ReviewerPage(driver, context);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public WorkflowData providerEntry(Map<String, String> entry) {
        return new WorkflowData(
                entry.get(WorkflowManagementWorkflowColumns.WORKFLOW_NAME.getDefaultName()),
                entry.get(WorkflowManagementWorkflowColumns.WORKFLOW_TYPE.getDefaultName()),
                entry.get(WorkflowManagementWorkflowColumns.DATE_CREATED.getDefaultName()),
                entry.get(WorkflowManagementWorkflowColumns.LAST_UPDATED.getDefaultName()),
                entry.get(WorkflowManagementWorkflowColumns.STATUS.getDefaultName()));
    }

    private boolean doesWorkflowExist(String workflowName) {
        return getWorkflowList().stream()
                .anyMatch(workflow -> nonNull(workflow.getName()) && workflow.getName().equals(workflowName));
    }

    @When("Workflow {string} is updated with type {string}")
    public void updateWorkflowTypeByAPI(String workflowName, String workflowType) {
        if (workflowName.equals(VALUE_TO_REPLACE)) {
            workflowName = (String) context.getScenarioContext().getContext(WORKFLOW_NAME_CONTEXT);
        }
        context.getScenarioContext().setContext(WORKFLOW_DEFAULT_TYPE, workflowType);
        context.getScenarioContext().setContext(WORKFLOW_NAME_CONTEXT, workflowName);
        WorkFlowItem workflow = WorkflowApi.getWorkflowByName(workflowName);
        if (nonNull(workflow)) {
            workflow.setType(workflowType);
            WorkflowApi.updateWorkflow(workflow, workflow.getId());
        } else {
            throw new IllegalArgumentException("Workflow with name '" + workflowName + "' is not found");
        }
    }

    @When("User navigates to 'Workflow Management' block 'Workflow' section")
    public void navigateToWorkflowPage() {
        workflowPage.navigateToWorkflowPage();
    }

    @When("Skip Workflow {string} creation if already exists")
    public void skipWorkflowCreationIfExists(String workflowReference) {
        if (doesWorkflowExist(workflowReference)) {
            throw new SkipException(workflowReference + " already exists!");
        }
    }

    @When("User clicks workflow button {string}")
    public void clickWorkflowButtonWithName(String button) {
        workflowPage.clickWorkflowButton(button);
    }

    @When("User clicks workflow button Commit New Version")
    public void clickCommitNewVersion() {
        workflowPage.clickWorkflowButton(COMMIT_NEW_VERSION);
        if (Objects.nonNull(updatedWorkflowName)) {
            workflowName = updatedWorkflowName;
            this.context.getScenarioContext().setContext(WORKFLOW_NAME_CONTEXT, updatedWorkflowName);
        }
    }

    @When("User creates new Workflow {string} with Activity {string}")
    public void createNewWorkflow(String workflowReference, String activity) {
        navigateToWorkflowPage();
        workflowPage.clickButtonAddWorkflow();
        fillInWorkflowDetailsData(workflowReference);
        workflowPage.clickNextButton();
        workflowPage.clickAddWizardComponentButton();
        componentPosition = 1;
        addNewActivity(activity);
        clickSaveButtonForWorkflow();
    }

    @When("User creates new Workflow {string} with Activity {string} with Reviewer {string}")
    public void createNewWorkflowWithActivityAndReviewer(String workflowReference, String activity, String reviewer) {
        navigateToWorkflowPage();
        workflowPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        workflowPage.clickButtonAddWorkflow();
        fillInWorkflowDetailsData(workflowReference);
        workflowPage.clickNextButton();
        clickAddWizardComponentBtn();
        clickAddActivityButton();
        activitySteps.fillInActivityDetails(activity);
        activitySteps.clickActivityTab(ADD_REVIEWER_TAB);
        activitySteps.selectValueForDefaultReviewer(reviewer);
        activitySteps.clickDoneButtonForActivity();
        clickSaveButtonForWorkflow();
    }

    @When("^User creates new Workflow \"(.*)\" with Activity \"(.*)\" with Reviewer \"(.*)\" with Reviewer rules$")
    public void createNewWorkflowWithActivityAndReviewerRules(String workflowReference, String activity,
            String defaultReviewer, List<String> reviewerRules) {
        navigateToWorkflowPage();
        workflowPage.clickButtonAddWorkflow();
        fillInWorkflowDetailsData(workflowReference);
        workflowPage.clickNextButton();
        clickAddWizardComponentBtn();
        clickAddActivityButton();
        workflowPage.waitWhilePreloadProgressbarIsDisappeared();
        activitySteps.fillInActivityDetails(activity);
        activitySteps.clickActivityTab(ADD_REVIEWER_TAB);
        activitySteps.selectValueForDefaultReviewer(defaultReviewer);
        IntStream.rangeClosed(1, reviewerRules.size()).forEach(i -> {
            WorkflowReviewerApproverData reviewerData =
                    new JsonUiDataTransfer<WorkflowReviewerApproverData>(WORKFLOW_REVIEWER).getTestData()
                            .get(reviewerRules.get(i - 1))
                            .getDataToEnter();
            reviewerTabPage.fillInReviewerDetails(reviewerData, i);
            if (i < reviewerRules.size()) {
                reviewerTabPage.clickAddReviewerButton();
            }
        });
        activitySteps.clickDoneButtonForActivity();
        clickSaveButtonForWorkflow();
    }

    @When("User creates new Workflow {string} with Activity {string} with Approver {string} and Reviewer {string}")
    public void createNewWorkflowWithApproverAndReviewer(String workflowReference, String activity, String approver,
            String reviewer) {
        navigateToWorkflowPage();
        workflowPage.clickButtonAddWorkflow();
        fillInWorkflowDetailsData(workflowReference);
        workflowPage.clickNextButton();
        clickAddWizardComponentBtn();
        clickAddActivityButton();
        activitySteps.fillInActivityDetails(activity);
        activitySteps.clickActivityTab(ADD_APPROVER_TAB);
        activitySteps.selectValueForDefaultApprover(approver);
        activitySteps.clickActivityTab(ADD_REVIEWER_TAB);
        activitySteps.selectValueForDefaultReviewer(reviewer);
        activitySteps.clickDoneButtonForActivity();
        clickSaveButtonForWorkflow();
    }

    @When("User adds new Activity {string} with Approver {string} and Reviewer {string}")
    public void addNewActivityWithApproverAndReviewer(String activity, String approver, String reviewer) {
        clickAddActivityButton();
        activitySteps.fillInActivityDetails(activity);
        activitySteps.clickActivityTab(ADD_APPROVER_TAB);
        activitySteps.selectValueForDefaultApprover(approver);
        activitySteps.clickActivityTab(ADD_REVIEWER_TAB);
        activitySteps.selectValueForDefaultReviewer(reviewer);
        activitySteps.clickDoneButtonForActivity();
    }

    @When("User adds new Activity {string} with Approver {string}")
    public void addNewActivityWithApprover(String activity, String approver) {
        clickAddActivityButton();
        activitySteps.fillInActivityDetails(activity);
        activitySteps.clickActivityTab(ADD_APPROVER_TAB);
        activitySteps.selectValueForDefaultApprover(approver);
        activitySteps.clickDoneButtonForActivity();
    }

    @When("User adds new Activity {string}")
    public void addNewActivity(String activityReference) {
        clickAddActivityButton();
        activitySteps.fillInActivityDetails(activityReference);
        activitySteps.clickDoneButtonForActivity();
    }

    @When("User fills new Activity {string} details")
    public void fillNewActivityDetails(String activityReference) {
        clickAddActivityButton();
        activitySteps.fillInActivityDetails(activityReference);
    }

    @When("User adds new Activity {string} with {string} data")
    public void addNewActivityWithData(String activityName, String activityReference) {
        workflowPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        clickAddActivityButton();
        workflowPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        activitySteps.fillInActivityNameDetails(activityName, activityReference);
        activitySteps.clickDoneButtonForActivity();
    }

    @When("User adds new Activity {string} with {string} data with Reviewer {string}")
    public void addNewActivityWithDataAndReviewer(String activityName, String activityReference, String reviewer) {
        clickAddActivityButton();
        activitySteps.fillInActivityNameDetails(activityName, activityReference);
        activitySteps.clickActivityTab(ADD_REVIEWER_TAB);
        activitySteps.selectValueForDefaultReviewer(reviewer);
        activitySteps.clickDoneButtonForActivity();
    }

    @When("User fills in workflow details data {string}")
    public void fillInWorkflowDetailsData(String workflowReference) {
        String workflowGroupName;
        WorkflowData workflowData =
                new JsonUiDataTransfer<WorkflowData>(WORKFLOW_MANAGEMENT_WORKFLOW)
                        .getTestData().get(workflowReference)
                        .getDataToEnter();
        if (workflowData.getWorkflowName().equals(VALUE_TO_REPLACE)) {
            workflowName = AUTO_TEST_NAME_PREFIX + randomUUID();
        } else {
            workflowName = workflowData.getWorkflowName();
        }
        if (workflowData.getWorkflowGroup().equals(VALUE_TO_REPLACE)) {
            postNewWorkflowGroup(workflowName, true);
            workflowGroupName = workflowName;
            workflowPage.refreshPage();
            this.context.getScenarioContext().setContext(WORKFLOW_GROUP_NAME_CONTEXT, workflowName);
        } else if (workflowData.getWorkflowGroup().equals(WORKFLOW_GROUP_NAME_CONTEXT)) {
            workflowGroupName = (String) context.getScenarioContext().getContext(WORKFLOW_GROUP_NAME_CONTEXT);
        } else {
            workflowGroupName = workflowData.getWorkflowGroup();
        }
        workflowData.setWorkflowName(workflowName).setWorkflowGroup(workflowGroupName);
        workflowData = updateRiskScoringRange(workflowData);
        this.context.getScenarioContext().setContext(WORKFLOW_NAME_CONTEXT, workflowData.getWorkflowName());
        this.context.getScenarioContext().setContext(WORKFLOW_DATA_CONTEXT, workflowData);
        workflowPage.fillInWorkflowType(workflowData.getWorkflowType());
        workflowPage.fillInDescription(workflowData.getDescription());
        workflowPage.tickActiveCheckbox(workflowData.getStatus());
        workflowPage.fillInRiskScoringRange(workflowData.getRiskScoringRange());
        workflowPage.fillInWorkflowGroup(workflowData.getWorkflowGroup());
        workflowPage.fillInWorkflowName(workflowData.getWorkflowName());
    }

    private WorkflowData updateRiskScoringRange(WorkflowData workflowData) {
        String name;
        Object min;
        Object max;
        if (getTenantFeatureManagement().isDisableDynamicRiskScoringEngine()) {
            WorkflowData riskScoring = getRiskScoringList().stream()
                    .filter(range -> range.getRiskScoringRange().contains(workflowData.getRiskScoringRange()))
                    .findFirst()
                    .orElse(new WorkflowData());
            name = riskScoring.getRiskScoringRange();
            min = riskScoring.getFrom();
            max = riskScoring.getTo();
        } else {
            RiskScoreEngineResponse.DataItem.RangesItem riskScoring =
                    SIPublicApi.getRiskScoreEngineRanges().getData().stream()
                            .flatMap(range -> range.getRanges().stream())
                            .filter(range -> range.getName().contains(workflowData.getRiskScoringRange()))
                            .findFirst()
                            .orElse(new RiskScoreEngineResponse.DataItem.RangesItem());
            name = riskScoring.getName();
            min = riskScoring.getMin();
            max = riskScoring.getMax();
        }
        if (isNull(name)) {
            WorkFlowItem workflowResponse = getWorkflowList().stream()
                    .filter(workflow -> Objects.nonNull(workflow.getName()) &&
                            workflow.getName().equals(workflowData.getRiskScoringRange()))
                    .findFirst().orElse(new WorkFlowItem());
            name = workflowResponse.getRiskScoringRange().getName();
            min = workflowResponse.getRiskScoringRange().getMin();
            max = workflowResponse.getRiskScoringRange().getMax();
        }
        workflowData.setRiskScoringRange(format(RISK_RANGE_FORMAT, name, min, max))
                .setFrom(valueOf(min))
                .setTo(valueOf(max));
        return workflowData;
    }

    @When("User clicks Workflow Management Workflow submenu in Set Up menu")
    public void clickWorkflowManagementSubmenuWorkflow() {
        workflowPage.clickWorkflowManagementSubmenuWorkflow();
    }

    @When("User clicks workflow from Workflow table")
    public void clickWorkflowFromWorkflowTable() {
        workflowName = workflowPage.getFirstWorkflowName();
        workflowPage.clickOnFirstWorkflowName();
    }

    @When("User clicks on workflow with name {string}")
    public void clickWorkflowFromWorkflowTable(String name) {
        this.context.getScenarioContext().setContext(WORKFLOW_NAME_CONTEXT, name);
        workflowName = name;
        workflowPage.searchWorkflowByName(name);
        workflowPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        workflowPage.clickOnFirstWorkflowName();
    }

    @When("User clicks Add Workflow button")
    public void clickAddWorkflowBtn() {
        workflowPage.clickButtonAddWorkflow();
    }

    @When("User populates Workflow Name with {string}")
    public void fillInWorkflowNameWith(String name) {
        workflowName = name + RandomStringUtils.randomAlphanumeric(10);
        workflowPage.fillInWorkflowName(workflowName);
        this.context.getScenarioContext().setContext(WORKFLOW_NAME_CONTEXT, workflowName);
    }

    @When("User updates Workflow Name with {string}")
    public void updateWorkflowName(String name) {
        updatedWorkflowName = name + RandomStringUtils.randomAlphanumeric(10);
        workflowPage.fillInWorkflowName(updatedWorkflowName);
    }

    @When("User fills in Workflow Type {string}")
    public void fillInWorkflowType(String type) {
        workflowPage.fillInWorkflowType(type);
        if (!workflowPage.isRiskScoringRangeDropDownDisplayed()) {
            workflowPage.fillInWorkflowType(type);
        }
    }

    @When("User populates Workflow Description with {string}")
    public void fillInWorkflowDescriptionWith(String description) {
        workflowPage.fillInDescription(description);
    }

    @When("User selects available Risk Scoring Range in range")
    public void chooseRiskScoringRange() {
        String valueTypeId = AppApi.getValueTypeId(ValueTypeName.RISK_SCORING_RANGE);
        RefDataResponse riskRanges = AppApi.getRefDataPayload(valueTypeId);
        String riskScoringRangeName = Arrays.stream(riskRanges.getListValues()).map(Value::getName).findFirst()
                .orElse("No Available Risk Scoring Ranges for selection");
        workflowPage.fillInRiskScoringRange(riskScoringRangeName);
    }

    @When("User clicks Next button")
    public void clickNextBtn() {
        workflowPage.clickNextButton();
    }

    @When("User clicks Add Wizard Component button")
    public void clickAddWizardComponentBtn() {
        workflowPage.clickAddWizardComponentButton();
        componentPosition++;
    }

    @When("User updates Component Name {string} on position {int}")
    public void fillInComponentName(String name, int position) {
        workflowPage.clickEditComponentButton(position + 1);
        workflowPage.setComponentName(name, position + 1);
    }

    @When("User updates Component Name {string}")
    public void fillInComponentName(String name) {
        workflowPage.clickEditComponentButton(componentPosition);
        workflowPage.setComponentName(name, componentPosition);
    }

    @When("User clicks 'Edit' wizard component")
    public void clickEditWizardComponent() {
        workflowPage.clickEditWizardComponent();
    }

    @When("User clicks Check button")
    public void clickCheckButton() {
        workflowPage.clickCheckComponentButton(componentPosition);
    }

    @When("User clicks Check button on position {int}")
    public void clickCheckButtonOnPosition(int position) {
        workflowPage.clickCheckComponentButton(position + 1);
    }

    @When("User adds {int} components with {string} activity")
    public void addComponentsWithActivity(int componentCount, String activityReference) {
        for (int i = 0; i < componentCount; i++) {
            clickAddWizardComponentBtn();
            if (i >= 3) {
                componentPosition = 3;
            }
            workflowPage.clickEditComponentButton(componentPosition);
            workflowPage.setComponentName(AUTO_TEST_NAME_PREFIX + (i + 1), componentPosition);
            workflowPage.clickCheckComponentButton(componentPosition);
            addNewActivity(activityReference);
        }
    }

    @When("User adds component {string} with {int} {string} activities")
    public void addNewComponentWithActivity(String componentName, int activitiesCount, String activityReference) {
        clickAddWizardComponentBtn();
        fillInComponentName(componentName, componentPosition);
        workflowPage.clickCheckComponentButton(componentPosition);
        for (int i = 0; i < activitiesCount; i++) {
            addNewActivity(activityReference);
        }
    }

    @When("User clicks +Add Activity button")
    public void clickAddActivityButton() {
        workflowPage.clickAddActivity(componentPosition);
    }

    @When("User clicks Save button for Workflow")
    public void clickSaveButtonForWorkflow() {
        this.context.getScenarioContext().setContext(WORKFLOW_INACTIVATE_FLAG_CONTEXT, true);
        workflowPage.clickSaveButton();
    }

    @When("User clicks Save button for Workflow without context")
    public void clickSaveButtonForWorkflowNoContext() {
        workflowPage.clickSaveButton();
    }

    @When("User selects Risk scoring range and Workflow group combination of existing {string} workflow")
    public void selectExistingCombination(String name) {
        WorkFlowItem workflowResponse = getWorkflowList().stream()
                .filter(workflow -> Objects.nonNull(workflow.getName()) && workflow.getName().contains(name))
                .findFirst().orElse(new WorkFlowItem());
        WorkflowGroupData workflowGroup =
                getWorkflowGroupsList(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, DEFAULT_SORT_BY, DEFAULT_SORT).stream()
                        .filter(group -> group.getWorkflowGroupId().equals(workflowResponse.getWorkflowGroupId()))
                        .findFirst().orElse(new WorkflowGroupData());
        workflowPage.fillInRiskScoringRange(workflowResponse.getRiskScoringRange().getName());
        workflowPage.fillInWorkflowGroup(workflowGroup.getGroupName());
    }

    @When("^User clicks on (?:created|updated?) Workflow$")
    public void clickOnCreatedWorkflow() {
        workflowPage.searchWorkflowByName(workflowName);
        workflowPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        workflowPage.clickOnFirstWorkflowName();
    }

    @When("User clicks 'Edit' button for created Workflow")
    public void clickEditButtonForCreatedWorkflow() {
        clickEditButtonForWorkflow(workflowName);
    }

    @When("User clicks 'Edit' button for Workflow with name {string}")
    public void clickEditButtonForWorkflow(String workflowName) {
        workflowPage.searchWorkflowByName(workflowName);
        workflowPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        workflowPage.clickEditButtonForFirstWorkflow();
    }

    @When("Users drags component on position {int} and drop on position {int}")
    public void dragAndDropComponent(int fromPosition, int toPosition) {
        workflowPage.dragAndDropComponent(fromPosition + 1, toPosition + 2);
    }

    @When("^User clicks \"(Edit|Delete)\" button for component on position (\\d+)$")
    public void clickButtonForComponentOnPosition(String buttonType, int componentPosition) {
        switch (buttonType) {
            case EDIT:
                workflowPage.clickEditComponentButton(componentPosition + 1);
                break;
            case DELETE:
                workflowPage.clickDeleteComponentButton(componentPosition + 1);
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
    }

    @When("User clicks {string} icon for Activity {string}")
    public void clickViewActivityIcon(String action, String activityName) {
        workflowPage.clickActivityComponent(action, activityName);
    }

    @When("User clicks {string} {string} activity")
    public void clicksViewActivity(String action, String activityReference) {
        WorkflowActivityData activityData =
                (WorkflowActivityData) context.getScenarioContext().getContext(activityReference);
        clickViewActivityIcon(action, activityData.getActivityName());
    }

    @When("User clears workflow {string} input field")
    public void clearWorkflowInputField(String fieldName) {
        workflowPage.clearInput(fieldName);
    }

    @When("User clicks Edit workflow button")
    public void clickEditWorkflowButton() {
        workflowPage.clickEditWorkflowButton();
    }

    @When("User inactivates all Workflows with name prefix generated by auto tests via API")
    public void inactivateAllWorkflowsWithNamePrefixGeneratedByAutoTestsViaAPI() {
        getWorkflowList().forEach(
                workflow -> {
                    if (workflow.getName().startsWith(AUTO_TEST_NAME_PREFIX) &&
                            workflow.getStatus().equals(ACTIVE.getStatus())) {
                        workflow.setStatus(Status.INACTIVE.getStatus());
                        updateWorkflow(workflow, workflow.getId());
                    }
                }
        );
    }

    @When("User opens newly created Workflow")
    public void openCreatedWorkflow() {
        clickWorkflowFromWorkflowTable((String) context.getScenarioContext().getContext(WORKFLOW_NAME_CONTEXT));
    }

    @When("User inactivates last created workflow")
    public void inactivatesLastCreatedWorkflow() {
        String workflowName =
                (String) this.context.getScenarioContext().getContext(WORKFLOW_NAME_CONTEXT);
        WorkFlowItem workflow = WorkflowApi.getWorkflowByName(workflowName);
        if (nonNull(workflow)) {
            workflow.setStatus("Inactive");
            WorkflowApi.updateWorkflow(workflow, workflow.getId());
        }
    }

    @Then("Add Wizard page is displayed")
    public void isAddWizardPageDisplayed() {
        workflowPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(workflowPage.getPageHeaderText())
                .as("Page with name '%s' is not displayed", workflowName)
                .contains(workflowName.toUpperCase());
    }

    @Then("Workflow Table is displayed")
    public void workflowTableIsDisplayed() {
        workflowPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(workflowPage.isWorkflowTableDisplayed())
                .as("Workflow Table is not displayed")
                .isTrue();
    }

    @Then("^Workflow Create Workflow page is (disappeared|displayed)$")
    public void workflowCreateWorkflowPageIsDisappeared(String state) {
        workflowPage.waitWhilePreloadProgressbarIsDisappeared();
        if (state.equalsIgnoreCase(DISPLAYED)) {
            assertThat(workflowPage.getPageHeaderText())
                    .as("Create Workflow is not displayed")
                    .contains(ADD_WORKFLOW);
        } else {
            assertThat(workflowPage.isPageHeaderDisappeared())
                    .as("Create Workflow is not disappeared")
                    .isTrue();
        }
    }

    @Then("Workflow Active checkbox is ticked")
    public void isActiveCheckboxChecked() {
        assertThat(workflowPage.isWorkflowActiveCheckboxChecked())
                .as("Active checkbox is not ticked")
                .isTrue();
    }

    @Then("New Component Check button is enabled")
    public void isNewComponentDetailsEnabled() {
        assertThat(workflowPage.isNewComponentButtonEnabled(componentPosition))
                .as("New Component button is not enabled")
                .isTrue();
    }

    @Then("Component Name {string} is displayed")
    public void isComponentNameDisplayedWithName(String name) {
        if (componentPosition == 0) {
            componentPosition++;
        }
        assertThat(workflowPage.getComponentName(componentPosition))
                .as("Component with name '%s' is not displayed", name)
                .isEqualTo(name);
    }

    @Then("Component Name {string} for component on position {int} is displayed")
    public void validateComponentName(String name, int position) {
        assertThat(workflowPage.getComponentName(position + 1))
                .as("Component with name '%s' is not displayed", name)
                .isEqualTo(name);
    }

    @Then("New Component is created")
    public void newComponentIsCreated() {
        assertThat(workflowPage.isNewComponentCreated(componentPosition))
                .as("New Component is not created")
                .isTrue();
    }

    @Then("New Component header contains text {string}")
    public void newComponentHeaderContainsText(String expectedText) {
        assertThat(workflowPage.getComponentName(componentPosition))
                .as("New Component text is unexpected")
                .isEqualTo(expectedText);
    }

    @Then("Component Name field input is not displayed")
    public void componentNameFieldInputIsDisabled() {
        assertThat(workflowPage.isComponentNameInputDisplayed(componentPosition))
                .as("Component Name field input is not disabled")
                .isFalse();
    }

    @Then("Component Name input for component on position {int} is not displayed")
    public void validateComponentNameInputIsNotDisplayed(int position) {
        assertThat(workflowPage.isComponentNameInputDisplayed(position + 1))
                .as("Component Name field input is not disabled")
                .isFalse();
    }

    @Then("^Component \"(Edit|Delete)\" button is displayed$")
    public void componentButtonIsDisplayed(String buttonType) {
        boolean isElementDisplayed;
        switch (buttonType) {
            case EDIT:
                isElementDisplayed = workflowPage.isComponentEditButtonDisplayed(componentPosition);
                break;
            case DELETE:
                isElementDisplayed = workflowPage.isComponentDeleteButtonDisplayed(componentPosition);
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        assertThat(isElementDisplayed)
                .as("Component '%s' button is not displayed", buttonType)
                .isTrue();
    }

    @Then("Component {string} button for component on position {int} is displayed")
    public void validateComponentButtonIsDisplayed(String buttonType, int position) {
        boolean isElementDisplayed;
        switch (buttonType) {
            case EDIT:
                isElementDisplayed = workflowPage.isComponentEditButtonDisplayed(position + 1);
                break;
            case DELETE:
                isElementDisplayed = workflowPage.isComponentDeleteButtonDisplayed(position + 1);
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        assertThat(isElementDisplayed)
                .as("Component '%s' button is not displayed", buttonType)
                .isTrue();
    }

    @Then("Created Workflow is displayed in table with values")
    public void workflowIsDisplayedWithValues(WorkflowData expectedResult) {
        workflowPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String workflowName = (String) this.context.getScenarioContext().getContext(WORKFLOW_NAME_CONTEXT);
        expectedResult.setDateCreated(getTodayDate(expectedResult.getDateCreated()));
        if (expectedResult.getStatus() != null) {
            expectedResult.setStatus(workflowPage.getFromDictionaryIfExists(expectedResult.getStatus()));
        }
        if (expectedResult.getLastUpdate() != null) {
            expectedResult.setLastUpdate(getTodayDate(expectedResult.getLastUpdate()));
        }
        if (expectedResult.getWorkflowName().equals(VALUE_TO_REPLACE)) {
            expectedResult.setWorkflowName(workflowName);
        }
        workflowPage.searchWorkflowByName(workflowName);
        workflowPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(workflowPage.getAllFieldsTableValues())
                .as("Workflow is not displayed with expected values")
                .isEqualTo(expectedResult);
    }

    @Then("Workflow table column names should be correct")
    public void workflowColumnNamesShouldBeCorrect(List<String> expectedColumns) {
        assertThat(workflowPage.getTableColumnNames()).as("Workflow columns are unexpected")
                .isEqualTo(expectedColumns);
    }

    @Then("Workflows table displays workflow sorted by {string} in {string} order")
    public void usersTableIsSortedByField(String sortedBy, String sortOrder) {
        List<WorkflowData> expectedResult = getWorkflows(DEFAULT_ITEMS_PER_PAGE, sortedBy, sortOrder).getObjects()
                .stream()
                .map(workflow -> new WorkflowData()
                        .setWorkflowName(workflow.getName())
                        .setWorkflowType(workflow.getType())
                        .setDateCreated(getDateFromEpochMilli(workflow.getCreateTime(), REACT_FORMAT))
                        .setLastUpdate(getDateFromEpochMilli(workflow.getUpdateTime(), REACT_FORMAT))
                        .setStatus(workflow.getStatus()))
                .collect(Collectors.toList());
        assertThat(workflowPage.getAllWorkflowsData()).usingRecursiveComparison().ignoringActualNullFields()
                .as("Workflows table is not sorted")
                .isEqualTo(expectedResult);
    }

    @Then("Workflow overview has correct field titles")
    public void verifyWorkflowFieldTitles(List<String> expectedResult) {
        assertThat(workflowPage.getWorkflowOverviewFieldTitles())
                .as("Workflow overview fields are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Workflow page is displayed with expected details")
    public void workflowEditFieldsContainsProvidedValues() {
        WorkflowData expectedWorkflowData =
                (WorkflowData) context.getScenarioContext().getContext(WORKFLOW_DATA_CONTEXT);
        assertThat(workflowPage.getWorkflowData()).as("Workflow page data is unexpected")
                .isEqualTo(expectedWorkflowData);
    }

    @Then("Workflow overview is displayed")
    public void workflowOverviewIsDisplayed() {
        workflowPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        isAddWizardPageDisplayed();
        assertThat(workflowPage.isEditWorkflowButtonDisplayed())
                .as("Workflow Overview edit button is not displayed")
                .isTrue();
    }

    @Then("Workflow button {string} should be displayed")
    public void workflowButtonShouldBeDisplayed(String button) {
        assertThat(workflowPage.isWorkflowButtonDisplayed(button))
                .as("Button '%s' is not displayed", button)
                .isTrue();
    }

    @Then("^Workflow button \"(.*)\" should be (enabled|disabled)$")
    public void workflowButtonShouldBeEnabled(String button, String state) {
        if (state.equals(ENABLED)) {
            assertThat(workflowPage.isWorkflowButtonEnabled(button))
                    .as("Button '%s' is not enabled", button)
                    .isTrue();
        } else {
            assertThat(workflowPage.isWorkflowButtonEnabled(button))
                    .as("Button '%s' is not disabled", button)
                    .isFalse();
        }
    }

    @Then("User verifies workflow wizard elements are displayed")
    public void verifyWorkflowWizardsElementsAreDisplayed() {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(workflowPage.isAddWizardButtonDisplayed())
                .as("Component is not displayed on a page")
                .isTrue();
        softAssert.assertThat(workflowPage.isLinkAddActivityDisplayed(componentPosition))
                .as("Component link is not displayed on a page")
                .isTrue();
        softAssert.assertAll();
    }

    @Then("^Workflow Type drop down contains the following options$")
    public void workflowTypeDropDownContains(List<String> expectedResult) {
        workflowPage.clickCreteWorkflowTypeButton();
        List<String> dropDownOptionList = workflowPage.getDropDownOptionList();
        dropDownOptionList.remove(DROPDOWN_PLACEHOLDER);
        assertThat(dropDownOptionList)
                .as("Workflow Type drop down options are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Risk Scoring Range drop down contains all ranges sorted in Ascending order")
    public void riskScoringRangeDropDownContains() {
        SoftAssertions soft = new SoftAssertions();
        List<String> expectedResult =
                SIPublicApi.getRiskScoreEngineRanges().getData().stream()
                        .flatMap(range -> range.getRanges().stream())
                        .map(range -> format(RISK_RANGE_FORMAT, range.getName(), range.getMin(), range.getMax()))
                        .collect(Collectors.toUnmodifiableList());
        workflowPage.clickRiskScoringButton();
        List<String> actualResult = workflowPage.getDropDownOptionList();
        actualResult.remove(DROPDOWN_PLACEHOLDER);
        soft.assertThat(actualResult)
                .as("Risk Scoring Range drop down options are unexpected")
                .hasSameElementsAs(expectedResult);
        soft.assertThat(workflowPage.getDropDownOptionNumbersList(actualResult))
                .as("Risk Scoring options aren't sorted in Ascending order")
                .isSortedAccordingTo(getFloatComparator(ASC));
        workflowPage.clickOnDescription();
        soft.assertAll();
    }

    @Then("Workflow Group drop down contains all active workflow groups")
    public void workflowGroupDropDownContains() {
        final String MORE_THEN_ONE_SPACE = "\\s{2,}";
        List<String> expectedResult =
                getWorkflowGroupsList(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, DEFAULT_SORT_BY, DEFAULT_SORT).stream()
                        .filter(group -> group.getStatus().equals(ACTIVE.getStatus()))
                        .map(WorkflowGroupData::getGroupName)
                        .map(group -> group.replaceAll(MORE_THEN_ONE_SPACE, valueOf(StringUtil.SPACE)))
                        .collect(Collectors.toList());
        workflowPage.clickWorkflowGroupButton();
        List<String> actualResult = workflowPage.getDropDownOptionList();
        actualResult.remove(DROPDOWN_PLACEHOLDER);
        assertThat(actualResult)
                .as("Workflow Group drop down options are unexpected")
                .isEqualTo(expectedResult);
        workflowPage.clickOnDescription();
    }

    @Then("Workflow {string} input field is required and blank")
    public void requiredWorkflowNameInputFieldIsBlank(String fieldName) {
        workflowInputFieldIsBlank(fieldName);
        workflowInputIsRequired(fieldName, EMPTY);
    }

    @Then("^Workflow \"(.*)\" input field is (required|not required)$")
    public void workflowInputIsRequired(String fieldName, String state) {
        if (state.contains(NOT)) {
            assertThat(workflowPage.getWorkflowInputLabelText(fieldName))
                    .as("'%s' input field is required", fieldName)
                    .isNull();
        } else {
            assertThat(workflowPage.getWorkflowInputLabelText(fieldName))
                    .as("'%s' input field is not required", fieldName)
                    .isEqualTo(REQUIRED_INDICATOR);
        }
    }

    @Then("Workflow {string} input field is blank and disabled")
    public void workflowInputFieldIsBlankAndDisabled(String fieldName) {
        workflowInputFieldIsBlank(fieldName);
        workflowInputFieldIsDisabled(fieldName);
    }

    @Then("Workflow {string} input field is disabled")
    public void workflowInputFieldIsDisabled(String fieldName) {
        assertThat(workflowPage.isWorkflowFieldDisabled(fieldName))
                .as("'%s' input field is not disabled", fieldName)
                .isFalse();
    }

    @Then("Workflow {string} input field is blank")
    public void workflowInputFieldIsBlank(String fieldName) {
        assertThat(workflowPage.getInputValue(fieldName))
                .as("'%s' input field is not blank", fieldName)
                .isNull();
    }

    @Then("Workflow {string} input field contains value {string}")
    public void workflowInputFieldIsBlank(String fieldName, String expectedValue) {
        if (expectedValue.equals(WORKFLOW_NAME_CONTEXT)) {
            expectedValue = updatedWorkflowName;
        } else if (fieldName.equals(WORKFLOW_NAME) || expectedValue.contains(VALUE_TO_REPLACE)) {
            expectedValue = workflowName;
        }
        assertThat(workflowPage.getInputValue(fieldName))
                .as("'%s' input field doesn't contain expected value", fieldName)
                .isEqualTo(expectedValue);
    }

    @Then("Workflow {string} drop-down field is required and blank")
    public void workflowDropDownFieldIsRequiredAndBlank(String fieldName) {
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(workflowPage.getInputValue(fieldName))
                .as("'%s' input field is not blank", fieldName)
                .isNull();
        softAssertions.assertThat(workflowPage.getWorkflowInputLabelText(fieldName))
                .as("'%s' input field is not required", fieldName)
                .isEqualTo(REQUIRED_INDICATOR);
        softAssertions.assertAll();
    }

    @Then("Workflow Description text area is blank")
    public void workflowTextAreaIsBlank() {
        assertThat(workflowPage.getDescriptionValue())
                .as("Description is not blank")
                .isNull();
    }

    @Then("Error message {string} in red color is displayed near {string} field")
    public void errorMessageInRedColorIsDisplayedNearField(String message, String fieldName) {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(workflowPage.isInputInvalidAriaDisplayed(fieldName))
                .as("'%s' field doesn't display invalid aria", fieldName)
                .isTrue();
        softAssert.assertThat(workflowPage.getValidationMessageForField(fieldName))
                .as("'%s' field error message is unexpected", fieldName)
                .isEqualTo(message);
        softAssert.assertThat(workflowPage.getErrorMessageElementCSS(fieldName, COLOR))
                .as("'%s' error message is not red", fieldName)
                .isEqualTo(REACT_RED.getColorRgba());
        softAssert.assertAll();
    }

    @Then("Component on position {int} contains {string} activity assigned to {string} group")
    public void componentOnPositionContainsActivityOnPositionAssignedToGroup(int componentPosition,
            String activityReference, String expectedGroupIndex) {
        WorkflowActivityData activityData =
                (WorkflowActivityData) context.getScenarioContext().getContext(activityReference);
        String actualGroupIndex =
                workflowPage.getAssignedGroupIndex(componentPosition + 1, activityData.getActivityName());
        assertThat(actualGroupIndex)
                .as("Component on position %s doesn't contain %s activity assigned to %s group",
                    componentPosition, activityData.getActivityName(), expectedGroupIndex)
                .isEqualTo(expectedGroupIndex);
    }

    @Then("Activity {string} buttons are active")
    public void activityButtonsAreActive(String activityReference) {
        SoftAssertions softAssert = new SoftAssertions();
        WorkflowActivityData activityData =
                (WorkflowActivityData) context.getScenarioContext().getContext(activityReference);
        softAssert.assertThat(workflowPage.isEditButtonEnabled(activityData.getActivityName()))
                .as("Activity edit buttons is not active")
                .isTrue();
        softAssert.assertThat(workflowPage.isDeleteButtonEnabled(activityData.getActivityName()))
                .as("Activity delete buttons is not active")
                .isTrue();
        softAssert.assertAll();
    }

    @Then("^Workflow Management module is (displayed|hidden)$")
    public void workflowManagementModuleIsNotDisplayed(String status) {
        workflowPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        boolean shouldBeDisplayed = status.equals(DISPLAYED.toLowerCase());
        assertThat(workflowPage.isWorkFlowManagementModuleDisplayed())
                .as("Workflow management module is displayed")
                .isEqualTo(shouldBeDisplayed);
    }

    @Then("Workflow {string} is created")
    public void isWorkflowCreated(String workflowName) {
        assertThat(doesWorkflowExist(workflowName))
                .as("Workflow %s is not created", workflowName)
                .isTrue();
    }

    @Then("Workflow should be created")
    public void isWorkflowCreated() {
        assertThat(doesWorkflowExist(workflowName))
                .as("Workflow %s is not created", workflowName)
                .isTrue();
    }

}