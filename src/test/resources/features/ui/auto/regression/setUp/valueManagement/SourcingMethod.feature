@ui @full_regression @value_management @sourcing_method
Feature: Value Management - Sourcing Method

  As a RDDC Administrator
  I want see the Sourcing Method Configured in the system
  So that I can review the Sourcing Method when needed

  @C36135679
  Scenario: C36135679: [Value Management Setup] Sourcing Method - Sourcing Method Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Sourcing Method" value
    Then Value Management "Sourcing Method" overview page is displayed
    And All expected Value Management Overview buttons are displayed
    And Value "Sourcing Method" container contains all default values
      | Purchased through distribution or agent from multiple sources |
      | Purchased through distribution or agent                       |
      | Directly sourced with no contract                             |
      | Directly sourced with contract in place                       |
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Sourcing Method" value
    And User clicks value "Sourcing Method" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    And User expands "Third-party Segmentation" section
    Then Add third-party "Sourcing Method" dropdown contains expected values
      | Purchased through distribution or agent from multiple sources |
      | Purchased through distribution or agent                       |
      | Directly sourced with no contract                             |
      | Directly sourced with contract in place                       |