@ui @full_regression @core_regression @react @activity_with_reviewer
Feature: Activity Information Page - Activity with Multiple Reviewers Rules

  As a RDDC user
  I want the activities to be reviewed by designated Reviewer before the activities is completed
  So that I could ensure that the correct activity was performed and was done properly

  @C38383273
  Scenario: C38383273: Activity Information Page - Activity with Reviewer - Verify status changed to Completed once activity is reviewed
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "Assignee_AT_FN Assignee_AT_LN"
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Review" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Reviewed |
    And Activity Information Status is displayed with "Completed"

  @C38383274
  @onlySingleThread
  @email
  Scenario: C38383274: Activity Information Page - Activity with Reviewer - Verify email and onscreen notification of the Request for Review is received by the reviewer
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "Assignee_AT_FN Assignee_AT_LN"
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "Assignee"
    And User clicks Notification Bell
    Then The list with notifications is shown
    And "Activity to Review" notification displayed with text
      | Assessment Activity |
    When User clicks "Activity to Review" "Assessment Activity" notification
    Then Activity Information page is displayed
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    And Email notification "Refinitiv Due Diligence Centre - Activity: Assessment Activity Request for Review" is received by "Assignee" user

  @C38531596
  @onlySingleThread
  Scenario: C38531596: Activity Information Page - Activity with Reviewer - Verify landing page if activity is no longer existing
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "Assignee_AT_FN Assignee_AT_LN"
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks "Stop Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User logs into RDDC as "Assignee"
    And User clicks Notification Bell
    Then The list with notifications is shown
    And "Activity to Review" notification displayed with text
      | Assessment Activity |
    When User clicks "Activity to Review" "Assessment Activity" notification
    Then User is redirected to page 404

  @C38531597
  Scenario: C38531597: Activity Information Page - Activity with Reviewer - Branching - Verify next activity is triggered once activity is completed
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Ukraine"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User updates Component Name "AUTO_TEST_0"
    And User clicks Check button
    And User adds new Activity "Auto Activity" with "Assessment Activity" data with Reviewer "Assignee_AT_FN Assignee_AT_LN"
    And User adds 1 components with "Approve Onboarding Activity" activity
    And User clicks workflow button "GROUPING"
    Then Workflow Grouping page is displayed
    When User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 1
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "AUTO_TEST_0" component tab
    And User clicks on "Auto Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks "AUTO_TEST_1" component tab
    Then Component Activity "Approve Onboarding" is disabled
    When User clicks "AUTO_TEST_0" component tab
    And User clicks on "Auto Activity" activity
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Review" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Activity Information Status is displayed with "Completed"
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Reviewed |
    When User opens previously created Third-party
    And User clicks "AUTO_TEST_1" component tab
    Then Component Activity "Approve Onboarding" is enabled
    When User clicks on "Approve Onboarding" activity
    Then Activity Information page is displayed
