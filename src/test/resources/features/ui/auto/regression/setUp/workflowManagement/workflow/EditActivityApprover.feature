@ui @workflow_management
Feature: Workflow Management - Edit Activity Approvers

  As a user
  I want to be sure that Approver can be added to Activity
  So Activity can be correctly saved with Approver

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks 'Edit' button for Workflow with name "Workflow Activity Approvers"
    And User clicks workflow button "Next"
    Then Component Name "Auto Component" is displayed
    When User clicks "Edit" icon for Activity "Auto Activity"
    Then Activity "Edit Activity" tab is displayed
    When User clicks Activity "Edit Approver" tab
    Then Edit Approver tab has unfilled fields

  @C35845679
  @core_regression
  Scenario: C35845679: [Workflows] - Adding Approvers to Activities - verify that Approver can be added to the Existing Activity
    When User clicks 'Add Existing Approval Process' button
    And User selects approval process with name "Automation Approval Process"
    And User click approval process button "Select"
    Then Edit Approver tab has correct values
    When User clicks Done button for Activity
    Then Component Name "Auto Component" is displayed
    When User clicks "View" icon for Activity "Auto Activity"
    And User clicks Activity "Approver" tab
    Then Overview Approver tab has correct edit values where rules applied for "Activity Owner"

  @C35845703
  @full_regression
  Scenario: C35845703: [Workflows] - Editing Approvers to Activities - verify table 'sorting' functionality + Search
    When User clicks 'Add Existing Approval Process' button
    Then Pagination option "10" is selected
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    When User selects "25" items per page
    Then Table displayed with up to 25 "approval processes" for first page
    When User selects "50" items per page
    Then Table displayed with up to 50 "approval processes" for first page
    When User selects "10" items per page
    Then Table displayed with up to 10 "approval processes" for first page
    And 'Add Existing Approval Process' table contains columns
      | APPROVAL PROCESS NAME | DESCRIPTION | STATUS |
    And 'Add Existing Approval Process' page title should be "APPROVAL PROCESS"
    And Approval Process page button "Cancel" should be visible
    And Approval Process page button "Select" should be visible
    And Pagination buttons should be visible
      | first | previous | next | last |
    When User searches item by "Automation Approval Process" keyword
    Then Search item "Automation Approval Process" is shown
    When User clicks first Approval Process
    Then Activity process record should have next fields
      | Approval Process Name | Description | Active | Approver | Add Rules For | Activity Owner | Approver | Approver Method |
    When User clicks Approval Process "Back" button
    Then Approval Process item modal window should be closed

  @C35844376
  @core_regression
  Scenario: C35844376: [Workflows] - Adding Approvers to Activities - additional Approver can be set to the workflow
    Then Add approver button is disabled
    When User selects "Admin_AT_FN Admin_AT_LN" value for Default Approver
    And User clicks Add approver button
    Then Add approver button is disabled
    And User fills "Activity Owner Division" in Approver details for 1 rule section
    Then Add approver button is enabled
    When User clicks Add approver button
    Then Approver rule section on position "2" is displayed
    And Approver Rule section on position 1 has remove icon
    And Approver Rule section on position 2 has remove icon
    When User fills "Activity Owner Group" in Approver details for 2 rule section
    And User clicks Add approver button
    Then Approver rule section on position "3" is displayed
    When User clicks remove icon for Approver rule section on position 3
    Then Approver rule section on position 3 is disappeared
    When User clicks workflow button "Done"
    And User clicks "View" icon for Activity "Auto Activity"
    And User clicks Activity "Approver" tab
    Then Approver overview page contains expected list details

  @C35845910 @C37428273
  @core_regression
  Scenario: C35845910, C37428273: [Workflows] - Editing Approvers to Activities - verify that Approvers can be edited
    When User selects "Admin_AT_FN Admin_AT_LN" value for Default Approver
    And User clicks Add approver button
    And User fills "Activity Owner Division" in Approver details for 1 rule section
    And User clicks workflow button "Done"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then Activity "Edit Activity" tab is displayed
    And Activity "Edit Approver" tab is displayed
    When User clicks Activity "Edit Approver" tab
    Then Approver edit page contains expected "Activity Owner Division" details
    When User fills "Activity Owner Group" in Approver details for 1 rule section
    And User clicks workflow button "Done"
    And User clicks "View" icon for Activity "Auto Activity"
    And User clicks Activity "Approver" tab
    Then Approver overview page contains expected "Activity Owner Group" details
