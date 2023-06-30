@ui @dueDiligenceReports
Feature: Reports - Due Diligence Order Reports

  As a user
  I would like to verify Due Diligence Reports test scripts
  So that I can get the accurate Due Diligence Reports results.

  @C36487646
  @full_regression
  Scenario: C36487646: Reports - Due Diligence Order Reports - Verify Show Option
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    Then "DUE DILIGENCE ORDER REPORT" report page is displayed
    And Activity Report Third-party drop down displays "All Third-party" value
    And Activity Report Third-party drop down has options
      | All Third-party |
      | My Third-party  |
    When User selects My Third-party show option
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "RESPONSIBLE PARTY"
    And User clicks Pagination Select "50"
    Then Report table column "RESPONSIBLE PARTY" contains only values
      | Admin_AT_FN Admin_AT_LN |
    And Report Icon info contains expected data

  @C36487663
  @full_regression
  Scenario: C36487663: Reports - Due Diligence Order Reports - Reset Filters
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User clicks Pagination Select "50"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks filter page button
    And User clicks Filter Field Title "Risk Tier"
    Then Report Filter Field "Medium" is selected
    And Report Filter Field "(Select All)" is not selected
    And Report Filter Field "High" is not selected
    And Report Filter Field "Low" is not selected
    When User clicks Reset All filter report button
    And User clicks Filter Field Title "Risk Tier"
    Then All Report Filter Fields are selected
    And Report Filter Field "(Select All)" is selected

  @C36487664
  @full_regression
  Scenario: C36487664: Reports - Due Diligence Order Report - No Match Found - Verify that Reset Filters is still displayed
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Report panel "Filters"
    Then No Match Found report records is displayed
    And Report Reset all Filter Button is available

  @C36858514
  @full_regression
  Scenario: C36858514: Reports - Due Diligence Order Report - No Available Data - Verify that Reset Filters is hidden
    Given User logs into RDDC as "Empty Metrics User"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User selects My Third-party show option
    Then Report Reset all Filter Button is hidden

  @C36487665
  @full_regression
  @onlySingleThread
  Scenario: C36487665: Reports - Due Diligence Order Reports - All Third-party - Export
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User clicks Report panel "Columns"
    And User checks Column Field "Risk Tier"
    And User checks Column Field "Risk Score"
    And User checks Column Field "Third-Party Region"
    And User checks Column Field "Third-Party Country"
    And User unchecks Column Field "Requestor Name"
    And User unchecks Column Field "Requestor Email"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks filter option button "Filter"
    And User clicks export xls file
    Then ".xlsx" File with name "RDDCentre_DueDiligenceOrder-Report_" and date format "MMddYYYY" downloaded
    And Report "xlsx" file contains expected columns
      | RISK TIER           |
      | RISK SCORE          |
      | THIRD-PARTY COUNTRY |
      | THIRD-PARTY REGION  |
    And Report "xlsx" file does not contain expected columns
      | REQUESTOR NAME  |
      | REQUESTOR EMAIL |
    And Report "xmlx" file contains full country name in Third-party Country field
    And Report "xmlx" file contains decimal format in Risk Score field
    When User clicks export csv file
    And User clicks My Exports option
    Then My Exports table contains file with name "RDDCentre_DueDiligenceOrder_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"
    When User clicks file with name "RDDCentre_DueDiligenceOrder_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"
    Then ".csv" File with name "RDDCentre_DueDiligenceOrder_Report_" and date format "MM_dd_YYYY_HH_mm" downloaded
    And Report "csv" file contains expected columns
      | RISK TIER           |
      | RISK SCORE          |
      | THIRD-PARTY COUNTRY |
      | THIRD-PARTY REGION  |
    And Report "csv" file does not contain expected columns
      | REQUESTOR NAME  |
      | REQUESTOR EMAIL |
    And Report "csv" file contains full country name in Third-party Country field
    And Report "csv" file contains decimal format in Risk Score field

  @C36848412
  @full_regression
  @onlySingleThread
  Scenario: C36848412: Reports - Due Diligence Order Reports - My Third-party - Export
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User selects My Third-party show option
    And User clicks Report panel "Columns"
    And User checks Column Field "Risk Tier"
    And User checks Column Field "Risk Score"
    And User checks Column Field "Third-Party Country"
    And User checks Column Field "Third-Party Region"
    And User unchecks Column Field "Requestor Name"
    And User unchecks Column Field "Requestor Email"
    And User clicks Report panel "Columns"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks filter option button "Filter"
    And User clicks export xls file
    Then ".xlsx" File with name "RDDCentre_DueDiligenceOrder-Report_" and date format "MMddYYYY" downloaded
    And Report "xlsx" file contains expected columns
      | RISK TIER           |
      | RISK SCORE          |
      | THIRD-PARTY COUNTRY |
      | THIRD-PARTY REGION  |
    And Report "xlsx" file does not contain expected columns
      | REQUESTOR NAME  |
      | REQUESTOR EMAIL |
    And Report "xlsx" file contains full country name in Third-party Country field
    And Report "xlsx" file contains decimal format in Risk Score field
    When User clicks export csv file
    And User clicks My Exports option
    Then My Exports table contains file with name "RDDCentre_DueDiligenceOrder_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"
    When User clicks file with name "RDDCentre_DueDiligenceOrder_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"
    Then ".csv" File with name "RDDCentre_DueDiligenceOrder_Report_" and date format "MM_dd_YYYY_HH_mm" downloaded
    And Report "csv" file contains expected columns
      | RISK TIER           |
      | RISK SCORE          |
      | THIRD-PARTY COUNTRY |
      | THIRD-PARTY REGION  |
    And Report "csv" file does not contain expected columns
      | REQUESTOR NAME  |
      | REQUESTOR EMAIL |
    And Report "csv" file contains full country name in Third-party Country field
    And Report "csv" file contains decimal format in Risk Score field

  @C36487666
  @full_regression
  Scenario: C36487666: Reports - Due Diligence Order Reports - No Results - Verify that Export button is disabled
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Report panel "Filters"
    Then Export Report Button is disabled

  @C36487672
  @full_regression
  Scenario: C36487672: Reports - Due Diligence Order Reports - No Available Data
    Given User logs into RDDC as "Empty Metrics User"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User selects My Third-party show option
    Then Report 'No Available Data' is displayed

  @C36487671
  @full_regression
  Scenario: C36487671: Reports - Due Diligence Order Reports - No Match Found
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Report panel "Filters"
    Then No Match Found report records is displayed

  @C36487668
  @full_regression
  Scenario: C36487668: Reports - Due Diligence Order Reports - Add/Remove Columns
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "RISK TIER"
    Then Report column "RISK TIER" is displayed
    When User unchecks Column Field "RISK TIER"
    Then Report column "RISK TIER" is not displayed
    When User checks Column Field "RISK SCORE"
    Then Report column "RISK SCORE" is displayed
    When User unchecks Column Field "RISK SCORE"
    Then Report column "RISK SCORE" is not displayed
    When User checks Column Field "THIRD-PARTY STATUS"
    Then Report column "THIRD-PARTY STATUS" is displayed
    When User unchecks Column Field "THIRD-PARTY STATUS"
    Then Report column "THIRD-PARTY STATUS" is not displayed
    When User checks Column Field "COMPANY TYPE"
    Then Report column "COMPANY TYPE" is displayed
    When User unchecks Column Field "COMPANY TYPE"
    Then Report column "COMPANY TYPE" is not displayed
    When User checks Column Field "ORGANISATION SIZE"
    Then Report column "ORGANISATION SIZE" is displayed
    When User unchecks Column Field "ORGANISATION SIZE"
    Then Report column "ORGANISATION SIZE" is not displayed
    When User checks Column Field "DATE OF INCORPORATION"
    Then Report column "DATE OF INCORPORATION" is displayed
    When User unchecks Column Field "DATE OF INCORPORATION"
    Then Report column "DATE OF INCORPORATION" is not displayed
    When User checks Column Field "CURRENCY"
    Then Report column "CURRENCY" is displayed
    When User unchecks Column Field "CURRENCY"
    Then Report column "CURRENCY" is not displayed
    When User checks Column Field "INDUSTRY TYPE"
    Then Report column "INDUSTRY TYPE" is displayed
    When User unchecks Column Field "INDUSTRY TYPE"
    Then Report column "INDUSTRY TYPE" is not displayed
    When User checks Column Field "BUSINESS CATEGORY"
    Then Report column "BUSINESS CATEGORY" is displayed
    When User unchecks Column Field "BUSINESS CATEGORY"
    Then Report column "BUSINESS CATEGORY" is not displayed
    When User checks Column Field "REVENUE"
    Then Report column "REVENUE" is displayed
    When User unchecks Column Field "REVENUE"
    Then Report column "REVENUE" is not displayed
    When User checks Column Field "LIQUIDATION DATE"
    Then Report column "LIQUIDATION DATE" is displayed
    When User unchecks Column Field "LIQUIDATION DATE"
    Then Report column "LIQUIDATION DATE" is not displayed
    When User checks Column Field "AFFILIATION"
    Then Report column "AFFILIATION" is displayed
    When User unchecks Column Field "AFFILIATION"
    Then Report column "AFFILIATION" is not displayed
    When User checks Column Field "SPEND CATEGORY"
    Then Report column "SPEND CATEGORY" is displayed
    When User unchecks Column Field "SPEND CATEGORY"
    Then Report column "SPEND CATEGORY" is not displayed
    When User checks Column Field "DESIGN AGREEMENT"
    Then Report column "DESIGN AGREEMENT" is displayed
    When User unchecks Column Field "DESIGN AGREEMENT"
    Then Report column "DESIGN AGREEMENT" is not displayed
    When User checks Column Field "RELATIONSHIP VISIBILITY"
    Then Report column "RELATIONSHIP VISIBILITY" is displayed
    When User unchecks Column Field "RELATIONSHIP VISIBILITY"
    Then Report column "RELATIONSHIP VISIBILITY" is not displayed
    When User checks Column Field "COMMODITY TYPE"
    Then Report column "COMMODITY TYPE" is displayed
    When User unchecks Column Field "COMMODITY TYPE"
    Then Report column "COMMODITY TYPE" is not displayed
    When User checks Column Field "SOURCING METHOD"
    Then Report column "SOURCING METHOD" is displayed
    When User unchecks Column Field "SOURCING METHOD"
    Then Report column "SOURCING METHOD" is not displayed
    When User checks Column Field "SOURCING TYPE"
    Then Report column "SOURCING TYPE" is displayed
    When User unchecks Column Field "SOURCING TYPE"
    Then Report column "SOURCING TYPE" is not displayed
    When User checks Column Field "PRODUCT IMPACT"
    Then Report column "PRODUCT IMPACT" is displayed
    When User unchecks Column Field "PRODUCT IMPACT"
    Then Report column "PRODUCT IMPACT" is not displayed
    When User checks Column Field "THIRD-PARTY REGION"
    Then Report column "THIRD-PARTY REGION" is displayed
    When User unchecks Column Field "THIRD-PARTY REGION"
    Then Report column "THIRD-PARTY REGION" is not displayed
    When User checks Column Field "THIRD-PARTY COUNTRY"
    Then Report column "THIRD-PARTY COUNTRY" is displayed
    When User unchecks Column Field "THIRD-PARTY COUNTRY"
    Then Report column "THIRD-PARTY COUNTRY" is not displayed
    When User checks Column Field "RESPONSIBLE PARTY"
    Then Report column "RESPONSIBLE PARTY" is displayed
    When User unchecks Column Field "RESPONSIBLE PARTY"
    Then Report column "RESPONSIBLE PARTY" is not displayed
    When User checks Column Field "RESPONSIBLE PARTY EMAIL"
    Then Report column "RESPONSIBLE PARTY EMAIL" is displayed
    When User unchecks Column Field "RESPONSIBLE PARTY EMAIL"
    Then Report column "RESPONSIBLE PARTY EMAIL" is not displayed
    When User checks Column Field "DIVISION"
    Then Report column "DIVISION" is displayed
    When User unchecks Column Field "DIVISION"
    Then Report column "DIVISION" is not displayed
    When User checks Column Field "ORDER SOURCE"
    Then Report column "ORDER SOURCE" is displayed
    When User unchecks Column Field "ORDER SOURCE"
    Then Report column "ORDER SOURCE" is not displayed
    When User checks Column Field "DATE CREATED"
    Then Report column "DATE CREATED" is displayed
    When User unchecks Column Field "DATE CREATED"
    Then Report column "DATE CREATED" is not displayed
    When User checks Column Field "DATE CANCELLED"
    Then Report column "DATE CANCELLED" is displayed
    When User unchecks Column Field "DATE CANCELLED"
    Then Report column "DATE CANCELLED" is not displayed
    When User checks Column Field "ON HOLD DATE"
    Then Report column "ON HOLD DATE" is displayed
    When User unchecks Column Field "ON HOLD DATE"
    Then Report column "ON HOLD DATE" is not displayed

  @C36487673
  @full_regression
  Scenario: C36487673: Reports - Due Diligence Order Reports - Verify that user can filter every column in the Report
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User clicks Report panel "Filters"
    Then Report filter options contains buttons
      | Filter |
      | Clear  |
    When User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks Report panel "Filters"
    And User clicks Pagination Select "50"
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "RISK TIER"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Title "Third-Party Status"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Low"
    And User clicks Report panel "Filters"
    Then Report table column "RISK TIER" contains only values
      | Low |

  @C36487674
  @full_regression
  Scenario: C36487674: Reports - Due Diligence Order Reports - Verify Filter panel
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    Then Report Filters panel contains label text "Apply Filters"
    When User clicks Report panel "Filters"
    Then Report Filters panel contains label text "Filters"

  @C36753752
  @full_regression
  Scenario: C36753752: Reports - Due Diligence Report - Validate Columns/Filters panel should be closed upon initial loading
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User clicks Report panel "Columns"
    Then Report panel "Columns" tool panel is displayed
    When User clicks Report panel "Columns"
    Then Report panel "Columns" tool panel is not displayed
    When User clicks Report panel "Filters"
    Then Report panel "Filters" tool panel is displayed
    When User clicks Report panel "Filters"
    Then Report panel "Filters" tool panel is not displayed

  @C36811047
  @full_regression
  @onlySingleThread
  Scenario: C36811047: Reports - Due Diligence Report - Validate contents of csv file is same as report table
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "DATE CREATED"
    And User checks Column Field "DATE COMPLETED"
    And User checks Column Field "COMPLETION TIME"
    And User clicks Pagination Select "50"
    And User clicks export csv file
    Then ".csv" File with name "RDDCentre_DueDiligenceOrder-Report_" and date format "MMddYYYY" downloaded
    And Report csv file content is the same as report table

  @C36487669
  @full_regression
  Scenario: C36487669: Reports - Due Diligence Order Reports - Verify label for the number of returned results
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    Then Label for the number of returned results is expected

  @C36487657
  @full_regression
  Scenario: C36487657: Activity Metrics - All Third-party - Click Due Diligence Reports cells - Verify that user should be redirected to the Due Diligence Order Report page
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    And User clicks Due Diligence Activity section "Total Active" column value
    Then "DUE DILIGENCE ORDER REPORT" report page is displayed
    And Activity Report Third-party drop down displays "All Third-party" value
    When User clicks Pagination Select "50"
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "Status"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | NEW         |
      | PENDING     |
      | IN_PROGRESS |
      | ON_HOLD     |
    And Export Report Button is enabled
    And Report Reset all Filter Button is available
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks filter page button
    And User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "STATUS" is not displayed
    When User navigates to Home page
    And User selects Activity Metrics Tab
    And User clicks Due Diligence Activity section "Past Due" column value
    Then "DUE DILIGENCE ORDER REPORT" report page is displayed
    And Activity Report Third-party drop down displays "All Third-party" value
    When User clicks Pagination Select "50"
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "Status"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | NEW         |
      | PENDING     |
      | IN_PROGRESS |
      | ON_HOLD     |
    And Report table column "DUE DATE" date contains only values in range from "" to "TODAY-1"
    And Export Report Button is enabled
    And Report Reset all Filter Button is available
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks filter page button
    And User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "STATUS" is not displayed
    When User navigates to Home page
    And User selects Activity Metrics Tab
    And User clicks Due Diligence Activity section "Due within 7 Days" column value
    Then "DUE DILIGENCE ORDER REPORT" report page is displayed
    And Activity Report Third-party drop down displays "All Third-party" value
    And Report table column "DUE DATE" date contains only values in range from "TODAY+0" to "TODAY+6"
    And Export Report Button is enabled
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "STATUS" is not displayed
    When User navigates to Home page
    And User selects Activity Metrics Tab
    And User clicks Due Diligence Activity section "Due in 8-14 Days" column value
    Then "DUE DILIGENCE ORDER REPORT" report page is displayed
    And Activity Report Third-party drop down displays "All Third-party" value
    And Report table column "DUE DATE" date contains only values in range from "TODAY+7" to "TODAY+13"
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "STATUS" is not displayed

  @C36487658
  @full_regression
  Scenario: C36487658: Activity Metrics - My Third-party - Click Due Diligence Reports cells - Verify that user should be redirected to the Due Diligence Order Report page
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    And User selects My Third-party show option
    And User clicks Due Diligence Activity section "Total Active" column value
    Then "DUE DILIGENCE ORDER REPORT" report page is displayed
    And Activity Report Third-party drop down displays "My Third-party" value
    When User clicks Pagination Select "50"
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "Status"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | NEW         |
      | PENDING     |
      | IN_PROGRESS |
      | ON_HOLD     |
    And Export Report Button is enabled
    And Report Reset all Filter Button is available
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks filter page button
    And User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "STATUS" is not displayed
    When User navigates to Home page
    And User selects Activity Metrics Tab
    And User selects My Third-party show option
    And User clicks Due Diligence Activity section "Past Due" column value
    Then "DUE DILIGENCE ORDER REPORT" report page is displayed
    And Activity Report Third-party drop down displays "My Third-party" value
    When User clicks Pagination Select "50"
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "Status"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | NEW         |
      | PENDING     |
      | IN_PROGRESS |
      | ON_HOLD     |
    And Report table column "DUE DATE" date contains only values in range from "" to "TODAY-1"
    And Export Report Button is enabled
    And Report Reset all Filter Button is available
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks filter page button
    And User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "STATUS" is not displayed
    When User navigates to Home page
    And User selects Activity Metrics Tab
    And User selects My Third-party show option
    And User clicks Due Diligence Activity section "Due within 7 Days" column value
    Then "DUE DILIGENCE ORDER REPORT" report page is displayed
    And Activity Report Third-party drop down displays "My Third-party" value
    And Report table column "DUE DATE" date contains only values in range from "TODAY+0" to "TODAY+6"
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "STATUS" is not displayed
    When User navigates to Home page
    And User selects Activity Metrics Tab
    And User selects My Third-party show option
    And User clicks Due Diligence Activity section "Due in 8-14 Days" column value
    Then "DUE DILIGENCE ORDER REPORT" report page is displayed
    And Activity Report Third-party drop down displays "My Third-party" value
    And Report table column "DUE DATE" date contains only values in range from "TODAY+7" to "TODAY+13"
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "STATUS" is not displayed

  @C36487660
  @full_regression
  Scenario: C36487660: Reports - Due Diligence Order Reports - View Order
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Due Diligence Order Report"
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "Third-party Id"
    And User checks Column Field "Risk Tier"
    And User checks Column Field "Order Id"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks Report panel "Filters"
    And User adds Reports first row "ORDER ID" value to "orderId" context
    And User adds Reports first row "THIRD-PARTY ID" value to "thirdPartyId" context
    And User clicks first Report row
    Then Due Diligence Order form is opened
    And Due Diligence Order form contains expected URL
    When User clicks Back button on Due Diligence Order page
    Then "DUE DILIGENCE ORDER REPORT" report page is displayed
    And Report filter icon for column "RISK TIER" is displayed

  @C36487661
  @full_regression
  Scenario: C36487661: Activity Metrics - Click cell from Due Diligence Report - View Order
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    And User selects My Third-party show option
    And User clicks Due Diligence Activity section "Total Active" column value
    Then "DUE DILIGENCE ORDER REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "Third-party Id"
    And User checks Column Field "Risk Tier"
    And User checks Column Field "Order Id"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Medium"
    And User clicks Report panel "Filters"
    And User clicks Report panel "Filters"
    And User adds Reports first row "ORDER ID" value to "orderId" context
    And User adds Reports first row "THIRD-PARTY ID" value to "thirdPartyId" context
    And User clicks Report panel "Filters"
    And User clicks first Report row
    Then Due Diligence Order form is opened
    And Due Diligence Order form contains expected URL
    When User clicks Back button on Due Diligence Order page
    Then "DUE DILIGENCE ORDER REPORT" report page is displayed
    And Report filter icon for column "RISK TIER" is displayed
