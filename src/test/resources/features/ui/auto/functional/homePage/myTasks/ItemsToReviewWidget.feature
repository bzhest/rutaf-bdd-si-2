@ui @functional @dashboard
Feature: Home Page - My Tasks - Items To Review Widget

  As an RDDC User
  I want a quick view of all the activities assigned to me for review
  So that I can review the list without going through each Third-party Record

  @C43133336
  Scenario: C43133336: Items to Review widget is not clickable when it's counter value is 0
    Given User logs into RDDC as "Empty Metrics User"
    When User hovers over "Items To Review" widget
    Then My Tasks "Items To Review" widget is in disabled color
    And Dashboard widget chevron is not displayed
    And Dashboard "Items To Review" widget is disabled

  @C43133337 @C43133338
  Scenario: C43133337, C43133338: Grey highlight appears when hovering over "Items to Review" widget with counter value >= 1
  Chevron is displayed when hovering over "Items to Review" widget with counter value >= 1
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
    And User hovers over "Items To Review" widget
    Then My Tasks "Items To Review" widget is in disabled color
    And Dashboard widget chevron is displayed

  @C43133339 @C43133340
  Scenario: C43133339, C43133340: Items to Review widget changes color to blue when clicked
  Chevron appears after "Items to Review" widget is clicked
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User hovers over "Assigned Activities" widget
    Then Dashboard Items To Review widget is in clicked color
    And Dashboard widget chevron is displayed

  @C43133350
  Scenario: C43133350: Table closes after clicking the "Items to Review" widget
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    Then Dashboard table is displayed
    When User clicks 'Items To Review' widget
    And User hovers over "Assigned Activities" widget
    Then Dashboard table is not displayed
    And Dashboard Items To Review widget is not in clicked color
    And Dashboard "Items To Review" widget chevron is not displayed

  @C43133351
  Scenario: C43133351: Only one widget can be active at a time
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User clicks 'Due Diligence Orders' widget
    Then Dashboard Due Diligence Orders widget is in clicked color
    And Dashboard "Due Diligence Orders" widget chevron is displayed
    And Dashboard Items To Review widget is not in clicked color
    And Dashboard "Items To Review" widget chevron is not displayed

  @C32904526
  Scenario: C32904526: My Tasks - Items to Review - View records for review
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Questionnaire
    Then Dashboard Items To Review table is displayed with column names
      | THIRD-PARTY NAME | QUESTIONNAIRE NAME | QUESTIONNAIRE DESCRIPTION | REVIEWER NAME | QUESTIONNAIRE DUE DATE | QUESTIONNAIRE STATUS |
    When User selects Items to Review Screening
    Then Dashboard Items To Review table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | TYPE | RECORD NAME | REVIEWER | DUE DATE |

  @C32904527
  Scenario: C32904527: My Tasks - Items to Review - Verify that user should be able to click on "Items to Review" tile and it should be highlighted (with value)
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Activity
    Then Dashboard Items To Review widget is in clicked color
    And Items To Review widget's counter displays sum of all items

  @C42870854
  @RMS-32356
  Scenario: C42870854: [React Migration Phase 2] Internal Users Portal - My Tasks: Items to Review widget - Apply sorting to all pages
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And Users clicks "Third-party Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Third-party Name" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Activity Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Activity Name" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Activity Name" in "ASC" order
    When Users clicks "Description" dashboard table column header
    Then "Items To Review" table displays records sorted by "Description" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Description" in "ASC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Items To Review" table displays records sorted by "Due Date" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Due Date" in "ASC" order
    When Users clicks "Assigned To" dashboard table column header
    Then "Items To Review" table displays records sorted by "Assigned To" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Assigned To" in "ASC" order
    When Users clicks "Status" dashboard table column header
    Then "Items To Review" table displays records sorted by "Status" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Status" in "ASC" order
    And User selects Items to Review Questionnaire
    And Users clicks "Third-party Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Third-party Name" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Questionnaire Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Name" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Questionnaire Name" in "ASC" order
    When Users clicks "Questionnaire Description" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Description" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Questionnaire Description" in "ASC" order
    When Users clicks "Reviewer Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Reviewer Name" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Reviewer Name" in "ASC" order
    When Users clicks "Questionnaire Due Date" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Due Date" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Questionnaire Due Date" in "ASC" order
    When Users clicks "Questionnaire Status" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Status" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Questionnaire Status" in "ASC" order
    When User selects Items to Review Screening
    And Users clicks "Third-party Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Third-party Name" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Activity Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Activity Name" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Activity Name" in "ASC" order
#    TODO uncomment when RMS-32356 will be fixed
#    When Users clicks "Type" dashboard table column header
#    Then "Items To Review" table displays records sorted by "Type" in "ASC" order
#    When User clicks last page icon
#    Then "Items To Review" table displays records sorted by "Type" in "ASC" order
    When Users clicks "Record Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Record Name" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Record Name" in "ASC" order
    When Users clicks "Reviewer" dashboard table column header
    Then "Items To Review" table displays records sorted by "Reviewer" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Reviewer" in "ASC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Items To Review" table displays records sorted by "Due Date" in "ASC" order
    When User clicks last page icon
    Then "Items To Review" table displays records sorted by "Due Date" in "ASC" order