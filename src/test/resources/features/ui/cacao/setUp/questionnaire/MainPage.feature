@ui @cacao @functional @questionnaires
Feature: Questionnaire Management - Main Page

  GIVEN an internal RDDC user AND permissions to manage questionnaire
  WHEN click on Set up > Questionnaire
  THEN show the Questionnaire Main page

  Background:
    Given User logs into RDDC as "Admin"
    And  User clicks Set Up option

  @C46267572 @C32969617 @C32969708
  Scenario: C46267572, C32969617, C32969708: [Questionnaire] - Main page - Data present
  Questionnaire Overview can be navigated through Questionnaire Management > Questionnaires
  Verify column headers on Questionnaire Overview Page
    When User clicks Questionnaires tab in Questionnaire Management
    Then Questionnaire Overview page is displayed
    And Search text field is displayed
    And Show drop-down is displayed
    And Questionnaire Management "Add  questionnaire" button is displayed
    And Questionnaire table contains expected count for "All" questionnaires
    And Questionnaire Management Edit and Clone buttons are displayed for each row
    And Questionnaire Management columns with the next headers are displayed
      | QUESTIONNAIRE NAME |
      | STATUS             |
      | DATE CREATED       |
      | LAST UPDATED       |
    And Current URL contains "/ui/admin/questionnaire-management/questionnaires" endpoint
    And Questionnaire Management table sorted by "Date Created" in "DESC" order
    When User clicks Questionnaire Management table "Questionnaire Name" column's header
    Then Questionnaire Management table sorted by "Questionnaire Name" in "ASC" order
    When User clicks Questionnaire Management table "Status" column's header
    Then Questionnaire Management table sorted by "Status" in "ASC" order
    When User clicks Questionnaire Management table "Date Created" column's header
    Then Questionnaire Management table sorted by "Date Created" in "ASC" order
    When User clicks Questionnaire Management table "Last Updated" column's header
    And User clicks Questionnaire Management table "Last Updated" column's header
    Then Questionnaire Management table sorted by "Last Updated" in "DESC" order
    And Pagination option "10" is selected
    And Pagination buttons should be visible
      | first | previous | next | last |
    And Each recording in the Questionnaire Management table is clickable
    And Table displays corresponding to pagination correct rows number

  @C46284003 @C32969834
  Scenario: C46284003, C32969834: [Questionnaire] - Main page - Search and filter
  Verify that Show filter has All, Active, Inactive, and Saved As Draft options
    When User clicks Questionnaires tab in Questionnaire Management
    Then Show Drop-Down current option should be "All"
    And Show Drop-Down list is displayed with values
      | All            |
      | Active         |
      | Inactive       |
      | Saved As Draft |
    When User selects "Active" show option
    Then Table displayed with all "Active" items
    When User searches item by "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" keyword
    Then Questionnaire "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" is displayed on questionnaires table
    When User selects "Inactive" show option
    And User clears search input field
    And  User clicks Questionnaire Management table "Questionnaire Name" column's header
    Then Table displayed with all "Inactive" items
    And Questionnaire Management table sorted by "Questionnaire Name" in "ASC" order
    And Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |
    When User selects "25" items per page
    Then Table displayed with up to "25" rows
    When User selects "Saved As Draft" show option
    Then Table displayed with all "Saved As Draft" items
    When User searches item by "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" keyword
    Then Questionnaire Management "NO MATCH FOUND" massage is displayed
    When User selects "All" show option
    And User searches item by "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" keyword
    Then Questionnaire "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" is displayed on questionnaires table
    When User searches item by "AUTO_TEST_EXTERNAL_QUESTIONNAIR" keyword
    Then Questionnaire Management "NO MATCH FOUND" massage is displayed
    When User searches item by "auto_test_external_questionnaire" keyword
    Then Questionnaire Management "NO MATCH FOUND" massage is displayed
    When User clears search input field
    Then Questionnaire table contains expected count for "All" questionnaires
