@ui @full_regression @workflow_management
Feature: Workflow Management - Renewal Settings - Country/Workflow Group/Commodity Type

  As a Third-party Integrity Administrator
  I want to designate Assignees to Third-parties that are for Renewal based on the Third-party Country/Third-party Workflow Group/Third-party Commodity Type
  So that the renewal of the Third-parties will be attended to as soon as they are ready for renewal

  @C35804113 @C35804149 @C35804216
  Scenario Outline: C35804113, C35804149, C35804216: Check user to setup rule to trigger Assignee - Country, Workflow Group, Commodity Type
    Given User logs into RDDC as "Admin"
    And User navigates to Workflow Management Renewal Settings page
    And User makes sure that Assignee Rule with default setup is added
    When User clicks 'Rule' dropdown for last added rule
    Then 'Rule' dropdown of last added rule contains "<ruleDropDownValue>" value
    When User selects "<ruleDropDownValue>" from 'Rule' dropdown of last added rule
    Then 'Rule value' dropdown of last added rule becomes enabled
    And 'Rule value' dropdown contains all "<typeOfValues>"
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
    When User clicks 'Rule' dropdown for last added rule
    Then 'Rule' dropdown of last added rule contains "<ruleDropDownValue>" value
    And 1 selected value(s) is(are) displayed in Rule Value dropdown of last added rule
    And "Responsible Party" Assignee Rule radio button of last added rule is ticked
    Examples:
      | ruleDropDownValue          | typeOfValues           |
      | Third-party Country        | Countries              |
      | Third-party Workflow Group | Active Workflow Groups |
      | Third-party Commodity Type | Commodity Types        |
