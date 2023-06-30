@ui @functional @user_management @roles
Feature: Role - Search and filter Role

  As a RDDC admin
  I want to be able to filter and search for Roles in the system
  So that I can efficiently find the Role/s that I need to manage

  @C44056653
  Scenario: C44056653: (Set Up/Role) - "All" option is default for the filter on the "User Management/ Role" page
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    And Show Drop-Down current option should be "All"
    And All roles are displayed in Roles table

  @C44056654
  Scenario: C44056654: (Set Up/Role) - (Set Up/Role) - Roles only with "Active" status are displayed when "Active" option is enabled in filter
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    Then User selects "Active" show option
    And Show Drop-Down current option should be "Active"
    And Active roles are displayed in Roles table

  @C44056655
  Scenario: C44056655: (Set Up/Role) - Roles only with "Inactive" status are displayed when "Inactive" option is enabled in filter
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    Then User selects "Inactive" show option
    And Show Drop-Down current option should be "Inactive"
    And Inactive roles are displayed in Roles table

  @C44056656
  Scenario: C44056656: (Set Up/Role) - All roles are displayed when "All" option is enabled in filter
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    Then User selects "Inactive" show option
    And Show Drop-Down current option should be "Inactive"
    Then User selects "All" show option
    And All roles are displayed in Roles table

  @C44056657
  Scenario: C44056657: (Set Up/Role) - Search feature for the "User Management/ Role" table is not case sensitive
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    When User searches item by "AUTO" keyword
    And User selects "Max" items per page
    Then All items containing "AUTO" keyword in a Name field are shown
    And Role table contains roles with values
      | Name                               | Status   |
      | AUTO TEST ROLE                     | Active   |
      | lower case inactive auto test role | Inactive |
    When User searches item by "auto" keyword
    And User selects "Max" items per page
    Then All items containing "AUTO" keyword in a Name field are shown
    And Role table contains roles with values
      | Name                               | Status   |
      | AUTO TEST ROLE                     | Active   |
      | lower case inactive auto test role | Inactive |

  @C44056658
  Scenario: C44056658: (Set Up/Role) - "No match found" is displayed when no results returned by search
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    When User searches item by "qwerty123!@#" keyword
    Then The page should contain the message "NO MATCH FOUND"

  @C44056659
  Scenario: C44056659: (Set Up/Role) - Searching for an empty value delivers results based on the filter dropdown selection
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    Then User selects "Active" show option
    When User searches item by "AUTO" keyword
    Then All items containing "AUTO" keyword in a Name field are shown
    When User searches item by "" keyword
    And Active roles are displayed in Roles table

  @C44056660
  Scenario: C44056660: (Set Up/Role) - Searching for an empty value delivers results based on the filter dropdown selection
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    Then User selects "Active" show option
    When User searches item by "AUTO" keyword
    Then All items containing "AUTO" keyword in a Name field are shown
    And Items per page drop-down should be displayed
    When Pagination buttons should be visible
      | first page | previous page | next page | last page |

  @C44056661
  Scenario: C44056661: (Set Up/Role) - (Set Up/Role) - "Roles" table with search result can be sorted by clicking the column headers
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    Then User selects "Active" show option
    When User searches item by "AUTO" keyword
    Then All items containing "AUTO" keyword in a Name field are shown
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

  @C44102061
  Scenario: C44102061: (Set Up/ Role) - Search result list is sorted by relevancy
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    When User searches item by "AUTO TEST ROLE" keyword
    When "AUTO TEST ROLE" role is first in roles list
    And Role table contains roles with values
      | Name                               | Status   |
      | AUTO TEST ROLE WITH RESTRICTIONS   | Active   |
      | lower case inactive auto test role | Inactive |