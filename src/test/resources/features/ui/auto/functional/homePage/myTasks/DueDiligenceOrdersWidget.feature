@ui @functional @dashboard
Feature: Home Page - My Tasks - Due Diligence Orders Widget

  As an RDDC User
  I want a quick view of all the third-party assigned for me for renewal
  So that I can review the list without going through each Third-party Record

  @C42841715
  Scenario: C42841715: Due Diligence Orders widget is not clickable when it's counter value is 0
    Given User logs into RDDC as "Empty Metrics User"
    When User hovers over "Due Diligence Orders" widget
    Then My Tasks "Due Diligence Orders" widget is in disabled color
    And Dashboard widget chevron is not displayed
    And Dashboard "Due Diligence Orders" widget is disabled

  @C42841716 @C42841717
  Scenario: C42841716, C42841717: Grey highlight appears when hovering over "Due Diligence Orders" widget with counter value >= 1
  Chevron is displayed when hovering over "Due Diligence Orders" widget with counter value >= 1
    Given User logs into RDDC as "Assignee"
    When User creates third-party "workflowGroupUkraineIndividual"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And User clicks Create Order button
    Then Due Diligence Order form is opened
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    And User populates First Name for Key Principal with "Auto"
    And User populates Last Name for Key Principal with "Principal"
    And User selects Country "Albania" for Key Principal
    And User clicks Add Contact Key Principal button
    And User clicks "Proceed" Alert dialog button
    And User fills in Po No.
    And User gets OrderId from Due Diligence Order page URL
    And User clicks "Place Order" button on Due Diligence Order page
    And User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed
    When User navigates to Home page
    Then Home page is loaded
    When User navigates to Home page
    And User hovers over "Due Diligence Orders" widget
    Then My Tasks "Due Diligence Orders" widget is in disabled color
    And Dashboard widget chevron is displayed

  @C42841718 @C42841719
  Scenario: C42841718, C42841719: Due Diligence Orders widget changes color to blue when clicked
  Chevron appears after "Due Diligence Orders" widget is clicked
    Given User logs into RDDC as "Admin"
    When User clicks 'Due Diligence Orders' widget
    And User hovers over "Assigned Activities" widget
    Then Dashboard Due Diligence Orders widget is in clicked color
    And Dashboard widget chevron is displayed

  @C42841721
  Scenario: C42841721: Table with orders is sort by "Order Date" column in descending order by default
    Given User logs into RDDC as "Admin"
    When User clicks 'Due Diligence Orders' widget
    Then "Due Diligence Orders" table displays records sorted by "Order Date" in "DECS" order

  @C42841722
  Scenario: C42841722: User is able to sort "Due Diligence Orders" table by "Order ID" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Due Diligence Orders' widget
    And Users clicks "Order ID" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order ID" in "ASC" order
    When Users clicks "Order ID" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order ID" in "DESC" order
    When Users clicks "Order ID" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order ID" in "ASC" order

  @C42841723
  Scenario: C42841723: User is able to sort "Due Diligence Orders" table by "Scope" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Due Diligence Orders' widget
    And Users clicks "Scope" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Scope" in "ASC" order
    When Users clicks "Scope" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Scope" in "DESC" order
    When Users clicks "Scope" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Scope" in "ASC" order

  @C42841724
  Scenario: C42841724: User is able to sort "Due Diligence Orders" table by "Order Date" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Due Diligence Orders' widget
    And Users clicks "Order Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Date" in "ASC" order
    When Users clicks "Order Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Date" in "DESC" order
    When Users clicks "Order Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Date" in "ASC" order

  @C42841725
  Scenario: C42841725: User is able to sort "Due Diligence Orders" table by "Order Status" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Due Diligence Orders' widget
    And Users clicks "Order Status" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Status" in "ASC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Status" in "DESC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Status" in "ASC" order

  @C42841726
  Scenario: C42841726: User is able to sort "Due Diligence Orders" table by "Due Date" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Due Diligence Orders' widget
    And Users clicks "Due Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Due Date" in "ASC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Due Date" in "DESC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Due Date" in "ASC" order

  @C42841727
  Scenario: C42841727: User is able to sort "Due Diligence Orders" table by "Requester Name" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Due Diligence Orders' widget
    And Users clicks "Requester Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Requester Name" in "ASC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Requester Name" in "DESC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Requester Name" in "ASC" order

  @C43103939
  Scenario: C43103939: User is able to sort "Due Diligence Orders" table by "Approver Name" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Due Diligence Orders' widget
    And Users clicks "Approver Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Approver Name" in "ASC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Approver Name" in "DESC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Approver Name" in "ASC" order

  @C43104031
  Scenario: C43104031: Only one widget can be active at a time
    Given User logs into RDDC as "Admin"
    When User clicks 'Due Diligence Orders' widget
    And User clicks 'Third-party for Renewal' widget
    Then Dashboard Third-party for Renewal widget is in clicked color
    And Dashboard "Third-party for Renewal" widget chevron is displayed
    And Dashboard Due Diligence Orders widget is not in clicked color
    And Dashboard "Due Diligence Orders" widget chevron is not displayed

  @C32904545
  Scenario: C32904545: My Tasks - View Due Diligence Order widget
    Given User logs into RDDC as "Admin"
    When User clicks 'Due Diligence Orders' widget
    Then Dashboard Due Diligence Orders table is displayed with column names
      | ORDER ID | SCOPE | ORDER DATE | ORDER STATUS | DUE DATE | REQUESTER NAME | APPROVER NAME |
    And "Due Diligence Orders" table displays records sorted by "Order Date" in "DESC" order

  @C32904547
  Scenario: C32904547: My Tasks - Due Diligence Order - Verify that view is redirected to Due Diligence Order after clicking order in Orders Overview
    Given User logs into RDDC as "Assignee"
    When User creates third-party "workflowGroupUkraineIndividual"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And User clicks Create Order button
    Then Due Diligence Order form is opened
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    And User populates First Name for Key Principal with "Auto"
    And User populates Last Name for Key Principal with "Principal"
    And User selects Country "Albania" for Key Principal
    And User clicks Add Contact Key Principal button
    And User clicks "Proceed" Alert dialog button
    And User fills in Po No.
    And User clicks "Place Order" button on Due Diligence Order page
    And User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed
    When User navigates to Home page
    And User refreshes page
    And User clicks 'Due Diligence Orders' widget
    And Dashboard table name is "DUE DILIGENCE ORDERS"
    And User selects "Max" items per page
    Then Dashboard Due Diligence Order table contains only expected order's statuses
    When Users clicks first My Tasks table page
    And User selects created Due Diligence Order
    Then Due Diligence Order form is opened
    And Due Diligence Order form contains expected URL
    When User clicks Dashboard link button on Due Diligence Order page
    Then Home page is loaded
    When User clicks 'Due Diligence Orders' widget
    And User selects created Due Diligence Order
    Then Due Diligence Order form is opened
    When User clicks Back button on Due Diligence Order page
    Then Home page is loaded

  @C42870856
  Scenario: C42870856: [React Migration Phase 2] Internal Users Portal - My Tasks: Due Diligence Orders widget - Apply sorting to all pages
    Given User logs into RDDC as "Admin"
    When User clicks 'Due Diligence Orders' widget
    And Users clicks "Order ID" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order ID" in "ASC" order
    When User clicks last page icon
    Then "Due Diligence Orders" table displays records sorted by "Order ID" in "ASC" order
    When Users clicks "Scope" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Scope" in "ASC" order
    When User clicks last page icon
    Then "Due Diligence Orders" table displays records sorted by "Scope" in "ASC" order
    When Users clicks "Order Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Date" in "ASC" order
    When User clicks last page icon
    Then "Due Diligence Orders" table displays records sorted by "Order Date" in "ASC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Status" in "ASC" order
    When User clicks last page icon
    Then "Due Diligence Orders" table displays records sorted by "Order Status" in "ASC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Due Date" in "ASC" order
    When User clicks last page icon
    Then "Due Diligence Orders" table displays records sorted by "Due Date" in "ASC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Requester Name" in "ASC" order
    When User clicks last page icon
    Then "Due Diligence Orders" table displays records sorted by "Requester Name" in "ASC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Approver Name" in "ASC" order
    When User clicks last page icon
    Then "Due Diligence Orders" table displays records sorted by "Approver Name" in "ASC" order
