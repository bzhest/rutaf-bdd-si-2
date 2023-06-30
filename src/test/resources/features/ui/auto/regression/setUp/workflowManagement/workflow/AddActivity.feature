@ui @full_regression @workflow_management
Feature: Adding Activities to a Workflow

  As a Third-party Integrity Administrator
  I want to be able to create activities in Workflows
  So that I can layout the activities that needs to be completed for Onboarding Third-parties,
  that satisty the conditions of the Workflow

  Background:
    Given User logs into RDDC as "Admin"
    And User navigates to 'Workflow Management' block 'Workflow' section
    And Workflow Table is displayed
    And User clicks Add Workflow button
    And Workflow Create Workflow page is displayed
    And User fills in workflow details data "Onboarding Workflow"
    When User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    Then New Component is created
    When User clicks +Add Activity button

  @C35814751 @C37428262
  @core_regression
  Scenario: C35814751, C37428262: Workflow - Add Activity with assignee as a user
    Then Activity "Add Activity" tab is displayed
    And Add Activity tab is displayed with expected required fields
    And Activity Type drop-down list contains all the Activity types that are in the system
    And Assignee options are displayed
    And Risk Area drop-down contains expected Risk Areas
    And Workflow button "Cancel" should be enabled
    And Workflow button "Done" should be enabled
    When User selects "User" Assignee type
    Then Assignee's drop-down contains only active users
    When User fills in Activity "Assign Questionnaire" details
    And User clicks workflow button "Done"
    Then Component on position 0 contains "Assign Questionnaire" activity assigned to "0" group
    And Activity "Assign Questionnaire" buttons are active
    When User clicks "view" "Assign Questionnaire" activity
    Then Activity "Assign Questionnaire" Detail page is shown with expected details
    And Workflow button "Cancel" should be enabled
    And Activity button 'Edit' should be enabled

  @C35839868 @C37429831
  @core_regression
  Scenario: C35839868, C37429831: Workflow - Add Activity with assignee as a group
    When User fills in Activity "Assign Questionnaire With Group Assignee" details
    Then Assignee(s) drop-down contains all active user groups
    When User clicks workflow button "Done"
    Then Component on position 0 contains "Assign Questionnaire With Group Assignee" activity assigned to "0" group
    And Activity "Assign Questionnaire With Group Assignee" buttons are active
    When User clicks "view" "Assign Questionnaire With Group Assignee" activity
    Then Activity "Assign Questionnaire With Group Assignee" Detail page is shown with expected details
    And Workflow button "Cancel" should be enabled
    And Activity button 'Edit' should be enabled

  @C35842514 @C37428264
  @core_regression
  Scenario: C35842514, C37428264: Workflow - Add Activity - Add Activity with Activity type having an assessment
    When User fills in Activity "Assessment Activity" details
    Then Assignee's drop-down contains only active users
    And The set up values are displayed in the corresponding fields
      | custom |
    When User clicks workflow button "Done"
    Then Component on position 0 contains "Assessment Activity" activity assigned to "0" group
    And Activity "Assessment Activity" buttons are active
    When User clicks "view" "Assessment Activity" activity
    Then Activity "Assessment Activity" Detail page is shown with expected details
    And Workflow button "Cancel" should be enabled
    And Activity button 'Edit' should be enabled

  @C35840010
  Scenario: C35840010: Workflow - Add Activity - Validation for required fields
    Then Activity "Add Activity" tab is displayed
    And Add Activity tab is displayed with expected required fields
    And Add Activity tab fields should be in correct state
      | Activity Type           | enabled  |
      | Activity Name           | enabled  |
      | Description             | enabled  |
      | User radio              | enabled  |
      | Group radio             | enabled  |
      | Responsible Party radio | enabled  |
      | Pending for Assignment  | enabled  |
      | Assignee(s)             | disabled |
      | Status                  | disabled |
      | Risk Area               | enabled  |
      | Attachment              | enabled  |
      | Due In                  | enabled  |
    And Workflow Activity Responsible Party assignee is selected
    And Assignee options are displayed
    And Activity Type drop-down list contains all the Activity types that are in the system
    And Risk Area drop-down contains expected Risk Areas
    When User clicks workflow button "Done"
    Then Alert Icon is displayed with text
      | Cannot Save                           |
      | Please complete the required field(s) |
    And Workflow Activity field should be highlighted in red
      | Activity Type | Activity Name | Description | Due In |
    And Error message "This field is required" is displayed on Workflow Add Activity page for fields
      | Activity Type | Activity Name | Description | Due In |
    When User ticks Pending for Assignment checkbox
    Then Assignee's field should be hidden
    When User clicks workflow button "Done"
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Workflow Activity field should be highlighted in red
      | Activity Type | Activity Name | Description | Due In |
    And Error message "This field is required" is displayed on Workflow Add Activity page for fields
      | Activity Type | Activity Name | Description | Due In |

  @C35862618
  Scenario: C35862618: Workflow - Edit Activity from Component Screen/Activity Details Screen. Validation for required fields
    When User fills in Activity "Assign Questionnaire With Group Assignee" details
    And User clicks workflow button "Done"
    Then Component on position 0 contains "Assign Questionnaire With Group Assignee" activity assigned to "0" group
    And Activity "Assign Questionnaire With Group Assignee" buttons are active
    When User clicks "edit" "Assign Questionnaire With Group Assignee" activity
    Then Activity "Edit Activity" tab is displayed
    And Edit Activity tab is displayed with expected required fields
    And Edit Activity tab fields should be in correct state
      | Activity Type           | enabled  |
      | Activity Name           | enabled  |
      | Description             | enabled  |
      | User radio              | enabled  |
      | Group radio             | enabled  |
      | Responsible Party radio | enabled  |
      | Pending for Assignment  | enabled  |
      | Assignee(s)             | enabled  |
      | Status                  | disabled |
      | Risk Area               | enabled  |
      | Attachment              | enabled  |
      | Due In                  | enabled  |
    And Workflow button "Cancel" should be enabled
    And Workflow button "Done" should be enabled
    When User clears all Activity form required fields with Group Assignee type
    And User clicks workflow button "Done"
    Then Alert Icon is displayed with text
      | Cannot Save                           |
      | Please complete the required field(s) |
    And Workflow Activity field should be highlighted in red
      | Activity Type | Activity Name | Description | Assignee(s) | Due In |
    And Error message "This field is required" is displayed on Workflow Add Activity page for fields
      | Activity Type | Activity Name | Description | Assignee(s) | Due In |

  @C35879739
  Scenario: C35879739: Workflow - Edit Activity from Component Screen/Activity Details Screen. Edit Activity with Assessment
    When User fills in Activity "Assessment Activity With Assignee User" details
    And User clicks workflow button "Done"
    Then Component on position 0 contains "Assessment Activity With Assignee User" activity assigned to "0" group
    And Activity "Assessment Activity With Assignee User" buttons are active
    When User clicks "edit" "Assessment Activity With Assignee User" activity
    Then Activity "Edit Activity" tab is displayed
    And Assessment fields should be disabled
    When User clears all Activity form required fields with User Assignee type
    And User fills in Activity "Simple Custom Activity" details
    Then Assessment fields should be absent
