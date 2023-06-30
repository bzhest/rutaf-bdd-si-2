@ui @functional @user_management
Feature: Set Up - User Management - Reset Password

  As a RDDC Internal User with appropriate permissions
  I want to be able to reset the passwords of RDDC IdP Accounts
  So that I can send reset instructions to Users who have forgotten their passwords

  @C40220516
  @onlySingleThread
  @WSO2email
  Scenario: C40220516: [Reset Password] - Internal Users - Reset password from user details view page - SSO is OFF
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And Users table is displayed
    And User searches user by "Internal_User_For_Editing" keyword
    And User clicks edit user button for user with First Name "Internal_User_For_Editing"
    And User checks 'Active' Edit User checkbox
    And User unchecks 'Enable Single Sign On' Edit User checkbox
    And User clicks Proceed button on confirmation window
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    And User searches user by "Internal_User_For_Editing" keyword
    And User clicks on user with First Name "Internal_User_For_Editing"
    And User clicks User form button "Reset Password"
    Then Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "Internal User" user
    When User opens "Refinitiv Due Diligence Centre - Password Reset" email link
    And User fills Enter New Password field with value for user "Internal User"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    And User clicks 'Ok' button
    And User clicks Log Out button
    And User logs into RDDC as "Internal User"
    Then Home page is loaded

  @C40220517
  @WSO2email
  Scenario: C40220517: [Reset Password] - External Users - Reset password from user details view page - SSO is OFF
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And Users table is displayed
    And User searches user by "External_User_For_Editing" keyword
    And User clicks edit user button for user with First Name "External_User_For_Editing"
    And User checks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    And User searches user by "External_User_For_Editing" keyword
    And User clicks on user with First Name "External_User_For_Editing"
    And User clicks User form button "Reset Password"
    Then Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "External user for password edit" user
    When User opens "Refinitiv Due Diligence Centre - Password Reset" email link
    And User fills Enter New Password field with value for user "External user for password edit"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    And User clicks 'Ok' button
    And User clicks Log Out button
    And User logs into RDDC as "External user for password edit"
    Then Home page is loaded
