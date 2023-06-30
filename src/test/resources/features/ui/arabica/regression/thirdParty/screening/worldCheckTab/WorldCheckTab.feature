@ui @full_regression @core_regression @arabica

Feature: Third Party - Screening Result

  As a user,
  I want to see the World-check and Custom WatchList screening results.
  So that I can manage the screening results.

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "Apple"

  @C39568139
  Scenario: C39568139 - Screening - Verify If the results are more than 10 records, I should see the pagination
    When Screening results table is loaded
    Then Screening Rows Per Page is "enabled"
    When User clicks Change Search Criteria screening button
    And User edits Search Term with value "Adidas"
    Then Screening results table is loaded
    And Screening Rows Per Page is "disabled"

  @C39603530
  Scenario: C39603530: Screening - Verify Screening table in World-Check tab
    When User clicks WORLD-CHECK tab and "CUSTOM WATCHLIST" tab is appeared
    Then Screening section table displays expected columns
      | thirdPartyInformation.screening.columnName                  |
      | thirdPartyInformation.screening.columnCountryOfRegistration |
      | thirdPartyInformation.screening.columnType                  |
      | thirdPartyInformation.screening.columnMatchStrength         |
      | thirdPartyInformation.screening.columnDataProvider          |
      | thirdPartyInformation.screening.columnReferenceId           |
      | thirdPartyInformation.screening.columnResolution            |
    And Verify third-party screening record for "supplier" on the positions from "World-Check One"

  @C39603539
  Scenario: C39603539: Screening - Verify WC1 screening results display 'No Available Data' If there is no available data in the selected tab
    When User clicks WORLD-CHECK tab and "CUSTOM WATCHLIST" tab is appeared
    And User clicks Change Search Criteria screening button
    And User fills in Search Term with random value
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    And No Available Data on "WORLD-CHECK" tab is displayed

  @C39603540
  Scenario: C39603540 - Screening - Verify Last Screening Date is displayed
    When Screening results table is loaded
    Then Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"

  @C39603536
  Scenario: C39603536 - Screening - Verify Match Strength tooltip is displayed and text pattern is matched
    When Screening results table is loaded
    And User hovers WC Screening Match Strength
    Then Match Strength tooltip is displayed
    And Match Strength Pattern is matched