@ui @supplier_renewal
Feature: Third-party Information - Third-party Renewal - Decline Renewal

  As a RDDC User
  I want a way to Decline the Renewal of a Third-party
  So that I can stop processing Third-party that are already determined to be ineligible for Renewal

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with renewal workflow Norway" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Custom Component" component tab
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    And User refreshes page
    And User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"


  @C37805341
  @full_regression
  Scenario: C37805341: Decline Renewal: Declining the Renewal Process
  Component's {string} header swimlane text color is {string}
    Then Third-party's element "Decline Renewal" should be shown
    And Third-party's button "Decline Renewal" color is "orange"
    When User clicks "Decline Renewal" third-party button
    Then Message is displayed on confirmation window
      | Are you sure you want to decline the Renewal Process? This cannot be undone and you will have to restart the Onboarding Process again. |
    And Confirmation window button with text "Yes" is displayed
    And Confirmation window button with text "No" is displayed
    When User clicks No button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "RENEWING"
    When User clicks "Decline Renewal" third-party button
    And User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "RENEWAL DENIED"
    And Third-party's element "Decline Renewal" should not be shown
    And Third-party's element "Stop Renewal" should not be shown
    And Third-party's element "Start Onboarding" should be shown
    And Onboarding Activities section is not displayed

  @C37805379
  @full_regression
  Scenario: C37805379: Decline Renewal: Declining the Renewal Process - No permissions for Onboarding/Renewal - Impossible to decline Renewal
    When User clicks Log Out button
    Then Login page is loaded
    When User logs into RDDC as "User without Onboarding and Renewal accesses"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then Third-party's element "Decline Renewal" should not be shown
