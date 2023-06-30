@ui @functional @user_group_management
Feature: Set Up - User Group Management - Add Edit Group

  As a RDDC Administrator
  I want to be able to a group to the users of RDDC
  So that I can efficiently manage the types of each user


  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Group Management page

  @C32909392
  Scenario: C32909392: [moved]User Management - Add/Edit Group- Verify that user sees validation messages when Group Name and Members fields are blank
    When User clicks 'Add New Group' button
    And User clicks "Save" Group form page button
    Then Alert Icon for User Group Management is displayed with text
      | Cannot Save. Please complete the required fields. |
    And Group form page "Group name" field validation message "This field is required" is displayed
    And Group form page "Members" field validation message "This field is required" is displayed
    And Group form page "Group name" field is highlighted
    And Group form page "Members" field is highlighted
    When User creates new User Group "active user group with description" via API
    And User clicks "Cancel" Group form page button
    And User clicks "Edit" icon for the created User Group
    And User waits for progress bar to disappear from page
    Then Group Management "Edit Group" page is displayed
    When User clears Group form page "Group name" field
    And User clicks cross control button for User Group member "Admin_AT_FN Admin_AT_LN"
    And User clicks "Save" Group form page button
    Then Alert Icon for User Group Management is displayed with text
      | Cannot Save. Please complete the required fields. |
    And Group form page "Group name" field validation message "This field is required" is displayed
    And Group form page "Members" field validation message "This field is required" is displayed
    And Group form page "Group name" field is highlighted
    And Group form page "Members" field is highlighted

  @C32909396
  Scenario: C32909396: [moved]User Management - Add/Edit Group - Verify the behaviour of Members drop down
    When User creates new User Group "active user group" via API
    And User refreshes page
    And User clicks "Edit" icon for the created User Group
    Then User Group "Members" drop-down contains only active internal users
    And Group form page "Members" dropdown is populated with "Admin_AT_FN Admin_AT_LN"
    And Group form selected "Members" values is displayed with cross control near the value
    When User clicks cross control button for User Group member "Admin_AT_FN Admin_AT_LN"
    Then Group form page "Members" dropdown is populated with ""
    When User selects in "Members" User Group value "Admin_AT_FN Admin_AT_LN"
    And User selects in "Members" User Group value "Admin_AT_FN Admin_AT_LN"
    Then Group form page "Members" dropdown is populated with ""
    When User selects in "Members" User Group value "Admin_AT_FN Admin_AT_LN"
    And User selects in "Members" User Group value "Assignee_AT_FN Assignee_AT_LN"
    Then Group form page "Members" dropdown is populated with "Admin_AT_FN Admin_AT_LN"
    And Group form page "Members" dropdown is populated with "Assignee_AT_FN Assignee_AT_LN"
    When User clicks "Save" Group form page button
    And User clicks "Edit" icon for the created User Group
    Then Group form page "Members" dropdown is populated with "Admin_AT_FN Admin_AT_LN"
    And Group form page "Members" dropdown is populated with "Assignee_AT_FN Assignee_AT_LN"

  @C32909344
  Scenario: C32909344: [moved] User Management - Add/Edit Group - Verify that Add/Edit Group page has such fields as: Group Name , Descriptions, Active checkbox, Members.
    When User clicks 'Add New Group' button
    Then Group Management "Add New Group" page is displayed
    And Group form page "Group name" input is displayed
    And Group form page "Group name" field is required
    And Group form page "Description" input is displayed
    And Group form page Active checkbox is displayed
    And Group form page Active checkbox is checked
    And Group form page "Members" input is displayed
    And Group form page "Members" field is required
    And User Group "Members" drop-down contains only active internal users
    And Group form page "Cancel" button is displayed
    And Group form page "Save" button is displayed
    And Group form page breadcrumb test is "GROUP MANAGEMENT/ADD NEW GROUP"
    And Group form page "Group name" field max length is "64"
    And Group form page "Description" field max length is "264"
    When User creates new User Group "active user group with description" via API
    And User clicks "Cancel" Group form page button
    And User clicks "Edit" icon for the created User Group
    And User waits for progress bar to disappear from page
    Then Group Management "Edit Group" page is displayed
    And Group form page "Group name" field is populated with "toBeReplaced"
    And Group form page "Group name" field is required
    And Group form page "Description" field is populated with "Test Description"
    And Group form page "Description" field is not required
    And Group form page Active checkbox is checked
    And Group form page "Members" dropdown is populated with "toBeReplaced"
    And Group form page "Members" field is required
    And Group form page breadcrumb test is "GROUP MANAGEMENT/EDIT GROUP"
    And Group form page "Group name" field max length is "64"
    And Group form page "Description" field max length is "264"

  @C32909365 @C43874228
  Scenario: C32909365, C43874228: [moved] User Management - Add Group - Verify the behavior Save and Cancel buttons
  [moved]User Management - Add Group - Verify that user is updated when being assigned to a group via group Setup
    When User clicks 'Add New Group' button
    And User fills in "Group name" User Group value "toBeReplaced"
    And User selects in "Members" User Group value "User_Change_Role_AT_FN User_Change_Role_AT_LN"
    And User clicks "Save" Group form page button
    Then Group is displayed with values
      | Group name   | Description | Status | Date Created | Last Update |
      | toBeReplaced |             | Active | MM/dd/YYYY   |             |
    When User clicks "Edit" icon for the created User Group
    Then Group form page "Group name" field is populated with "toBeReplaced"
    And Group form page "Member" dropdown is populated with "User_Change_Role_AT_FN User_Change_Role_AT_LN"
    When User navigates 'Set Up' block 'User' section
    And User searches user by "User_Change_Role_AT_FN" keyword
    And User clicks on user with First Name "User_Change_Role_AT_FN"
    Then User Overview "Group" field is displayed with "toBeReplaced"
    When User navigates to Group Management page
    And User clicks 'Add New Group' button
    And User fills in "Group name" User Group value "Cancel creation User Group"
    And User selects in "Members" User Group value "Admin_AT_FN Admin_AT_LN"
    And User clicks "Cancel" Group form page button
    Then User group "Cancel creation User Group" is not created

  @C43874292
  Scenario: C43874292: User Management- Add Group - Verify URL
    When User clicks 'Add New Group' button
    Then Current URL contains "/ui/admin/user-management/group/add" endpoint