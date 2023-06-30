@ui @core_regression @full_regression @ordering
Feature: Due Diligence Report Approval

  As an Admin or Internal User that has access right
  I Want To automatically trigger approval based on the rules only when scope was changed from the recommended scope
  So That It would require approval first before the request push through

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up Due Diligence Order Approval Responsible Party Default Approver via API

  @C36324370 @C37447497
  @email
  Scenario: C36324370, C37447497: Due Diligence Report Approval - Approve and Place Order - Organisation type
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
    And Email notification for template "Order Request For Approval" is received by "Admin" user
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
    When User clicks "Approve and Place Order" button on Due Diligence Order page
    Then "THIS IS TO CONFIRM YOUR ORDER DETAILS. WOULD YOU LIKE TO PROCEED?" message for Due Diligence Order is displayed
    When User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed

  @C36324370 @C37447497
  @email
  Scenario: C36324370, C37447497: Due Diligence Report Approval - Approve and Place Order - Individual type
    When User creates third-party "workflowGroupUkraineIndividualWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
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
    Then "Place Order" button on Due Diligence page is displayed
    When User clicks none selected scope
    Then "Send for Approval" button on Due Diligence page is displayed
    When User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Email notification for template "Order Request For Approval" is received by "Admin" user
    When User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    And User clicks Activity from 'Pending Order for Approval' table
    Then "Approve and Place Order" button on Due Diligence page is displayed
    When User fills in Po No.
    And User fills in Address section values
      | Address Line      | State/Province      | City      | Code postal          | Country |
      | Address Line text | State/Province text | City text | Zip/Postal Code text | Norway  |
    And User clicks "Manage Key Principal" button on Due Diligence Order page
    And User fills Key Principle form data "Key Principle all fields"
    And User accepts Key Principle module window
    And User selects Subject Full name "Key Principle"
#    TODO uncomment step when scope list size will be more than 1
#    And User clicks none selected scope
    And User selects Add-ons on position 1
    When User clicks "Approve and Place Order" button on Due Diligence Order page
    Then Confirmation block should be displayed
    And "THIS IS TO CONFIRM YOUR ORDER DETAILS. WOULD YOU LIKE TO PROCEED?" message for Due Diligence Order is displayed
    When User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed

  @C36326407
  @email
  Scenario: C36326407: Due Diligence Report Approval - Reassigning the Approval of Due Diligence Report Orders
    When User creates third-party "workflowGroupUkraineIndividualWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
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
    Then "Place Order" button on Due Diligence page is displayed
    When User clicks none selected scope
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    And User clicks Activity from 'Pending Order for Approval' table
    Then Create Due Diligence Order page is opened
    And "Decline Order" button on Due Diligence page is enabled
    And "Approve and Place Order" button on Due Diligence page is enabled
    And "Save" button on Due Diligence page is enabled
    When User selects "Assignee_AT_FN Assignee_AT_LN" Due Diligence Order Approver
#    TODO uncomment when question related REACT migration will be resolved
#    Then "Decline Order" button on Due Diligence page is disabled
#    And "Approve and Place Order" button on Due Diligence page is disabled
    When User clicks "Save" button on Due Diligence Order page
    Then Email notification for template "Order Request For Approval" is received by "Assignee" user
