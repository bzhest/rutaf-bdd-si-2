@ui @functional @dashboard @dashboardThirdPartyMetrics
Feature: Home Page - Third-party Metrics - Renewal Metrics

  As a RDDC User
  I want to see a categorized count of all the partners for Renewal in the system
  So that I can have an idea of the status of the different partners

  Background:
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab

  @C35530546
  Scenario: C35530546: [RMS-3524] Dashboard - Verify Supplier Renewal Metrics Major Columns and Sub Columns and Rows
    Then Third-party Metrics Renewal table is displayed with header column names
      | PENDING RENEWAL | RENEWING VOLUME | RENEWED | RENEWAL CYCLE TIME (DAYS) |
    And Third-party Metrics Renewal table is displayed with major column names
      | RISK TIER | 30 DAYS | 90 DAYS | FOR RENEWAL | RENEWING | (LAST 90 DAYS) | LONGEST | SHORTEST | AVERAGE |
    And Third-party Metrics Renewal table is displayed with minor column names
      | HIGH | MED | LOW | TOTAL |

  @C35598335
  Scenario: C35598335: [RMS-3524] Dashboard - Renewing Volume Table - Verify the for Renewal column based on All Third-party Filter
    Then Third-party Renewal "FOR RENEWAL" Metrics third-parties with "High" risk score for DIVISION is expected
    And Third-party Renewal "FOR RENEWAL" Metrics third-parties with "Med" risk score for DIVISION is expected
    And Third-party Renewal "FOR RENEWAL" Metrics third-parties with "Low" risk score for DIVISION is expected

  @C35598343
  Scenario: C35598343: [RMS-3524] Dashboard - Renewing Volume Table - Verify the for Renewal column based on My Third-party Filter
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Renewal "FOR RENEWAL" Metrics third-parties with "High" risk score for USER is expected
    And Third-party Renewal "FOR RENEWAL" Metrics third-parties with "Med" risk score for USER is expected
    And Third-party Renewal "FOR RENEWAL" Metrics third-parties with "Low" risk score for USER is expected

  @C35598344
  Scenario: C35598344: [RMS-3524] Dashboard - Renewing Volume Table - Verify the Renewing column based on My Third-party Filter
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Renewal "RENEWING" Metrics third-parties with "High" risk score for USER is expected
    And Third-party Renewal "RENEWING" Metrics third-parties with "Med" risk score for USER is expected
    And Third-party Renewal "RENEWING" Metrics third-parties with "Low" risk score for USER is expected

  @C35598347
  Scenario: C35598347: [RMS-3524] Dashboard - Renewing Volume Table - Verify the "Renewing" column based on All Third-party Filter
    Then Third-party Renewal "RENEWING" Metrics third-parties with "High" risk score for DIVISION is expected
    And Third-party Renewal "RENEWING" Metrics third-parties with "Med" risk score for DIVISION is expected
    And Third-party Renewal "RENEWING" Metrics third-parties with "Low" risk score for DIVISION is expected

  @C35603178
  Scenario: C35603178: [RMS-3524] - Renewing Table Volume - Verify the total Renewing and for Renewal column and RENEWAL CYCLE TIME (DAYS) for shortest , longest, average
    Then Renewal Metrics table TOTAL is displayed with empty expected values
      | FOR RENEWAL | - |
      | RENEWING    | - |
      | LONGEST     | - |
      | SHORTEST    | - |
      | AVERAGE     | - |

  @C35530734
  Scenario: C35530734: RMS-3524 Dashboard - Verify Pending Renewals table Due in 30 Days based on ALL Third-party filter
    Then Third-party Renewal "30 DAYS" Metrics third-parties with "High" risk score for DIVISION is expected
    And Third-party Renewal "30 DAYS" Metrics third-parties with "Med" risk score for DIVISION is expected
    And Third-party Renewal "30 DAYS" Metrics third-parties with "Low" risk score for DIVISION is expected

  @C35548286
  Scenario: C35548286: RMS-3524 Dashboard - Verify Pending Renewals table Due in 30 Days based on My Third-party filter
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Renewal "30 DAYS" Metrics third-parties with "High" risk score for USER is expected
    And Third-party Renewal "30 DAYS" Metrics third-parties with "Med" risk score for USER is expected
    And Third-party Renewal "30 DAYS" Metrics third-parties with "Low" risk score for USER is expected

  @C35548290
  Scenario: C35548290: RMS-3524 Dashboard - Verify Pending Renewals table Due in 90 Days based on ALL Third-party filter
    Then Third-party Renewal "90 DAYS" Metrics third-parties with "High" risk score for DIVISION is expected
    And Third-party Renewal "90 DAYS" Metrics third-parties with "Med" risk score for DIVISION is expected
    And Third-party Renewal "90 DAYS" Metrics third-parties with "Low" risk score for DIVISION is expected

  @C35598329
  Scenario: C35598329: RMS-3524 Dashboard - Verify Pending Renewals table Due in 90 Days based on My Third-party filter
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Renewal "90 DAYS" Metrics third-parties with "High" risk score for USER is expected
    And Third-party Renewal "90 DAYS" Metrics third-parties with "Med" risk score for USER is expected
    And Third-party Renewal "90 DAYS" Metrics third-parties with "Low" risk score for USER is expected

  @C35603469
  Scenario: C35603469: RMS-3524 Dashboard - Verify the Renewed last 90 days column based on My Third-party Filter
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Renewal "(LAST 90 DAYS)" Metrics third-parties with "High" risk score for USER is expected
    And Third-party Renewal "(LAST 90 DAYS)" Metrics third-parties with "Med" risk score for USER is expected
    And Third-party Renewal "(LAST 90 DAYS)" Metrics third-parties with "Low" risk score for USER is expected
    And Third-party Renewal Metric total count for "(LAST 90 DAYS)" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C35614004
  Scenario: C35614004: RMS-3524 Dashboard - Verify the Renewed last 90 days column based on All Third-party Filter
    Then Third-party Renewal "(LAST 90 DAYS)" Metrics third-parties with "High" risk score for DIVISION is expected
    And Third-party Renewal "(LAST 90 DAYS)" Metrics third-parties with "Med" risk score for DIVISION is expected
    And Third-party Renewal "(LAST 90 DAYS)" Metrics third-parties with "Low" risk score for DIVISION is expected
    And Third-party Renewal Metric total count for "(LAST 90 DAYS)" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C35614012
  Scenario: C35614012: RMS-3524 Dashboard - Verify Renewal Cycle Time Days Table
    Then Renewal cycle time for DIVISION contains expected value for all columns for all Risk Tiers
    When User selects My Third-party Third-party Metrics show option
    Then Renewal cycle time for USER contains expected value for all columns for all Risk Tiers
    And Renewal Metrics table TOTAL is displayed with empty expected values
      | LONGEST  | - |
      | SHORTEST | - |
      | AVERAGE  | - |
    When User selects My Third-party Third-party Metrics show option
    Then Renewal Metrics table TOTAL is displayed with empty expected values
      | LONGEST  | - |
      | SHORTEST | - |
      | AVERAGE  | - |
