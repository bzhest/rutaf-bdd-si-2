@ui @full_regression @user_management
Feature: Delete Role

  As a Supplier Integrity Administrator
  I want to be able to delete Roles
  So that I can delete the Roles that are no longer being used in Supplier Integrity

  @C35728502
  Scenario: C35728502 User Management - Role - Delete a Role
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When Add Active role with "User Role Full Details" data
    And User searches role by name
    And User clicks 'Delete' button
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this role? |
      | This change cannot be undone               |
    When User clicks Cancel button on confirmation window
    And User searches role by name
    Then Role is displayed in roles list
    And Role status is "Active"
    And User clicks 'Delete' button
    When User clicks Yes button on confirmation window
    Then Alert Icon is displayed with text
      | Success               |
      | Role has been deleted |
    When User searches role by name
    Then Role is NOT displayed in roles list
    When Add Inactive role with "Default Role Details" data
    And User searches role by name
    And User clicks 'Delete' button
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this role? |
      | This change cannot be undone               |
    When User clicks Cancel button on confirmation window
    And User searches role by name
    Then Role is displayed in roles list
    And Role status is "Inactive"
    And User clicks 'Delete' button
    When User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success               |
      | Role has been deleted |
    When User searches role by name
    Then Role is NOT displayed in roles list
    When Add Active role with "User Role Full Details" data
    And User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "toBeReplaced"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    And User navigates 'Set Up' block 'Role' section
    And User searches role by name
    And User clicks 'Delete' button
    Then Message is displayed on confirmation window
      | This role is currently in use         |
      | and you will not be able to delete it |
    When User clicks Proceed button on confirmation window
    And User searches role by name
    Then Role is displayed in roles list
    And Role status is "Active"