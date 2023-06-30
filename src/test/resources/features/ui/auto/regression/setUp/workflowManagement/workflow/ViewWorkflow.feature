@ui @core_regression @workflow_management
Feature: Viewing Workflows

  As a Supplier Integrity Administrator
  I want to see all the workflows configured in the system
  So that I can see the workflows that can apply to the suppliers that the company is Onboarding

  @C35780051
  Scenario: C35780051: Workflow Management - Workflows - View Workflow List
    Given User logs into RDDC as "Admin"
    And User clicks Set Up option
    When User clicks Workflow Management Workflow submenu in Set Up menu
    Then Workflow table column names should be correct
      | WORKFLOW NAME |
      | WORKFLOW TYPE |
      | DATE CREATED  |
      | LAST UPDATED  |
      | STATUS        |
    And Workflows table displays workflow sorted by "createTime" in "DESC" order
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    And Pagination option "10" is selected
    When User selects "25" items per page
    Then Table displayed with up to 25 "workflows" for first page
    When User selects "50" items per page
    Then Table displayed with up to 50 "workflows" for first page
    When User selects "10" items per page
    Then Table displayed with up to 10 "workflows" for first page
    When User clicks on workflow with name "Workflow Activity Approvers"
    Then Workflow overview is displayed
    And Workflow overview has correct field titles
      | Workflow Name      |
      | Workflow Type      |
      | Description        |
      | Active             |
      | Risk Scoring Range |
      | From               |
      | To                 |
      | Workflow Group     |
    And Workflow button "Next" should be displayed
    And Workflow button "Cancel" should be displayed
    When User clicks workflow button "Cancel"
    And User clicks on workflow with name "Workflow Activity Approvers"
    And User clicks workflow button "Next"
    Then User verifies workflow wizard elements are displayed
    When User clicks workflow button "Back"
    Then Workflow overview is displayed
    And Workflow overview has correct field titles
      | Workflow Name      |
      | Workflow Type      |
      | Description        |
      | Active             |
      | Risk Scoring Range |
      | From               |
      | To                 |
      | Workflow Group     |
