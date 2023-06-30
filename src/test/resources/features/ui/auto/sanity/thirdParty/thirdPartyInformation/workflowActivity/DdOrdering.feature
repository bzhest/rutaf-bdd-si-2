@ui @sanity @ordering @multilanguage
Feature: Create Order

  As an Admin or Internal User that has access right
  I want to have an ability to change Order state

  Background:
    Given User logs into RDDC as "Admin"
    When User sets up language via API

  @C34594222
  @onlySingleThread
  Scenario: C34594222: Third-party Onboarding - Order Due Diligence Report - Create Order - Save as Draft
    When User makes sure that Custom field "Billing Entity" is set as not required via API
    And User creates third-party "workflowGroupUkraine"
    And User verifies third-party is created
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And User clicks Create Order button
    When User clicks "ddoActivity.saveAsDraftButton" button on Due Diligence Order page
    And Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description              | Order Details                                  | Due Date | Assignee     | Status  |
      | Order Due Diligence Report | OrderDueDiligenceReport | Test Automation activity | ORDER DETAILS: toBeReplaced - {SAVED AS DRAFT} | TODAY+1  | toBeReplaced | Waiting |
    When User clicks Order Details button
    And User fills City field with "Kyiv"
    And User clicks "ddoActivity.saveAsDraftButton" button on Due Diligence Order page
    When User clicks Order Details button
    Then City field is displayed with "Kyiv"

  @C34594223
  @onlySingleThread
  Scenario: C34594223: Third-party Onboarding - Order Due Diligence Report - Cancel Declining of Order
    When User opens Due Diligence Custom Required Fields page
    And I make sure that "customRequiredFields.billingEntity" Required checkbox is "unchecked"
    And I make sure that "customRequiredFields.purchaseOrderNumber" Required checkbox is "unchecked"
    And User creates third-party "workflowGroupUkraine"
    And User verifies third-party is created
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    Then Create Order button is displayed
    And Decline Order button is displayed
    When User clicks Create Order button
    Then Create Due Diligence Order page should be shown with default values for "Organisation" order type
    When User clicks "ddoActivity.declineOrderButton" button on Due Diligence Order page
    Then Modal window with text 'ddoActivity.refuseOrderMessage' appears
    When User clicks on Cancel button on Due Diligence Order page
    Then Modal window disappears
    When User clicks "ddoActivity.placeOrderButton" button on Due Diligence Order page
    Then "ddoActivity.confirmOrderMessage" message for Due Diligence Order is displayed

  @C34594224
  @onlySingleThread
  Scenario: C34594224: Third-party Onboarding - Order Due Diligence Report - Created Order (Individual) with Recommended Scope
    Given User creates third-party "workflowGroupUkraineIndividual"
    And User clicks Start Onboarding for third-party
    When User creates an order for activity "OrderDueDiligenceReport"
    Then Create Due Diligence Order page is opened
    And "ddoActivity.placeOrderButton" button on Due Diligence page is displayed
    When User clicks "ddoActivity.manageKeyPrinciple" button on Due Diligence Order page
    And User populates First Name for Key Principal with "Auto"
    And User populates Last Name for Key Principal with "Principal"
    And User selects Country "Albania" for Key Principal
    And User clicks Add Contact Key Principal button
    And User clicks "ddoActivity.proceedCapitalizeButton" Alert dialog button
    Then Due Diligence Subject Full Name is populated with "Auto Principal"
    And Due Diligence Country "Albania" is displayed
    When User closes Key Principle creation alert
    And User fills in Po No.
    And User clicks "ddoActivity.placeOrderButton" button on Due Diligence Order page
    Then "ddoActivity.confirmOrderMessage" message for Due Diligence Order is displayed
    And "ddoActivity.proceedButton" button on Due Diligence page is displayed
    When User on confirmation block clicks "ddoActivity.proceedButton"
    Then "ddoActivity.createOrderCongratulationMessage" message for Due Diligence Order is displayed

  @C34594225
  @onlySingleThread
  Scenario: C34594225: Third-party Onboarding - Order Due Diligence Report - Created Order (Organisation)with Recommended Scope
    Given User creates third-party "workflowGroupUkraine"
    And User clicks Start Onboarding for third-party
    When User creates an order for activity "OrderDueDiligenceReport"
    Then Create Due Diligence Order page is opened
    And "ddoActivity.placeOrderButton" button on Due Diligence page is displayed
    When User fills in Po No.
    And  User clicks "ddoActivity.placeOrderButton" button on Due Diligence Order page
    Then "ddoActivity.confirmOrderMessage" message for Due Diligence Order is displayed
    And "ddoActivity.proceedButton" button on Due Diligence page is displayed
    When User on confirmation block clicks "ddoActivity.proceedButton"
    Then "ddoActivity.createOrderCongratulationMessage" message for Due Diligence Order is displayed

  @C34594226
  @onlySingleThread
