@ui @suppliers @alamid @full_regression

Feature: Third-party Screening section

  @C44864740 @core_regression
  Scenario: C44864740: Third-party - Screening - Send WC Groups to WC
    Given User logs into RDDC as "Admin"
    When User opens third-party creation form
    And User fills third-party creation form with third-party's test data "Paris"
    And User expands the add third-party screening criteria accordion if it is collapsed
    And User selects other group 2
    And User submits Third-party creation form
    Then Screening results table is loaded
    And "WORLD-CHECK" tab is displayed
    When User clicks on "CUSTOM WATCHLIST" tab
    Then "CUSTOM WATCHLIST" tab is displayed
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed