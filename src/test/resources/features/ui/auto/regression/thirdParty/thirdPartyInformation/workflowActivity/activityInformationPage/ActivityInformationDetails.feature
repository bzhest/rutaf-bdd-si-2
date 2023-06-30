@ui @full_regression @react @activity_details
Feature: Activity Information Page - Activity Details

  @C38727234
  Scenario: C38727234: Activity Information - Activity Information should display complete details when Core Activity is clicked via Onboarding process
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Assign Questionnaire Component" component tab
    And User clicks on "Assign Questionnaire" activity
    Then Activity Information modal is displayed with details
      | Activity Name        | Activity Type        | Description | Due Date | Assessment | Status      | Assignee                      |
      | Assign Questionnaire | Assign Questionnaire | Description | TODAY+1  |            | Not Started | Assignee_AT_FN Assignee_AT_LN |
    And Activity Information Edit button is displayed
    And Activity Information page URL is expected
    When User clicks on Risk Management tab
    And User clicks back browser button
    Then Activity Information page is displayed
    And Activity Information page URL is expected

  @C38727235
  Scenario: C38727235: Activity Information - All details will be editable once Edit button is clicked
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "Auto Test Custom Activity name" activity
    And User clicks Edit button for Activity
    Then Activity Information Edit button is hidden
    And Activity Information button 'Save' is displayed
    And Activity Information button 'Cancel' is displayed
    And Activity Information Assessment field should be enabled
    And Activity Information Status field should be enabled
    And Activity Information Assignee can be edited

  @C38727236 @core_regression
  Scenario: C38727236: Activity Information - Save changes after editing the Activity Information
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "Auto Test Custom Activity name" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User selects activity status "In Progress"
    And User selects activity Assessment "custom"
    And User selects activity assignee "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Save' activity button
    And User clicks on "Auto Test Custom Activity name" activity
    Then Activity Information modal is displayed with details
      | Assessment | Status      | Assignee                      |
      | custom     | In Progress | Assignee_AT_FN Assignee_AT_LN |

  @C38727237
  Scenario: C38727237: Activity Information - Cancel changes after editing the Activity Information
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "Auto Test Custom Activity name" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User selects activity status "In Progress"
    And User selects activity Assessment "custom"
    And User selects activity assignee "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Assessment | Status      | Assignee                |
      |            | Not Started | Admin_AT_FN Admin_AT_LN |

  @C38727238
  Scenario: C38727238: Activity Information - Activity Information will be editable when the Edit button is clicked from the Third-party Information page
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks edit "Auto Test Custom Activity name" activity row button
    Then Activity Information page is displayed
    And Activity Information Edit button is hidden
    And Activity Information button 'Save' is displayed
    And Activity Information button 'Cancel' is displayed
    And Activity Information Assessment field should be enabled
    And Activity Information Status field should be enabled
    And Activity Information Assignee can be edited

  @C38727239
  Scenario: C38727239: Activity Information - Activity Information should display complete details when Core Activity is click
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User clicks "Assign Questionnaire1" Activity details on Workflow History page
    Then Workflow History Activity values should be displayed
      | Activity Type | Assign Questionnaire    |
      | Description   | Description             |
      | Assessment    | case1                   |
      | Status        | Not Started             |
      | Assignee      | Admin_AT_FN Admin_AT_LN |
      | Risk Area     |                         |
      | Approvers     |                         |
      | Reviewers     |                         |
      | Start Date    | TODAY+0                 |
      | Due Date      | TODAY+2                 |
      | Last Update   |                         |
