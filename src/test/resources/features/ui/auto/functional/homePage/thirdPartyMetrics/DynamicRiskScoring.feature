@ui @functional @dashboard @dashboardThirdPartyMetrics
Feature: Home Page - Third-party Metrics - Dynamic Risk Scoring

  Background:
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab


  @C46247502
  Scenario: C46247502: [Dynamic Risk Scoring] Dashboard Third-party Metrics - The first table - Display the color from Value Management - Risk Scoring Range
    Then Third-party Metrics Onboarding table Risk Tier columns color are expected
      | High |
      | Med  |
      | Low  |

  @C46247503
  Scenario: C46247503: [Dynamic Risk Scoring] Dashboard Third-party Metrics - The second table - Display the color from Value Management - Risk Scoring Range
    Then Third-party Metrics Renewal table Risk Tier columns color are expected
      | High |
      | Med  |
      | Low  |
