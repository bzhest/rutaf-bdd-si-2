@ui @full_regression @country_checklist
Feature: Delete/Inactivate Country Checklist

  As a Supplier Integrity Administrator
  I want to be able to be able to delete/inactivate Country Checklists
  So that I can delete/inactivate the Lists that are no longer being used in Supplier Integrity

  Background:
    Given User logs into RDDC as "Admin"

  @C36068925
  Scenario: C36068925: [Country Checklist Setup] - Delete List Name
    When User creates Country Checklist "Caution with assigned Belize to be deleted" via API
    And User creates third-party "with mandatory fields"
    And User clicks Set Up option
    And User clicks Country Checklist in Set Up menu
    Then Country Checklist page is loaded
    When User clicks delete button for country checklist "toBeReplaced"
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this country checklist? |
      | This change cannot be undone.                           |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Country "toBeReplaced" is displayed with values
      | List Name    | Alert Type | Status | Date Created | Last Update |
      | toBeReplaced | Caution    | Active | MM/dd/YYYY   |             |
    When User clicks delete button for country checklist "toBeReplaced"
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success!                       |
      | Country checklist has been deleted |
    Then Confirmation window is disappeared
    And Country Checklist "toBeReplaced" is not displayed
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks General and Other Information section "Edit" button
    And User selects "Afghanistan" country in Edit Profile Country drop-down
    And User waits for progress bar to disappear from page
    Then Address Country alert message is not displayed
    When User updates Bank Details on position 1 with values
      | Bank Country |
      | Afghanistan  |
    And User waits for progress bar to disappear from page
    Then Address Country alert message is not displayed

  @C36071607
  Scenario: C36071607: [Country Checklist Setup] - Deactivate List Name and verify that Alerts belongs to only Active List Names are displayed on the Supplier Information page
    When User creates Country Checklist "Caution with assigned Afghanistan to be inactivated" via API
    And User creates third-party "with mandatory fields" via API and open it
    And User clicks Set Up option
    And User clicks Country Checklist in Set Up menu
    Then Country Checklist page is loaded
    When User clicks edit button for country checklist "toBeReplaced"
    Then "Edit Country Checklist" details page is displayed
    When User unchecks Active Country Checklist checkbox
    And User clicks Save button for edit assigning Country
    Then Alert Icon is displayed with text
      | Success                          |
      | Country checklist has been saved |
    Then Country Checklist page is loaded
    And  Country "toBeReplaced" is displayed with values
      | List Name    | Alert Type | Status   | Date Created | Last Update |
      | toBeReplaced | Caution    | Inactive | MM/dd/YYYY   | MM/dd/YYYY  |
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks General and Other Information section "Edit" button
    And User selects "Afghanistan" country in Edit Profile Country drop-down
    Then Address Country alert message is not displayed