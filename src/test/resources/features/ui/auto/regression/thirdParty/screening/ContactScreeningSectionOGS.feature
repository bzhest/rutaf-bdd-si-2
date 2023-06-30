@ui @sanity @wc1 @screening_result @contacts @multilanguage
Feature: Contact Screening Result - Ongoing Screening

  As a SI user
  I want an ability to monitor OGS for contact.
  So that I can be informed of any relevant new data or data updates.

  @C37072699
  Scenario: C37072699: WC - Contact - Screening Result - Turn On Ongoing Screening toggle
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Individual" "with mandatory fields" via API and open it
    Then Screening results table is loaded
    When User clicks OGS slider to ON
    Then Alert Icon is displayed with text
      | <messages.success>                                           |
      | <thirdPartyInformation.screening.ongoingScreeningIsTurnedOn> |
    Then OGS slider is turned ON
