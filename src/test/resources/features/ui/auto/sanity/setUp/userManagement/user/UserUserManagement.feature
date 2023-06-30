@ui @sanity @user_management @multilanguage
Feature: User Management - User

  As a Supplier Integrity Administrator
  I want to be able to create user accounts
  So that I can give access to the users who neeDd to use Supplier Integrity


  @C32987284 @C35814716 @C35801186
  @full_regression @core_regression
  @WSO2email
  Scenario: C32987284, C35814716, C35801186: User Management - Add Internal User
    Given User creates valid email
    And User logs into RDDC as "Admin"
    And User sets up language via API
    And User navigates 'Set Up' block 'User' section
    When User clicks 'Add New User' button
    Then Add User page is loaded
    And User Type is "Internal"
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User searches user by first name
    Then User table contains user with values
      | First Name   | Last Name    | User Name    | User Type | Role                 | Status | Single Sign On |
      | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | ACTIVE | user.noValue   |
    And Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received

  @C32987285 @C35801417
  @core_regression
  Scenario: C32987285, C35801417: User Management - Update Internal User details
    Given User creates valid email
    And User logs into RDDC as "Admin"
    And User sets up language via API
    And User navigates 'Set Up' block 'User' section
    When User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User searches user by first name
    Then First fined user is displayed with values
      | First Name   | Last Name           | User Name    | User Type | Role                 | Status | Single Sign On |
      | toBeReplaced | AUTO TEST Last Name | toBeReplaced | Internal  | System Administrator | ACTIVE | user.noValue   |
    When User clicks edit user button by name
    Then Edit User page is displayed
    When User fills in "First Name" Edit User value "toBeReplaced"
    And User fills in "Last Name" Edit User value "AUTO TEST Edit Last Name"
    And User selects in "Role" Edit User value "AUTO TEST ROLE WITH RESTRICTIONS"
    And User selects in "Division" Edit User value "Operations"
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    And User searches user by first name
    Then First fined user is displayed with values
      | First Name   | Last Name                | User Name    | User Type | Role                             | Status | Single Sign On |
      | toBeReplaced | AUTO TEST Edit Last Name | toBeReplaced | Internal  | AUTO TEST ROLE WITH RESTRICTIONS | ACTIVE | user.noValue   |
    When User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | First Name   | Last Name                | Email        | User Name    | User Type | Role                             | Status | Organisation | Division   |
      | toBeReplaced | AUTO TEST Edit Last Name | toBeReplaced | toBeReplaced | Internal  | AUTO TEST ROLE WITH RESTRICTIONS | Active | RFG          | Operations |
