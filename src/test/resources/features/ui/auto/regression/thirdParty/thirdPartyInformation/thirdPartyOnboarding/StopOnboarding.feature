@ui @supplier_onboarding
Feature: Third-party Information - Third-party Onboarding - Stop Onboarding

  As a RDDC User
  I want a way to stop the Onboarding of a Third-party
  So that I can stop processing Third-parties that no longer need to be Onboarded

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineIndividual" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"


  @C35914618 @C37805406
  @core_regression @full_regression
  Scenario: C35914618, C37805406: [Supplier Onboarding] Stopping the Onboarding Process
  Stop Onboarding: Stopping the Onboarding Process
    Then Third-party's element "Decline Onboarding" should be shown
    When User clicks "Stop Onboarding" third-party button
    Then Message is displayed on confirmation window
      | Are you sure you want to stop the Onboarding Process? This cannot be undone and you will have to restart the Onboarding Process again. |
    And Confirmation window button with text "Yes" is displayed
    And Confirmation window button with text "No" is displayed
    When User clicks No button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "ONBOARDING"
    When User clicks "Stop Onboarding" third-party button
    And User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "NEW"
    And Onboarding Start Date field should be hidden
    And Third-party's element "Decline Onboarding" should not be shown
    And Third-party's element "Stop Onboarding" should not be shown
    And Third-party's element "Start Onboarding" should be shown
    And Onboarding Activities section is not displayed

  @C37805570
  @full_regression
  Scenario: C37805570: Stop Onboarding: No permissions for Onboarding/Renewal - Impossible to Stop Onboarding
    When User clicks Log Out button
    Then Login page is loaded
    When User logs into RDDC as "User without Onboarding and Renewal accesses"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then Third-party's element "Stop Onboarding" should not be shown
