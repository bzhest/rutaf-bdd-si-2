@ui @functional @user_preferences
Feature: Home Page - Main Menu - My Preferences

  As a RDDC User
  I want to have a way to configure my User Account Preferences
  So that I can make changes when needed

  @C40182167 @C32909596
  @onlySingleThread
  @email @WSO2email
  Scenario: C40182167, C32909596: User Preferences - Internal user - My Preferences Page - ON/OFF emails verifications
  User - My Preferences - Email Notification set to ON - Verify that user should be able to receive email notifications from any Activity
    Given User logs into RDDC as "Internal User for Editing"
    When User clicks User Menu
    And User clicks Preferences option
    And User turns On Email Notification
    And User clicks Save preferences button
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assign Questionnaire Responsible Party Assignee"
    And User creates third-party "with workflow group Ukraine"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    And Email notification "Activity Assigned" with following values is received by "Internal User for Editing" user
      | <Activity_Name> | Auto Activity |
    When User clicks on "Auto Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    And Email notification "Activity Completed" with following values is received by "Internal User for Editing" user
      | <Activity_Name> | Auto Activity |
    When User deletes last emails for user "Internal User for Editing"
    And User clicks User Menu
    And User clicks Preferences option
    And User turns Off Email Notification
    And User clicks Save preferences button
    Then Alert Icon is displayed with text
      | Success! Preferences has been updated |
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks Offboard button
    And User clicks Offboard button on confirmation window
    Then Confirmation window should be Disappeared
    When User clicks Start Onboarding for third-party
    Then Email notification "Activity Assigned" with following values is not received by "Internal User for Editing" user
      | <Activity_Name> | Auto Activity |
    When User clicks on "Auto Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    And Email notification "Activity Completed" with following values is not received by "Internal User for Editing" user
      | <Activity_Name> | Auto Activity |
    When User clicks Log Out button
    And User clicks Forgot Password? button
    And User fills email for user "Internal User for Editing"
    And User clicks 'Reset' password button
    And User clicks 'Ok' button
    Then Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "Internal User for Editing" user
    When User logs into RDDC as "Admin"

  @C32909598
  Scenario: C32909598: User Preference - Verify that Change password link and password field is hidden
    Given User logs into RDDC as "Admin"
    When User clicks User Menu
    And User clicks Preferences option
    Then Preference Page doesn't contain Password field