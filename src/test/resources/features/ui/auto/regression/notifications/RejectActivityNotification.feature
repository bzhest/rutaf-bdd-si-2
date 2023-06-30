@ui @full_regression @notification
Feature: On Screen Notifications - Reject Activity

  As a Responsible Party of a Supplier Being Onboarded
  I want to be notified whenever an activity is Rejected by an Approver
  So that I will be updated and I can manage the next steps

  @C36105765
  @core_regression
  @onlySingleThread
  Scenario: C36105765: Supplier Onboarding - Activity Rejected Screen Notification
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineIndividualWithApprover"
    And User clicks Start Onboarding for third-party
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information page is displayed
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
    And User clicks Reject button on confirmation window
    Then Confirmation window is disappeared
    And Activity Information page is displayed
    When User navigates to Home page
    Then Notification Bell Icon contains 1 new notification
    When User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    And "Activity has been Rejected" notification displayed with text
      | OrderDueDiligenceReport |
    When User clicks "Activity has been Rejected" "OrderDueDiligenceReport" notification
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description | Order Details                  | Due Date | Assignee                | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | description | ORDER DETAILS: NO ORDER PLACED | TODAY+1  | Admin_AT_FN Admin_AT_LN | Not Started |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced | Re-assign for Approval | Rejected |

  @C36106087
  Scenario: C36106087: Supplier Onboarding - Activity Rejected Screen Notification - 404 error
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupWithApproverAndResponsibleParty"
    And User clicks Start Onboarding for third-party
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
    And User clicks Reject button on confirmation window
    Then Confirmation window is disappeared
    When User logs into RDDC as "Assignee"
    And User clicks Notification Bell
    Then "Activity has been Rejected" notification displayed with text
      | OrderDueDiligenceReport |
    When User opens previously created Third-party
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User navigates to Home page
    And User clicks Notification Bell
    And User clicks "Activity has been Rejected" "OrderDueDiligenceReport" notification
    Then User is redirected to page 404