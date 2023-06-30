@ui @supplier_onboarding
Feature: Third-party Information - Third-party Onboarding - Decline Onboarding

  As a RDDC User
  I want  a way to Decline the Onboarding of a Third-party
  So that I can stop processing Third-parties that are already determined to be ineligible for the company

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineIndividual" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"


  @C35914890 @C37805407
  @core_regression @full_regression
  Scenario: C35914890, C37805407: [Supplier Onboarding] Decline the Onboarding Process
  Decline Onboarding: Decline the Onboarding Process
    Then Third-party's element "Decline Onboarding" should be shown
    When User clicks "Decline Onboarding" third-party button
    Then Message is displayed on confirmation window
      | Are you sure you want to decline the Onboarding Process? This cannot be undone and you will have to restart the Onboarding Process again. |
    And Confirmation window button with text "Yes" is displayed
    And Confirmation window button with text "No" is displayed
    When User clicks No button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "ONBOARDING"
    When User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "ONBOARDING DENIED"
    And Onboarding Denied Date should be TODAY+0
    And Onboarded Decision Date field should be hidden
    And Third-party's element "Decline Onboarding" should not be shown
    And Third-party's element "Stop Onboarding" should not be shown
    And Third-party's element "Start Onboarding" should be shown
    And Onboarding Activities section is not displayed

  @C37805572
  @full_regression
  Scenario: C37805572: Decline Onboarding: No permissions for Onboarding/Renewal - Impossible to Decline Onboarding
    When User clicks Log Out button
    Then Login page is loaded
    When User logs into RDDC as "User without Onboarding and Renewal accesses"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then Third-party's element "Decline Onboarding" should not be shown
