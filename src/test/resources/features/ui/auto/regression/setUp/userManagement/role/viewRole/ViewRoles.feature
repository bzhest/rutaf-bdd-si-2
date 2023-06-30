@ui @functional @user_management
Feature: View Roles

  As a Supplier Integrity Administrator
  I want to be able to see all the Roles of Supplier Integrity
  So that I can manage the Roles and their access as necessary

  @C35739105
  Scenario: C35739105 User management - Role- View Role - Sort Roles Table
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Roles table is displayed with columns
      | NAME | DESCRIPTION | DATE CREATED | LAST UPDATED | STATUS |
    And Verify checkboxes are present opposite to roles
    And Verify Edit and Delete buttons are present opposite to roles
    And Roles table displays roles sorted by "Date Created" in "DESC" order
    When Users clicks "Name" column in role header
    Then Roles table displays roles sorted by "Name" in "ASC" order
    When Users clicks "Name" column in role header
    Then Roles table displays roles sorted by "Name" in "DESC" order
    When Users clicks "Description" column in role header
    Then Roles table displays roles sorted by "Description" in "ASC" order
    When Users clicks "Description" column in role header
    Then Roles table displays roles sorted by "Description" in "DESC" order
    When Users clicks "Date Created" column in role header
    Then Roles table displays roles sorted by "Date Created" in "ASC" order
    When Users clicks "Date Created" column in role header
    Then Roles table displays roles sorted by "Date Created" in "DESC" order
    When Users clicks "Last Updated" column in role header
    Then Roles table displays roles sorted by "Last Updated" in "ASC" order
    When Users clicks "Last Updated" column in role header
    Then Roles table displays roles sorted by "Last Updated" in "DESC" order
    When Users clicks "Status" column in role header
    Then Roles table displays roles sorted by "Status" in "ASC" order
    When Users clicks "Status" column in role header
    Then Roles table displays roles sorted by "Status" in "DESC" order
    When User clicks 'Add New Role' button
    Then Verify the set up values contain expected "Default Role Details" roles
    And There are the following Role Management sections displayed
      | Third-party           |
      | Reports and Dashboard |
      | Set Up                |
      | Due Diligence Order   |
      | Data Providers        |
      | Bulk Processing       |
    And User management breadcrumb "ROLE MANAGEMENT / ADD ROLE" is displayed
    When User clicks Back button on Role form
    Then "Add Role" Role Management page is closed