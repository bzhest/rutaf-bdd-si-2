@ui @functional @dashboard @dashboardThirdPartyMetrics
Feature: Home Page - Third-party Metrics - Onboarding Volume by Status

  As a RDDC User
  I want to see a visual representation of the number of partners that are New and In Progress
  So that I can have an Idea of the work that needs to be done to process all the Partners

  Background:
    Given User logs into RDDC as "Admin"
    When User selects Third-party Metrics Tab

  @C35519574
  Scenario: C35519574: [RMS-3534] Verify there's should be a Bar Graph Named "Onboarding Volume by Status"
    Then Third-party metrics bar graph with label Named Onboarding Volume by Status is displayed
