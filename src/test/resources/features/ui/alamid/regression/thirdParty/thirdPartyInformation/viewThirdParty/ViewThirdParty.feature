@ui  @suppliers @alamid

Feature: Third-party Information - View Third-party

  Background:
    Given User logs into RDDC as "Admin"

  @C45728504
  @full_regression
  Scenario: C45728504: Third-party Information Page - Display Risk Model field in Risk Analyzer section if Dynamic Risk Scoring = ON
    When User creates third-party "with random ID name"
    And User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    When User clicks on created third-party
    Then Third-party Information tab is loaded
    And Risk Model value is displayed

  @C45728502 @C45728503
  @full_regression
  Scenario: C45728502, C45728503: Third-party - Information Page - Overall Risk Score Meter Configure button
    When User creates third-party "with random ID name"
    And User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    When User clicks on created third-party
    Then Third-party Information tab is loaded
    When User clicks Configure Risk Analyzer button
    Then Configure Overall Risk Score modal is displayed
    And Configure Overall Risk Score default modal elements should be displayed
    When User clicks Configure Overall Risk Score Cancel button
    And User clicks Start Onboarding for third-party
    Then Configure Risk Analyzer button is disabled

  @C54216868
  @core_regression
  Scenario: C54216868: View Third-party - Display Final Assessment field of Onboarded Third-party with selected assessment in Approve Onboarding workflow activity
    When User creates third-party "OnboardingWFG" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on "Approve Onboarding" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    And "Final Assessment" is displayed between Status and Risk Tier field

  @C54230897
  @core_regression
  Scenario: C54230897: View Third-party - Display Final Assessment field of Onboarding Denied Third-party with selected assessment in Decline Onboarding workflow activity
    When User creates third-party "OnboardingWFG" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And User clicks on "Decline Onboarding" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDING DENIED"
    And "Final Assessment" is displayed between Status and Risk Tier field

  @C54233652
  @full_regression
  Scenario: C54233652: View Third-party - 'Final Assessment' field should not display for Onboarded Third-party without selected assessment in Approve Onboarding workflow activity
    When User creates third-party "OnboardingWFG" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And User clicks on "Approve Onboarding" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    And "Final Assessment" is not displayed between Status and Risk Tier field

  @C54235841
  @full_regression
  Scenario: C54235841: View Third-party - 'Final Assessment' field should not display for Onboarding Denied Third-party without selected assessment in Decline Onboarding workflow activity
    When User creates third-party "OnboardingWFG" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And User clicks on "Decline Onboarding" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDING DENIED"
    And "Final Assessment" is not displayed between Status and Risk Tier field

