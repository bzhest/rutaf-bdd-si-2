@ui @robusta @business_overview
Feature: Business Overview

  As a RDDC User with appropriate permissions
  I want to Business Overview section with 'Run' button in Third-party Information/Data Provider
  So that I can search Business Overview in order to get more third party information

  @C50571221
  Scenario: C50571221 - Business Overview - Search Result with No Previous result - Run button - Verify that 'Run' button is displayed
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks on "Data Providers" tab on Third-party page
    Then Business Overview Run Button is displayed
