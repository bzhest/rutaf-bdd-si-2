@ui @core_regression @full_regression @email_management
Feature: Email Management Setup - Activity

  As a RDDC Administrator
  I want to be able to view and edit the content of the email sent when an activity is assigned
  So that manage the details being sent to the recipient of the email

  @C36154897
  @RMS-8743
  @email
  Scenario: C36154897: Email Management Setup - Activity Assigned - Edit Activity Assigned email template
    Given User logs into RDDC as "Assignee"
    When User navigates to Email Management page
    Then Email Management page is opened
    When User selects "50" items per page
    Then Email Management table contains following template
      | Template Name     | Category | Status |
      | Activity Assigned |          | Active |
    When User clicks Edit button for "Activity Assigned" template row
    And User saves initial "Activity Assigned" template data
    Then "Activity Assigned" email template page is displayed
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
    And Email Template Name field is not editable and contains value "Activity Assigned"
    And Category field is not editable and contains value ""
    And Subject contains text "<Brand_Name> - Activity: <Activity_Name> has been assigned to you"
    And Body field contains text
      | Dear <User_Full_Name>                                                                     |
      | A new activity has been assigned to you. Click on the following link to view the activity |
      | <Link_Activity>                                                                           |
      | For support please visit <Support_Link> customer support portal.                          |
      | Best Regards                                                                              |
      | <Brand_Name>                                                                              |
    And Cancel template button is displayed
    And Save template button is displayed
    When User inputs into the email field "CC" value "toBeReplaced"
    And User inputs into the email field "BCC" value "toBeReplaced"
    And User updates Subject with value "<Activity_Name>"
#    TODO Uncomment and replace previous step when RMS-8743 will be fixed
#    And User updates Subject with value "<Activity_Name> <User_First_Name> <User_Full_Name> <Link_Activity> <Supplier_Name>"
    And User updates Email Body with bold style text "bold text"
    Then Email Body contains bold text "bold text"
    When User updates Email Body with variable "<User_Full_Name>"
    Then Email Body contains variable "<User_Full_Name>"
    When User align Center text "align center"
    Then Email Body contains text "align center" align center
    When User inserts link "google.com" in Email Body
    Then Email Body contains link "google.com"
    When User inserts table in Email Body
    Then Email Body contains table
    When User clicks Save template button
    Then Alert Icon is displayed with text
      | Success! Email Template has been updated |
    When User creates "Activity Type" "without assessment" via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    Then Email notification "Activity Assigned" with following values is received by "Assignee" user
      | <Activity_Name> | AUTO_TEST_ACTIVITY_NAME |
