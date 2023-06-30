@ui @sanity @workflow_management
Feature: Workflow Management

  As a user
  I want to manage Workflows
  So they can be assigned to a Supplier

  @multilanguage
  @C32988243
  Scenario: C32988243: Workflow Management - Groups - Add a Workflow Group
    When User logs into RDDC as "Admin"
    And User sets up language via API
    And User navigates to 'Workflow Management' block 'Groups' section
    And User clicks Add Workflow Group button
    Then Workflow Group "groups.add groups.group" page is displayed
    When User populates Workflow Group Name
    Then Workflow Group Active checkbox is ticked
    When User clicks "associatedParties.saveButton" Value Management button
    Then Workflow Group is displayed with values
      | WORKFLOW GROUP NAME | STATUS                                | DATE CREATED | LAST UPDATED |
      | toBeReplaced        | workflowManagement.group.activeStatus | MM/dd/YYYY   |              |

  @C32988235
  Scenario: C32988235: Workflow Management - Workflow - Add a Workflow (Basic Workflow)
    Given User logs into RDDC as "Assignee"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Auto Component" on position 0
    And User clicks Check button
    Then Component Name "Auto Component" is displayed
    When User clicks +Add Activity button
    Then Activity "Add Activity" tab is displayed
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Auto Activity"
    And User populates Activity Description with "Activity Description"
    And User ticks User radio button
    And User selects Workflow Assignee(s) as "Admin_AT_FN Admin_AT_LN"
    And User populates Due In with "1"
    And User clicks Done button for Activity
    And User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | STATUS                                   |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   | workflowManagement.workflow.activeStatus |
