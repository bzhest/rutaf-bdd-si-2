@ui @smoke @third_party
Feature: External User Portal - Questionnaire Assigned

  As an External user
  I want to be able to answer on assigned questionnaire

  @C44131952
  @email
  Scenario: C44131952: Third-party Onboarding - External User - Submit Questionnaire
    Given User logs into RDDC as "Admin"
    When  User navigates to Third-party page
    Then Third-party Overview tab is loaded
    When User searches third-party with name "Supplier_External_User"
    And User clicks third-party with name "Supplier_External_User"
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User logs into RDDC as "External"
    And User click on "Due within 5 days" widget for External user
    And User clicks on assigned activity with name "Supplier_External_User"
    Then Activity Information page is displayed
    When User for questionnaire "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" status should be "Submitted"
    When User logs into RDDC as "Approver"
    Then Email notification "Questionnaire Review" with following values is received by "Approver" user
      | <Questionnaire_Name> | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE |