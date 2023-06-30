@ui @full_regression @value_management @business_category
Feature: Value Management - Business Category

  As a RDDC Administrator
  I want see the Business Type Configured in the system
  So that I can review the Business Type when needed

  @C36105674
  Scenario: C36105674: [Value Management Setup] Business Type - Business Type Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Business Category" value
    Then Value Management "Business Category" overview page is displayed
    And All expected Value Management Overview buttons are displayed
    And Value "Business Category" container contains all default values
      | Property & Structure                 |
      | Life and Health                      |
      | Business Coverages                   |
      | Misc.                                |
      | Print Advertising                    |
      | Broadcast Advertising                |
      | Product Marketing                    |
      | Military                             |
      | Commercial                           |
      | Private                              |
      | Production                           |
      | Sales and Distribution               |
      | Gov/SOE                              |
      | Public Entities                      |
      | Extraction                           |
      | Production and Refining              |
      | Distribution                         |
      | Sales                                |
      | Accounting and Auditing              |
      | Asset Management-Private             |
      | Asset Management-Public, include SWF |
      | Testing and Clinical Trials          |
      | Charitable                           |
      | International only                   |
      | Financing                            |
      | Marketing                            |
      | Development                          |
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Business Category" value
    And User clicks value "Business Category" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    And User fills third-party creation form with third-party's test data "belizeWithApproverWithIndustryType"
    And User expands "General Information" section
    Then Add third-party "Business Category" dropdown contains expected values
      | Military   |
      | Commercial |
      | Private    |
