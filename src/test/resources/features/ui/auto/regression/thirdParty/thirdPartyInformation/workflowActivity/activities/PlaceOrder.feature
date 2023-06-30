@ui @core_regression @full_regression @ordering
Feature: Due Diligence Report Ordering - Place Order

  As a requestor of DD
  I want to be able to save the dd order as draft
  So that I can work on the order and submit it later if the details are not yet complete

  @C36198950
  Scenario: C36198950: Due Diligence Report Ordering - Order Page - Place new Order / Save as Draft
    Given User logs into RDDC as "Admin"
    And User makes sure that Custom field "Purchase Order Number" is set as required via API
    When User creates third-party "workflowGroupUkraine"
    And User clicks Start Onboarding for third-party
    And User creates an order for activity "OrderDueDiligenceReport"
    Then Create Due Diligence Order page is opened
    When User clicks "Save as Draft" button on Due Diligence Order page
    And User clicks Order Details button
    And User clicks "Place Order" button on Due Diligence Order page
    Then Alert Icon for Due Diligence Order page is displayed with text
      | Cannot Save                           |
      | Please complete the required field(s) |
    When User waits for progress bar to disappear from page
    And User fills in Po No.
    And User clicks "Place Order" button on Due Diligence Order page
    Then "THIS IS TO CONFIRM YOUR ORDER DETAILS. WOULD YOU LIKE TO PROCEED?" message for Due Diligence Order is displayed
    And "proceed" button on Due Diligence page is displayed
    When User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed
