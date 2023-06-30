@ui @core_regression @full_regression @questionnaires
Feature: Email Notifications - Review Assigned Questionnaire Activity

  As an Internal User Onboarding a Supplier
  I want External user to receive an email notification whenever a Supplier is assigned to them for Renewal
  So that I won't miss the task and halt the Renewal process

  @C36136173 @C41174425
  @email @WSO2email
  Scenario: C36136173, C41174425: Questionnaire - External User - verify that External user received Questionnaire Assigned Activity email notification
    Given User logs into RDDC as "Admin"
    And User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    And User creates valid email
    And User creates Associated Party "for questionnaire activity"
    And User clicks Log Out button
    Then Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    And User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    And User logs into RDDC as "user created during test"
    And User clicks Log Out button
    And User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_First_Name" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Email notification "Questionnaire Assigned" with following values is received by "current" user
      | <Activity_Name> | External Questionnaire for thirdPartyName |
