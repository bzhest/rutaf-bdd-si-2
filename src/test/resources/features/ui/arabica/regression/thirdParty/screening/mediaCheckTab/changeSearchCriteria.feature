@ui @core_regression @arabica

Feature: Third-party - Change Search Criteria

  As a RDDC user
  I want Change Search Criteria button to be adjusted
  So that I can choose to screen for World-Check, Custom WatchList, Media Check results or all of them

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API

  @C38354115
  Scenario: C38354115: third-Party - Change Search Criteria - Verify Search Term field when user don't fill out the value
    When User creates third-party "Bank of China"
    Then Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
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
    When User clears "SearchTerm" on Change Search Criteria
    And User clicks Search On Search criteria button
    Then Toast message "Cannot search. Please complete the required field." is displayed
    And Error message "This field is required" in red color is displayed on changes Search Criteria field
      | SearchTerm |
    When User clicks Cancel search criteria button
    And User clicks Change Search Criteria screening button
    Then Search criteria value of "Search Term" is
      | Bank of China |

  @C39567233
  Scenario: C39567233: Third-party - Change Search Criteria - Verify search term is changed If name is changed
    When User creates third-party "Bank of China"
    Then Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Search Term" is
      | Bank of China |
    And User clicks Cancel search criteria button
    When User clicks General and Other Information section "Edit" button
    And User updates General Information section with values
      | Name  |
      | Apple |
    And User clicks General and Other Information section "Save" button
    Then Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Search Term" is
      | Apple |
    And User edits Search Term with value "AUTO_TEST_THIRD_PARTY_EDIT"
    And Third-party "Name" General Information section's field contains "Apple"