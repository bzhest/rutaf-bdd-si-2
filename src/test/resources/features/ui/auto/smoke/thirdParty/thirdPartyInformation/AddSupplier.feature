@ui @smoke @suppliers
Feature: Third-party Information - Add Third-party

  As a Supplier Integrity User
  I want I want to be able to create new Suppliers
  So that I can process the Suppliers that need to be Onboarded for the Organisation

  @C43652456
  Scenario: C43652456: Third-party Overview - Add Third-party with Complete Details and Verify Country Checklist Alert
    Given User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User clicks Add Third-party button
    When User creates third-party "with Complete Details"
    Then Third-party Information details are displayed with populated data
    And "Informational" 'i' icon button is displayed beside add "Address" section
    When User clicks 'i' icon button
    Then Address Country alert toast message is displayed