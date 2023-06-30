@ui @robusta @bitsight @core_regression
Feature: BitSight

  As a RDDC User with right permissions
  I want to see BitSight section under Screening tab
  So that I can view BitSight information and do some other actions in the section

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks on "Screening" tab on Third-party page

  @C45133103
  Scenario: C45133103 - [BitSight Phase 1] Display BitSight section under Data providers tab - BitSight section should be available under Data Providers tab (renamed from Data Service Providers) after Risk Management tab
  permission to Business Overview
    Then Business Overview Tab is displayed
    When User clicks BitSight tab
    Then BitSight Tab is displayed