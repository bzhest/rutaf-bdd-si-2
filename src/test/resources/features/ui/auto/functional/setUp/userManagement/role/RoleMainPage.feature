@ui @functional @user_management @roles
Feature: Role - Main Page

  As a RDDC Administrator
  I want to be able to see all the Roles of RDDC
  So that I can manage the Roles and their access as necessary

  @C32909912
  Scenario: C32909912: Search Role - Verify that user was able to search roles based on the keyword or search term enter in Search field
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User searches item by "AUTO" keyword
    And User selects "50" items per page or max value
    Then All items containing "AUTO" keyword in a Name field are shown
    And Role table contains roles with values
      | Name                               | Status   |
      | AUTO TEST ROLE                     | Active   |
      | lower case inactive auto test role | Inactive |

  @C32909929 @C44055496
  Scenario: C32909929, C44055496: Role Setup - Verify that user can select one or multiple roles and 'deactivate' button should appear and clicking Deactivate should deactivate all selected roles
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When Add Active role with "role mandatory fields" data
    And Add Active role with "role mandatory fields 2" data
    And User selects role in roles list
    And User clicks 'Deactivate' button
    Then Message is displayed on confirmation window
      | The selected role(s) will be deactivated |
      | Do you want to proceed?                  |
    When User clicks No button on confirmation window
    Then Role status is "Active"
    And Role #1 status is "Active"
    When User clicks 'Deactivate' button
    And User clicks Yes button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Role(s) has been deactivated. |
    When User waits for progress bar to disappear from page
    Then Role status is "Inactive"
    And Role #1 status is "Inactive"

  @C32909937
  Scenario: C32909937: Role - Country Checklist- System Administrator : Verify that "Country Checklist" should be set to "Yes" by default
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User opens "System Administrator" created role
    Then Verify the set up values contain expected "System Administrator Country Checklist" data for "Active" role

  @C44046042
  Scenario: C44046042: (Set Up/Role) - Header "ROLE MANAGEMENT" is displayed on the top of the page
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Role Management header is "ROLE MANAGEMENT"

  @C44046043
  Scenario: C44046043: (Set Up/Role) - Table with the list of roles is displayed on the "ROLE MANAGEMENT" page
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Roles table is displayed with columns
      | NAME | DESCRIPTION | DATE CREATED | LAST UPDATED | STATUS |
    And Verify checkboxes are present opposite to roles
    And Verify Edit and Delete buttons are present opposite to roles
    And Roles table displays roles sorted by "Date Created" in "DESC" order

  @C44046044
  Scenario: C44046044: (Set Up/Role) - [Add New Role] button is displayed on the "Role management" page
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed

  @C44046045
  Scenario: C44046045: (Set Up/Role) - Filter and Search features is displayed on the "Role management" page
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And Show Drop-Down list is displayed with values
      | All      |
      | Active   |
      | Inactive |
    And Search text field is displayed
    And Search button is displayed

  @C44046046
  Scenario: C44046046: (Set Up/Role) - Table with the list of roles can be sorted by clicking the column headers
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And Users clicks "Name" column in role header
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

  @C44046047
  Scenario: C44046047: (Set Up/Role) - Checkboxes of the "Role management" table can be activated for active roles
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When Add Active role with "role mandatory fields" data
    And Add Active role with "role mandatory fields 2" data
    And Add Active role with "role mandatory fields 3" data
    And User selects role in roles list
    Then Role #0 checkbox is checked in roles list
    And Role #1 checkbox is checked in roles list
    And Role #2 checkbox is checked in roles list
    When User unselects role in roles list
    Then Role #0 checkbox is unchecked in roles list
    And Role #1 checkbox is unchecked in roles list
    And Role #2 checkbox is unchecked in roles list

  @C44046048
  Scenario: C44046048: (Set Up/Role) - Checkboxes of the "Role management" table can not be activated for inactive roles and "System Administrator" role
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When Add Active role with "role mandatory fields inactive" data
    Then Role checkbox is disabled for role "userRoleTitle"
    When User hovers over Role checkbox
    Then Tooltip text is displayed
      | Role cannot be deactivated due to inactive status or System Administrator |

  @C44046049
  Scenario: C44046049: (Set Up/Role) - Pagination is displayed below the table with the list of roles
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Pagination buttons should be visible
      | first page | previous page | next page | last page |
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |

  @C44046244
  Scenario: C44046244: (Set Up/Role) - Uneditable and undeletable "System Administrator" role is present by default
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And Users clicks "Date Created" column in role header
    Then "System Administrator" role is first in roles list
    And "Delete" element is not present for "System Administrator" in roles list
    And "Edit" element is not present for "System Administrator" in roles list
    And Role checkbox is disabled for role "System Administrator"
