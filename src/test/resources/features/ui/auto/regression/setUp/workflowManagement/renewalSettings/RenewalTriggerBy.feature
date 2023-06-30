@ui @full_regression @workflow_management
Feature: Workflow Management - Renewal Settings - Renewal Trigger By

  As a Third-party Integrity Administrator
  I want the status of Onboarded Third-parties to automatically be changed to "FOR RENEWAL"
  So that the assigned users will be able to manage them accordingly

  @C35777862
  Scenario: C35777862: Workflow Management - Renewal Settings - check Renewal Trigger By
    Given User logs into RDDC as "Admin"
    And User clicks Set Up option
    When User clicks Workflow Management Renewal Settings submenu in Set Up menu
    Then 'Renewal Settings Rules' section is displayed
    And Renewal Settings page has "Renewal Trigger By" section
    And Renewal Trigger By section has 'Next Renewal Date' radio button
    And Renewal Trigger By section has 'Days Before Renewal' radio button with text input field
    When User clicks Next Renewal Date radio button
    Then 'Days Before Renewal' text input is disabled
    When User clicks Days Before Renewal radio button
    Then 'Days Before Renewal' text input is enabled
    And The max value for 'Days Before Renewal' field is 4 digits
    When User fills in 'Days Before Renewal' text input with "10"
    And User clicks Next Renewal Date radio button
    Then 'Days Before Renewal' text input is empty
    When User clicks Days Before Renewal radio button
    And User clicks Renewal Settings Save button
    Then Alert Icon for Renewal Settings page is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And 'Days Before Renewal' text input is highlighted RED with message "This is a required field and needs a valid value"
    When User clicks Next Renewal Date radio button
    And User clicks Renewal Settings Save button
    Then Alert Icon for Renewal Settings page is displayed with text
      | Success!                       |
      | Renewal Setup has been updated |
    When User clicks Workflow Management Workflow submenu in Set Up menu
    And User clicks Workflow Management Renewal Settings submenu in Set Up menu
    Then 'Next Renewal Date' radio button is "checked"
