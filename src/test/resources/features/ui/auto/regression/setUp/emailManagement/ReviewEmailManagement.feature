@ui @core_regression @full_regression @email_management
Feature: Email Management Setup - Request for Review and Review Rejected

  As a RDDC Administrator
  I want to be able to view and edit the content of the email send when an activity is assigned for Review
  So that manage the details being sent to the recipient of the email

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Email Management page
    Then Email Management page is opened
    When User selects "50" items per page

  @C36188703 @C41174544
  @RMS-8743
  @email
  Scenario: C36188703, C41174544: Email Management Setup - Review Rejected - Edit Review Rejected email template
    Then Email Management table contains following template
      | Template Name   | Category | Status |
      | Review Rejected |          | Active |
    When User clicks Edit button for "Review Rejected" template row
    And User saves initial "Review Rejected" template data
    Then "Review Rejected" email template page is displayed
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
    And Email Template Name field is not editable and contains value "Review Rejected"
    And Category field is not editable and contains value ""
    And Subject contains text "<Brand_Name> - Activity: <Activity_Name> your request for review has been rejected"
    And Body field contains text
      | Dear <User_First_Name>                                                                                                   |
      | Your request for review for Activity <Activity_Name> has been rejected. Click on the following link to view the activity |
      | <Link_Activity>                                                                                                          |
      | For support please visit <Support_Link> customer support portal.                                                         |
      | Best Regards                                                                                                             |
      | <Brand_Name>                                                                                                             |
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
    When User align Left text "align left"
    Then Email Body contains text "align left" align left
    When User inserts link "test.com" in Email Body
    Then Email Body contains link "test.com"
    When User inserts table in Email Body
    Then Email Body contains table
    When User clicks Save template button
    Then Alert Icon is displayed with text
      | Success! Email Template has been updated |
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks +Add Activity button
    And User fills in Activity "Request for Due Diligence Activity" details
    And User clicks Activity "Add Reviewer" tab
    And User selects "Admin_AT_FN Admin_AT_LN" value for Default Reviewer
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Request for Due Diligence" activity
    Then Activity Information page is displayed
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Reject button on confirmation window
    Then Confirmation window is disappeared
    And Email notification "Review Rejected" with following values is received by "Assignee" user
      | <Activity_Name> | Request for Due Diligence |
#    TODO Uncomment when RMS-8743 will be fixed
#      | <User_First_Name> | Admin_AT_FN                   |
#      | <User_Full_Name>  | Admin_AT_FN Admin_AT_LN       |
#      | <Link_Activity>   | AUTO_TEST_ACTIVITY_NAME       |
#      | <Supplier_Name>   | thirdPartyName                |
    And Email contains the following text
      | <strong>bold text</strong>                  |
      | <p style="text-align: left;">align left</p> |
      | <table style="width: 100%;">                |
      | <a href="http://test.com">test.com</a>      |
      | <p>Assignee_AT_FN Assignee_AT_LN</p>        |
    When User opens email link
    Then Activity Information modal is displayed with details
      | Activity Type                      | Activity Name             | Description               | Due Date | Assignee                      | Status |
      | Request for Due Diligence Activity | Request for Due Diligence | Request for Due Diligence | TODAY+1  | Assignee_AT_FN Assignee_AT_LN | Done   |

  @C36267770
  @email
  Scenario: C36267770: Email Management Setup - Request for Review - Edit Request for Review template
    Then Email Management table contains following template
      | Template Name      | Category | Status |
      | Request for Review |          | Active |
    When User clicks Edit button for "Request for Review" template row
    And User saves initial "Request for Review" template data
    Then "Request for Review" email template page is displayed
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
    And Email Template Name field is not editable and contains value "Request for Review"
    And Category field is not editable and contains value ""
    And Subject contains text "<Brand_Name> - Activity: <Activity_Name> Request for Review"
    And Body field contains text
      | Dear <User_First_Name>                                                                              |
      | Activity <Activity_Name> has a request for review. Click on the following link to view the activity |
      | <Link_Activity>                                                                                     |
      | For support please visit <Support_Link> customer support portal.                                    |
      | Best Regards                                                                                        |
      | <Brand_Name>                                                                                        |
    And Cancel template button is displayed
    And Save template button is displayed
    When User inputs into the email field "CC" value "toBeReplaced"
    And User inputs into the email field "BCC" value "toBeReplaced"
    And User updates Subject with value "<Activity_Name>"
#    TODO Uncomment and replace previous step when RMS-8743 will be fixed
#    And User updates Subject with value "<Activity_Name> <User_First_Name> <User_Full_Name> <Link_Activity> <Supplier_Name>"
    And User updates Email Body with underline style text "underline text"
    Then Email Body contains underline text "underline text"
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
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Done button in Activity Reviewers section
    And User clicks Back button to return from Activity modal
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Email notification "Request for Review" with following values is received by "Admin" user
      | <Activity_Name> | AUTO_TEST_ACTIVITY_NAME |
#    TODO Uncomment when RMS-8743 will be fixed
#      | <User_First_Name> | Admin_AT_FN                   |
#      | <User_Full_Name>  | Admin_AT_FN Admin_AT_LN       |
#      | <Link_Activity>   | AUTO_TEST_ACTIVITY_NAME       |
#      | <Supplier_Name>   | thirdPartyName                |
    And Email contains the following text
      | <u>underline text</u>                           |
      | <p style="text-align: center;">align center</p> |
      | <table style="width: 100%;">                    |
      | <a href="http://google.com">google.com</a>      |
      | <p>Admin_AT_FN Admin_AT_LN</p>                  |
    When User opens email link
    Then Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Assignee                | Status |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   |
