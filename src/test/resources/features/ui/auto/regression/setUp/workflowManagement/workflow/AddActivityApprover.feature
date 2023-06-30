@ui @full_regression @workflow_management
Feature: Workflow Management - Add Activity Approvers

  As a user
  I want to be sure that Approver can be added to Activity
  So Activity can be correctly saved with Approver

  Background:
    Given User logs into RDDC as "Admin"
    And User navigates to 'Workflow Management' block 'Workflow' section
    And Workflow Table is displayed
    And User clicks Add Workflow button
    And Workflow Create Workflow page is displayed
    And User fills in workflow details data "Onboarding Workflow"
    When User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    Then New Component is created
    When User clicks +Add Activity button
    Then Activity "Add Activity" tab is displayed

  @C35815670
  Scenario: C35815670: [Workflows] - Adding Approvers to Activities - page overview
    When User clicks Activity "Add Approver" tab
    Then Activity "Add Approver" tab is displayed
    When User clicks Add approver button
    Then 'Approver' dropdown contains all Internal Active users
    And Add Approver tab 'Add Rules For' dropdown contains for rule with number 1
      | Activity Owner            |
      | Activity Owner Group      |
      | Activity Owner Department |
      | Activity Owner Division   |
      | Third-party Country       |
      | Third-party Region        |
      | Third-party Industry Type |
    When Close "Add Approver" tab 'Add Rules For' dropdown after check
    And User fills "Activity Third-party Region" in Approver details for 1 rule section
    Then 'Default Approver' Approver section has +Add button

  @C35843320
  Scenario Outline: C35843320: [Workflows] - Verify content of Add rules value is adjusted for Activity Owner
    When User clicks Activity "Add Approver" tab
    And User clicks Add approver button
    And User selects in Add Approver Add Rules For dropdown value "<activityOwnerType>" for rule with number 1
    Then Approval process drop-down "<activityOwnerType>" becomes required
    And Approval process drop-down "Approver" becomes required
    And "<activityOwnerType>" dropdown contains all "<dropDownListOfValues>" for rule with number 1
    When User selects in Add Approver "<activityOwnerType>" Value dropdown 2 values for rule with number 1
    Then Add Approver "<activityOwnerType>" Value dropdown contains added values for rule with number 1
    When User selects in Add Approver Approver dropdown value "Assignee_AT_FN Assignee_AT_LN" for rule with number 1
    And User selects in Add Approver Approver dropdown value "Admin_AT_FN Admin_AT_LN" for rule with number 1
    Then Approver dropdown contains expected values for rule with number 1
      | Assignee_AT_FN Assignee_AT_LN |
      | Admin_AT_FN Admin_AT_LN       |
    Examples:
      | activityOwnerType         | dropDownListOfValues             |
      | Activity Owner            | Internal Active users            |
      | Activity Owner Group      | Active user groups               |
      | Activity Owner Department | All Departments in the system    |
      | Activity Owner Division   | All Divisions in the system      |
      | Third-party Country       | All Countries in the system      |
      | Third-party Region        | All Regions in the system        |
      | Third-party Industry Type | All Industry Types in the system |

  @C35845836
  Scenario: C35845836: [Workflows] - Searching of approval processes in list of approval processes
    When User clicks Activity "Add Approver" tab
    And User clicks 'Add Existing Approval Process' button
    Then 'Add Existing Approval Process' table contains columns
      | APPROVAL PROCESS NAME | DESCRIPTION | STATUS |
    When User searches not existing approval process
    Then No Approval Process Available message is displayed
    When User click approval process button "Cancel"
    And User clicks 'Add Existing Approval Process' button
    And User searches approval process with name "toBeReplaced"
    Then Search item "toBeReplaced" is shown


  @C37428271
  @core_regression
  Scenario: C37428271: [Workflows] - Adding Approvers to Activities - additional Approver can be set to the workflow.
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Auto Activity"
    And User populates Activity Description with "Activity Description"
    And User ticks User radio button
    And User selects Workflow Assignee(s) as "Admin_AT_FN Admin_AT_LN"
    And User populates Due In with "1"
    And User clicks Activity "Add Approver" tab
    Then Add approver button is disabled
    When User selects "Admin_AT_FN Admin_AT_LN" value for Default Approver
    And User clicks Add approver button
    Then Add approver button is disabled
    When User fills "Activity Owner Division" in Approver details for 1 rule section
    Then Add approver button is enabled
    When User clicks Add approver button
    And User fills "Activity Third-party Region" in Approver details for 2 rule section
    Then Add approver button is enabled
    When User clicks Add approver button
    Then Approver rule section on position "3" is displayed
    When User clicks remove icon for Approver rule section on position 3
    Then Approver rule section on position 3 is disappeared
    When User clicks workflow button "Done"
    And User clicks "View" icon for Activity "Auto Activity"
    And User clicks Activity "Approver" tab
    Then Approver overview page contains expected list details
