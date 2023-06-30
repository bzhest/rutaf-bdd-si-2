@ui @full_regression @value_management @organisation_size
Feature: Value Management - Organisation Size

  As a RDDC Administrator
  I want see the Organisation Size Configured in the system
  So that I can review the Organisation Size when needed

  @C36136580
  Scenario: C36136580: [Value Management Setup] Organisation Size - Organisation Size Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Organisation Size" value
    Then Value Management "Organisation Size" overview page is displayed
    And All expected Value Management Overview buttons are displayed
    And Value "Organisation Size" container contains all default values
      | 1-10 employees        |
      | 11-50 employees       |
      | 51-200 employees      |
      | 201-500 employees     |
      | 501-1000 employees    |
      | 1001-5000 employees   |
      | 5001-10,000 employees |
      | 10,001+ employees     |
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Organisation Size" value
    And User clicks value "Organisation Size" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    And User expands "General Information" section
    Then Add third-party "Organisation Size" dropdown contains expected values
      | 1-10 employees        |
      | 11-50 employees       |
      | 51-200 employees      |
      | 201-500 employees     |
      | 501-1000 employees    |
      | 1001-5000 employees   |
      | 5001-10,000 employees |
      | 10,001+ employees     |
