@ui @sanity @questionnaires
Feature: Questionnaire Assigned

  As as Admin Or Internal User that has access right
  I Want To be able to assign Questionnaire to either Internal or External user
  So That Client should be able to gather relevant information in order to make better decision in onboarding supplier

  @C32988290 @C32988292
  @email
  Scenario: C32988290, C32988292: Email Notification - External User - Verify that External User received Questionnaire Assigned Activity email notification
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And  User navigates to Third-party page
    Then Third-party Overview tab is loaded
    When User searches third-party with name "Supplier_External_User"
    And User clicks third-party with name "Supplier_External_User"
    And User clicks on Questionnaire tab
    When User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Ad Hoc Activity with name "External Questionnaire for Supplier_External_User DO NOT DELETE" is created
    And Email notification "Questionnaire Assigned" with following values is received by "External" user
      | <Activity_Name> | External Questionnaire for Supplier_External_User DO NOT DELETE |
    And Email contains the following text
      | Dear External_AT_FN,                                                                                                 |
      | A new activity has been assigned to you. Click on the following link to view the questionnaire                       |
      | External Questionnaire for Supplier_External_User DO NOT DELETE                                                      |
      | Includes the following questionnaire/s:                                                                              |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE                                                                                     |
      | For support please visit <a href="https://my.refinitiv.com" target="_blank">MyRefinitiv</a> customer support portal. |
      | Best Regards,                                                                                                        |
      | Refinitiv Due Diligence Centre                                                                                       |
    When User logs into RDDC as "External"
    And User opens email link
    Then Activity Information page is displayed