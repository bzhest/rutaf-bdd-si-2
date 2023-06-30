@ui @full_regression @react @dashboard
Feature: Home Page - Items to Review Widget

  As an RDDC User
  I want a quick view of all the activities assigned to me for review
  So that I can review the list without going through each Third-party Record


  @C46712209
  Scenario: C46712209: "Items to Review" widget is displayed in the "My task" dashboard
    Given User logs into RDDC as "Admin"
    When User navigates to Home page
    Then Dashboard "Items To Review" widget is enabled
    When User clicks 'Items To Review' widget
    Then Items To Review widget's counter displays sum of all items

  @C46712215
  @core_regression
  Scenario: C46712215: Table with activities to review is displayed after "Items to Review" widget is clicked
    Given User logs into RDDC as "Admin"
    When User navigates to Home page
    And User clicks 'Items To Review' widget
    Then Dashboard table name is "ACTIVITIES"
    And Dashboard drop-down option "Activity" is selected

  @C46712224
  Scenario: C46712224: Dropdown menu is displayed after clicking "Items to Review" widget
    Given User logs into RDDC as "Admin"
    When User navigates to Home page
    And User clicks 'Items To Review' widget
    Then Dashboard drop-down options are expected
      | Activity      |
      | Questionnaire |
      | Screening     |
    And Dashboard selected drop-down option is highlighted with grey color

  @C46712225
  Scenario: C46712225, : "ACTIVITIES" table is displayed after clicking "Activity" option in the dropdown menu
    Given User logs into RDDC as "Admin"
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
    And User selects Items to Review Activity
    Then Dashboard table name is "ACTIVITIES"
    And Dashboard Items To Review table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |

  @C46712226 @C46712249
  Scenario: C46712226, C46712249: "QUESTIONNAIRES" table is displayed after clicking "Questionnaire" option in the dropdown menu
    Given User logs into RDDC as "Admin"
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
    Then Dashboard table name is "QUESTIONNAIRES"
    And Dashboard Items To Review table is displayed with column names
      | THIRD-PARTY NAME | QUESTIONNAIRE NAME | QUESTIONNAIRE DESCRIPTION | REVIEWER NAME | QUESTIONNAIRE DUE DATE | QUESTIONNAIRE STATUS |

  @C46712227
  Scenario: C46712227: "SCREENING" table is displayed after clicking "Screening" option in the dropdown menu
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    Then Dashboard table name is "SCREENING"

  @C46712228
  @onlySingleThread
  Scenario: C46712228: "No available data" message is displayed when user have no questionnaires to review
    Given User logs into RDDC as "Assignee"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Questionnaire
    Then Dashboard table message "NO AVAILABLE DATA" is displayed

  @C46712234
  @core_regression
  Scenario: C46712234: Table with activities to review is displayed after "Items to Review" widget is clicked
    Given User logs into RDDC as "Admin"
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
    Then Dashboard table name is "ACTIVITIES"
    And Dashboard Items To Review table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |

  @C46712231
  Scenario: C46712231: Table with activities to review is sort by "Due Date" column in ascending order by default
    Given User logs into RDDC as "Admin"
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
    Then "Items To Review" table displays records sorted by "Due Date" in "ASC" order

  @C46712233
  Scenario: C46712233: Pagination is displayed under "Activities" table when user have > 10 activities to review
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    Then Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |

  @C46712246
  Scenario: C46712246: The "QUESTIONNAIRES" table is sort by "Questionnaire Due Date" column in ascending order by default
    Given User logs into RDDC as "Admin"
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
    Then "Items To Review" table displays records sorted by "Questionnaire Due Date" in "ASC" order

  @C46712248
  Scenario: C46712248: Pagination is displayed under "QUESTIONNAIRES" table when user have > 10 questionnaires to review
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Questionnaire
    Then Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |

  @C46712261
  @core_regression
  Scenario: C46712261: Table with screening activities is displayed after "Screening" option is clicked in the dropdown menu of the "Items to Review" widget
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    Then Dashboard Items To Review table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | TYPE | RECORD NAME | REVIEWER | DUE DATE |

  @C46712262
  Scenario: C46712262: The "SCREENING" table is sort by "Due Date" column in ascending order by default
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    Then "Items To Review" table displays records sorted by "Due Date" in "ASC" order

  @C46712264
  Scenario: C46712264: Pagination is displayed under "SCREENING" table when user have > 10 screenings to review
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    Then Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |