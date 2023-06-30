@ui @full_regression @workflowReports
Feature: Reports - Workflow Reports

  As a user
  I would like to verify Workflow Reports test scripts
  So that I can get the accurate Workflow Reports results.

  @C36866776
  Scenario: C36866776: Dashboard Enhancements - Workflow Report: "Show" option
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    Then "WORKFLOW REPORT" report page is displayed
    And Workflow Report Third-party drop down displays "All Third-party" value
    And Workflow Report Third-party drop down has options
      | All Third-party |
      | My Third-party  |

  @C36873700
  Scenario: C36873700: Dashboard Enhancements - Workflow Report: "Show" option - dropdown: All Third-party
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    Then "WORKFLOW REPORT" report page is displayed
    And Report Icon info contains expected data
    When User selects All Third-party show option
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "DIVISION"
    And User clicks Pagination Select "50"
    Then Report table column "DIVISION" contains only values
      | MyDivision |
      | Operations |

  @C36873701
  Scenario: C36873701: Dashboard Enhancements - Workflow Report: "Show" option - dropdown: My Third-party
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    Then "WORKFLOW REPORT" report page is displayed
    And Report Icon info contains expected data
    When User selects My Third-party show option
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "RESPONSIBLE PARTY"
    And User clicks Pagination Select "50"
    Then Report table column "RESPONSIBLE PARTY" contains only values
      | Admin_AT_FN Admin_AT_LN |

  @C36873730
  Scenario: C36873730: Dashboard Enhancements - Workflow Report: Display Results - Validate filter panel, columns can be check or uncheck
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    Then "WORKFLOW REPORT" report page is displayed
    And Report columns are displayed
      | THIRD-PARTY ID      |
      | REFERENCE ID        |
      | THIRD-PARTY NAME    |
      | WORKFLOW NAME       |
      | WORKFLOW TYPE       |
      | STATUS              |
      | INITIATED BY        |
      | RESPONSIBLE PARTY   |
      | DIVISION            |
      | CYCLE TIME          |
      | RISK TIER           |
      | ASSESSED RISK TIER  |
      | WORKFLOW RISK SCORE |
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    Then Report columns could be checked and unchecked
      | Risk Score              |
      | Third-party Status      |
      | Company Type            |
      | Organisation Size       |
      | Date of Incorporation   |
      | Currency                |
      | Industry Type           |
      | Business Category       |
      | Revenue                 |
      | Liquidation Date        |
      | Affiliation             |
      | Spend Category          |
      | Design Agreement        |
      | Relationship Visibility |
      | Commodity Type          |
      | Sourcing Method         |
      | Sourcing Type           |
      | Product Impact          |
      | Third-party Region      |
      | Third-party Country     |
      | Workflow ID             |
      | Workflow Group          |
      | Initiated By email      |
      | Responsible Party Email |
      | Start Date              |
      | Last Update             |
      | Activities Completed    |
      | Irrelevant Activities   |

  @C36874047
  Scenario: C36874047: Dashboard Enhancements - Workflow Report: Display Results - Validate table for the display results section
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    Then "WORKFLOW REPORT" report page is displayed
    And Pagination option "10" is selected
    And Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    And Pagination buttons should be visible
      | first page | previous page | next page | last page |
    And Label for the number of returned results is expected

  @C36955953
  Scenario: C36955953: Dashboard Enhancements - Workflow Report: Export button
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    Then "WORKFLOW REPORT" report page is displayed
    When User clicks Report Export button
    Then Extension options are available
      | .csv |
      | .xls |

  @C36970720
  Scenario: C36970720: Dashboard Enhancements - Workflow Report: Display Results - Filter by Workflow Name using single letter
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    And User selects My Third-party show option
    Then "WORKFLOW REPORT" report page is displayed
    And Report panel "Filters" tool panel is not displayed
    And Report panel "Columns" tool panel is not displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "WORKFLOW NAME"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Workflow Name"
    And User clicks Filter Field Label "(Select All)"
    And User fills in Filter input value "W"
    Then Static report filter option contains "W"
    When User clicks Filter Field Label "(Select All)"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report table column "WORKFLOW NAME" contains only values
      | reportFilterOptions |
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "WORKFLOW NAME" is not displayed

  @C36970721
  Scenario: C36970721: Dashboard Enhancements - Workflow Report: Display Results - Filter by Workflow Name using keyword
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    And User selects My Third-party show option
    Then "WORKFLOW REPORT" report page is displayed
    And Report panel "Filters" tool panel is not displayed
    And Report panel "Columns" tool panel is not displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "WORKFLOW NAME"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Workflow Name"
    And User clicks Filter Field Label "(Select All)"
    And User fills in Filter input value "Workflow"
    Then Static report filter option contains "Workflow"
    When User clicks Filter Field Label "(Select All)"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report table column "WORKFLOW NAME" contains only values
      | reportFilterOptions |
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "WORKFLOW NAME" is not displayed

  @C36970722
  Scenario: C36970722: Dashboard Enhancements - Workflow Report: Display Results - Filter by Workflow Name using exact match name
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    And User clicks Pagination Select "50"
    Then "WORKFLOW REPORT" report page is displayed
    And Report panel "Filters" tool panel is not displayed
    And Report panel "Columns" tool panel is not displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "WORKFLOW NAME"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Workflow Name"
    And User clicks Filter Field Label "(Select All)"
    And User fills in Filter input value "toBeReplaced"
    Then Static report filter option contains "toBeReplaced"
    When User clicks Filter Field Label "(Select All)"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report table column "WORKFLOW NAME" contains only values
      | reportFilterOptions |
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "WORKFLOW NAME" is not displayed

  @C36970723
  Scenario: C36970723: Dashboard Enhancements - Workflow Report: Display Results - No Available Data
    Given User logs into RDDC as "Empty Metrics User"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    Then "WORKFLOW REPORT" report page is displayed
    When User selects My Third-party show option
    Then Report 'No Available Data' is displayed
    And Report Reset all Filter Button is hidden

  @C36970725
  Scenario: C36970725: Dashboard Enhancements - Workflow Report: Display Results - Search in result section: No Match found
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    Then "WORKFLOW REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "RISK SCORE"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Score"
    And User fills in Filter input value "5"
    And User clicks filter page button
    Then No Match Found report records is displayed
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "RISK SCORE" is not displayed

  @C36970826
  Scenario: C36970826: Dashboard Enhancements - Workflow Report - Filter panel, expand and collapsed
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    Then "WORKFLOW REPORT" report page is displayed
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    Then Report Filters panel contains label text "Apply Filters"
    When User clicks Report panel "Filters"
    Then Report Filters panel contains label text "Filters"

  @C36972155
  Scenario: C36972155: Dashboard Enhancements - Workflow Report - Filter type: Text
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Third-Party Id"
    Then Search area is displayed

  @C36975430
  Scenario: C36975430: Dashboard Enhancements - Workflow Report: View Workflow
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Workflow Report"
    Then "WORKFLOW REPORT" report page is displayed
    And Report panel "Filters" tool panel is not displayed
    And Report panel "Columns" tool panel is not displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY ID"
    And User checks Column Field "STATUS"
    And User clicks Report panel "Columns"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Status"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Onboarding"
    And User clicks Report panel "Filters"
    Then Report table column "STATUS" contains only values
      | Onboarding |
    When User clicks last page icon
    And User clicks first Report row
    Then Third-party Information tab is loaded

  @C36996940
  Scenario: C36996940: Dashboard Enhancements - Dashboard Enhancements - Third-party Onboarding Metrics: Go to Workflow Report (Onboarded) - Last 90 Days x TOTAL
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    Then Third-party metrics bar graph with label "Third-party Volume by Risk Tier" is displayed
    And Third-party metrics bar graph with label "Onboarding Volume by Status" is displayed
    And Third-party metrics bar graph with label "Onboarding Cycle Time by Risk Tier" is displayed
    And Third-party metrics bar graph with label "Pending Renewal by Risk Tier" is displayed
    And Third-party metrics bar graph with label "Renewal Volume by Status" is displayed
    And Third-party metrics bar graph with label "Renewal Cycle Time by Risk Tier" is displayed
    When User clicks Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "TOTAL" risk score
    Then "WORKFLOW REPORT" report page is displayed
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "WORKFLOW TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "LAST UPDATE"
    Then Report table column "WORKFLOW TYPE" contains only values
      | Onboarding |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    When User clicks last page icon
    Then Report table column "WORKFLOW TYPE" contains only values
      | Onboarding |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Workflow Name"
    And User fills in Filter input value "toBeReplaced"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report Reset all Filter Button is available
    And Report table column "WORKFLOW NAME" contains "toBeReplaced" values
    And User clicks first Report row
    Then Third-party Information tab is loaded
    When User waits and clicks "Back Button" third-party button
    Then "WORKFLOW REPORT" report page is displayed
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "WORKFLOW TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed
    And Report filter icon for column "LAST UPDATE" is not displayed
    And Report filter icon for column "WORKFLOW NAME" is not displayed

  @C37001453
  Scenario: C37001453: Dashboard Enhancements - Third-party Onboarding Metrics: Go to Workflow Report (Onboarded) - Last 90 Days x HIGH
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    And User clicks Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "HIGH" risk score
    Then "WORKFLOW REPORT" report page is displayed
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "WORKFLOW TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "LAST UPDATE"
    And User checks Column Field "RISK TIER"
    Then Report table column "WORKFLOW TYPE" contains only values
      | Onboarding |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "RISK TIER" contains only values
      | High |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    When User clicks last page icon
    Then Report table column "WORKFLOW TYPE" contains only values
      | Onboarding |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    And Report table column "RISK TIER" contains only values
      | High |
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Workflow Name"
    And User fills in Filter input value "toBeReplaced"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report Reset all Filter Button is available
    And Report table column "WORKFLOW NAME" contains "toBeReplaced" values
    And User clicks first Report row
    Then Third-party Information tab is loaded
    When User waits and clicks "Back Button" third-party button
    Then "WORKFLOW REPORT" report page is displayed
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "WORKFLOW TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed
    And Report filter icon for column "LAST UPDATE" is not displayed
    And Report filter icon for column "WORKFLOW NAME" is not displayed
    And Report filter icon for column "RISK TIER" is not displayed

  @C37001452
  Scenario: C37001452: Dashboard Enhancements - Third-party Onboarding Metrics: Go to Workflow Report (Onboarded) - Last 90 Days x MED
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    And User clicks Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "MED" risk score
    Then "WORKFLOW REPORT" report page is displayed
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "WORKFLOW TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "LAST UPDATE"
    And User checks Column Field "RISK TIER"
    Then Report table column "WORKFLOW TYPE" contains only values
      | Onboarding |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "RISK TIER" contains only values
      | Medium |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    When User clicks last page icon
    Then Report table column "WORKFLOW TYPE" contains only values
      | Onboarding |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    And Report table column "RISK TIER" contains only values
      | Medium |
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Workflow Name"
    And User fills in Filter input value "toBeReplaced"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report Reset all Filter Button is available
    And Report table column "WORKFLOW NAME" contains "toBeReplaced" values
    And User clicks first Report row
    Then Third-party Information tab is loaded
    When User waits and clicks "Back Button" third-party button
    Then "WORKFLOW REPORT" report page is displayed
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "WORKFLOW TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed
    And Report filter icon for column "LAST UPDATE" is not displayed
    And Report filter icon for column "WORKFLOW NAME" is not displayed
    And Report filter icon for column "RISK TIER" is not displayed

  @C37001418
  Scenario: C37001418: Dashboard Enhancements - Third-party Onboarding Metrics: Go to Workflow Report (Onboarded) -Last 90 Days x LOW
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    And User clicks Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "LOW" risk score
    Then "WORKFLOW REPORT" report page is displayed
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "WORKFLOW TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "LAST UPDATE"
    And User checks Column Field "RISK TIER"
    Then Report table column "WORKFLOW TYPE" contains only values
      | Onboarding |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "RISK TIER" contains only values
      | Low |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    When User clicks last page icon
    Then Report table column "WORKFLOW TYPE" contains only values
      | Onboarding |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    And Report table column "RISK TIER" contains only values
      | Low |
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Workflow Name"
    And User fills in Filter input value "toBeReplaced"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report Reset all Filter Button is available
    And Report table column "WORKFLOW NAME" contains "toBeReplaced" values
    And User clicks first Report row
    Then Third-party Information tab is loaded
    When User waits and clicks "Back Button" third-party button
    Then "WORKFLOW REPORT" report page is displayed
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "WORKFLOW TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed
    And Report filter icon for column "LAST UPDATE" is not displayed
    And Report filter icon for column "WORKFLOW NAME" is not displayed
    And Report filter icon for column "RISK TIER" is not displayed

  @C37001454
  Scenario: C37001454: Dashboard Enhancements - Third-party Renewal Metrics: Go to Workflow Report (Renewed) - Last 90 Days x TOTAL
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    And User clicks Renewal Metrics for column "(LAST 90 DAYS)" third-parties with "TOTAL" risk score
    Then "WORKFLOW REPORT" report page is displayed
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "WORKFLOW TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "LAST UPDATE"
    Then Report table column "WORKFLOW TYPE" contains only values
      | Renewal |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    When User clicks last page icon
    Then Report table column "WORKFLOW TYPE" contains only values
      | Renewal |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Workflow Name"
    And User fills in Filter input value "toBeReplaced"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report Reset all Filter Button is available
    And Report table column "WORKFLOW NAME" contains "toBeReplaced" values
    And User clicks first Report row
    Then Third-party Information tab is loaded
    When User waits and clicks "Back Button" third-party button
    Then "WORKFLOW REPORT" report page is displayed
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "WORKFLOW TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed
    And Report filter icon for column "LAST UPDATE" is not displayed
    And Report filter icon for column "WORKFLOW NAME" is not displayed

  @C37001457
  Scenario: C37001457: Dashboard Enhancements - Third-party Renewal Metrics: Go to Workflow Report (Renewed) - Last 90 Days x HIGH
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    And User clicks Renewal Metrics for column "(LAST 90 DAYS)" third-parties with "HIGH" risk score
    Then "WORKFLOW REPORT" report page is displayed
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "WORKFLOW TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "LAST UPDATE"
    And User checks Column Field "RISK TIER"
    Then Report table column "WORKFLOW TYPE" contains only values
      | Renewal |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "RISK TIER" contains only values
      | High |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    When User clicks last page icon
    Then Report table column "WORKFLOW TYPE" contains only values
      | Renewal |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    And Report table column "RISK TIER" contains only values
      | High |
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Workflow Name"
    And User fills in Filter input value "toBeReplaced"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report Reset all Filter Button is available
    And Report table column "WORKFLOW NAME" contains "toBeReplaced" values
    And User clicks first Report row
    Then Third-party Information tab is loaded
    When User waits and clicks "Back Button" third-party button
    Then "WORKFLOW REPORT" report page is displayed
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "WORKFLOW TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed
    And Report filter icon for column "LAST UPDATE" is not displayed
    And Report filter icon for column "WORKFLOW NAME" is not displayed
    And Report filter icon for column "RISK TIER" is not displayed

  @C37001456
  Scenario: C37001456: Dashboard Enhancements - Third-party Renewal Metrics: Go to Workflow Report (Renewed) - Last 90 Days x MED
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    And User clicks Renewal Metrics for column "(LAST 90 DAYS)" third-parties with "MED" risk score
    Then "WORKFLOW REPORT" report page is displayed
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "WORKFLOW TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "LAST UPDATE"
    And User checks Column Field "RISK TIER"
    Then Report table column "WORKFLOW TYPE" contains only values
      | Renewal |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "RISK TIER" contains only values
      | Medium |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    When User clicks last page icon
    Then Report table column "WORKFLOW TYPE" contains only values
      | Renewal |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    And Report table column "RISK TIER" contains only values
      | Medium |
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Workflow Name"
    And User fills in Filter input value "toBeReplaced"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report Reset all Filter Button is available
    And Report table column "WORKFLOW NAME" contains "toBeReplaced" values
    And User clicks first Report row
    Then Third-party Information tab is loaded
    When User waits and clicks "Back Button" third-party button
    Then "WORKFLOW REPORT" report page is displayed
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "WORKFLOW TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed
    And Report filter icon for column "LAST UPDATE" is not displayed
    And Report filter icon for column "WORKFLOW NAME" is not displayed
    And Report filter icon for column "RISK TIER" is not displayed

  @C37001455
  Scenario: C37001455: Dashboard Enhancements - Third-party Renewal Metrics: Go to Workflow Report (Renewed) -Last 90 Days x LOW
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    And User clicks Renewal Metrics for column "(LAST 90 DAYS)" third-parties with "LOW" risk score
    Then "WORKFLOW REPORT" report page is displayed
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "WORKFLOW TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "LAST UPDATE"
    And User checks Column Field "RISK TIER"
    Then Report table column "WORKFLOW TYPE" contains only values
      | Renewal |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "RISK TIER" contains only values
      | Low |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    When User clicks last page icon
    Then Report table column "WORKFLOW TYPE" contains only values
      | Renewal |
    And Report table column "STATUS" contains only values
      | Onboarded |
    And Report table column "LAST UPDATE" date contains only values in range from "TODAY-90" to "TODAY+1"
    And Report table column "RISK TIER" contains only values
      | Low |
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Workflow Name"
    And User fills in Filter input value "toBeReplaced"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report Reset all Filter Button is available
    And Report table column "WORKFLOW NAME" contains "toBeReplaced" values
    And User clicks first Report row
    Then Third-party Information tab is loaded
    When User waits and clicks "Back Button" third-party button
    Then "WORKFLOW REPORT" report page is displayed
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "WORKFLOW TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed
    And Report filter icon for column "LAST UPDATE" is not displayed
    And Report filter icon for column "WORKFLOW NAME" is not displayed
    And Report filter icon for column "RISK TIER" is not displayed
