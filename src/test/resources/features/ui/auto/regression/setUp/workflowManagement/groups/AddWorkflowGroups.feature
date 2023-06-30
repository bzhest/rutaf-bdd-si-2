@ui @core_regression @workflow_management
Feature: Workflow Group - Add New Workflow Group

  As a Supplier Integrity Administrator
  I want to be able to create Workflow Groups
  So that I can have a way of grouping workflows and create different workflows for specific risk ranges

  @C35734195
  Scenario: C35734195: Workflow Management - Workflow Groups - Add and Cancel Add New Workflow Group
    Given User logs into RDDC as "Admin"
    And User clicks Set Up option
    And User clicks Workflow Management Groups submenu in Set Up menu
    When User clicks Add Workflow Group button
    Then Workflow Group "Add Group" page is displayed
    And Workflow Group Name field is required
    And Workflow Group Name field is blank
    And Workflow Group Active checkbox is ticked
    And Workflow Group page "Save" button is displayed
    And Workflow Group page "Cancel" button is displayed
    When User clicks "Save" button for Workflow Group
    Then Alert Icon is displayed with text
      | Cannot Save! Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near Workflow Group Name field
    When User populates Workflow Group Name with "Auto Workflow Group"
    And User clicks "Save" button for Workflow Group
    Then Alert Icon is displayed with text
      | Cannot save! Workflow group already exists |
    When User populates Workflow Group Name
    And User clicks "Save" button for Workflow Group
    Then Workflow Group "Add Group" page is not displayed
    And Workflow Group is displayed with values
      | WORKFLOW GROUP NAME | STATUS | DATE CREATED | LAST UPDATED |
      | toBeReplaced        | Active | MM/dd/YYYY   |              |
    When User clicks Add Workflow Group button
    Then Workflow Group "Add Group" page is displayed
    When User clicks "Cancel" button for Workflow Group
    Then Workflow Group "Add Group" page is not displayed
