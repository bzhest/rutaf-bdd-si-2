@ui @full_regression @core_regression @arabica

Feature: Third Party - Custom Watchlist - Screening Result

  As a RDDC user
  I want an ability to display results from Custom Watchlist.
  So that I can see the correct result in a table.

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "Adidas"

  @C39603541 @C39603542
  Scenario: C39603541 C39603542: Screening - Verify Screening table in Custom Watchlist tab
    When User clicks CUSTOM WATCHLIST tab at Screening section
    Then Screening section table displays expected columns
      | thirdPartyInformation.screening.columnName                  |
      | thirdPartyInformation.screening.columnCountryOfRegistration |
      | thirdPartyInformation.screening.columnType                  |
      | thirdPartyInformation.screening.columnMatchStrength         |
      | thirdPartyInformation.screening.columnDataProvider          |
      | thirdPartyInformation.screening.columnReferenceId           |
      | thirdPartyInformation.screening.columnResolution            |
    And Verify third-party screening record for "supplier" on the positions from "Custom WatchList"

  @C39603551
  Scenario: C39603551: Screening - Verify WC1 screening results display 'No Available Data' If there is no available data in the selected tab
    When User clicks WORLD-CHECK tab and "CUSTOM WATCHLIST" tab is appeared
    And User clicks Change Search Criteria screening button
    And User fills in Search Term with random value
    And User clicks Search On Search criteria button
    And User clicks CUSTOM WATCHLIST tab at Screening section
    Then No Available Data on "CUSTOM WATCHLIST" tab is displayed

  @C43429040
  Scenario: C43429040 - Custom WatchList - Screening - Verify Match Strength tooltip is displayed and text pattern is matched
    When User clicks CUSTOM WATCHLIST tab at Screening section
    And User hovers WC Screening Match Strength
    Then Match Strength tooltip is displayed
    And Match Strength Pattern is matched

  @C39603549
  Scenario: C39603549 - Custom WatchList - Screening - Verify Resolution Type tooltip is displayed and matched the text pattern
    When User clicks CUSTOM WATCHLIST tab at Screening section
    And User hovers WC Screening Resolution Type at position no.1
    Then Resolution Type tooltip "positive" is displayed
    When User hovers WC Screening Resolution Type at position no.2
    Then Resolution Type tooltip "possible" is displayed
    When User hovers WC Screening Resolution Type at position no.3
    Then Resolution Type tooltip "false" is displayed
    When User marks resolution on position no.1
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And Screening results table is loaded
    And User hovers WC Screening Resolution Type at position no.1
    Then Resolution Type tooltip "positive" is displayed
    When User hovers WC Screening Resolution Type at position no.1
    And Resolution Type Pattern is matched

  @C39603552
  Scenario: C39603552 - Custom WatchList - Screening - Verify Last Screening Date is displayed
    When User clicks CUSTOM WATCHLIST tab at Screening section
    And Screening results table is loaded
    Then Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"