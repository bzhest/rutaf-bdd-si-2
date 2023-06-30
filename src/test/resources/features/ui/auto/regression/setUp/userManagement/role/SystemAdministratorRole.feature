@ui @core_regression @user_management
Feature: System Administrator Role

  As a Supplier Integrity Administrator
  I have a “System Administrator” role configured in the system by default
  So that I have access to all the features of Supplier Integrity

  @C35740905
  Scenario: C35740905: User Management - Role - System Administrator Role
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And Users clicks "Date Created" column in role header
    Then Role table contains roles with values
      | Name                 | Status |
      | System Administrator | Active |
    And "System Administrator" role is first in roles list
    And "Delete" element is not present for "System Administrator" in roles list
    And "Edit" element is not present for "System Administrator" in roles list
    And "Checkbox" element is not present for "System Administrator" in roles list
    And Role "System Administrator" status is "Active"
    And "Date Created" is matched with date pattern for "System Administrator" role
    And "Last Update" is matched with date pattern for "System Administrator" role
    When User opens "System Administrator" created role
    Then Verify the set up values contain expected "System Administrator Role" data for "Active" role
    And User management breadcrumb "ROLE MANAGEMENT / SYSTEM ADMINISTRATOR" is displayed
    And Edit button is not displayed on Role Management form page
    And All checkboxes are not editable on System Administrator form
    When User clicks Back button on Role form
    Then "Add Role" Role Management page is closed