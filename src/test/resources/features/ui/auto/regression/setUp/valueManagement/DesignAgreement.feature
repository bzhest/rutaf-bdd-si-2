@ui @full_regression @value_management @design_agreement
Feature: Value Management - Design Agreement

  As a Supplier Integrity Administrator
  I want see the Design Agreements Configured in the system
  So that I can review the Design Agreements when needed

  @C36136571
  Scenario: C36136571: [Value Management Setup] Design Agreement - Design Agreement Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Design Agreement" value
    Then Value Management "Design Agreement" overview page is displayed
    And All expected Value Management Overview buttons are displayed
    And Value "Design Agreement" container contains all default values
      | Products purchased off the shelf                            |
      | Spec owned by supplier but qualified by the business        |
      | Design created by our organisation, IP shared with supplier |
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Design Agreement" value
    And User clicks value "Design Agreement" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    And User expands "Third-party Segmentation" section
    Then Add third-party "Design Agreement" dropdown contains expected values
      | Products purchased off the shelf                            |
      | Spec owned by supplier but qualified by the business        |
      | Design created by our organisation, IP shared with supplier |
