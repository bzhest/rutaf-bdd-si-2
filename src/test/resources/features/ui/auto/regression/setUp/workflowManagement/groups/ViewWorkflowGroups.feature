@ui @core_regression @workflow_management
Feature: Workflow Group - List / View Workflow Group

  As a Supplier Integrity Administrator
  I want to be able to see all the Workflow Groups in Supplier Integrity
  So that I can manage the Workflow Groups and make some changes if necessary

  @C35739639
  @onlySingleThread
  Scenario: C35739639: Workflow Management - Workflow Groups - Workflow Group List / View Workflow Group
    Given User logs into RDDC as "Admin"
    And User clicks Set Up option
    And User clicks Workflow Management Groups submenu in Set Up menu
    When Users clicks "Last Updated" column header
    Then Workflow Group table displays groups sorted by "Last Updated" in "ASC" order
    When Users clicks "Last Updated" column header
    Then Workflow Group table displays groups sorted by "Last Updated" in "DESC" order
    When Users clicks "Status" column header
    Then Workflow Group table displays groups sorted by "Status" in "ASC" order
    When Users clicks "Status" column header
    Then Workflow Group table displays groups sorted by "Status" in "DESC" order
    When Users clicks "Date Created" column header
    Then Workflow Group table displays groups sorted by "Date Created" in "ASC" order
    When Users clicks "Date Created" column header
    Then Workflow Group table displays groups sorted by "Date Created" in "DESC" order
    When Users clicks "Workflow Group Name" column header
    Then Workflow Group table displays groups sorted by "Workflow Group Name" in "ASC" order
    When Users clicks "Workflow Group Name" column header
    Then Workflow Group table displays groups sorted by "Workflow Group Name" in "DESC" order
    When User clicks first Workflow Group table row
    Then Workflow Group "workflowGroupName" page is displayed
    And Workflow Group Name input field is not displayed
    And Workflow Group Active checkbox is not editable
    And Workflow Group page "Edit" button is displayed
    When User clicks "Back" button for Workflow Group
    Then Workflow Group "workflowGroupName" page is not displayed
    And Workflow Management Group table is displayed with columns
      | WORKFLOW GROUP NAME | STATUS | DATE CREATED | LAST UPDATED |
    When User selects "Max" items per page
    Then Workflow Group table contains group
      | WORKFLOW GROUP NAME | STATUS | DATE CREATED | LAST UPDATED |
      | Default             | Active |              |              |