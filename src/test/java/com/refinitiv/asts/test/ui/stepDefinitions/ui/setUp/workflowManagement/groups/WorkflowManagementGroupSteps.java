package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.workflowManagement.groups;

import com.google.common.collect.ImmutableMap;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.core.framework.drivers.DriverFactory;
import com.refinitiv.asts.test.ui.api.WorkflowApi;
import com.refinitiv.asts.test.ui.constants.PageElementNames;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.WorkflowManagementGroupColumns;
import com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.groups.WorkflowManagementGroupsPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowGroupData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.openqa.selenium.WebDriver;
import org.testng.SkipException;

import java.util.List;
import java.util.Map;

import static com.refinitiv.asts.test.ui.api.WorkflowApi.getWorkflowGroupsList;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.postNewWorkflowGroup;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.COLOR;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.WORKFLOW_GROUP_NAME_CONTEXT;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.WORKFLOW_MANAGEMENT_GROUP_CONTEXT;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.WORKFLOW_GROUPS;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_RED;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getTodayDate;
import static java.util.Objects.nonNull;
import static java.util.UUID.randomUUID;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.*;

public class WorkflowManagementGroupSteps extends BaseSteps {

    private static final ImmutableMap<String, String> SORT_FIELD = new ImmutableMap.Builder<String, String>()
            .put("Workflow Group Name", "name")
            .put("Status", "status")
            .put("Date Created", "createTime")
            .put("Last Updated", "updateTime")
            .build();
    private final WebDriver driver;
    private final ScenarioCtxtWrapper context;
    private final WorkflowManagementGroupsPage groupsPage;
    private String groupName;

