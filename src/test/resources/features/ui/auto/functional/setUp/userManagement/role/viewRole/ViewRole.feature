@ui @functional @user_management @roles
Feature: Role - View Role

  As a RDDC Administrator
  I want to be able to assign preconfigured access rights to the users of RDDC
  So that I can efficiently manage the access rights of each user

  @C32909886
  Scenario: C32909886: Internal User - Third-party Onboarding - User without Edit Third-party Information Role should not be able to edit Other Information Section
    Given User logs into RDDC as "admin"
    When User creates third-party "workflowGroupUkraineIndividual" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "Restricted"
    And User navigates to Third-party page
    And User searches created third-party
    Then Edit buttons are not displayed for third-parties
    When User clicks on created third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And General and Other Information section is not allowed for editing, as edit icon is disabled

  @C32909904
  Scenario: C32909904: Role - Workflow Management- Default System Admin Role - Verify that user should see workflow Management is set to "YES" as default
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User opens "System Administrator" created role
    Then Verify the set up values contain expected "System Administrator Workflow Management" data for "Active" role

  @C37428263
  Scenario: C37428263: Self Service Bulk Processing (Phase 1) - Bulk Process: Role Setup - Validate default setting for system admin is 'YES'
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User opens "System Administrator" created role
    Then Verify the set up values contain expected "Bulk Processing YES" data for "Active" role

  @C37428265
  Scenario: C37428265: Self Service Bulk Processing (Phase 1) - Bulk Process: Role Setup - Validate setting of the existing users is 'No'
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User opens "AUTO TEST ROLE" created role
    Then Verify the set up values contain expected "Bulk Processing NO" data for "Active" role

  @C36411892
  Scenario: C36411892: View Role - Activity Rollback - Verify that user should be able to see Activity rollback permissions
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User opens "System Administrator" created role
    Then Verify the set up values contain expected "Activity Rollback YES" data for "Active" role
    When User navigates 'Set Up' block 'Role' section
    And User opens "AUTO TEST ROLE" created role
    Then Verify the set up values contain expected "Activity Rollback NO" data for "Active" role

  @C46320135
  Scenario: C46320135: View Role - Verify that user should be able to see Activity rollback permissions
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User opens "System Administrator" created role
    Then Verify the set up values contain expected "Screening management YES" data for "Active" role
    When User navigates 'Set Up' block 'Role' section
    And User opens "AUTO TEST ROLE" created role
    Then Verify the set up values contain expected "Screening management NO" data for "Active" role

  @C44944120
  Scenario: C44944120: [User Management - Role] - Verify the "View Role" page is displayed when clicking any row in the table with the list of roles
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User opens "AUTO TEST ROLE" created role
    Then "AUTO TEST ROLE" Role Management page is opened
    And User management breadcrumb "ROLE MANAGEMENT / AUTO TEST ROLE" is displayed
    And There are the following Role Management sections displayed
      | Third-party           |
      | Reports and Dashboard |
      | Set Up                |
      | Due Diligence Order   |
      | Data Providers        |
      | Bulk Processing       |
    And Role Management sections are expanded
      | Third-party           |
      | Reports and Dashboard |
      | Set Up                |
      | Due Diligence Order   |
      | Data Providers        |
      | Bulk Processing       |
    When User collapses Role Management sections
      | Third-party           |
      | Reports and Dashboard |
      | Set Up                |
      | Due Diligence Order   |
      | Data Providers        |
      | Bulk Processing       |
    Then Role Management sections are collapsed
      | Third-party           |
      | Reports and Dashboard |
      | Set Up                |
      | Due Diligence Order   |
      | Data Providers        |
      | Bulk Processing       |
    When User clicks 'Edit' button on role form page
    And User management breadcrumb "ROLE MANAGEMENT / EDIT ROLE" is displayed
    And User clicks Back button on Role form
    Then Button 'Add New Role' should be displayed

  @C45004568
  Scenario: C45004568: [User Management - Role] - Verify the URL for the "View Role" page
    Given User logs into RDDC as "Admin"
    When User saves random Role id to context
    And User navigates 'Set Up' block 'Role' section
    And User opens created role
    Then View Role URL contains expected Role id