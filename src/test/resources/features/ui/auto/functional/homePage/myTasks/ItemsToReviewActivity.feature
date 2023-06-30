@ui @functional  @dashboard
Feature: Home Page - My Tasks - Items To Review Widget - Activity

  As an RDDC User
  I want a quick view of all the activities assigned to me for review
  So that I can review the list without going through each Third-party Record

  @C43279202
  Scenario: C43279202: User is able to sort "Items to Review" table by "Third-party Name" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And Users clicks "Third-party Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Third-party Name" in "DESC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Third-party Name" in "ASC" order

  @C43279408
  Scenario: C43279408: User is able to sort "Items to Review" table by "Activity Name" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And Users clicks "Activity Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Activity Name" in "ASC" order
    When Users clicks "Activity Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Activity Name" in "DESC" order
    When Users clicks "Activity Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Activity Name" in "ASC" order

  @C43279411
  Scenario: C43279411: User is able to sort "Items to Review" table by "Description" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And Users clicks "Description" dashboard table column header
    Then "Items To Review" table displays records sorted by "Description" in "ASC" order
    When Users clicks "Description" dashboard table column header
    Then "Items To Review" table displays records sorted by "Description" in "DESC" order
    When Users clicks "Description" dashboard table column header
    Then "Items To Review" table displays records sorted by "Description" in "ASC" order

  @C43279412
  Scenario: C43279412: User is able to sort "Items to Review" table by "Due Date" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And Users clicks "Due Date" dashboard table column header
    Then "Items To Review" table displays records sorted by "Due Date" in "ASC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Items To Review" table displays records sorted by "Due Date" in "DESC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Items To Review" table displays records sorted by "Due Date" in "ASC" order

  @C43279413
  Scenario: C43279413: User is able to sort "Items to Review" table by "Assigned To" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And Users clicks "Assigned To" dashboard table column header
    Then "Items To Review" table displays records sorted by "Assigned To" in "ASC" order
    When Users clicks "Assigned To" dashboard table column header
    Then "Items To Review" table displays records sorted by "Assigned To" in "DESC" order
    When Users clicks "Assigned To" dashboard table column header
    Then "Items To Review" table displays records sorted by "Assigned To" in "ASC" order

  @C43279414
  Scenario: C43279414: User is able to sort "Items to Review" table by "Status" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And Users clicks "Status" dashboard table column header
    Then "Items To Review" table displays records sorted by "Status" in "ASC" order
    When Users clicks "Status" dashboard table column header
    Then "Items To Review" table displays records sorted by "Status" in "DESC" order
    When Users clicks "Status" dashboard table column header
    Then "Items To Review" table displays records sorted by "Status" in "ASC" order

  @C35520559
  Scenario: C35520559: My Tasks - Items to review - Activity - Verify Activity Overview
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Activity
    Then Dashboard Items To Review table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |

  @C32904529
  Scenario: C32904529: My Tasks - Items to Review - Activity - View Activity for Review - Ad hoc activity
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
    And User saves Ad-Hoc Activity Id in context
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    Then Items to Review table contains activity
      | THIRD-PARTY NAME | ACTIVITY NAME           | DESCRIPTION           | DUE DATE | ASSIGNED TO             | STATUS |
      | toBeReplaced     | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   |
    When User clicks on record "AUTO_TEST_ACTIVITY_NAME" for created third-party
    Then Activity Information page is displayed
    And Ad Hoc Activity page contains expected URL
    When User clicks Back button to return from Activity modal
    Then Risk Management page is displayed

  @C32904533
  Scenario: C32904533: My Tasks - Items to Review - Activity - View Activity for Review - Onboarding activity
    Given User logs into RDDC as "Assignee"
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
    And User selects "Assignee_AT_FN Assignee_AT_LN" value for Default Reviewer
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    And User selects activity status "In Progress"
    And User clicks 'Save' activity button
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    Then Activity Information Reviewers section is not shown
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    Then Items to Review table contains activity
      | THIRD-PARTY NAME | ACTIVITY NAME             | DESCRIPTION               | DUE DATE | ASSIGNED TO                   | STATUS |
      | toBeReplaced     | Request for Due Diligence | Request for Due Diligence | TODAY+1  | Assignee_AT_FN Assignee_AT_LN | Done   |
    When User clicks on record "Request for Due Diligence" for created third-party
    Then Activity Information page is displayed
    And Activity Information page contains expected URL
    When User clicks Back button to return from Activity modal
    Then Third-party Information tab is loaded
