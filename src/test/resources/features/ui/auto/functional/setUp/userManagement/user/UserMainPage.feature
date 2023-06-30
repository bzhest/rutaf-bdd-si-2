@ui @functional @user_management
Feature: Set Up - User Management - User Main Page

  As a RDDC System Administrator
  I want to see all the users of RDDC
  So that I can manage the users and their access as necessary


  @C40180009 @C43406606 @C32909466
  Scenario: C40180009, C43406606, C32909466: User list - Verify User list table values and sorting
  User Management - User List - Add 'Date Created' column
  User Management - Verify that 'Single Sign On' column on user overview displayed and should see Yes or No and sort the column (ASC or DESC)
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    Then Users table is displayed
    And Users table is displayed with columns
      | FIRST NAME | LAST NAME | USER NAME | THIRD-PARTY | USER TYPE | ROLE | STATUS | SINGLE SIGN ON | OUT OF OFFICE | DATE CREATED |
    And 'Edit' icon should be displayed for each user record
    And "Edit" icon tooltip should be displayed for each user record
    And Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |
    And User table Third-party columns non empty for External users
    And User table "SINGLE SIGN ON" column contains only values
      | Yes |
      | No  |
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
    When Users clicks "Third-party" column header
    Then Users table displays users sorted by "Third-party" in "ASC" order
    When Users clicks "Third-party" column header
    Then Users table displays users sorted by "Third-party" in "DESC" order
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
    When Users clicks "Out of Office" column header
    Then Users table displays users sorted by "Out of Office" in "ASC" order
    When Users clicks "Out of Office" column header
    Then Users table displays users sorted by "Out of Office" in "DESC" order
    When Users clicks "Date Created" column header
    Then Users table displays users sorted by "Date Created" in "ASC" order
    When Users clicks "Date Created" column header
    Then Users table displays users sorted by "Date Created" in "DESC" order
