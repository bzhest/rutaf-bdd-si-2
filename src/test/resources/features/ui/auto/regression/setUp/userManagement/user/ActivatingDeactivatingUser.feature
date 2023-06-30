@ui @core_regression @user_management
Feature: User Management - Activating/Deactivating users

  As a Supplier Integrity Administrator
  I want to be able to be able to activate or deactivate User accounts
  So that I can manage which user accounts can still log into Supplier Integrity

  @C35814781
  @onlySingleThread
  @WSO2email
  Scenario: C35814781: SI Users - verify that existing user (Internal/External) can be activated/deactivated in the System - Internal User
    Given User logs into RDDC as "Admin"
    And User navigates 'Set Up' block 'User' section
    And Users table is displayed
    And User searches user by "Internal_User_For_Editing" keyword
    And User clicks edit user button for user with First Name "Internal_User_For_Editing"
    And User checks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    And User clicks edit user button for user with First Name "Internal_User_For_Editing"
    And User unchecks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User clicks on back User Management button from User page
    Then First fined user is displayed with values
      | First Name                | User Type | Status   |
      | Internal_User_For_Editing | Internal  | INACTIVE |
    And Email notification "Refinitiv Due Diligence Centre - Your Account has been Disabled" is received by "Internal User" user
    And Email "Refinitiv Due Diligence Centre - Your Account has been Disabled" contains the following text
      | Account Disabled                                           |
      | Hi Internal_User_For_Editing,                              |
      | Please note that the account registered with the user name |
      | has been disabled.                                         |
      | Thanks,                                                    |
      | Refinitiv Due Diligence Centre                             |
    And User clicks edit user button for user with First Name "Internal_User_For_Editing"
    When User checks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    Then First fined user is displayed with values
      | First Name                | User Type | Status |
      | Internal_User_For_Editing | Internal  | ACTIVE |
    And Email notification "Refinitiv Due Diligence Centre - Your Account has been Enabled" is received by "Internal User" user
    And Email "Refinitiv Due Diligence Centre - Your Account has been Enabled" contains the following text
      | Account Enabled                                            |
      | Hi Internal_User_For_Editing,                              |
      | Please note that the account registered with the user name |
      | has been enabled.                                          |
      | Thanks,                                                    |
      | Refinitiv Due Diligence Centre                             |

  @C35814781
  @onlySingleThread
  @WSO2email
  Scenario: C35814781: SI Users - verify that existing user (Internal/External) can be activated/deactivated in the System - External User
    Given User logs into RDDC as "Admin"
    And User navigates 'Set Up' block 'User' section
    And Users table is displayed
    And User searches user by "External_User_For_Editing" keyword
    And User clicks edit user button for user with First Name "External_User_For_Editing"
    And User checks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    And User clicks edit user button for user with First Name "External_User_For_Editing"
    And User unchecks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    Then First fined user is displayed with values
      | First Name                | User Type | Status   |
      | External_User_For_Editing | External  | INACTIVE |
    And Email notification "Refinitiv Due Diligence Centre - Your Account has been Disabled" is received by "External User for Password Edit" user
    And Email "Refinitiv Due Diligence Centre - Your Account has been Disabled" contains the following text
      | Account Disabled                                           |
      | Hi External_User_For_Editing,                              |
      | Please note that the account registered with the user name |
      | has been disabled.                                         |
      | Thanks,                                                    |
      | Refinitiv Due Diligence Centre                             |
    And User clicks edit user button for user with First Name "External_User_For_Editing"
    When User checks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    Then First fined user is displayed with values
      | First Name                | User Type | Status |
      | External_User_For_Editing | External  | ACTIVE |
    And Email notification "Refinitiv Due Diligence Centre - Your Account has been Enabled" is received by "External User for Password Edit" user
    And Email "Refinitiv Due Diligence Centre - Your Account has been Enabled" contains the following text
      | Account Enabled                                            |
      | Hi External_User_For_Editing,                              |
      | Please note that the account registered with the user name |
      | has been enabled.                                          |
      | Thanks,                                                    |
      | Refinitiv Due Diligence Centre                             |
