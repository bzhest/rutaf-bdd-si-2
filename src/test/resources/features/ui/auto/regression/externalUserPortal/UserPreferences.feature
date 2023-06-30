@ui @user_preferences
Feature: User Preferences

  As a RDDC User
  I want to have a way to configure my User Account Preferences
  So that I can change

  @C35654085
  @core_regression
  @onlySingleThread
  @WSO2email
  Scenario: C35654085: User Preferences - External user - Update all details
    Given User logs into RDDC as "External User for Editing"
    Then User menu items are displayed
      | Preferences |
      | Help        |
      | Log Out     |
    When User clicks Preferences option
    Then My Preferences page for External User is displayed
    And Personal Details section required field "First Name" for External User is enabled
    And Personal Details section required field "Last Name" for External User is enabled
    And Personal Details section field "Position" for External User is enabled
    And Personal Details section photo placeholder for External User is enabled
    And System Setting Date Format for External User is disabled
    And System Setting for External User Date Format is "Month Day Year"
    And System Setting Email Notification for External User is displayed
    And My Preferences page Save button for External User is disabled
    When External User updates First Name Personal Details with value random name
    And External User updates Last Name Personal Details with value random name
    And External User updates Position Personal Details with value random name
    And External User uploads Personal Details "logo.jpg" photo
    And External User clicks Email Notification
    Then My Preferences page Save button for External User is enabled
    When External User clicks Save preferences button
    Then Alert Icon is displayed with text
      | Success! Preferences has been updated |
    Then First Name Personal Details for External User contains expected value
    And Last Name Personal Details for External User contains expected value
    And Position Personal Details for External User contains expected value
    And Personal Details section photo for External User is displayed
    And Email Notification for External User is clicked
    And Profile photo icon on the upper right corner of the screen is displayed for External User
    When User clicks Log Out button
    And User clicks Forgot Password? button
    And User fills email for user "External User for Editing"
    And User clicks 'Reset' password button
    And User clicks 'Ok' button
    Then Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "External User for Editing" user
    And Email "Refinitiv Due Diligence Centre - Password Reset" contains the following text
      | userEditedFirstName |
    When User logs into RDDC as "Admin"
    And User navigates 'Set Up' block 'User' section
    And User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | First Name   | Last Name    | Position     |
      | toBeReplaced | toBeReplaced | toBeReplaced |
