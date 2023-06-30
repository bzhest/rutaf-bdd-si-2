@ui @core_regression @workflow_management
Feature: Workflow Management - Renewal Settings - Default Assignee - User Group

  As a Third-party Integrity Administrator
  I want to assign Default Assignees to Third-parties that are for Renewal
  So that the renewal of the Third-parties will be attended to as soon as they are ready for renewal

  @C35798808 @C37447404
  Scenario: C35798808, C37447404: Workflow Management - Check Advance Search for User Group on Default Assignee field
    Given User logs into RDDC as "Admin"
    When User navigates to Workflow Management Renewal Settings page
    And User clicks "User Group" default assignee radio button
    Then Default Assignee section Advance Search link is displayed
    When User clicks Default Assignee section Advance Search link
    Then Renewal Settings "Advanced search - Users Group" modal is displayed
    And Renewal Settings 'Advanced Search - Users Group' modal has Group Name field
    And Renewal Settings 'Advanced Search - Users Group' modal has Search and Cancel buttons
    When User fills in 'Advanced Search - Users Group' modal Group Name with "toBeReplaced"
    And User clicks Renewal Settings 'Advanced Search - Users Group' modal Search button
    Then Renewal Settings "Advanced search - Users Group" modal is displayed
    And 'Advanced Search - Users Group' modal appropriate results are displayed in Group Name column
    When User navigates to Workflow Management Renewal Settings page
    And User clicks "User Group" default assignee radio button
    And User clicks Default Assignee section Advance Search link
    Then Renewal Settings "Advanced search - Users Group" modal is displayed
    When User clicks Renewal Settings 'Advanced Search - Users Group' modal Search button
    Then Renewal Settings "Advanced search - Users Group" modal is displayed
    And The 'Add' button is disabled when user group is not selected
    And All Active User Groups are returned as a search result in 'Advanced Search - Users Group' modal
    When User navigates to Workflow Management Renewal Settings page
    And User clicks "User Group" default assignee radio button
    And User clicks Default Assignee section Advance Search link
    Then Renewal Settings "Advanced search - Users Group" modal is displayed
    When User fills in 'Advanced Search - Users Group' modal Group Name with "invalid"
    And User clicks Renewal Settings 'Advanced Search - Users Group' modal Search button
    Then Renewal Settings 'Advanced Search - Users Group' modal displays No Match Found Message
    And 'Advanced Search - Users Group' modal has Cancel button
    When User navigates to Workflow Management Renewal Settings page
    And User clicks "User Group" default assignee radio button
    And User clicks Default Assignee section Advance Search link
    Then Renewal Settings "Advanced search - Users Group" modal is displayed
    When User fills in 'Advanced Search - Users Group' modal Group Name with "toBeReplaced"
    And User clicks Renewal Settings 'Advanced Search - Users' modal Search button
    And User selects Renewal Settings 'Advanced Search - Users Group' modal first radio button
    Then Renewal Settings 'Advanced Search - Users' modal has Add button
    When User clicks Renewal Settings 'Advanced Search - Users' modal Add button
    Then Renewal Settings "Advanced Search - Users Group" modal disappeared
    And Default Assignee dropdown is displayed with value "toBeReplacedAdvancedSearchUserGroup"
    When User navigates to Workflow Management Renewal Settings page
    And User clicks "User Group" default assignee radio button
    And User clicks Default Assignee section Advance Search link
    Then Renewal Settings "Advanced search - Users Group" modal is displayed
    When User fills in 'Advanced Search - Users Group' modal Group Name with "toBeReplaced"
    And User clicks Renewal Settings 'Advanced Search - Users' modal Search button
    And User clicks Renewal Settings 'Advanced Search - Users' modal Add button
    Then Renewal Settings "Advanced Search - Users Group" modal disappeared
    When User navigates to Workflow Management Renewal Settings page
    And User clicks "User Group" default assignee radio button
    And User clicks Default Assignee section Advance Search link
    Then Renewal Settings "Advanced search - Users Group" modal is displayed
    When User fills in 'Advanced Search - Users Group' modal Group Name with "toBeReplaced"
    And User clicks Renewal Settings 'Advanced Search - Users' modal Search button
    Then 'Advanced Search - Users Group' modal appropriate results are displayed in Group Name column
    When User clicks Renewal Settings 'Advanced Search - Users Group' modal Cancel button
    Then Renewal Settings "Advanced search - Users Group" modal is displayed
    And Renewal Settings 'Advanced Search - Users Group' modal has Group Name field