#    TODO Uncomment when RMS-8743 will be fixed
#      | <User_First_Name> | Assignee_AT_FN                |
#      | <User_Full_Name>  | Assignee_AT_FN Assignee_AT_LN |
#      | <Link_Activity>   | AUTO_TEST_ACTIVITY_NAME       |
#      | <Supplier_Name>   | thirdPartyName                |
    And Email contains the following text
      | <strong>bold text</strong>                      |
      | <p style="text-align: center;">align center</p> |
      | <table style="width: 100%;">                    |
      | <a href="http://google.com">google.com</a>      |
      | <p>Assignee_AT_FN Assignee_AT_LN</p>            |
    When User opens email link
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Start Date | Assignee                      | Initiated By                  | Status      |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | TODAY+0    | Assignee_AT_FN Assignee_AT_LN | Assignee_AT_FN Assignee_AT_LN | Not Started |

  @C36184357
  Scenario: C36184357: Email Management Setup - Validation for CC and BCC fields - Activity Template
    Given User logs into RDDC as "Admin"
    When User navigates to Email Management page
    Then Email Management page is opened
    When User selects "50" items per page
    And User clicks Edit button for "Activity Assigned" template row
    Then "Activity Assigned" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Activity Completed" template row
    Then "Activity Completed" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Approval Rejected" template row
    Then "Approval Rejected" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Request for Approval" template row
    Then "Request for Approval" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Request for Review" template row
    Then "Request for Review" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Review Rejected" template row
    Then "Review Rejected" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"

  @C36184357
  Scenario: C36184357: Email Management Setup - Validation for CC and BCC fields - Questionnaire Template
    Given User logs into RDDC as "Admin"
    When User navigates to Email Management page
    Then Email Management page is opened
    When User selects "50" items per page
    And User clicks Edit button for "Questionnaire Assigned" template row
    Then "Questionnaire Assigned" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Questionnaire Completed" template row
    Then "Questionnaire Completed" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Questionnaire Review" template row
    Then "Questionnaire Review" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Questionnaire Revision Request" template row
    Then "Questionnaire Revision Request" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"

  @C36184357
  Scenario: C36184357: Email Management Setup - Validation for CC and BCC fields - Screening Template
    Given User logs into RDDC as "Admin"
    When User navigates to Email Management page
    Then Email Management page is opened
    When User selects "50" items per page
    And User clicks Edit button for "Screening Delegation" template row
    Then "Screening Delegation" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Screening Delegation Completed" template row
    Then "Screening Delegation Completed" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Third-party Pending for Renewal" template row
    Then "Third-party Pending for Renewal" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "World-Check One screening - Ongoing screening" template row
    Then "World-Check One screening - Ongoing screening" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"

  @C36184357
  Scenario: C36184357: Email Management Setup - Validation for CC and BCC fields - Order Template
    Given User logs into RDDC as "Admin"
    When User navigates to Email Management page
    Then Email Management page is opened
    When User selects "50" items per page
    And User clicks Edit button for "Order Details Update" template row
    Then "Order Details Update" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Order Request Cancelled" template row
    Then "Order Request Cancelled" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Order Request Completed" template row
    Then "Order Request Completed" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Order Request For Approval" template row
    Then "Order Request For Approval" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Order Request In-Progress" template row
    Then "Order Request In-Progress" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Order Request On-Hold" template row
    Then "Order Request On-Hold" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Order Request Placed" template row
    Then "Order Request Placed" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"
    When User clicks Cancel template button
    And User selects "50" items per page
    And User clicks Edit button for "Order Request Rejected" template row
    Then "Order Request Rejected" email template page is displayed
    When User inputs into the email field "CC" value "invalid.com"
    And User inputs into the email field "BCC" value "invalid.com"
    And User clicks Save template button
    Then Alert Icon is displayed with text
      | Cannot Save! Invalid Email Address |
    And Error message "Invalid Email Address" is displayed near "CC"
    And Error message "Invalid Email Address" is displayed near "BCC"

  @C36187993 @C41174267
  @RMS-8743
  @email
  Scenario: C36187993, C41174267: Email Management Setup - Activity Completed - Edit Activity Completed email template
    Given User logs into RDDC as "Admin"
    When User navigates to Email Management page
    Then Email Management page is opened
    When User selects "50" items per page
    Then Email Management table contains following template
      | Template Name      | Category | Status |
      | Activity Completed |          | Active |
    When User clicks Edit button for "Activity Completed" template row
    And User saves initial "Activity Completed" template data
    Then "Activity Completed" email template page is displayed
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
    And Email Template Name field is not editable and contains value "Activity Completed"
    And Category field is not editable and contains value ""
    And Subject contains text "<Brand_Name> - Activity: <Activity_Name> has been completed"
    And Body field contains text
      | Dear <User_First_Name>                                                                        |
      | Activity <Activity_Name> has been completed. Click on the following link to view the activity |
      | <Link_Activity>                                                                               |
      | For support please visit <Support_Link> customer support portal.                              |
      | Best Regards                                                                                  |
      | <Brand_Name>                                                                                  |
    And Cancel template button is displayed
    And Save template button is displayed
    When User inputs into the email field "CC" value "toBeReplaced"
    And User inputs into the email field "BCC" value "toBeReplaced"
    And User updates Subject with value "<Activity_Name>"
#    TODO Uncomment and replace previous step when RMS-8743 will be fixed
#    And User updates Subject with value "<Activity_Name> <User_First_Name> <User_Full_Name> <Link_Activity> <Supplier_Name>"
    And User updates Email Body with bold style text "bold text"
    Then Email Body contains bold text "bold text"
    When User updates Email Body with variable "<User_Full_Name>"
    Then Email Body contains variable "<User_Full_Name>"
    When User align Right text "right text"
    Then Email Body contains text "right text" align right
    When User inserts link "google.com" in Email Body
    Then Email Body contains link "google.com"
    When User inserts table in Email Body
    Then Email Body contains table
    When User clicks Save template button
    Then Alert Icon is displayed with text
      | Success! Email Template has been updated |
    When User creates "Activity Type" "without assessment" via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Email notification "Activity Completed" with following values is received by "Admin" user
      | <Activity_Name> | AUTO_TEST_ACTIVITY_NAME |
#    TODO Uncomment step when RMS-8743 will be fixed
#      | <User_First_Name> | Admin_AT_FN             |
#      | <User_Full_Name>  | Admin_AT_FN Admin_AT_LN |
#      | <Link_Activity>   | AUTO_TEST_ACTIVITY_NAME |
#      | <Supplier_Name>   | thirdPartyName          |
    And Email contains the following text
      | <strong>bold text</strong>                   |
      | <p style="text-align: right;">right text</p> |
      | <table style="width: 100%;">                 |
      | <a href="http://google.com">google.com</a>   |
      | <p>Admin_AT_FN Admin_AT_LN</p>               |
    When User opens email link
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Start Date | Assignee                | Initiated By            | Status    |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | TODAY+0    | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | Completed |