@ui @full_regression @core_regression @react @activity_approver
Feature: Activity Information Page - Activity with Approver Notification

  As a RDDC User
  I want the activities to be approved by designated Approvers before they are started
  So that I can make sure that the activities are correct before they are started for the third-party


  @C38380719
  @email
  Scenario: C38380719: Activity Information Page - Activity with Approver - Verify email and onscreen notification of the Activity Assigned is received by the assignee once activity is approved
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User refreshes page
    And User clicks Notification Bell
    Then "Activity has been Assigned" notification displayed with text
      | OrderDueDiligenceReport |
    When User clicks "Activity has been Assigned" "OrderDueDiligenceReport" notification
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Order Details                  | Due Date | Assignee                | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | ORDER DETAILS: NO ORDER PLACED | TODAY+1  | Admin_AT_FN Admin_AT_LN | Not Started |
    And Email notification "Request for Approval" with following values is received by "Admin" user
      | <Activity_Name> | OrderDueDiligenceReport |

  @C38380720
  @email
  Scenario: C38380720: Activity Information Page - Activity with Approver - Verify email and onscreen notification of the Request for Approval is received by the approver
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User refreshes page
    And User clicks Notification Bell
    Then "Activity to Approve" notification displayed with text
      | OrderDueDiligenceReport |
    When User clicks "Activity to Approve" "OrderDueDiligenceReport" notification
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description | Order Details                  | Due Date | Assignee                | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | description | ORDER DETAILS: NO ORDER PLACED | TODAY+1  | Admin_AT_FN Admin_AT_LN | Not Started |
    And Email notification "Request for Approval" with following values is received by "Admin" user
      | <Activity_Name> | OrderDueDiligenceReport |