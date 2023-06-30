@ui @functional @roles @arabica @qa-sprint6

Feature: Announcement banner - setUp

  As a RDDC Administrator
  I want to be able to add announcement banner permission for the other roles
  So that the accessibility for the announcement banner can be authorized by role

  Background:
    Given User logs into RDDC as "Admin"

  @C54379923
  Scenario: C54379923: Setup/Permission - Verify  Announcement Banner Permission for "Program Administrator" and "System Administrator" roles is set to "YES" as default
    When User navigates 'Set Up' block 'Role' section
    And User opens "System Administrator" created role
    Then Verify the set up values contain expected "Announcement Banner YES" data for "Active" role

  @C54379926
  Scenario: C54379926: Setup/Permission - Verify when add new role: role announcement Banner is defaulted as OFF(NO)
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When User clicks 'Add New Role' button
    Then Verify the set up values contain expected "Announcement Banner NO" data for "Active" role

  @C54379963
  Scenario: C54379963: Setup/Permission - Verify when edit role: role announcement Banner can turn ON and OFF
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    And User fills User Role page header with "role mandatory fields" data
    And User clicks 'Submit' Role Management button
    And User waits for progress bar to disappear from page
    And User opens created role
    Then "userRoleTitle" Role Management page is opened
    And User waits for progress bar to disappear from page
    When User clicks 'Edit' button on role form page
    Then User management breadcrumb "ROLE MANAGEMENT / EDIT ROLE" is displayed
    And Verify the set up values contain expected "Announcement Banner NO" data for "Active" role
    When User fills setUp block with "enable announcement Banner" data
    And User clicks 'Submit' Role Management button
    Then Alert Icon is displayed with text
      | Success               |
      | Role has been updated |
    And "Edit Role" Role Management page is closed
    When User opens created role
    And User waits for progress bar to disappear from page
    Then Verify the set up values contain expected "Announcement Banner YES" data for "Active" role