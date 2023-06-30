@ui @core_regression @activity_with_reviewer
Feature: Activity Information Page - Reviewer Section

  As a user
  I want to approve or reject the activity
  So that I could approve or reject the activity I got assigned

  Background:
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "Admin_AT_FN Admin_AT_LN"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button

  @C50732169
  Scenario: C50732169: Activity Information Page - Activity with Reviewer - Verify that Reviewers section is only enabled to activity reviewer
    When User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled

  @C50732170
  Scenario: C50732170: Activity Information Page - Activity with Reviewer - Verify that Reviewers section is enabled to user with System Admin role
    When User logs into RDDC as "Assignee"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled

  @C50732171
  Scenario: C50732171: Activity Information Page - Activity with Reviewer - Verify that Reviewers section is disabled to user not the activity reviewer nor has System Admin role
    When User logs into RDDC as "second with edit permissions"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are disabled