@ui @functional @dashboard @dashboardThirdPartyMetrics
Feature: Home Page - Third-party Metrics - Onboarding Metrics

  As a RDDC User
  I want to see a categorized count of all the partners in the system
  So that I can have an idea of the status of the different partners

  Background:
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab

  @C35382770
  Scenario: C35382770: [RMS-3522] Supplier Onboarding Metrics - Verify the Major columns and Sub columns
    Then Third-party Metrics Onboarding table is displayed with major column names
      | THIRD-PARTY VOLUME | ONBOARDING VOLUME | ONBOARDED | ONBOARDING CYCLE TIME (DAYS) |
    And Third-party Metrics Onboarding table is displayed with minor column names
      | RISK TIER | COUNT | PERCENT | NEW | IN PROGRESS | (LAST 90 DAYS) | LONGEST | SHORTEST | AVERAGE |

  @C35382771
  Scenario: C35382771: [RMS-3522] Supplier Onboarding Metrics - table should have the following Rows/Row Headers:HIGH, MED, LOW, TOTAL
    Then Third-party Metrics Onboarding table is displayed with risk tier column names
      | HIGH | MED | LOW | TOTAL |

  @C35382773
  Scenario: C35382773: [RMS-3522] Third-party Volume Count "HIGH" - Verify the value it should be match on the number of High Risk Tier (My Third-party)
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Volume Metrics third-parties with "High" risk score for USER is expected

  @C35382774
  Scenario: C35382774: [RMS-3522] Third-party Volume Count "MED" - Verify the value it should be match on the number of MED Risk Tier (My Third-party)
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Volume Metrics third-parties with "Med" risk score for USER is expected

  @C35382775
  Scenario: C35382775: [RMS-3522] Third-party Volume Count "LOW" - Verify the value it should be match on the number of LOW Risk Tier (My Third-party)
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Volume Metrics third-parties with "Low" risk score for USER is expected

  @C35382776
  Scenario: C35382776: [RMS-3522] Third-party Volume Count "HIGH" - Verify the value it should be match on the number of High Risk Tier (All Third-party)
    Then Third-party Volume Metrics third-parties with "High" risk score for DIVISION is expected

  @C35382777
  Scenario: C35382777: [RMS-3522] Third-party Volume Count "MED" - Verify the value it should be match on the number of MED Risk Tier (All Third-party)
    Then Third-party Volume Metrics third-parties with "Med" risk score for DIVISION is expected

  @C35382778
  Scenario: C35382778: [RMS-3522] Third-party Volume Count "LOW" - Verify the value it should be match on the number of LOW Risk Tier (All Third-party)
    Then Third-party Volume Metrics third-parties with "Low" risk score for DIVISION is expected

  @C35382779
  Scenario: C35382779: [RMS-3522] Third Party Volume Count - Total - Verify This cell should contain the total number of Third Party that are currently in the system based on "All Third Party" filter
    Then Third-party Onboarding Metric total count for "COUNT" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C35382780
  Scenario: C35382780: [RMS-3522] Third Party Volume Count - Total - Verify This cell should contain the total number of Third Party that are currently in the system based on "My Third Party" filter
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Onboarding Metric total count for "COUNT" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C35382781
  Scenario: C35382781: [RMS-3522] Third-party Volume Percentage "HIGH" - Verify the percentage HIGH Risk Tier Third-party based on "All Third-party"
    Then Third-party Volume Percentage is expected for risk "High Risk"

  @C35382782
  Scenario: C35382782: [RMS-3522] Third-party Volume Percentage "HIGH" - Verify the percentage HIGH Risk Tier Third-party based on "My Third-party"
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Volume Percentage is expected for risk "High Risk"

  @C35382783
  Scenario: C35382783: [RMS-3522] Third-party Volume Percentage "MED" - Verify the percentage of MED Risk Tier Third-party based on "All Third-party"
    Then Third-party Volume Percentage is expected for risk "Medium Risk"

  @C35382784
  Scenario: C35382784: [RMS-3522] Third-party Volume Percentage "MED" - Verify the percentage of MED Risk Tier Third-party based on "My Third-party"
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Volume Percentage is expected for risk "Medium Risk"

  @C35382785
  Scenario: C35382785: [RMS-3522] Third-party Volume Percentage "LOW" - Verify the percentage of LOW Risk Tier Third-party based on "All Third-party"
    Then Third-party Volume Percentage is expected for risk "Low Risk"

  @C35382786
  Scenario: C35382786: [RMS-3522] Third-party Volume Percentage "LOW" - Verify the percentage of LOW Risk Tier Third-party based on "My Third-party"
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Volume Percentage is expected for risk "Low Risk"

  @C35382787
  Scenario: C35382787: [RMS-3522] Third-party Volume - Verify "TOTAL" PERCENTAGE, IN PROGRESS, NEW, LONGEST, SHORTEST and AVERAGE columns should contain "-" value
    Then Onboarding Metrics table TOTAL is displayed with empty expected values
      | PERCENT     | - |
      | IN PROGRESS | - |
      | NEW         | - |
      | LONGEST     | - |
      | SHORTEST    | - |
      | AVERAGE     | - |

  @C35382788
  Scenario: C35382788: [RMS-3522] Onboarding Volume - HIGH- Verify the value should contain the number of HIGH Risk Tier Third-party (My Third-party)
    When User selects My Third-party Third-party Metrics show option
    Then Third-party New status Metrics third-parties with "High" risk score for USER is expected

  @C35382789
  Scenario: C35382789: [RMS-3522] Onboarding Volume - MED- Verify the value should contain the number of MED Risk Tier Third-party (My Third-party)
    When User selects My Third-party Third-party Metrics show option
    Then Third-party New status Metrics third-parties with "Med" risk score for USER is expected

  @C35382790
  Scenario: C35382790: [RMS-3522] Onboarding Volume - LOW - Verify the value should contain the number of LOW Risk Tier Third-party (My Third-party)
    When User selects My Third-party Third-party Metrics show option
    Then Third-party New status Metrics third-parties with "Low" risk score for USER is expected

  @C35382791
  Scenario: C35382791: [RMS-3522] Onboarding Volume - HIGH - Verify the value should contain the number of HIGH Risk Tier Third-party (All Third-party)
    Then Third-party New status Metrics third-parties with "High" risk score for DIVISION is expected

  @C35382792
  Scenario: C35382792: [RMS-3522] Onboarding Volume - MED - Verify the value should contain the number of MED Risk Tier Third-party  (All Third-party)
    Then Third-party New status Metrics third-parties with "Med" risk score for DIVISION is expected

  @C35382793
  Scenario: C35382793: [RMS-3522] Onboarding Volume - LOW - Verify the value should contain the number of LOW Risk Tier Third-party (All Third-party)
    Then Third-party New status Metrics third-parties with "Low" risk score for DIVISION is expected

  @C35382794
  Scenario: C35382794: [RMS-3522] Onboarding Volume - HIGH - Verify the value should contain the number of HIGH Risk Tier Third-party (My Third-party)
    When User selects My Third-party Third-party Metrics show option
    Then Third-party In Progress status Metrics third-parties with "High" risk score for USER is expected

  @C35382795
  Scenario: C35382795: [RMS-3522] Onboarding Volume - MED - Verify the value should contain the number of MED Risk Tier Third-party (My Third-party)
    When User selects My Third-party Third-party Metrics show option
    Then Third-party In Progress status Metrics third-parties with "Med" risk score for USER is expected

  @C35382796
  Scenario: C35382796: [RMS-3522] Onboarding Volume - LOW - Verify the value should contain the number of LOW Risk Tier Third-party (My Third-party)
    When User selects My Third-party Third-party Metrics show option
    Then Third-party In Progress status Metrics third-parties with "Low" risk score for USER is expected

  @C35382797
  Scenario: C35382797: [RMS-3522] Onboarding Volume - HIGH - Verify the value should contain the number of HIGH Risk Tier Third-party (All Third-party)
    Then Third-party In Progress status Metrics third-parties with "High" risk score for DIVISION is expected

  @C35382798
  Scenario: C35382798: [RMS-3522] Onboarding Volume - MED - Verify the value should contain the number of MED Risk Tier Third-party (All Third-party)
    Then Third-party In Progress status Metrics third-parties with "Med" risk score for DIVISION is expected

  @C35382799
  Scenario: C35382799: [RMS-3522] Onboarding Volume - LOW - Verify the value should contain the number of LOW Risk Tier Third-party (All Third-party)
    Then Third-party In Progress status Metrics third-parties with "Low" risk score for DIVISION is expected

  @C35506790
  Scenario: C35506790: RMS-3522 High - Onboarded last 90 days - Verify this cell should contain High Risk tier Third-party that turned from "ONBOARDING" to "Onboarded" status in the last 90 Days based on "ALL Third-party" filter
    Then Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "High" risk score for DIVISION is expected

  @C35506791
  Scenario: C35506791: RMS-3522 Medium - Onboarded last 90 days - Verify this cell should contain Medium Risk tier Suppliers that turned from "ONBOARDING" to "Onboarded" status in the last 90 Days based on "ALL suppliers" filter
    Then Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "Med" risk score for DIVISION is expected

  @C35506792
  Scenario: C35506792: RMS-3522 LOW - Onboarded last 90 days - Verify this cell should contain Medium Risk tier Third-party that turned from "ONBOARDING" to "Onboarded" status in the last 90 Days based on "ALL Third-party" filter
    Then Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "Low" risk score for DIVISION is expected

  @C35506793
  Scenario: C35506793: RMS-3522 HIGH - Onboarded last 90 days - Verify this cell should contain Medium Risk tier Third-party that turned from "ONBOARDING" to "Onboarded" status in the last 90 Days based on "MY Third-party" filter
    When User selects My Third-party Third-party Metrics show option
    Then Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "High" risk score for USER is expected

  @C35506794
  Scenario: C35506794: RMS-3522MEDIUM - Onboarded last 90 days - Verify this cell should contain Medium Risk tier Third-party that turned from "ONBOARDING" to "Onboarded" status in the last 90 Days based on "MY Third-party" filter
    When User selects My Third-party Third-party Metrics show option
    Then Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "Med" risk score for USER is expected

  @C35506795
  Scenario: C35506795: RMS-3522LOW - Onboarded last 90 days - Verify this cell should contain Medium Risk tier Third-party that turned from "ONBOARDING" to "Onboarded" status in the last 90 Days based on "MY Third-party" filter
    When User selects My Third-party Third-party Metrics show option
    Then Onboarding Metrics for column "(LAST 90 DAYS)" third-parties with "Low" risk score for USER is expected

  @C35506796
  Scenario: C35506796: RMS-3522 Total - Onboarded last 90 days - Verify the total number of Third-party that turned from "ONBOARDING" to "Onboarded" status in the Last 90 days based on "MY Third-party" filter
    When User selects My Third-party Third-party Metrics show option
    Then Third-party Onboarding Metric total count for "(LAST 90 DAYS)" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C35506797
  Scenario: C35506797: RMS-3522 Total - Onboarded last 90 days - Verify the total number of Third-party that turned from "ONBOARDING" to "Onboarded" status in the Last 90 days based on "ALL Third-party" filter
    Then Third-party Onboarding Metric total count for "(LAST 90 DAYS)" column contains values for third-parties with risk scores
      | HIGH |
      | MED  |
      | LOW  |

  @C35522851
  Scenario: C35522851: RMS-3522 Verify Onboarding Cycle Time (Days) Table
    Then Onboarding cycle time for DIVISION contains expected value for all columns for all Risk Tiers
    When User selects My Third-party Third-party Metrics show option
    Then Onboarding cycle time for USER contains expected value for all columns for all Risk Tiers

  @C35522852
  Scenario: C35522852: RMS-3522 Verify Onboarding Cycle Time (Days) Table
    Then Onboarding Metrics table TOTAL is displayed with empty expected values
      | LONGEST  | - |
      | SHORTEST | - |
      | AVERAGE  | - |
    When User selects My Third-party Third-party Metrics show option
    Then Onboarding Metrics table TOTAL is displayed with empty expected values
      | LONGEST  | - |
      | SHORTEST | - |
      | AVERAGE  | - |
