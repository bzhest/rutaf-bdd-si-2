@ui @full_regression @react @activity_approver
Feature: Activity Information Page - Multiple Approver Rules But No Rule Is Satisfied

  As a RDDC User
  I want the activities to be approved by designated Approvers before they are started
  So that I can make sure that the activities are correct before they are started for the third-party

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "Aruba country with Approver" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "TwoApprovalRulesSatisfiedInSequence" activity

  @C38380714
  Scenario: C38380714: Activity Information Page - Activity with Approver - Multiple Approver Rules Set but no rule is satisfied - Verify default approver can approve activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |
    And Activity Information Approvers table does not contain the following approvers
      | Assigned To                                                     | Last Update | Action                  | Status  |
      | Assignee_AT_FN Assignee_AT_LN                                   |             | Approve,Reject,Reassign | Pending |
      | Autouser_With_Restrictions Autouser_With_Restrictions_Last_Name |             | Approve,Reject,Reassign | Pending |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN                   |             | Approve,Reject,Reassign | Pending |
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action | Status   |
      | Admin_AT_FN Admin_AT_LN |              |        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Approved |

  @C38380715
  Scenario: C38380715: Activity Information Page - Activity with Approver - Multiple Approver Rules Set but no rule is satisfied - Verify default approver can reject activity
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

  @C38380716
  Scenario: C38380716: Activity Information Page - Activity with Approver - Multiple Approver Rules Set but no rule is satisfied - Verify default approver can re-assign for approval a rejected activity
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Activity Information Approvers table should contain the following approvers
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

  @C38380717
  Scenario: C38380717: Activity Information Page - Activity with Approver - Multiple Approver Rules Set but no rule is satisfied - Verify default approver can reassign activity
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Reassign" button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
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
