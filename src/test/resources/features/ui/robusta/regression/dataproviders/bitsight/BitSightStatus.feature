@ui @robusta @business_overview @core_regression
Feature: BitSight

  As a RDDC User with appropriate permissions
  I want to see BitSight tab/section with 'Run' button
  So that I can click and search BitSight in order to get more third party information

  @C45396117
  Scenario: C45396117 - BitSight Section - Display Search Results - Search not yet run
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks on "Screening" tab on Third-party page
    Then Business Overview Tab is displayed
    When User clicks BitSight tab
    Then BitSight Tab is displayed
    And BitSight Search Date value is "--"
    And BitSight Status value is "Status: --"
    And BitSight Run Button is enabled

