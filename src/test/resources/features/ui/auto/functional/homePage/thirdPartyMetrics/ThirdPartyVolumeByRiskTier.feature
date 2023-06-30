@ui @functional @dashboard @dashboardThirdPartyMetrics
Feature: Home Page - Third-party Metrics - Third-party Volume by Risk Tier

  Background:
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab

  @C35519566
  Scenario: C35519566: [RMS-3526] Verify there's should be a pie chart Named "Third-party Volume by Risk Tier"
    Then Third-party metrics bar graph with label Named Third-party Volume by Risk Tier is displayed
