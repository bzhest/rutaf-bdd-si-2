@ui @core_regression @full_regression @ordering
Feature: Due Diligence Report Ordering - Notifications

  As an Admin or Internal User (Order Requester and Approver) that has access right
  I want to received see bell notification whenever a DD order is created or existing order status/details was updated
  So that Client Order requester and Approver can easily see the new notification when currently login

  Background:
    Given User logs into RDDC as "Admin"

  @C36278038
  @onlySingleThread
  @email
  Scenario: C36278038: Due Diligence Report Ordering - Notifications: Send notification when order has been successfully placed - Email notification / "Bell " notification
    When User creates third-party "workflowGroupUkraineIndividual" via API and open it
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
    And User clicks Notification Bell
    Then "Order Request Placed" notification displayed with text
      | orderId |
    When User clicks "Order Request Placed" "orderId" notification
    Then Due Diligence Order form is opened
    And Email notification for template "Order Request Placed" is received by "Admin" user
    When User opens email link
    Then Due Diligence Order form is opened

  @C36295006
  @onlySingleThread
  @email
  Scenario: C36295006: Due Diligence Report Ordering - Notifications: Send notification when order request is sent for approval - Email notification / "Bell " notification
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    When Create Due Diligence Order page should be shown with default values for "Organisation" order type
    And User clicks none selected scope
    And User fills in Po No.
    And User gets OrderId from Due Diligence Order page URL
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User navigates to Home page
    And User clicks Notification Bell
    Then "Order Request pending for approval" notification displayed with text
      | orderId |
    When User clicks "Order Request pending for approval" "orderId" notification
    Then Create Due Diligence Order page is opened
    And Email notification for template "Order Request For Approval" is received by "Admin" user
    When User opens email link
    Then Create Due Diligence Order page is opened
