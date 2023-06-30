@ui @full_regression @dashboard
Feature: Dashboard - Viewing Due Diligence Report Orders

  @C36200086
  @core_regression
  Scenario: C36200086: Supplier - Dashboard - View Due Diligence Order Request Widget
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
    And User refreshes page
    And User clicks 'Due Diligence Orders' widget
    And User selects created Due Diligence Order
    Then Due Diligence Order form is opened
    When User clicks Back button on Due Diligence Order page
    And User clicks 'Due Diligence Orders' widget
    Then Due Diligence Orders count is as expected for logged in user
    And Due Diligence Orders requested by User are displayed in table
    When Users clicks "Scope" dashboard table column header
    And Users clicks "Scope" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Scope" in "DESC" order
    When Users clicks "Scope" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Scope" in "ASC" order
    When Users clicks "Order Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Date" in "ASC" order
    When Users clicks "Order Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Date" in "DESC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Status" in "ASC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Status" in "DESC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Due Date" in "ASC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Due Date" in "DESC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Requester Name" in "ASC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Requester Name" in "DESC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Approver Name" in "ASC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Approver Name" in "DESC" order

  @C36200365
  Scenario: C36200365: Supplier - Dashboard - Display zero in the Due Diligence Order Request Widget
    Given User logs into RDDC as "Internal User for Editing"
    Then Dashboard Due Diligence Orders widget is disabled
    And Dashboard Due Diligence Orders widget counter contains 0 count