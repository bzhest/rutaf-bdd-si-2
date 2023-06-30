@ui @core_regression @full_regression @ordering
Feature: Due Diligence Report Ordering - List of Orders

  As a RDDC Administrator
  I want to be able to view Due Diligence Report Orders
  So that I can see orders are correctly displayed with details

  @C36136901
  Scenario: C36136901: Due Diligence Report Ordering - List of Orders: "Due Diligence Orders" Overview / View Due Diligence Report Order
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    And User selects "Individual" Due Diligence Order Type
    And User clicks "Manage Key Principal" button on Due Diligence Order page
    And User populates First Name for Key Principal with "Auto"
    And User populates Last Name for Key Principal with "Principal"
    And User selects Country "Albania" for Key Principal
    And User clicks Add Contact Key Principal button
    And User clicks "Proceed" Alert dialog button
    And User fills in Po No.
    And User clicks none selected scope
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on "Third-party Information" tab on Third-party page
    And User clicks on Create Order under Due Diligence Order section
    And User gets OrderId from Due Diligence Order page URL
    And User clicks "Save as Draft" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on "Third-party Information" tab on Third-party page
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And User clicks Create Order button
    Then Order type is "Organisation"
    When User fills in Po No.
    And User clicks "Place Order" button on Due Diligence Order page
    And User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed
    When User clicks Back button on Due Diligence Order page
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
#    Then Text is shown when hover over Risk Rating help icon on DDO section
#      | The risk score is Refinitiv's proprietary rating system that enables quicker decision making when evaluating key third parties. |
#      | It's based on identified red flags, an evaluation of their validity, and the risk they may represent to your business.          |
    Then Last created order is on the top of DDO list
    When User opens DD order with status "New"
    Then The Due Diligence order screen is displayed with the following details
      | Order ID                 | toBeReplaced                   |
      | PO Number                | toBeReplaced                   |
      | Order Type               | Organisation                   |
      | Order Status             | New                            |
      | Approver                 | Admin_AT_FN Admin_AT_LN        |
      | Order Date               | TODAY+                         |
      | Due Date                 |                                |
      | Date Completed           |                                |
      | Requester                | Admin_AT_FN Admin_AT_LN        |
      | Requester Email          | admin.username                 |
      | Requester on behalf of   |                                |
      | Risk Rating              |                                |
      | Subject Details          |                                |
      | List of Key Principal(s) |                                |
      | Due Diligence Scope      | Bronze Company (QA-Regression) |
      | Attachment               |                                |
      | Comment                  |                                |
    When User clicks Back button on Due Diligence Order page
    Then Text is shown when hover over Risk Rating help icon on DDO page
      | The risk score is Refinitiv's proprietary rating system that enables quicker decision making when evaluating key third parties. |
      | It's based on identified red flags, an evaluation of their validity, and the risk they may represent to your business.          |
    When User clicks 'sort DD orders icon' on "Order Id"
    Then DD orders are sorted by "Order Id" in "ASC" order
    When User clicks 'sort DD orders icon' on "Order Id"
    Then DD orders are sorted by "Order Id" in "DESC" order
    When User clicks 'sort DD orders icon' on "Order Type"
    Then DD orders are sorted by "Order Type" in "DESC" order
    When User clicks 'sort DD orders icon' on "Order Type"
    Then DD orders are sorted by "Order Type" in "ASC" order
    When User clicks 'sort DD orders icon' on "Subject Name"
    Then DD orders are sorted by "Subject Name" in "DESC" order
    When User clicks 'sort DD orders icon' on "Subject Name"
    Then DD orders are sorted by "Subject Name" in "ASC" order
    When User clicks 'sort DD orders icon' on "Status"
    Then DD orders are sorted by "Status" in "ASC" order
    When User clicks 'sort DD orders icon' on "Status"
    Then DD orders are sorted by "Status" in "DESC" order
    When User clicks 'sort DD orders icon' on "Scope"
    Then DD orders are sorted by "Scope" in "ASC" order
    When User clicks 'sort DD orders icon' on "Scope"
    Then DD orders are sorted by "Scope" in "DESC" order
