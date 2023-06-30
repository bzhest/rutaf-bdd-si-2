@ui @full_regression @value_management @currency
Feature: Value Management - Currency

  As a RDDC Administrator
  I want see the Currencies Configured in the system
  So that I can review the Currencies when needed

  @C36107096
  @core_regression
  Scenario: C36107096: [Value Management Setup] Currency - Currency Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Currency" value
    Then Value Management "Currency" overview page is displayed
    And "Currency" container contains all values in the system
    And All expected Value Management Overview buttons are displayed
    And Current URL contains "/ui/admin/value-management/" endpoint
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Currency" value
    And User clicks value "Currency" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    Then Add third-party Currency dropdown contains expected values
    When User fills third-party creation form with third-party's test data "with random ID name"
    And User submits Third-party creation form
    Then User verifies third-party is created
    When User clicks General and Other Information section "Edit" button
    Then Add third-party Currency dropdown contains expected values
