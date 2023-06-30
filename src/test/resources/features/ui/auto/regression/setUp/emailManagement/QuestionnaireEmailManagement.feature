@ui @core_regression @full_regression @email_management
Feature: Email Management Setup - Questionnaire

  As an Admin or Internal User that has access right to Email Management
  I Want To be able to configure the email template for questionnaire
  So That client will have the ability to configured the preferred email notification for their user's involve

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Email Management page
    Then Email Management page is opened
    When User selects "50" items per page

  @C36312264
  @RMS-8743
  @onlySingleThread
  @email
  Scenario: C36312264: Email Management Setup - Questionnaire Assigned - Edit Questionnaire Assigned template
    Then Email Management table contains following template
      | Template Name          | Category | Status |
      | Questionnaire Assigned |          | Active |
    When User clicks Edit button for "Questionnaire Assigned" template row
    And User saves initial "Questionnaire Assigned" template data
    Then "Questionnaire Assigned" email template page is displayed
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
    And Email Template Name field is not editable and contains value "Questionnaire Assigned"
    And Category field is not editable and contains value ""
    And Subject contains text "<Brand_Name> - <Activity_Name> has been assigned to you"
    And Body field contains text
      | Dear <Assignee_First_Name>,                                                                     |
      | A new activity has been assigned to you. Click on the following link to view the questionnaire. |
      | <Link_Activity>                                                                                 |
      | Includes the following questionnaire/s:                                                         |
      | <Questionnaire_Name>                                                                            |
      | For support please visit <Support_Link> customer support portal.                                |
      | Best Regards                                                                                    |
      | <Brand_Name>                                                                                    |
    And Cancel template button is displayed
    And Save template button is displayed
    When User inputs into the email field "CC" value "toBeReplaced"
    And User inputs into the email field "BCC" value "toBeReplaced"
    And User updates Subject with value "<Client_Name>"
#    TODO Uncomment and replace previous step when RMS-8743 will be fixed
#    And User updates Subject with value "<User_Full_Name><User_First_Name><User_Last_Name><Assignee_First_Name><Assignee_Last_Name><Link_Activity><Questionnaire_Name><Supplier_Name><Activity_Name><Client_Name>"
    And User updates Email Body with bold style text "bold text"
    Then Email Body contains bold text "bold text"
    When User updates Email Body with variable "<Assignee_Last_Name>"
    Then Email Body contains variable "<Assignee_Last_Name>"
    When User align Center text "align center"
    Then Email Body contains text "align center" align center
    When User inserts link "test.com" in Email Body
    Then Email Body contains link "test.com"
    When User inserts table in Email Body
    Then Email Body contains table
    When User clicks Save template button
    Then Alert Icon is displayed with text
      | Success! Email Template has been updated |
    When User navigates to Third-party page
    And User searches third-party with name "Supplier_Internal_User"
    And User clicks third-party with name "Supplier_Internal_User"
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Assignee_AT_FN Assignee_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    #    TODO update expected result when RMS-8743 will be fixed
    Then Email notification "Questionnaire Assigned" with following values is received by "Assignee" user
      | <Activity_Name> | Internal Questionnaire for Supplier_Internal_User DO NOT DELETE |
    And Email contains the following text
      | <strong>bold text</strong>                      |
      | <p style="text-align: center;">align center</p> |
      | <table style="width: 100%;">                    |
      | <a href="http://test.com">test.com</a>          |
      | <p>Assignee_AT_LN</p>                           |
    When User opens email link
    Then Activity Information modal is displayed with details
      | Activity Type          | Activity Name                                                   | Description                                                      | Due Date | Assignee                      | Status      |
      | Questionnaire Assigned | Internal Questionnaire for Supplier_Internal_User DO NOT DELETE | Click on the link below to view and/or answer the questionnaire. | TODAY+0  | Assignee_AT_FN Assignee_AT_LN | Not Started |

  @C36312392 @C41174532
  @RMS-8743
  @onlySingleThread
  @email
  Scenario: C36312392, C41174532: Email Management Setup - Questionnaire Completed - Edit Questionnaire Completed template
    Then Email Management table contains following template
      | Template Name           | Category | Status |
      | Questionnaire Completed |          | Active |
    When User clicks Edit button for "Questionnaire Completed" template row
    And User saves initial "Questionnaire Completed" template data
    Then "Questionnaire Completed" email template page is displayed
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
    And Email Template Name field is not editable and contains value "Questionnaire Completed"
    And Category field is not editable and contains value ""
    And Subject contains text "<Brand_Name> - <Client_Name> : <Questionnaire_Name> has been completed"
    And Body field contains text
      | Dear <Assignee_First_Name>,                                                              |
      | Questionnaire has been completed. Click on the following link to view the questionnaire. |
      | <Link_Activity>                                                                          |
      | Includes the following questionnaire/s:                                                  |
      | <Questionnaire_Name>                                                                     |
      | For support please visit <Support_Link> customer support portal.                         |
      | Best Regards                                                                             |
      | <Brand_Name>                                                                             |
    And Cancel template button is displayed
    And Save template button is displayed
    When User inputs into the email field "CC" value "toBeReplaced"
    And User inputs into the email field "BCC" value "toBeReplaced"
    And User updates Subject with value "<Client_Name>"
