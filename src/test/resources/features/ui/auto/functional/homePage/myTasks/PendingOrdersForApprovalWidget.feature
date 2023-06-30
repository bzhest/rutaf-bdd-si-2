@ui @functional @dashboard
Feature: Home Page - My Tasks - Pending Order For Approval Widget

  As an Admin or Internal User that has access right
  I want to display all active Due Diligence Order Request that requires my approval in the Dashboard
  So that Approver can easily see in the dashboard

  @C43428542
  Scenario: C43428542: "Pending Orders for Approval" widget is not clickable when it's counter value is 0
    Given User logs into RDDC as "Empty Metrics User"
    When User hovers over "Pending Orders for Approval" widget
    Then My Tasks "Pending Orders for Approval" widget is in disabled color
    And Dashboard widget chevron is not displayed
    And Dashboard "Pending Orders for Approval" widget is disabled

  @C43428543 @C43428544
  Scenario: C43428543, C43428544: Grey highlight appears when hovering over "Pending Orders for Approval" widget with counter value >= 1
  Chevron is displayed when hovering over "Pending Orders for Approval" widget with counter value >= 1
    Given User logs into RDDC as "Admin"
    And User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    And User clicks none selected scope
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - FOR APPROVAL"
    And User navigates to Home page
    And User hovers over "Pending Orders for Approval" widget
    Then My Tasks "Pending Orders for Approval" widget is in disabled color
    And Dashboard widget chevron is displayed

  @C43428545 @C43428546
  Scenario: C43428545, C43428546: "Pending Orders for Approval" widget changes color to blue when clicked
  Chevron appears after "Pending Orders for Approval" widget is clicked
    Given User logs into RDDC as "Admin"
    When User clicks 'Pending Orders For Approval' widget
    And User hovers over "Assigned Activities" widget
    Then Dashboard Pending Orders for Approval widget is in clicked color
    And Dashboard widget chevron is displayed

  @C43428548
  Scenario: C43428548: Table "Pending Orders for Approval" is sort by "Order ID" column in descending order by default
    Given User logs into RDDC as "Admin"
    When User clicks 'Pending Orders For Approval' widget
    Then "Pending Orders For Approval" table displays records sorted by "Order ID" in "DESC" order

  @C43428549
  Scenario: C43428549: User is able to sort "Pending Orders for Approval" table by clicking column headers
    Given User logs into RDDC as "Admin"
    When User clicks 'Pending Orders For Approval' widget
    And Users clicks "Order ID" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order ID" in "ASC" order
    When Users clicks "Order ID" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order ID" in "DESC" order
    When Users clicks "Order ID" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order ID" in "ASC" order
    When Users clicks "Scope" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Scope" in "ASC" order
    When Users clicks "Scope" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Scope" in "DESC" order
    When Users clicks "Scope" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Scope" in "ASC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order Status" in "ASC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order Status" in "DESC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order Status" in "ASC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Requester Name" in "ASC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Requester Name" in "DESC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Requester Name" in "ASC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Approver Name" in "ASC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Approver Name" in "DESC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Approver Name" in "ASC" order

  @C43428551
  Scenario: C43428551: Only one widget can be active at a time
    Given User logs into RDDC as "Admin"
    When User clicks 'Pending Orders For Approval' widget
    And User clicks 'Due Diligence Orders' widget
    Then Dashboard Due Diligence Orders widget is in clicked color
    And Dashboard "Due Diligence Orders" widget chevron is displayed
    And Dashboard Pending Orders for Approval widget is not in clicked color
    And Dashboard "Pending Orders for Approval" widget chevron is not displayed

  @C32904548
  Scenario: C32904548: My Tasks - View Pending Order for Approval widget
    Given User logs into RDDC as "Admin"
    When User clicks 'Pending Orders For Approval' widget
    Then Dashboard Pending Orders For Approval table is displayed with column names
      | ORDER ID | SCOPE | ORDER DATE | ORDER STATUS | REQUESTER NAME | APPROVER NAME |
    When User selects first Due Diligence Order
    Then Due Diligence Order form is opened

  @C35624683
  @onlySingleThread
  Scenario: C35624683: My Tasks - Pending Orders for Approval - Assigned to User Group - Verify that order is displayed for all User Group members
    Given User logs into RDDC as "Assignee"
    When User opens Due Diligence Order Approval page
    And User clicks "User Group" DD Order default approver radio button
    And User selects "Group With Multi Users" in DD order Default approver dropdown
    And User clicks DDO Approval Save button
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    And User clicks none selected scope
    And User fills in Po No.
    And User gets OrderId from Due Diligence Order page URL
    And User clicks "Send for Approval" button on Due Diligence Order page
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - FOR APPROVAL"
    And User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    Then Pending Due Diligence Order is displayed in the list
    And User logs into RDDC as "Approver"
    And User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    Then Pending Due Diligence Order is displayed in the list

  @C32904549
  Scenario: C32904549: My Tasks - Pending Orders for Approval - Verify that view is redirected to Due Diligence Order after clicking order in Orders Overview
    Given User logs into RDDC as "Admin"
    When User clicks 'Pending Orders For Approval' widget
    And User selects first Due Diligence Order
    Then Due Diligence Order form is opened
    When User clicks Back button on Due Diligence Order page
    Then Home page is loaded
    When User clicks 'Pending Orders For Approval' widget
    And User selects first Due Diligence Order
    Then Due Diligence Order form is opened
    When User clicks Dashboard link button on Due Diligence Order page
    Then Home page is loaded

  @C36146019
  Scenario: C36146019: My Tasks - Pending Orders for Approval - Verify pagination
    Given User logs into RDDC as "Admin"
    When User clicks 'Pending Orders For Approval' widget
    Then Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |
    When User selects "10" items per page
    Then Table displayed with up to "10" rows
    When User selects "25" items per page
    Then Table displayed with up to "25" rows
    When User selects "50" items per page
    Then Table displayed with up to "50" rows

  @C42870857
  Scenario: C42870857: [React Migration Phase 2] Internal Users Portal - My Tasks: Pending Orders for Approval widget - Apply sorting to all pages
    Given User logs into RDDC as "Admin"
    When User clicks 'Pending Orders For Approval' widget
    And Users clicks "Order ID" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order ID" in "ASC" order
    When User clicks last page icon
    Then "Pending Orders For Approval" table displays records sorted by "Order ID" in "ASC" order
    When Users clicks "Scope" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Scope" in "ASC" order
    When User clicks last page icon
    Then "Pending Orders For Approval" table displays records sorted by "Scope" in "ASC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order Status" in "ASC" order
    When User clicks last page icon
    Then "Pending Orders For Approval" table displays records sorted by "Order Status" in "ASC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Requester Name" in "ASC" order
    When User clicks last page icon
    Then "Pending Orders For Approval" table displays records sorted by "Requester Name" in "ASC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Approver Name" in "ASC" order
    When User clicks last page icon
    Then "Pending Orders For Approval" table displays records sorted by "Approver Name" in "ASC" order
