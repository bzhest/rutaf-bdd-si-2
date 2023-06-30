@ui @core_regression @full_regression @questionnaires
Feature: Review Assigned Questionnaire Activity

  As an Admin or Questionnaire reviewer that has access right
  I Want To allow questionnaire reviewer to be approve/Reject questionnaire to other reviewer
  SO That Other relevant user should be able to see the assessment of reviewer and make better decisions

  @C36136210 @C41174533
  @email
  Scenario: C36136210, C41174533: Questionnaire - Internal User - check Review Assigned Questionnaire Activity
    Given User logs into RDDC as "Admin"
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    When User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    When User logs into RDDC as "APPROVER"
    And User navigates to Home page
    And User clicks 'Assigned Activities' widget
    And Users clicks "Due Date" dashboard table column header
    And User clicks on assigned activity for created third-party
    And User clicks Edit button for Activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" status should be "Submitted"
    And Email notification "Questionnaire Review" with following values is received by "Admin" user
      | <Questionnaire_Name> | AUTO_TEST_INTERNAL_QUESTIONNAIRE |
    And Email contains the following text
      | Dear Admin_AT_FN,                                                                                         |
      | Questionnaire has been assigned to you for review. Click on the following link to view the questionnaire. |
      | For support please visit                                                                                  |
      | https://my.refinitiv.com                                                                                  |
      | MyRefinitiv                                                                                               |
      | customer support portal.                                                                                  |
      | Best Regards,                                                                                             |
      | Refinitiv Due Diligence Centre                                                                            |
    When User logs into RDDC as "Admin"
    And User opens email link
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Review"
    And User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    And User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "In Progress"
    And Email notification "Questionnaire Completed" with following values is received by "Admin" user
      | <Questionnaire_Name> | AUTO_TEST_INTERNAL_QUESTIONNAIRE |
    And Email notification "Activity Assigned" with following values is received by "Admin" user
      | <Activity_Name> | Auto Activity |