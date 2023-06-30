@ui @full_regression @rebranding
Feature: Rebranding - Renewal Settings
  As a product owner,
  I want to update admin user assignee to the new admin user in Workflow Renewal Settings
  So that admin user in Workflow Renewal Settings will assign to the new admin user.

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Workflow Management Renewal Settings page
    And User makes sure that Assignee Rule with default setup is added
    And User clicks 'Rule' dropdown for last added rule

  @C37447406
  Scenario: C37447406: Workflow Management - Renewal Settings - check user to setup rule to trigger Assignee - Third-party Country
    When User selects "Third-party Country" from 'Rule' dropdown of last added rule
    Then 'Rule value' dropdown of last added rule becomes enabled
    And 'Rule value' dropdown contains all "Countries"
    And "User" radio button of last added rule becomes enabled
    And "User Group" radio button of last added rule becomes enabled
    And "Responsible Party" radio button of last added rule becomes enabled
    When User selects 3 value(s) from Rule Value dropdown of last added rule
    Then 3 selected value(s) is(are) displayed in Rule Value dropdown of last added rule
    When User removes 1 value from Rule Value dropdown of last added rule
    Then 2 selected value(s) is(are) displayed in Rule Value dropdown of last added rule
    When User selects Assignee Rule "User" radio button of last added rule
    Then Assignee dropdown of last added rule becomes enabled
    And Assignee dropdown contains 20 Active Internal Users
    When User selects Assignee Rule "User Group" radio button of last added rule
    Then Assignee dropdown of last added rule becomes enabled
    And Assignee dropdown contains all Active User Groups
    When User selects Assignee Rule "Responsible Party" radio button of last added rule
    Then Assignee dropdown of last added rule becomes disabled
    And Assignee dropdown of last added rule is empty
    When User removes 2 value from Rule Value dropdown of last added rule
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
    When User clicks Workflow Management Workflow submenu in Set Up menu
    And User clicks Workflow Management Renewal Settings submenu in Set Up menu
    And User clicks 'Rule' dropdown for last added rule
    Then 'Rule' dropdown of last added rule contains "Third-party Country" value
    And 1 selected value(s) is(are) displayed in Rule Value dropdown of last added rule
    And "Responsible Party" Assignee Rule radio button of last added rule is ticked

  @C37447407
  Scenario: C37447407: Workflow Management - Renewal Settings - check user to setup rule to trigger Assignee - Third-party Workflow Group
    When User selects "Third-party Workflow Group" from 'Rule' dropdown of last added rule
    Then 'Rule value' dropdown of last added rule becomes enabled
    And 'Rule value' dropdown contains all "Active Workflow Groups"
    And "User" radio button of last added rule becomes enabled
    And "User Group" radio button of last added rule becomes enabled
    And "Responsible Party" radio button of last added rule becomes enabled
    When User selects 3 value(s) from Rule Value dropdown of last added rule
    Then 3 selected value(s) is(are) displayed in Rule Value dropdown of last added rule
    When User removes 1 value from Rule Value dropdown of last added rule
    Then 2 selected value(s) is(are) displayed in Rule Value dropdown of last added rule
    When User selects Assignee Rule "User" radio button of last added rule
    Then Assignee dropdown of last added rule becomes enabled
    And Assignee dropdown contains 20 Active Internal Users
    When User selects Assignee Rule "User Group" radio button of last added rule
    Then Assignee dropdown of last added rule becomes enabled
    And Assignee dropdown contains all Active User Groups
    When User selects Assignee Rule "Responsible Party" radio button of last added rule
    Then Assignee dropdown of last added rule becomes disabled
    And Assignee dropdown of last added rule is empty
    When User removes 2 value from Rule Value dropdown of last added rule
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
    When User clicks Workflow Management Workflow submenu in Set Up menu
    And User clicks Workflow Management Renewal Settings submenu in Set Up menu
    And User clicks 'Rule' dropdown for last added rule
    Then 'Rule' dropdown of last added rule contains "Third-party Workflow Group" value
    And 1 selected value(s) is(are) displayed in Rule Value dropdown of last added rule
    And "Responsible Party" Assignee Rule radio button of last added rule is ticked

  @C37447408
  Scenario: C37447408: Workflow Management - Renewal Settings - check user to setup rule to trigger Assignee - Third-party Commodity Type
    When User selects "Third-party Commodity Type" from 'Rule' dropdown of last added rule
    Then 'Rule value' dropdown of last added rule becomes enabled
    And 'Rule value' dropdown contains all "Commodity Types"
    And "User" radio button of last added rule becomes enabled
    And "User Group" radio button of last added rule becomes enabled
    And "Responsible Party" radio button of last added rule becomes enabled
    When User selects 3 value(s) from Rule Value dropdown of last added rule
    Then 3 selected value(s) is(are) displayed in Rule Value dropdown of last added rule
    When User removes 1 value from Rule Value dropdown of last added rule
    Then 2 selected value(s) is(are) displayed in Rule Value dropdown of last added rule
    When User selects Assignee Rule "User" radio button of last added rule
    Then Assignee dropdown of last added rule becomes enabled
    And Assignee dropdown contains 20 Active Internal Users
    When User selects Assignee Rule "User Group" radio button of last added rule
    Then Assignee dropdown of last added rule becomes enabled
    And Assignee dropdown contains all Active User Groups
    When User selects Assignee Rule "Responsible Party" radio button of last added rule
    Then Assignee dropdown of last added rule becomes disabled
    And Assignee dropdown of last added rule is empty
    When User removes 2 value from Rule Value dropdown of last added rule
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
    When User clicks Workflow Management Workflow submenu in Set Up menu
    And User clicks Workflow Management Renewal Settings submenu in Set Up menu
    And User clicks 'Rule' dropdown for last added rule
    Then 'Rule' dropdown of last added rule contains "Third-party Commodity Type" value
    And 1 selected value(s) is(are) displayed in Rule Value dropdown of last added rule
    And "Responsible Party" Assignee Rule radio button of last added rule is ticked