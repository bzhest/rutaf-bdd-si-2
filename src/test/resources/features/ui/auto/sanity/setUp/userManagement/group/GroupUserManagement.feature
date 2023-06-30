@ui @sanity @user_management @multilanguage
Feature: User Management - Groups

  As a System Administrator
  I want to have the ability to setup grouping members on it
  So that i can assign activity to a group

  @C32987286 @C35621790
  @full_regression
  Scenario: C32987286, C35621790: User Management - Add User Group
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User navigates to Group Management page
    Then User Group Management page is displayed
    When User clicks 'Add New Group' button
    Then Group Management "groups.addNewGroup" page is displayed
    When User fills in "groups.groupNameField" User Group value "toBeReplaced"
    And User fills in "groups.descriptionField" User Group value "Auto Test Group Description"
    And User checks User Group Active checkbox
    And User selects in "groups.membersDropdown" User Group value "Admin_AT_FN"
    And User clicks "Save" Group form page button
    And "groups.addNewGroup" User Group page is disappeared
    And User searches group by group name
    Then Group is displayed with values
      | Group name   | Description                 | Status | Date Created | Last Update |
      | toBeReplaced | Auto Test Group Description | Active | MM/dd/YYYY   |             |
    When User navigates 'Set Up' block 'User' section
    And User searches user by "Admin_AT_FN" keyword
    And User clicks on user with First Name "Admin_AT_FN"
    Then User Overview "groups.groupField" field is displayed with "toBeReplaced"
