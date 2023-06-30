@ui @full_regression @core_regression @react @wc1 @other_names
Feature: Contact Other Names - Delete Other Name

  As a user,
  I want to an ability to delete the other name.
  So that I can delete it.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"
    And User creates Associated Party "with mandatory fields"

  @C33362273
  Scenario: C33362273: SI-WC1-Contact-Check that possible to delete Other name
    When User creates Other name "contact other name" for Associated Party
    And User clicks Close Other Name Results button
    Then Delete Other Name button is displayed in the Other Names section after each record
    When User clicks on Delete Other Name Button for "Test Other Name" name
    Then Delete Other Name modal window is opened
    And Delete Other Name modal window contains text
      | Are you sure you want to delete this Other Name? This change cannot be undone. |
    When User clicks "Cancel" on Delete Other Name modal window
    Then Delete Other Name modal window is closed
    When User clicks on Delete Other Name Button for "Test Other Name" name
    And User clicks "Proceed" on Delete Other Name modal window
    Then Alert Icon is displayed with text
      | Success!                                     |
      | Other name Test Other Name has been deleted. |
    And Delete Other Name modal window is closed
    And The Other name is deleted from table
    And The case "otherNameId" is deleted from WC1
