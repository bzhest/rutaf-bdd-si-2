@ui @full_regression @thirdPartyReports
Feature: Reports - Third Party Reports

  As a user
  I would like to verify Third Party Reports test scripts
  So that I can get the accurate Third Party Reports results.

  @C36188784
  Scenario: C36188784: [RMS-3558] Supplier Report: Display Results
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "THIRD-PARTY REPORT"
    Then Report columns are displayed
      | THIRD-PARTY ID             |
      | REFERENCE ID               |
      | THIRD-PARTY NAME           |
      | RISK TIER                  |
      | RISK SCORE                 |
      | THIRD-PARTY STATUS         |
      | THIRD-PARTY REGION         |
      | THIRD-PARTY COUNTRY        |
      | WORKFLOW GROUP             |
      | THIRD-PARTY ADDRESS LINE   |
      | THIRD-PARTY CITY           |
      | THIRD-PARTY ZIP/POSTAL     |
      | THIRD-PARTY STATE/PROVINCE |
      | THIRD-PARTY DESCRIPTION    |
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "RISK TIER"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks filter page button
    Then Report table column "RISK TIER" contains only values
      | Medium |
    And Report table column "RISK TIER" values "Medium" are in expected color
    And Pagination buttons should be visible
      | first page | previous page | next page | last page |
    And Label for the number of returned results is expected
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "RISK TIER"
    And User checks Column Field "RISK SCORE"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Score"
    And User fills in Filter input value "5"
    And User clicks filter page button
    Then No Match Found report records is displayed
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "RISK TIER" is not displayed
    And Report filter icon for column "RISK SCORE" is not displayed