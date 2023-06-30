@ui @full_regression @core_regression @arabica

Feature: Associated Individual - World-check and Custom WatchList screening results

  As a user,
  I want to see the World-check and Custom WatchList screening results.
  So that I can manage the screening results.

  Background:
    Given User logs into RDDC as "Admin"

  @C39520727
  Scenario: C39520727: Associated Individual - Screening - Verify default selected tab is 'World-Check'
    When User creates third-party "with random ID name"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    And User clicks Auto-screen button to ON
    And User clicks on "Custom WatchList" checkbox to "unselect" in add contact page
    And User clicks on "Media Check" checkbox to "unselect" in add contact page
    And User creates Associated Party "with mandatory fields"
    Then Screening results table is loaded
    And "WORLD-CHECK" tab is displayed
    And World-Check tab is selected
    And Label toggle is displayed as "World-Check Ongoing Screening"
    When User clicks Change Search Criteria screening button
    Then Check Type is checked
      | World-Check |

  @C39568130
  Scenario: C39568130: Associated Individual - Screening - Verify If the results are more than 10 records, I should see the pagination
    When User creates third-party "with random ID name"
    And User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    And Screening Rows Per Page is "disabled"
    When User clicks Change Search Criteria screening button
    And User edits Search Term with value "John Smith"
    Then Screening results table is loaded
    And Screening Rows Per Page is "enabled"

  @C39520728
  Scenario: C39520728: Associated Individual - Screening - Verify WC1 screening table in World-Check tab
    When User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    And Screening results table is loaded
    And User clicks WORLD-CHECK tab and "CUSTOM WATCHLIST" tab is appeared
    Then Screening section table displays expected columns
      | thirdPartyInformation.screening.columnName              |
      | thirdPartyInformation.screening.columnCountryOfLocation |
      | thirdPartyInformation.screening.columnType              |
      | thirdPartyInformation.screening.columnMatchStrength     |
      | thirdPartyInformation.screening.columnDataProvider      |
      | thirdPartyInformation.screening.columnReferenceId       |
      | thirdPartyInformation.screening.columnResolution        |
    And Verify contacts screening record for "contact" on 10 positions from "World-Check One"

  @C39569507
  Scenario: C39569507: Associated Individual - Screening - Verify WC1 screening results display 'No Available Data' If there is no available data in the selected tab
    When User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    And Screening results table is loaded
    And User clicks WORLD-CHECK tab and "CUSTOM WATCHLIST" tab is appeared
    And User clicks Change Search Criteria screening button
    And User fills in Search Term with random value
    And User clicks Search On Search criteria button
    Then No Available Data on "WORLD-CHECK" tab is displayed

  @C39603537
  Scenario: C39603537 - Screening - Verify Resolution Type tooltip is displayed and matched the text pattern
    When User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    Then Screening results table is loaded
    When User hovers WC Screening Resolution Type at position no.1
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

  @C39520735
  Scenario: C39520735 - Contacts - Screening - Verify Resolution Type tooltip is displayed and matched the text pattern
    When User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    Then Screening results table is loaded
    When User hovers WC Screening Resolution Type at position no.1
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
    Then Resolution Type Pattern is matched

  @C43475666
  Scenario: C43475666 - Contacts - Screening - Verify Match Strength tooltip is displayed and text pattern is matched
    When User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    Then  Screening results table is loaded
    When User hovers WC Screening Match Strength
    Then Match Strength tooltip is displayed
    And Match Strength Pattern is matched

  @C39570544
  Scenario: C39570544 - Contacts - Screening - Verify Last Screening Date is displayed
    When User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    Then  Screening results table is loaded
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"

  @C39520727
  Scenario: C39520727: Associated Individual - Screening - Verify default selected tab is 'World-Check'
    When User creates third-party "with random ID name"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    And User clicks Auto-screen button to ON
    And User clicks on "Custom WatchList" checkbox to "unselect" in add contact page
    And User clicks on "Media Check" checkbox to "unselect" in add contact page
    And User creates Associated Party "with mandatory fields"
    Then Screening results table is loaded
    And "WORLD-CHECK" tab is displayed
    And World-Check tab is selected
    And Label toggle is displayed as "World-Check Ongoing Screening"
    When User clicks Change Search Criteria screening button
    Then Check Type is checked
      | World-Check |

  @C39568130
  Scenario: C39568130: Associated Individual - Screening - Verify If the results are more than 10 records, I should see the pagination
    When User creates third-party "with random ID name"
    And User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    And Screening Rows Per Page is "disabled"
    When User clicks Change Search Criteria screening button
    And User edits Search Term with value "John Smith"
    Then Screening results table is loaded
    And Screening Rows Per Page is "enabled"