@ui @core_regression @suppliers
Feature: Third-party Advance Search

  As a RDD Center User
  I want to have a way to use advance search for Third-parties
  So that I can have more accurate list of Third-parties

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with Complete Details and country Ukraine"
    And User navigates to Home page
    When User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User clicks 'Advance Search' link

  @C35653853
  Scenario: C35653853: Advanced Search - check if user can use Advanced Search functionality with multiple parameters
    Then Line with parameter - Third-party Name and value - EMPTY is present
    And 'Search for Third-party Match' dropdown is present with selected value All
    And 'Search for Third-party Match' dropdown has only values to select
      | All | Any |
    And 'Advance Search' results table contains countries
      | NO AVAILABLE DATA |
    And Add filter button is DISABLED
    When User adds search criteria parameter - Region, value - Europe on 1st line
    Then Add filter button is ENABLED
    When User clicks 'Add' new parameter button
    Then Line with parameter - Region and value - Europe is present
    And Line with parameter - EMPTY and value - EMPTY is present
    And 'Delete' button is visible for 1st filter line
    And 'Delete' button is visible for 2nd filter line
    When User clicks 'Delete' button for 2nd line
    Then Line with parameter - Region and value - Europe is present
    And Line with parameter - EMPTY and value - EMPTY is not present
    And 'Delete' button is not visible for 1st filter line
    When User selects Any value in 'Search for Third-party Match' dropdown
    And User clicks 'Add' new parameter button
    And User adds search criteria parameter - Country, value - Ukraine on 2nd line
    And User clicks 'Search' button on Advance Search screen
    Then 'Advance Search' results table contains countries
      | Ukraine |
    And 'Clear Search' button is appeared
    And Line with parameter - Region and value - Europe is present
    And Line with parameter - Country and value - Ukraine is present
    When User selects All value in 'Search for Third-party Match' dropdown
    And User clicks 'Search' button on Advance Search screen
    Then 'Advance Search' results table contains countries
      | Ukraine |
    And 'Clear Search' button is appeared
    When User clicks 'Clear Search' button
    Then 'Advance Search' results table contains countries
      | NO AVAILABLE DATA |
    And Add filter button is DISABLED
    And Search filter button is DISABLED
    And Line with parameter - EMPTY and value - EMPTY is present
    And Line with parameter - Region and value - Europe is not present
    And Line with parameter - Country and value - Ukraine is not present
    When User adds search criteria parameter - Country, value - Ukraine on 1st line
    And User clicks 'Add' new parameter button
    And User adds search criteria parameter - Region, value - Europe on 2nd line
    And User clicks 'Add' new parameter button
    And User adds search criteria parameter - Region, value - Africa on 3rd line
    And User clicks 'Add' new parameter button
    And User adds search criteria parameter - Region, value - Europe on 4th line
    And User clicks 'Add' new parameter button
    And User adds search criteria parameter - Country, value - Ukraine on 5th line
    Then Add filter button is DISABLED

  @C35655661
  Scenario: C35655661: Advanced Search - verify that user can open Third-party Information page from advanced search result
    When User adds search criteria parameter - Region, value - Europe on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 'Advance Search' results table contains countries
      | Ukraine |
    When User clicks on first found third-party in advance search results
    Then User waits for progress bar to disappear from page
    And Current URL contains "/thirdparty/" endpoint
    And Third-party's element "Advanced search" should be shown
    When User waits and clicks "Advanced search" third-party button
    And User waits for 'Advance Search' page to load
    Then Current URL contains "/thirdparty/advanced-search" endpoint
    And 'Advance Search' results table contains countries
      | toBeReplaced |

  @C35656596
  Scenario: C35656596: Advanced Search - verify that user can export search result of advanced search to Excel file
    When Export to Excel button is hidden
    And User adds search criteria parameter - Third-party name, value - qwertyuiop on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then 'Advance Search' results table contains countries
      | NO RECORDS FOUND |
    And Export to Excel button is hidden
    When User adds search criteria parameter - Region, value - Europe on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then Export to Excel button is present
    When User saves Advanced Search Results to context
    And User clicks Export to Excel button
    And User navigates to My Exports page
    Then My Exports table contains file with name "RDDCentre_AdvancedSearch_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"
    When User clicks file with name "RDDCentre_AdvancedSearch_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"
    Then ".csv" File with name "RDDCentre_AdvancedSearch_Report_%s" and date format "MM_dd_YYYY_HH_mm" downloaded
    And CSV file contains expected values