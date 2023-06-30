@ui @robusta @core_regression @questionnaires
Feature: Third-party Information - Workflow Activity - Activity Visibility - Questionnaire Assigned Activity - Comment Question

  As an Admin or Questionnaire Assignee that has access right
  I Want To allow questionnaire assignee to reply to comment
  So That it will help the reviewer assess the questionnaire again with the new response

  @C32987551
  Scenario: C32987551: Questionnaire Assigned - Responder - REQUIRES REVISION - Comment - Verify that assignee can respond to the comment by reviewer
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
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    And User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then Questionnaire answer form comment counter is displayed with value "1"
    When User clicks Comment questionnaire button
    Then Questionnaire answer form comment modal contains comment with text "test comment"
    When User clicks Questionnaire Answer comment Reply button
    Then Questionnaire answer form comment input is displayed
    And Questionnaire answer form comment Send button is disabled
    And Questionnaire answer form comment input max length is "5000" symbols
    When User fills in Comment text "test reply"
    Then Questionnaire answer form comment Send button is enabled
    When User clicks Send comment button
    Then Questionnaire answer form comment on position 2 contains data
      | Admin_AT_FN Admin_AT_LN |
      | MM/dd/yyyy 'at' h:mm a  |
      | test reply              |
    And Questionnaire answer form comment on position 2 "Delete" button is enabled
    And Questionnaire answer form comment on position 2 "Edit" button is enabled
    When User clicks Done comment button
    Then Questionnaire answer form comment modal is not displayed
    And Questionnaire answer form comment counter is displayed with value "2"
    When User clicks on "Save as Draft" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Revision in Draft |
    When User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User clicks Questionnaire Answer comment Reply button
    And User fills in Comment text "test reply 2"
    And User clicks Send comment button
    Then Questionnaire answer form comment on position 3 contains data
      | Admin_AT_FN Admin_AT_LN |
      | MM/dd/yyyy 'at' h:mm a  |
      | test reply 2            |
    When User clicks Done comment button
    Then Questionnaire answer form comment modal is not displayed
    And Questionnaire answer form comment counter is displayed with value "3"
    When User clicks on "Cancel" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Revision in Draft |
    When User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then Questionnaire answer form comment counter is displayed with value "2"
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Level 1 In Review |
