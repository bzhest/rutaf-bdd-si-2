@ui @sanity @user_management @multilanguage
Feature: User Management - Role

  As a Supplier Integrity Administrator
  I want to be able to assign preconfigured access rights to the users of Supplier Integrity
  So that I can efficiently manage the access rights of each user


  @C32988054 @C32988073
  Scenario: C32988054, C32988073: User Management - Role - Login as Internal User using the created User Role
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And Skip test if existing roles number exceeds limit in 50 roles
    And User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When User clicks 'Add New Role' button
    And User fills User Role page header with "User Role Full Details" data
    And User fills Third-party block with "User Role Full Details" data
    And User fills reports block with "User Role Full Details" data
    And User fills setUp block with "User Role Full Details" data
    And User fills ddOrdering block with "User Role Full Details" data
    And User fills Data Providers block with "User Role Full Details" data
    And User clicks 'Submit' Role Management button
    Then Role saved with provided details
    And User deletes the role
    When User refreshes page
    Then User verifies role is deleted

  @C32988055
  Scenario: C32988055: User Management - Role - Update Existing User Role
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And Skip test if existing roles number exceeds limit in 50 roles
    And User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When User clicks 'Add New Role' button
    And User fills User Role page header with "User Role Full Details" data
    And User fills Third-party block with "User Role Full Details" data
    And User fills reports block with "User Role Full Details" data
    And User fills setUp block with "User Role Full Details" data
    And User fills ddOrdering block with "User Role Full Details" data
    And User fills Data Providers block with "User Role Full Details" data
    And User clicks 'Submit' Role Management button
    And User refreshes page
    And User clicks 'Edit' button on created role on roles list
    And User edits role name and description with "User Role Full Details"
    And User edits Third-party privileges with "User Role Full Details" data
    And User clicks 'Submit' Role Management button
    And Role saved with provided details
    And User deletes the role
    When User refreshes page
    Then User verifies role is deleted

  @C32988057
  @WSO2email
  Scenario: C32988057: User Management - Role - Add an Internal User using the created User Role
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And Skip test if existing roles number exceeds limit in 50 roles
    And User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When User clicks 'Add New Role' button
    And User fills User Role page header with "User Role Full Details" data
    And User fills Third-party block with "User Role Full Details" data
    And User fills reports block with "User Role Full Details" data
    And User fills setUp block with "User Role Full Details" data
    And User fills ddOrdering block with "User Role Full Details" data
    And User fills Data Providers block with "User Role Full Details" data
    And User clicks 'Submit' Role Management button
    And User creates valid email
    And User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    Then Add User page is loaded
    And User Type is "Internal"
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "toBeReplaced"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    And Add User page is closed
    And User searches user by first name
    Then First fined user is displayed with values
      | First Name   | Last Name           | User Name    | User Type | Role         | Status | Single Sign On |
      | toBeReplaced | AUTO TEST Last Name | toBeReplaced | Internal  | toBeReplaced | ACTIVE | user.noValue   |
    And Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    When User navigates 'Set Up' block 'User' section
    And User searches user by first name
    And User clicks edit user button by name
    And User selects in "Role" Add User value "System Administrator"
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    And User navigates 'Set Up' block 'Role' section
    And User deletes the role
    And User refreshes page
    Then User verifies role is deleted