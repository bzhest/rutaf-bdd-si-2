@ui @core_regression @full_regression @email_management
Feature: Email Management Setup - Order Request

  As a RDDC Administrator
  I want to be able to view and edit the content of the email send when an activity is assigned for Review
  So that manage the details being sent to the recipient of the email

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Email Management page
    Then Email Management page is opened
    When User selects "50" items per page

  @C36308509 @C41174420 @C40222031
  @email
  Scenario: C36308509, C41174420, C40222031: Email Management Setup - Order Request Placed - Edit Order Request Placed template
    Then Email Management table contains following template
      | Template Name        | Category            | Status |
      | Order Request Placed | Order Due Diligence | Active |
    When User clicks Edit button for "Order Request Placed" template row
    And User saves initial "Order Request Placed" template data
    Then "Order Request Placed" email template page is displayed
    And There are the following fields displayed
      | Variable            |
      | Value               |
      | CC                  |
      | BCC                 |
      | Email Template Name |
      | Active              |
      | Category            |
      | Subject             |
      | Language            |
    And Email Template Name field is not editable and contains value "Order Request Placed"
    And Category field is not editable and contains value "Order Due Diligence"
    And Subject contains text "<Brand_Name> - Order request successfully placed"
    And Body field contains text
      | Dear <Requestor_FirstName>,                                                                                          |
      | Your order has been successfully placed with reference no <Order_Id>. Click on the following link to view the order: |
      | <Link_To_IC_Order>                                                                                                   |
      | For support please visit <Support_Link> customer support portal.                                                     |
      | Best Regards                                                                                                         |
      | <Brand_Name>                                                                                                         |
    And Cancel template button is displayed
    And Save template button is displayed
    When User inputs into the email field "CC" value "toBeReplaced"
    And User inputs into the email field "BCC" value "toBeReplaced"
    And User updates Subject with value "<Requestor_FirstName>"
#    TODO Uncomment and replace previous step when RMS-8743 will be fixed
#    And User updates Subject with value "<Requestor_FirstName> <Order_Id> <Link_To_IC_Order>"
    And User updates Email Body with bold style text "bold text"
    Then Email Body contains bold text "bold text"
    When User updates Email Body with variable "<Requestor_FirstName>"
    Then Email Body contains variable "<Requestor_FirstName>"
    When User align Right text "align right"
    Then Email Body contains text "align right" align right
    When User inserts link "test.com" in Email Body
    Then Email Body contains link "test.com"
    When User inserts table in Email Body
    Then Email Body contains table
    When User clicks Save template button
    Then Alert Icon is displayed with text
      | Success! Email Template has been updated |
    When User creates third-party "workflowGroupUkraineOrganizationWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks "Approve" approve action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Edit button for Activity
    Then Create Order button is displayed
    When User clicks Create Order button
    Then Due Diligence Order form is opened
    When User fills in Po No.
    And User clicks "Place Order" button on Due Diligence Order page
    And User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed
      #    TODO change expected result when RMS-8743 will be fixed
    And Email notification "Order Request Placed" with following values is received by "Admin" user
      | <Requestor_FirstName> | <Requestor_FirstName> |
    And Email contains the following text
      | <strong>bold text</strong>                    |
      | <p style="text-align: right;">align right</p> |
      | <table style="width: 100%;">                  |
      | <a href="http://test.com">test.com</a>        |
      | <p>Admin_AT_FN</p>                            |
    When User opens email link
    Then Due Diligence Order form is opened

  @C36307352 @C41174419 @C40222028
  @email
  Scenario: C36307352, C41174419, C40222028: Email Management Setup - Order Request For Approval - Edit Order Request For Approval template
    Then Email Management table contains following template
      | Template Name              | Category            | Status |
      | Order Request For Approval | Order Due Diligence | Active |
    When User clicks Edit button for "Order Request For Approval" template row
    And User saves initial "Order Request For Approval" template data
    Then "Order Request For Approval" email template page is displayed
    And There are the following fields displayed
      | Variable              |
      | Value                 |
      | CC                    |
      | BCC                   |
      | Notification Reminder |
      | Email Template Name   |
      | Active                |
      | Category              |
      | Subject               |
      | Language              |
    And Email Template Name field is not editable and contains value "Order Request For Approval"
    And Category field is not editable and contains value "Order Due Diligence"
    And Subject contains text "<Brand_Name> - Order Request is Pending for approval"
    And Body field contains text
      | Dear <Approver_FirstName>,                                                                                                                                      |
      | The Due Diligence Report order request by <Requestor_Name> with reference no. <Order_Id> requires your approval. Click on the following link to view the order: |
      | <Link_To_IC_Order>                                                                                                                                              |
      | For support please visit <Support_Link> customer support portal.                                                                                                |
      | Best Regards                                                                                                                                                    |
      | <Brand_Name>                                                                                                                                                    |
    And Cancel template button is displayed
    And Save template button is displayed
    When User inputs into the email field "CC" value "toBeReplaced"
    And User inputs into the email field "BCC" value "toBeReplaced"
    And User updates Subject with value "<Approver_FirstName>"
