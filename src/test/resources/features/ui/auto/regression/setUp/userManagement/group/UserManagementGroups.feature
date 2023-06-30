@ui @user_management
Feature: User Management - Groups

  As a System Administrator
  I want to have the ability to setup grouping members on it
  So that I can assign activity to a group

  Background:
    Given User logs into RDDC as "Admin"

  @C35624657
  @full_regression
  Scenario: C35624657 - User Group - Delete a group
    Given User creates new User Group "active user group" via API
    When User navigates to Group Management page
    Then Edit and Delete icons are available on User Groups page
    When User clicks "Delete" icon for the created User Group
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Group? This change cannot be undone. |
    And Confirmation button Cancel should be displayed
    And Confirmation button Delete should be displayed
    When User clicks Delete button on confirmation window
    Then Alert Icon for User Group Management is displayed with text
      | Success!            |
      | %s has been deleted |

  @C35624658
  @core_regression
  Scenario: C35624658 - User Group - Deactivate a group
    Given User creates new User Group "active user group" via API
    When User navigates to Group Management page
    And User ticks created User Group to be deactivated
    Then User Group Deactivate button appears
    When User clicks User Group Deactivate button
    Then Message is displayed on confirmation window
      | The selected Group(s) will be deactivated. Do you want to proceed? |
    And Confirmation button Yes should be displayed
    And Confirmation button No should be displayed
    When User clicks No button on confirmation window
    Then Confirmation window should be Disappeared
    And Created User group status is "Active"
    When User ticks created User Group to be deactivated
    Then User Group Deactivate button appears
    When User clicks User Group Deactivate button
    Then  Message is displayed on confirmation window
      | The selected Group(s) will be deactivated. Do you want to proceed? |
    And Confirmation button Yes should be displayed
    And Confirmation button No should be displayed
    When User clicks Yes button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Group(s) has been deactivated. |
    And Created User group status is "Inactive"

  @C35624660
  @full_regression
  Scenario: C35624660 - User Group - Validation for required fields
    Given User creates new User Group "active user group" via API
    When User navigates to Group Management page
    And User clicks 'Add New Group' button
    Then Group Management "Add New Group" page is displayed
    And Group form page "Group name" input is displayed
    And Group form page "Description" input is displayed
    And Group form page Active checkbox is displayed
    And Group form page "Members" input is displayed
    And Group form page "Group name" field is required
    And Group form page "Members" field is required
    When User clicks "Save" Group form page button
    Then Alert Icon for User Group Management is displayed with text
      | Cannot Save                          |
      | Please complete the required fields. |
    And Group form page "Group name" field validation message "This field is required" is displayed
    And Group form page "Members" field validation message "This field is required" is displayed
    And Group form page "Group name" field is highlighted
    And Group form page "Members" field is highlighted
    When User clicks "Cancel" Group form page button
    And User clicks "Edit" icon for the created User Group
    And User waits for progress bar to disappear from page
    Then Group Management "Edit Group" page is displayed
    And Group form page "Group name" field is populated with "toBeReplaced"
    And Group form page Active checkbox is checked
    And Group form page "Members" dropdown is populated with "toBeReplaced"
    When User clears Group form page "Group name" field
    And User clears Group form page "Members" field
    And User clicks "Save" Group form page button
    Then Alert Icon for User Group Management is displayed with text
      | Cannot Save                          |
      | Please complete the required fields. |
    And Group form page "Group name" field validation message "This field is required" is displayed
    And Group form page "Members" field validation message "This field is required" is displayed

  @C35624661
  @core_regression
  Scenario: C35624661 - User Group - View/Edit a group
    Given User creates new User Group "active user group" via API
    When User navigates to Group Management page
    Then Edit and Delete icons are available on User Groups page
    And User Group Overview columns are displayed
      | GROUP NAME   |
      | DESCRIPTION  |
      | DATE CREATED |
      | LAST UPDATE  |
      | STATUS       |
    When User searches group by group name
    And User clicks on User Group to view details
    Then Group form page "Group name" input is displayed
    And Group form page "Description" input is displayed
    And Group form page "Active" input is displayed
    And Group form page "Members" input is displayed
    And Group form page "Group name" field is disabled
    And Group form page "Description" field is disabled
    And Group form page "Active" field is disabled
    And Group form page "Members" field is disabled
    Then User Group Edit button on Group page is displayed
    When User clicks Edit button on Group page
    Then Group Management "Edit Group" page is displayed
    And Group form page "Group name" input is displayed
    And Group form page "Description" input is displayed
    And Group form page Active checkbox is displayed
    And Group form page "Members" input is displayed
    And Group form page "Group name" field is required
    And Group form page "Members" field is required
    And Group form page Active checkbox is checked
    And Group form page "Cancel" button is displayed
    And Group form page "Save" button is displayed
    When User fills in "Group name" User Group value "toBeUpdated"
    And User fills in "Description" User Group value "Auto Test Group Description"
    And User unchecks User Group Active checkbox
    And User clears Group form page "Members" field
    And User selects in "Members" User Group value "Admin_AT_FN"
    And User clicks "Save" Group form page button
    Then Alert Icon for User Group Management is displayed with text
      | Group has been updated |
    And "Edit Group" User Group page is disappeared
    And User searches group by group name
    Then Group is displayed with values
      | Group name   | Description                 | Status   | Date Created | Last Update |
      | toBeReplaced | Auto Test Group Description | Inactive | MM/dd/YYYY   | MM/dd/YYYY  |
    When User creates new User Group "active user group" via API
    And User navigates to Group Management page
    And User clicks "Edit" icon for the created User Group
    Then Group Management "Edit Group" page is displayed
    And Group form page "Group name" input is displayed
    And Group form page "Description" input is displayed
    And Group form page Active checkbox is displayed
    And Group form page "Members" input is displayed
    And Group form page "Group name" field is required
    And Group form page "Members" field is required
    And Group form page Active checkbox is checked
    And Group form page "Cancel" button is displayed
    And Group form page "Save" button is displayed
    When User fills in "Group name" User Group value "toBeUpdated"
    And User fills in "Description" User Group value "Auto Test Group Description"
    And User unchecks User Group Active checkbox
    And User clears Group form page "Members" field
    And User selects in "Members" User Group value "Admin_AT_FN"
    And User clicks "Save" Group form page button
    Then Alert Icon for User Group Management is displayed with text
      | Group has been updated |
    And "Edit Group" User Group page is disappeared
    And User searches group by group name
    Then Group is displayed with values
      | Group name   | Description                 | Status   | Date Created | Last Update |
      | toBeReplaced | Auto Test Group Description | Inactive | MM/dd/YYYY   | MM/dd/YYYY  |

  @C35625113
  @full_regression
  Scenario: C35625113 - User Group - Verify unable to update with duplicate group name
    When User navigates to Group Management page
    And User clicks 'Add New Group' button
    Then Group Management "Add New Group" page is displayed
    And Group form page "Group name" input is displayed
    And Group form page "Description" input is displayed
    And Group form page Active checkbox is displayed
    And Group form page "Members" input is displayed
    When User fills in "Group name" Group field with already existing Group name
    And User selects in "Members" User Group value "Admin_AT_FN"
    And User clicks "Save" Group form page button
    Then Alert Icon for User Group Management is displayed with text
      | User group already exists |
    And Group form page "Group name" field validation message "%s already exists" is displayed
    And Group Management "Add New Group" page is displayed
    When User clicks "Cancel" Group form page button
    And User searches group by group name
    Then User Group table shows only one search result
    When User creates new User Group "active user group" via API
    And User navigates to Group Management page
    And User clicks "Edit" icon for the created User Group
    And User waits for progress bar to disappear from page
    Then Group Management "Edit Group" page is displayed
    And Group form page "Group name" input is displayed
    And Group form page "Description" input is displayed
    And Group form page Active checkbox is displayed
    And Group form page "Members" input is displayed
    When User fills in "Group name" Group field with already existing Group name
    And User clicks "Save" Group form page button
    Then Alert Icon for User Group Management is displayed with text
      | User group already exists |
    And Group form page "Group name" field validation message "%s already exists" is displayed
    And Group Management "Edit Group" page is displayed

  @C35621789
  @core_regression
  Scenario: C35621789 - User Groups - Create a new group - only required fields
    When User navigates to Group Management page
    Then User Group Management page is displayed
    When User clicks 'Add New Group' button
    Then Group Management "Add New Group" page is displayed
    When User fills in "Group name" User Group value "toBeReplaced"
    And User selects in "Members" User Group value "Admin_AT_FN Admin_AT_LN"
    And User clicks "Save" Group form page button
    And "Add New Group" User Group page is disappeared
    And User searches group by group name
    Then Group is displayed with values
      | Group name   | Description | Status | Date Created | Last Update |
      | toBeReplaced |             | Active | MM/dd/YYYY   |             |
    When User navigates 'Set Up' block 'User' section
    And User searches user by "Admin_AT_FN" keyword
    And User clicks on user with First Name "Admin_AT_FN"
    Then User Overview "Group" field is displayed with "toBeReplaced"

  @C35633525
  @core_regression
  @onlySingleThread
  Scenario: C35633525 - User group - Search for a group
    Given User creates new User Group "active user group" via API
    When User navigates to Group Management page
    Then User Groups table is displayed
    And Show Drop-Down current option should be "All"
    And Show Drop-Down list is displayed with values
      | All      |
      | Active   |
      | Inactive |
    And User selects "All" show option
    When User searches group by group name
    Then Group is displayed with values
      | Group name   | Description | Status | Date Created | Last Update |
      | toBeReplaced |             | Active | MM/dd/YYYY   |             |
    When User refreshes page
    And User selects "Active" show option
    Then Table displayed with all "Active" items
    When User selects "Inactive" show option
    Then Table displayed with all "Inactive" items