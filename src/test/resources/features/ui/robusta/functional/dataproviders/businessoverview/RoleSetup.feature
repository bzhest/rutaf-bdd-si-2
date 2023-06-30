@ui @robusta @business_overview
Feature: Set up of Business Overview

  As a RDDC User with right permissions
  I want to create/edit/view roles with Business Overview entitlement
  So that I can manage the Roles and their access as necessary

  @C234331535
  Scenario: C234331535 - Data Provider - Business Overview - Tenant Configuration - Verify tenant with permission to Business Overview
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When User clicks 'Add New Role' button
    Then User management breadcrumb "ROLE MANAGEMENT / ADD ROLE" is displayed
    And There are the following Role Management sections displayed
      | Third-party           |
      | Reports and Dashboard |
      | Set Up                |
      | Due Diligence Order   |
      | Data Providers        |
      | Bulk Processing       |
    And Toggle buttons can be switched on Role Management page
      | Business Overview Search|