#    TODO Uncomment and replace previous step when RMS-8743 will be fixed
#    And User updates Subject with value "<Approver_FirstName><Requestor_FirstName> <Order_Id> <Link_To_IC_Order>"
    And User updates Email Body with bold style text "bold text"
    Then Email Body contains bold text "bold text"
    When User updates Email Body with variable "<Approver_FirstName>"
    Then Email Body contains variable "<Approver_FirstName>"
    When User align Right text "align right"
    Then Email Body contains text "align right" align right
    When User inserts link "test.com" in Email Body
    Then Email Body contains link "test.com"
    When User inserts table in Email Body
    Then Email Body contains table
    When User clicks Save template button
    Then Alert Icon is displayed with text
      | Success! Email Template has been updated |
    When User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    When Create Due Diligence Order page should be shown with default values for "Organisation" order type
    And User clicks none selected scope
    And User fills in Po No.
    And User gets OrderId from Due Diligence Order page URL
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
   #    TODO change expected result when RMS-8743 will be fixed
    And Email notification "Order Request For Approval" with following values is received by "Admin" user
      | <Approver_FirstName> | <Approver_FirstName> |
    And Email contains the following text
      | <strong>bold text</strong>                    |
      | <p style="text-align: right;">align right</p> |
      | <table style="width: 100%;">                  |
      | <a href="http://test.com">test.com</a>        |
      | <p>Admin_AT_FN</p>                            |
    When User opens email link
    Then Due Diligence Order form is opened
    And Create Order page Available Scope section for "Organisation" should be shown with expected values

  @C36309119 @C41174424 @C40222032
  @RMS-8743
  @email
  Scenario: C36309119, C41174424, C40222032: Email Management Setup - Order Request Rejected - Edit Order Request Rejected template
    Then Email Management table contains following template
      | Template Name          | Category            | Status |
      | Order Request Rejected | Order Due Diligence | Active |
    When User clicks Edit button for "Order Request Rejected" template row
    And User saves initial "Order Request Rejected" template data
    Then "Order Request Rejected" email template page is displayed
    And There are the following fields displayed
      | Variable            |
      | Value               |
      | CC                  |
      | BCC                 |
      | Email Template Name |
      | Active              |
      | Category            |
      | Subject             |
      | Language            |
    And Email Template Name field is not editable and contains value "Order Request Rejected"
    And Category field is not editable and contains value "Order Due Diligence"
    And Subject contains text "<Brand_Name> - Order request for approval has been rejected"
    And Body field contains text
      | Dear <Requestor_FirstName>,                                                                                                          |
      | Your order request with reference no <Order_Id> has been rejected by <Approver_Name>. Click on the following link to view the order: |
      | <Link_To_IC_Order>                                                                                                                   |
      | For support please visit <Support_Link> customer support portal.                                                                     |
      | Best Regards                                                                                                                         |
      | <Brand_Name>                                                                                                                         |
    And Cancel template button is displayed
    And Save template button is displayed
    When User inputs into the email field "CC" value "toBeReplaced"
    And User inputs into the email field "BCC" value "toBeReplaced"
    And User updates Subject with value "<Approver_FirstName>"
#    TODO Uncomment and replace previous step when RMS-8743 will be fixed
#    And User updates Subject with value "<Approver_FirstName><Requestor_FirstName> <Order_Id> <Link_To_IC_Order>"
    And User updates Email Body with bold style text "bold text"
    Then Email Body contains bold text "bold text"
    When User updates Email Body with variable "<Requestor_FirstName>"
    Then Email Body contains variable "<Requestor_FirstName>"
    When User align Right text "align right"
    Then Email Body contains text "align right" align right
    When User inserts link "test.com" in Email Body
    Then Email Body contains link "test.com"
    When User inserts table in Email Body
    Then Email Body contains table
    When User clicks Save template button
    Then Alert Icon is displayed with text
      | Success! Email Template has been updated |
    When User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User creates third-party "workflowGroupUkraineOrganizationWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks Edit button for Activity
    Then Create Order button is displayed
    When User clicks Create Order button
    And User clicks none selected scope
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
#    When User navigates to Home page
#    And User clicks 'Pending Orders For Approval' widget
#    And User clicks Activity from 'Pending Order for Approval' table
    When User clicks Order Details button
    And User clicks "Decline Order" button on Due Diligence Order page
    Then Modal window with text 'Are you sure you want to decline? This change cannot be undone.' appears
    When User clicks on Proceed button on Due Diligence Order page
    Then Activity Information page is displayed
    #    TODO change expected result when RMS-8743 will be fixed
    And Email notification "Order Request Rejected" with following values is received by "Admin" user
      | <Approver_FirstName> | <Approver_FirstName> |
    And Email contains the following text
      | <strong>bold text</strong>                    |
      | <p style="text-align: right;">align right</p> |
      | <table style="width: 100%;">                  |
      | <a href="http://test.com">test.com</a>        |
      | <p>Admin_AT_FN</p>                            |
    When User opens email link
    Then Due Diligence Order form is opened
    And Create Order page Available Scope section for "Organisation" should be shown with expected values
