@ui @sanity @value_management @multilanguage
Feature: Value Management

  As a user
  I want to setup values
  So they can meet the requirements of the Organisation

  @C32988211
  @tenant2-qa-regression
  Scenario: C32988211 - Value Management - Add Risk Scoring Range
    And User logs into RDDC as "Admin"
    And User sets up language via API
    And User clicks Set Up option
    And User navigates to Value Management page
    When User clicks "Risk Scoring Range" value
    And User clicks Add New button for Value
    And User fills in Value name "toBeReplaced_1"
    And User fills in Risk Scoring Range using API
    And User selects medium color in Risk Scoring Range
    And User clicks "associatedParties.saveButton" Value Management button
    Then "toBeReplaced_1" Risk Scoring Range is displayed in grid
