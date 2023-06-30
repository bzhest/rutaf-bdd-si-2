@ui @full_regression @dashboard @dashboardSupplierMetrics
Feature: Third-party Metrics - Renewal

  Background:
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab

  @C36269161
  Scenario: C36269161: [Dashboard enh.] Supplier Metrics - Verify Pending Renewals table Due in 30 Days based on ALL Suppliers filter
    Then Third-party Renewal "30 DAYS" Metrics third-parties with "High" risk score for DIVISION is expected
    And Third-party Renewal "30 DAYS" Metrics third-parties with "Med" risk score for DIVISION is expected
    And Third-party Renewal "30 DAYS" Metrics third-parties with "Low" risk score for DIVISION is expected
    And Third-party Renewal Metric total count for "30 DAYS" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C36269162
  Scenario: C36269162: [Dashboard enh.] Supplier Metrics - Verify Pending Renewals table Due in 30 Days based on My Suppliers filter
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Renewal "30 DAYS" Metrics third-parties with "High" risk score for USER is expected
    And Third-party Renewal "30 DAYS" Metrics third-parties with "Med" risk score for USER is expected
    And Third-party Renewal "30 DAYS" Metrics third-parties with "Low" risk score for USER is expected
    And Third-party Renewal Metric total count for "30 DAYS" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C36269237
  Scenario: C36269237: [Dashboard enh.] Supplier Metrics - Verify Pending Renewals table Due in 90 Days based on ALL Suppliers filter
    Then Third-party Renewal "90 DAYS" Metrics third-parties with "High" risk score for DIVISION is expected
    And Third-party Renewal "90 DAYS" Metrics third-parties with "Med" risk score for DIVISION is expected
    And Third-party Renewal "90 DAYS" Metrics third-parties with "Low" risk score for DIVISION is expected
    And Third-party Renewal Metric total count for "30 DAYS" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C36269238
  Scenario: C36269238: [Dashboard enh.] Supplier Metrics - Verify Pending Renewals table Due in 90 Days based on My Suppliers filter
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Renewal "90 DAYS" Metrics third-parties with "High" risk score for USER is expected
    And Third-party Renewal "90 DAYS" Metrics third-parties with "Med" risk score for USER is expected
    And Third-party Renewal "90 DAYS" Metrics third-parties with "Low" risk score for USER is expected
    And Third-party Renewal Metric total count for "30 DAYS" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C36269278
  Scenario: C36269278: [To clarify][Dashboard enh.] Supplier Metrics - Verify Renewal Cycle Time Days Table
    Then Third-party Metrics Renewal table is displayed with major column names
      | RISK TIER | 30 DAYS | 90 DAYS | FOR RENEWAL | RENEWING | (LAST 90 DAYS) | LONGEST | SHORTEST | AVERAGE |
    And Renewal cycle time for DIVISION contains expected value for all columns for all Risk Tiers
    When User selects My Third-party Third-party Metrics show option
    Then Renewal cycle time for USER contains expected value for all columns for all Risk Tiers

  @C36269279
  Scenario: C36269279: [Dashboard enh.] Supplier Metrics - Renewing Volume Table - Verify the "Renewing"/"for Renewal" column based on ALL Suppliers filter
    Then Third-party Renewal "RENEWING" Metrics third-parties with "High" risk score for DIVISION is expected
    And Third-party Renewal "RENEWING" Metrics third-parties with "Med" risk score for DIVISION is expected
    And Third-party Renewal "RENEWING" Metrics third-parties with "Low" risk score for DIVISION is expected
    And Third-party Renewal "FOR RENEWAL" Metrics third-parties with "High" risk score for DIVISION is expected
    And Third-party Renewal "FOR RENEWAL" Metrics third-parties with "Med" risk score for DIVISION is expected
    And Third-party Renewal "FOR RENEWAL" Metrics third-parties with "Low" risk score for DIVISION is expected

  @C36640417
  Scenario: C36640417: [Dashboard enh.] Supplier Metrics - Renewing Volume Table - Verify the "Renewing"/"for Renewal" column based on My Suppliers filter
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Renewal "RENEWING" Metrics third-parties with "High" risk score for USER is expected
    And Third-party Renewal "RENEWING" Metrics third-parties with "Med" risk score for USER is expected
    And Third-party Renewal "RENEWING" Metrics third-parties with "Low" risk score for USER is expected
    And Third-party Renewal "FOR RENEWAL" Metrics third-parties with "High" risk score for USER is expected
    And Third-party Renewal "FOR RENEWAL" Metrics third-parties with "Med" risk score for USER is expected
    And Third-party Renewal "FOR RENEWAL" Metrics third-parties with "Low" risk score for USER is expected
