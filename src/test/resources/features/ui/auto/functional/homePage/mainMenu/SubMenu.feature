@ui @functional @main_menu
Feature: Home Page - Sub Menu

  As a user,
  I want to see a main menu in React.
  So that it will align with Refinitiv policy.

  @C44992364
  Scenario: C44992364: Home - Submenu - Display icons of each menu
    Given User logs into RDDC as "Internal User for Editing"
    Then User menu items are displayed
      | Preferences |
      | Set Up      |
      | Help        |
      | My Exports  |
      | Log Out     |
    When User hovers to Help submenu
    Then Help option "Get Support" is displayed
    And Help option "Share your feedback" is displayed

  @C41611659
  Scenario: C41611659: User submenu is displayed after clicking on the "Hi, {name}" line
    Given User logs into RDDC as "Internal User for Editing"
    Then User menu items are displayed
      | Preferences |
      | Set Up      |
      | Help        |
      | My Exports  |
      | Log Out     |
    When User menu item background color is changed to grey when hover over it
      | Preferences |
      | Set Up      |
      | Help        |
      | My Exports  |
      | Log Out     |
    Then User clicks User Menu
    And User menu items are hidden
