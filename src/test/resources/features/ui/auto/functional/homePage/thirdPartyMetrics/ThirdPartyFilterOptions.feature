@ui @functional @dashboard @dashboardThirdPartyMetrics
Feature: Home Page - Third-party Metrics - Filter Options

  As a RDDC User
  I want to filter the output of the charts in the Dashboard
  So that I can choose to see only the partners that I need to review

  Background:
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab

  @C35401493
  Scenario: C35401493: [RMS-3523] - Verify Filter dropdown should have " My Third-party" and "All Third-party" Filters
    Then Dashboard Metrics filter drop-down contains options
      | All Third-party |
      | My Third-party  |

  @C35401494
  Scenario: C35401494: [RMS-3523] - Check the default Filter , It should be "All Third-party"
    Then Dashboard Metrics filter drop-down option "All Third-party" is selected
