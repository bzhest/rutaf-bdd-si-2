@ui @robusta @automation_DDO_logic
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

  @C54031288
  @onlySingleThread
  @core_regression
  Scenario: C54031288: Automated DDO - Workflow Setup -Add Activity- Verify Recommended Scope Setting is optional in Organisation Scope Type
    Then Workflow Type drop down contains the following options
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
    When User selects Activity Type as "Order Due Diligence Report"
    And User selects Scope Type as "Organisation"
    And User populates Activity Name with "Order Due Diligence Report"
    And User populates Activity Description with "DDO description"
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been added. |
    When User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |

  @C54031289
  @onlySingleThread
  @core_regression
  Scenario: C54031289: Automated DDO - Workflow Setup -Add Activity- Verify Recommended Scope Setting is optional in Individual Scope Type
    Then Workflow Type drop down contains the following options
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
    When User selects Activity Type as "Order Due Diligence Report"
    And User selects Scope Type as "Individual"
    And User populates Activity Name with "Order Due Diligence Report"
    And User populates Activity Description with "DDO description"
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been added. |
    When User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |
