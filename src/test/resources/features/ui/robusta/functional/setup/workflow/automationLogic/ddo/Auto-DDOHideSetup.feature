@ui @robusta @automation_DDO_logic
Feature: Setup Order Due Diligence Report Activity

As RDDC User
I want to be able to setup the configuration for auto-DDO in Order Due Diligence Report Activity
So that I can hide the configuration to User Group and Pending for Assignment

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User creates new Workflow "Onboarding Workflow" with Activity "Simple Custom Activity"
    And User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks +Add Activity button
    Then Activity "Add Activity" tab is displayed

  @C53680524 @C53680525
  Scenario: C53680524: Workflow Activity - DDO - Automation Logic - Auto-ordering configuration is ON - Disable assignee: User Group,
            C53680525: Workflow Activity - DDO - Automation Logic - Auto-ordering configuration is ON - Disable Pending for Assignment
    When User selects Activity Type as "Order Due Diligence Report"
    And User ticks Automatically order recommended scope of Due Diligence report checkbox
    Then User Group radio button should be disabled
    And Pending for Assignment checkbox is disabled