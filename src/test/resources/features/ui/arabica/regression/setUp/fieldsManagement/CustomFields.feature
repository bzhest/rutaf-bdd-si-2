@ui @full_regression @fields_management
Feature: Fields Management - Role permission

  As an Admin user,
  I want to view Fields Management access right in role instead of Custom fields

  @C49962204
  Scenario: C49962204: [Fields Management] - Role permission - Rename "Custom Fields" to "Fields management" - Lite version
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User opens "System Administrator" created role
    Then Verify the set up values contain expected "Fields management YES" data for "Active" role
    And Access rights are not present on Role page
      | Custom Fields |
    And Access rights are present on Role page
      | Fields Management |
    When User navigates 'Set Up' block 'Role' section
    And User saves random Role id to context
    Then Button 'Add New Role' should be displayed
    When User clicks 'Add New Role' button
    Then Access rights are not present on Role page
      | Custom Fields |
    And Access rights are present on Role page
      | Fields Management |
    When User navigates to 'View Role' page of existing Role
    Then Access rights are not present on Role page
      | Custom Fields |
    And Access rights are present on Role page
      | Fields Management |
    When User navigates to 'Edit Role' page of existing Role
    Then Access rights are not present on Role page
      | Custom Fields |
    And Access rights are present on Role page
      | Fields Management |