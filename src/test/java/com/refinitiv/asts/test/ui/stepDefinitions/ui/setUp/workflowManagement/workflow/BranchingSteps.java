package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.workflowManagement.workflow;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow.BranchingPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

public class BranchingSteps extends BaseSteps {

    private final BranchingPage branchingPage;

    public BranchingSteps(ScenarioCtxtWrapper context) {
        super(context);
        branchingPage = new BranchingPage(driver);
    }

    @When("User clicks on {string} branching modal activity")
    public void clickOnBranchingModalActivity(String activityName) {
        branchingPage.clickActivity(activityName);
    }

    @When("User clicks Apply Branching modal 'Back' button")
    public void clickApplyBranchingModalButton() {
        branchingPage.clickCloseModalButton();
    }

    @When("User selects {string} for {string} drop-down")
    public void selectForDropDown(String value, String dropDownLabel) {
        branchingPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        branchingPage.selectDropDownValue(value, dropDownLabel);
    }

    @When("User clears {string} drop-down")
    public void clearDropDown(String dropDownLabel) {
        branchingPage.clearDropDownValue(dropDownLabel);
    }

    @Then("Branching modal is displayed")
    public void branchingModalIsDisplayed() {
        assertThat(branchingPage.getPageTitle())
                .as("Branching modal is not displayed")
                .isEqualTo("BRANCHING");
    }

    @Then("Apply Branching modal is displayed")
    public void applyBranchingModalIsDisplayed() {
        assertThat(branchingPage.isApplyBranchingModalDisplayed())
                .as("Apply Branching modal is not displayed")
                .isTrue();
    }

    @Then("Apply Branching modal is disappeared")
    public void applyBranchingModalIsDisappeared() {
        assertThat(branchingPage.isApplyBranchingModalDisappeared())
                .as("Apply Branching modal is not disappeared")
                .isTrue();
    }

    @Then("Branching modal contains {string} group with activities")
    public void branchingModalContainsGroupWithActivities(String groupName, List<String> expectedResult) {
        assertThat(branchingPage.getGroupActivitiesList(groupName))
                .as("Branching modal %s group doesn't contains activities", groupName)
                .isEqualTo(expectedResult);
    }

    @Then("Group {string} is shown first")
    public void groupIsShownFirst(String groupName) {
        assertThat(branchingPage.getFirstGroupName())
                .as("Group %s is not shown first", groupName)
                .isEqualTo(groupName);
    }

    @Then("Activity Name field is displayed with value {string}")
    public void activityNameFieldIsDisplayedWithValue(String expectedValue) {
        assertThat(branchingPage.getActivityNameValue())
                .as("Activity Name doesn't contain expected value")
                .isEqualTo(expectedValue);
    }

    @Then("Assessment label {string} is displayed with values")
    public void assessmentLabelIsDisplayedWithValues(String assessmentLabel, DataTable dataTable) {
        List<String> expectedResult = dataTable.asList();
        branchingPage.clickDropDown(assessmentLabel);
        List<String> actualResult = branchingPage.getDropDownList();
        assertThat(actualResult)
                .as("Assessment label '%s' is not displayed with expected values", assessmentLabel)
                .isEqualTo(expectedResult);
        branchingPage.clickActivityName();
    }

    @Then("Assessment drop-down {string} contains value {string}")
    public void assessmentDropDownContainsValue(String assessmentLabel, String expectedValue) {
        assertThat(branchingPage.getDropDownValue(assessmentLabel))
                .as("Assessment drop-down %s doesn't contain value", assessmentLabel)
                .isEqualTo(expectedValue.isEmpty() ? null : expectedValue);
    }

}