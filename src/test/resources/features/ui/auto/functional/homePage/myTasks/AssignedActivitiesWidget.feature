@ui @functional @dashboard
Feature: Home Page - My Tasks - Pending Order For Approval Widget

  As an Admin or Internal User that has access right
  I want to display all Assigned Activities in the Dashboard
  So that User can easily see them in the dashboard

  @C41726719
  Scenario: C41726719: "ASSIGNED ACTIVITIES" widget is not clickable when it's counter value is 0
    Given User logs into RDDC as "Empty Metrics User"
    When User hovers over "Assigned Activities" widget
    Then My Tasks "Assigned Activities" widget is in disabled color
    And Dashboard widget chevron is not displayed
    And Dashboard "Assigned Activities" widget is disabled

  @C41746059 @C41748745
  Scenario: C41748745, C41746059: Grey highlight appears when hovering over "ASSIGNED ACTIVITIES" widget with counter value >= 1
  Chevron is displayed when hovering over "ASSIGNED ACTIVITIES" widget with counter value >= 1
    Given User logs into RDDC as "Admin"
    And User hovers over "Assigned Activities" widget
    Then My Tasks "Assigned Activities" widget is in disabled color
    And Dashboard widget chevron is displayed

  @C41752942 @C41752943
  Scenario: C41752942, C41752943: "ASSIGNED ACTIVITIES" widget changes color to blue when clicked
  Chevron appears after "ASSIGNED ACTIVITIES" widget is clicked
    Given User logs into RDDC as "Admin"
    When User clicks 'Assigned Activities' widget
    And User hovers over "Assigned Activities" widget
    Then Dashboard Assigned Activities widget is in clicked color
    And Dashboard widget chevron is displayed

  @C41805110
  Scenario: C41805110: Table with assigned activities is sort by Due Date in ascending order by default
    Given User logs into RDDC as "Admin"
    When User clicks 'Assigned Activities' widget
    Then "Assigned Activities" table displays records sorted by "Due Date" in "ASC" order

  @C35560780
  Scenario: C35560780: My Tasks - Assigned Activities - Verify when activity is already set to Done by the user, the activity should be removed from the list
    Given User logs into RDDC as "Admin"
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User navigates to Home page
    And User clicks 'Assigned Activities' widget
    And User selects "Max" items per page
    And Users clicks "Third-party Name" dashboard table column header
    Then Assigned Activity for third-party is displayed
    When User clicks on assigned activity for created third-party
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User navigates to Home page
    And User clicks 'Assigned Activities' widget
    And User selects "Max" items per page
    And Users clicks "Third-party Name" dashboard table column header
    Then Assigned Activity for third-party is not displayed

  @C32904546
  Scenario: C32904546: My Tasks - Assigned Activities - Verify that user should see Activity status: Not Started/ In Progress/Deferral/ Waiting
    Given User logs into RDDC as "Admin"
    When User clicks 'Assigned Activities' widget
    And User selects "Max" items per page
    And Users clicks "Third-party Name" dashboard table column header
    Then Assigned activities widget column Status contains expected values

  @C42870852
  Scenario: C42870852: [React Migration Phase 2] Internal Users Portal - My Tasks: Assigned Activities widget - Apply sorting to all pages
    Given User logs into RDDC as "Admin"
    When User clicks 'Assigned Activities' widget
    And Users clicks "Third-party Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Third-party Name" in "ASC" order
    When User clicks last page icon
    Then "Assigned Activities" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks first My Tasks table page
    And Users clicks "Activity Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Activity Name" in "ASC" order
    When User clicks last page icon
    Then "Assigned Activities" table displays records sorted by "Activity Name" in "ASC" order
    When Users clicks first My Tasks table page
    And Users clicks "Description" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Description" in "ASC" order
    When User clicks last page icon
    Then "Assigned Activities" table displays records sorted by "Description" in "ASC" order
    When Users clicks first My Tasks table page
    And Users clicks "Due Date" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Due Date" in "ASC" order
    When User clicks last page icon
    Then "Assigned Activities" table displays records sorted by "Due Date" in "ASC" order
    When Users clicks first My Tasks table page
    And Users clicks "Assigned To" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Assigned To" in "ASC" order
    When User clicks last page icon
    Then "Assigned Activities" table displays records sorted by "Assigned To" in "ASC" order
    When Users clicks first My Tasks table page
    And Users clicks "Status" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Status" in "ASC" order
    When User clicks last page icon
    Then "Assigned Activities" table displays records sorted by "Status" in "ASC" order

  @C32904522
  Scenario: C32904522: My Tasks - Assigned Activities - Verify that user should be able to select any of the activity and it should be redirected to the Activity in Third Party Information page (Ad Hoc Activity)
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    Then Ad-Hoc Activity Information is saved
    When User navigates to Home page
    And User clicks 'Assigned Activities' widget
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "50" items per page
    Then Assigned Activity for third-party is displayed
    When User clicks on assigned activity with name "AUTO_TEST_ACTIVITY_NAME" for created third-party
    Then Risk Management Ad Hoc Activity has correct URL
    And Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Assignee                | Status      |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Not Started |

  @C32904522
  Scenario: C32904522: My Tasks - Assigned Activities - Verify that user should be able to select any of the activity and it should be redirected to the Activity in Third Party Information page (Onboarding Activity)
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User navigates to Home page
    And User clicks 'Assigned Activities' widget
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "50" items per page
    Then Assigned Activity for third-party is displayed
    When User clicks on assigned activity for created third-party
    Then Activity Information page is displayed
    And Activity Information page contains expected URL
    And Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description              | Order Details                  | Due Date | Assignee                | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | Test Automation activity | ORDER DETAILS: NO ORDER PLACED | TODAY+1  | Admin_AT_FN Admin_AT_LN | Not Started |

  @C32904523
  Scenario: C32904523 - My Tasks - Assigned Activities - Verify Activity Overview
    Given User logs into RDDC as "Admin"
    When User clicks 'Assigned Activities' widget
    Then Dashboard Assigned Activities table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |