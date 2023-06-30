@ui @full_regression @value_management @relationship_visibility
Feature: Value Management - Relationship Visibility

  As a RDDC Administrator
  I want see the Relationship Visibility Configured in the system
  So that I can review the Relationship Visibility when needed

  @C36107026
  Scenario: C36107026: [Value Management Setup] Relationship Visibility - Relationship Visibility Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Relationship Visibility" value
    Then Value Management "Relationship Visibility" overview page is displayed
    And All expected Value Management Overview buttons are displayed
    And Value "Relationship Visibility" container contains all default values
      | Little to no visibility of relationship                 |
      | Products rebranded from Original Equipment Manufacturer |
      | Strategic Partner                                       |
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Relationship Visibility" value
    And User clicks value "Relationship Visibility" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    And User expands "Third-party Segmentation" section
    Then Add third-party "Relationship Visibility" dropdown contains expected values
      | Little to no visibility of relationship                 |
      | Products rebranded from Original Equipment Manufacturer |
      | Strategic Partner                                       |
