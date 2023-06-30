@ui @full_regression @value_management @company_type
Feature: Value Management - Company Type

  As a RDDC Administrator
  I want see the Company Type Configured in the system
  So that I can review the Company Type when needed

  @C36136372
  Scenario: C36136372: [Value Management Setup] Company Type - Company Type Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Company Type" value
    Then Value Management "Company Type" overview page is displayed
    And All expected Value Management Overview buttons are displayed
    And Value "Company Type" container contains all default values
      | Corporation           |
      | Company               |
      | Cooperation           |
      | Single Proprietorship |
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Company Type" value
    And User clicks value "Company Type" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    And User expands "General Information" section
    Then Add third-party "Company Type" dropdown contains expected values
      | Corporation           |
      | Company               |
      | Cooperation           |
      | Single Proprietorship |
