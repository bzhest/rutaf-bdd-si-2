@ui @full_regression @dashboard
Feature: Dashboard - Pending Orders for Approval

  As an Admin or Internal User that has access right
  I Want To display all active Due Diligence Order Request that requires my approval in the Dashboard
  So That Approver can easily see in the dashboard

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User creates third-party "with random ID name" via API and open it
    And User makes sure that Custom field "Purchase Order Number" is set as required via API
    And User clicks on Create Order under Due Diligence Order section
    And User clicks none selected scope
    And User gets OrderId from Due Diligence Order page URL
    And User clicks "Send for Approval" button on Due Diligence Order page
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - FOR APPROVAL"

  @C36214515
  @onlySingleThread
  @core_regression
  Scenario: C36214515: Supplier - Dashboard - Viewing Pending Orders for Approval - Reassign DD Order
    When User navigates to Home page
    Then Counter for Pending Orders For Approval is displayed
    When User clicks 'Pending Orders For Approval' widget
    And User clicks Activity from 'Pending Order for Approval' table
    Then Due Diligence Order form is opened
    When User selects "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" Due Diligence Order Approver
    And User clicks "Save" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User navigates to Home page
    Then Activity is excluded from Pending Orders For Approval counter
    When User clicks 'Pending Orders For Approval' widget
    Then Pending Due Diligence Order is removed from the list

  @C36214571
  @onlySingleThread
  @core_regression
  Scenario: C36214571: Supplier - Dashboard - Viewing Pending Orders for Approval - Approve DD Order
    When User navigates to Home page
    Then Counter for Pending Orders For Approval is displayed
    When User clicks 'Pending Orders For Approval' widget
    And User clicks Activity from 'Pending Order for Approval' table
    Then Due Diligence Order form is opened
    When User clicks "Approve and Place Order" button on Due Diligence Order page
    Then Confirmation block should be displayed
    And "THIS IS TO CONFIRM YOUR ORDER DETAILS. WOULD YOU LIKE TO PROCEED?" message for Due Diligence Order is displayed
    When User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed
    When User navigates to Home page
    Then Activity is excluded from Pending Orders For Approval counter
    When User clicks 'Pending Orders For Approval' widget
    Then Pending Due Diligence Order is removed from the list

  @C36211074
  Scenario: C36211074: Supplier - Dashboard - View Pending Orders for Approval Widget
    When User navigates to Home page
    Then Dashboard Pending Orders For Approval widget counter displayed with expected count
    When User clicks 'Pending Orders For Approval' widget
    Then Dashboard Pending Orders For Approval table is displayed with column names
      | ORDER ID | SCOPE | ORDER DATE | ORDER STATUS | REQUESTER NAME | APPROVER NAME |
    And Users clicks "Order ID" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Order ID" in "ASC" order
    When Users clicks "Order ID" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Order ID" in "DESC" order
    When Users clicks "Scope" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Scope" in "ASC" order
    When Users clicks "Scope" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Scope" in "DESC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Order Status" in "ASC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Order Status" in "DESC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Requester Name" in "ASC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Requester Name" in "DESC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Approver Name" in "ASC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Assigned Activities" table displays records sorted by "Approver Name" in "DESC" order
    When User clicks 'Pending Orders For Approval' widget
    Then Dashboard table is not displayed
