@ui @functional @wc1 @other_names
Feature: Third-party - Information - Other Name - Delete

  As a user,
  I want to an ability to delete the other name.
  So that I can delete it.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"

  @C33592811
  Scenario: C33592811: Supplier - Check that possible to delete Other name
    When User creates Other name "with mandatory fields"
    Then Delete Other Name button is displayed in the Other Names section after each record
    When User clicks on Delete Other Name Button for "Test Other Name" name
    And User clicks "Proceed" on Delete Other Name modal window
    Then The Other name is deleted from table
    And The case "otherNameId" is deleted from WC1
