@ui @full_regression @core_regression @arabica

Feature: Associated Individual - Screening section - Screening Result

  As a RDDC user
  I want an ability to display results from Custom Watchlist
  So that I can see the correct result in a table.

  Background:
    Given User logs into RDDC as "Admin"

  @C39520737 @C39520738
  Scenario: C39520737 C39520738: Associated Individual - Screening - Verify all components of the screening table
    When User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    And Screening results table is loaded
    And User clicks WORLD-CHECK tab and "CUSTOM WATCHLIST" tab is appeared
    And User clicks CUSTOM WATCHLIST tab at Screening section
    Then Screening section table displays expected columns
      | thirdPartyInformation.screening.columnName              |
      | thirdPartyInformation.screening.columnCountryOfLocation |
      | thirdPartyInformation.screening.columnType              |
      | thirdPartyInformation.screening.columnMatchStrength     |
      | thirdPartyInformation.screening.columnDataProvider      |
      | thirdPartyInformation.screening.columnReferenceId       |
      | thirdPartyInformation.screening.columnResolution        |
    And Verify contacts screening record for "contact" on 10 positions from "Custom WatchList"

  @C39520747
  Scenario: C39520747: Associated Individual - Custom Watchlist - Screening - Verify screening results display 'No Available Data' If there is no available data in the selected tab
    When User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    And Screening results table is loaded
    And User clicks WORLD-CHECK tab and "CUSTOM WATCHLIST" tab is appeared
    And User clicks CUSTOM WATCHLIST tab at Screening section
    And User clicks Change Search Criteria screening button
    And User fills in Search Term with random value
    And User clicks Search On Search criteria button
    Then No Available Data on "CUSTOM WATCHLIST" tab is displayed

  @C43475667
  Scenario: C43475667: Associated Individual - Custom Watchlist - Screening - Verify Match Strength tooltip is displayed and text pattern is matched
    When User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    Then Screening results table is loaded
    When User clicks WORLD-CHECK tab and "CUSTOM WATCHLIST" tab is appeared
    And User clicks CUSTOM WATCHLIST tab at Screening section
    And User hovers WC Screening Match Strength
    Then Match Strength tooltip is displayed
    And Match Strength Pattern is matched

  @C39520745
  Scenario: C39520745: Associated Individual - Custom Watchlist - Screening - Verify Resolution Type tooltip is displayed and matched the text pattern
    When User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    Then Screening results table is loaded
    When User clicks WORLD-CHECK tab and "CUSTOM WATCHLIST" tab is appeared
    And User clicks CUSTOM WATCHLIST tab at Screening section
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
    Then Screening results table is loaded
    When User hovers WC Screening Resolution Type at position no.1
    Then Resolution Type tooltip "positive" is displayed
    When User hovers WC Screening Resolution Type at position no.1
    And Resolution Type Pattern is matched

  @C39570543
  Scenario: C39570543: Associated Individual - Custom Watchlist - Screening - Verify Last Screening Date is displayed
    When User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    Then Screening results table is loaded
    When User clicks WORLD-CHECK tab and "CUSTOM WATCHLIST" tab is appeared
    And User clicks CUSTOM WATCHLIST tab at Screening section
    Then Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"