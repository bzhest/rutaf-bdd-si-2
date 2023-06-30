@ui @functional @wc1 @screening_result @suppliers
Feature: Third-party - Screening - World Check Tab

  As a SI user,
  I want address type and country to send to WC1.
  So that I can get the accurate screening results.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API

  @C32996669
  Scenario: C32996669: Supplier - Verify that when Supplier is created 'Name' and 'Country' are sent to WC1
    When User creates third-party "with random ID name"
    Then WC1 case contains "China" provided "REGISTEREDIN" "supplier" secondary field
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page

  @C33000126
  Scenario: C33000126: Supplier - Verify that when Supplier 'Country' is edited it is sent to WC1
    Given User creates third-party "with random ID name"
    When User clicks General and Other Information section "Edit" button
    And User updates Address section with values
      | Country        |
      | United Kingdom |
    And User clicks General and Other Information section "Save" button
    Then Screening results table is loaded
    And Address section details are displayed with populated data
    And WC1 case contains "United Kingdom" provided "REGISTEREDIN" "supplier" secondary field
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page

  @C33611701
  Scenario: C33611701: Supplier - Check that country values are from WC1
    Given User creates third-party "with random ID name"
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria "Country of Registration" drop-down field is displayed with list of countries from WC1

  @C33489848
  Scenario: C33489848: Supplier - Change search criteria pop-up - 'Country of Registration' changed
    Given User creates third-party "with random ID name"
    And User changes Search Criteria "Search Term" with value "Bank of China"
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria "Country of Registration" contains "China" value
    And User clicks Cancel search criteria button
    And Screening results table is loaded
    When User changes Search Criteria "Country of Registration" with value "United Kingdom"
    And Screening results table is loaded
    Then WC1 case contains "United Kingdom" provided "REGISTEREDIN" "supplier" secondary field
    And Third-party "Country" address details contains "China"
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page

  @C33495587
  Scenario: C33495587:  Supplier - Change search criteria pop-up - 'Search Term' changed
    Given User creates third-party "PetroChina"
    When User marks "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE"
    And User marks "World-Check" screening record for "supplier" on position 2 on main screening list as "POSSIBLE"
    And User marks "World-Check" screening record for "supplier" on position 3 on main screening list as "FALSE"
    And Screening results table is loaded
    And User clicks Change Search Criteria screening button
    Then Search criteria "Country of Registration" contains "China" value
    And Search criteria "Search Term" contains "PetroChina" value
    And User clicks Cancel search criteria button
    When User changes Search Criteria "Country of Registration" with value "United Kingdom"
    And User changes Search Criteria "Search Term" with value "Bank of China"
    Then Screening results table is loaded
    And WC1 case contains "United Kingdom" provided "REGISTEREDIN" "supplier" secondary field
    And WC1 case contains "Bank of China" "supplier" name
    And Third-party "Country" address details contains "China"
    And Third-party "Name" General Information section's field contains "PetroChina"
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page
    And Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 2 appears in the main screening table with "POSSIBLE" resolution
    Then Screening record under number 3 does not appear in the main screening table

  @C33489746
  Scenario: C33489746: Supplier - Change search criteria pop-up - 'Country of Registration' cleared
    Given User creates third-party "USG"
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria "Country of Registration" contains "Turkey" value
    And Search criteria "Search Term" contains "USG" value
    When User clears Search Criteria "Country of Registration"
    And User clicks on screening confirmation button with name "SEARCH"
    And Screening results table is loaded
    Then WC1 case contains empty "REGISTEREDIN" "supplier" secondary field
    And Third-party "Country" address details contains "Turkey"
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page

  @C33489928
  Scenario: C33489928: Supplier - Change search criteria pop-up - 'Country of Registration' changed in supplier info
    Given User creates third-party "PETROCHINA HONG KONG LTD"
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria "Country of Registration" contains "Hong Kong" value
    And Search criteria "Search Term" contains "PETROCHINA HONG KONG LTD" value
    And User clicks Cancel search criteria button
    And Screening results table is loaded
    When User clicks General and Other Information section "Edit" button
    And User updates Address section with values
      | Country        |
      | United Kingdom |
    And User clicks General and Other Information section "Save" button
    Then Screening results table is loaded
    And Address section details are displayed with populated data
    And WC1 case contains "United Kingdom" provided "REGISTEREDIN" "supplier" secondary field
    When User clicks Change Search Criteria screening button
    Then Search criteria "Country of Registration" contains "United Kingdom" value
    And Search criteria "Search Term" contains "PETROCHINA HONG KONG LTD" value
    And User clicks Cancel search criteria button
    And Screening results table is loaded
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page

  @C33519209
  Scenario: C33519209: Supplier - Rerun WC1 screening when supplier name is changed
    Given User creates third-party "Bank"
    And Screening results table is loaded
    When User marks "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE"
    And User marks "World-Check" screening record for "supplier" on position 2 on main screening list as "POSSIBLE"
    And User marks "World-Check" screening record for "supplier" on position 3 on main screening list as "FALSE"
    And User clicks General and Other Information section "Edit" button
    And User updates General Information section with values
      | Name               |
      | BANK AUDI SYRIA SA |
    And User clicks General and Other Information section "Save" button
    Then Sorted search "World-Check" results for "supplier" appear in main screening table for current page
    And Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 2 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 3 does not appear in the main screening table
    And WC1 case contains "BANK AUDI SYRIA SA" "supplier" name
    And Third-party "Name" General Information section's field contains "BANK AUDI SYRIA SA"

  @C33519273
  Scenario: C33519273: Supplier - Not Rerun WC1 screening when supplier name is not changed but section saved
    Given User creates third-party "Bank of China"
    And Screening results table is loaded
    When User clicks General and Other Information section "Edit" button
    And User updates General Information section with values
      | Reference No. |
      | 123456789     |
    And User clicks General and Other Information section "Save" button
    Then WC1 case contains "Bank of China" "supplier" name
    And Third-party "Name" General Information section's field contains "Bank of China"
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page
