@ui @functional @user_preferences
Feature: Home Page - Main Menu - Language Support

  As an Internal User in RDDC
  I want to set Language  in "My Preferences" page
  So that I can work with RDDC React pages in selected Language by default

  @C40948350
  Scenario: C40948350: Internal User - My Preference - Preference page have to display language field and should display language value correctly.
    Given User logs into RDDC as "Admin"
    When User clicks User Menu
    And User clicks Preferences option
    Then Personal Details section field "Language" is enabled
    And Preferences field "Language" is not required

  @C40971646
  @onlySingleThread
  Scenario: C40971646: Internal User - My Preference - My preference page are able to edit the language.
    Given User logs into RDDC as "Assignee"
    And User sets up default language via API
    When User clicks User Menu
    And User clicks Preferences option
    And User fills in Language value "French"
    And User clicks Save preferences button
    Then Alert Icon is displayed with text
      | Success! Preferences has been updated |
    When User refreshes page
    And User waits for progress bar to disappear from page
    Then Preferences Language drop-down contains "French" value
    And Personal Details section required field "Prénom" is enabled
    And Personal Details section required field "Nom" is enabled

  @C40948610
  Scenario: C40948610: Internal User- My Preference - Verify "SAVE" button when changes language value.
    Given User logs into RDDC as "Admin"
    And User sets up default language via API
    When User clicks User Menu
    And User clicks Preferences option
    And User fills in Language value "French"
    Then My Preferences page Save button is enabled

  @C40972643
  @onlySingleThread
  Scenario: C40972643: Internal User - My Preference - Verify My preference page when the required fields are empty.
    Given User logs into RDDC as "Approver"
    And User sets up default language via API
    When User clicks User Menu
    And User clicks Preferences option
    And User fills in Language value "French"
    Then My Preferences page Save button is enabled
    When User clicks Save preferences button
    And User refreshes page
    And User waits for progress bar to disappear from page
    Then Preferences Language drop-down contains "French" value
    When User clears First Name
    And User clears Last Name
    Then Error message "Ce champ est obligatoire" in red color is displayed near User Preferences fields
      | Prénom |
      | Nom    |

  @C41137761 @C41028651
  @onlySingleThread
  Scenario: C41137761, C41028651: Internal User - My Preference - Preferences page should be translated all labels with a saved language when log in with a user that edited on Edit User step.
    Given User logs into RDDC as "Internal User for Editing"
    And User sets up default language via API
    When User clicks User Menu
    And User clicks Preferences option
    And User fills in Language value "French"
    And User clicks Save preferences button
    And User waits for progress bar to disappear from page
    And User clicks Log Out button
    And User logs into RDDC as "Internal User for Editing"
    And User navigates to Home page
    And User navigates to Preferences page
    Then Preferences Language drop-down contains "French" value
    When User logs into RDDC as "Admin"
    And User navigates to Home page
    And User navigates to Preferences page
    Then Preferences Language drop-down contains "English" value
