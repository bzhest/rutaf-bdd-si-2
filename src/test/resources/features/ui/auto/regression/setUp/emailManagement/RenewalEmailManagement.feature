@ui @core_regression @full_regression @email_management
Feature: Email Management Setup - Third-party Pending for Renewal

  As a RDDC Administrator
  I want to be able to view and edit the content of the email sent when Suppliers are pending for Renewal
  So that manage the details being sent to the recipient of the email

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Email Management page
    Then Email Management page is opened
    When User selects "50" items per page

  @C36315524 @C41174624
  @RMS-8743
  @email
  Scenario: C36315524, C41174624: Email Management Setup - Supplier pending for renewal - Edit Supplier pending for renewal template
    Then Email Management table contains following template
      | Template Name                   | Category | Status |
      | Third-party Pending for Renewal |          | Active |
    When User clicks Edit button for "Third-party Pending for Renewal" template row
    And User saves initial "Third-party Pending for Renewal" template data
    Then "Third-party Pending for Renewal" email template page is displayed
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
    And Email Template Name field is not editable and contains value "Third-party Pending for Renewal"
    And Category field is not editable and contains value ""
    And Subject contains text "<Brand_Name> - <Third_Party_Type> Pending for Renewal"
    And Body field contains text
      | Dear <User_First_Name>                                                   |
      | The following is the list of <Third_Party_Type> that is pending renewal: |
      | <Link_To_Third_Party_Name>                                               |
      | For support please visit <Support_Link> customer support portal.         |
      | Best Regards                                                             |
      | <Brand_Name>                                                             |
    And Cancel template button is displayed
    And Save template button is displayed
    When User inputs into the email field "CC" value "toBeReplaced"
    And User inputs into the email field "BCC" value "toBeReplaced"
    And User updates Subject with value "<Client_Name>"
#    TODO Uncomment and replace previous step when RMS-8743 will be fixed
#    And User updates Subject with value "<Link_To_Supplier_Name><Supplier_Responsible_Party_Email><Client_Name><User_First_Name>"
    And User updates Email Body with italic style text "italic text"
    Then Email Body contains italic text "italic text"
    When User updates Email Body with variable "<User_First_Name>"
    Then Email Body contains variable "<User_First_Name>"
    When User align Right text "align right"
    Then Email Body contains text "align right" align right
    When User inserts link "test.com" in Email Body
    Then Email Body contains link "test.com"
    When User inserts table in Email Body
    Then Email Body contains table
    When User clicks Save template button
    And User clicks Set Up option
    And User clicks Workflow Management Renewal Settings submenu in Set Up menu
    And User clicks "Responsible Party" default assignee radio button
    And User clicks Renewal Settings Save button
    And User creates third-party "with renewal workflow Norway"
    And User clicks Start Onboarding for third-party
    And User clicks "Custom Component" tab
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    When User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    And User refreshes page
    Then Third-party's element "Renew" should be shown
#     TODO update expected result when RMS-8743 will be fixed
    And Email notification for template "Third-party Pending for Renewal" is received by "Admin" user
    And Email contains the following text
      | <em>italic text</em>                          |
      | <p style="text-align: right;">align right</p> |
      | <table style="width: 100%;">                  |
      | <a href="http://test.com">test.com</a>        |
      | <p>Admin_AT_FN</p>                            |
    When User opens email link
    Then Third-party Information details are displayed with populated data