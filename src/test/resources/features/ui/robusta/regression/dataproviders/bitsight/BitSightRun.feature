@ui @robusta @business_overview @core_regression
Feature: BitSight

  As a RDDC User with appropriate permissions
  I want to see BitSight tab/section with 'Run' button

  @C45266112
  Scenario: C45266112 - [BitSight Phase 1] BitSight section "Run" button-Verify that the search  button is present in bitsight tab when the serach is not started
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks on "Screening" tab on Third-party page
    Then Business Overview Tab is displayed
    When User clicks BitSight tab
    Then BitSight Tab is displayed
    And BitSight Run Button is displayed