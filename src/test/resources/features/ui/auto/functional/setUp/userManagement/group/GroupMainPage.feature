@ui @functional @user_group_management
Feature: Set Up - User Group Management - Group Main Page

  As a System Admin
  I want to be able to see all the Groups of RDDC in REACT
  So that I can manage the user groups as necessary

  Background:
    Given User logs into RDDC as "Admin"

  @C43570954
  Scenario: C43570954: Header "GROUP MANAGEMENT" is displayed on the top of the page
    When User clicks Set Up option
    And User clicks User Groups in Set Up menu
    Then User Group Management page is displayed

  @C43571728 @C43571729 @C43571730
  Scenario: C43571728, C43571729, C43571730: Table with the list of groups is displayed on the "Group management" page
  [Add New Group] button is displayed on the "Group management" page
  Filter and Search features is displayed on the "Group management" page
    When User navigates to Group Management page
    Then Edit and Delete icons are available on User Groups page
    And User Group Overview columns are displayed
      | GROUP NAME   |
      | DESCRIPTION  |
      | DATE CREATED |
      | LAST UPDATE  |
      | STATUS       |
    And User Groups table displays groups sorted by "Date Created" in "DESC" order
    And User Groups Add New Group button is displayed
    And Search text field is displayed
    And Search button is displayed
    And Show drop-down is displayed

  @C43571737
  Scenario: C43571737: Table with the list of groups can be sorted by clicking the column headers
    When User navigates to Group Management page
    And Users clicks "Group Name" column header
    Then User Groups table displays groups sorted by "Group Name" in "ASC" order
    When Users clicks "Group Name" column header
    Then User Groups table displays groups sorted by "Group Name" in "DESC" order
    When Users clicks "Group Name" column header
    Then User Groups table displays groups sorted by "Group Name" in "ASC" order
    When Users clicks "Description" column header
    Then User Groups table displays groups sorted by "Description" in "ASC" order
    When Users clicks "Description" column header
    Then User Groups table displays groups sorted by "Description" in "DESC" order
    When Users clicks "Description" column header
    Then User Groups table displays groups sorted by "Description" in "ASC" order
    When Users clicks "Date Created" column header
    Then User Groups table displays groups sorted by "Date Created" in "ASC" order
    When Users clicks "Date Created" column header
    Then User Groups table displays groups sorted by "Date Created" in "DESC" order
    When Users clicks "Date Created" column header
    Then User Groups table displays groups sorted by "Date Created" in "ASC" order
    When Users clicks "Last Update" column header
    Then User Groups table displays groups sorted by "Last Update" in "ASC" order
    When Users clicks "Last Update" column header
    Then User Groups table displays groups sorted by "Last Update" in "DESC" order
    When Users clicks "Last Update" column header
    Then User Groups table displays groups sorted by "Last Update" in "ASC" order
    When Users clicks "Status" column header
    Then User Groups table displays groups sorted by "Status" in "ASC" order
    When Users clicks "Status" column header
    Then User Groups table displays groups sorted by "Status" in "DESC" order
    When Users clicks "Status" column header
    Then User Groups table displays groups sorted by "Status" in "ASC" order

  @C43571747
  Scenario: C43571747: Checkboxes of the "Group management" table can be activated for active groups
    When User creates new User Group "active user group" via API
    And User navigates to Group Management page
    And User ticks created User Group to be deactivated
    Then All checkboxes for created User Groups are activated
    When User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User refreshes page
    And User ticks created User Group to be deactivated
    Then All checkboxes for created User Groups are activated
    When User ticks created User Group to be deactivated
    Then All checkboxes for created User Groups are inactivated

  @C43571748
  Scenario: C43571748: Checkboxes of the "Group management" table can not be activated for inactive groups
    When User creates new User Group "inactive user group" via API
    And User navigates to Group Management page
    Then All checkboxes for created User Groups are disabled
    When User hovers over cheated User Group checkbox
    Then Tooltip text is displayed
      | Group cannot be deactivated due to inactive status |
    When User ticks created User Group to be deactivated
    Then All checkboxes for created User Groups are disabled

  @C43571754
  Scenario: C43571754: Pagination is displayed below the table with the list of groups
    When User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User navigates to Group Management page
    Then Pagination buttons should be visible
      | first page | previous page | next page | last page |
    And Items per page drop-down should be displayed

  @C32909387
  Scenario: C32909387: User Management- Group Overview- Verify that user should be able to use show dropdown : All, Recently added, Active, Inactive
    When User creates new User Group "active user group" via API
    And User creates new User Group "inactive user group" via API
    And User navigates to Group Management page
    Then User Groups table is displayed
    And Show Drop-Down current option should be "All"
    And Show Drop-Down list is displayed with values
      | All      |
      | Active   |
      | Inactive |
    And User selects "All" show option
    And Group is displayed with values
      | Group name   | Description | Status   | Date Created | Last Update |
      | toBeReplaced |             | Active   | MM/dd/YYYY   |             |
      | toBeReplaced |             | Inactive | MM/dd/YYYY   |             |
    When User refreshes page
    And User selects "Active" show option
    Then Table displayed with all "Active" items
    When User selects "Inactive" show option
    Then Table displayed with all "Inactive" items
