@ui @alamid @full_regression @supplier_onboarding
Feature: Third-party Information - Third-party Onboarding - Offboard

  As an RDDC User
  I want  a way to Offboard an already Onboarded Third-party
  So that I can tag the Third-parties that have lapsed the agreed engagement with the company


  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with renewal workflow Norway" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown


  @C37806176
  Scenario: C37806176: Offboard: OFFBOARD flow and Start onboarding, Supplier has status Offboarded, workflow can be applied
    When User clicks Offboard button
    Then Message is displayed on confirmation window
      | Are you sure you want to Offboard this Third-party? |
      | This change cannot be undone.                       |
    And Confirmation button Cancel should be displayed
    And Confirmation button Offboard should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window should be Disappeared
    And Third-party's status should be shown - "ONBOARDED"
    And Third-party's element "Offboard" should be shown
    When User clicks Offboard button
    And User clicks Offboard button on confirmation window
    Then Confirmation window should be Disappeared
    And Third-party's status should be shown - "OFFBOARDED"
    And Assessment section field "Offboarded Decision Date" is displayed
    And Assessment section field "Onboarded Decision Date" is not displayed
    And Offboarded Decision Date should be TODAY+0
    And Third-party's element "Offboard" should not be shown
    And Third-party's element "Start Onboarding" should be shown
    When User clicks Start Onboarding for third-party
    Then Third-party's element "Start Onboarding" should not be shown
    And Third-party's element "Decline Onboarding" should be shown
    And Third-party's element "Stop Onboarding" should be shown
    And Onboarding Start Date should be TODAY+0
    And Third-party's onboarding workflow should be shown - "Auto Workflow Renewal Workflow Low Risk Onboarding"
    And Third-party's onboarding workflow description should be shown - "Onboarding Workflow for automation test with For Renewal status"
    And Third-party's status should be shown - "ONBOARDING"
    When User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "ONBOARDING"

  @C37806171
  Scenario: C37806171: Offboard: No permissions for Onboarding/Renewal - Impossible to Offboard
    When User clicks Log Out button
    Then Login page is loaded
    When User logs into RDDC as "User without Onboarding and Renewal accesses"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then Third-party's element "Offboard" should not be shown
