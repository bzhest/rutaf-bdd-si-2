@ui @core_regression @workflow_management
Feature: Search for Workflow

  As an admin of Supplier Integrity
  I want to be able to filter and search for Workflows in the system
  So that I can efficiently find the Workflows that I need to manage

  @C35801182
  Scenario: C35801182 Workflow Management - Workflows - Workflow List Search and Filter - Filter Workflow
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Show Drop-Down current option should be "All"
    And Show Drop-Down list is displayed with values
      | All      |
      | Active   |
      | Inactive |
    When User selects "Active" show option
    And User selects "50" items per page
    Then Table displayed with all "Active" items
    When User selects "Inactive" show option
    And User selects "50" items per page
    Then Table displayed with all "Inactive" items