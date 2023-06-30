@ui @full_regression @ordering
Feature: Due Diligence Report Ordering - Creating Due Diligence Report Order in the Onboarding Process

  As a RDDC Administrator
  I want to be able to create Due Diligence Report Order
  So that orders will be successfully submitted

  Background:
    Given User logs into RDDC as "Admin"

  @C35983520
  @core_regression
  Scenario: C35983520: Creating Due Diligence Report Order in the Onboarding Process – Organisation Order Type - Recommended Scope
    When User creates third-party "workflowGroupUkraine"
    Then Third-party's status should be shown - "NEW"
    When User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    Then Activities table should contain the following activity
      | Name                    | Type                       | Assigned To             | Due Date | Status      |
      | OrderDueDiligenceReport | Order Due Diligence Report | Admin_AT_FN Admin_AT_LN | TODAY+1  | Not Started |
    When User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information page is displayed
    And Activity Information Edit button is displayed
    When User clicks Edit button for Activity
    Then Activity Information Edit button is hidden
    When User clicks Create Order button
    Then Due Diligence Order form is opened
    And Order type is "Organisation"
    And Create Order page Available Scope section for "Organisation" should be shown with expected values
    And "Place Order" button on Due Diligence page is displayed
    When User fills in Po No.
    And User clicks "Place Order" button on Due Diligence Order page
    Then "THIS IS TO CONFIRM YOUR ORDER DETAILS. WOULD YOU LIKE TO PROCEED?" message for Due Diligence Order is displayed
    When User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed

  @C36014553
  @core_regression
  Scenario: C36014553: Creating Due Diligence Report Orders in the Onboarding Process – Individual Order Type - Recommended Scope
    When User creates third-party "workflowGroupUkraineIndividual" via API and open it
    Then Third-party's status should be shown - "NEW"
    When User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    Then Activities table should contain the following activity
      | Name                    | Type                       | Assigned To             | Due Date | Status      |
      | OrderDueDiligenceReport | Order Due Diligence Report | Admin_AT_FN Admin_AT_LN | TODAY+1  | Not Started |
    When User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information page is displayed
    And Activity Information Edit button is displayed
    When User clicks Edit button for Activity
    Then Activity Information Edit button is hidden
    When User clicks Create Order button
    Then Due Diligence Order form is opened
    And Order type is "Individual"
    And Create Order page Available Scope section for "Individual" should be shown with expected values
    And "Place Order" button on Due Diligence page is displayed
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    And User populates First Name for Key Principal with "Auto"
    And User populates Last Name for Key Principal with "Principal"
    And User selects Country "Albania" for Key Principal
    And User clicks Add Contact Key Principal button
    And User clicks "Proceed" Alert dialog button
    Then Due Diligence Subject Full Name is populated with "Auto Principal"
    And Due Diligence Country "Albania" is displayed
    And User fills in Po No.
    When User clicks "Place Order" button on Due Diligence Order page
    Then "THIS IS TO CONFIRM YOUR ORDER DETAILS. WOULD YOU LIKE TO PROCEED?" message for Due Diligence Order is displayed
    When User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed

  @C36079430
  Scenario: C36079430: Due Diligence Report Ordering - Create Order/Edit Order - Change Order type
    When User creates third-party "workflowGroupUkraine"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And User clicks Create Order button
    And User selects "Individual" Due Diligence Order Type
    Then Create Due Diligence Order page is opened
    When User gets OrderId from Due Diligence Order page URL
    Then Create Order page Available Scope section for "Individual" should be shown with expected values
    And Create Due Diligence Order page should be shown with default values for "Individual" order type
    When User clicks "Save as Draft" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - SAVED AS DRAFT"
    When User clicks Order Details button
    Then Create Due Diligence Order page is opened
    And Order type is "Individual"
    When User selects "Organisation" Due Diligence Order Type
    Then Create Due Diligence Order page should be shown with default values for "Organisation" order type
    When User clicks "Save as Draft" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - SAVED AS DRAFT"
    When User clicks Order Details button
    Then Create Due Diligence Order page is opened
    And Order type is "Organisation"

  @C36187816
  Scenario: C36187816: Due Diligence Report Ordering - Update Order: Edit "Order Due Diligence Report" with "Save as Draft" Status (Scope, Comment, Attachment)
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And User clicks Create Order button
    Then Create Due Diligence Order page is opened
    When User gets OrderId from Due Diligence Order page URL
    And User clicks "Save as Draft" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - SAVED AS DRAFT"
    When User clicks Order Details button
    Then Create Due Diligence Order page is opened
    When User gets OrderId from Due Diligence Order page URL
    And User add comment with text "Some short text for comment"
    Then User should see created comment
    When User adds Order attachment
      | File Name   | Description          |
      | csvFile.csv | Activity description |
    Then Create Order page Attachment table row appears
      | File Name   | Description          | Uploaded by             | Upload Date |
      | csvFile.csv | Activity description | Admin_AT_FN Admin_AT_LN | TODAY       |
    When User selects "Organisation" Due Diligence Order Type
    And User fills in Po No.
    And User fills in Requester on behalf "Requestor on behalf text"
    And User fills in Subject Name in Local Language "Subject Name"
    And User fills in Address section values
      | Address Line      | State/Province      | City      | Code postal          | Country |
      | Address Line text | State/Province text | City text | Zip/Postal Code text | Norway  |
    And User clicks "Manage Key Principal" button on Due Diligence Order page
    And User fills Key Principle form data "Key Principle all fields"
    And User accepts Key Principle module window
    And User clicks Add to List Key Principle button
    And User selects Add-ons on position 1
    Then "Place Order" button on Due Diligence page is displayed
    And "Decline Order" button on Due Diligence page is displayed
    And "Save as Draft" button on Due Diligence page is displayed
    When User clicks "Save as Draft" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - SAVED AS DRAFT"
    When User clicks Order Details button
    Then Create Due Diligence Order page is opened
    And Order type is "Organisation"
    And User should see created comment
    And Create Order page Attachment table row appears
      | File Name   | Description          | Uploaded by             | Upload Date |
      | csvFile.csv | Activity description | Admin_AT_FN Admin_AT_LN | TODAY       |
    And Create Order page Header section should be shown with provided "Organisation" Order Type and selected Billing Entity and default values
    And Create Order page Subject Details section for "Organisation" order type should be shown with "Subject Name" Subject Local Name expected values
    And Create Order page Address section should be shown with expected values
      | Address Line      | State/Province      | City      | Code postal          | Country |
      | Address Line text | State/Province text | City text | Zip/Postal Code text | Norway  |
    And Order Key Principal table contains records
      | KEY PRINCIPAL NAME       | EMAIL              | ADDRESS                                        |
      | Test title Key Principle | testEmail@test.com | Test address Gotham Gotham state 90210 Ukraine |
    When User selects "Individual" Due Diligence Order Type
    And User fills in Po No.
    And User fills in Requester on behalf "Requestor on behalf text"
    And User clicks "Manage Key Principal" button on Due Diligence Order page
    And User fills Key Principle form data "Key Principle all fields"
    And User accepts Key Principle module window
    Then Create Order page Address section should be shown with expected values
      | Address Line | City   | Code postal | State/Province | Country |
      | Test address | Gotham | 90210       | Gotham state   | Ukraine |
    And User fills in Address section values
      | Address Line      | State/Province      | City      | Code postal          | Country |
      | Address Line text | State/Province text | City text | Zip/Postal Code text | Ukraine |
