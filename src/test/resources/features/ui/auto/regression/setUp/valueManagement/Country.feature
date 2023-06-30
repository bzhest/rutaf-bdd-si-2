@ui @full_regression @value_management @country
Feature: Value Management - Country

  As a RDDC Administrator
  I want see the Country Configured in the system
  So that I can review the Country when needed

  @C36105283
  Scenario: C36105283: [Value Management Setup] Country Overview - Verify that Country overview page has correct content and view
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Country" value
    Then Value Management "Country" overview page is displayed
    And "Country" container contains all values in the system
    And All expected Value Management Overview buttons are displayed
    And Value Management Container are sorted in alphabetical order
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Country" value
    And User clicks value "Country" breadcrumb
    Then Value Management overview page is displayed