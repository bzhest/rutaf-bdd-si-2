@ui @full_regression @core_regression @react @dashboard
Feature: Home Page - Main Menu

  As a user,
  I want to see a main menu in React.
  So that it will align with Refinitiv policy.

  @C46712101
  Scenario: C46712101: Main menu items are displayed on the top of the page
    Given User logs into RDDC as "Admin"
    When User navigates to Home page
    Then Home Page buttons are displayed in the header
      | HOME        |
      | THIRD-PARTY |
      | REPORTS     |

  @C46712108
  @onlySingleThread
  Scenario: C46712108: An eight-character User First Name is displayed in full in the "Hi, {name}" line
    Given User logs into RDDC as "Internal User for Editing"
    When User clicks User Menu
    And User clicks Preferences option
    And User updates First Name Personal Details with value random 8 characters name
    And External User clicks Save preferences button
    And User clicks Home page
    Then Header "Hi, userEditedFirstName" label is displayed

  @C46712110
  Scenario: C46712110: Capitalization of the first name in the "Hi, {name}" line correspond to the capitalization in user preferences
    Given User logs into RDDC as "Internal User for Editing"
    When User clicks User Menu
    And User clicks Preferences option
    And User updates First Name Personal Details with value "User"
    And External User clicks Save preferences button
    And User clicks Home page
    Then Header "Hi, UseruserEditedFirstName" label is displayed
    When User clicks User Menu
    And User clicks Preferences option
    And User updates First Name Personal Details with value "user"
    And External User clicks Save preferences button
    And User clicks Home page
    Then Header "Hi, useruserEditedFirstName" label is displayed