    public WorkflowManagementGroupSteps(ScenarioCtxtWrapper context) {
        this.driver = DriverFactory.getDriver();
        this.context = context;
        this.groupsPage = new WorkflowManagementGroupsPage(driver, translator);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public WorkflowGroupData providerEntry(Map<String, String> entry) {
        return new WorkflowGroupData(
                entry.get(WorkflowManagementGroupColumns.WORKFLOW_GROUP_NAME.getDefaultName()),
                entry.get(WorkflowManagementGroupColumns.STATUS.getDefaultName()),
                entry.get(WorkflowManagementGroupColumns.DATE_CREATED.getDefaultName()),
                entry.get(WorkflowManagementGroupColumns.LAST_UPDATED.getDefaultName()));
    }

    @When("User navigates to 'Workflow Management' block 'Groups' section")
    public void openWorkflowManagementGroups() {
        groupsPage.navigateToGroupsPage();
    }

    @When("User creates new Workflow Group with {string} data")
    public void createNewGroup(String group) {
        groupsPage.navigateToGroupsPage();
        WorkflowGroupData workflowGroupsData =
                new JsonUiDataTransfer<WorkflowGroupData>(WORKFLOW_GROUPS)
                        .getTestData().get(group)
                        .getDataToEnter();
        this.context.getScenarioContext().setContext(WORKFLOW_MANAGEMENT_GROUP_CONTEXT, workflowGroupsData);
        WorkflowManagementGroupsPage groupsPage = new WorkflowManagementGroupsPage(driver);
        groupsPage.clickButtonAddWorkflowGroup();
        groupsPage.enterGroupsName(workflowGroupsData.getGroupName());
        groupsPage.clickSave();
    }

    @When("User clicks Workflow Management Groups submenu in Set Up menu")
    public void clickWorkflowManagementSubmenuGroups() {
        groupsPage.clickWorkflowManagementSubmenuGroups();
    }

    @When("User clicks Add Workflow Group button")
    public void clickAddWorkflowGroupBtn() {
        groupsPage.clickButtonAddWorkflowGroup();
    }

    @When("User populates Workflow Group Name with {string}")
    public void fillInWorkflowGroupName(String name) {
        groupName = name;
        groupsPage.enterGroupsName(groupName);
    }

    @When("User populates Workflow Group Name")
    public void fillInWorkflowGroupName() {
        fillInWorkflowGroupName(AUTO_TEST_NAME_PREFIX + randomUUID());
        this.context.getScenarioContext().setContext(WORKFLOW_GROUP_NAME_CONTEXT, groupName);
    }

    @When("User updates Workflow Group Name")
    public void updatedWorkflowGroupName() {
        fillInWorkflowGroupName(AUTO_TEST_NAME_PREFIX + randomUUID());
    }

    @When("^User clicks \"(Save|Cancel|Back|Edit)\" button for Workflow Group$")
    public void clickWorkflowBtn(String buttonType) {
        switch (buttonType) {
            case SAVE:
                groupsPage.clickSave();
                break;
            case CANCEL:
                groupsPage.clickCancel();
                break;
            case BACK:
                groupsPage.clickBack();
                break;
            case PageElementNames.EDIT:
                groupsPage.clickEdit();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
    }

    @When("User clicks first Workflow Group table row")
    public void clickFirstWorkflowGroupTableRow() {
        groupName = groupsPage.getFirstRowText();
        groupsPage.clickFirstRow();
    }

    @When("User creates {string} workflow group with random name via API")
    public void createWorkflowGroupWithRandomNameViaAPI(String groupStatus) {
        String groupName = AUTO_TEST_NAME_PREFIX + randomUUID();
        postNewWorkflowGroup(groupName, groupStatus.equals(ACTIVE.getStatus()));
        this.context.getScenarioContext().setContext(WORKFLOW_GROUP_NAME_CONTEXT, groupName);
    }

    @When("User creates workflow group {string} via API without context")
    public void createWorkflowGroupWithViaAPI(String groupReference) {
        WorkflowGroupData workflowGroupsData =
                new JsonUiDataTransfer<WorkflowGroupData>(WORKFLOW_GROUPS)
                        .getTestData().get(groupReference)
                        .getDataToEnter();
        postNewWorkflowGroup(workflowGroupsData.getGroupName(),
                             workflowGroupsData.getStatus().equals(ACTIVE.getStatus()));
    }

    @When("Skip Workflow Group {string} creation if already exists")
    public void skipWorkflowGroupCreationIfExists(String groupReference) {
        if (nonNull(getWorkflowGroupsList(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, DEFAULT_SORT_BY, DEFAULT_SORT).stream()
                            .filter(group -> group.getGroupName().equals(groupReference)).findFirst().orElse(null))) {
            throw new SkipException("Workflow Group \"" + groupReference + "\" already exists!");
        }
    }

    @When("User clicks the Edit icon for created workflow group")
    public void clickTheEditIconForCreatedWorkflowGroup() {
        groupsPage.clickEditWorkflowGroup(groupName);
    }

    @When("User clicks the Delete icon for created workflow group")
    public void clickTheDeleteIconForCreatedWorkflowGroup() {
        groupName = (String) context.getScenarioContext().getContext(WORKFLOW_GROUP_NAME_CONTEXT);
        groupsPage.clickDeleteWorkflowGroup(groupName);
    }

    @When("User opens created workflow group")
    public void openCreatedWorkflowGroup() {
        groupsPage.clickWorkflowGroup(groupName);
    }

    @When("User deletes all Workflow Groups with name prefix generated by auto tests via API")
    public void deletesAllWorkflowGroupsWithNamePrefixGeneratedByAutoTestsViaAPI() {
        getWorkflowGroupsList(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, DEFAULT_SORT_BY, DEFAULT_SORT)
                .forEach(workflowGroup -> {
                             if (workflowGroup.getGroupName().startsWith(AUTO_TEST_NAME_PREFIX)) {
                                 WorkflowApi.deleteWorkflowGroup(workflowGroup.getWorkflowGroupId());
                             }
                         }
                );
    }

    @Then("^Workflow Group \"((.*))\" page (is|is not) displayed$")
    public void isPageWithNameDisplayed(String name, String state) {
        name = groupsPage.getFromDictionaryIfExists(name);
        if (name.equals(WORKFLOW_GROUP_NAME_CONTEXT)) {
            name = groupName;
        }
        if (state.contains(NOT)) {
            assertThat(groupsPage.isPageWithNameDisappeared(name))
                    .as("Workflow Group page with name %s is not disappeared", name)
                    .isTrue();
        } else {
            assertThat(groupsPage.isPageWithNameDisplayed(name))
                    .as("Workflow Group page with name %s is not displayed", name)
                    .isTrue();
        }
    }

    @Then("Workflow Group Active checkbox is ticked")
    public void isWorkFlowGroupActiveCheckboxTicked() {
        assertThat(groupsPage.isActiveCheckboxChecked()).as("Active checkbox is not ticked").isTrue();
    }

    @Then("^Workflow Group (is|is not) displayed with values$")
    public void workflowGroupIsDisplayedWithValues(String condition, WorkflowGroupData expectedResult) {
        groupsPage.waitWhilePreloadProgressbarIsDisappeared();
        if (expectedResult.getStatus() != null) {
            expectedResult.setStatus(groupsPage.getFromDictionaryIfExists(expectedResult.getStatus()));
        }
        if (expectedResult.getLastUpdate() != null) {
            expectedResult.setLastUpdate(getTodayDate(expectedResult.getLastUpdate()));
        }
        if (expectedResult.getDateCreated() != null) {
            expectedResult.setDateCreated(getTodayDate(expectedResult.getDateCreated()));
        }
        if (expectedResult.getGroupName().contains(VALUE_TO_REPLACE)) {
            groupName = (String) context.getScenarioContext().getContext(WORKFLOW_GROUP_NAME_CONTEXT);
            expectedResult.setGroupName(groupName);
        }
        if (condition.contains(NO.toLowerCase())) {
            assertThat(groupsPage.getGroupsList()).as("Workflow Group table contains group")
                    .doesNotContain(expectedResult);
        } else {
            WorkflowGroupData actualResult = groupsPage.getAllFieldsValues(groupName);
            assertThat(actualResult).as("Workflow Group is not displayed with expected values")
                    .isEqualTo(expectedResult);
        }
    }

    @Then("^Workflow Group page \"(Cancel|Save|Close|Edit)\" button is displayed$")
    public void workflowGroupPageButtonIsDisplayed(String buttonType) {
        boolean isElementDisplayed;
        switch (buttonType) {
            case SAVE:
                isElementDisplayed = groupsPage.isSaveButtonDisplayed();
                break;
            case CANCEL:
                isElementDisplayed = groupsPage.isCancelButtonDisplayed();
                break;
            case CLOSE:
                isElementDisplayed = groupsPage.isCloseButtonDisplayed();
                break;
            case EDIT:
                isElementDisplayed = groupsPage.isEditButtonDisplayed();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        assertThat(isElementDisplayed).as("Workflow Group %s button is not displayed", buttonType)
                .isTrue();
    }

    @Then("Workflow Group Name field is required")
    public void workflowGroupNameFieldIsRequired() {
        assertTrue("Workflow Group Name field is not marked as required",
                   groupsPage.getGroupNameFieldLabelText().contains(REQUIRED_INDICATOR));
    }

    @Then("Workflow Group Name field is blank")
    public void workflowGroupNameFieldIsBlank() {
        assertTrue("Workflow Group Name field is not blank", groupsPage.getGroupNameFieldText().isEmpty());
    }

    @Then("Workflow Group Name field is populated")
    public void workflowGroupNameFieldIsPopulated() {
        assertThat(groupsPage.getGroupNameFieldText()).
                as("Workflow Group Name field is not expected").isEqualTo(groupName);
    }

    @Then("Error message {string} in red color is displayed near Workflow Group Name field")
    public void errorMessageInRedColorIsDisplayedNearWorkflowGroupNameField(String errorMessage) {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(groupsPage.isFieldInvalidAriaDisplayed())
                .as("Workflow Group Name field doesn't display invalid aria").isTrue();
        softAssert.assertThat(groupsPage.getErrorMessageText())
                .as("Workflow Group Name error message is not displayed").isEqualTo(errorMessage);
        softAssert.assertThat(groupsPage.getErrorMessageElementCSS(COLOR))
                .as("Workflow Group Name error message is not red").contains(REACT_RED.getColorRgba());
        softAssert.assertAll();
    }

    @Then("Workflow Management Group table is displayed with columns")
    public void workflowGroupTableIsDisplayedWithColumns(DataTable dataTable) {
        assertThat(groupsPage.getColumnNames()).as("Workflow Group columns are unexpected")
                .isEqualTo(dataTable.asList());
    }

    @Then("Workflow Group table displays groups sorted by {string} in {string} order")
    public void workflowGroupTableDisplaysGroupsSortedByInOrder(String sortedBy, String sortOrder) {
        groupsPage.waitWhilePreloadProgressbarIsDisappeared();
        List<WorkflowGroupData> expectedGroupsList =
                getWorkflowGroupsList(DEFAULT_ITEMS_PER_PAGE, DEFAULT_PAGE, sortOrder, SORT_FIELD.get(sortedBy));
        List<WorkflowGroupData> actualGroupsList = groupsPage.getGroupsList();
        assertThat(actualGroupsList).usingRecursiveFieldByFieldElementComparatorIgnoringFields("workflowGroupId")
                .as("Workflow Group table displays groups is not sorted").isEqualTo(expectedGroupsList);
    }

    @Then("^Workflow Group table (contains|does not contain) group$")
    public void workflowGroupTableContainsGroup(String condition, WorkflowGroupData expectedGroup) {
        if (condition.contains(NO.toLowerCase())) {
            assertThat(groupsPage.getAllGroupsList()).as("Workflow Group table contains group")
                    .doesNotContain(expectedGroup);
        } else {
            assertThat(groupsPage.getAllGroupsList()).as("Workflow Group table doesn't contain group")
                    .contains(expectedGroup);
        }
    }

    @Then("Workflow Group Active checkbox is not editable")
    public void workflowGroupActiveCheckboxIsNotEditable() {
        assertThat(groupsPage.isActiveCheckboxEnabled())
                .as("Workflow Group Active checkbox is editable").isFalse();
    }

    @Then("Workflow Group Name input field is not displayed")
    public void workflowGroupNameInputFieldIsNotDisplayed() {
        assertThat(groupsPage.isWorkflowGroupNameInputDisplayed())
                .as("Workflow Group Name input field is displayed").isFalse();
    }

    @Then("Edit icon is displayed in each row of the Workflow Group table")
    public void editIconIsDisplayedInEachRowOfTheWorkflowGroupTable() {
        assertThat(groupsPage.areEditButtonsDisplayedForEachRow())
                .as("Not all edit buttons are displayed").isTrue();
    }

    @Then("Delete icon is displayed in each row of the Workflow Group table")
    public void deleteIconIsDisplayedInEachRowOfTheWorkflowGroupTable() {
        assertThat(groupsPage.areDeleteButtonsDisplayedForEachRow())
                .as("Not all edit buttons are displayed").isTrue();
    }

}
