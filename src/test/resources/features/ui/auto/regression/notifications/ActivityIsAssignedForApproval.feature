@ui @full_regression @notification
Feature: On Screen Notifications - 	Activity is Assigned for Approval

  As an Internal User
  I want to be notified whenever an activity is assigned to me for approval
  So that I won't miss the task and halt the progress of the activity

  @C35997344
  @onlySingleThread
  @core_regression
  Scenario: C35997344: Third-party Onboarding - Request for Approval Screen Notification - New Activity assigned to a User for Approval is Triggered
    Given User logs into RDDC as "Admin"
    And User creates third-party "workflowGroupUkraineIndividualWithApprover"
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks Start Onboarding for third-party
    When User navigates to Home page
    Then Notification Bell Icon contains 1 new notification
    When User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    And "Activity to Approve" notification displayed with text
      | OrderDueDiligenceReport |
    When User clicks "Activity to Approve" "OrderDueDiligenceReport" notification
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description | Order Details                  | Due Date | Assignee                | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | description | ORDER DETAILS: NO ORDER PLACED | TODAY+1  | Admin_AT_FN Admin_AT_LN | Not Started |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |

  @C35997362
  @core_regression
  Scenario: C35997362: Third-party Onboarding - Request for Approval Screen Notification - Activity is reassigned to user for Approval
    Given User logs into RDDC as "Admin"
    And User creates third-party "workflowGroupUkraineIndividualWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    When User clicks "Reassign" approve action button for "Admin_AT_FN Admin_AT_LN" user
    And User assigns approver "Assignee_AT_FN Assignee_AT_LN"
    And User logs into RDDC as "Assignee"
    Then Notification Bell Icon contains at least 1 new notification
    When User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    And "Activity to Approve" notification displayed with text
      | OrderDueDiligenceReport |
    When User clicks "Activity to Approve" "OrderDueDiligenceReport" notification
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description | Order Details                  | Due Date | Assignee                | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | description | ORDER DETAILS: NO ORDER PLACED | TODAY+1  | Admin_AT_FN Admin_AT_LN | Not Started |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update  | Action                  | Status     |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                         | Reassigned |
      | Assignee_AT_FN Assignee_AT_LN |              | Approve,Reject,Reassign | Pending    |

  @C35997469
  @onlySingleThread
  Scenario: C35997469: Supplier Onboarding - Request for Approval Screen Notification - 404 error
    Given User logs into RDDC as "Admin"
    And User creates third-party "workflowGroupUkraineIndividualWithApprover"
    And User clicks Start Onboarding for third-party
    And User navigates to Home page
    And User clicks Notification Bell
    Then "Activity to Approve" notification displayed with text
      | OrderDueDiligenceReport |
    When User clicks Notification Bell
    And User opens previously created Third-party
    And User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User navigates to Home page
    And User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    When User clicks "Activity to Approve" "OrderDueDiligenceReport" notification
    Then User is redirected to page 404
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks "Reassign" approve action button for "Admin_AT_FN Admin_AT_LN" user
    And User assigns approver "Assignee_AT_FN Assignee_AT_LN"
    And User logs into RDDC as "Assignee"
    And User navigates to Home page
    And User clicks Notification Bell
    Then "Activity to Approve" notification displayed with text
      | OrderDueDiligenceReport |
    When User clicks Notification Bell
    And User opens previously created Third-party
    And User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User navigates to Home page
    And User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    When User clicks "Activity to Approve" "OrderDueDiligenceReport" notification
    Then User is redirected to page 404
