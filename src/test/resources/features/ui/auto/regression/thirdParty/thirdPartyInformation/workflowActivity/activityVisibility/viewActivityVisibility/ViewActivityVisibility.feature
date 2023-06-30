@ui @activity_details
Feature: Third-party Information - Workflow Activity - Activity Visibility - View Activity Visibility

  As a user
  I want to view the DDO page based on my division
  So that I will be able to see the DDO page only the one page that based on my division

  Background:
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

  @C45018108
  @core_regression
  Scenario: C45018108: [TP and Activity Visibility] DDO page- Adjust Visibility based on Division and user
  approver-Verify that the valid user can access DDO via Activity list
    When User navigates to Home page
    And User refreshes page
    And User clicks 'Due Diligence Orders' widget
    And User selects created Due Diligence Order
    Then Due Diligence Order form is opened

  @C45018110
  @full_regression
  Scenario: C45018110: [TP and Activity Visibility] DDO page- Adjust Visibility based on Division and user
  approver-Verify that the valid user can access DDO workflow activity via On screen notification
    When User navigates to Home page
    And User refreshes page
    Then Home page is loaded
    When User clicks Notification Bell
    Then The list with notifications is shown
    When User clicks "Order Request Placed" "orderId" notification
    Then Due Diligence Order form is opened



