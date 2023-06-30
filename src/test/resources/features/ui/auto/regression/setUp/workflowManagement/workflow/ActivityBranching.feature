@ui @core_regression @workflow_management
Feature: Add/Edit Activity Branching

  As a Supplier Integrity Administrator Creating an Onboarding Workflow
  I want to be able to design the sequence of activities for onboarding
  So that only the relevant activities will be done based on the results of the completed activities

  Background:
    Given User logs into RDDC as "Admin"
    And User creates "Activity Type" "without assessment" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
    And Workflow Table is displayed
    And User clicks Add Workflow button
    And Workflow Create Workflow page is displayed
    And User fills in workflow details data "Onboarding Workflow"
    When User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "AUTO_TEST_0"
    And User clicks Check button
    And User adds new Activity "Auto Activity" with "Simple Custom Activity" data
    And User adds 1 components with "Assessment Activity" activity
    And User clicks workflow button "GROUPING"
    Then Workflow Grouping page is displayed
    When User clicks "Add" grouping button
    And User ticks checkbox for activity on position 1
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks workflow button "BRANCHING"
    Then Branching modal is displayed

  @C35927294
  Scenario: C35927294: Workflow - Add Activity Branching
    Given Branching modal contains "Group 1" group with activities
      | Assessment Activity,AUTO_TEST_1 |
    And Branching modal contains "Group 2" group with activities
      | Auto Activity,AUTO_TEST_0 |
    And Group "Group 0" is shown first
    When User clicks on "Auto Activity" branching modal activity
    Then Message is displayed on confirmation window
      | No available assessment |
    When User clicks Ok button on confirmation window
    Then Confirmation window is disappeared
    When User clicks on "Assessment Activity" branching modal activity
    Then Apply Branching modal is displayed
    And Activity Name field is displayed with value "Assessment Activity"
    And Assessment label "Deeper Dive" is displayed with values
      | Auto Activity |
    And Assessment label "Resolved" is displayed with values
      | Auto Activity |
    And Assessment label "Issue Identified" is displayed with values
      | Auto Activity |
    And Workflow button "Apply" should be displayed
    When User clicks workflow button "Cancel"
    Then Apply Branching modal is disappeared
    When User clicks on "Assessment Activity" branching modal activity
    Then Apply Branching modal is displayed
    When User selects "Auto Activity" for "Deeper Dive" drop-down
    And User clicks workflow button "Apply"
    Then Apply Branching modal is disappeared
    When User clicks on "Assessment Activity" branching modal activity
    Then Assessment drop-down "Deeper Dive" contains value "Auto Activity"

  @C35928225
  Scenario: C35928225: Workflow - Edit Activity Branching
    When User clicks on "Assessment Activity" branching modal activity
    Then Apply Branching modal is displayed
    When User selects "Auto Activity" for "Deeper Dive" drop-down
    And User clicks workflow button "Apply"
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User clicks 'Edit' button for created Workflow
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks workflow button "BRANCHING"
    Then Branching modal is displayed
    When User clicks on "Assessment Activity" branching modal activity
    Then Apply Branching modal is displayed
    When User selects "Auto Activity" for "Resolved" drop-down
    And User clears "Deeper Dive" drop-down
    And User clicks workflow button "Apply"
    And User clicks workflow button "Done"
    And User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Confirmation window is disappeared
    And Workflow Table is displayed
    When User clicks on created Workflow
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks workflow button "BRANCHING"
    Then Branching modal is displayed
    When User clicks on "Assessment Activity" branching modal activity
    Then Apply Branching modal is displayed
    And Assessment drop-down "Deeper Dive" contains value ""
    And Assessment drop-down "Resolved" contains value "Auto Activity"
