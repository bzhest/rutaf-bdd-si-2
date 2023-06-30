@ui @full_regression @core_regression @arabica

Feature: Third-party - Change Search Criteria

  As a RDDC user
  I want Change Search Criteria button to be adjusted
  So that I can choose to screen for World-Check, Custom WatchList, Media Check results or all of them

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API

  @C39567060
  Scenario: C39567060: third-Party - Change Search Criteria - Verify Re-Screening data when changing the search term value
    When User creates third-party "Bank of China"
    Then Screening results table is loaded
    When User hovers WC Screening Resolution Type at position no.1
    Then Resolution Type tooltip "positive" is displayed
    When User hovers WC Screening Resolution Type at position no.2
    Then Resolution Type tooltip "possible" is displayed
    When User hovers WC Screening Resolution Type at position no.3
    Then Resolution Type tooltip "false" is displayed
    When User gets Screening Number before Re-Screening
    And User clicks Change Search Criteria screening button
    Then Search criteria value of "Groups" is
      | All |
    And Search criteria value of "Search Term" is
      | Bank of China |
    And Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    And Search criteria value of "Country of Registration" is
      | China |
    When User changes Search Term to "Honda"
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    And The system re-screening with the new search term and screening results should be updated

  @C39567059
  Scenario: C39567059: Third-party - Change Search Criteria - Verify the error text is "This field is required" is displayed
    When User creates third-party "Bank of China"
    Then Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Search Term" is
      | Bank of China |
    When User clears "SearchTerm" on Change Search Criteria
    And User clicks Search On Search criteria button
    Then Error message "This field is required" in red color is displayed on changes Search Criteria field
      | SearchTerm |