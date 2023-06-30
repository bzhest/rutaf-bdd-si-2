@ui @alamid @suppliers @full_regression

Feature: Third-party Overview Page

  @C45728505
  Scenario: C45728505: Third-party Overview Page - Add Risk Model column
    Given User logs into RDDC as "Admin"
    When User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    And Third-party Overview header "Third-party overview" should be displayed
    And Third-party Table columns are displayed
      | Name                              |
      | Industry Type                     |
      | Country                           |
      | Status                            |
      | Risk Model                        |
      | Risk Tier                         |
      | Date Created                      |
      | Last Update                       |
      | Screening Status (WC & Custom WL) |