@ui @full_regression @notification
Feature: On Screen Notifications - Request for Review

  As an Internal User
  I want to be notified whenever an activity is assigned to me for review
  So that I won't miss the task and halt the onboarding process

  @C36050610
  @onlySingleThread
  @core_regression
  Scenario: C36050610: Supplier Onboarding - Request for Review Screen Notification - Activity Review is reassigned to another User
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Ukraine"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks +Add Activity button
    And User fills in Activity "Request for Due Diligence Activity" details
    And User clicks Activity "Add Reviewer" tab
    And User selects "Admin_AT_FN Admin_AT_LN" value for Default Reviewer
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group Ukraine"
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User navigates to Home page
    And User clicks Notification Bell
    Then The list with notifications is shown
    And "Activity to Review" notification displayed with text
      | Request for Due Diligence |
    When User clicks "Activity to Review" "Request for Due Diligence" notification
    Then Activity Information page is displayed
    When User clicks "Reassign" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User selects "Assignee_AT_FN Assignee_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status     |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                        | Reassigned |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending    |
    When User logs into RDDC as "Assignee"
    Then Notification Bell Icon contains at least 1 new notification
    When User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    And "Activity to Review" notification displayed with text
      | Request for Due Diligence |
    When User clicks "Activity to Review" "Request for Due Diligence" notification
    Then Activity Information modal is displayed with details
      | Activity Type                      | Activity Name             | Description               | Due Date | Assignee                      | Status |
      | Request for Due Diligence Activity | Request for Due Diligence | Request for Due Diligence | TODAY+1  | Assignee_AT_FN Assignee_AT_LN | Done   |
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status     |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                        | Reassigned |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending    |

  @C36052102
  @onlySingleThread
  @core_regression
  Scenario: C36052102: Risk Management Overview - Request for Review Screen Notification - Ad Hoc Activity with a Reviewer is set to DONE
    Given User logs into RDDC as "Assignee"
    When User creates third-party "with random ID name"
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Done button in Activity Reviewers section
    And User clicks Back button to return from Activity modal
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User refreshes page
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks 'Save' activity button
    And User navigates to Home page
    Then Notification Bell Icon contains 1 new notification
    When User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    And "Activity to Review" notification displayed with text
      | AUTO_TEST_ACTIVITY_NAME |
    When User clicks "Activity to Review" "AUTO_TEST_ACTIVITY_NAME" notification
    Then Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Assignee                | Status |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   |
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |

  @C36099380
  @onlySingleThread
  @core_regression
  Scenario: C36099380: Risk Management Overview - Request for Review Screen Notification - Ad Hoc Activity Review is Reassigned to a new Reviewer
    Given User logs into RDDC as "Assignee"
    When User creates third-party "with random ID name" via API and open it
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Done button in Activity Reviewers section
    And User clicks Back button to return from Activity modal
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User navigates to Home page
    And User clicks Notification Bell
    And User clicks "Activity to Review" "AUTO_TEST_ACTIVITY_NAME" notification
    Then Activity Information page is displayed
    When User clicks "Reassign" review Ad Hoc action button for "Assignee_AT_FN Assignee_AT_LN" user
    And User selects "Admin_AT_FN Admin_AT_LN" reviewer user
    When User logs into RDDC as "Admin"
    Then Home page is loaded
    And Notification Bell Icon contains at least 1 new notification
    When User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    And "Activity to Review" notification displayed with text
      | AUTO_TEST_ACTIVITY_NAME |
    When User clicks "Activity to Review" "AUTO_TEST_ACTIVITY_NAME" notification
    Then Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Assignee                | Status |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   |
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status     |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |                        | Reassigned |
      | Admin_AT_FN Admin_AT_LN       |              | Review,Reject,Reassign | Pending    |

  @C36050533
  Scenario: C36050533: Supplier Onboarding - Request for Review Screen Notification -  Activity pre-assigned to a User for Review is set to DONE
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks +Add Activity button
    And User fills in Activity "Request for Due Diligence Activity" details
    And User clicks Activity "Add Reviewer" tab
    And User selects "Admin_double_AT_FN Admin_double_AT_LN" value for Default Reviewer
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "admin double"
    And User clicks Notification Bell
    Then "Activity to Review" notification displayed with text
      | Request for Due Diligence |
    When User clicks "Activity to Review" "Request for Due Diligence" notification
    Then Activity Information modal is displayed with details
      | Activity Type                      | Activity Name             | Description               | Due Date | Assignee                      | Status |
      | Request for Due Diligence Activity | Request for Due Diligence | Request for Due Diligence | TODAY+1  | Assignee_AT_FN Assignee_AT_LN | Done   |
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                           | Last Update | Action                 | Status  |
      | Admin_double_AT_FN Admin_double_AT_LN |             | Review,Reject,Reassign | Pending |

  @C36050639
  @onlySingleThread
  Scenario: C36050639: Supplier Onboarding - Request for Review Screen Notification - 404 error - Activity pre-assigned
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks +Add Activity button
    And User fills in Activity "Request for Due Diligence Activity" details
    And User clicks Activity "Add Reviewer" tab
    And User selects "Admin_double_AT_FN Admin_double_AT_LN" value for Default Reviewer
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks "Stop Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User logs into RDDC as "admin double"
    And User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And "Activity to Review" notification displayed with text
      | Request for Due Diligence |
    When User clicks "Activity to Review" "Request for Due Diligence" notification
    Then User is redirected to page 404

  @C36050639
  @onlySingleThread
  Scenario: C36050639: Supplier Onboarding - Request for Review Screen Notification - 404 error - Activity Review is reassigned
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks +Add Activity button
    And User fills in Activity "Request for Due Diligence Activity" details
    And User clicks Activity "Add Reviewer" tab
    And User selects "Admin_AT_FN Admin_AT_LN" value for Default Reviewer
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User navigates to Home page
    And User clicks Notification Bell
    Then "Activity to Review" notification displayed with text
      | Request for Due Diligence |
    When User clicks "Activity to Review" "Request for Due Diligence" notification
    Then Activity Information page is displayed
    When User clicks "Reassign" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User selects "Assignee_AT_FN Assignee_AT_LN" reviewer user
    And User opens previously created Third-party
    And User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User logs into RDDC as "Assignee"
    Then Notification Bell Icon contains at least 1 new notification
    When User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    And "Activity to Review" notification displayed with text
      | Request for Due Diligence |
    When User clicks "Activity to Review" "Request for Due Diligence" notification
    Then User is redirected to page 404

  @C36099489
  @onlySingleThread
  Scenario: C36099489: Risk Management Overview - Request for Review Screen Notification - 404 error page when a supplier is deleted - Activity pre-assigned
    Given User logs into RDDC as "Assignee"
    When User creates third-party "with random ID name"
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Done button in Activity Reviewers section
    And User logs into RDDC as "Admin"
    And User clicks Notification Bell
    Then "Activity has been Assigned" notification displayed with text
      | AUTO_TEST_ACTIVITY_NAME |
    When User clicks "Activity has been Assigned" "AUTO_TEST_ACTIVITY_NAME" notification
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User logs into RDDC as "Assignee"
    And User clicks Notification Bell
    Then "Activity to Review" notification displayed with text
      | AUTO_TEST_ACTIVITY_NAME |
    When User navigates to Third-party page
    And User deletes third-party saved in context
    And User clicks Notification Bell
    And User clicks "Activity to Review" "AUTO_TEST_ACTIVITY_NAME" notification
    Then User is redirected to page 404

  @C36099489
  @onlySingleThread
  Scenario: C36099489: Risk Management Overview - Request for Review Screen Notification - 404 error page when a supplier is deleted - Activity reassigned
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name"
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_double_AT_FN Admin_double_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Done button in Activity Reviewers section
    And User logs into RDDC as "admin double"
    And User clicks Notification Bell
    Then "Activity has been Assigned" notification displayed with text
      | AUTO_TEST_ACTIVITY_NAME |
    When User clicks "Activity has been Assigned" "AUTO_TEST_ACTIVITY_NAME" notification
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks "Reassign" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User selects "Assignee_AT_FN Assignee_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status     |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                        | Reassigned |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending    |
    When User logs into RDDC as "Assignee"
    And User clicks Notification Bell
    Then "Activity to Review" notification displayed with text
      | AUTO_TEST_ACTIVITY_NAME |
    When User navigates to Third-party page
    And User deletes third-party saved in context
    And User clicks Notification Bell
    And User clicks "Activity to Review" "AUTO_TEST_ACTIVITY_NAME" notification
    Then User is redirected to page 404