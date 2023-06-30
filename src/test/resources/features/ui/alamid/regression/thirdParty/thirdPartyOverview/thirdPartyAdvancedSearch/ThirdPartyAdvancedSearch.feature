@ui @alamid @suppliers @full_regression

Feature: Third-party Overview - Advance Search

  @C45659288 @C45659287
  Scenario: C45659288, C45659287: Third-party - Advance Search - Add 'Risk Model' parameter
    Given User logs into RDDC as "Admin"
    When User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    When User clicks 'Advance Search' link
    And User adds search criteria parameter - Risk Model, value - IntegraRating on 1st line
    And User clicks 'Search' button on Advance Search screen
    Then Line with parameter - Risk Model and value - IntegraRating is present