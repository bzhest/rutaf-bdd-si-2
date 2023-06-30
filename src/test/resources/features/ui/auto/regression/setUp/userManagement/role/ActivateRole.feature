@ui @core_regression @user_management @robusta
Feature: Activate Role

  As a Supplier Integrity Administrator
  I want to be able to activate Roles
  So that I can activate the Roles that are inactive

  @C35729397
  Scenario: C35729397: User Management - Role - Activate Role
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When User clicks 'Add New Role' button
    And User fills User Role page header with "User Role Full Details" data
    And User unchecks 'Active' Edit User Role checkbox
    When User clicks 'Submit' Role Management button
    Then "Add Role" Role Management page is closed
    When User searches role by name
    And Role status is "Inactive"
    When User clicks 'Edit' button on created role on roles list
    Then "Edit Role" Role Management page is opened
    And There are the following Role Management sections displayed
      | Third-party           |
      | Reports and Dashboard |
      | Set Up                |
      | Due Diligence Order   |
      | Data Providers        |
      | Bulk Processing       |
    And Verify the set up values contain expected "Default Role Details" data for "Inactive" role
    When User checks 'Active' Edit User Role checkbox
    And User clicks 'Submit' Role Management button
    Then Alert Icon is displayed with text
      | Success! Role has been updated |
    And "Edit Role" Role Management page is closed
    When User searches role by name
    Then Role status is "Active"
    When User clicks 'Edit' button on created role on roles list
    And User unchecks 'Active' Edit User Role checkbox
    And User clicks 'Submit' Role Management button
    And User opens created role
    Then "userRoleTitle" Role Management page is opened
    And Verify the set up values contain expected "Default Role Details" data for "Inactive" role
    When User clicks 'Edit' button on role form page
    Then User checks 'Active' Edit User Role checkbox
    When User clicks 'Submit' Role Management button
    Then Alert Icon is displayed with text
      | Success! Role has been updated |
    And "Edit Role" Role Management page is closed
    When User searches role by name
    And Role status is "Active"
    When User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    Then User selects in "Role" Add User value "toBeReplaced"
