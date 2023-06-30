@ui @full_regression @dashboard @dashboardSupplierMetrics
Feature: Third-party Metrics - Onboarding

  @C36269127
  Scenario: C36269127: [Dashboard enh.] Supplier Metrics - Onboarded last 90 days - Verify this cell contains High/Medium/Low Risk tier Suppliers that turned from "ONBOARDING" to "Onboarded" status in the last 90 Days based on "MY suppliers" filter
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    And User selects My Third-party Third-party Metrics show option
    Then Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "High" risk score for USER is expected
    And Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "Med" risk score for USER is expected
    And Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "Low" risk score for USER is expected
    And Third-party Onboarding Metric total count for "(LAST 90 DAYS)" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C36269130
  Scenario: C36269130: [Dashboard enh.] Supplier Metrics - Onboarded last 90 days - Verify this cell contains High/Medium/Low Risk tier Suppliers that turned from "ONBOARDING" to "Onboarded" status in the last 90 Days based on "All suppliers" filter
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    Then Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "High" risk score for DIVISION is expected
    And Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "Med" risk score for DIVISION is expected
    And Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "Low" risk score for DIVISION is expected
    And Third-party Onboarding Metric total count for "(LAST 90 DAYS)" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C36269140
  Scenario: C36269140: [Dashboard enh.] Supplier Metrics - Verify Onboarding Cycle Time (Days) Table
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    Then Third-party Metrics Onboarding table is displayed with minor column names
      | RISK TIER | COUNT | PERCENT | NEW | IN PROGRESS | (LAST 90 DAYS) | LONGEST | SHORTEST | AVERAGE |
    And Onboarding cycle time for DIVISION contains expected value for all columns for all Risk Tiers
    When User selects My Third-party Third-party Metrics show option
    Then Onboarding cycle time for USER contains expected value for all columns for all Risk Tiers

  @C36265444
  Scenario: C36265444: [Dashboard enh.] Supplier Metrics - Verify that Supplier Metrics page has correct content and view
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    Then Third-party Metrics Onboarding table is displayed with major column names
      | THIRD-PARTY VOLUME | ONBOARDING VOLUME | ONBOARDED | ONBOARDING CYCLE TIME (DAYS) |
    And Third-party Metrics Renewal table is displayed with major column names
      | RISK TIER | 30 DAYS | 90 DAYS | FOR RENEWAL | RENEWING | (LAST 90 DAYS) | LONGEST | SHORTEST | AVERAGE |
    And Dashboard Metrics filter drop-down contains options
      | All Third-party |
      | My Third-party  |
    And Third-party metrics bar graph with label "Third-party Volume by Risk Tier" is displayed
    And Third-party metrics bar graph with label "Onboarding Volume by Status" is displayed
    And Third-party metrics bar graph with label "Onboarding Cycle Time by Risk Tier" is displayed
    And Third-party metrics bar graph with label "Pending Renewal by Risk Tier" is displayed
    And Third-party metrics bar graph with label "Renewal Volume by Status" is displayed
    And Third-party metrics bar graph with label "Renewal Cycle Time by Risk Tier" is displayed
    And Dashboard Metrics Last Updated date is displayed in expected format
    And Third-party Metrics Onboarding table is displayed with risk tier column names
      | HIGH | MED | LOW | TOTAL |
    And Onboarding Metrics table TOTAL is displayed with empty expected values
      | PERCENT     | - |
      | IN PROGRESS | - |
      | NEW         | - |
      | LONGEST     | - |
      | SHORTEST    | - |
      | AVERAGE     | - |
    And Third-party Metrics Renewal table is displayed with minor column names
      | HIGH | MED | LOW | TOTAL |
    And Renewal Metrics table TOTAL is displayed with empty expected values
      | FOR RENEWAL | - |
      | RENEWING    | - |
      | LONGEST     | - |
      | SHORTEST    | - |
      | AVERAGE     | - |
    And Dashboard Metrics filter drop-down option "All Third-party" is selected

  @C36267750
  Scenario: C36267750: [Dashboard enh.] Supplier Metrics - Partner Volume - Verify that the values are matched on the number of HIGH/MED/LOW Risk Tier Suppliers that the user have access based on "My Suppliers" Filter
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    And User selects My Third-party Third-party Metrics show option
    Then Third-party Volume Metrics third-parties with "High" risk score for USER is expected
    And Third-party Volume Metrics third-parties with "Med" risk score for USER is expected
    And Third-party Volume Metrics third-parties with "Low" risk score for USER is expected
    And Third-party Onboarding Metric total count for "COUNT" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C36268789
  Scenario: C36268789: [Dashboard enh.] Supplier Metrics - Partner Volume - Verify that the values are matched on the number of HIGH/MED/LOW Risk Tier Suppliers that the user have access based on "All Suppliers" Filter
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    Then Third-party Volume Metrics third-parties with "High" risk score for DIVISION is expected
    And Third-party Volume Metrics third-parties with "Med" risk score for DIVISION is expected
    And Third-party Volume Metrics third-parties with "Low" risk score for DIVISION is expected
    And Third-party Onboarding Metric total count for "COUNT" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C36269106
  Scenario: C36269106: [Dashboard enh.] Supplier Metrics - Onboarding Volume - Verify the value contains the number of HIGH/MED/LOW Risk Tier Suppliers that are in "New"/"Onboarding" status based on "My Suppliers" filter
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    And User selects My Third-party Third-party Metrics show option
    Then Third-party New status Metrics third-parties with "High" risk score for USER is expected
    And Third-party New status Metrics third-parties with "Med" risk score for USER is expected
    And Third-party New status Metrics third-parties with "Low" risk score for USER is expected

  @C36269115
  Scenario: C36269115: [Dashboard enh.] Supplier Metrics - Onboarding Volume - Verify the value contains the number of HIGH/MED/LOW Risk Tier Suppliers that are in "New"/"Onboarding" status based on "All Suppliers" filter
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    Then Third-party New status Metrics third-parties with "High" risk score for DIVISION is expected
    And Third-party New status Metrics third-parties with "Med" risk score for DIVISION is expected
    And Third-party New status Metrics third-parties with "Low" risk score for DIVISION is expected

  @C36270907
  Scenario: C36270907: [Dashboard enh.] Supplier Metrics - Verify Supplier Metrics page when there is No Available Data
    Given User logs into RDDC as "Empty Metrics User"
    When User selects Third-party Metrics Tab
    Then Third-party Metrics table is displayed with empty results
    And Onboarding Metrics table TOTAL is displayed with empty expected values
      | COUNT          | 0 |
      | PERCENT        | - |
      | IN PROGRESS    | - |
      | NEW            | - |
      | (LAST 90 DAYS) | 0 |
      | LONGEST        | - |
      | SHORTEST       | - |
      | AVERAGE        | - |
    And Renewal Metrics table TOTAL is displayed with empty expected values
      | 30 DAYS        | 0 |
      | 90 DAYS        | 0 |
      | FOR RENEWAL    | - |
      | RENEWING       | - |
      | (LAST 90 DAYS) | 0 |
      | LONGEST        | - |
      | SHORTEST       | - |
      | AVERAGE        | - |
    And Third-party Metrics "No Available Data" displayed for following bar charts
      | THIRD-PARTY VOLUME BY RISK TIER    |
      | ONBOARDING VOLUME BY STATUS        |
      | ONBOARDING CYCLE TIME BY RISK TIER |
      | PENDING RENEWAL BY RISK TIER       |
      | RENEWAL VOLUME BY STATUS           |
      | RENEWAL CYCLE TIME BY RISK TIER    |
