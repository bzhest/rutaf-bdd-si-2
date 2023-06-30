@ui @full_regression @core_regression @workflow_completion
Feature: Activity Approval

  As a user
  I want to be sure that Approver can approve, reject, reassign activities
  So Activity approval status and assigned user can be correctly changed

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineIndividualWithApprover"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks 'Edit' button on created third-party
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |

  @C36051704
  Scenario: C36051704 [Activity Approval] Only Default Approver set for Activity approval - action Approve
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action | Status   |
      | Admin_AT_FN Admin_AT_LN |              |        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Approved |
    When User clicks Back button to return from Activity modal
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action | Status   |
      | Admin_AT_FN Admin_AT_LN |              |        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Approved |

  @C36051804
  Scenario: C36051804 [Activity Approval] Only Default Approver set for Activity approval - action Reject
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
    And User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
    And User clicks Reject button on confirmation window
    Then Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced | Re-assign for Approval | Rejected |
    When Approver clicks "Re-assign for Approval" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action                  | Status   |
      | Admin_AT_FN Admin_AT_LN |              |                         | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |                         | Rejected |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced | Approve,Reject,Reassign | Pending  |
    When User clicks Back button to return from Activity modal
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action                  | Status   |
      | Admin_AT_FN Admin_AT_LN |              |                         | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |                         | Rejected |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced | Approve,Reject,Reassign | Pending  |

  @C36052012
  @email
  Scenario: C36052012 [Activity Approval] Only Default Approver set for Activity approval - action Re-assign
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
    When User logs into RDDC as "Assignee"
    And User clicks 'Items To Approve' widget
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "Max" items per page
    Then Assigned Activity for third-party is displayed
    And Email notification "Request for Approval" with following values is received by "Assignee" user
      | <Activity_Name> | OrderDueDiligenceReport |
