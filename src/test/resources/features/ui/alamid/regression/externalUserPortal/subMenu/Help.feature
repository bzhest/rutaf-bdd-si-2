@ui @full_regression @external_user_profile @alamid

Feature: External User Portal

  @C44992562 @C44992657 @C44992661
  Scenario: C44992562, C44992657, C44992661: External User Portal - Sub menu - Help - Redirect to 'Share your feedback' link
    Given User logs into RDDC as "External"
    Then User menu items are displayed
      | Preferences |
      | Help        |
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
