@ui @sanity @suppliers
Feature: Third-party Onboarding

  As a Supplier Integrity User
  I want I want a way to start the Onboarding process for a Supplier
  So that I can start with the activities that needed to be done to Onboard the suppliers and see which suppliers are currently being Onboarded

  @C32988289 @C36105326
  @multilanguage
  @onlySingleThread
  @core_regression
  @WSO2email
  Scenario: C32988289, C36105326: Supplier Onboarding - Internal User - Assign Activity (Assign Questionnaire) to an External User
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User creates valid email
    And User creates Associated Party "Individual" "with valid email and enabled as user" via API and open it
    And Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    And User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    And Page form is displayed with text
      | Set your Password to better protect your account |
    And User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    And User clicks 'Ok' button
    When User navigates to Home page
    And User clicks 'Assigned Activities' widget
    And Users clicks "ddoActivity.dueDate" dashboard table column header
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
    Then Email notification "Questionnaire Assigned" with following values is received by "current" user
      | <Activity_Name> | External Questionnaire for thirdPartyName |

  @C32988271
  @email
  Scenario: C32988271: Third-party Onboarding - Internal User - Start Onboarding Third-party
    Given User logs into RDDC as "Assignee"
    And User creates third-party "with questionnaire workflow"
    When User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks "Assign Questionnaire Component" component tab
    And User clicks on "Assign Questionnaire" activity
    Then Activity Information page is displayed
    When User approves all activities
    Then Email notification "Activity Assigned" with following values is received by "Assignee" user
      | <Activity_Name> | Assign Questionnaire |
