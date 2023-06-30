@ui @full_regression @alamid @dashboard

Feature: Home page Sub menu

  @C44992558 @C44992560
  Scenario: C44992558, C44992560: Home - Submenu - Help - Redirect to "Share your feedback" link
    Given User logs into RDDC as "Admin"
    Then User menu items are displayed
      | Preferences |
      | Set Up      |
      | Help        |
      | My Exports  |
      | Log Out     |
    When User hovers to Help submenu
    Then Help option "Get Support" is displayed
    And Help option "Share your feedback" is displayed
    When User selects "Get Support" from Help submenu
    Then User should be redirected to "login.cp.thomsonreuters.net"
    When User navigates back to RDDC page
    And User hovers to Help submenu
    And User selects "Share your feedback" from Help submenu
    Then User should be redirected to "https://my.refinitiv.com/content/mytr/en/feedback.html"
