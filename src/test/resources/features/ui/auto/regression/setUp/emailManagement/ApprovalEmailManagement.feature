@ui @core_regression @full_regression @email_management
Feature: Email Management Setup - Request for Approval and Approval Rejected

  As a RDDC Administrator
  I want to be able to view and edit the content of the email send when an activity is assigned for Approval
  So that manage the details being sent to the recipient of the email

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Email Management page
    Then Email Management page is opened
    When User selects "50" items per page

  @C36216212 @C41174276
  @RMS-8743
  @email
  Scenario: C36216212, C41174276: Email Management Setup - Approval Rejected - Edit Approval Rejected email template
    Then Email Management table contains following template
      | Template Name     | Category | Status |
      | Approval Rejected |          | Active |
    When User clicks Edit button for "Approval Rejected" template row
    And User saves initial "Approval Rejected" template data
    Then "Approval Rejected" email template page is displayed
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
    And Email Template Name field is not editable and contains value "Approval Rejected"
    And Category field is not editable and contains value ""
    And Subject contains text "<Brand_Name> - Activity: <Activity_Name> your request for approval has been rejected"
    And Body field contains text
      | Dear <User_First_Name>                                                                                                     |
      | Your request for approval for Activity <Activity_Name> has been rejected. Click on the following link to view the activity |
      | <Link_Activity>                                                                                                            |
      | For support please visit <Support_Link> customer support portal.                                                           |
      | Best Regards                                                                                                               |
      | <Brand_Name>                                                                                                               |
    And Cancel template button is displayed
    And Save template button is displayed
    When User inputs into the email field "CC" value "toBeReplaced"
    And User inputs into the email field "BCC" value "toBeReplaced"
    And User updates Subject with value "<Activity_Name>"
#    TODO Uncomment and replace previous step when RMS-8743 will be fixed
#    And User updates Subject with value "<Activity_Name> <User_First_Name> <User_Full_Name> <Link_Activity> <Supplier_Name>"
    And User updates Email Body with italic style text "italic text"
    Then Email Body contains italic text "italic text"
    When User updates Email Body with variable "<User_Full_Name>"
    Then Email Body contains variable "<User_Full_Name>"
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
    And User clicks "Reject" approve action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Reject button on confirmation window
    Then Confirmation window is disappeared
    And Email notification "Approval Rejected" with following values is received by "Admin" user
      | <Activity_Name>    | OrderDueDiligenceReport |
      | <Third_Party_Name> | OrderDueDiligenceReport |
#    TODO Uncomment when RMS-8743 will be fixed
#      | <User_First_Name> | Admin_AT_FN                   |
#      | <User_Full_Name>  | Admin_AT_FN Admin_AT_LN       |
#      | <Link_Activity>   | OrderDueDiligenceReport       |
#      | <Supplier_Name>   | thirdPartyName                |
    And Email contains the following text
      | <em>italic text</em>                          |
      | <p style="text-align: right;">align right</p> |
      | <table style="width: 100%;">                  |
      | <a href="http://test.com">test.com</a>        |
      | <p>Admin_AT_FN Admin_AT_LN</p>                |
    When User opens email link
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description | Due Date | Assignee                | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | description | TODAY+1  | Admin_AT_FN Admin_AT_LN | Not Started |

  @C36215996 @C41174538
  @RMS-8743
  @email
  Scenario: C36215996, C41174538: Email Management Setup - Request for Approval - Edit Request for Approval email template
    Then Email Management table contains following template
      | Template Name        | Category | Status |
      | Request for Approval |          | Active |
    When User clicks Edit button for "Request for Approval" template row
    And User saves initial "Request for Approval" template data
    Then "Request for Approval" email template page is displayed
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
    And Email Template Name field is not editable and contains value "Request for Approval"
    And Category field is not editable and contains value ""
    And Subject contains text "<Brand_Name> - Activity: <Activity_Name> Request for approval"
    And Body field contains text
      | Dear <User_First_Name>                                           |
      | Activity <Activity_Name> has a request for approval              |
      | Click on the following link to view the activity                 |
      | <Link_Activity>                                                  |
      | For support please visit <Support_Link> customer support portal. |
      | Best Regards                                                     |
      | <Brand_Name>                                                     |
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
    When User align Right text "align right"
    Then Email Body contains text "align right" align right
    When User inserts link "google.com" in Email Body
    Then Email Body contains link "google.com"
    When User inserts table in Email Body
    Then Email Body contains table
    When User clicks Save template button
    Then Alert Icon is displayed with text
      | Success! Email Template has been updated |
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    Then Email notification "Request for Approval" with following values is received by "Admin" user
      | <Activity_Name> | Assign Questionnaire |
#    TODO Uncomment when RMS-8743 will be fixed
#      | <User_First_Name> | Admin_AT_FN                   |
#      | <User_Full_Name>  | Admin_AT_FN Admin_AT_LN       |
#      | <Link_Activity>   | Assign Questionnaire          |
#      | <Supplier_Name>   | thirdPartyName                |
    And Email contains the following text
      | <u>underline text</u>                         |
      | <p style="text-align: right;">align right</p> |
      | <table style="width: 100%;">                  |
      | <a href="http://google.com">google.com</a>    |
      | <p>Admin_AT_FN Admin_AT_LN</p>                |
    When User opens email link
    Then Activity Information modal is displayed with details
      | Activity Type        | Activity Name        | Description | Due Date | Assignee                      | Status      |
      | Assign Questionnaire | Assign Questionnaire | Description | TODAY+1  | Assignee_AT_FN Assignee_AT_LN | Not Started |

