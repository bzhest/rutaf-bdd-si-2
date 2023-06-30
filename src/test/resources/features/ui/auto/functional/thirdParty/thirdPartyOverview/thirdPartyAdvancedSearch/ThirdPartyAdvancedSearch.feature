@ui @functional @thirdPartyAdvancedSearch
Feature: Third-party Advanced Search

  As a RDD Center User
  I want to have a way to use advance search for Third-parties
  So that I can have more accurate list of Third-parties

  Background:
    Given User logs into RDDC as "Admin"

  @C39514991
  Scenario: C39514991: Third-party Advanced Search - Verify Rename the "Screening Status" parameter to "Screening Status (WC & Custom WL)"
    When User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User clicks 'Advance Search' link
    And User adds search criteria parameter - Screening Status (WC & Custom WL), value - Unresolved on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then Line with parameter - Screening Status (WC & Custom WL) and value - Unresolved is present
    And "SCREENING STATUS (WC & CUSTOM WL)" column is displayed in the 'Third-party Advanced Search' result table

  @C45319239 @C45326004
  Scenario: C45319239, C45326004: Third-party Advanced Search - Verify Associated Party is available to select as a parameter but not displayed as a column in 'Search Results' table
    When User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User clicks 'Advance Search' link
    And User adds search parameter - Associated Party on 1st line
    Then Search filter button is DISABLED
    When User adds search value - apple on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then "ASSOCIATED PARTY" column is not displayed in the 'Third-party Advanced Search' result table
    When User clicks 'Clear Search' button
    Then 'Advance Search' results table contains countries
      | NO AVAILABLE DATA |

  @C45326006
  Scenario: C45326006: Third-party Advanced Search - Verify Searching Result showing and sorting are the same as current
    When User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User clicks 'Advance Search' link
    And User adds search criteria parameter - Associated Party, value - Apple on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then Advanced search result table is sorted by "DATE CREATED" in "DESC" order
    When User adds search criteria parameter - Third-party Name, value - test on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then Advanced search result table is sorted by "DATE CREATED" in "DESC" order

  @C45326008
  Scenario: C45326008: Third-party Advanced Search - Verify Can't find Associated Individual and Associated Organisation when there's no data created
    When User creates third-party "with random ID name" via API and open it
    And User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User clicks 'Advance Search' link
    And User fills search value field with previously created Third-party name on line 1
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clicks 'Add' new parameter button
    And User adds search parameter - Associated Party on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 'Advance Search' results table contains countries
      | NO RECORDS FOUND |
    When User adds search value - random on 2nd line
    And User clicks 'Search' button on Advance Search screen without waiter
    Then 'Advance Search' results table contains countries
      | NO RECORDS FOUND |
    When User clicks 'Delete' button for 1st line
    And User clears search value field on line 1
    And User fills search value field with previously created Third-party name on line 1
    And User clicks 'Search' button on Advance Search screen
    Then 'Advance Search' results table contains countries
      | NO RECORDS FOUND |

  @C45326035
  Scenario: C45326035: Third-party Advanced Search - Third-party Match All - Verify A user can type any names in the
  text box and Associated Individual > Search by First Name and Last Name.
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Individual" "Barac Hussein Obama" via API and open it
    And User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User clicks 'Advance Search' link
    And User fills search value field with previously created Third-party name on line 1
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clicks 'Add' new parameter button
    And User adds search parameter - Associated Party on 2nd line
    And User adds search value - DARIDARA on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is not displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - Barac on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - Obama on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - Hussein on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is not displayed in the Advanced Search table
    When User clicks 'Delete' button for 1st line
    And User clears search value field on line 1
    And User adds search value - Barac on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - Obama on 1nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - Hussein on 1nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is not displayed in the Advanced Search table

  @C45326038
  Scenario: C45326038: Third-party Advanced Search - Third-party Match All - Verify A user can type any names in the
  text box and Associated Organisation > Search by Company Name.
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Organisation" "Dell" via API and open it
    And User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User clicks 'Advance Search' link
    And User fills search value field with previously created Third-party name on line 1
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clicks 'Add' new parameter button
    And User adds search parameter - Associated Party on 2nd line
    And User adds search value - RANDOM on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is not displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - Dell on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - De on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clicks 'Delete' button for 1st line
    And User clears search value field on line 1
    And User adds search value - Dell on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - Del on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - De on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table

  @C45327293
  Scenario: C45327293: Third-party Advanced Search - Third-party Match All - Verify all related third party list will appear correctly when input associated party name
    When User creates third-party "with similar name" via API and open it
    And User creates Associated Party "Individual" "Barac Hussein Obama" via API and open it
    And User creates Associated Party "Organisation" "Dell" via API and open it
    And User creates third-party "with similar name" via API and open it
    And User creates Associated Party "Individual" "Barac Hussein Obama" via API and open it
    And User creates Associated Party "Organisation" "ABC" via API and open it
    And User creates third-party "with similar name" via API and open it
    And User creates Associated Party "Individual" "Barac Hussein Obama Key Principal" via API and open it
    And User creates Associated Party "Organisation" "Marshall" via API and open it
    And User creates third-party "with similar name" via API and open it
    And User creates Associated Party "Individual" "Barac George Marshall" via API and open it
    And User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User clicks 'Advance Search' link
    And User fills search value field with previously created Third-party name on line 1
    And User clicks 'Search' button on Advance Search screen
    Then 4 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clicks 'Add' new parameter button
    And User adds search parameter - Associated Party on 2nd line
    And User adds search value - Barac on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 4 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - Obama on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 3 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - Hussein on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 'Advance Search' results table contains countries
      | NO RECORDS FOUND |
    When User clears search value field on line 2
    And User adds search value - Marshall on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 2 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - George on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 'Advance Search' results table contains countries
      | NO RECORDS FOUND |
    When User clicks 'Delete' button for 1st line
    And User clears search value field on line 1
    And User adds search value - Barac on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 4 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - Obama on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 3 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - Hussein on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 'Advance Search' results table contains countries
      | NO RECORDS FOUND |
    When User clears search value field on line 1
    And User adds search value - Marshall on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 2 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - George on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 'Advance Search' results table contains countries
      | NO RECORDS FOUND |
    When User clears search value field on line 1
    And User adds search value - Dell on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 1 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - Dell on 1st line
    And User clicks 'Add' new parameter button
    And User adds search criteria parameter - Third-party Name, value - Similar_Name_Dell on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 'Advance Search' results table contains countries
      | NO RECORDS FOUND |
    When User clicks 'Delete' button for 2nd line
    And User clears search value field on line 1
    And User adds search value - Marshall on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 2 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clicks 'Add' new parameter button
    And User adds search parameter - Third-party Name on 2nd line
    And User fills search value field with previously created Third-party name on line 2
    And User clicks 'Search' button on Advance Search screen
    Then 2 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User searches created third-party
    And User deletes 4 previously created Third-parties with similar name
    And User refreshes page
    Then Third-party Overview tab is loaded

  @C45341736
  Scenario: C45341736: Third-party Advanced Search - Third-party Match Any - Verify A user can type any names in the text
  box and Associated Individual > Search by First Name and Last Name.
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Individual" "Barac Hussein Obama" via API and open it
    And User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User clicks 'Advance Search' link
    And User selects Any value in 'Search for Third-party Match' dropdown
    And User fills search value field with previously created Third-party name on line 1
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clicks 'Add' new parameter button
    And User adds search parameter - Associated Party on 2nd line
    And User adds search value - DARIDARA on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - Barac on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - Obama on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - Hussein on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clicks 'Delete' button for 1st line
    And User clears search value field on line 1
    And User adds search value - Barac on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - Obama on 1nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - Hussein on 1nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is not displayed in the Advanced Search table

  @C45341737
  Scenario: C45341737: Third-party Advanced Search - Third-party Match Any - Verify A user can type any names in the text
  box and Associated Organisation > Search by Company Name.
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Organisation" "Dell" via API and open it
    And User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User clicks 'Advance Search' link
    And User selects Any value in 'Search for Third-party Match' dropdown
    And User fills search value field with previously created Third-party name on line 1
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clicks 'Add' new parameter button
    And User adds search parameter - Associated Party on 2nd line
    And User adds search value - RANDOM on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - Dell on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - De on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clicks 'Delete' button for 1st line
    And User clears search value field on line 1
    And User adds search value - Dell on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - Del on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - De on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then Previously created Third-party is displayed in the Advanced Search table

  @C45341738
  Scenario: C45341738: Third-party Advanced Search - Third-party Match Any - Verify all related third party list will appear correctly when input associated party name
    When User creates third-party "with similar name" via API and open it
    And User creates Associated Party "Individual" "Barac Hussein Obama" via API and open it
    And User creates Associated Party "Organisation" "Dell" via API and open it
    And User creates third-party "with similar name" via API and open it
    And User creates Associated Party "Individual" "Barac Hussein Obama" via API and open it
    And User creates Associated Party "Organisation" "ABC" via API and open it
    And User creates third-party "with similar name" via API and open it
    And User creates Associated Party "Individual" "Barac Hussein Obama Key Principal" via API and open it
    And User creates Associated Party "Organisation" "Marshall" via API and open it
    And User creates third-party "with similar name" via API and open it
    And User creates Associated Party "Individual" "Barac George Marshall" via API and open it
    And User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User clicks 'Advance Search' link
    And User selects Any value in 'Search for Third-party Match' dropdown
    And User fills search value field with previously created Third-party name on line 1
    And User clicks 'Search' button on Advance Search screen
    Then 4 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clicks 'Add' new parameter button
    And User adds search parameter - Associated Party on 2nd line
    And User adds search value - Barac on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 4 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - Obama on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 4 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - Hussein on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 4 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - Marshall on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 4 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 2
    And User adds search value - George on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 4 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clicks 'Delete' button for 1st line
    And User clears search value field on line 1
    And User adds search value - Barac on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 4 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - Obama on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 3 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - Hussein on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 'Advance Search' results table contains countries
      | NO RECORDS FOUND |
    When User clears search value field on line 1
    And User adds search value - Marshall on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 2 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - George on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 'Advance Search' results table contains countries
      | NO RECORDS FOUND |
    When User clears search value field on line 1
    And User adds search value - Dell on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 1 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clears search value field on line 1
    And User adds search value - Dell on 1st line
    And User clicks 'Add' new parameter button
    And User adds search criteria parameter - Third-party Name, value - Similar_Name_Dell on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 1 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clicks 'Delete' button for 2nd line
    And User clears search value field on line 1
    And User adds search value - Marshall on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 2 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clicks 'Add' new parameter button
    And User adds search parameter - Third-party Name on 2nd line
    And User fills search value field with previously created Third-party name on line 2
    And User clicks 'Search' button on Advance Search screen
    Then 4 previously created Third-parties with similar names is displayed in the Advanced Search table
    When User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User searches created third-party
    And User deletes 4 previously created Third-parties with similar name
    And User refreshes page
    Then Third-party Overview tab is loaded