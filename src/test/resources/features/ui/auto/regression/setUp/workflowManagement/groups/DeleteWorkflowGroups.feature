@ui @full_regression @workflow_management
Feature: Workflow Group - Delete Workflow Group

  Background:
    Given User logs into RDDC as "Admin"

  @C35742548
  Scenario: C35742548: Workflow Management - Workflow Groups - Delete and Cancel Delete Workflow Group
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User navigates to 'Workflow Management' block 'Groups' section
    Then Delete icon is displayed in each row of the Workflow Group table
    When User clicks the Delete icon for created workflow group
    Then Message is displayed on confirmation window
      | Workflow group is currently in use and you will not be able to delete it |
    When User clicks Ok button on confirmation window
    Then Confirmation window is disappeared
    When User creates "Active" workflow group with random name via API
    And User navigates to 'Workflow Management' block 'Groups' section
    And User clicks the Delete icon for created workflow group
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this workflow group? This change cannot be undone. |
    And Confirmation button Cancel should be displayed
    And Confirmation button Delete should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Workflow Group is displayed with values
      | WORKFLOW GROUP NAME | STATUS | DATE CREATED |
      | toBeReplaced        | Active | MM/dd/YYYY   |
    And User clicks the Delete icon for created workflow group
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Workflow group has been deleted |
    And Confirmation window is disappeared
    And Workflow Group is not displayed with values
      | WORKFLOW GROUP NAME | STATUS | DATE CREATED | LAST UPDATED |
      | toBeReplaced        | Active | MM/dd/YYYY   |              |
