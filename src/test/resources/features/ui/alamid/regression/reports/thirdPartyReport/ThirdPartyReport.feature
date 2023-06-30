@ui @alamid @thirdPartyReports @full_regression

Feature: Reports - Third-party Reports

  @C45659290 @C45659291
  Scenario: C45659290, C45659291: Third-party Report - Add Risk Model column / Filter by Risk Model
    When User logs into RDDC as "Admin"
    And User navigates to Reports page
    And User selects Report Tab "THIRD-PARTY REPORT"
    Then Report column "RISK MODEL" is displayed
    When User clicks Report panel "Columns"
    And User unchecks Column Field "RISK MODEL"
    Then Report column "RISK MODEL" is not displayed
    When User checks Column Field "RISK MODEL"
    Then Report column "RISK MODEL" is displayed
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "Risk Model"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "IntegraRating"
    And User clicks filter page button
    Then Report table column "RISK MODEL" contains only values
      | IntegraRating |

  @C54209087 @C54198942
  Scenario: C54209087, C54198942: Third-party Report - Filter by Final Assessment
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "THIRD-PARTY REPORT"
    Then Report columns are displayed
      | THIRD-PARTY ID             |
      | REFERENCE ID               |
      | THIRD-PARTY NAME           |
      | RISK TIER                  |
      | RISK SCORE                 |
      | THIRD-PARTY STATUS         |
      | FINAL ASSESSMENT           |
      | THIRD-PARTY REGION         |
      | THIRD-PARTY COUNTRY        |
      | WORKFLOW GROUP             |
      | THIRD-PARTY ADDRESS LINE   |
      | THIRD-PARTY CITY           |
      | THIRD-PARTY ZIP/POSTAL     |
      | THIRD-PARTY STATE/PROVINCE |
      | THIRD-PARTY DESCRIPTION    |
    When User clicks Report panel "Columns"
    And User unchecks all Report columns
    And User checks Column Field "FINAL ASSESSMENT"
    Then Report column "FINAL ASSESSMENT" is displayed
    When User clicks Report panel "Filters"
    And User clicks Filter Field Title "FINAL ASSESSMENT"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Approve Assessment 1"
    And User clicks filter page button
    Then Report table column "FINAL ASSESSMENT" contains only values
      | Approve Assessment 1 |
    When User clicks Reset All filter report button
    And User selects My Third-party show option
    And User clicks Filter Field Title "FINAL ASSESSMENT"
    And User clicks Filter Field Label "(Select All)"
    And User clicks Filter Field Label "Approve Assessment 1"
    And User clicks filter page button
    Then Report table column "FINAL ASSESSMENT" contains only values
      | Approve Assessment 1 |