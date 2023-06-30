@ui @full_regression @value_management @industry_type
Feature: Value Management - Industry Type

  As a RDDC Administrator
  I want see the Industry Type Configured in the system
  So that I can review the Industry Type when needed

  @C36105327 @C36105596
  Scenario: C36105327, C36105596: [Value Management Setup] Industry Type - Industry Type Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Industry Type" value
    Then Value Management "Industry Type" overview page is displayed
    And "Industry Type" container contains all values in the system
    And All expected Value Management Overview buttons are displayed
    And Value Management Container are sorted in alphabetical order
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Industry Type" value
    And User clicks value "Industry Type" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    Then Add third-party "Industry Type" dropdown contains all sorted values
