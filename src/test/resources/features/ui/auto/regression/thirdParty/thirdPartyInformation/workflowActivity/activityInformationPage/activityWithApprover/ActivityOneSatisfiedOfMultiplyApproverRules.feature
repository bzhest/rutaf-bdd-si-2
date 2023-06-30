@ui @full_regression @react @activity_approver
Feature: Activity Information Page - Multiple Approver Rules But One Rule Is Satisfied

  As a RDDC User
  I want the activities to be approved by designated Approvers before they are started
  So that I can make sure that the activities are correct before they are started for the third-party

  Background:
    Given User logs into RDDC as "Assignee"
    When User creates third-party "belizeWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "TwoApprovalRulesSatisfiedInSequence" activity

  @C38380706
  @core_regression
  Scenario: C38380706: Activity Information Page - Activity with Approver - Multiple Approver Rules set but only one rule is satisfied - Verify approver rule can approve activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update | Action                  | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Approve,Reject,Reassign | Pending |
    And Activity Information Approvers table does not contain the following approvers
      | Assigned To                                                     | Last Update | Action                  | Status  |
      | Autouser_With_Restrictions Autouser_With_Restrictions_Last_Name |             | Approve,Reject,Reassign | Pending |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN                   |             | Approve,Reject,Reassign | Pending |
    When Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Approved |

  @C38380707
  Scenario: C38380707: Activity Information Page - Activity with Approver - Multiple Approver Rules set but only one rule is satisfied - Verify approver rule can reject activity
    When Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Reject" button
    Then Message is displayed on confirmation window
      | REJECT APPROVER                                        |
      | Are you sure you want to Reject? This cannot be undone |
    And Confirmation button with name Cancel should be displayed
    And Confirmation button with name Proceed should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update | Action                  | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Approve,Reject,Reassign | Pending |
    When Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |                        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced | Re-assign for Approval | Rejected |

  @C38380708
  @core_regression
  Scenario: C38380708: Activity Information Page - Activity with Approver - Multiple Approver Rules set but only one rule is satisfied - Verify approver rule can re-assign for approval a rejected activity
    When Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |                        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced | Re-assign for Approval | Rejected |
    When Approver clicks "Re-assign for Approval" button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |                         | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |                         | Rejected |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced | Approve,Reject,Reassign | Pending  |

  @C38380709
  Scenario: C38380709: Activity Information Page - Activity with Approver - Multiple Approver Rules set but only one rule is satisfied - Verify approver rule can reassign activity
    When Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Reassign" button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action | Status                 |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Pending                |
      |                               |              |        | Pending for Assignment |
    And Activity Information Approvers drop-down contains 20 active users
    When User assigns approver "Admin_AT_FN Admin_AT_LN"
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status     |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |                         | Reassigned |
      | Admin_AT_FN Admin_AT_LN       |              | Approve,Reject,Reassign | Pending    |

  @C38380718
  @RMS-32155
  @core_regression
  Scenario: C38380718: Activity Information Page - Activity with Approver - Verify assessment and status is enabled once activity is approved
    Given The test is Blocked due to the issue: "RMS-32155"
    When User clicks Back button to return from Activity modal
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    And User approves all activities
    And User clicks Edit button for Activity
    Then Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Done        |
    When User selects activity status "Done"
    Then Activity Assessment drop-down contains all "World Check Screening" activity assessments
