@ui @robusta @core_regression @questionnaires
Feature: Third-party Information - Workflow Activity - Questionnaire Assigned Activity - Responder Questionnaire Page - Revision Request

  As an Admin or Questionnaire reviewer that has access right
  I want to allow questionnaire reviewer to be able, send the QST to assignee to review again and add request for revision of answer to the Responder
  So that reviewer an provide clarification regarding the question to the responder and give a chance to provide answer again

  @C39520748
  Scenario: C39520748: Questionnaire Assigned - Responder - REQUIRES REVISION - Revision Request - Verify that assignee can respond to the revision request by reviewer
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks "Assign Questionnaire Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    When User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Revision questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Add comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    And User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User selects "Yes" questionnaire answer option
    And User clicks on "Save as Draft" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Revision in Draft |
    When User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User selects "No" questionnaire answer option
    And User clicks on "Cancel" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Revision in Draft |
    When User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User selects "Yes" questionnaire answer option
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Level 1 In Review |
