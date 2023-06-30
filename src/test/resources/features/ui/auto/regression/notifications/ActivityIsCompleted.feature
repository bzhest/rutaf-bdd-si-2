@ui @full_regression @notification
Feature: Third-party Onboarding - Activity Completed Screen Notification

  As a Responsible Party of a Third-party Being Onboarded
  I want to be notified whenever an activity is Completed
  So that I will be updated on the Status of the Supplier Onboarding

  @C35971578
  Scenario: C35971578: [On Screen Notification] Supplier Onboarding - Activity Completed Screen Notification for a responsible party
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow and Assignee responsible party"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "Assignee"
    And User navigates to Home page
    And User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And "Activity has been Completed" notification displayed with text
      | Assign Questionnaire1 |
    When User clicks "Activity has been Completed" "Assign Questionnaire1" notification
    Then Activity Information modal is displayed with details
      | Activity Type        | Activity Name         | Description | Due Date | Assignee                | Status    | Assessment |
      | Assign Questionnaire | Assign Questionnaire1 | Description | TODAY+2  | Admin_AT_FN Admin_AT_LN | Completed | case1      |


  @C35972512
  Scenario: C35972512: [On Screen Notification] Supplier Onboarding - Activity Completed Screen Notification for a responsible party - 404 error page
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow and Assignee responsible party"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    When User logs into RDDC as "Assignee"
    And User clicks Notification Bell
    Then "Activity has been Completed" notification displayed with text
      | Assign Questionnaire1 |
    When User opens previously created Third-party
    And User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User navigates to Home page
    And User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    And "Activity has been Completed" notification displayed with text
      | Assign Questionnaire1 |
    When User clicks "Activity has been Completed" "Assign Questionnaire1" notification
    Then User is redirected to page 404

  @C35980701
  Scenario: C35980701: Risk Management - Activity Completed Screen Notification for a creator - ad hoc activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name"
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Status" drop-down with "Not Started"
    And User fills in "Activity Type" drop-down with "Assessment"
    And User fills in "Activity Name" field with "toBeReplaced"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_double_AT_FN Admin_double_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    Then Ad-Hoc Activity Information is saved
    When User logs into RDDC as "admin double"
    And User opens previously created Ad-Hoc Acvtivity
    And User clicks Edit button for Activity
    And User fills in "Status" drop-down with "Done"
    And User clicks Third-Party Risk Management "Save" button
    And User logs into RDDC as "Admin"
    And User clicks Notification Bell
    Then "Activity has been Completed" notification displayed with text
      | toBeReplaced |
    When User clicks "Activity has been Completed" "toBeReplaced" notification
    Then Activity Information modal is displayed with details
      | Activity Type | Activity Name | Description           | Due Date | Assignee                              | Status    | Initiated By            | Last Update | Start Date | Risk Area |
      | Assessment    | toBeReplaced  | Auto test Description | TODAY+0  | Admin_double_AT_FN Admin_double_AT_LN | Completed | Admin_AT_FN Admin_AT_LN | TODAY+0     | TODAY+0    |           |

  @C35982338
  Scenario: C35982338: Risk Management - Activity Completed Screen Notification - 404 error is shown when a supplier is deleted (ad hoc activity)
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name"
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Status" drop-down with "Not Started"
    And User fills in "Activity Type" drop-down with "Assessment"
    And User fills in "Activity Name" field with "toBeReplaced"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_double_AT_FN Admin_double_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    Then Ad-Hoc Activity Information is saved
    When User logs into RDDC as "admin double"
    And User opens previously created Ad-Hoc Acvtivity
    And User clicks Edit button for Activity
    And User fills in "Status" drop-down with "Done"
    And User clicks Third-Party Risk Management "Save" button
    And User logs into RDDC as "Admin"
    And User clicks Notification Bell
    Then "Activity has been Completed" notification displayed with text
      | toBeReplaced |
    When User navigates to Third-party page
    And User deletes third-party saved in context
    And User clicks Notification Bell
    And User clicks "Activity has been Completed" "toBeReplaced" notification
    Then User is redirected to page 404