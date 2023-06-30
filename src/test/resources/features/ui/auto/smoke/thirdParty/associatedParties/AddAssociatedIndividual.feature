@ui @smoke @suppliers
Feature: Third-party Contact - Add Contact

  As a Supplier Integrity User creating Supplier Contact Records
  I want I want to have a quick and efficient way of creating multiple Supplier Contact records
  So that I can save time from reopening the Add Contact page every time I create a new Supplier Contact

  @C44131918
  Scenario: C44131918: Third-party - Associated Parties - Add Associated Individual and Verify WC Screening Result
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"
    And User clicks on "Associated Parties" tab on Third-party page
    When User clicks on ADD ASSOCIATED PARTY button
    And User clicks Auto-screen button to ON
    And User enters Associated Party first name with value "Test_First_Name"
    And User enters Associated Party last name with value "Test_Last_Name"
    And User clicks on Save Associated Party button
    Then Associated Party page is loaded
    And Screening results table is loaded

  @C44131920
  @WSO2email
  Scenario: C44131920: Third-party Associated Parties - Associated Individual - Internal User - Enable Individual as External User
    Given User logs into RDDC as "Admin"
    And User creates valid email
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "with valid email"
    When User checks 'Enabled as User' checkbox on contact screen
    Then Contact section "Cancel" button is not displayed
    And Contact section "Save" button is not displayed
    And Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received