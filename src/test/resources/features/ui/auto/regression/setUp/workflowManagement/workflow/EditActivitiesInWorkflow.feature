@ui @full_regression @workflow_management
Feature: Editing Activities in a Workflow

  As a Supplier Integrity Administrator
  I want to be able to edit activities in Workflows
  So that I can make the necessary changes to the activities if needed

  Background:
    Given User logs into RDDC as "Admin"
    And User navigates to 'Workflow Management' block 'Workflow' section
    And Workflow Table is displayed

  @C35859255
  Scenario: C35859255: Workflow - Edit Activity from Component Screen. Assignee is changed from a user to a group
    When User clicks Add Workflow button
    And Workflow Create Workflow page is displayed
    And User creates new Workflow "Onboarding Workflow" with Activity "Assign Questionnaire"
    And User clicks 'Edit' button for created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then Activity "Edit Activity" tab is displayed
    And Edit Activity tab is displayed with expected required fields
    And Workflow button "Cancel" should be enabled
    And Workflow button "Done" should be enabled
    And Edit Activity "Assign Questionnaire" Detail page is shown with expected details
    And Edit Activity Status field is disabled
    And Risk Area drop-down contains expected Risk Areas
    And Activity Type drop-down list contains all the Activity types that are in the system
    When User selects "User Group" Assignee type
    Then Edit Activity "Edit Assign Questionnaire With Group Assignee" Assignees field is empty
    And Assignee(s) drop-down contains all active user groups
    When User fills in Activity "Edit Assign Questionnaire With Group Assignee" details
    And User clicks workflow button "Cancel"
    Then Add Wizard page is displayed
    When User clicks "View" icon for Activity "Auto Activity"
    Then Activity "Assign Questionnaire" Detail page is shown with expected details
    When User clicks workflow button "Cancel"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then Activity "Edit Activity" tab is displayed
    When User selects "User Group" Assignee type
    And User fills in Activity "Edit Assign Questionnaire With Group Assignee" details
    And User clicks workflow button "Done"
    Then Add Wizard page is displayed
    When User clicks "View" icon for Activity "Auto Activity Edit"
    Then Activity "Edit Assign Questionnaire With Group Assignee" Detail page is shown with expected details

  @C35881900
  Scenario: C35881900: Workflow - Edit Activity from Component/Activity Details Screen. Assignee is changed from a user to a group - Done
    When User clicks Add Workflow button
    And Workflow Create Workflow page is displayed
    And User creates new Workflow "Onboarding Workflow" with Activity "Assign Questionnaire"
    And User clicks 'Edit' button for created Workflow
    And User clicks workflow button "Next"
    And User clicks "View" icon for Activity "Auto Activity"
    Then Activity button 'Edit' should be enabled
    And Activity "Assign Questionnaire" Detail page is shown with expected details
    When User clicks 'Edit' button on view Activity screen
    Then Activity "Edit Activity" tab is displayed
    And Edit Activity tab is displayed with expected required fields
    And Workflow button "Cancel" should be enabled
    And Workflow button "Done" should be enabled
    And Edit Activity "Assign Questionnaire" Detail page is shown with expected details
    And Edit Activity Status field is disabled
    And Risk Area drop-down contains expected Risk Areas
    And Activity Type drop-down list contains all the Activity types that are in the system
    When User selects "User Group" Assignee type
    Then Edit Activity "Edit Assign Questionnaire With Group Assignee" Assignees field is empty
    And Assignee(s) drop-down contains all active user groups
    When User fills in Activity "Edit Assign Questionnaire With Group Assignee" details
    And User clicks workflow button "Cancel"
    Then Add Wizard page is displayed
    When User clicks "View" icon for Activity "Auto Activity"
    Then Activity "Assign Questionnaire" Detail page is shown with expected details
    When User clicks workflow button "Cancel"
    And User clicks "View" icon for Activity "Auto Activity"
    Then Activity button 'Edit' should be enabled
    When User clicks 'Edit' button on view Activity screen
    Then Activity "Edit Activity" tab is displayed
    When User selects "User Group" Assignee type
    And User fills in Activity "Edit Assign Questionnaire With Group Assignee" details
    And User clicks workflow button "Done"
    Then Add Wizard page is displayed
    When User clicks "View" icon for Activity "Auto Activity Edit"
    Then Activity "Edit Assign Questionnaire With Group Assignee" Detail page is shown with expected details

  @C35861757
  Scenario: C35861757: Workflow - Edit Activity from Component Screen. Assignee is changed from a group to a user
    When User clicks Add Workflow button
    And Workflow Create Workflow page is displayed
    And User creates new Workflow "Onboarding Workflow" with Activity "Assign Questionnaire With Group Assignee"
    And User clicks 'Edit' button for created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then Activity "Edit Activity" tab is displayed
    And Edit Activity tab is displayed with expected required fields
    And Workflow button "Cancel" should be enabled
    And Workflow button "Done" should be enabled
    And Edit Activity "Assign Questionnaire With Group Assignee" Detail page is shown with expected details
    And Edit Activity Status field is disabled
    And Risk Area drop-down contains expected Risk Areas
    And Activity Type drop-down list contains all the Activity types that are in the system
    When User selects "User" Assignee type
    Then Edit Activity "User" Assignees field is empty
    And Assignee's drop-down contains only active users
    When User fills in Activity "Edit Assign Questionnaire" details
    And User clicks workflow button "Cancel"
    Then Add Wizard page is displayed
    When User clicks "View" icon for Activity "Auto Activity"
    Then Activity "Assign Questionnaire With Group Assignee" Detail page is shown with expected details
    When User clicks workflow button "Cancel"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then Activity "Edit Activity" tab is displayed
    When User selects "User" Assignee type
    And User fills in Activity "Edit Assign Questionnaire" details
    And User clicks workflow button "Done"
    Then Add Wizard page is displayed
    When User clicks "View" icon for Activity "Auto Activity Edit"
    Then Activity "Edit Assign Questionnaire" Detail page is shown with expected details

  @C35881927
  Scenario: C35881927: Workflow - Edit Activity from Activity Details Screen.  Assignee is changed from a group to a user
    When User clicks Add Workflow button
    And Workflow Create Workflow page is displayed
    And User creates new Workflow "Onboarding Workflow" with Activity "Assign Questionnaire With Group Assignee"
    And User clicks 'Edit' button for created Workflow
    And User clicks workflow button "Next"
    And User clicks "View" icon for Activity "Auto Activity"
    Then Activity button 'Edit' should be enabled
    And Activity "Assign Questionnaire With Group Assignee" Detail page is shown with expected details
    When User clicks 'Edit' button on view Activity screen
    Then Activity "Edit Activity" tab is displayed
    And Edit Activity tab is displayed with expected required fields
    And Workflow button "Cancel" should be enabled
    And Workflow button "Done" should be enabled
    And Edit Activity "Assign Questionnaire With Group Assignee" Detail page is shown with expected details
    And Edit Activity Status field is disabled
    And Risk Area drop-down contains expected Risk Areas
    And Activity Type drop-down list contains all the Activity types that are in the system
    When User selects "User" Assignee type
    Then Edit Activity "User" Assignees field is empty
    And Assignee's drop-down contains only active users
    When User fills in Activity "Edit Assign Questionnaire" details
    And User clicks workflow button "Cancel"
    Then Add Wizard page is displayed
    When User clicks "View" icon for Activity "Auto Activity"
    Then Activity "Assign Questionnaire With Group Assignee" Detail page is shown with expected details
    When User clicks workflow button "Cancel"
    And User clicks "View" icon for Activity "Auto Activity"
    And User clicks 'Edit' button on view Activity screen
    Then Activity "Edit Activity" tab is displayed
    When User selects "User" Assignee type
    And User fills in Activity "Edit Assign Questionnaire" details
    And User clicks workflow button "Done"
    Then Add Wizard page is displayed
    When User clicks "View" icon for Activity "Auto Activity Edit"
    Then Activity "Edit Assign Questionnaire" Detail page is shown with expected details