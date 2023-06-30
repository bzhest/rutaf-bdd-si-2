@ui @full_regression @dashboard @dashboardSupplierMetrics
Feature: Activity Metrics

  @C36271092
  Scenario: C36271092: [Dashboard enh.] Activity Metrics - Verify Activity Metrics page when there is No Available Data
    Given User logs into RDDC as "Empty Metrics User"
    When User selects Activity Metrics Tab
    Then Activity Metrics table is displayed with empty results
    And Activity Metrics "No Available Data" displayed for following bar charts
      | COUNT OF ACTIVE ACTIVITIES                 |
      | COUNT OF ACTIVE QUESTIONNAIRES             |
      | COUNT OF IN-PROGRESS DUE DILIGENCE REPORTS |

  @C36269139
  Scenario: C36269139: [Dashboard enh.] Activity Metrics - Verify that Activity Metrics page has correct content and view
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    Then Activity Metrics table is displayed with header column names
      | ALL ACTIVITIES | QUESTIONNAIRE | DUE DILIGENCE REPORTS |
    And Activity Metrics table is displayed with major column names
      | ASSIGNED | APPROVALS | REVIEWS | INTERNAL | EXTERNAL |
    And Activity Metrics table is displayed with minor column names
      | TOTAL ACTIVE | PAST DUE | DUE WITHIN 7 DAYS | DUE IN 8-14 DAYS | AVERAGE COMPLETION (DAYS) |
    And Activity Metrics "COUNT OF ACTIVE ACTIVITIES" bar chart is displayed
    And Activity Metrics "COUNT OF ACTIVE QUESTIONNAIRES" bar chart is displayed
    And Activity Metrics "COUNT OF IN-PROGRESS DUE DILIGENCE REPORTS" bar chart is displayed
    And Dashboard Metrics filter drop-down contains options
      | All Third-party |
      | My Third-party  |
    And Dashboard Metrics filter drop-down option "All Third-party" is selected
    And Dashboard Metrics Last Updated date is displayed in expected format
