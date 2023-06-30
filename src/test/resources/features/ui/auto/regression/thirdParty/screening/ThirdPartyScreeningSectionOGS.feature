@ui @sanity @wc1 @screening_result @suppliers @multilanguage
Feature: Third-party Screening Result - Ongoing Screening

  As a SI user
  I want an ability to monitor OGS for supplier.
  So that I can be informed of any relevant new data or data updates.

  @C37072700
  Scenario: C37072700: WC - Third-party - Screening Result - Turn on Ongoing Screening toggle
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks OGS slider to ON
    Then Alert Icon is displayed with text
      | <messages.success>                       |
      | <thirdPartyInformation.screening.ongoingScreeningTurnedOnMessage> |
    And OGS slider is turned ON