@ui @user_management
Feature: Add New Role

  As a Supplier Integrity Administrator
  I want to be able to assign preconfigured access rights to the users of Supplier Integrity
  So that I can efficiently manage the access rights of each user

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When User clicks 'Add New Role' button
    Then User management breadcrumb "ROLE MANAGEMENT / ADD ROLE" is displayed

  @C35694086
  @core_regression
  Scenario: C35694086: User Management - Role - Add Role - Verify that a role can be created
    Then There are the following Role Management sections displayed
      | Third-party           |
      | Reports and Dashboard |
      | Set Up                |
      | Due Diligence Order   |
      | Data Providers        |
      | Bulk Processing       |
    When User fills User Role page header with "User Role Full Details" data
    Then Checkboxes in "Third-party" block in "Read" column are ticked and NOT editable
      | Third-party Information | Associated Parties | Contracts | Relationship | Activities |
    And Checkbox for "Bank Details" in "Read" column is editable
    And Create, Edit and Delete checkboxes are editable
      | Third-party Information | Associated Parties | Contracts | Relationship | Activities | Bank Details |
    And Toggle buttons can be switched on Role Management page
      | Configure Overall Risk | Activity Rollback | External User Management | Onboarding/Renewal |
    And Checkboxes are editable on Related Files section
      | Add | Download | Delete |
    And Toggle buttons can be switched on Role Management page
      | Third-party Status | Risk Report | Dashboard | Third-party Report | Activity Report | Questionnaire Report | Due Diligence Order Report | Workflow Report |
    And Toggle buttons can be switched on Role Management page
      | User Management | My Organisation | Questionnaire Management | Workflow Management | Screening Management | Approval Process | Review Process | Fields Management | Country Checklist | Value Management | Email Management | Due Diligence Order Management |
    And Checkboxes are editable on Due Diligence Order section
      | Create | Edit | Read | Decline | Approve |
    And Toggle buttons can be switched on Role Management page
      | Enable Screening | Manage Resolution Type | Ongoing Screening | Change Search Criteria | BitSight Search | Business Overview Search |
    And Toggle buttons can be switched on Role Management page
      | Bulk Processing |
    And User clicks 'Cancel' button
    And "Add Role" Role Management page is closed
    Then A new role has not been created
    When User clicks 'Add New Role' button
    And User fills User Role page header with "User Role Full Details" data
    Then User fills Third-party block with "User Role Full Details" data
    And User fills reports block with "User Role Full Details" data
    And User fills setUp block with "User Role Full Details" data
    And User fills ddOrdering block with "User Role Full Details" data
    And User fills Data Providers block with "User Role Full Details" data
    And User fills Bulk Processing block with "User Role Full Details" data
    And User clicks 'Submit' Role Management button
    And "Add Role" Role Management page is closed
    When User searches role by name
    Then Role status is "Active"
    And "Date Created" is matched with "Today"
    And "Last Update" is matched with "Today"
    When User opens created role
    Then "userRoleTitle" Role Management page is opened
    And Verify the set up values contain expected "User Role Full Details" data for "Active" role

  @C35694102
  @full_regression
  Scenario: C35694102: User Management - Role - Add Role - Validation for required fields and duplicate Name field
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
    When User updates Name field with "AUTO TEST ROLE" name
    And User clicks 'Submit' Role Management button
    Then Alert Icon is displayed with text
      | Cannot save. Role already exists |
    And "Name" field becomes highlighted in red
    And Under "Name" field there is an error message: "Role already exists"
    When User clicks 'Cancel' button
    Then Duplicated role has not been created