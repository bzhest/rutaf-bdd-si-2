@ui @full_regression @value_management @product_impact
Feature: Value Management - Product Impact

  As a RDDC Administrator
  I want see the Product Impact Configured in the system
  So that I can review the Product Impact when needed

  @C36136206
  Scenario: C36136206: [Value Management Setup] Product Impact - Product Impact Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Product Impact" value
    Then Value Management "Product Impact" overview page is displayed
    And All expected Value Management Overview buttons are displayed
    And Value "Product Impact" container contains all default values
      | Commoditized product                            |
      | Alternate sources require qualification process |
      | Strategic partner                               |
      | Critical to business                            |
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Product Impact" value
    And User clicks value "Product Impact" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    And User expands "Third-party Segmentation" section
    Then Add third-party "Product Impact" dropdown contains expected values
      | Commoditized product                            |
      | Alternate sources require qualification process |
      | Strategic partner                               |
      | Critical to business                            |