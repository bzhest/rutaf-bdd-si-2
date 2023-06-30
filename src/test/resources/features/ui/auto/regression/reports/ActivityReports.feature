@ui @full_regression @activityReports
Feature: Reports

  As a user
  I would like to verify Activity Reports test scripts
  So that I can get the accurate Activity Reports results.

  @C36627342 @C36627343 @C36627344 @C36627345 @C36627346 @C36627347
  Scenario Outline: C36627342, C36627343, C36627344, C36627345, C36627346, C36627347: Activity Metrics - All/My Third-party - Click All Activities x Assigned/Approvals/Reviews cells - Verify that user should be redirected to Activity Report page
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    Then Activity Metrics tab Third-party drop down displays "All Third-party" value
    When User selects <thirdPartyDropdown> show option
    And User clicks All Activities section "Total Active" row "<columnName>" column value
    Then "ACTIVITY REPORT" report page is displayed
    And Activity Report Third-party drop down displays "<thirdPartyDropdown>" value
    When User clicks Pagination Select "50"
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "Status"
    And User checks Column Field "<columnField>"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | <statusValues> |
    And Report table column "<columnField>" contains only values
      | <columnValues> |
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
    And User selects <thirdPartyDropdown> show option
    And User clicks All Activities section "Past Due" row "<columnName>" column value
    Then "ACTIVITY REPORT" report page is displayed
    And Activity Report Third-party drop down displays "<thirdPartyDropdown>" value
    When User clicks Pagination Select "50"
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "Status"
    And User checks Column Field "<columnField>"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | <statusValues> |
    And Report table column "<columnField>" contains only values
      | <columnValues> |
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
    And User selects <thirdPartyDropdown> show option
    And User clicks All Activities section "Due within 7 Days" row "<columnName>" column value
    Then "ACTIVITY REPORT" report page is displayed
    And Activity Report Third-party drop down displays "<thirdPartyDropdown>" value
    And Report table column "DUE DATE" date contains only values in range from "TODAY+0" to "TODAY+6"
    And Export Report Button is enabled
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "STATUS" is not displayed
    When User navigates to Home page
    And User selects Activity Metrics Tab
    And User selects <thirdPartyDropdown> show option
    And User clicks All Activities section "Due in 8-14 Days" row "<columnName>" column value
    Then "ACTIVITY REPORT" report page is displayed
    And Activity Report Third-party drop down displays "<thirdPartyDropdown>" value
    And Report table column "DUE DATE" date contains only values in range from "TODAY+7" to "TODAY+13"
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "STATUS" is not displayed

    Examples:
      | thirdPartyDropdown | columnName | columnField     | statusValues                                | columnValues                              |
      | All Third-party    | Assigned   | not applicable  | Not Started, Deffered, Waiting, In Progress | not applicable                            |
      | All Third-party    | Approvals  | Approval Status | Not Started                                 | Pending, Pending for Assignment, Rejected |
      | All Third-party    | Reviews    | Review Status   | Done                                        | Pending, Rejected, Pending for Assignment |
      | My Third-party     | Assigned   | not applicable  | Not Started, Deffered, Waiting, In Progress | not applicable                            |
      | My Third-party     | Approvals  | Approval Status | Not Started                                 | Pending, Pending for Assignment, Rejected |
      | My Third-party     | Reviews    | Review Status   | Done                                        | Pending, Rejected, Pending for Assignment |

  @C36627356
  Scenario: C36627356: Reports - Activity Report - All Third-party - Export
    Given User launches RDDC Login page
    When User "Admin" enters username and password
    And User navigates to Reports page
    And User selects Report Tab "Activity Report"
    Then Activity Report Third-party drop down displays "All Third-party" value
    When User clicks Report panel "Columns"
    And User checks Column Field "Risk Tier"
    Then Column with name "Risk Tier" is displayed
    When User checks Column Field "Risk Score"
    Then Column with name "Risk Score" is displayed
    When User checks Column Field "Third-Party Country"
    Then Column with name "Third-Party Country" is displayed
    When User checks Column Field "Third-Party Region"
    Then Column with name "Third-Party Region" is displayed
    When User unchecks Column Field "Assignee"
    Then Column with name "Assignee" is not displayed
    When User unchecks Column Field "Assignee Email"
    Then Column with name "Assignee Email" is not displayed
    When User unchecks Column Field "Submission Date"
    Then Column with name "Submission Date" is not displayed
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Third-Party Status"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "ONBOARDING"
    And User clicks Filter Field Label "RENEWING"
    And User clicks Report panel "Filters"
    When User clicks Report Export button
    Then Extension options are available
      | .csv |
      | .xls |
    When User clicks export xls file
    Then ".xlsx" File with name "RDDCentre_Activity-Report_" and date format "MMddYYYY" downloaded
    When User clicks export csv file
    And User clicks My Exports option
    Then My Exports table contains file with name "RDDCentre_Activity_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"

  @C36844787
  Scenario: C36844787 : Reports - Activity Report - My Third-party Export
    Given User launches RDDC Login page
    When User "Admin" enters username and password
    And User navigates to Reports page
    And User selects Report Tab "Activity Report"
    And User selects My Third-party show option
    And User clicks Report panel "Columns"
    And User checks Column Field "Risk Tier"
    And User checks Column Field "Risk Score"
    And User checks Column Field "Third-Party Country"
    And User checks Column Field "Third-Party Region"
    And User unchecks Column Field "Assignee"
    And User unchecks Column Field "Assignee Email"
    And User unchecks Column Field "Submission Date"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Third-Party Status"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "ONBOARDING"
    And User clicks Report panel "Filters"
    And User clicks export csv file
    And User clicks export xls file
    And User navigates to Home page

  @C36627369
  Scenario: C36627369 : Reports - Activity Report - Reset Filters
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Activity Report"
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
    Then Report Filter Field "Medium" is selected
    And Report Filter Field "(Select All)" is selected
    And Report Filter Field "High" is selected
    And Report Filter Field "Low" is selected

  @C36627367
  Scenario: C36627367 : Reports - Activity Report - No Match Found
    Given User logs into RDDC as "Admin"
    And User navigates to Reports page
    And User selects Report Tab "Activity Report"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Report panel "Filters"
    And No Match Found report records is displayed

  @C36627357
  Scenario: C36627357 : Reports - Activity Report - No Results - Verify that Export button is disabled
    Given User launches RDDC Login page
    When User "Admin" enters username and password
    And User navigates to Reports page
    And User selects Report Tab "Activity Report"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Report panel "Filters"
    Then No Match Found report records is displayed
    And Export Report Button is enabled
    And User navigates to Home page

  @C36627368
  Scenario: C36627368 : Reports - Activity Report - No Available Data
    Given User logs into RDDC as "Empty Metrics User"
    When User navigates to Reports page
    And User selects Report Tab "Activity Report"
    Then Report 'No Available Data' is displayed
    And Report Reset all Filter Button is hidden

  @C36627370
  Scenario: C36627370 : Reports - Activity Report - No Match Found - Verify that Reset Filters button is displayed
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Activity Report"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Report panel "Filters"
    Then No Match Found report records is displayed
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden

  @C36627360
  Scenario: C36627360 : Activity Report - Verify Filter panel
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Activity Report"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    Then Report Filters panel contains label text "Apply Filters"
    When User clicks Report panel "Filters"
    Then Report Filters panel contains label text "Filters"

  @C36627365
  Scenario: C36627365 : Reports - Activity Report - Verify label for the number of returned results
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Activity Report"
    Then Label for the number of returned results is expected

  @C36627364
  Scenario: C36627364 : Reports - Activity Report - Add/Remove Columns
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Activity Report"
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


  @C36753754
  Scenario: C36753754 : Reports - Activity Report - Verify that Columns/Filters panel should be closed upon initial loading
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Activity Report"
    And User clicks Report panel "Columns"
    Then Report panel "Columns" tool panel is displayed
    When User clicks Report panel "Columns"
    Then Report panel "Columns" tool panel is not displayed
    When User clicks Report panel "Filters"
    Then Report panel "Filters" tool panel is displayed
    When User clicks Report panel "Filters"
    Then Report panel "Filters" tool panel is not displayed

  @C36627371
  Scenario Outline: C36627371 : Reports - Activity Report - View Activity
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Activity Report"
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "Third-party Id"
    And User checks Column Field "Activity Id"
    And User checks Column Field "Activity Source"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Activity Source"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "<activitySource>"
    And User clicks Report panel "Filters"
    And User clicks "2" pagination button if present
    And User adds Reports last row "ACTIVITY ID" value to "activityId" context
    And User adds Reports last row "THIRD-PARTY ID" value to "thirdPartyId" context
    And User clicks Last Row on Report table
    Then '<activityPage>' Activity page is displayed
    And <activityPage> page opened from Reports contains expected URL
    When User clicks Back button to return from Activity modal
    Then "ACTIVITY REPORT" report page is displayed
    And Report filter icon for column "ACTIVITY SOURCE" is displayed
    And Pagination page "toBeReplaced" is currently selected

    Examples:
      | activitySource     | activityPage         |
      | ADHOC              | Ad Hoc Activity      |
      | ONBOARDING/RENEWAL | Activity Information |


  @C36627372
  Scenario Outline: C36627372 : Activity Metrics - Click cell from All Activities columns - View Activity
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    Then Activity Metrics tab Third-party drop down displays "All Third-party" value
    When User clicks All Activities section "Total Active" row "<columnName>" column value
    Then "ACTIVITY REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "Third-party Id"
    And User checks Column Field "Activity Id"
    And User checks Column Field "Activity Source"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Activity Source"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "<activitySource>"
    And User clicks Report panel "Filters"
    And User clicks "2" pagination button if present
    And User adds Reports last row "ACTIVITY ID" value to "activityId" context
    And User adds Reports last row "THIRD-PARTY ID" value to "thirdPartyId" context
    And User clicks Last Row on Report table
    Then '<activityPage>' Activity page is displayed
    And <activityPage> page opened from Reports contains expected URL
    When User clicks Back button to return from Activity modal
    Then "ACTIVITY REPORT" report page is displayed
    And Report filter icon for column "ACTIVITY SOURCE" is displayed
    And Pagination page "toBeReplaced" is currently selected

    Examples:
      | columnName | activitySource     | activityPage         |
      | Assigned   | ADHOC              | Ad Hoc Activity      |
      | Approvals  | ONBOARDING/RENEWAL | Activity Information |

  @C36627341
  Scenario: C36627341 : Reports - Activity Report - Verify Show Option
    Given User launches RDDC Login page
    When User "Admin" enters username and password
    And User navigates to Reports page
    And User selects Report Tab "Activity Report"
    Then Activity Report Third-party drop down displays "All Third-party" value
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
