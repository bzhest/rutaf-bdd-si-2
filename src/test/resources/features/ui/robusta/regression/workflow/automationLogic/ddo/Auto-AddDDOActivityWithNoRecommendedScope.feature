@ui @robusta @automation_DDO_logic
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

  @C54016644 @core_regression
  Scenario: C54016644- Automated DDO - Workflow Setup - Add Activity - When user ticks auto-order on Organization Scope
  without Recommended Scope
    When User selects Scope Type as "Organisation"
    And User populates Activity Name with "Order Due Diligence Report"
    And User populates Activity Description with "DDO description"
    And User ticks Automatically order recommended scope of Due Diligence report checkbox
    And User populates Due In with "1"
    And User clicks Done button for Activity
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Cannot Save! Please select the |
      | recommended scope to           |
      | proceed.                       |
    And Error message 'This field is required' is displayed in 'Please select the recommended scope' section
    When User selects recommended scope as "Gold Company"
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
    Then Automatically order recommended scope of Due Diligence report checkbox is checked

  @C54031285 @core_regression
  Scenario: C54031285- Automated DDO - Workflow Setup - Add Activity - When user ticks auto-order on Individual Scope
  without Recommended Scope
    When User selects Scope Type as "Individual"
    And User populates Activity Name with "Order Due Diligence Report"
    And User populates Activity Description with "DDO description"
    And User ticks Automatically order recommended scope of Due Diligence report checkbox
    And User populates Due In with "1"
    And User clicks Done button for Activity
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Cannot Save! Please select the |
      | recommended scope to           |
      | proceed.                       |
    And Error message 'This field is required' is displayed in 'Please select the recommended scope' section
    When User selects recommended scope as "Platinum Individual"
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
    Then Automatically order recommended scope of Due Diligence report checkbox is checked