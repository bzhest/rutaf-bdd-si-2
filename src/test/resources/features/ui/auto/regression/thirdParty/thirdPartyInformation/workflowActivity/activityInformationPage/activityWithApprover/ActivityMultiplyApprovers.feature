@ui @full_regression @react @activity_approver
Feature: Activity Information Page - Approver Rules with Multiple Approvers

  As a RDDC User
  I want the activities to be approved by designated Approvers before they are started
  So that I can make sure that the activities are correct before they are started for the third-party


  @C38620049
  @core_regression
  Scenario: C38620049: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ALL' - Verify approver rule can approve activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "Aruba country with Approver" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Approve,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are enabled
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                         | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                         | Approved |
      | Assignee_AT_FN Assignee_AT_LN |              | Approve,Reject,Reassign | Pending  |
    When Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |        | Approved |
      | Assignee_AT_FN Assignee_AT_LN |              |        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Approved |

  @C38620051
  Scenario: C38620051: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ALL' - Verify approver rule can reject activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "Aruba country with Approver" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "OneSatisfiedApprovalRule" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
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
      | Admin_AT_FN Admin_AT_LN       |             | Approve,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Approve,Reject,Reassign | Pending |
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                         | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Re-assign for Approval  | Rejected |
      | Assignee_AT_FN Assignee_AT_LN |              | Approve,Reject,Reassign | Pending  |
    When Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Re-assign for Approval | Rejected |
      | Assignee_AT_FN Assignee_AT_LN |              |                        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced | Re-assign for Approval | Rejected |

  @C38620054
  Scenario: C38620054: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ALL' - Verify approver rule can re-assign for approval a rejected activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "Aruba country with Approver" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                         | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Re-assign for Approval  | Rejected |
      | Assignee_AT_FN Assignee_AT_LN |              | Approve,Reject,Reassign | Pending  |
    When Approver clicks "Re-assign for Approval" button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                         | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                         | Rejected |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Approve,Reject,Reassign | Pending  |
      | Assignee_AT_FN Assignee_AT_LN |              | Approve,Reject,Reassign | Pending  |

  @C38620152
  @core_regression
  Scenario: C38620152: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ALL' - Verify approver rule can reassign activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "Aruba country with Approver" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Reassign" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status                 |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                         | Pending                |
      |                               |              |                         | Pending for Assignment |
      | Assignee_AT_FN Assignee_AT_LN |              | Approve,Reject,Reassign | Pending                |
    And Activity Information Approvers drop-down contains 20 active users
    When User assigns approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN"
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                   | Last Update  | Action                  | Status     |
      | Admin_AT_FN Admin_AT_LN                       | toBeReplaced |                         | Reassigned |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN |              | Approve,Reject,Reassign | Pending    |
      | Assignee_AT_FN Assignee_AT_LN                 |              | Approve,Reject,Reassign | Pending    |
    When Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Reassign" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                   | Last Update  | Action                  | Status                 |
      | Admin_AT_FN Admin_AT_LN                       | toBeReplaced |                         | Reassigned             |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN |              | Approve,Reject,Reassign | Pending                |
      | Assignee_AT_FN Assignee_AT_LN                 | toBeReplaced |                         | Pending                |
      |                                               |              |                         | Pending for Assignment |
    And Activity Information Approvers drop-down contains 20 active users
    When User assigns approver "Admin_AT_FN Admin_AT_LN"
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                   | Last Update  | Action                  | Status     |
      | Admin_AT_FN Admin_AT_LN                       | toBeReplaced |                         | Reassigned |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN |              | Approve,Reject,Reassign | Pending    |
      | Assignee_AT_FN Assignee_AT_LN                 | toBeReplaced |                         | Reassigned |
      | Admin_AT_FN Admin_AT_LN                       |              | Approve,Reject,Reassign | Pending    |

  @C38620048
  @core_regression
  Scenario: C38620048: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method ' IN SEQUENCE' - Verify approver rule can approve activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupOrganizationWithApproverWithIndustryType" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Approve,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are disabled
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                         | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                         | Approved |
      | Assignee_AT_FN Assignee_AT_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are enabled
    When Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |        | Approved |
      | Assignee_AT_FN Assignee_AT_LN |              |        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Approved |

  @C38620050
  Scenario: C38620050: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method ' IN SEQUENCE' - Verify approver rule can reject activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupOrganizationWithApproverWithIndustryType" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
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
      | Admin_AT_FN Admin_AT_LN       |             | Approve,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are disabled
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                         | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Re-assign for Approval  | Rejected |
      | Assignee_AT_FN Assignee_AT_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are disabled

  @C38620410
  Scenario: C38620410: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method ' IN SEQUENCE' - Verify approver rule can re-assign for approval a rejected activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupOrganizationWithApproverWithIndustryType" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                         | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Re-assign for Approval  | Rejected |
      | Assignee_AT_FN Assignee_AT_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are disabled
    When Approver clicks "Re-assign for Approval" button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                         | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                         | Rejected |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Approve,Reject,Reassign | Pending  |
      | Assignee_AT_FN Assignee_AT_LN |              | Approve,Reject,Reassign | Pending  |

  @C38620411
  Scenario: C38620411: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method ' IN SEQUENCE - Verify approver rule can reassign activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupOrganizationWithApproverWithIndustryType" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Reassign" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status                 |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                         | Pending                |
      |                               |              |                         | Pending for Assignment |
      | Assignee_AT_FN Assignee_AT_LN |              | Approve,Reject,Reassign | Pending                |
    And Activity Information Approvers drop-down contains 20 active users
    When User assigns approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN"
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                   | Last Update  | Action                  | Status     |
      | Admin_AT_FN Admin_AT_LN                       | toBeReplaced |                         | Reassigned |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN |              | Approve,Reject,Reassign | Pending    |
      | Assignee_AT_FN Assignee_AT_LN                 |              | Approve,Reject,Reassign | Pending    |
    And All action buttons for Activity approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" are enabled
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are disabled

  @C38620047
  @core_regression
  Scenario: C38620047: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ANY' - Verify approver rule can approve activity
    Given User logs into RDDC as "Approver"
    When User creates third-party "workflowGroupAfghanistanOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                   | Last Update | Action                  | Status  |
      | Assignee_AT_FN Assignee_AT_LN                 |             | Approve,Reject,Reassign | Pending |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Assignee_AT_FN Assignee_AT_LN" are enabled
    And All action buttons for Activity approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" are enabled
    When Approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" clicks "Approve" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                   | Last Update  | Action | Status   |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN |              |        | Pending  |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN | toBeReplaced |        | Approved |
    And Activity Information Approvers table does not contain the following approvers
      | Assigned To                   | Last Update | Action                  | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Approve,Reject,Reassign | Pending |

  @C38620052
  Scenario: C38620052: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ANY' - Verify approver rule can reject activity
    Given User logs into RDDC as "Assignee"
    When User creates third-party "workflowGroupAfghanistanOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Reject" button
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
      | Assigned To                                   | Last Update  | Action                  | Status   |
      | Assignee_AT_FN Assignee_AT_LN                 |              |                         | Pending  |
      | Assignee_AT_FN Assignee_AT_LN                 | toBeReplaced | Re-assign for Approval  | Rejected |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" are enabled

  @C38620445
  Scenario: C38620445: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ANY - Verify approver rule can re-assign for approval a rejected activity
    Given User logs into RDDC as "Assignee"
    When User creates third-party "workflowGroupAfghanistanOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    And Confirmation window is disappeared
    And Activity Information page is displayed
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                   | Last Update  | Action                  | Status   |
      | Assignee_AT_FN Assignee_AT_LN                 |              |                         | Pending  |
      | Assignee_AT_FN Assignee_AT_LN                 | toBeReplaced | Re-assign for Approval  | Rejected |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN |              | Approve,Reject,Reassign | Pending  |
    When Approver clicks "Re-assign for Approval" button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                   | Last Update  | Action                  | Status   |
      | Assignee_AT_FN Assignee_AT_LN                 |              |                         | Pending  |
      | Assignee_AT_FN Assignee_AT_LN                 | toBeReplaced |                         | Rejected |
      | Assignee_AT_FN Assignee_AT_LN                 | toBeReplaced | Approve,Reject,Reassign | Pending  |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN |              | Approve,Reject,Reassign | Pending  |
    And All action buttons for Activity approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" are enabled

  @C38620446
  Scenario: C38620446: Activity Information Page - Activity with Approver - Approver Rules with Multiple Approvers using method 'ANY' - Verify approver rule can reassign activity
    Given User logs into RDDC as "Approver"
    When User creates third-party "workflowGroupAfghanistanOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" clicks "Reassign" button
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                   | Last Update  | Action                  | Status                 |
      | Assignee_AT_FN Assignee_AT_LN                 |              | Approve,Reject,Reassign | Pending                |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN | toBeReplaced |                         | Pending                |
      |                                               |              |                         | Pending for Assignment |
    And Activity Information Approvers drop-down contains 20 active users
    When User assigns approver "Admin_AT_FN Admin_AT_LN"
    Then Alert Icon is displayed with text
      | Success! Activity has been updated |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                                   | Last Update  | Action                  | Status     |
      | Assignee_AT_FN Assignee_AT_LN                 |              | Approve,Reject,Reassign | Pending    |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN | toBeReplaced |                         | Reassigned |
      | Admin_AT_FN Admin_AT_LN                       |              | Approve,Reject,Reassign | Pending    |
