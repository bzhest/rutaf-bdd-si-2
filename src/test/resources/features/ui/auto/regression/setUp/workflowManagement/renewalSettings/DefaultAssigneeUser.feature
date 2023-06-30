@ui @core_regression @workflow_management
Feature: Workflow Management - Renewal Settings - Default Assignee User

  As a Third-party Integrity Administrator
  I want to assign Default Assignees to Third-parties that are for Renewal
  So that the renewal of the Third-parties will be attended to as soon as they are ready for renewal

  @C35778518 @C37447403
  Scenario: C35778518, C37447403: Workflow Management - Check Advance Search for User on Default Assignee field - Search using valid First Name and Last Name
    Given User logs into RDDC as "Admin"
    And User clicks Set Up option
    When User clicks Workflow Management Renewal Settings submenu in Set Up menu
    And User clicks "User" default assignee radio button
    Then Default Assignee section Advance Search link is displayed
    When User clicks Default Assignee section Advance Search link
    Then Renewal Settings "Advanced search - Users" modal is displayed
    And Renewal Settings 'Advanced Search - Users' modal has First Name and Last Name fields
    And Renewal Settings 'Advanced Search - Users' modal has Search and Cancel buttons
    When User fills in 'Advanced Search - Users' modal First Name and Last Name with "toBeReplaced" and "toBeReplaced"
    And User clicks Renewal Settings 'Advanced Search - Users' modal Search button
    Then Renewal Settings "Advanced search - Users" modal is displayed
    And 'Advanced Search - Users' modal appropriate results are displayed for the next columns "FIRST NAME LAST NAME ROLE"
    When User navigates to Workflow Management Renewal Settings page
    And User clicks "User" default assignee radio button
    And User clicks Default Assignee section Advance Search link
    And User clicks Renewal Settings 'Advanced Search - Users' modal Search button
    And User waits for progress bar to disappear from page
    Then Renewal Settings "Advanced search - Users" modal is displayed
    And All Active users are returned as a search result in 'Advanced Search - Users' modal
    When User navigates to Workflow Management Renewal Settings page
    And User clicks "User" default assignee radio button
    And User clicks Default Assignee section Advance Search link
    And User fills in 'Advanced Search - Users' modal First Name and Last Name with "invalid" and "invalid"
    And User clicks Renewal Settings 'Advanced Search - Users' modal Search button
    Then Renewal Settings 'Advanced Search - Users' modal displays No Match Found Message
    And 'Advanced Search - Users' modal has Cancel button
    When User navigates to Workflow Management Renewal Settings page
    And User clicks "User" default assignee radio button
    And User clicks Default Assignee section Advance Search link
    And User fills in 'Advanced Search - Users' modal First Name and Last Name with "toBeReplaced" and "toBeReplaced"
    And User clicks Renewal Settings 'Advanced Search - Users' modal Search button
    And User selects Renewal Settings 'Advanced Search - Users' modal first radio button
    Then Renewal Settings 'Advanced Search - Users' modal has Add button
    When User clicks Renewal Settings 'Advanced Search - Users' modal Add button
    Then Renewal Settings "Advanced Search - Users" modal disappeared
    And Default Assignee dropdown is displayed with value "toBeReplacedAdvancedSearchUser"
    When User navigates to Workflow Management Renewal Settings page
    And User clicks "User" default assignee radio button
    And User clicks Default Assignee section Advance Search link
    Then Renewal Settings "Advanced search - Users" modal is displayed
    When User fills in 'Advanced Search - Users' modal First Name and Last Name with "toBeReplaced" and "toBeReplaced"
    And User clicks Renewal Settings 'Advanced Search - Users' modal Search button
    And The 'Add' button is disabled when user is not selected
    When User clicks Renewal Settings 'Advanced Search - Users' modal Cancel button
    Then Renewal Settings "Advanced search - Users" modal is displayed
    And Renewal Settings 'Advanced Search - Users' modal has First Name and Last Name fields
