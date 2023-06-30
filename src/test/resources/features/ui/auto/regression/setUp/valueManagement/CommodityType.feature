@ui @full_regression @value_management @commodity_type
Feature: Value Management - Commodity Type

  As a RDDC Administrator
  I want see the Commodity Type Configured in the system
  So that I can review the Commodity Type when needed

  @C36136325
  Scenario: C36136325: [Value Management Setup] Commodity Type - Commodity Type Overview
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Commodity Type" value
    Then Value Management "Commodity Type" overview page is displayed
    And All expected Value Management Overview buttons are displayed
    And Value "Commodity Type" container contains all default values
      | 3PL Services                  |
      | Accreditation services        |
      | Building Maintenance          |
      | Cleaning                      |
      | Clinical Services             |
      | Clinical Trials               |
      | Company Registration Services |
      | Consumables                   |
      | Customized parts              |
      | Electricity                   |
      | Employee Benefit              |
      | External Machine building     |
      | FTL/LTL Distribution          |
      | Housing                       |
      | Laboratory Equipment          |
      | Logistics Consultancy         |
      | Maintenance and spare parts   |
      | Mechanical Units              |
      | New Buildings                 |
      | Non-BOM packaging             |
      | Office Supplies               |
      | Oil & Gas                     |
      | Parcel Distribution           |
      | Patent & Trademark Reg. Serv. |
      | Postage                       |
      | Recruitment                   |
      | Rent MRO                      |
      | Sales & Product training      |
      | Sea and Air Distribution      |
      | Security                      |
      | Shop Supplies                 |
      | Spare Parts, Components       |
      | Subject Matter Experts        |
      | Temporary Labour              |
      | Travel Agency                 |
      | Visa Services                 |
      | Warehouse Equipment           |
      | Waste handling                |
      | Water                         |
      | Workwear                      |
    When User clicks Cancel button for Value
    Then Value Management overview page is displayed
    When User clicks "Commodity Type" value
    And User clicks value "Commodity Type" breadcrumb
    Then Value Management overview page is displayed
    When User opens third-party creation form
    And User expands "Third-party Segmentation" section
    Then Add third-party "Commodity Type" dropdown contains expected values
      | 3PL Services                  |
      | Accreditation services        |
      | Building Maintenance          |
      | Cleaning                      |
      | Clinical Services             |
      | Clinical Trials               |
      | Company Registration Services |
      | Consumables                   |
      | Customized parts              |
      | Electricity                   |
      | Employee Benefit              |
      | External Machine building     |
      | FTL/LTL Distribution          |
      | Housing                       |
      | Laboratory Equipment          |
      | Logistics Consultancy         |
      | Maintenance and spare parts   |
      | Mechanical Units              |
      | New Buildings                 |
      | Non-BOM packaging             |
      | Office Supplies               |
      | Oil & Gas                     |
      | Parcel Distribution           |
      | Patent & Trademark Reg. Serv. |
      | Postage                       |
      | Recruitment                   |
      | Rent MRO                      |
      | Sales & Product training      |
      | Sea and Air Distribution      |
      | Security                      |
      | Shop Supplies                 |
      | Spare Parts, Components       |
      | Subject Matter Experts        |
      | Temporary Labour              |
      | Travel Agency                 |
      | Visa Services                 |
      | Warehouse Equipment           |
      | Waste handling                |
      | Water                         |
      | Workwear                      |
