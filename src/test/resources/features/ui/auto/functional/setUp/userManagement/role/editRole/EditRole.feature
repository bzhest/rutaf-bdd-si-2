@ui @functional @user_management @roles
Feature: Role - Edit Role

  As a RDDC Administrator
  I want to be able to assign preconfigured access rights to the users of RDDC
  So that I can efficiently manage the access rights of each user

  @C32909884
  Scenario: C32909884: Edit User Role - Verify that updating user role with existing role name should have validation 'User Role already exist.' and field highlighted in red and toast message should appear displaying 'Cannot Save User Role already exist.'
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    And User fills User Role page header with "role mandatory fields" data
    And User clicks 'Submit' Role Management button
    And User waits for progress bar to disappear from page
    And User opens created role
    Then "userRoleTitle" Role Management page is opened
    When User clicks 'Edit' button on role form page
    Then User management breadcrumb "ROLE MANAGEMENT / EDIT ROLE" is displayed
    When User updates Name field with "AUTO TEST ROLE" name
    And User clicks 'Submit' Role Management button
    Then Alert Icon is displayed with text
      | Cannot save. Role already exists |
    And Under "Name" field there is an error message: "Role already exists"

  @C32909893
  Scenario: C32909893: Edit Role - Verify that user should be able to update user role and save changes
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    And User fills User Role page header with "role mandatory fields" data
    And User clicks 'Submit' Role Management button
    And User waits for progress bar to disappear from page
    And User opens created role
    Then "userRoleTitle" Role Management page is opened
    When User clicks 'Edit' button on role form page
    And User fills User Role page header with "Data for edit all fields" data
    And User fills Third-party block with "Data for edit all fields" data
    And User fills reports block with "Data for edit all fields" data
    And User fills setUp block with "Data for edit all fields" data
    And User fills ddOrdering block with "Data for edit all fields" data
    And User fills Data Providers block with "Data for edit all fields" data
    And User fills Bulk Processing block with "Data for edit all fields" data
    And User clicks 'Submit' Role Management button
    Then Alert Icon is displayed with text
      | Success               |
      | Role has been updated |
    And "Edit Role" Role Management page is closed
    When User opens created role
    And User waits for progress bar to disappear from page
    Then Verify the set up values contain expected "Data for edit all fields" data for "Inactive" role

  @C32909897
  Scenario: C32909897: User Management - Update role to active
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    And User fills User Role page header with "role mandatory fields inactive" data
    And User clicks 'Submit' Role Management button
    And User opens created role
    And User clicks 'Edit' button on role form page
    And User checks 'Active' Edit User Role checkbox
    And User clicks 'Submit' Role Management button
    And User opens created role
    And User waits for progress bar to disappear from page
    Then Verify the set up values contain expected "role mandatory fields" data for "Active" role

  @C32909916
  Scenario: C32909916: User Management - Update role to inactive
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    And User fills User Role page header with "role mandatory fields" data
    And User clicks 'Submit' Role Management button
    And User opens created role
    And User clicks 'Edit' button on role form page
    And User unchecks 'Active' Edit User Role checkbox
    And User clicks 'Submit' Role Management button
    And User opens created role
    And User waits for progress bar to disappear from page
    Then Verify the set up values contain expected "role mandatory fields inactive" data for "Inactive" role

  @C32909903 @C44055497
  Scenario: C32909903, C44055497: Role Setup - Verify that deactivating role that consists of role that are currently used should display prompt message "This Role is currently in use and you cannot deactivate it."
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And Add Active role with "role mandatory fields" data
    And Add Active role with "role mandatory fields 2" data
    And User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "toBeReplaced"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    And User navigates 'Set Up' block 'Role' section
    And User waits for progress bar to disappear from page
    And User selects roles in roles list
    And User clicks 'Deactivate' button
    Then Message is displayed on confirmation window
      | This Role is currently in use and you cannot |
      | deactivate it                                |
    When User clicks Proceed button on confirmation window
    And User searches role by name
    Then Role status is "Active"
    And Role #1 status is "Active"

  @C32909935
  Scenario: C32909935: Edit Role - Verify that clicking close/cancel all changes on user role should not be saved
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    And User fills User Role page header with "Default Role Details" data
    And User clicks 'Submit' Role Management button
    And User opens created role
    And User clicks 'Edit' button on role form page
    And User fills User Role page header with "Data for edit all fields" data without saving to context
    And User fills Third-party block with "Data for edit all fields" data
    And User fills reports block with "Data for edit all fields" data
    And User fills setUp block with "Data for edit all fields" data
    And User clicks 'Cancel' button
    And User opens created role
    Then Verify the set up values contain expected "Default Role Details" data for "Active" role

  @C32909936
  Scenario: C32909936: Edit Role - Verify that updating role with empty role name should see validation message â€˜This field is required'
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    And User fills User Role page header with "role mandatory fields" data
    And User clicks 'Submit' Role Management button
    And User clicks 'Edit' button on created role on roles list
    And User fills name in header with empty data
    And User clicks 'Submit' Role Management button
    Then Alert Icon is displayed with text
      | Cannot save                         |
      | Please complete the required fields |
    And "Name" field becomes highlighted in red
    And Under "Name" field there is an error message: "This field is required"

  @C36411873
  Scenario: C36411873: Edit Role - Activity Rollback - Verify that user should be able to configure Activity rollback permissions
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    And User fills User Role page header with "role mandatory fields" data
    And User fills Third-party block with "Activity Rollback YES" data
    And User clicks 'Submit' Role Management button
    And User opens created role
    And User clicks 'Edit' button on created role on roles list
    And User fills Third-party block with "Activity Rollback NO" data
    And User clicks 'Submit' Role Management button
    And User opens created role
    And User waits for progress bar to disappear from page
    Then Verify the set up values contain expected "Activity Rollback NO" data for "Active" role
    When User clicks 'Edit' button on created role on roles list
    And User fills Third-party block with "Activity Rollback YES" data
    And User clicks 'Submit' Role Management button
    And User opens created role
    And User waits for progress bar to disappear from page
    Then Verify the set up values contain expected "Activity Rollback YES" data for "Active" role

  @C46320134 @C46619576
  Scenario: C46320134, C46619576: Edit Role  - Verify that user should be able to configure Screening management permissions = Yes/No
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    And User fills User Role page header with "role mandatory fields" data
    And User fills setUp block with "enable workflow management" data
    And User clicks 'Submit' Role Management button
    And User waits for progress bar to disappear from page
    And User sets up role "userRoleTitle" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User clicks Set Up option
    Then Setup navigation option "Screening Management" is not displayed
    When User logs into RDDC as "Admin"
    And User navigates 'Set Up' block 'Role' section
    And User opens created role
    And User clicks 'Edit' button on created role on roles list
    And User fills setUp block with "Screening management YES" data
    And User clicks 'Submit' Role Management button
    And User opens created role
    And User waits for progress bar to disappear from page
    Then Verify the set up values contain expected "Screening management YES" data for "Active" role
    When User sets up role "userRoleTitle" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User clicks Set Up option
    Then Setup navigation option "Screening Management" is displayed
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management toggle buttons are present
      | Enable screening when adding new third-party              |
      | Enable screening when adding new associated party         |
      | Enable World-Check and Custom Watchlist Ongoing Screening |
    And User logs into RDDC as "Admin"

  @C44971149
  Scenario: C44971149: Edit Role - Verify the deactivation of a role that isn't assigned to user (Edit from view page)
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When Add Active role with "role mandatory fields" data
    And User opens created role
    And User clicks 'Edit' button on role form page
    And User unchecks 'Active' Edit User Role checkbox
    And User clicks 'Submit' Role Management button
    Then Alert Icon is displayed with text
      | Success! Role has been updated |
    And "Edit Role" Role Management page is closed
    When User searches role by name
    Then Role status is "Inactive"

  @C44971149
  Scenario: C44971149: Edit Role - Verify the deactivation of a role that isn't assigned to user (Edit from roles list)
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When Add Active role with "role mandatory fields" data
    And User clicks 'Edit' button on created role on roles list
    And User unchecks 'Active' Edit User Role checkbox
    And User clicks 'Submit' Role Management button
    Then Alert Icon is displayed with text
      | Success! Role has been updated |
    And "Edit Role" Role Management page is closed
    When User searches role by name
    Then Role status is "Inactive"

  @C45222550
  Scenario: C45222550: Edit Role - Verify URL and back navigation (Edit from view page)
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When Add Active role with "role mandatory fields" data
    And User opens created role
    And User clicks 'Edit' button on role form page
    Then User management breadcrumb "ROLE MANAGEMENT / EDIT ROLE" is displayed
    And Current URL contains "/ui/admin/user-management/role/userRoleId/edit" endpoint
    When User clicks Back button on Role form
    And User waits for progress bar to disappear from page
    Then Button 'Add New Role' should be displayed
    And Roles table is displayed with columns
      | NAME | DESCRIPTION | DATE CREATED | LAST UPDATED | STATUS |
    When User opens created role
    And User waits for progress bar to disappear from page
    And User clicks 'Edit' button on role form page
    And User clicks back browser button
    Then User management breadcrumb "ROLE MANAGEMENT / userRoleTitle" is displayed

  @C45222550
  Scenario: C45222550: Edit Role - Verify URL and back navigation (Edit from roles list)
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When Add Active role with "role mandatory fields" data
    And User clicks 'Edit' button on created role on roles list
    Then User management breadcrumb "ROLE MANAGEMENT / EDIT ROLE" is displayed
    And Current URL contains "/ui/admin/user-management/role/userRoleId/edit" endpoint
    When User clicks Back button on Role form
    Then Button 'Add New Role' should be displayed
    And Roles table is displayed with columns
      | NAME | DESCRIPTION | DATE CREATED | LAST UPDATED | STATUS |
    When User clicks 'Edit' button on created role on roles list
    And User clicks back browser button
    Then Button 'Add New Role' should be displayed
    And Roles table is displayed with columns
      | NAME | DESCRIPTION | DATE CREATED | LAST UPDATED | STATUS |

  @C32909945
  Scenario: C32909945: User Role - Verify that "Integrawatch Search Filter" and "Data Management" should not be visible in list of role privilege of System Administrator as default role
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    And User opens "System Administrator" created role
    Then Access rights are not present on Role page
      | Integrawatch Search Filter |
      | Data Management            |

  @C32909899
  Scenario: C32909899: Edit Role - Verify "Integrawatch Search Filter" and "Data Management" access right privileged should not display in the list when editing existing role
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    And User opens "AUTO TEST ROLE" created role
    And User clicks 'Edit' button on role form page
    And User management breadcrumb "ROLE MANAGEMENT / EDIT ROLE" is displayed
    Then Access rights are not present on Role page
      | Integrawatch Search Filter |
      | Data Management            |