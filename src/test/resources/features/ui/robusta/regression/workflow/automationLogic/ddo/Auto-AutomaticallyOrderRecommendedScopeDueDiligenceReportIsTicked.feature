@ui @robusta @automation_DDO_logic @core_regression
Feature: Creating New Workflows

  As an RDDC Administrator
  I want to be able to create Workflows
  So that I can set the activities that need to be completed to Onboard Third-Parties based on their information

  Background:
    Given User logs into RDDC as "Admin"
    And User navigates to 'Workflow Management' block 'Workflow' section
    And Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    And Workflow Type drop down contains the following options
      | Renewal    |
      | Onboarding |
    When User fills in Workflow Type "Onboarding"
    Then Workflow Group drop down contains all active workflow groups
    And Risk Scoring Range drop down contains all ranges sorted in Ascending order
    When User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    Then New Component is created
    When User clicks +Add Activity button
    Then Activity "Add Activity" tab is displayed
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "My Assign Questionnaire"
    And User populates Activity Description with "QST description"
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been added. |
    When User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |
    When User clicks 'Edit' button for created Workflow
    And User clicks Next button
    And User clicks "Edit" icon for Activity "My Assign Questionnaire"
    And User selects Activity Type as "Order Due Diligence Report"

  @C54016645
  Scenario: C54016645: Automated DDO - Workflow Setup -Edit Activity- When user ticks auto-order on Organization Scope with Recommended Scope
    When User selects Scope Type as "Organisation"
    And User populates Activity Name with "Order Due Diligence Report"
    And User populates Activity Description with "DDO description"
    And User populates Due In with "1"
    And User ticks Automatically order recommended scope of Due Diligence report checkbox
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Cannot Save! Please select the |
      | recommended scope to           |
      | proceed.                       |
    And Error message 'This field is required' is displayed in 'Please select the recommended scope' section
    When User selects recommended scope as "Bronze Company (QA-Regression)"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   | MM/dd/YYYY   | Active |

  @C54016646
  Scenario: C54016646: Automated DDO - Workflow Setup - Edit Activity - When user ticks auto-order on Organization Scope without Recommended Scope
    When User selects Scope Type as "Organisation"
    And User populates Activity Name with "Order Due Diligence Report"
    And User populates Activity Description with "DDO description"
    And User populates Due In with "1"
    And User ticks Automatically order recommended scope of Due Diligence report checkbox
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Cannot Save! Please select the |
      | recommended scope to           |
      | proceed.                       |
    And Error message 'This field is required' is displayed in 'Please select the recommended scope' section

  @C54031286
  Scenario: C54031286: Automated DDO - Workflow Setup -Edit Activity- When user ticks auto-order on Individual Scope with Recommended Scope
    When User selects Scope Type as "Individual"
    And User populates Activity Name with "Order Due Diligence Report"
    And User populates Activity Description with "DDO description"
    And User populates Due In with "1"
    And User ticks Automatically order recommended scope of Due Diligence report checkbox
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Cannot Save! Please select the |
      | recommended scope to           |
      | proceed.                       |
    And Error message 'This field is required' is displayed in 'Please select the recommended scope' section
    When User selects recommended scope as "Bronze Individual (QA-Regression)"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   | MM/dd/YYYY   | Active |

  @C54031287
  Scenario: C54031287: Automated DDO - Workflow Setup - Edit Activity - When user ticks auto-order on Individual Scope without Recommended Scope
    When User selects Scope Type as "Individual"
    And User populates Activity Name with "Order Due Diligence Report"
    And User populates Activity Description with "DDO description"
    And User populates Due In with "1"
    And User ticks Automatically order recommended scope of Due Diligence report checkbox
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Cannot Save! Please select the |
      | recommended scope to           |
      | proceed.                       |
    And Error message 'This field is required' is displayed in 'Please select the recommended scope' section