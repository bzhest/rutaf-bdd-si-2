@ui @full_regression @value_management @affiliation
Feature: Value Management - Affiliation

  As a RDDC Administrator
  I want see the Affiliation Configured in the system
  So that I can review the Affiliation when needed

  @C36105759
  Scenario: C36105759: [Value Management Setup] Affiliation - Affiliation Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Affiliation" value
    Then Value Management "Affiliation" overview page is displayed
    And All expected Value Management Overview buttons are displayed
    And Value "Affiliation" container contains all default values
      | State Owned Entity |
      | Publicly Traded    |
      | Privately Held     |
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Affiliation" value
    And User clicks value "Affiliation" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    And User expands "General Information" section
    Then Add third-party "Affiliation" dropdown contains expected values
      | State Owned Entity |
      | Publicly Traded    |
      | Privately Held     |
