@ui @full_regression @dashboard
Feature: Dashboard - Viewing Items to Review

  Background:
    Given User logs into RDDC as "Admin"

  @C36187821
  @core_regression
  Scenario: C36187821: Home - My Tasks - Viewing Items to Review - Review Activity
    When User creates "Activity Type" "without assessment" via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Done button in Activity Reviewers section
    And User clicks Back button to return from Activity modal
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    When User navigates to Home page
    And User clicks 'Items To Review' widget
    Then Items to Review table contains activity
      | THIRD-PARTY NAME | ACTIVITY NAME           | DESCRIPTION           | DUE DATE | ASSIGNED TO             | STATUS |
      | toBeReplaced     | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   |
    When User clicks on record "AUTO_TEST_ACTIVITY_NAME" for created third-party
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Assignee                | Status |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   |
    And Current URL contains "/thirdparty/" endpoint
    When User clicks Back button to return from Activity modal
    Then Risk Management page is displayed
    And Current URL contains "/thirdparty/" endpoint
    When User clicks on Third-party Information tab
    Then Third-party Information tab is loaded
    And Current URL contains "/thirdparty/" endpoint
    When User clicks on "Associated Parties" tab on Third-party page
    Then Associated Parties tab is loaded
    And Current URL contains "/thirdparty/" endpoint
    When User clicks on Questionnaire tab
    Then Questionnaire tab is loaded
    And Current URL contains "/thirdparty/" endpoint
    When User navigates to Home page
    Then Home page is loaded
    When User clicks 'Items To Review' widget
    And User clicks on record "AUTO_TEST_ACTIVITY_NAME" for created third-party
    And User clicks "Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Assignee                | Status    |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Completed |
    When User navigates to Home page
    Then Home page is loaded
    When User clicks 'Items To Review' widget
    Then Items to Review table doesn't contain activity
      | THIRD-PARTY NAME | ACTIVITY NAME           | DESCRIPTION           | DUE DATE | ASSIGNED TO             | STATUS |
      | toBeReplaced     | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   |
    And Items To Review widget's counter displays sum of all items

  @C36187822
  @core_regression
  Scenario: C36187822: Home - My Tasks - Viewing Items to Review - Reassign Activity
    When User creates "Activity Type" "without assessment" via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Done button in Activity Reviewers section
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    When User navigates to Home page
    And User clicks 'Items To Review' widget
    Then Items to Review table contains activity
      | THIRD-PARTY NAME | ACTIVITY NAME           | DESCRIPTION           | DUE DATE | ASSIGNED TO             | STATUS |
      | toBeReplaced     | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   |
    When User clicks on record "AUTO_TEST_ACTIVITY_NAME" for created third-party
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Assignee                | Status |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   |
    And Current URL contains "/thirdparty/" endpoint
    When User clicks "Reassign" review Ad Hoc action button for "Admin_AT_FN Admin_AT_LN" user
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Assignee                | Status |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   |
    When User navigates to Home page
    Then Home page is loaded
    When User clicks 'Items To Review' widget
    Then Items to Review table doesn't contain activity
      | THIRD-PARTY NAME | ACTIVITY NAME           | DESCRIPTION           | DUE DATE | ASSIGNED TO             | STATUS |
      | toBeReplaced     | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   |
    And Items To Review widget's counter displays sum of all items

  @C36200369
  @core_regression
  Scenario: C36200369: Home - My Tasks - Viewing Items to Review - Review Questionnaire
    When User creates "Activity Type" "without assessment" via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for"
    Then Activity Information page is displayed
    When User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" status should be "Submitted"
    When User navigates to Home page
    Then Home page is loaded
    When User clicks 'Items To Review' widget
    And User selects Items to Review Questionnaire
    Then Items to Review table contains activity
      | THIRD-PARTY NAME | QUESTIONNAIRE NAME               | QUESTIONNAIRE DESCRIPTION | REVIEWER NAME           | QUESTIONNAIRE DUE DATE | QUESTIONNAIRE STATUS |
      | toBeReplaced     | AUTO_TEST_INTERNAL_QUESTIONNAIRE |                           | Admin_AT_FN Admin_AT_LN | TODAY+0                | Submitted            |
    When User clicks on record "AUTO_TEST_INTERNAL_QUESTIONNAIRE" for created third-party
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type        | Activity Name        | Description                                                                       | Due Date | Assignee                | Status  |
      | Assign Questionnaire | Assign Questionnaire | This activity was automatically initiated through adhoc questionnaire assignment. | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Current URL contains "/thirdparty/" endpoint
    When User clicks Back button to return from Activity modal
    Then Risk Management page is displayed
    And Current URL contains "/thirdparty/" endpoint
    When User clicks on Third-party Information tab
    Then Third-party Information tab is loaded
    And Current URL contains "/thirdparty/" endpoint
    When User clicks on "Associated Parties" tab on Third-party page
    Then Associated Parties tab is loaded
    And Current URL contains "/thirdparty/" endpoint
    When User clicks on Questionnaire tab
    Then Questionnaire tab is loaded
    And Current URL contains "/thirdparty/" endpoint
    When User navigates to Home page
    Then Home page is loaded
    When User clicks 'Items To Review' widget
    And User selects Items to Review Questionnaire
    And User clicks on record "AUTO_TEST_INTERNAL_QUESTIONNAIRE" for created third-party
    And User clicks review questionnaires
    Then Questionnaire details page is displayed
    When User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    And Current URL contains "/thirdparty/" endpoint
    When User navigates to Home page
    Then Home page is loaded
    When User clicks 'Items To Review' widget
    Then Items to Review table doesn't contain activity
      | THIRD-PARTY NAME | QUESTIONNAIRE NAME               | QUESTIONNAIRE DESCRIPTION | REVIEWER NAME           | QUESTIONNAIRE DUE DATE | QUESTIONNAIRE STATUS |
      | toBeReplaced     | AUTO_TEST_INTERNAL_QUESTIONNAIRE |                           | Admin_AT_FN Admin_AT_LN | TODAY+0                | Submitted            |
    And Items To Review widget's counter displays sum of all items

  @C36156811
  Scenario: C36156811: Supplier - Dashboard - View Items to Review Widget
    When User creates "Activity Type" "without assessment" via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Done button in Activity Reviewers section
    And User clicks Back button to return from Activity modal
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    Then Items To Review widget's counter displays sum of all items
    When User selects Items to Review Activity
    Then Dashboard Items To Review table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |
    And Users clicks "Status" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Status" in "ASC" order
    When Users clicks "Status" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Status" in "DESC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Third-party Name" in "DESC" order
    When Users clicks "Activity Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Activity Name" in "ASC" order
    When Users clicks "Activity Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Activity Name" in "DESC" order
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
    When User clicks 'Items To Review' widget
    Then Dashboard table is not displayed