@ui @core_regression @activity_approver
Feature: Activity Information Page - Approval Section

  As a user
  I want to approve or reject the activity
  So that I could approve or reject the activity I got assigned

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party

  @C50731779
  Scenario: C50731779: Activity Information Page - Activity with Approver - Verify that Approvers section is only enabled to activity approver
    When User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Admin_AT_FN Admin_AT_LN" are enabled

  @C50731834
  Scenario: C50731834: Activity Information Page - Activity with Approver - Verify that Approvers section is enabled to user with System Admin role
    When User logs into RDDC as "Assignee"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Admin_AT_FN Admin_AT_LN" are enabled

  @C50731839
  Scenario: C50731839: Activity Information Page - Activity with Approver - Verify that Approvers section is disabled to user not the activity approver nor has System Admin role
    When User logs into RDDC as "second with edit permissions"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information "Approvers" section is expanded
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |
    And All action buttons for Activity approver "Admin_AT_FN Admin_AT_LN" are disabled