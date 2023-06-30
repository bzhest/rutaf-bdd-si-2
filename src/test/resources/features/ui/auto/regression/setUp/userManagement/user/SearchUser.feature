@ui @full_regression @user_management
Feature: User Management - Search for User
  As an admin of Supplier Integrity
  I want to be able to filter and search for Users in the system
  So that I can efficiently find the user/s that I need to manage

  @C35843633
  @onlySingleThread
  Scenario: C35843633: SI Users - verify that it's possible to filter/search for users (Internal/External) in the System
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    Then Users table is displayed
    And Show Drop-Down list is displayed with values
      | All      |
      | Active   |
      | Inactive |
    When User selects "Active" show option
    Then Table displayed with all "ACTIVE" items
    When User selects "Inactive" show option
    Then Table displayed with all "INACTIVE" items
    When User selects "All" show option
    Then Results "users" for current page is displayed
    When User searches user by "admin" keyword
    Then User table should display user accounts that contain the provided "admin" keyword
    When User selects "Active" show option
    And User searches user by "admin" keyword
    Then User table should display user accounts that contain the provided "admin" keyword
    When User selects "Active" show option
    And User searches user by "admin" keyword
    Then User table should display user accounts that contain the provided "admin" keyword
    When User searches user by "qwerty123!@#" keyword
    Then The page should contain the message "NO MATCH FOUND"
    When User selects "All" show option
    And User searches user by "" keyword
    Then Users table is sorted according to Date creation in Descending order
