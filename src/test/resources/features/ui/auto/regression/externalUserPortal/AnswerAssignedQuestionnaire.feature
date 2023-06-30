@ui @core_regression @full_regression @questionnaires
Feature: Answering Assigned Questionnaire

  As an Assignee of Questionnaire Activity
  I Want to be able to answer a questionnaire assigned to me and answer with different language translation
  So That I can answer it based on the preferred language from the available option

  @C36136202
  @WSO2email
  Scenario: C36136202: Questionnaire - External User - check completing the Assigned Questionnaire
    Given User creates valid email
    When User logs into RDDC as "Admin"
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User creates Associated Party "for questionnaire activity"
    Then Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    And User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    And User navigates to Home page
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
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
    And User logs into RDDC as "user created during test"
    And User click on "Due within 5 days" widget for External user
    And User click on "Due within 5 days" widget for External user
    And User clicks on assigned activity for created third-party
    Then Activity Information page is displayed
    When User for questionnaire "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" status should be "Submitted"
    When User logs into RDDC as "Admin"