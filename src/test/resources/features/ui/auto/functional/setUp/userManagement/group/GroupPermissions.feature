@ui @functional @user_group_management
Feature: Set Up - User Group Management - Group Permissions

  As a RDDC Administrator
  I want to be able to limit the access to the User Management Module
  So that only the authorized users will be able to manage users and user access


  @C43973084
  Scenario: C43973084: [Set Up/User management/Groups] "Groups" option is not displayed in the left-side navigation menu for users who do not have access to this functionality
    Given User logs into RDDC as "Restricted"
    When User clicks Set Up option
    Then User Groups option in Set Up menu is not displayed

  @C43973091
  Scenario: C43973091: [Set Up/User management/Groups] "403 FORBIDDEN" screen is displayed for users who do not have access to this functionality
    Given User logs into RDDC as "Admin"
    When User creates new User Group "active user group" via API
    And User clicks Log Out button
    And User logs into RDDC as "Restricted"
    And User clicks Set Up option
    When User navigates to Group Management page
    Then Current URL contains "/forbidden" endpoint
    When User navigates to Group Management Add page
    Then Current URL contains "/forbidden" endpoint
    When User navigates to open "" existing User Group page
    Then Current URL contains "/forbidden" endpoint
    When User navigates to open "/edit" existing User Group page
    Then Current URL contains "/forbidden" endpoint
