@ui @full_regression @value_management @spend_category
Feature: Value Management - Spend Category

  As a RDDC Administrator
  I want see the Spend Category Configured in the system
  So that I can review the Spend Category when needed

  @C36136019
  Scenario: C36136019: [Value Management Setup] Spend Category - Spend Category Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Spend Category" value
    Then Value Management "Spend Category" overview page is displayed
    And All expected Value Management Overview buttons are displayed
    And Value "Spend Category" container contains all default values
      | One time spend          |
      | Regularly sourcing from |
      | Major spends supplier   |
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Spend Category" value
    And User clicks value "Spend Category" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    And User expands "Third-party Segmentation" section
    Then Add third-party "Spend Category" dropdown contains expected values
      | One time spend          |
      | Regularly sourcing from |
      | Major spends supplier   |
