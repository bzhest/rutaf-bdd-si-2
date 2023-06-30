@ui @functional @wc1 @screening_result @suppliers
Feature: Third-party - Screening - World Check Tab - Turn On OGS

  As a SI user
  I want an ability to monitor OGS for supplier.
  So that I can be informed of any relevant new data or data updates.

  @C32906959
  Scenario: C32906959: WC - Supplier - Screening Result - Turn on Global Screening
    Given User logs into RDDC as "Admin"
    When  User sets up default Screening Management parameters via API
    And User creates third-party "Bank of China"
    And User clicks OGS slider to ON
    Then Alert Icon is displayed with text
      | Success!                        |
      | Ongoing screening is turned on. |