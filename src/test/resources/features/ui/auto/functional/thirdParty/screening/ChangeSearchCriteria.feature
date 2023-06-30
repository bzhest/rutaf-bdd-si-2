@ui @functional @wc1 @screening_result @suppliers
Feature: Third-party - Screening - Change Search Criteria

  As a SI user,
  I want address type and country to send to WC1.
  So that I can get the accurate screening results.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API

  @C33612278
  Scenario Outline: C33612278: Supplier - Country of Registration from profile isn't matched with the country in Change Search Criteria
    Given User creates third-party "<supplierReferenceWithCountry>"
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria "Country of Registration" contains "<matchedCountry>" value
    And WC1 case contains "<matchedCountry>" provided "REGISTEREDIN" "supplier" secondary field
    Examples:
      | supplierReferenceWithCountry                         | matchedCountry                   |
      | with random ID name and Kosovo country               | Serbia                           |
      | with random ID name and Laos country                 | Lao People's Democratic Republic |
      | with random ID name and Netherlands Antilles country |                                  |
      | with random ID name and Samoa Western country        | Samoa                            |