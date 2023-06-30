@ui @functional @dashboard @dashboardThirdPartyMetrics
Feature: Home Page - Dashboard Tabs

  As a user,
  I want a separate tab for Existing Dashboard, Supplier Metrics, and Activity Metrics in SI Dashboard Page.
  So that I can have a better UI design.


  @C35536048
  Scenario: C35536048: [RMS-6003] Dashboard - Verify 3 separate Tabs it should display My tasks, Third-party Metrics and Activity Metrics Tab
    Given User logs into RDDC as "Admin"
    Then Dashboard of Internal Users is displayed with the following tabs
      | MY TASKS            |
      | THIRD-PARTY METRICS |
      | ACTIVITY METRICS    |

  @C35741365
  Scenario: C35741365: Dashboard - Third-party Metrics - Verify that Last Updated Label is displayed
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab
    Then Dashboard Metrics Last Updated date is displayed in expected format

  @C35712953
  Scenario: C35712953: All Suppliers - Third Party Metrics - Verify Third Party Metrics tables when there is No Available Data
    Given User logs into RDDC as "Empty Metrics User"
    Then Dashboard of Internal Users is displayed with the following tabs
      | MY TASKS            |
      | THIRD-PARTY METRICS |
      | ACTIVITY METRICS    |
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

  @C35712954
  Scenario: C35712954: All Third Party- Third Party Metrics - Verify Pie and Bar charts when there is No Available Data
    Given User logs into RDDC as "Empty Metrics User"
    When User selects Third-party Metrics Tab
    Then Third-party Metrics "No Available Data" displayed for following bar charts
      | THIRD-PARTY VOLUME BY RISK TIER    |
      | ONBOARDING VOLUME BY STATUS        |
      | ONBOARDING CYCLE TIME BY RISK TIER |
      | PENDING RENEWAL BY RISK TIER       |
      | RENEWAL VOLUME BY STATUS           |
      | RENEWAL CYCLE TIME BY RISK TIER    |

  @C35712955
  Scenario: C35712955: My Third Party- Third Party Metrics - Verify Third Party Metrics tables when there is No Available Data
    Given User logs into RDDC as "Empty Metrics User"
    When User selects Third-party Metrics Tab
    And User selects My Third-party Third-party Metrics show option
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

  @C35712956
  Scenario: C35712956: My Third Party- Third Party Metrics - Verify Pie and Bar charts when there is No Available Data
    Given User logs into RDDC as "Empty Metrics User"
    When User selects Third-party Metrics Tab
    And User selects My Third-party Third-party Metrics show option
    Then Third-party Metrics "No Available Data" displayed for following bar charts
      | THIRD-PARTY VOLUME BY RISK TIER    |
      | ONBOARDING VOLUME BY STATUS        |
      | ONBOARDING CYCLE TIME BY RISK TIER |
      | PENDING RENEWAL BY RISK TIER       |
      | RENEWAL VOLUME BY STATUS           |
      | RENEWAL CYCLE TIME BY RISK TIER    |
