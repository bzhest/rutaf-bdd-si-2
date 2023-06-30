@ui @smoke @third_party @supplier_onboarding
Feature: Assign Questionnaire Activity

  As an user
  I want to be able to assign questionnaire activity.
  So, I can get email notification about assigned activities

  @C43652461
  @onlySingleThread
  @WSO2email
  Scenario: C43652461: Supplier Onboarding - Internal User - Assign Activity (Assign Questionnaire) to an External User
    Given User logs into RDDC as "Admin"
    And User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    And User creates valid email
    When User creates Associated Party "Individual" "with valid email and enabled as user" via API and open it
    Then Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    And User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    And User navigates to Home page
    And User clicks 'Assigned Activities' widget
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "Max" items per page
    Then Assigned Activity for third-party is displayed
    When User clicks Notification Bell
    Then "Activity has been Assigned" notification displayed with text
      | Assign Questionnaire1 |
    When User clicks "Activity has been Assigned" "Assign Questionnaire1" notification
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    Then Activity Information Assignee can be edited
    When User clicks 'Assign Questionnaire' Activity Information button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Test_First_Name" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status      |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE | Unresponded |
    Then Email notification "Questionnaire Assigned" with following values is received by "current" user
      | <Activity_Name> | External Questionnaire for thirdPartyName |
