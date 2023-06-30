@ui @full_regression @value_management @sourcing_type
Feature: Value Management - Sourcing Type

  As a RDDC Administrator
  I want see the Sourcing Type Configured in the system
  So that I can review the Sourcing Type when needed

  @C36135798
  Scenario: C36135798: [Value Management Setup] Sourcing Type - Sourcing Type Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Sourcing Type" value
    Then Value Management "Sourcing Type" overview page is displayed
    And All expected Value Management Overview buttons are displayed
    And Value "Sourcing Type" container contains all default values
      | Multiple sources available |
      | Single sourced             |
      | Sole sourced               |
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Sourcing Type" value
    And User clicks value "Sourcing Type" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    And User expands "Third-party Segmentation" section
    Then Add third-party "Sourcing Type" dropdown contains expected values
      | Multiple sources available |
      | Single sourced             |
      | Sole sourced               |
