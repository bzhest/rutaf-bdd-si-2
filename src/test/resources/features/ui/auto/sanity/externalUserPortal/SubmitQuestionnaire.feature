@ui @sanity @questionnaires
Feature: Submit questionnaire

  As as Admin Or Internal User that has access right
  I Want To be able to assign Questionnaire to either Internal or External user
  So That Client should be able to gather relevant information in order to make better decision in onboarding supplier

  @C32988293
  @email
  Scenario: C32988293: Third-party Onboarding - External User - Submit Questionnaire
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And  User navigates to Third-party page
    Then Third-party Overview tab is loaded
    When User searches third-party with name "Supplier_External_User"
    And User clicks third-party with name "Supplier_External_User"
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Email notification "Questionnaire Assigned" with following values is received by "External" user
      | <Activity_Name> | External Questionnaire for Supplier_External_User DO NOT DELETE |
    When User logs into RDDC as "External"
    And User click on "Due within 5 days" widget for External user
    And User clicks on assigned activity with name "Supplier_External_User"
    Then Activity Information page is displayed
    When User for questionnaire "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" clicks link "activity.answerLink"
    And User clicks on "questionnaire.submitButton" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" status should be "Submitted"
    When User logs into RDDC as "Approver"
    Then Email notification "Questionnaire Review" with following values is received by "Approver" user
      | <Questionnaire_Name> | AUTO_TEST_EXTERNAL_QUESTIONNAIRE |
    And Email contains the following text
      | Dear Questionnaire_Approver_AT_FN,                                                                        |
      | Questionnaire has been assigned to you for review. Click on the following link to view the questionnaire. |
      | External Questionnaire for Supplier_External_User DO NOT DELETE                                           |
      | Best Regards,                                                                                             |
      | Refinitiv Due Diligence Centre                                                                            |
    And User opens email link
    And User for questionnaire "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" clicks link "questionnaire.review"
    Then User should see Questionnaire Overall Assessment button "questionnaire.rejectButton"
    And User should see Questionnaire Overall Assessment button "questionnaire.approveButton"