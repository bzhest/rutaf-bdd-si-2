@ui @full_regression @dashboard
Feature: Dashboard - Viewing Assigned Activities

  Background:
    Given User logs into RDDC as "Admin"

  @C36134038
  @onlySingleThread
  Scenario: C36134038: Supplier - Dashboard - View Assigned Activities Widget
    When User creates third-party "workflowGroupUkraineIndividual"
    And User clicks Start Onboarding for third-party
    When User navigates to Home page
    Then Dashboard Assigned Activities widget counter displayed with expected count
    When User clicks 'Assigned Activities' widget
    Then Dashboard Assigned Activities table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |
    And Users clicks "Status" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Status" in "ASC" order
    When Users clicks "Status" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Status" in "DESC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Third-party Name" in "DESC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Third-party Name" in "DESC" order
    When Users clicks "Description" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Description" in "ASC" order
    When Users clicks "Description" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Description" in "DESC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Due Date" in "ASC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Due Date" in "DESC" order
    When Users clicks "Assigned To" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Assigned To" in "ASC" order
    When Users clicks "Assigned To" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Assigned To" in "DESC" order
    When User clicks 'Assigned Activities' widget
    Then Dashboard table is not displayed

  @C37107924
  Scenario: C37107924: Home - My Tasks - Viewing Assigned Activities - Change Activity Status to Done
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Status" drop-down with "Not Started"
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User clicks Third-Party Risk Management "Back" button
    Then Added Ad Hoc Activity is displayed in Ad Hoc Activity table
    When User navigates to Home page
    And User clicks 'Assigned Activities' widget
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "50" items per page
    Then Assigned Activity for third-party is displayed
    When User clicks on assigned activity for created third-party
    Then Activity Information page is displayed
    And Current URL contains "/thirdparty/" endpoint
    And Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Assignee                | Status      |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Not Started |
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks on the newly created Ad Hoc Activity with name "AUTO_TEST_ACTIVITY_NAME"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Assignee                | Status    |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Completed |

  @C37107925
  Scenario: C37107925: Home - My Tasks - Viewing Assigned Activities - Change Third-party Status to NOT Onboarding or Renewing
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User navigates to Home page
    And User clicks 'Assigned Activities' widget
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "50" items per page
    Then Assigned Activity for third-party is displayed
    When User clicks on assigned activity for created third-party
    Then Activity Information page is displayed
    And Current URL contains "/thirdparty/" endpoint
    And Activity Information modal is displayed with details
      | Activity Type        | Activity Name         | Due Date | Assignee                | Status      |
      | Assign Questionnaire | Assign Questionnaire1 | TODAY+2  | Admin_AT_FN Admin_AT_LN | Not Started |
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on Third-party Information tab
    And User clicks on "Assign Questionnaire" activity
    And User approves all activities
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    When User clicks Home page
    Then Home page is loaded

  @C37107926
  Scenario: C37107926: Home - My Tasks - Viewing Assigned Activities - Reassign Activity
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Status" drop-down with "Not Started"
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User clicks Third-Party Risk Management "Back" button
    Then Added Ad Hoc Activity is displayed in Ad Hoc Activity table
    When User navigates to Home page
    And User clicks 'Assigned Activities' widget
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "50" items per page
    Then Assigned Activity for third-party is displayed
    When User clicks on assigned activity for created third-party
    Then Activity Information page is displayed
    And Current URL contains "/thirdparty/" endpoint
    And Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Assignee                | Status      |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Not Started |
    When User clicks Edit button for Activity
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Save' activity button
    And User clicks on the newly created Ad Hoc Activity with name "AUTO_TEST_ACTIVITY_NAME"
    Then Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Assignee                      | Status      |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Assignee_AT_FN Assignee_AT_LN | Not Started |
    When User navigates to Home page
    And User clicks 'Assigned Activities' widget
    Then Assigned Activity for third-party is not displayed
