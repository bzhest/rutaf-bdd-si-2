@ui @full_regression @react @activity_approver
Feature: Activity Information Page - Activity with Default Approver

  As a RDDC User
  I want the activities to be approved by designated Approvers before they are started
  So that I can make sure that the activities are correct before they are started for the third-party

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity

  @C38380701
  @core_regression
  Scenario: C38380701: Activity Information Page - Activity with Approver - Verify Approver Section and its content
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following columns
      | ASSIGNED TO | LAST UPDATE | ACTION | STATUS |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |

  @C38380702
  @core_regression
  Scenario: C38380702: Activity Information Page - Activity with Approver - Only Default Approver Set - Verify Default Approver can approve activity
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action | Status   |
      | Admin_AT_FN Admin_AT_LN |              |        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Approved |

  @C38380703
  Scenario: C38380703: Activity Information Page - Activity with Approver - Only Default Approver Set - Verify Default Approver can reject activity
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
    Then Message is displayed on confirmation window
      | REJECT APPROVER                                        |
      | Are you sure you want to Reject? This cannot be undone |
    And Confirmation button with name Cancel should be displayed
    And Confirmation button with name Proceed should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced | Re-assign for Approval | Rejected |

  @C38380704
  @core_regression
  Scenario: C38380704: Activity Information Page - Activity with Approver - Only Default Approver Set - Verify Default Approver can Re-assign for Approval a rejected activity
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced | Re-assign for Approval | Rejected |
    When Approver clicks "Re-assign for Approval" button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action                  | Status   |
      | Admin_AT_FN Admin_AT_LN |              |                         | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |                         | Rejected |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced | Approve,Reject,Reassign | Pending  |

  @C38380705
  Scenario: C38380705: Activity Information Page - Activity with Approver - Only Default Approver Set - Verify Default Approver can reassign activity
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Reassign" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action | Status                 |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Pending                |
      |                         |              |        | Pending for Assignment |
    And Activity Information Approvers drop-down contains 20 active users
    When User assigns approver "Assignee_AT_FN Assignee_AT_LN"
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status     |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                         | Reassigned |
      | Assignee_AT_FN Assignee_AT_LN |              | Approve,Reject,Reassign | Pending    |
