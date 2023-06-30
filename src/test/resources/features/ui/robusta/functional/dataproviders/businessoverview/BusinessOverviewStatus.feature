@ui @robusta @business_overview
Feature: Business Overview

  As RDDC User with appropriate permissions
  I want to Business Overview section with 'Run' button in Third-party Information/Data Provider
  So that I can search Business Overview in order to get more third party information

  @C50542803
  Scenario: C50542803 - Business Overview- Run button - Verify the statuses when the Run button is not clicked yet
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks on "Data Providers" tab on Third-party page
    Then Business Overview Search Date value is "--"
    And Business Overview Run Button is enabled
    And Business Overview "Business overview has not started" message is displayed
