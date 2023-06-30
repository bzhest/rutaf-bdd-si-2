@ui @full_regression @react @activity_approver
Feature: Activity Information Page - Approver Rules with Multiple Approvers

  As a RDDC User
  I want the activities to be approved by designated Approvers before they are started
  So that I can make sure that the activities are correct before they are started for the third-party

  @C43652631
  @core_regression
  Scenario: C43652631: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ALL' - Verify approver rule can approve OWN activity only
    Given User logs into RDDC as "Admin"
    When User creates third-party "Cape Verde country with Approver" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update | Action                  | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Approve,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When Approver "Autouser_Edit_FN Autouser_Edit_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                         | Approved |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When Approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |        | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |        | Approved |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |        | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |        | Approved |

  @C43629209
  Scenario: C43629209: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ALL'  - Verify approver rule can reject OWN activity only
    Given User logs into RDDC as "Admin"
    When User creates third-party "Cape Verde country with Approver" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    And Approver "Autouser_Edit_FN Autouser_Edit_LN" clicks "Reject" button
    Then Message is displayed on confirmation window
      | REJECT APPROVER                                        |
      | Are you sure you want to Reject? This cannot be undone |
    And Confirmation button with name Cancel should be displayed
    And Confirmation button with name Proceed should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update | Action                  | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Approve,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When Approver "Autouser_Edit_FN Autouser_Edit_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced | Re-assign for Approval  | Rejected |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    Then All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When Approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                 | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                        | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced | Re-assign for Approval | Rejected |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |                        | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced | Re-assign for Approval | Rejected |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled

  @C43629407
  Scenario: C43629407: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ALL'  - Verify only the approver rule can  re-assign for approval a rejected activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "Fiji country with Approver" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    And Approver "Autouser_Edit_FN Autouser_Edit_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Activity Information page is displayed
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                       | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced | Re-assign for Approval  | Rejected |
      | Assignee_AT_FN Assignee_AT_LN     |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are disabled
    When User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                       | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced | Re-assign for Approval  | Rejected |
      | Assignee_AT_FN Assignee_AT_LN     |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are disabled
    When Approver clicks "Re-assign for Approval" button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                       | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced |                         | Rejected |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced | Approve,Reject,Reassign | Pending  |
      | Assignee_AT_FN Assignee_AT_LN     |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are disabled

  @C43629498 @C43653555
    @core_regression
  Scenario Outline: C43629498, C43653555: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ALL/ANY'  - Verify approver rule can reassign OWN activity only
    Given User logs into RDDC as "Admin"
    When User creates third-party "<thirdParty>" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "<componentName>" component tab
    And User clicks on "<activityName>" activity
    And Approver "Autouser_Edit_FN Autouser_Edit_LN" clicks "Reassign" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status                 |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                         | Pending                |
      |                                                 |              |                         | Pending for Assignment |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending                |
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    And Activity Information Approvers drop-down contains 20 active users
    When User assigns approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN"
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status     |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                         | Reassigned |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN   |              | Approve,Reject,Reassign | Pending    |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending    |
    And All action buttons for Activity approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" are disabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "<componentName>" component tab
    And User clicks on "<activityName>" activity
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status     |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                         | Reassigned |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN   |              | Approve,Reject,Reassign | Pending    |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending    |
    And All action buttons for Activity approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" are disabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When Approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" clicks "Reassign" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status                 |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                         | Reassigned             |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN   |              | Approve,Reject,Reassign | Pending                |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |                         | Pending                |
      |                                                 |              |                         | Pending for Assignment |
    And Activity Information Approvers drop-down contains 20 active users
    When User assigns approver "Admin_AT_FN Admin_AT_LN"
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status     |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                         | Reassigned |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN   |              | Approve,Reject,Reassign | Pending    |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |                         | Reassigned |
      | Admin_AT_FN Admin_AT_LN                         |              | Approve,Reject,Reassign | Pending    |
    And All action buttons for Activity approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" are disabled
    And All action buttons for Activity approver "Admin_AT_FN Admin_AT_LN" are disabled
    Examples:
      | thirdParty                                   | componentName              | activityName             |
      | Cape Verde country with Approver             | New Component              | OneSatisfiedApprovalRule |
      | workflowGroupMyanmarOrganizationWithApprover | Auto Test Custom Component | OrderDueDiligenceReport  |

  @C43630296
  @core_regression
  Scenario: C43630296: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method ' IN SEQUENCE' - Verify approver rule can approve OWN activity only
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupOrganizationWithApproverWithBIOIndustryType" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update | Action                  | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Approve,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update | Action                  | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Approve,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When Approver "Autouser_Edit_FN Autouser_Edit_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                         | Approved |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                         | Approved |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When Approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |        | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |        | Approved |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |        | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |        | Approved |

  @C43652272
  Scenario: C43652272: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method ' IN SEQUENCE' - Verify approver rule can reject OWN activity only
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupOrganizationWithApproverWithBIOIndustryType" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update | Action                  | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Approve,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update | Action                  | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Approve,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When Approver "Autouser_Edit_FN Autouser_Edit_LN" clicks "Reject" button
    Then Message is displayed on confirmation window
      | REJECT APPROVER                                        |
      | Are you sure you want to Reject? This cannot be undone |
    And Confirmation button with name Cancel should be displayed
    And Confirmation button with name Proceed should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update | Action                  | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Approve,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When Approver "Autouser_Edit_FN Autouser_Edit_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced | Re-assign for Approval  | Rejected |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced | Re-assign for Approval  | Rejected |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled

  @C43652273
  Scenario: C43652273: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method ' IN SEQUENCE' - Verify only the approver rule can re-assign for approval a rejected activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupOrganizationWithApproverWithBIOIndustryType" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    When Approver "Autouser_Edit_FN Autouser_Edit_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Confirmation window is disappeared
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced | Re-assign for Approval  | Rejected |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced | Re-assign for Approval  | Rejected |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When Approver clicks "Re-assign for Approval" button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                         | Rejected |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced | Approve,Reject,Reassign | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled

  @C43652388
  Scenario: C43652388: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method ' IN SEQUENCE - Verify approver rule can reassign OWN activity only
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupOrganizationWithApproverWithBIOIndustryType" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Autouser_Edit_FN Autouser_Edit_LN" clicks "Reassign" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status                 |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                         | Pending                |
      |                                                 |              |                         | Pending for Assignment |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending                |
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    And Activity Information Approvers drop-down contains 20 active users
    When User assigns approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN"
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status     |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                         | Reassigned |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN   |              | Approve,Reject,Reassign | Pending    |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending    |
    And All action buttons for Activity approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" are disabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status     |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                         | Reassigned |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN   |              | Approve,Reject,Reassign | Pending    |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Approve,Reject,Reassign | Pending    |
    And All action buttons for Activity approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" are disabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled

  @C43652648
  @core_regression
  Scenario: C43652648: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ANY' - Verify approver rule can approve OWN activity only
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupMyanmarOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update | Action                  | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Approve,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update | Action                  | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Approve,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When Approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action | Status   |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |        | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |        | Approved |
    And Activity Information Approvers table does not contain the following approvers
      | Assigned To                       | Last Update | Action                  | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN |             | Approve,Reject,Reassign | Pending |

  @C43652653
  Scenario: C43652653: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ANY'  - Verify approver rule can reject OWN activity only
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupMyanmarOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update | Action                  | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Approve,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update | Action                  | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Approve,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When Approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" clicks "Reject" button
    Then Message is displayed on confirmation window
      | REJECT APPROVER                                        |
      | Are you sure you want to Reject? This cannot be undone |
    And Confirmation button with name Cancel should be displayed
    And Confirmation button with name Proceed should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update | Action                  | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Approve,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When Approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                     | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              | Approve,Reject,Reassign | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |                         | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced | Re-assign for Approval  | Rejected |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity approver "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled

  @C43652654
  Scenario: C43652654: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ANY - Verify only the approver rule can re-assign for approval a rejected activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupThailandOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Autouser_Edit_FN Autouser_Edit_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                       | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced | Re-assign for Approval  | Rejected |
      | Assignee_AT_FN Assignee_AT_LN     |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are disabled
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                       | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced | Re-assign for Approval  | Rejected |
      | Assignee_AT_FN Assignee_AT_LN     |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are disabled
    When User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                       | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced | Re-assign for Approval  | Rejected |
      | Assignee_AT_FN Assignee_AT_LN     |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are disabled
    When Approver clicks "Re-assign for Approval" button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                       | Last Update  | Action                  | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN |              |                         | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced |                         | Rejected |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced | Approve,Reject,Reassign | Pending  |
      | Assignee_AT_FN Assignee_AT_LN     |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are disabled
