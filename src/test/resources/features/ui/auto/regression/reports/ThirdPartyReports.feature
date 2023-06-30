@ui @full_regression @thirdPartyReports
Feature: Reports - Third Party Reports

  As a user
  I would like to verify Third Party Reports test scripts
  So that I can get the accurate Third Party Reports results.

  @C36188782
  Scenario: C36188782: [RMS-5195] Supplier Report - Verify Partner Volume Drilldown (All Suppliers Filter)
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "THIRD-PARTY REPORT"
    Then Activity Report Third-party drop down displays "All Third-party" value
    And Report panel "Columns" tool panel is not displayed
    And Report panel "Filters" tool panel is not displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY ID"
    And User checks Column Field "RISK TIER"
    And User checks Column Field "THIRD-PARTY STATUS"
    And User checks Column Field "RESPONSIBLE PARTY"
    Then Report column "RESPONSIBLE PARTY" is displayed
    And Report column "THIRD-PARTY ID" is displayed
    And Report column "RISK TIER" is displayed
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report table column "RISK TIER" contains only values
      | Medium |
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "RISK TIER" is not displayed
    And Report column "THIRD-PARTY ID" is displayed
    And Report column "RESPONSIBLE PARTY" is displayed
    And Report column "RISK TIER" is displayed
    And Report column "THIRD-PARTY STATUS" is displayed
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Title "Third-party Status"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "ONBOARDING"
    And User clicks Report panel "Filters"
    Then Report table column "RISK TIER" contains only values
      | Medium |
    And Report table column "THIRD-PARTY STATUS" contains only values
      | ONBOARDING |
    And Report Reset all Filter Button is available
    When User clicks first Report row
    Then Third-party Information tab is loaded
    When User waits and clicks "Back Button" third-party button
    Then "THIRD-PARTY REPORT" report page is displayed
    And Report table column "RISK TIER" contains only values
      | Medium |
    And Report table column "THIRD-PARTY STATUS" contains only values
      | ONBOARDING |
    And Report filter icon for column "RISK TIER" is displayed
    And Report filter icon for column "THIRD-PARTY STATUS" is displayed
    And Report column "RESPONSIBLE PARTY" is displayed
    And Report column "RISK TIER" is displayed
    And Report column "THIRD-PARTY STATUS" is displayed

  @C36188781
  Scenario: C36188781: [RMS-5195] Supplier Report - Verify Partner Volume Drilldown (My Suppliers Filter)
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "THIRD-PARTY REPORT"
    And User selects My Third-party show option
    Then Report panel "Columns" tool panel is not displayed
    And Report panel "Filters" tool panel is not displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY ID"
    And User checks Column Field "RISK TIER"
    And User checks Column Field "THIRD-PARTY STATUS"
    And User checks Column Field "RESPONSIBLE PARTY"
    And User clicks Pagination Select "50"
    Then Report column "RESPONSIBLE PARTY" is displayed
    And Report table column "RESPONSIBLE PARTY" contains only values
      | Admin_AT_FN Admin_AT_LN |
    And Report column "RISK TIER" is displayed
    And Report column "THIRD-PARTY ID" is displayed
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report table column "RISK TIER" contains only values
      | Medium |
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "RISK TIER" is not displayed
    And Report column "THIRD-PARTY ID" is displayed
    And Report column "RESPONSIBLE PARTY" is displayed
    And Report column "RISK TIER" is displayed
    And Report column "THIRD-PARTY STATUS" is displayed
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Title "Third-Party Name"
    And User fills in Filter input value "Supplier"
    And User clicks Report panel "Filters"
    And User clicks Report panel "Filters"
    Then Report Reset all Filter Button is available
    When User clicks last page icon
    And User clicks first Report row
    Then Third-party Information tab is loaded
    When User waits and clicks "Back Button" third-party button
    Then "THIRD-PARTY REPORT" report page is displayed
    And Report table column "RISK TIER" contains only values
      | Medium |
    And Report filter icon for column "RISK TIER" is displayed
    And Report column "RESPONSIBLE PARTY" is displayed
    And Report column "RISK TIER" is displayed
    And Report column "THIRD-PARTY STATUS" is displayed

  @C36188785
  Scenario: C36188785: [RMS-3561] - Verify Supplier Report: Clear Search
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "THIRD-PARTY REPORT"
    Then Report panel "Columns" tool panel is not displayed
    And Report panel "Filters" tool panel is not displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY STATUS"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Third-party Status"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "NEW"
    And User clicks Report panel "Filters"
    Then Report table column "THIRD-PARTY STATUS" contains only values
      | NEW |
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "THIRD-PARTY STATUS" is not displayed

  @C36188811
  Scenario: C36188811: [RMS-3560] - Verify Supplier Report: Export to CSV
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "THIRD-PARTY REPORT"
    And User selects My Third-party show option
    Then All Reports columns are capitalized
    And Report Risk score column displayed one decimal digit
    And Export Report Button is enabled
    When User clicks export csv file
    Then Alert Icon is displayed with text
      | Success! The exporting process has started. |
    When User clicks My Exports option
    Then My Exports table contains file with name "RDDCentre_ThirdParty_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"
    When User clicks file with name "RDDCentre_ThirdParty_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"
    Then ".csv" File with name "RDDCentre_ThirdParty_Report_" and date format "MM_dd_YYYY_HH_mm" downloaded
    And Report "csv" file contains expected columns
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
      | THIRD-PARTY REGION         |
      | THIRD-PARTY DESCRIPTION    |
    And Report "csv" file contains full country name in Third-party Country field
    And Report "csv" file contains decimal format in Risk Score field
