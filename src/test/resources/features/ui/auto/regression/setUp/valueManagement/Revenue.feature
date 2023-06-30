@ui @full_regression @value_management @revenue
Feature: Value Management - Revenue

  As a RDDC Administrator
  I want see the Revenue Configured in the system
  So that I can review the Revenue when needed

  @C36105897
  Scenario: C36105897: [Value Management Setup] Revenue - Revenue Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Revenue" value
    Then Value Management "Revenue" overview page is displayed
    And All expected Value Management Overview buttons are displayed
    And Value "Revenue" container contains all default values
      | Private company revenue unknown            |
      | Less than 10 million in annual revenue     |
      | 10 million to 20 million in annual revenue |
      | 20 to 50 million in annual revenue         |
      | 50 to 100 million in annual revenue        |
      | 100 to 500 million in annual revenue       |
      | 500 to 2 billion                           |
      | Greater than 2 billion                     |
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Revenue" value
    And User clicks value "Revenue" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    And User expands "General Information" section
    Then Add third-party "Revenue" dropdown contains expected values
      | Private company revenue unknown            |
      | Less than 10 million in annual revenue     |
      | 10 million to 20 million in annual revenue |
      | 20 to 50 million in annual revenue         |
      | 50 to 100 million in annual revenue        |
      | 100 to 500 million in annual revenue       |
      | 500 to 2 billion                           |
      | Greater than 2 billion                     |
