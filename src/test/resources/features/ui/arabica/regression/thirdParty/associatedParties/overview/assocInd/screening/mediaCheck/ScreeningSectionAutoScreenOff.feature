@ui @core_regression @arabica

Feature: Associated Individual Auto Screen Screening Result - Ongoing Screening

  As a RDDC user
  I want an ability to monitor OGS for Associated Individual.
  So that I can be informed of any relevant new data or data updates.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"
    And User clicks on "Associated Parties" tab on Third-party page

  @C39520434
  Scenario: C39520434: Associated Individual - Screening - Verify OGS button is disable By default
    When User clicks on ADD ASSOCIATED PARTY button
    And User enters Associated Party first name with value "Test_First_Name"
    And User enters Associated Party last name with value "Test_Last_Name"
    And User clicks Save Associated Organisation button
    Then Associated Party page is loaded
    And OGS Toggle is disable
    When User clicks Enable screening button
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    And OGS alert message "Success! Screening is turned on." is displayed
    And OGS slider is turned OFF
    When User clicks OGS slider to ON
    Then OGS slider is turned ON
    And OGS alert message "Success! Ongoing screening is turned on." is displayed