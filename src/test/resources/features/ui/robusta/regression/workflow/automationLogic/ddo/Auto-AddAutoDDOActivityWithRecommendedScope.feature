@ui @robusta @regression @automation_DDO_logic
Feature: Automated DDO

  As an RDDC user
  I want to be able to configure automated ordering of Due Diligence
  So that the the order would be placed directly to PSA without my manual input.

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
    When User selects Activity Type as "Order Due Diligence Report"

  @C54016643 @core_regression
  Scenario: C54016643- Automated DDO - Workflow Setup -Add Activity- When user ticks auto-order on Organisation Scope
  with Recommended Scope
    When User selects Scope Type as "Organisation"
    And User selects recommended scope as "Bronze Company (QA-Regression)"
    And User populates Activity Name with "Order Due Diligence Report"
    And User populates Activity Description with "DDO description"
    And User ticks Automatically order recommended scope of Due Diligence report checkbox
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been added. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow should be created
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "View" icon for Activity "Order Due Diligence Report"
    Then Active checkbox is checked

  @C54031284 @core_regression
  Scenario: C54031284 - Automated DDO - Workflow Setup -Add Activity- When user ticks auto-order on Individual Scope
  with Recommended Scope
    When User selects Scope Type as "Individual"
    And User selects recommended scope as "Bronze Individual (QA-Regression)"
    And User populates Activity Name with "Order Due Diligence Report"
    And User populates Activity Description with "DDO description"
    And User ticks Automatically order recommended scope of Due Diligence report checkbox
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been added. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow should be created
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "View" icon for Activity "Order Due Diligence Report"
    Then Active checkbox is checked