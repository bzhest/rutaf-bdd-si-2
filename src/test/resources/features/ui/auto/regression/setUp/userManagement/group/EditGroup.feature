@ui @user_management
Feature: User Management - Edit Group

  As a RDDC Administrator
  I want an ability to edit the existing groups of RDDC
  So that I can efficiently manage the details of each group

  @C32909357
  @full_regression
  Scenario: C32909357: [moved]User Management - Group Edit - Verify the behavior on Save and Cancel while editing a group
    Given User logs into RDDC as "Admin"
    When User creates new User Group "active user group" via API
    And User navigates to Group Management page
    And User searches group by group name
    And User clicks on User Group to view details
    And User clicks Edit button on Group page
    Then Group Management "Edit Group" page is displayed
    And Group form page breadcrumb test is "GROUP MANAGEMENT/EDIT GROUP"
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
    Then "Edit Group" User Group page is disappeared
    When User searches group by group name
    Then Group is displayed with values
      | Group name   | Description                 | Status   | Date Created | Last Update |
      | toBeReplaced | Auto Test Group Description | Inactive | MM/dd/YYYY   | MM/dd/YYYY  |
    When User clicks "Edit" icon for the created User Group
    Then Group Management "Edit Group" page is displayed
    And Group form page breadcrumb test is "GROUP MANAGEMENT/EDIT GROUP"
    And Group form page "Group name" input is displayed
    And Group form page "Description" input is displayed
    And Group form page Active checkbox is displayed
    And Group form page "Members" input is displayed
    And Group form page "Group name" field is required
    And Group form page "Members" field is required
    And Group form page "Cancel" button is displayed
    And Group form page "Save" button is displayed
    When User fills in "Group name" User Group value "Cancel creation User Group"
    And User fills in "Description" User Group value "Cancel Save Description"
    And User checks User Group Active checkbox
    And User clears Group form page "Members" field
    And User selects in "Members" User Group value "Assignee_AT_FN"
    And User clicks "Cancel" Group form page button
    Then "Edit Group" User Group page is disappeared
    And User group "Cancel creation User Group" is not created

  @C32909347
  @full_regression
  Scenario: C32909347: User Management - Group Edit - Verify that user is able to click "Edit" from Group Overview page and from View Group page
    Given User logs into RDDC as "Admin"
    When User creates new User Group "active user group" via API
    And User navigates to Group Management page
    Then Edit and Delete icons are available on User Groups page
    When User clicks "Edit" icon for the created User Group
    Then Group Management "Edit Group" page is displayed
    And Group form page "Group name" input is displayed
    And Group form page "Description" input is displayed
    And Group form page Active checkbox is displayed
    And Group form page "Members" input is displayed
    And Group form page "Cancel" button is displayed
    And Group form page "Save" button is displayed
    And Current URL contains "/ui/admin/user-management/group/groupId/edit" endpoint
    When User navigates to Group Management page
    And User clicks on created User Group to view details
    Then User Group Edit button on Group page is displayed
    When User clicks Edit button on Group page
    Then Group Management "Edit Group" page is displayed
    And Group form page "Group name" input is displayed
    And Group form page "Description" input is displayed
    And Group form page Active checkbox is displayed
    And Group form page "Members" input is displayed
    And Group form page "Cancel" button is displayed
    And Group form page "Save" button is displayed
    And Current URL contains "/ui/admin/user-management/group/groupId/edit" endpoint
