@ui @core_regression @user_management
Feature: Search and Filter for Role

  As an admin of Supplier Integrity
  I want to be able to filter and search for Roles in the system
  So that I can efficiently find the Role/s that I need to manage

  @C35740903
  @onlySingleThread
  Scenario: C35740903 User Management - Role - Role List Search and Filter
    Given User logs into RDDC as "Admin"
    And User navigates 'Set Up' block 'Role' section
    And Show Drop-Down list is displayed with values
      | All      |
      | Active   |
      | Inactive |
    When User selects "Active" show option
    Then Table displayed with all "Active" items
    When User selects "Inactive" show option
    Then Table displayed with all "Inactive" items
    When User selects "All" show option
    Then Table displayed with up to 10 "roles" for first page
    When User searches item by "AUTO" keyword
    And User selects "25" items per page
    Then All items containing "AUTO" keyword in a Name field are shown
    And Role table contains roles with values
      | Name                               | Status   |
      | AUTO TEST ROLE                     | Active   |
      | lower case inactive auto test role | Inactive |
    When User searches item by "AUTO" keyword
    And User selects "Active" show option
    Then All items containing "AUTO" keyword in a Name field are shown
    And Role table contains roles with values
      | Name           | Status |
      | AUTO TEST ROLE | Active |
    And Table displayed with all "Active" items
    When User searches item by "AUTO" keyword
    And User selects "Inactive" show option
    Then All items containing "AUTO" keyword in a Name field are shown
    And  Role table contains roles with values
      | Name                               | Status   |
      | lower case inactive auto test role | Inactive |
    And Table displayed with all "Inactive" items
    When User searches item by "AUTO" keyword
    And User selects "All" show option
    And User selects "25" items per page
    Then All items containing "AUTO" keyword in a Name field are shown
    And  Role table contains roles with values
      | Name                               | Status   |
      | AUTO TEST ROLE                     | Active   |
      | lower case inactive auto test role | Inactive |
    When User searches item by "AUTO" keyword
    Then All items containing "AUTO" keyword in a Name field are shown
    When User searches item by "qwerty123!@#" keyword
    Then The page should contain the message "NO MATCH FOUND"
