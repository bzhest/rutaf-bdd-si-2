@ui @full_regression @ordering
Feature: Due Diligence Report Ordering - Declining a Due Diligence Report Order

  As an Internal User that has Access right
  I want to have an option to not proceed in ordering Due Diligence Report
  So that Client still have an option to move forward with the onboarding process without ordering Due Diligence

  Background:
    Given User logs into RDDC as "Admin"

  @C36052039
  @core_regression
  Scenario: C36052039: Due Diligence Report Ordering - Declining a Due Diligence Report Order during Onboarding Process
    When User creates third-party "workflowGroupUkraine"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    Then Create Order button is displayed
    And Decline Order button is displayed
    When User clicks Create Order button
    Then Create Due Diligence Order page is opened
    When User clicks "Decline Order" button on Due Diligence Order page
    Then Modal window with text 'Are you sure you want to decline? This change cannot be undone.' appears
    When User clicks on Cancel button on Due Diligence Order page
    Then Modal window disappears
    And Create Due Diligence Order page is opened
    When User clicks "Decline Order" button on Due Diligence Order page
    And User gets OrderId from Due Diligence Order page URL
    Then Modal window with text 'Are you sure you want to decline? This change cannot be undone.' appears
    When User clicks on Proceed button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - DECLINED TO ORDER"
    And Activity Status drop-down contains the next options
      | In Progress |
      | Done        |
    And Activity Information Assessment field should be enabled
    And Create Order button is not displayed
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"

  @C36053046
  @core_regression
  Scenario: C36053046: Due Diligence Report Ordering - Declining a Due Diligence Report Order - Order Page
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    When User clicks "Decline Order" button on Due Diligence Order page
    Then Modal window with text 'Are you sure you want to decline? This change cannot be undone.' appears
    When User clicks on Cancel button on Due Diligence Order page
    Then Modal window disappears
    And Create Due Diligence Order page is opened
    When User clicks "Decline Order" button on Due Diligence Order page
    And User gets OrderId from Due Diligence Order page URL
    Then Modal window with text 'Are you sure you want to decline? This change cannot be undone.' appears
    When User clicks on Proceed button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - DECLINED TO ORDER"
    And Activity Information Edit button is displayed
    When User clicks Edit button for Activity
    Then Activity Status drop-down contains the next options
      | In Progress |
      | Done        |

  @C36053058
  Scenario: C36053058: Due Diligence Report Ordering - Declining a Due Diligence Report Order - Order Status is "Save as Draft"
    When User creates third-party "workflowGroupUkraine"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    Then Create Order button is displayed
    And Decline Order button is displayed
    When User clicks Create Order button
    Then Create Due Diligence Order page is opened
    When User clicks "Save as Draft" button on Due Diligence Order page
    Then Activity Information modal is displayed with details
      | Activity Type              | Order Details                                |
      | Order Due Diligence Report | ORDER DETAILS: toBeReplaced - SAVED AS DRAFT |
    When User clicks Order Details button
    Then Create Due Diligence Order page is opened
    And "Decline Order" button on Due Diligence page is displayed
    When User clicks "Decline Order" button on Due Diligence Order page
    Then Modal window with text 'Are you sure you want to decline? This change cannot be undone.' appears
    And Cancel button is displayed on Decline Order modal
    And Proceed button is displayed on Decline Order modal
    When User clicks on Cancel button on Due Diligence Order page
    Then Modal window disappears
    When User clicks "Decline Order" button on Due Diligence Order page
    And User gets OrderId from Due Diligence Order page URL
    Then Modal window with text 'Are you sure you want to decline? This change cannot be undone.' appears
    When User clicks on Proceed button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - DECLINED TO ORDER"
    And Activity Status drop-down contains the next options
      | In Progress |
      | Done        |

  @C36325707
  @email
  Scenario: C36325707: Due Diligence Report Approval - Declining Due Diligence Report Orders
    When User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User creates third-party "workflowGroupUkraineOrganizationWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks Create Order button
    Then Due Diligence Order form is opened
    When User clicks none selected scope
    And User fills in Po No.
    And User gets OrderId from Due Diligence Order page URL
    Then "Send for Approval" button on Due Diligence page is displayed
    When User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - FOR APPROVAL"
    When User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    And User clicks Activity from 'Pending Order for Approval' table
    Then Create Due Diligence Order page is opened
    And "Decline Order" button on Due Diligence page is displayed
    When User clicks "Decline Order" button on Due Diligence Order page
    Then Modal window with text 'Are you sure you want to decline? This change cannot be undone.' appears
    And Alert Dialog "Cancel" button displayed
    And Alert Dialog "Proceed" button displayed
    When User clicks on Cancel button on Due Diligence Order page
    Then Modal window disappears
    And Create Due Diligence Order page is opened
    When User clicks "Decline Order" button on Due Diligence Order page
    And User gets OrderId from Due Diligence Order page URL
    Then Modal window with text 'Are you sure you want to decline? This change cannot be undone.' appears
    When User clicks on Proceed button on Due Diligence Order page
    Then Activity Information page is displayed
    And Activity Information Order Details button should contain expected text "ORDER DETAILS: toBeReplaced - DECLINED TO ORDER"
    And Activity Information "Status" is displayed with "In Progress"
    And Email notification "Order Request Rejected" with following values is received by "Admin" user
      | <Approver_FirstName> | <Approver_FirstName> |
    When User opens email link
    Then Due Diligence Order form is opened
    When User clicks Back button on Due Diligence Order page
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    Then Activity Status drop-down contains the next options
      | In Progress |
      | Done        |
    And Activity Information Assessment field should be enabled