#    TODO uncomment step when scope list size will be more than 1
#    And User clicks none selected scope
    And User add comment with text "Some short text for comment 2"
    And User adds Order attachment
      | File Name   | Description            |
      | csvFile.csv | Activity description 2 |
    Then "Send for Approval" button on Due Diligence page is displayed
    And "Decline Order" button on Due Diligence page is displayed
    And "Save as Draft" button on Due Diligence page is displayed
    When User clicks "Save as Draft" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - SAVED AS DRAFT"
    When User clicks Order Details button
    Then Create Due Diligence Order page is opened
    And Order type is "Individual"
    And User should see created comment
    And Create Order page Attachment table row appears
      | File Name   | Description            | Uploaded by             | Upload Date |
      | csvFile.csv | Activity description   | Admin_AT_FN Admin_AT_LN | TODAY       |
      | csvFile.csv | Activity description 2 | Admin_AT_FN Admin_AT_LN | TODAY       |
    And Create Order page Header section should be shown with provided "Individual" Order Type and selected Billing Entity and default values
    Then Due Diligence Subject Full Name is populated with "Key Principle"
    And Create Order page Address section should be shown with expected values
      | Address Line      | State/Province      | City      | Code postal          | Country |
      | Address Line text | State/Province text | City text | Zip/Postal Code text | Ukraine |
