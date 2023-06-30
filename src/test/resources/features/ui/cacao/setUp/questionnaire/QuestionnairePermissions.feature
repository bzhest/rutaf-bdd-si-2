@ui @cacao @functional @questionnaires
Feature: Questionnaire Management - Permissions

  As a RDDC System Administrator
  I want to be able to limit the access to the Questionnaire management setup module
  So that only the authorized users will be able to configure the Questionnaires in the system


  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Questionnaire Management page


  @C46305591
  Scenario: C46305591: [Questionnaire Management] User with Permissions
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User clicks Questionnaire Setup button "Cancel"
    And User searches item by "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" keyword
    And User clicks edit questionnaire with name "AUTO_TEST_EXTERNAL_QUESTIONNAIRE"
    Then Questionnaire tab displayed in edit mode
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks Clone questionnaire button for "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" Questionnaire
    Then Clone Questionnaire pop-up appears with Questionnaire Name
    When User fills in New Questionnaire Name field with "toBeReplaced"
    And User clicks Clone Questionnaire modal "Clone" button
    And User clears search input field
    Then Cloned Questionnaire is displayed on questionnaires table

  @C46307848
  Scenario: C46307848: [Questionnaire Management] User with NO Permissions
    When User clicks Add Questionnaire button
    And User fills "with completed Internal data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User saves Questionnaire ID from current URL
    And User clicks Log Out button
    And User logs into RDDC as "Restricted"
    And User clicks Set Up option
    Then Setup navigation option "Questionnaires" is not displayed
    When User navigates to Questionnaire Management page
    Then Current URL contains "/forbidden" endpoint
    When User navigates to Add Questionnaire Management page
    Then Current URL contains "/forbidden" endpoint
    When User navigates to open "" existing Questionnaire Management page
    Then Current URL contains "/forbidden" endpoint
    When User navigates to open "/edit" existing Questionnaire Management page
    Then Current URL contains "/forbidden" endpoint
    When User navigates to open "/preview" existing Questionnaire Management page
    Then Current URL contains "/forbidden" endpoint
