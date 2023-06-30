@ui @functional @dashboard
Feature: Home Page - My Tasks - Items to Approve Widget

  As an Admin or Internal User that has access right
  I want to display all active Items to Approve that requires my approval in the Dashboard
  So that Approver can easily see in the dashboard

  @C43400874
  Scenario: C43400874: "Items to Approve" widget is not clickable when it's counter value is 0
    Given User logs into RDDC as "Empty Metrics User"
    When User hovers over "Items To Approve" widget
    Then My Tasks "Items To Approve" widget is in disabled color
    And Dashboard widget chevron is not displayed
    And Dashboard "Items To Approve" widget is disabled

  @C43400875 @C43400876
  Scenario: C43400875, C43400876: Grey highlight appears when hovering over "Items to Approve" widget with counter value >= 1
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User adds new Activity "Assessment Activity" with "Assessment Activity" data
    And User clicks "Edit" icon for Activity "Assessment Activity"
    And User clicks Activity "Edit Approver" tab
    And User selects "Admin_AT_FN Admin_AT_LN" value for Default Approver
    And User clicks workflow button "Done"
    And User adds new Activity "AUTO_TEST_SIMPLE_ACTIVITY_TYPE_2" with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" data
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User navigates to Home page
    And User hovers over "Items To Approve" widget
    Then My Tasks "Items To Approve" widget is in disabled color
    And Dashboard widget chevron is displayed

  @C43400877 @C43400878
  Scenario: C43400877, C43400878: "Items to Approve" widget changes color to blue when clicked
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Approve' widget
    Then Dashboard Items To Approve widget is in clicked color
    And Dashboard widget chevron is displayed

  @C43400880
  Scenario: C43400880: Table "Items to Approve" is sort by "Due Date" column in ascending order by default
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Approve' widget
    Then "Items To Approve" table displays records sorted by "Due Date" in "ASC" order

  @C43400881
  Scenario: C43400881: User is able to sort "Items to Approve" table by clicking column headers
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Approve' widget
    And Users clicks "Third-party Name" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Third-party Name" in "DESC" order
    When Users clicks "Activity Name" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Activity Name" in "ASC" order
    When Users clicks "Activity Name" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Activity Name" in "DESC" order
    When Users clicks "Description" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Description" in "ASC" order
    When Users clicks "Description" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Description" in "DESC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Due Date" in "ASC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Due Date" in "DESC" order
    When Users clicks "Assigned To" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Assigned To" in "ASC" order
    When Users clicks "Assigned To" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Assigned To" in "DESC" order
    When Users clicks "Status" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Status" in "ASC" order
    When Users clicks "Status" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Status" in "DESC" order

  @C43400889
  Scenario: C43400889: Only one widget can be active at a time
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Approve' widget
    Then Dashboard Items To Approve widget is in clicked color
    And Dashboard "Items To Approve" widget chevron is displayed
    When User clicks 'Pending Orders For Approval' widget
    Then Dashboard Items To Approve widget is not in clicked color
    And Dashboard "Items To Approve" widget chevron is not displayed

  @C32904530
  Scenario: C32904530: My Tasks - Items to Approve - Verify pagination
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Approve' widget
    Then Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
    When User selects "10" items per page
    Then Table displayed with up to "10" rows
    When User selects "25" items per page
    Then Table displayed with up to "25" rows

  @C32904538
  Scenario: C32904538: My Tasks - Items to Approve - Verify that user should see Activity Status: Not Started
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Approve' widget
    Then Dashboard Items To Approve table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |
    And Status column has "Not Started" status values

  @C32904540
  Scenario: C32904540: My Tasks - Items to Approve - View Activity for Approval
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Approve' widget
    Then Dashboard Items To Approve table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |
    When User selects first Item to Approve
    Then Activity Information page is displayed

  @C42870853
  Scenario: C42870853: [React Migration Phase 2] Internal Users Portal - My Tasks: Items to Approve widget - Apply sorting to all pages
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Approve' widget
    And Users clicks "Third-party Name" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Third-party Name" in "ASC" order
    When User clicks last page icon
    Then "Items To Approve" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Activity Name" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Activity Name" in "ASC" order
    When User clicks last page icon
    Then "Items To Approve" table displays records sorted by "Activity Name" in "ASC" order
    When Users clicks "Description" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Description" in "ASC" order
    When User clicks last page icon
    Then "Items To Approve" table displays records sorted by "Description" in "ASC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Due Date" in "ASC" order
    When User clicks last page icon
    Then "Items To Approve" table displays records sorted by "Due Date" in "ASC" order
    When Users clicks "Assigned To" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Assigned To" in "ASC" order
    When User clicks last page icon
    Then "Items To Approve" table displays records sorted by "Assigned To" in "ASC" order
    When Users clicks "Status" dashboard table column header
    Then "Items To Approve" table displays records sorted by "Status" in "ASC" order
    When User clicks last page icon
    Then "Items To Approve" table displays records sorted by "Status" in "ASC" order
