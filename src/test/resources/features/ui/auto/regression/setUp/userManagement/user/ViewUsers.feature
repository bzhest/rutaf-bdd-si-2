@ui @full_regression @user_management
Feature: User Management - View Users

  As a Supplier Integrity Administrator
  I want to be able to see all the users of Supplier Integrity
  So that I can manage the users and their access as necessary

  @C35845635
  @onlySingleThread
  Scenario: C35845635: SI Users - verify that Internal/External user's details can be viewed
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    Then User waits for progress bar to disappear from page
    And Users table is displayed with columns
      | FIRST NAME | LAST NAME | USER NAME | THIRD-PARTY | USER TYPE | ROLE | STATUS | SINGLE SIGN ON | OUT OF OFFICE | DATE CREATED |
    And Pagination option "10" is selected
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    When User selects "25" items per page
    Then Table displayed with up to 25 "users" for first page
    When User selects "50" items per page
    Then Table displayed with up to 50 "users" for first page
    When User selects "10" items per page
    Then Table displayed with up to 10 "users" for first page
    And Users table displays users sorted by "Date Created" in "DESC" order
    And Users table is sorted according to Date creation in Descending order
    When Users clicks "First Name" column header
    Then Users table displays users sorted by "First Name" in "ASC" order
    When Users clicks "First Name" column header
    Then Users table displays users sorted by "First Name" in "DESC" order
    When Users clicks "Last Name" column header
    Then Users table displays users sorted by "Last Name" in "ASC" order
    When Users clicks "Last Name" column header
    Then Users table displays users sorted by "Last Name" in "DESC" order
    When Users clicks "User Name" column header
    Then Users table displays users sorted by "User Name" in "ASC" order
    When Users clicks "User Name" column header
    Then Users table displays users sorted by "User Name" in "DESC" order
    When Users clicks "User Type" column header
    Then Users table displays users sorted by "User Type" in "ASC" order
    When Users clicks "User Type" column header
    Then Users table displays users sorted by "User Type" in "DESC" order
    When Users clicks "Role" column header
    Then Users table displays users sorted by "Role" in "ASC" order
    When Users clicks "Role" column header
    Then Users table displays users sorted by "Role" in "DESC" order
    When Users clicks "Status" column header
    Then Users table displays users sorted by "Status" in "ASC" order
    When Users clicks "Status" column header
    Then Users table displays users sorted by "Status" in "DESC" order
    When Users clicks "Single Sign On" column header
    Then Users table displays users sorted by "Single Sign On" in "ASC" order
    When Users clicks "Single Sign On" column header
    Then Users table displays users sorted by "Single Sign On" in "DESC" order
    When Users clicks on 1 users table row
    Then Overview User modal is displayed
    And All User details should be uneditable
    When User clicks on back User Management button from User page
    Then Overview User modal is disappeared
    And Users table is displayed
