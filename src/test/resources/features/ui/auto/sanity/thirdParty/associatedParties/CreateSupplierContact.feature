@ui @sanity @contacts @multilanguage
Feature: Create Third-party Contact

  As A user
  I want to have a user interface create contact
  So that I can create contacts


  @C32988227
  Scenario: C32988227: Third-party - Associated Parties - Add Associated Individual
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on "Associated Parties" tab on Third-party page
    Then Empty Associated Parties table with text "associatedParties.noPartiesDefaultText" is displayed
    When User creates Associated Party "with only mandatory fields"
    Then Associated Parties details are displayed with populated data

  @C32988228
  Scenario: C32988228: Third-party - Associated Parties - Verify Contact WC Screening Result
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "with matched results"
    Then Screening results table is loaded
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And Screening section Change Search Criteria button is displayed
    And Screening section Bell icon is displayed
    And Screening section Ongoing Screening slider is displayed
    And Screening section table displays expected columns
      | thirdPartyInformation.screening.columnName              |
      | thirdPartyInformation.screening.columnCountryOfLocation |
      | thirdPartyInformation.screening.columnType              |
      | thirdPartyInformation.screening.columnMatchStrength     |
      | thirdPartyInformation.screening.columnDataProvider      |
      | thirdPartyInformation.screening.columnReferenceId       |
      | thirdPartyInformation.screening.columnResolution        |
    And Sorted search "World-Check" results for "contact" appear in main screening table for current page

  @C32988229
  @WSO2email
  Scenario: C32988229: Third-party - Associated Parties - Internal User - Enable Contact as External User
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User creates valid email
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "with valid email"
    When User checks 'Enabled as User' checkbox on contact screen
    Then Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
