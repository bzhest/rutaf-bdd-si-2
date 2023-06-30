@ui @functional @user_management @roles
Feature: Role - Role Permissions

  As a RDDC Administrator
  I want to be able to assign preconfigured access rights to the users of RDDC
  So that I can efficiently manage the access rights of each user

  @C32909862 @C32909901
  Scenario: C32909862, C32909901: Admin/Internal User- Setup Role: Custom Field Implementation: With Access Verify that user should see "Fields Management" in the setup side bar menu and user will be bale to Add/Edit/Delete/View custom field
    Given User logs into RDDC as "admin"
    When User clicks Set Up option
    And User waits for progress bar to disappear from page
    Then Setup navigation section "Fields Management" option "Custom Fields" is displayed
    And Setup navigation section "Fields Management" option "Third-party Fields" is displayed
    When User navigates to Custom Fields page
    And Add Custom Field button is displayed
    And Reorder button is displayed
    And For each Custom Field record controls buttons should be displayed

  @C32909882, @C32909890 @C32909909
  @onlySingleThread
  Scenario: C32909882, C32909890, C32909909: Role Implementation - Workflow Management- Verify that only internal user that has access right to workflow management should be able to access workflow and workflow group.
    Given User logs into RDDC as "admin"
    When User sets up role "Auto Test Full Permission Role" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User clicks Set Up option
    And User waits for progress bar to disappear from page
    Then Setup navigation option "Workflow Management" is displayed
    When User clicks Country Checklist in Set Up menu
    Then Country Checklist page is loaded
    And For each Country Checklist record in the list controls buttons should be displayed
    When User sets up role "AUTO TEST ROLE WITH DOWNLOAD AND ADD FILES PERMISSION" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User clicks Set Up option
    And User waits for progress bar to disappear from page
    Then Setup navigation option "Workflow Management" is not displayed
    And Setup navigation option "Country Checklist" is not displayed
    And Setup navigation option "Custom Field" is not displayed

  @C32909900
  Scenario: C32909900: Role - Verify that System Admin role should have default access in "Onboarding / Renewal" role (SIDEV-8361)
    Given User logs into RDDC as "admin"
    When User navigates 'Set Up' block 'Role' section
    And Users clicks "Date Created" column in role header
    And User opens "System Administrator" created role
    Then Verify the set up values contain expected "System Administrator Role" data for "Active" role

  @C32909913
  Scenario: C32909913: User Role - Verify that Role page of User management was able to access
    Given User logs into RDDC as "admin"
    When User clicks Set Up option
    And User waits for progress bar to disappear from page
    Then Setup navigation option "Role" is displayed

  @C36606333 @C36606298 @C37428269
  @onlySingleThread
  Scenario: C36606333, C36606298, C37428269: Dashboard Enhancements - Dashboard Reports Role & Permission - Verify that user with no access on reports can't access to the corresponding report
    Given User logs into RDDC as "admin"
    When User sets up role "AUTO TEST ROLE WITH RESTRICTIONS" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    When User clicks on "Reports" home page button
    Then The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    And Current URL contains "/forbidden" endpoint
    And Back button is displayed
    When User clicks 'Back to home' button
    Then Home page is loaded
    When User navigates to Reports page
    Then The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    And Current URL contains "/forbidden" endpoint
    And Back button is displayed
    When User clicks 'Back to home' button
    Then Home page is loaded

  @C36606351
  @onlySingleThread
  Scenario: C36606351: Dashboard Enhancements - Dashboard Reports Role & Permission - Validate restriction of the user to corresponding reports
    Given User logs into RDDC as "admin"
    When User sets up role "AUTO ROLE WITH RESTRICTED REPORTS" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User navigates to Reports page
    Then Reports page contains only following tabs
      | THIRD-PARTY REPORT | QUESTIONNAIRE REPORT | WORKFLOW REPORT |

  @C40202628 @C45221989
  Scenario: C40202628, C45221989: User Management - User List Permissions (with user management permissions)
    Given User logs into RDDC as "admin"
    When User clicks Set Up option
    And User waits for progress bar to disappear from page
    Then Setup navigation section "User Management" option "User" is displayed
    And Setup navigation section "User Management" option "Role" is displayed
    And Setup navigation section "User Management" option "Groups" is displayed
    And Users table is displayed

  @C40202628 @C45221989
  Scenario Outline: C40202628, C45221989: User Management - User List Permissions (without user management permissions, with other setup permissions)
    Given User logs into RDDC as "admin"
    When User saves random <type> id to context
    And User logs into RDDC as "restricted"
    And User clicks Set Up option
    And User waits for progress bar to disappear from page
    Then Setup navigation section "User Management" option "User" is not displayed
    And Setup navigation section "User Management" option "Role" is not displayed
    And Setup navigation section "User Management" option "Groups" is not displayed
    When User navigates 'Set Up' block '<type>' section
    And User waits for progress bar to disappear from page
    Then The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    And Current URL contains "/forbidden" endpoint
    And Back button is displayed
    When User navigates to 'Add <type>' page
    Then The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    And Current URL contains "/forbidden" endpoint
    And Back button is displayed
    When User navigates to 'View <type>' page of existing <type>
    Then The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    And Current URL contains "/forbidden" endpoint
    And Back button is displayed
    When User navigates to 'Edit <type>' page of existing <type>
    Then The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    And Current URL contains "/forbidden" endpoint
    And Back button is displayed

    Examples:
      | type |
      | Role |
      | User |

  @C40202628 @C45221989
  @onlySingleThread
  Scenario Outline: C40202628, C45221989: User Management - User List Permissions (without any setup permissions)
    Given User logs into RDDC as "admin"
    When User saves random <type> id to context
    And User sets up role "AUTO ROLE WITH RESTRICTED REPORTS" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User menu items are not displayed
      | Set Up |
    And User navigates 'Set Up' block '<type>' section
    And User waits for progress bar to disappear from page
    Then The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    And Current URL contains "/forbidden" endpoint
    And Back button is displayed
    When User navigates to 'Add <type>' page
    Then The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    And Current URL contains "/forbidden" endpoint
    And Back button is displayed
    When User navigates to 'View <type>' page of existing <type>
    Then The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    And Current URL contains "/forbidden" endpoint
    And Back button is displayed
    When User navigates to 'Edit <type>' page of existing <type>
    And The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    Then Current URL contains "/forbidden" endpoint
    And Back button is displayed

    Examples:
      | type |
      | Role |
      | User |