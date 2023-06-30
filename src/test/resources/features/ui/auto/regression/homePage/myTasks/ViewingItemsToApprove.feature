@ui @full_regression @dashboard
Feature: Dashboard - Items to Approve

  As a Supplier Integrity User
  I want a quick view of all the activities assigned to me for Approval
  So that I can review the list without going through each Third-party Record

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "workflowGroupUkraineIndividualWithApprover"
    And User clicks Start Onboarding for third-party

  @C36155826
  @onlySingleThread
  @core_regression
  Scenario: C36155826: Home - My Tasks - Items to Approve - Reassign Activity
    When User navigates to Home page
    Then Counter for Items to Approve is displayed
    When User clicks 'Items To Approve' widget
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "50" items per page
    Then Assigned Activity for third-party is displayed
    When User clicks on assigned activity for created third-party
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |
    And Current URL contains "/thirdparty/" endpoint
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Reassign" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action | Status                 |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Pending                |
      |                         |              |        | Pending for Assignment |
    When User assigns approver "Assignee_AT_FN Assignee_AT_LN"
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status     |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                         | Reassigned |
      | Assignee_AT_FN Assignee_AT_LN |              | Approve,Reject,Reassign | Pending    |
    When User navigates to Home page
    Then Activity is excluded from Items to Approve counter
    When User clicks 'Items To Approve' widget
    Then Assigned Activity for third-party is not displayed

  @C36156022
  @onlySingleThread
  @core_regression
  Scenario: C36156022: Home - My Tasks - Items to Approve - Change Third-party Status to NOT Onboarding or Renewing
    When User navigates to Home page
    Then Counter for Items to Approve is displayed
    When User clicks 'Items To Approve' widget
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "50" items per page
    Then Assigned Activity for third-party is displayed
    When User clicks on assigned activity for created third-party
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |
    And Current URL contains "/thirdparty/" endpoint
    When User clicks Back button to return from Activity modal
    And User clicks "Stop Onboarding" third-party button
    Then Message is displayed on confirmation window
      | Are you sure you want to stop the Onboarding Process? This cannot be undone and you will have to restart the Onboarding Process again. |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "NEW"
    When User navigates to Home page
    Then Activity is excluded from Items to Approve counter
    When User clicks 'Items To Approve' widget
    Then Assigned Activity for third-party is not displayed

  @C36154398
  Scenario: C36154398: Home - My Tasks - Items to Approve - Approved Activity
    When User navigates to Home page
    Then Counter for Items to Approve is displayed
    When User clicks 'Items To Approve' widget
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "Max" items per page
    Then Assigned Activity for third-party is displayed
    When User clicks on assigned activity for created third-party
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |
    And Current URL contains "/thirdparty/" endpoint
    When User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Status   |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced | Approved |
    When User navigates to Home page
    And User clicks 'Items To Approve' widget
    Then Assigned Activity for third-party is not displayed