#    TODO Uncomment and replace previous step when RMS-8743 will be fixed
#    And User updates Subject with value "<User_Full_Name><User_First_Name><User_Last_Name><Assignee_First_Name><Assignee_Last_Name><Link_Activity><Questionnaire_Name><Supplier_Name><Activity_Name><Client_Name>"
    And User updates Email Body with bold style text "bold text"
    Then Email Body contains bold text "bold text"
    When User updates Email Body with variable "<Assignee_Last_Name>"
    Then Email Body contains variable "<Assignee_Last_Name>"
    When User align Center text "align center"
    Then Email Body contains text "align center" align center
    When User inserts link "test.com" in Email Body
    Then Email Body contains link "test.com"
    When User inserts table in Email Body
    Then Email Body contains table
    When User clicks Save template button
    Then Alert Icon is displayed with text
      | Success! Email Template has been updated |
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks Back button to return from Activity modal
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Internal Questionnaire for" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Assign Questionnaire" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Review"
    And User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    #    TODO update expected result when RMS-8743 will be fixed
    Then Email notification "Questionnaire Completed" with following values is received by "Admin" user
      | <Questionnaire_Name> | AUTO_TEST_INTERNAL_QUESTIONNAIRE |
    And Email contains the following text
      | <strong>bold text</strong>                      |
      | <p style="text-align: center;">align center</p> |
      | <table style="width: 100%;">                    |
      | <a href="http://test.com">test.com</a>          |
      | <p>Admin_AT_LN</p>                              |
    When User opens email link
    Then Activity Information modal is displayed with details
      | Activity Type        | Activity Name        | Description | Due Date | Assignee                | Status      |
      | Assign Questionnaire | Assign Questionnaire | Description | TODAY+1  | Admin_AT_FN Admin_AT_LN | In Progress |

  @C36312868
  @RMS-8743
  @email
  Scenario: C36312868: Email Management Setup - Questionnaire Review - Edit Questionnaire Review template
    Then Email Management table contains following template
      | Template Name        | Category | Status |
      | Questionnaire Review |          | Active |
    When User clicks Edit button for "Questionnaire Review" template row
    And User saves initial "Questionnaire Review" template data
    Then "Questionnaire Review" email template page is displayed
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
    And Email Template Name field is not editable and contains value "Questionnaire Review"
    And Category field is not editable and contains value ""
    And Subject contains text "<Brand_Name> - <Client_Name> : <Questionnaire_Name> has been assigned to you for review"
    And Body field contains text
      | Dear <Reviewer_First_Name>,                                                                               |
      | Questionnaire has been assigned to you for review. Click on the following link to view the questionnaire. |
      | <Link_Activity>                                                                                           |
      | Includes the following questionnaire/s:                                                                   |
      | <Questionnaire_Name>                                                                                      |
      | For support please visit <Support_Link> customer support portal.                                          |
      | Best Regards                                                                                              |
      | <Brand_Name>                                                                                              |
    And Cancel template button is displayed
    And Save template button is displayed
    When User inputs into the email field "CC" value "toBeReplaced"
    And User inputs into the email field "BCC" value "toBeReplaced"
    And User updates Subject with value "<Client_Name>"
