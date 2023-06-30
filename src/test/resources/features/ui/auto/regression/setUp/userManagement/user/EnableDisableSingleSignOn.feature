@ui @core_regression @user_management
Feature: User Management - Enabling/Disabling Single Sign-On

  @C35845680
  Scenario: C35845680: SI Users - verify that Single Sign on can be Enabled/Disabled
    Given User logs into RDDC as "Admin"
    And User navigates 'Set Up' block 'User' section
    And Users table is displayed
    And User searches user by "Internal_User_For_Editing" keyword
    And User clicks edit user button for user with First Name "Internal_User_For_Editing"
    When User checks 'Enable Single Sign On' Edit User checkbox
    And User clicks Proceed button on confirmation window
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    Then First fined user is displayed with values
      | First Name                | Single Sign On |
      | Internal_User_For_Editing | Yes            |
    And User clicks edit user button for user with First Name "Internal_User_For_Editing"
    When User unchecks 'Enable Single Sign On' Edit User checkbox
    And User clicks Proceed button on confirmation window
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    Then First fined user is displayed with values
      | First Name                | Single Sign On |
      | Internal_User_For_Editing | No             |
