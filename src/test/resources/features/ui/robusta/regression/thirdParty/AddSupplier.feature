@ui @suppliers @robusta
Feature: Third-party Information - Add Third-party

  As a RDDC User
  I want I want to be able to create new Third-parties
  So that I can process the Third-party that need to be Onboarded for the Organisation

  Background:
    Given User logs into RDDC as "Admin"

  @C35616136 @C38172830
  @full_regression @core_regression
  @RMS-28297
  Scenario: C35616136: Third Party - Add Third Party with complete details
    When Revert Fields management settings to defaults
    And User opens third-party creation form
#    TODO update step implementation when RMS-28297 will be fixed
    And User fills third-party creation form with third-party's test data "with Complete Details"
    And User submits Third-party creation form
    Then User verifies third-party is created
    And Third-party Information details are displayed with populated data
    And Third-party's status should be shown - "NEW"
    And Third-party's Risk Tier should be shown - "LOW"
    And Third-party's Overall Risk Score should be generated - "2.5"
    When User navigates to Third-party page
    Then Third-party with name "toBeReplaced" is displayed in Third-party overview table
    When User clicks on created third-party
    Then Third-party Information details are displayed with populated data
    When User navigates to Third-party page
    And User searches third-party with name "toBeReplaced"
    Then Third-party with name "toBeReplaced" is displayed in Third-party overview table

  @C35619360 @C38363924
  @full_regression
  @RMS-28297
  Scenario: C35619360: Supplier - Add Supplier - validation for Reference Number
    When Revert Fields management settings to defaults
    And User opens third-party creation form
    #    TODO update step implementation when RMS-28297 will be fixed
    When User fills third-party creation form with third-party's test data "with Complete Details"
    And User submits Third-party creation form
    Then User verifies third-party is created
    When User navigates to Third-party page
    And User opens third-party creation form
    And User fills in Reference No. existing data
    Then Error message "Reference No. already exists" in red color is displayed on Reference No. field
    And Third-party creation form Save button is disabled
    And Third-party creation form Save and New button is disabled
    And Third-party creation form Cancel button is enabled