#    TODO Uncomment and replace previous step when RMS-8743 will be fixed
#    And User updates Subject with value "<User_Full_Name><User_First_Name><User_Last_Name><Assignee_First_Name><Assignee_Last_Name><Link_Activity><Questionnaire_Name><Supplier_Name><Activity_Name><Client_Name>"
    And User updates Email Body with bold style text "bold text"
    Then Email Body contains bold text "bold text"
    When User updates Email Body with variable "<Assignee_Last_Name>"
    Then Email Body contains variable "<Assignee_Last_Name>"
    When User align Center text "align center"
    Then Email Body contains text "align center" align center
    When User inserts link "test.com" in Email Body
    Then Email Body contains link "test.com"
    When User inserts table in Email Body
    Then Email Body contains table
    When User clicks Save template button
    Then Alert Icon is displayed with text
      | Success! Email Template has been updated |
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks Back button to return from Activity modal
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Internal Questionnaire for" activity
    When User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" status should be "Submitted"
    #    TODO update expected result when RMS-8743 will be fixed
    And Email notification "Questionnaire Review" with following values is received by "Admin" user
      | <Questionnaire_Name> | AUTO_TEST_INTERNAL_QUESTIONNAIRE |
    And Email contains the following text
      | <strong>bold text</strong>                      |
      | <p style="text-align: center;">align center</p> |
      | <table style="width: 100%;">                    |
      | <a href="http://test.com">test.com</a>          |
      | <p>Admin_AT_LN</p>                              |
    When User opens email link
    Then Activity Information modal is displayed with details
      | Activity Type        | Activity Name        | Description | Due Date | Assignee                | Status  |
      | Assign Questionnaire | Assign Questionnaire | Description | TODAY+1  | Admin_AT_FN Admin_AT_LN | Waiting |

  @C36315489 @C41174537
  @RMS-8743
  @email
  Scenario: C36315489, C41174537: Email Management Setup - Questionnaire Revision Request - Edit Questionnaire Revision Request template
    Then Email Management table contains following template
      | Template Name                  | Category | Status |
      | Questionnaire Revision Request |          | Active |
    When User clicks Edit button for "Questionnaire Revision Request" template row
    And User saves initial "Questionnaire Revision Request" template data
    Then "Questionnaire Revision Request" email template page is displayed
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
    And Email Template Name field is not editable and contains value "Questionnaire Revision Request"
    And Category field is not editable and contains value ""
    And Subject contains text "<Brand_Name> - <Client_Name> : <Questionnaire_Name> has been assigned to you for revision"
    And Body field contains text
      | Dear <Assignee_First_Name>,                                                                                 |
      | Questionnaire has been assigned to you for revision. Click on the following link to view the questionnaire. |
      | <Link_Activity>                                                                                             |
      | Includes the following questionnaire:                                                                       |
      | <Questionnaire_Name>                                                                                        |
      | For support please visit <Support_Link> customer support portal.                                            |
      | Best Regards                                                                                                |
      | <Brand_Name>                                                                                                |
    And Cancel template button is displayed
    And Save template button is displayed
    When User inputs into the email field "CC" value "toBeReplaced"
    And User inputs into the email field "BCC" value "toBeReplaced"
    And User updates Subject with value "<Client_Name>"
#    TODO Uncomment and replace previous step when RMS-8743 will be fixed
#    And User updates Subject with value "<User_Full_Name><User_First_Name><User_Last_Name><Assignee_First_Name><Assignee_Last_Name><Link_Activity><Questionnaire_Name><Supplier_Name><Activity_Name><Client_Name>"
    And User updates Email Body with bold style text "bold text"
    Then Email Body contains bold text "bold text"
    When User updates Email Body with variable "<Assignee_Last_Name>"
    Then Email Body contains variable "<Assignee_Last_Name>"
    When User align Center text "align center"
    Then Email Body contains text "align center" align center
    When User inserts link "test.com" in Email Body
    Then Email Body contains link "test.com"
    When User inserts table in Email Body
    Then Email Body contains table
    When User clicks Save template button
    Then Alert Icon is displayed with text
      | Success! Email Template has been updated |
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks Back button to return from Activity modal
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Internal Questionnaire for" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Assign Questionnaire" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Review"
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    Then Activity Information page is displayed
    #    TODO update expected result when RMS-8743 will be fixed
    Then Email notification "Questionnaire Revision Request" with following values is received by "Admin" user
      | <Questionnaire_Name> | AUTO_TEST_INTERNAL_QUESTIONNAIRE |
    And Email contains the following text
      | <strong>bold text</strong>                      |
      | <p style="text-align: center;">align center</p> |
      | <table style="width: 100%;">                    |
      | <a href="http://test.com">test.com</a>          |
      | <p>Admin_AT_LN</p>                              |
    When User opens email link
    Then Activity Information modal is displayed with details
      | Activity Type          | Activity Name                             | Description                                                      | Due Date | Assignee                | Status      |
      | Questionnaire Assigned | Internal Questionnaire for thirdPartyName | Click on the link below to view and/or answer the questionnaire. | TODAY+0  | Admin_AT_FN Admin_AT_LN | In Progress |
