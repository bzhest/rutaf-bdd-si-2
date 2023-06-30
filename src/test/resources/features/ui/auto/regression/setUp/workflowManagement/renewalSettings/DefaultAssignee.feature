@ui @core_regression @workflow_management
Feature: Workflow Management - Renewal Settings - Default Assignee

  As a Third-party Integrity Administrator
  I want to assign Default Assignees to Third-parties that are for Renewal
  So that the renewal of the Third-parties will be attended to as soon as they are ready for renewal

  @C35778483 @C37447402
  Scenario: C35778483, C37447402: Workflow Management - Renewal Settings - check Renewal trigger : ability to setup Default Assignee for Renewal
    Given User logs into RDDC as "Admin"
    And User clicks Set Up option
    When User clicks Workflow Management Renewal Settings submenu in Set Up menu
    Then Renewal Settings page is displayed
    And Renewal Settings page has "Default Assignee" section
    And Renewal Settings page Default Assignee section has the following fields
      | fieldName         | inputType | isDisabled |
      | User              | radio     | false      |
      | User Group        | radio     | false      |
      | Responsible Party | radio     | false      |
    And Default Assignee section Default Assignee dropdown is displayed
    And Renewal Settings page has Save button
    When User clicks "User" default assignee radio button
    Then Default Assignee dropdown becomes enabled
    And Default Assignee dropdown contains 20 Active Internal users
    When User clicks "User Group" default assignee radio button
    Then Default Assignee dropdown becomes enabled
    And Default Assignee dropdown contains all Active Internal user groups
    When User selects "toBeReplaced" for "User Group" in Default Assignee dropdown
    And User clicks "Responsible Party" default assignee radio button
    Then Default Assignee dropdown becomes disabled
    And Value in Default Assignee dropdown is cleared
    When User clicks "User" default assignee radio button
    And User clicks Renewal Settings Save button
    Then Alert Icon for Renewal Settings page is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" with red border is displayed for Default Assignee dropdown
    When User clicks "User Group" default assignee radio button
    And User clicks Renewal Settings Save button
    Then Alert Icon for Renewal Settings page is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" with red border is displayed for Default Assignee dropdown
    When User clicks "User" default assignee radio button
    And User selects "toBeReplaced" for "User" in Default Assignee dropdown
    And User clicks Renewal Settings Save button
    Then Alert Icon for Renewal Settings page is displayed with text
      | Success!                       |
      | Renewal Setup has been updated |
    When User clicks Workflow Management Workflow submenu in Set Up menu
    And User clicks Workflow Management Renewal Settings submenu in Set Up menu
    And User waits for progress bar to disappear from page
    Then "User" default assignee radio button is checked
    And Default Assignee dropdown is displayed with value "toBeReplaced"
