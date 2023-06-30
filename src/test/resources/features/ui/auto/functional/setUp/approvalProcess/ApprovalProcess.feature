@ui @ristretto @functional @approval_process @qa-sprint7
Feature: Approval Process - Add Approval Process

  @C44969463
  Scenario: C44969463: [Approval Process] - Add Approval Process page - Clicking "Approval Process" header link redirects user to the "Overview" page
    Given User logs into RDDC as "Admin"
    When User navigates to Approval Process overview page
    And User clicks Add Approval Process button
    And User clicks Approval process header link
    Then Approval Process Overview page is displayed
