@ui @full_regression @user_management @react
Feature: User Management - Groups

  As an RDDC Administrator
  I want to be able to delete Groups
  So that I can delete the Groups that are no longer being used in RDDC

  Background:
    Given User logs into RDDC as "Admin"

  @C43829140
  Scenario: C43829140 - User can delete a group that is not in use
    When User creates new User Group "active user group" via API
    And User navigates to Group Management page
    Then Edit and Delete icons are available on User Groups page
    When User clicks "Delete" icon for the created User Group
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Group? This change cannot be undone. |
    And Confirmation button Cancel should be displayed
    And Confirmation button Delete should be displayed
    When User clicks Delete button on confirmation window
    Then Alert Icon for User Group Management is displayed with text
      | Success!            |
      | %s has been deleted |
    When User searches group by group name - "groupName"
    Then 'No match found' is displayed on user groups table

  @C43829143
  @core_regression
  Scenario: C43829143 - Group that is in use cannot be deleted
    When User creates new User Group "active user group" via API
    And User creates Approval Process with "approval process with group" via API
    And User navigates to Group Management page
    Then Edit and Delete icons are available on User Groups page
    When User clicks "Delete" icon for the created User Group
    Then Message is displayed on confirmation window
      | This Group is currently in use and you will not be able to delete it |
    When User clicks Ok button on confirmation window
    Then Confirmation window is disappeared
    And Group is displayed with values
      | Group name   | Description | Status | Date Created | Last Update |
      | toBeReplaced |             | Active | MM/dd/YYYY   |             |


  @C43715883
  Scenario: C43715883 - "All" option is default for the filter on the "User Management/ Groups" page
    When User navigates to Group Management page
    Then Show Drop-Down current option should be "All"
    And All User Groups are displayed on groups table

  @C43712471
    @C43715828
    @C43715829
  Scenario Outline: C43712471, C43715828, C43715829 - Groups only with "Active/Inactive/All" status are displayed when "Active/Inactive/All" option is enabled in filter
    When User navigates to Group Management page
    And User selects "Active" show option
    And User selects "<showOption>" show option
    Then <showOption> User Groups are displayed on groups table

    Examples:
      | showOption |
      | All        |
      | Active     |
      | Inactive   |

  @C43715931
  Scenario: C43715931 - "NO MATCH FOUND" is displayed when no results returned by search
    When User navigates to Group Management page
    And User searches group by group name - "NonValid%34234"
    Then 'No match found' is displayed on user groups table

  @C44102097
  Scenario: C44102097 - (Set Up/ Group) - Search result list is sorted by relevancy
    When User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User navigates to Group Management page
    And User searches group by group name - "AUTO_TEST_"
    Then User Groups table is displayed only with groups names contain "AUTO_TEST_"

  @C43833387
  Scenario: C43833387 - Group that is in use cannot be deactivated
    When User creates new User Group "active user group" via API
    And User creates Approval Process with "approval process with group" via API
    And User navigates to Group Management page
    Then Edit and Delete icons are available on User Groups page
    When User ticks created User Group to be deactivated
    And User Group Deactivate button appears
    And User clicks User Group Deactivate button
    Then Message is displayed on confirmation window
      | The selected Group(s) are currently in use and you will not be able to deactivate it |
    When User clicks Ok button on confirmation window
    Then Confirmation window is disappeared
    And Group is displayed with values
      | Group name   | Description | Status | Date Created | Last Update |
      | toBeReplaced |             | Active | MM/dd/YYYY   |             |

  @C43833391
  Scenario: C43833391 - User can deactivate multiple groups that are not in use at once
    When User creates new User Group "active user group" via API
    And User creates new User Group "active user group" via API
    And User navigates to Group Management page
    Then Edit and Delete icons are available on User Groups page
    When User ticks created User Groups to be deactivated
    And User Group Deactivate button appears
    And User clicks User Group Deactivate button
    Then Message is displayed on confirmation window
      | The selected Group(s) will be deactivated. Do you want to proceed? |
    When User clicks No button on confirmation window
    Then Confirmation window is disappeared
    And Group is displayed with values
      | Group name   | Description | Status | Date Created | Last Update |
      | toBeReplaced |             | Active | MM/dd/YYYY   |             |
      | toBeReplaced |             | Active | MM/dd/YYYY   |             |
    When User clicks User Group Deactivate button
    Then Message is displayed on confirmation window
      | The selected Group(s) will be deactivated. Do you want to proceed? |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Group is displayed with values
      | Group name   | Description | Status   | Date Created | Last Update |
      | toBeReplaced |             | Inactive | MM/dd/YYYY   | MM/dd/YYYY  |
      | toBeReplaced |             | Inactive | MM/dd/YYYY   | MM/dd/YYYY  |