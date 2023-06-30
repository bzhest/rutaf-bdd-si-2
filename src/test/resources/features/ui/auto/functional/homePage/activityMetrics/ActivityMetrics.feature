@ui @functional @dashboard @dashboardActivityMetrics
Feature: Home/Dashboard - Activity Metrics

  As a user
  I would like to verify Dashboard Activity Metrics test scripts
  So that I can get the accurate Activity Metrics results.

  Background:
    Given User logs into RDDC as "Admin"

  @C35714481
  Scenario: C35714481: All Third-party - Activity Metrics table - Verify Major Columns, Sub Columns and Rows
    When User selects Activity Metrics Tab
    And Activity Metrics table is displayed with header column names
      | ALL ACTIVITIES | QUESTIONNAIRE | DUE DILIGENCE REPORTS |
    And Activity Metrics table is displayed with major column names
      | ASSIGNED | APPROVALS | REVIEWS | INTERNAL | EXTERNAL |
    And Activity Metrics table is displayed with minor column names
      | TOTAL ACTIVE | PAST DUE | DUE WITHIN 7 DAYS | DUE IN 8-14 DAYS | AVERAGE COMPLETION (DAYS) |

  @C35714506
  Scenario: C35714506: My Third-party - Activity Metrics table - Verify Major Columns, Sub Columns and Rows
    When User selects Activity Metrics Tab
    And User selects My Third-party show option
    And Activity Metrics table is displayed with header column names
      | ALL ACTIVITIES | QUESTIONNAIRE | DUE DILIGENCE REPORTS |
    And Activity Metrics table is displayed with major column names
      | ASSIGNED | APPROVALS | REVIEWS | INTERNAL | EXTERNAL |
    And Activity Metrics table is displayed with minor column names
      | TOTAL ACTIVE | PAST DUE | DUE WITHIN 7 DAYS | DUE IN 8-14 DAYS | AVERAGE COMPLETION (DAYS) |

  @C35714480
  Scenario: C35714480: Dashboard Role Enabled - Verify that Activity Metrics tab is displayed (All Third-party)
    When User selects Activity Metrics Tab
    Then Activity Metrics tab Third-party drop down displays "All Third-party" value

  @C35714505
  Scenario: C35714505: Dashboard Role Enabled - Verify that Activity Metrics tab is displayed (My Third-party)
    When User selects Activity Metrics Tab
    And User selects My Third-party show option
    Then Activity Metrics tab Third-party drop down displays "My Third-party" value

  @C35741375
  Scenario: C35741375: Dashboard - Activity Metrics - Verify that Last Updated Label is displayed
    When User selects Activity Metrics Tab
    Then Activity Metrics update date is correct
