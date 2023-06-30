@ui @full_regression @workflow_management
Feature: Workflow Management - Renewal Settings - Check Renewal Setup

  As a Third-party Integrity Administrator
  I want to be able to designate varying Assignees to Third-parties that are for Renewal
  So that the renewal of the Third-parties will be attended to by the right users based on the Third-party details

  @C35811442
  Scenario: C35811442: Workflow Management - Check Renewal Setup: allow adding/deleting multiple rules and Save renewal settings
    Given User logs into RDDC as "Admin"
    When User navigates to Workflow Management Renewal Settings page
    Then 'Renewal Settings Rules' section is displayed
    And Renewal Settings page has "Renewal Assignee Rules" section
    And 'Renewal Settings Rules' section 'Add Rules' button is displayed
    When User clicks 'Add Rules' button
    Then 'Renewal Settings Rules' section has default enabled Rule dropdown
    And 'Renewal Settings Rules' section has default disabled Rule Value dropdown
    And 'Renewal Settings Rules' section has default disabled "User" radio button
    And 'Renewal Settings Rules' section has default disabled "User Group" radio button
    And 'Renewal Settings Rules' section has default disabled "Responsible Party" radio button
    And 'Renewal Settings Rules' section has default disabled Assignee dropdown
    When User clicks 'Rule' dropdown for last added rule
    And User selects "Third-party Country" from 'Rule' dropdown of last added rule
    And User selects 1 value(s) from Rule Value dropdown of last added rule
    And User adds 20 Renewal Assignee Rules
    Then 20 Renewal Assignee Rules are displayed
    When User clicks 'Add Rules' button
    Then Alert Icon for Renewal Settings page is displayed with text
      | Cannot Add                              |
      | Exceed the limit of the number of rules |
    When User refreshes page
    And User waits for progress bar to disappear from page
    And User adds 3 Renewal Assignee Rules
    And User removes 1 value from Rule Value dropdown of last added rule
    And User clicks Renewal Settings Save button
    Then Alert Icon for Renewal Settings page is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" with red border is displayed for Rule Value dropdown of last added rule
    When User selects 1 value(s) from Rule Value dropdown of last added rule
    And User selects Assignee Rule "User" radio button of last added rule
    And User clicks Renewal Settings Save button
    Then Alert Icon for Renewal Settings page is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" with red border is displayed for Assignee dropdown of last added rule
    When User selects Assignee Rule "User Group" radio button of last added rule
    And User clicks Renewal Settings Save button
    Then Alert Icon for Renewal Settings page is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" with red border is displayed for Assignee dropdown of last added rule
    When User selects Assignee Rule "Responsible Party" radio button of last added rule
    And User clicks Renewal Settings Save button
    Then Alert Icon for Renewal Settings page is displayed with text
      | Success!                       |
      | Renewal Setup has been updated |
    When User deletes previously created rule "toBeReplaced"
    Then Rule "toBeReplaced" is not displayed
    When User deletes all renewal rules except one
    Then 'Delete' button is hidden if there is only one Renewal rule present
