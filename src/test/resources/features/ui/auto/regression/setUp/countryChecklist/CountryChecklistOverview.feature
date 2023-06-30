@ui @full_regression @country_checklist
Feature: Country Checklist management

  As a Supplier Integrity Administrator
  I want to be able to Assign Countries in Country Checklists
  So that the users can be notified of information regarding the selected countries in the Suppler profile.

  @C36052124
  @onlySingleThread
  Scenario: C36052124: [Country Checklist Setup] Overview/View List Name
    Given User logs into RDDC as "Admin"
    And User creates Country Checklist "Caution with assigned Afghanistan" via API
    And User creates Country Checklist "Informational with assigned Afghanistan, Zimbabwe" via API
    And User creates Country Checklist "Warning with assigned Afghanistan Inactive" via API
    When User clicks Set Up option
    And User clicks Country Checklist in Set Up menu
    Then Country Checklist page is loaded
    When User clicks edit button for country checklist "toBeReplaced"
    Then "Edit Country Checklist" details page is displayed
    When User clicks Save button for edit assigning Country
    Then Country Checklist table with headers is displayed
      | LIST NAME | ALERT TYPE | STATUS | DATE CREATED | LAST UPDATED |
    And Search text field is displayed
    And Add Country Checklist button is displayed
    And Pagination buttons should be visible
      | Go to first page | Go to previous page | Go to next page | Go to last page |
    When User clicks pagination drop-down
    Then Rows dropdown contains correct options list for Country Checklist table
    When User selects "10" items per page
    Then Table is sorted by default according to Date Created in DESC order
    When User clicks "Date Created" Country Checklist column header
    Then "Date Created" Country Checklist column is sorted in "ASC" order
    When User clicks "Date Created" Country Checklist column header
    Then "Date Created" Country Checklist column is sorted in "DESC" order
    When User searches Country Checklist with name "AUTO_TEST"
    And User clicks "List Name" Country Checklist column header
    Then "List Name" Country Checklist column is sorted in "ASC" order
    When User clicks "List Name" Country Checklist column header
    Then "List Name" Country Checklist column is sorted in "DESC" order
    When User clicks "Alert Type" Country Checklist column header
    Then "Alert Type" Country Checklist column is sorted in "ASC" order
    When User clicks "Alert Type" Country Checklist column header
    Then "Alert Type" Country Checklist column is sorted in "DESC" order
    When User clicks "Status" Country Checklist column header
    Then "Status" Country Checklist column is sorted in "ASC" order
    When User clicks "Status" Country Checklist column header
    Then "Status" Country Checklist column is sorted in "DESC" order
    When User clicks "Last Update" Country Checklist column header
    Then "Last Update" Country Checklist column is sorted in "ASC" order
    When User clicks "Last Update" Country Checklist column header
    Then "Last Update" Country Checklist column is sorted in "DESC" order
    And Show Drop-Down list is displayed with values
      | All      |
      | Active   |
      | Inactive |

  @C36053039
  @onlySingleThread
  Scenario: C36053039: [Country Checklist Setup] Country Checklist Overview: Search - Verify that user can use searching option on the Country Checklist page
    Given User logs into RDDC as "Admin"
    And User creates Country Checklist "Informational with assigned Afghanistan, Zimbabwe" via API
    When User clicks Set Up option
    And User clicks Country Checklist in Set Up menu
    Then Country Checklist page is loaded
    When User clicks "List Name" Country Checklist column header
    And User searches Country Checklist with name "toBeReplaced"
    Then Country "toBeReplaced" is displayed with values
      | List Name    | Alert Type    | Status | Date Created |
      | toBeReplaced | Informational | Active | MM/dd/YYYY   |
    When User searches Country Checklist with name "notExisting"
    Then "NO MATCH FOUND" message is displayed for Country Checklist table
    When User searches Country Checklist with name ""
    And User selects "Active" show option
    Then Table displayed with all "Active" items
    When User selects "Inactive" show option
    Then Table displayed with all "Inactive" items
    When User selects "All" show option
    Then Table displayed with up to 10 "checklists" for first page

  @C36053054
  Scenario: C36053054: [Country Checklist Setup] Country Checklist Overview: Pagination - Verify that user can to paginate the Country Checklist table and traverse the list with a manageable number of records per page
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User clicks Country Checklist in Set Up menu
    Then Country Checklist page is loaded
    When User clicks pagination drop-down
    Then Rows dropdown contains correct options list for Country Checklist table
    And Table displays corresponding to pagination correct rows number
