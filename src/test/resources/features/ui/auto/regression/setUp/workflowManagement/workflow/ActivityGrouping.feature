@ui @workflow_management
Feature: Grouping Activities

  As a Supplier Integrity Administrator Creating an Onboarding Workflow
  I want to be able to group the activities of a workflow
  So that So I can efficiently plan the flow in which the activities should be accomplished

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User adds 2 components with "Assign Questionnaire" activity
    Then Component Name "AUTO_TEST_2" is displayed

  @C35896166
  @core_regression
  Scenario: C35896166: [Workflow Management] Workflows - Grouping Activities
    When User clicks workflow button "GROUPING"
    Then Workflow Grouping page is displayed
    And Workflow Grouping page Groups section is displayed
    And Workflow Grouping page Activities section is displayed
    And Activity group with name "Group 0" is displayed
    And Grouping button "Add" is enabled
    And Activities section contains all the existing activities in the workflow
      | Auto Activity |
      | Auto Activity |
    And Each activity is assigned to "0" group
    And Each activity has a checkbox
    And Grouping button "Apply" is disabled
    And Workflow button "RESET" should be enabled
    And Workflow button "Cancel" should be enabled
    And Workflow button "Done" should be enabled
    When User clicks "Add" grouping button
    Then Activity group with name "Group 1" is displayed
    And Delete button for group with name "Group 1" is displayed
    And Grouping button "Add" is disabled
    When User ticks checkbox for activity on position 0
    Then Grouping button "Apply" is enabled
    And Grouping button "Transfer to" is enabled
    And Transfer to drop-down list contains values
      | Group 0 |
      | Group 1 |
    When User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    Then Alert Icon is displayed with text
      | Success! Activity(s) have been transferred |
    And Activity on position 0 is assigned to "1" group
    When User clicks workflow button "Done"
    Then Add Wizard page is displayed
    And Component on position 0 contains "Assign Questionnaire" activity assigned to "1" group
    And Component on position 1 contains "Assign Questionnaire" activity assigned to "0" group
    When User clicks workflow button "GROUPING"
    Then Activity on position 0 is assigned to "1" group
    And Activity on position 1 is assigned to "0" group

  @C35900242
  @core_regression
  Scenario: C35900242: [Workflow Management] Workflows - Reset Grouping
    When User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks workflow button "GROUPING"
    And User ticks checkbox for activity on position 1
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    Then Alert Icon is displayed with text
      | Success! Activity(s) have been transferred |
    When User clicks workflow button "RESET"
    Then Message is displayed on confirmation window
      | Are you sure you want to reset the changes? This change cannot be undone |
    And Confirmation window button with text "Reset" is displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Activity on position 0 is assigned to "1" group
    And Activity on position 1 is assigned to "1" group
    When User clicks workflow button "RESET"
    Then Message is displayed on confirmation window
      | Are you sure you want to reset the changes? This change cannot be undone |
    And Confirmation window button with text "Reset" is displayed
    When User clicks Reset button on confirmation window
    Then Confirmation window is disappeared
    And Activity on position 0 is assigned to "1" group
    And Activity on position 1 is assigned to "0" group

  @C35899561
  @full_regression
  Scenario: C35899561: [Workflow Management] Workflows - Validation for a group in use and mid-group activities
    When User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 1
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks delete icon for group "Group 1"
    Then Message is displayed on confirmation window
      | This group is currently in use and you will not be able to remove it |
    And Confirmation window button with text "Ok" is displayed
    When User clicks Ok button on confirmation window
    Then Confirmation window is disappeared
    And Workflow Grouping page is displayed
    When User clicks "Add" grouping button
    Then Activity group with name "Group 2" is displayed
    And Delete button for group with name "Group 2" is displayed
    And Grouping button "Add" is disabled
    When User ticks checkbox for activity on position 1
    Then Grouping button "Apply" is enabled
    And Grouping button "Transfer to" is enabled
    And Transfer to drop-down list contains values
      | Group 0 |
      | Group 1 |
      | Group 2 |
    When User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    Then Alert Icon is displayed with text
      | Success! Activity(s) have been transferred |
    When User clicks workflow button "Done"
    Then Message is displayed on confirmation window
      | Unable to finish grouping with no existing activity on mid-group |
    And Confirmation window button with text "Ok" is displayed
    When User clicks Ok button on confirmation window
    Then Confirmation window is disappeared
    And Workflow Grouping page is displayed
    And Activity group with name "Group 0" is displayed
    And Activity group with name "Group 1" is displayed
    And Activity group with name "Group 2" is displayed

  @C35914553
  @full_regression
  Scenario: C35914553: [Workflow Management] Workflows - Remove a Group in a Grouping Page
    When User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 1
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    Then Activity group with name "Group 2" is displayed
    When User clicks delete icon for group "Group 2"
    Then Activity group with name "Group 2" is not displayed
    When User clicks "Add" grouping button
    Then Activity group with name "Group 2" is displayed
    And Delete button for group with name "Group 2" is displayed
    When User clicks workflow button "Done"
    Then Add Wizard page is displayed
    When User clicks workflow button "GROUPING"
    Then Workflow Grouping page is displayed
    And Activity group with name "Group 2" is not displayed
