@ui @suppliers @alamid @adhoc_activity
Feature: Ad Hoc Activities

  As a Compliance Group User
  I want to be able to create Ad Hoc activities for a Third-Party
  So that I can log additional activities that are not covered in the Onboarding process

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab

  @C35942594 @C38647977
  @full_regression
  Scenario: C35942594, C38647977: Third-party - Ad Hoc Activities - Edit Ad Hoc Activities with NOT Draft status from Ad Hoc Activity List
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    Then Ad Hoc Activity "ADD ACTIVITY" modal is displayed
    When User fills in "Activity Type" drop-down with "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User fills in "Status" drop-down with "Not Started"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    Then Risk Management "Cancel" button is displayed
    And Risk Management "Save" button is displayed
    And Ad Hoc Activity Information modal fields should be in correct state
      | Status   | enabled |
      | Assignee | enabled |
    And Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Waiting     |
      | Done        |
    When User clears value for dropdown "Assignee"
    And User clicks Third-Party Risk Management "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                          |
      | Please complete the required fields. |
    And Error message 'This field is required' is displayed for the next fields
      | Assignee |
    When User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                        | Activity Name           | Description           | Start Date | Due Date | Status      | Assignee                      |
      | AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1 | AUTO_TEST_ACTIVITY_NAME | Auto test Description | TODAY+0    | TODAY+0  | Not Started | Assignee_AT_FN Assignee_AT_LN |
    When User clicks Edit button for Activity
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User fills in "Status" drop-down with "Done"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                        | Activity Name           | Description           | Start Date | Due Date | Status    | Assignee                |
      | AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1 | AUTO_TEST_ACTIVITY_NAME | Auto test Description | TODAY+0    | TODAY+0  | Completed | Admin_AT_FN Admin_AT_LN |