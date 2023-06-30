package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.workflowManagement.workflow;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;

import com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow.GroupingPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.TestConstants.DISABLED;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static org.assertj.core.api.Assertions.assertThat;

public class GroupingSteps extends BaseSteps {

    private final GroupingPage groupingPage;

    public GroupingSteps(ScenarioCtxtWrapper context) {
        super(context);
        groupingPage = new GroupingPage(driver);
    }

    @When("^User clicks \"(Apply|Add)\" grouping button$")
    public void clickApplyGroupingButton(String buttonType) {
        switch (buttonType) {
            case ADD:
                groupingPage.clickAddButton();
                break;
            case APPLY:
                groupingPage.clickApplyButton();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
    }

    @When("User ticks checkbox for activity on position {int}")
    public void tickCheckboxForActivityOnPosition(int activityPosition) {
        groupingPage.tickActivityCheckbox(activityPosition);
    }

    @When("User selects {string} transfer to option")
    public void selectTransferToOption(String groupName) {
        groupingPage.clickTransferToDropDown();
        groupingPage.selectGroupOption(groupName);
    }

    @When("User clicks delete icon for group {string}")
    public void clickDeleteIconForGroup(String groupName) {
        groupingPage.clickDeleteButton(groupName);
    }

    @Then("Workflow Grouping page is displayed")
    public void workflowGroupingPageIsDisplayed() {
        assertThat(groupingPage.getPageTitle())
                .as("Workflow Grouping page Groups section is not displayed")
                .contains("GROUPING");
    }

    @Then("Workflow Grouping page Groups section is displayed")
    public void workflowGroupingPageGroupsSectionIsDisplayed() {
        assertThat(groupingPage.isGroupsSectionDisplayed())
                .as("Workflow Grouping page Groups section is not displayed")
                .isTrue();
    }

    @Then("Workflow Grouping page Activities section is displayed")
    public void workflowGroupingPageActivitiesSectionIsDisplayed() {
        assertThat(groupingPage.isActivitiesSectionDisplayed())
                .as("Workflow Grouping page Activities section is not displayed")
                .isTrue();
    }

    @Then("^Activity group with name \"((.*))\" is (displayed|not displayed)$")
    public void activityGroupWithNameIsDisplayed(String groupName, String status) {
        boolean actualResult = groupingPage.isGroupWithNameDisplayed(groupName);
        if (status.contains(NOT_DISPLAYED.toLowerCase())) {
            assertThat(actualResult)
                    .as("Activity group with name '%s' is displayed", groupName)
                    .isFalse();
        } else {
            assertThat(actualResult)
                    .as("Activity group with name '%s' is not displayed", groupName)
                    .isTrue();
        }
    }

    @Then("^Grouping button \"(Apply|Transfer to|Add)\" is (enabled|disabled)$")
    public void validateGroupingButtonState(String buttonType, String state) {
        boolean isButtonEnabled;
        switch (buttonType) {
            case TRANSFER_TO:
                isButtonEnabled = groupingPage.isTransferButtonEnabled();
                break;
            case APPLY:
                isButtonEnabled = groupingPage.isApplyButtonEnabled();
                break;
            case ADD:
                isButtonEnabled = groupingPage.isAddButtonEnabled();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        if (state.equals(DISABLED)) {
            assertThat(isButtonEnabled)
                    .as("Grouping button '%s' is not disabled", buttonType)
                    .isFalse();
        } else {
            assertThat(isButtonEnabled)
                    .as("Grouping button '%s' is not enabled", buttonType)
                    .isTrue();
        }
    }

    @Then("Activities section contains all the existing activities in the workflow")
    public void activitiesSectionContainsAllTheExistingActivitiesInTheWorkflow(List<String> expectedResult) {
        assertThat(groupingPage.getActivitiesList())
                .as("Activities section doesn't contain all the existing activities in the workflow")
                .isEqualTo(expectedResult);
    }

    @Then("Each activity is assigned to {string} group")
    public void eachActivityIsAssignedTo(String group) {
        boolean isAssignedToGroup =
                groupingPage.getAssignedGroupsList().stream().allMatch(groupIndex -> groupIndex.equals(group));
        assertThat(isAssignedToGroup)
                .as("Not each activity is assigned to %s group", group)
                .isTrue();
    }

    @Then("Each activity has a checkbox")
    public void eachActivityHasACheckbox() {
        assertThat(groupingPage.haveActivitiesCheckboxes())
                .as("Not each activity has a checkbox")
                .isTrue();
    }

    @Then("Delete button for group with name {string} is displayed")
    public void deleteButtonForGroupWithNameIsDisplayed(String groupName) {
        assertThat(groupingPage.isDeleteGroupButtonDisplayed(groupName))
                .as("Delete button for group with name '%s' is not displayed", groupName)
                .isTrue();
    }

    @Then("Transfer to drop-down list contains values")
    public void transferToDropDownListContainsValues(List<String> expectedResult) {
        groupingPage.clickTransferToDropDown();
        assertThat(groupingPage.getTransferToDropDownValues())
                .as("Transfer to drop-down list doesn't contain expected values")
                .isEqualTo(expectedResult);
    }

    @Then("Activity on position {int} is assigned to {string} group")
    public void activityOnPositionIsAssignedToGroup(int activityPosition, String groupIndex) {
        assertThat(groupingPage.getAssignedGroupsList().get(activityPosition))
                .as("Activity on position %s is not assigned to %s group", activityPosition, groupIndex)
                .isEqualTo(groupIndex);
    }

}