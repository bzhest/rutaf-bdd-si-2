@ui @smoke @suppliers
Feature: Ad Hoc Activities

  As a Compliance Group User
  I want to be able to create Ad Hoc activities for a Third-Party
  So that I can log additional activities that are not covered in the Onboarding process

  @C44131947
  Scenario: C44131947: Due Diligence Report Ordering - Ad Hoc- Create Ad Hoc Due Diligence Report Orders – Organisation Order Type
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    And Create Due Diligence Order page should be shown with default values for "Organisation" order type
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    And User fills Key Principle form data "Key Principle all fields"
    And User accepts Key Principle module window
    And User clicks Add to List Key Principle button
    Then Order Key Principal table contains records
      | KEY PRINCIPAL NAME       | EMAIL              | ADDRESS                                        |
      | Test title Key Principle | testEmail@test.com | Test address Gotham Gotham state 90210 Ukraine |
    When User clicks none selected scope
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed

  @C44131956
  Scenario: C44131956: Due Diligence Report Approval - Approve and Place Order - Organisation type
    Given User logs into RDDC as "Admin"
    And User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    When User creates third-party "workflowGroupUkraineOrganizationWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks Edit button for Activity
    And User clicks Create Order button
    Then Due Diligence Order form is opened
    When User fills in Po No.
    And User clicks "Manage Key Principal" button on Due Diligence Order page
    And User populates First Name for Key Principal with "Auto"
    And User populates Last Name for Key Principal with "Principal"
    And User selects Country "Albania" for Key Principal
    And User clicks Add Contact Key Principal button
    And User clicks "Proceed" Alert dialog button
    And User clicks Add to List Key Principle button
    And User gets OrderId from Due Diligence Order page URL
    Then "Place Order" button on Due Diligence page is displayed
    When User clicks none selected scope
    Then "Send for Approval" button on Due Diligence page is displayed
    When User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    And User clicks Activity from 'Pending Order for Approval' table
    Then "Approve and Place Order" button on Due Diligence page is displayed
    When User fills in Po No.
    And User fills in Subject Name in Local Language "Subject Name"
    And User fills in Address section values
      | Address Line      | State/Province      | City      | Code postal          | Country |
      | Address Line text | State/Province text | City text | Zip/Postal Code text | Norway  |
    And User clicks "Manage Key Principal" button on Due Diligence Order page
    And User fills Key Principle form data "Key Principle all fields"
    And User accepts Key Principle module window
    And User clicks Add to List Key Principle button
    #    TODO uncomment step when scope list size will be more than 1
#    And User clicks none selected scope
    And User selects Add-ons on position 1
    And User add comment with text "Some short text for comment"
    And User clicks "Approve and Place Order" button on Due Diligence Order page
    Then "THIS IS TO CONFIRM YOUR ORDER DETAILS. WOULD YOU LIKE TO PROCEED?" message for Due Diligence Order is displayed
    When User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed