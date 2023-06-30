@ui @full_regression @user_management @robusta
Feature: User Management - Edit Role from Role Details Page

  As a Supplier Integrity Administrator
  I want to be able to edit Roles
  So that I can change the details and access of Supplier Integrity Roles as necessary

  @C35695456
  Scenario: C35695456: User Management - Role - Edit Role from Role Details Page (RMS-9487)
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When User clicks 'Add New Role' button
    Then "Add Role" Role Management page is opened
    And User fills User Role page header with "User Role Full Details" data
    And User clicks 'Submit' Role Management button
    Then "Add Role" Role Management page is closed
    When User opens created role
    Then "userRoleTitle" Role Management page is opened
    And User management breadcrumb "ROLE MANAGEMENT / userRoleTitle" is displayed
    When User clicks 'Edit' button on role form page
    And User fills Third-party block with "Data for edit all fields" data
    And User fills reports block with "Data for edit all fields" data
    And User fills setUp block with "Data for edit all fields" data
    And User clicks 'Cancel' button
    When User opens created role
    Then "userRoleTitle" Role Management page is opened
    And Verify the set up values contain expected "Default Role Details" data for "Active" role
    When User clicks 'Edit' button on role form page
    And User fills name in header with empty data
    And User clicks 'Submit' Role Management button
    Then Toast message is displayed with text
      | Cannot save. Please complete the required fields. |
    And "Name" field becomes highlighted in red
    And Under "Name" field there is an error message: "This field is required"
    When User updates Name field with "AUTO TEST ROLE" name
    And User clicks 'Submit' Role Management button
    Then Alert Icon is displayed with text
      | Cannot save. Role already exists |
    And "Edit Role" Role Management page is opened
    And "Name" field becomes highlighted in red
    And Under "Name" field there is an error message: "Role already exists"
    When User unchecks 'Active' Edit User Role checkbox
    And User fills User Role page header with "Data for edit all fields" data
    And User fills Third-party block with "Data for edit all fields" data
    And User fills reports block with "Data for edit all fields" data
    And User fills setUp block with "Data for edit all fields" data
    And User fills ddOrdering block with "Data for edit all fields" data
    And User fills Data Providers block with "Data for edit all fields" data
    And User fills Bulk Processing block with "Data for edit all fields" data
    And User clicks 'Submit' Role Management button
    Then Alert Icon is displayed with text
      | Success               |
      | Role has been updated |
    And "Edit Role" Role Management page is closed
    When User searches role by name
    Then "Date Created" is matched with "Today"
    And "Last Update" is matched with "Today"
    When User opens created role
    Then "userRoleTitle" Role Management page is opened
    And Verify the set up values contain expected "Data for edit all fields" data for "Inactive" role
    When User navigates 'Set Up' block 'Role' section
    And User opens created role
    And User clicks 'Edit' button on role form page
    Then User checks 'Active' Edit User Role checkbox
    And User clicks 'Submit' Role Management button
    When User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "toBeReplaced"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    When User navigates 'Set Up' block 'Role' section
    And User opens created role
    Then "userRoleTitle" Role Management page is opened
    When User clicks 'Edit' button on role form page
    And User unchecks 'Active' Edit User Role checkbox
    And User clicks 'Submit' Role Management button
    Then Alert Icon is displayed with text
      | This Role is currently in use and cannot be deactivated |
    And "Edit Role" Role Management page is opened
    When User fills new name in header
    And User checks 'Active' Edit User Role checkbox
    And User clicks 'Submit' Role Management button
    And Alert Icon is displayed with text
      | Success               |
      | Role has been updated |
    And "Edit Role" Role Management page is closed
    When User opens created role
    Then "userRoleTitle" Role Management page is opened
    And Verify the set up values contain expected "Data for edit all fields" data for "Active" role
    When User navigates 'Set Up' block 'User' section
    And Open created user details
    Then Verify role name on user details was changed