#    Test results could be affected by Due Diligence Order Approval settings, check if test user is in default approver group
  Scenario: C34594226: Third-party Onboarding - Order Due Diligence Report - Approve and Place Order (Organisation) with Non Recommended scope
    When User makes sure that Custom field "Billing Entity" is set as not required via API
    And User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User creates third-party "workflowGroupUkraineOrganizationWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks "thirdPartyInformation.approversSection.approveButton" approve action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Edit button for Activity
    Then Create Order button is displayed
    When User clicks Create Order button
    Then "ddoActivity.placeOrderButton" button on Due Diligence page is displayed
    When User clicks none selected scope
    Then "ddoActivity.sendForApprovalButton" button on Due Diligence page is displayed
    When User gets OrderId from Due Diligence Order page URL
    And User fills in Po No.
    And User clicks "ddoActivity.sendForApprovalButton" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    And User clicks Activity from 'Pending Order for Approval' table
    Then "ddoActivity.approveAndPlaceOrderButton" button on Due Diligence page is displayed
    When User clicks "ddoActivity.approveAndPlaceOrderButton" button on Due Diligence Order page
    Then "ddoActivity.confirmOrderMessage" message for Due Diligence Order is displayed
    When User on confirmation block clicks "ddoActivity.proceedButton"
    Then "ddoActivity.createOrderCongratulationMessage" message for Due Diligence Order is displayed

  @C34594227
  @onlySingleThread
#    Test results could be affected by Due Diligence Order Approval settings, check if test user is in default approver group
  Scenario: C34594227: Third-party Onboarding - Order Due Diligence Report - Approve and Place Order (Individual) with Non Recommended scope
    When User makes sure that Custom field "Billing Entity" is set as not required via API
    And User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User opens third-party creation form
    And User fills third-party creation form with third-party's test data "workflowGroupUkraineIndividualWithApprover"
    And User submits Third-party creation form
    And User verifies third-party is created
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks "thirdPartyInformation.approversSection.approveButton" approve action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Edit button for Activity
    Then Create Order button is displayed
    When User clicks Create Order button
    Then "ddoActivity.placeOrderButton" button on Due Diligence page is displayed
    When User clicks "ddoActivity.manageKeyPrinciple" button on Due Diligence Order page
    And User fills Key Principle form data "Key Principle mandatory fields"
    And User accepts Key Principle module window
    And User clicks none selected scope
    Then "ddoActivity.sendForApprovalButton" button on Due Diligence page is displayed
    When User gets OrderId from Due Diligence Order page URL
    And User fills in Po No.
    And User clicks "ddoActivity.sendForApprovalButton" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    And User clicks Activity from 'Pending Order for Approval' table
    Then "ddoActivity.approveAndPlaceOrderButton" button on Due Diligence page is displayed
    When User clicks "ddoActivity.approveAndPlaceOrderButton" button on Due Diligence Order page
    Then "ddoActivity.confirmOrderMessage" message for Due Diligence Order is displayed
    When User on confirmation block clicks "ddoActivity.proceedButton"
    Then "ddoActivity.createOrderCongratulationMessage" message for Due Diligence Order is displayed
