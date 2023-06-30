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

  @C53680528 @core_regression
  Scenario: C53680528: Workflow Activity - DDO - Automation Logic - Auto-ordering configuration is ON: Organization - View DDO activity
    When User selects Activity Type as "Order Due Diligence Report"
    And User ticks Automatically order recommended scope of Due Diligence report checkbox
    And User selects Scope Type as "Organisation"
    And User selects recommended scope as "Bronze Company (QA-Regression)"
    Then User Group radio button should be disabled
    And Pending for Assignment checkbox is disabled
    When User populates Activity Name with "Order Due Diligence Report"
    And User populates Activity Description with "Order Due Diligence Report"
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow should be created
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "View" icon for Activity "Order Due Diligence Report"
    Then Automatically order recommended scope of Due Diligence report checkbox is checked

  @C54549461 @core_regression
  Scenario: C54549461: Workflow Activity - DDO - Automation Logic - Auto-ordering configuration is ON: Individual - View DDO activity
    When User selects Activity Type as "Order Due Diligence Report"
    And User ticks Automatically order recommended scope of Due Diligence report checkbox
    And User selects Scope Type as "Individual"
    And User selects recommended scope as "Bronze Individual (QA-Regression)"
    Then User Group radio button should be disabled
    And Pending for Assignment checkbox is disabled
    When User populates Activity Name with "Order Due Diligence Report"
    And User populates Activity Description with "Order Due Diligence Report"
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow should be created
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "View" icon for Activity "Order Due Diligence Report"
    Then Automatically order recommended scope of Due Diligence report checkbox is checked