@ui @full_regression @questionnaireReports
Feature: Reports - Questionnaire Reports

  As a user
  I would like to verify Questionnaire Reports test scripts
  So that I can get the accurate Questionnaire Reports results.

  @C36628733
  Scenario: C36628733: Dashboard Enhancements - Questionnaire Report: Display Results - Validate column navigation, columns can be check or uncheck
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    And Report columns are displayed
      | THIRD-PARTY ID     |
      | REFERENCE ID       |
      | THIRD-PARTY NAME   |
      | QUESTIONNAIRE ID   |
      | QUESTIONNAIRE NAME |
      | QUESTIONNAIRE TYPE |
      | STATUS             |
      | RESPONDER NAME     |
      | RESPONDER EMAIL    |
      | ASSIGNOR NAME      |
      | ASSIGNOR EMAIL     |
      | DUE DATE           |
      | DATE COMPLETED     |
      | REVIEWER NAME      |
      | CATEGORY           |
      | OVERALL ASSESSMENT |
      | LAST UPDATE        |
      | COMPLETION TIME    |
      | SCORE              |
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    Then Report columns could be checked and unchecked
      | Risk Tier                   |
      | Risk Score                  |
      | Third-party Status          |
      | Company Type                |
      | Organisation Size           |
      | Date of Incorporation       |
      | Currency                    |
      | Industry Type               |
      | Business Category           |
      | Revenue                     |
      | Liquidation Date            |
      | Affiliation                 |
      | Spend Category              |
      | Design Agreement            |
      | Relationship Visibility     |
      | Commodity Type              |
      | Sourcing Method             |
      | Sourcing Type               |
      | Product Impact              |
      | Third-party Region          |
      | Third-party Country         |
      | Responsible Party           |
      | Responsible Party Email     |
      | Division                    |
      | Questionnaire Source        |
      | Date Assigned               |
      | Submission Date             |
      | Revision Date               |
      | Revision Requested by       |
      | Revision Requested by email |
      | Date Rejected               |
      | Date Approved               |
      | Reviewer Email              |
      | Last Update                 |
      | Last Updated By             |
      | Last Updated By email       |
      | Reviewer Group              |
      | Reviewer Department         |
      | Reviewer Division           |

  @C36629205
  Scenario: C36629205: Dashboard Enhancements - Questionnaire Report: Display Results - Validate single select filter
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    And Report Reset all Filter Button is hidden
    And Report panel "Filters" tool panel is not displayed
    And Report panel "Columns" tool panel is not displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "STATUS"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Status"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Cancelled"
    And User clicks Report panel "Filters"
    Then Report table column "STATUS" contains only values
      | Cancelled |
    And Report filter icon for column "STATUS" is displayed
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "STATUS" is not displayed

  @C36629248
  Scenario: C36629248: Dashboard Enhancements - Questionnaire Report: Display Results - Validate Multi-select filter
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    And Report Reset all Filter Button is hidden
    And Report panel "Filters" tool panel is not displayed
    And Report panel "Columns" tool panel is not displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "RISK TIER"
    And User checks Column Field "STATUS"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Status"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Cancelled"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Low"
    And User clicks Report panel "Filters"
    Then Report table column "STATUS" contains only values
      | Cancelled |
    And Report table column "RISK TIER" contains only values
      | Low |
    And Report filter icon for column "STATUS" is displayed
    And Report filter icon for column "RISK TIER" is displayed
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "STATUS" is not displayed
    And Report filter icon for column "RISK TIER" is not displayed

  @C36629259
  Scenario: C36629259: Dashboard Enhancements - Questionnaire Report: Display Results - Filter by Questionnaire Name using single letter
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    And User clicks Pagination Select "25"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    And Report panel "Filters" tool panel is not displayed
    And Report panel "Columns" tool panel is not displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "QUESTIONNAIRE NAME"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Questionnaire Name"
    And User clicks Filter Field Label "(Select All)"
    And User fills in Filter input value "Q"
    Then Static report filter option contains "Q"
    When User clicks Filter Field Label "(Select All)"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    And User clicks Pagination Select "25"
    Then Report table column "QUESTIONNAIRE NAME" contains only values
      | reportFilterOptions |
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "QUESTIONNAIRE NAME" is not displayed

  @C36629260
  Scenario: C36629260: Dashboard Enhancements - Questionnaire Report: Display Results - Filter by Questionnaire Name using keyword
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    And Report panel "Filters" tool panel is not displayed
    And Report panel "Columns" tool panel is not displayed
    When User clicks Pagination Select "50"
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "QUESTIONNAIRE NAME"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Questionnaire Name"
    And User clicks Filter Field Label "(Select All)"
    And User fills in Filter input value "Auto"
    Then Static report filter option contains "Auto"
    When User clicks Filter Field Label "(Select All)"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report table column "QUESTIONNAIRE NAME" contains only values
      | reportFilterOptions |
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "QUESTIONNAIRE NAME" is not displayed

  @C36629264
  Scenario: C36629264: Dashboard Enhancements - Questionnaire Report: Display Results - Filter by Questionnaire Name using exact match name
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    And Report panel "Filters" tool panel is not displayed
    And Report panel "Columns" tool panel is not displayed
    When User clicks "next" pagination button
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "QUESTIONNAIRE NAME"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Questionnaire Name"
    And User clicks Filter Field Label "(Select All)"
    And User fills in Filter input value "toBeReplaced"
    Then Static report filter option contains "toBeReplaced"
    When User clicks Filter Field Label "(Select All)"
    And User clicks filter page button
    And User clicks Report panel "Filters"
    Then Report table column "QUESTIONNAIRE NAME" contains only values
      | reportFilterOptions |
    And Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "QUESTIONNAIRE NAME" is not displayed

  @C36829848
  Scenario: C36829848: Dashboard Enhancements - Questionnaire Report: Display Results - Validate clear button in each filter pannel
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Filters"
    Then Each Report filter option contains clear button

  @C36829885
  Scenario: C36829885: Dashboard Enhancements - Questionnaire Report: Display Results - Clear filter
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "STATUS"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Status"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Cancelled"
    And User clicks Report panel "Filters"
    Then Report table column "STATUS" contains only values
      | Cancelled |
    And Report filter icon for column "STATUS" is displayed
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Status"
    And User clicks Clear report filter button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "STATUS" is not displayed

  @C36858565
  Scenario: C36858565: Dashboard Enhancements - Questionnaire Report: Export button
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report Export button
    Then Extension options are available
      | .csv |
      | .xls |

  @C36858607
  Scenario: C36858607: Dashboard Enhancements - Questionnaire Report: "Show" option
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    And Workflow Report Third-party drop down displays "All Third-party" value
    And Workflow Report Third-party drop down has options
      | All Third-party |
      | My Third-party  |

  @C36858610
  Scenario: C36858610: Dashboard Enhancements - Questionnaire Report: "Show" option - dropdown: All Third-party
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    And Report Icon info contains expected data
    When User selects All Third-party show option
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "DIVISION"
    And User clicks Pagination Select "50"
    Then Report table column "DIVISION" contains only values
      | MyDivision |
      | Operations |

  @C36858627
  Scenario: C36858627: Dashboard Enhancements - Questionnaire Report: "Show" option - dropdown: My Third-party
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    And Report Icon info contains expected data
    When User selects My Third-party show option
    And User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "RESPONSIBLE PARTY"
    And User clicks Pagination Select "50"
    Then Report table column "RESPONSIBLE PARTY" contains only values
      | Admin_AT_FN Admin_AT_LN |

  @C36861295
  Scenario: C36861295: Reports - Dashboard Enhancements - Questionnaire Report: Export file-.xls file extension
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "RISK TIER"
    And User checks Column Field "THIRD-PARTY ID"
    And User clicks Report panel "Columns"
    And User clicks export xls file
    Then ".xlsx" File with name "RDDCentre_Questionnaire-Report_" and date format "MMddYYYY" downloaded
    And Report "xlsx" file contains expected columns
      | RISK TIER      |
      | THIRD-PARTY ID |


  @C54101712
  Scenario: C54101712: Reports - Questionnaire Report - All Third-party - Export
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User checks all Report columns
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Third-Party Status"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "ONBOARDED"
    And User clicks Report panel "Filters"
    And User clicks Report Export button
    Then Extension options are available
      | .csv |
      | .xls |
    When User clicks export xls file
    Then ".xlsx" File with name "RDDCentre_Questionnaire-Report_" and date format "MMddYYYY" downloaded
    When User clicks export csv file
    And User clicks My Exports option
    Then My Exports table contains file with name "RDDCentre_Questionnaire_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"

  @C36862156
  Scenario: C36862156: Dashboard Enhancements - Questionnaire Report - Validate filter in each column under filter pannel
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "STATUS"
    And User clicks Report panel "Filters"
    Then Report filter options are displayed
      | THIRD-PARTY ID     |
      | REFERENCE ID       |
      | THIRD-PARTY NAME   |
      | QUESTIONNAIRE ID   |
      | QUESTIONNAIRE NAME |
      | QUESTIONNAIRE TYPE |
      | STATUS             |
      | RESPONDER NAME     |
      | RESPONDER EMAIL    |
      | ASSIGNOR NAME      |
      | ASSIGNOR EMAIL     |
      | DUE DATE           |
      | DATE COMPLETED     |
      | REVIEWER NAME      |
      | CATEGORY           |
      | OVERALL ASSESSMENT |
      | LAST UPDATE        |
      | COMPLETION TIME    |
      | SCORE              |

  @C36862192
  Scenario: C36862192: Dashboard Enhancements - Questionnaire Report - Filter panel, expand and collapsed
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Tier"
    And User clicks Filter Field Label "(Select All)"
    Then Report Filters panel contains label text "Apply Filters"
    When User clicks Report panel "Filters"
    Then Report Filters panel contains label text "Filters"

  @C36864132
  Scenario: C36864132: Dashboard Enhancements - Questionnaire Report - Filter type: Text
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Third-Party Id"
    Then Search area is displayed

  @C36908549
  Scenario: C36908549: Dashboard Enhancements - Questionnaire Report: Display Results - Search result in filter pannel: No Available Data
    Given User logs into RDDC as "Empty Metrics User"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User selects My Third-party show option
    Then Report 'No Available Data' is displayed
    And Report Reset all Filter Button is hidden

  @C36908550
  Scenario: C36908550: Dashboard Enhancements - Questionnaire Report: Display Results - Search in result section: No Match found
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
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

  @C36908796
  Scenario: C36908796: [Improvement] Dashboard Enhancements - Questionnaire Report: When report menu isn't clicked from Dashboard
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY STATUS"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Third-Party Status"
    And User clicks Filter Field Label "NEW"
    And User clicks Report panel "Filters"
    Then Report filter icon for column "THIRD-PARTY STATUS" is displayed
    When User clicks last page icon
    Then Report filter icon for column "THIRD-PARTY STATUS" is displayed
    When User selects Report Tab "Workflow Report"
    Then "WORKFLOW REPORT" report page is displayed
    And Report filter icon for column "THIRD-PARTY STATUS" is not displayed

  @C36930067
  Scenario: C36930067: Dashboard Enhancements - Questionnaire Report: View Questionnaire
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    And Report panel "Filters" tool panel is not displayed
    And Report panel "Columns" tool panel is not displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY ID"
    And User checks Column Field "QUESTIONNAIRE ID"
    And User checks Column Field "STATUS"
    And User clicks Report panel "Columns"
    And User clicks Report panel "Filters"
    And User clicks Filter Field Title "Third-Party Name"
    And User fills in Filter input value "SUPPLIER_INTERNAL_USER"
    And User clicks Report panel "Filters"
    And User clicks last page icon
    And User adds Reports first row "THIRD-PARTY ID" value to "thirdPartyTestData" context
    And User adds Reports first row "QUESTIONNAIRE ID" value to "questionnaireId" context
    And User clicks first Report row
    Then Questionnaire details page is displayed
    And Questionnaire details form contains expected URL
    When User clicks Questionnaire Details Cancel button
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Status"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Unresponded"
    And User clicks Filter Field Title "Third-Party Name"
    And User fills in Filter input value "SUPPLIER_EXTERNAL_USER"
    And User clicks Report panel "Filters"
    Then Report table column "STATUS" contains only values
      | Unresponded |
    And Report filter icon for column "STATUS" is displayed
    When User clicks last page icon
    And User adds Reports first row "THIRD-PARTY ID" value to "thirdPartyTestData" context
    And User adds Reports first row "QUESTIONNAIRE ID" value to "questionnaireId" context
    And User clicks first Report row
    Then Questionnaire details page is displayed
    And Questionnaire details form contains expected URL

  @C36935882
  Scenario: C36935882: Dashboard Enhancements - Activity Metrics: Go to Questionnaire Report (Questionnaire) - Internal x Total Active Cell
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    And User clicks Questionnaire section "TOTAL ACTIVE" row "INTERNAL" column value
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY ID"
    And User checks Column Field "QUESTIONNAIRE ID"
    And User checks Column Field "QUESTIONNAIRE TYPE"
    And User checks Column Field "STATUS"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | Unresponded        |
      | Save as Draft      |
      | Responded          |
      | Submitted          |
      | In Review          |
      | Requires Revision  |
      | Revision in Draft  |
      | Revision Submitted |
    And Report table column "QUESTIONNAIRE TYPE" contains only values
      | INTERNAL |
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Questionnaire Type"
    Then Report Filter Field "INTERNAL" is selected
    And Report Filter Field "EXTERNAL" is not selected
    When User clicks Report panel "Filters"
    And User clicks last page icon
    Then Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "QUESTIONNAIRE TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed

  @C36935891
  Scenario: C36935891: Dashboard Enhancements - Activity Metrics: Go to Questionnaire Report (Questionnaire) - Internal x Past Due
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    And User clicks Questionnaire section "PAST DUE" row "INTERNAL" column value
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY ID"
    And User checks Column Field "QUESTIONNAIRE ID"
    And User checks Column Field "QUESTIONNAIRE TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "DUE DATE"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | Unresponded        |
      | Save as Draft      |
      | Responded          |
      | Submitted          |
      | In Review          |
      | Requires Revision  |
      | Revision in Draft  |
      | Revision Submitted |
    And Report table column "QUESTIONNAIRE TYPE" contains only values
      | INTERNAL |
    And Report table column "DUE DATE" date contains only values in range from "" to "TODAY-1"
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Questionnaire Type"
    Then Report Filter Field "INTERNAL" is selected
    And Report Filter Field "EXTERNAL" is not selected
    When User clicks Report panel "Filters"
    And User clicks last page icon
    Then Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "QUESTIONNAIRE TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed

  @C36935914
  Scenario: C36935914: Dashboard Enhancements - Activity Metrics: Go to Questionnaire Report (Questionnaire) - Internal x Due within 7 days
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    And User clicks Questionnaire section "DUE WITHIN 7 DAYS" row "INTERNAL" column value
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY ID"
    And User checks Column Field "QUESTIONNAIRE ID"
    And User checks Column Field "QUESTIONNAIRE TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "DUE DATE"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | Unresponded        |
      | Save as Draft      |
      | Responded          |
      | Submitted          |
      | In Review          |
      | Requires Revision  |
      | Revision in Draft  |
      | Revision Submitted |
    And Report table column "QUESTIONNAIRE TYPE" contains only values
      | INTERNAL |
    And Report table column "DUE DATE" date contains only values in range from "TODAY+0" to "TODAY+6"
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Questionnaire Type"
    Then Report Filter Field "INTERNAL" is selected
    And Report Filter Field "EXTERNAL" is not selected
    When User clicks Report panel "Filters"
    And User clicks last page icon
    Then Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "QUESTIONNAIRE TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed

  @C36936037
  Scenario: C36936037: Dashboard Enhancements - Activity Metrics: Go to Questionnaire Report (Questionnaire) - Internal x Due in 8 to 14 days
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    And User clicks Questionnaire section "DUE IN 8-14 DAYS" row "INTERNAL" column value
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY ID"
    And User checks Column Field "QUESTIONNAIRE ID"
    And User checks Column Field "QUESTIONNAIRE TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "DUE DATE"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | Unresponded        |
      | Save as Draft      |
      | Responded          |
      | Submitted          |
      | In Review          |
      | Requires Revision  |
      | Revision in Draft  |
      | Revision Submitted |
    And Report table column "QUESTIONNAIRE TYPE" contains only values
      | INTERNAL |
    And Report table column "DUE DATE" date contains only values in range from "TODAY+7" to "TODAY+13"
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Questionnaire Type"
    Then Report Filter Field "INTERNAL" is selected
    And Report Filter Field "EXTERNAL" is not selected
    When User clicks Report panel "Filters"
    And User clicks last page icon
    Then Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "QUESTIONNAIRE TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed

  @C36936075
  Scenario: C36936075: Dashboard Enhancements - Activity Metrics: Go to Questionnaire Report (Questionnaire) - External x Total Active Cell
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    And User clicks Questionnaire section "TOTAL ACTIVE" row "EXTERNAL" column value
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY ID"
    And User checks Column Field "QUESTIONNAIRE ID"
    And User checks Column Field "QUESTIONNAIRE TYPE"
    And User checks Column Field "STATUS"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | Unresponded        |
      | Save as Draft      |
      | Responded          |
      | Submitted          |
      | In Review          |
      | Requires Revision  |
      | Revision in Draft  |
      | Revision Submitted |
    And Report table column "QUESTIONNAIRE TYPE" contains only values
      | EXTERNAL |
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Questionnaire Type"
    Then Report Filter Field "EXTERNAL" is selected
    And Report Filter Field "INTERNAL" is not selected
    When User clicks Report panel "Filters"
    And User clicks last page icon
    Then Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "QUESTIONNAIRE TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed

  @C36936080
  Scenario: C36936080: Dashboard Enhancements - Activity Metrics: Go to Questionnaire Report (Questionnaire) - External x Past Due
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    And User clicks Questionnaire section "PAST DUE" row "EXTERNAL" column value
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY ID"
    And User checks Column Field "QUESTIONNAIRE ID"
    And User checks Column Field "QUESTIONNAIRE TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "DUE DATE"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | Unresponded        |
      | Save as Draft      |
      | Responded          |
      | Submitted          |
      | In Review          |
      | Requires Revision  |
      | Revision in Draft  |
      | Revision Submitted |
    And Report table column "QUESTIONNAIRE TYPE" contains only values
      | EXTERNAL |
    And Report table column "DUE DATE" date contains only values in range from "" to "TODAY-1"
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Questionnaire Type"
    Then Report Filter Field "EXTERNAL" is selected
    And Report Filter Field "INTERNAL" is not selected
    When User clicks Report panel "Filters"
    And User clicks last page icon
    Then Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "QUESTIONNAIRE TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed

  @C36936087
  Scenario: C36936087: Dashboard Enhancements - Activity Metrics: Go to Questionnaire Report (Questionnaire) - External x Due within 7 days
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    And User clicks Questionnaire section "DUE WITHIN 7 DAYS" row "EXTERNAL" column value
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY ID"
    And User checks Column Field "QUESTIONNAIRE ID"
    And User checks Column Field "QUESTIONNAIRE TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "DUE DATE"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | Unresponded        |
      | Save as Draft      |
      | Responded          |
      | Submitted          |
      | In Review          |
      | Requires Revision  |
      | Revision in Draft  |
      | Revision Submitted |
    And Report table column "QUESTIONNAIRE TYPE" contains only values
      | EXTERNAL |
    And Report table column "DUE DATE" date contains only values in range from "TODAY+0" to "TODAY+6"
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Questionnaire Type"
    Then Report Filter Field "EXTERNAL" is selected
    And Report Filter Field "INTERNAL" is not selected
    When User clicks Report panel "Filters"
    And User clicks last page icon
    Then Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "QUESTIONNAIRE TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed

  @C36936111
  Scenario: C36936111: Dashboard Enhancements - Activity Metrics: Go to Questionnaire Report (Questionnaire) - External x Due in 8 to 14 days
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    And User clicks Questionnaire section "DUE IN 8-14 DAYS" row "EXTERNAL" column value
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "THIRD-PARTY ID"
    And User checks Column Field "QUESTIONNAIRE ID"
    And User checks Column Field "QUESTIONNAIRE TYPE"
    And User checks Column Field "STATUS"
    And User checks Column Field "DUE DATE"
    And User clicks Report panel "Columns"
    Then Report table column "STATUS" contains only values
      | Unresponded        |
      | Save as Draft      |
      | Responded          |
      | Submitted          |
      | In Review          |
      | Requires Revision  |
      | Revision in Draft  |
      | Revision Submitted |
    And Report table column "QUESTIONNAIRE TYPE" contains only values
      | EXTERNAL |
    And Report table column "DUE DATE" date contains only values in range from "TODAY+7" to "TODAY+13"
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Questionnaire Type"
    Then Report Filter Field "EXTERNAL" is selected
    And Report Filter Field "INTERNAL" is not selected
    When User clicks Report panel "Filters"
    And User clicks last page icon
    Then Report Reset all Filter Button is available
    When User clicks Reset All filter report button
    Then Report Reset all Filter Button is hidden
    And Report filter icon for column "QUESTIONNAIRE TYPE" is not displayed
    And Report filter icon for column "STATUS" is not displayed

  @C37064408
  Scenario: C37064408: [Improvement] Dashboard Enhancements - Questionnaire Report: Add more columns
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Questionnaire Report"
    Then "QUESTIONNAIRE REPORT" report page is displayed
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    Then Report columns could be checked and unchecked
      | Reviewer Group      |
      | Reviewer Department |
      | Reviewer Division   |
