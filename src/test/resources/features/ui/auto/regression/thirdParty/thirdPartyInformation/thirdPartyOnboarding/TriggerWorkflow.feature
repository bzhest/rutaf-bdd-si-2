@ui @full_regression @supplier_onboarding
Feature: Supplier Onboarding - Trigger Workflow

  As a Supplier Integrity User
  I want I want to see the set of activities that need to be done in Onboarding a Supplier
  So that I can track the progress of the Suppliers being onboarded

  Background:
    Given User logs into RDDC as "Admin"

  @C35930133
  @core_regression
  Scenario: C35930133: [Onboarding workflow selection] Triggering the Correct Workflow for a Supplier
    When User creates new Workflow "Automation Workflow Questionnaire Inactive Duplicate" with Activity "Assign Questionnaire"
    And User creates new Workflow "Automation Workflow Questionnaire Active Duplicate" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's onboarding workflow should be shown - "workflowName"
    And Third-party's onboarding workflow description should be shown - "Automation Workflow Questionnaire Active Duplicate"

  @C35908642
  Scenario: C35908642: [Supplier Onboarding] Check flow for not available triggering workflow
    When User creates "Active" workflow group with random name via API
    And User creates third-party "with workflow group"
    Then Third-party's status should be shown - "NEW"
    When User waits and clicks "Start Onboarding" third-party button
    Then Alert Icon is displayed with text
      | There is no workflow available.    |
      | Please contact your administrator. |
    When User clicks Close Toast message button
    Then Toast message is not displayed

  @C35930625 @C37886412
  Scenario: C35930625, C37886412: [Onboarding workflow selection] Display Activities in Onboarding/Renewal Activities section
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Once Onboarding started user should have new activity assigned
    And Third-party's status should be shown - "ONBOARDING"
    When User clicks "Assign Questionnaire Component" component tab
    Then Activities table should contain the following columns
      | NAME | TYPE | ASSIGNED TO | DUE DATE | STATUS |
    And Activities table should contain the following activity
      | Name                 | Type                 | Assigned To                   | Due Date | Status      |
      | Assign Questionnaire | Assign Questionnaire | Assignee_AT_FN Assignee_AT_LN | TODAY+1  | Not Started |
    When User clicks close component button
    Then Component is closed
    When User clicks "Assign Questionnaire Component" component tab
    And User clicks "New Component" component tab
    And Activities table should contain the following activity
      | Name                  | Type                 | Assigned To             | Due Date | Status      |
      | Assign Questionnaire1 | Assign Questionnaire | Admin_AT_FN Admin_AT_LN | TODAY+2  | Not Started |
