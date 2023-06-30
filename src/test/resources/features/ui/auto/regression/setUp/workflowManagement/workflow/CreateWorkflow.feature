@ui @core_regression @workflow_management
Feature: Creating New Workflows

  As a Supplier Integrity Administrator
  I want to be able to create Workflows
  So that I can set the activities that need to be completed to Onboard Suppliers based on their information

  Background:
    Given User logs into RDDC as "Admin"
    And User navigates to 'Workflow Management' block 'Workflow' section
    And Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed

  @C35762047
  @onlySingleThread
  Scenario: C35762047: Workflow Management - Workflows - Creating New Workflows
    Given Workflow Type drop down contains the following options
      | Renewal    |
      | Onboarding |
    When User fills in Workflow Type "Onboarding"
    Then Workflow Group drop down contains all active workflow groups
    And Risk Scoring Range drop down contains all ranges sorted in Ascending order
    When User clicks workflow button "Cancel"
    Then Workflow Create Workflow page is disappeared
    And Workflow table column names should be correct
      | WORKFLOW NAME |
      | WORKFLOW TYPE |
      | DATE CREATED  |
      | LAST UPDATED  |
      | STATUS        |
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed

  @C35763301
  @RMS-8925
  Scenario: C35763301: Workflow Management - Workflows - Validation for required fields and unique combination of Risk Scoring Range and Workflow Group
    Given Workflow "Workflow Name" input field is required and blank
    And Workflow "Workflow Type" input field is required and blank
    And Workflow Description text area is blank
    And Workflow Active checkbox is ticked
    When User clicks workflow button "Next"
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Workflow Name" field
    And Error message "This field is required" in red color is displayed near "Workflow Type" field
    When User fills in Workflow Type "Onboarding"
    Then Workflow "Risk Scoring Range" drop-down field is required and blank
    And Workflow "From" input field is blank and disabled
    And Workflow "To" input field is blank and disabled
    And Workflow "Workflow Group" drop-down field is required and blank
    When User clicks workflow button "Next"
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Workflow Name" field
    And Error message "This field is required" in red color is displayed near "Risk Scoring Range" field
    And Error message "This field is required" in red color is displayed near "Workflow Group" field
    When User populates Workflow Name with "AUTO_TEST_Workflow_"
    And User selects Risk scoring range and Workflow group combination of existing "Workflow - do not edit" workflow
    And User clicks workflow button "Next"
    Then Alert Icon is displayed with text
      | Cannot save! Workflow group and risk scoring range already exists |
    And Error message "Risk scoring range already exists" in red color is displayed near "Risk Scoring Range" field
    And Error message "Workflow group already exists" in red color is displayed near "Workflow Group" field
    And Workflow Create Workflow page is displayed

  @C35794954
  Scenario: C35794954: Workflow Management - Workflow Wizard:Add/Edit Wizard Component - Add New Component
    Given User fills in workflow details data "Onboarding Workflow"
    When User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    Then New Component is created
    And New Component header contains text "NEW COMPONENT"
    And Workflow button "Back" should be displayed
    And Workflow button "Save" should be displayed
    And Workflow button "Back" should be enabled
    And Workflow button "Save" should be enabled
    When User updates Component Name "Auto Component" on position 0
    And User clicks Check button
    Then Component Name "Auto Component" is displayed
    And Component Name field input is not displayed
    And Component "Edit" button is displayed
    And Component "Delete" button is displayed
    When User clicks Add Wizard Component button
    Then New Component is created
    And New Component header contains text "NEW COMPONENT"
    Then Component Name "NEW COMPONENT" is displayed
    And Component Name field input is not displayed
    And Component "Edit" button is displayed
    And Component "Delete" button is displayed
    When User clicks Add Wizard Component button
    Then New Component is created
    And New Component header contains text "NEW COMPONENT"
    Then Component Name "NEW COMPONENT" is displayed
    And Component "Edit" button is displayed
    And Component "Delete" button is displayed

  @C35794954
  Scenario: C35794954: Workflow Management - Workflow Wizard:Add/Edit Wizard Component - Add 25 Components
    Given User fills in workflow details data "Onboarding Workflow"
    When User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User adds 25 components with "Assign Questionnaire" activity
    Then Component Name "AUTO_TEST_25" is displayed
    When User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |
    When User clicks on created Workflow
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    And Workflow button "ADD WIZARD COMPONENT" should be displayed
    And Workflow button "ADD WIZARD COMPONENT" should be enabled
    And Workflow button "GROUPING" should be displayed
    And Workflow button "GROUPING" should be enabled
    And Workflow button "Back" should be displayed
    And Workflow button "Back" should be enabled
    And Workflow button "Commit new version" should be displayed
    And Workflow button "Commit new version" should be enabled
    And Workflow button "Save as draft" should be displayed
    And Workflow button "Save as draft" should be enabled
    When Users drags component on position 0 and drop on position 1
    Then Component Name "AUTO_TEST_1" for component on position 1 is displayed
    And Component Name "AUTO_TEST_2" for component on position 0 is displayed
    When User clicks workflow button Commit New Version
    Then Message is displayed on confirmation window
      | Are you sure you want to commit a new version of this Workflow? |
    And Confirmation window button with text "Cancel" is displayed
    When User clicks Ok button on confirmation window
    And User refreshes page
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   | MM/dd/YYYY   | Active |
    When User clicks 'Edit' button for created Workflow
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    And Component Name "AUTO_TEST_1" for component on position 1 is displayed
    And Component Name "AUTO_TEST_2" for component on position 0 is displayed
    When User updates Component Name "Edited Auto Component" on position 0
    And User clicks Check button on position 0
    And User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Confirmation window is disappeared
    And Workflow Table is displayed
    When User refreshes page
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   | MM/dd/YYYY   | Active |
    When User clicks on created Workflow
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    And Component Name "Edited Auto Component" for component on position 0 is displayed

  @C35808898
  Scenario: C35808898: Workflow Management - Workflow - Create New Workflow Save Workflow Wizard
    Given User fills in workflow details data "Onboarding Workflow"
    When User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User adds 1 components with "Assign Questionnaire" activity
    Then Component Name "AUTO_TEST_1" is displayed
    When User clicks Add Wizard Component button
    And User clicks Save button for Workflow
    Then Message is displayed on confirmation window
      | There is Component with no activity. Please remove component with no activity |
    And Confirmation window button with text "Ok" is displayed
    When User clicks Ok button on confirmation window
    Then Confirmation window is disappeared
    When User clicks "Delete" button for component on position 1
    And User clicks Delete button on confirmation window
    And User clicks Save button for Workflow
    Then Workflow Table is displayed
    And Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |
    When User clicks on created Workflow
    Then Workflow overview is displayed
    And Workflow page is displayed with expected details
    When User clicks workflow button "Next"
    Then Component Name "AUTO_TEST_1" for component on position 0 is displayed
    And Workflow button "Back" should be displayed
    And Workflow button "Back" should be enabled
    And Workflow button "Commit new version" should be displayed
    And Workflow button "Commit new version" should be enabled
    And Workflow button "Save as draft" should be displayed
    And Workflow button "Save as draft" should be enabled

