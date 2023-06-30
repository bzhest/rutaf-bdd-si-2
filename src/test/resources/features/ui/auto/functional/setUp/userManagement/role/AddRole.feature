@ui @functional @user_management @roles
Feature: Role - Add Role

  As a RDDC Administrator
  I want to be able to assign preconfigured access rights to the users of RDDC
  So that I can efficiently manage the access rights of each user

  @C32909875 @C32909892
  Scenario: C32909875, C32909892: Admin/ Internal user- Setup Role: Add Role Verify that user should be able to set access right to Create/Edit/Delete/Read Bank Details (check/uncheck)
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When User clicks 'Add New Role' button
    Then Checkbox for "Bank Details" in "Read" column is editable
    And Create, Edit and Delete checkboxes are editable
      | Bank Details |

  @C32909864
  Scenario: C32909864: Add Role - Verify that user should see validation "This field is required" and toast message "Cannot Save Please complete the required fields." upon saving without name value.
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    Then Role Active checkbox is checked
    And "Name" field is mandatory
    And There are the following Role Management sections displayed
      | Third-party           |
      | Reports and Dashboard |
      | Set Up                |
      | Due Diligence Order   |
      | Data Providers        |
      | Bulk Processing       |
    And Submit button is displayed on Add Role page
    And Cancel button is displayed on Add Role page
    When User clicks 'Submit' Role Management button
    Then Toast message is displayed with text
      | Cannot save                         |
      | Please complete the required fields |
    And "Add Role" Role Management page is opened
    And "Name" field becomes highlighted in red
    And Under "Name" field there is an error message: "This field is required"

  @C32909906
  Scenario: C32909906: Add User Role that is existing - Validation message 'User Role already exist.' and field highlighted in red and toast message should appear displaying 'Cannot Save User Role already exist.'
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    And User updates Name field with "AUTO TEST ROLE" name
    And User clicks 'Submit' Role Management button
    Then Alert Icon is displayed with text
      | Cannot save. Role already exists |
    And "Name" field becomes highlighted in red
    And Under "Name" field there is an error message: "Role already exists"
    When User clicks 'Cancel' button
    Then Duplicated role has not been created

  @C32909906 @C36606350 @C37428276
  Scenario: C32909906, C36606350, C37428276: Add Role - Verify that Admin or internal user that have access rights was able to add a new role
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    And User fills User Role page header with "User Role Full Details" data
    And User fills Third-party block with "User Role Full Details" data
    And User fills reports block with "User Role Full Details" data
    And User fills setUp block with "User Role Full Details" data
    And User fills ddOrdering block with "User Role Full Details" data
    And User fills Data Providers block with "User Role Full Details" data
    And User fills Bulk Processing block with "User Role Full Details" data
    And User clicks 'Submit' Role Management button
    Then Role is displayed first in roles list
    When User opens created role
    Then Verify the set up values contain expected "User Role Full Details" data for "Active" role

  @C32909923
  Scenario: C32909923: Add Role - Verify that role was not successfully added if the required fields are empty or Admin cancel adding new User Role
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    Then "Add Role" Role Management page is opened
    And Role Active checkbox is checked
    And "Name" field is mandatory
    When User clicks 'Submit' Role Management button
    Then Toast message is displayed with text
      | Cannot save                         |
      | Please complete the required fields |
    And "Add Role" Role Management page is opened
    And "Name" field becomes highlighted in red
    And Under "Name" field there is an error message: "This field is required"

  @C32909946 @C32909914 @C32909948 @C36411834 @C46619573 @C32909925 @C36606350 @C35976686
  Scenario: C32909946, C32909914, C32909948, C36411834, C46619573, C32909925, C36606350, C35976686: Admin/Internal User- Setup Role:  Add Role: Verify that user should see "Custom Field" is set to "No" by default
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    Then Verify the set up values contain expected "Default Role Details" roles
    When User fills User Role page header with "User Role Full Details" data
    And User clicks 'Submit' Role Management button
    And User opens created role
    Then Verify the set up values contain expected "Default Role Details" data for "Active" role
    When User clicks 'Edit' button on created role on roles list
    Then Verify the set up values contain expected "Default Role Details" data for "Active" role

  @C46620159, @C32909941, @C32909947, @C36606255
  Scenario: C46620159, C32909941, C32909947, C36606255: Add Role - Screening management - Verify  System Administrator and Program Administrator (SI Lite) shall have Screening management set to "Yes".
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    And Users clicks "Date Created" column in role header
    And User opens "System Administrator" created role
    Then Verify the set up values contain expected "System Administrator Role" data for "Active" role

  @C46320133
  Scenario: C46320133: Add Role - Screening management - Verify that user should be able to configure Screening management permissions = No
    Given User logs into RDDC as "user screening permission off"
    When User navigates 'Set Up' block 'Role' section
    Then Setup navigation option "Screening Management" is not displayed

  @C46619571
  Scenario: C46619571: Add Role - Screening management - Verify that user should be able to configure Screening management permissions = Yes
    Given User logs into RDDC as "admin"
    When User clicks Set Up option
    And User waits for progress bar to disappear from page
    Then Setup navigation option "Screening Management" is displayed
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management toggle buttons are present
      | Enable screening when adding new third-party              |
      | Enable screening when adding new associated party         |
      | Enable World-Check and Custom Watchlist Ongoing Screening |

  @C45005893
  Scenario: C45005893: [User Management - Role] - Verify the URL for the "Add Role" page
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When User clicks 'Add New Role' button
    And User management breadcrumb "ROLE MANAGEMENT / ADD ROLE" is displayed
    Then Current URL contains "/ui/admin/user-management/role/add" endpoint
    When User clicks back browser button
    Then Roles table is displayed with columns
      | NAME | DESCRIPTION | DATE CREATED | LAST UPDATED | STATUS |