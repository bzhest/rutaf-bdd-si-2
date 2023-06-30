@ui @full_regression @value_management @risk_scoring_range @alamid

Feature: Value Management - Risk Scoring Range

  As a RDDC Administrator
  I want see the Risk Scoring Range Configured when Dynamic Risk Scoring is ON
  So that I can review the Risk Scoring Range when needed

  Background:
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User opens Value Management page
    And User clicks "Risk Scoring Range" value

  @C45667014 @core_regression
  Scenario: C45667014: [Dynamic Risk Scoring On]Value Management - Risk Scoring Range - Display Risk Model drop down
    Then Risk Model drop down is displayed
    When User clicks Risk Model drop down
    Then Risk Model Drop down list is displayed with values
      | IntegraRating |
    When User selects risk model "IntegraRating" from dropdown
    Then Risk model "IntegraRating" is displayed

  @C45667015 @core_regression
  Scenario: C45667015: [Dynamic Risk Scoring On] Value Management - Risk Scoring Range - Select IntegraRating risk model
    When User clicks Risk Model drop down
    And User selects risk model "IntegraRating" from dropdown
    Then Risk model "IntegraRating" is displayed
    And Value Management table displayed with columns
      | VALUE         |
      | SCORING RANGE |
      | COLOR         |
      | DATE CREATED  |
      | LAST UPDATED  |
    And For each Value Management record edit button should be displayed
    And "ADD RISK SCORING RANGE" Value Management Button is displayed
    And Apply Risk Model button is displayed
    And Risk Model Cancel button is displayed
    And Value Management message "NO AVAILABLE DATA" is displayed if table is empty

  @C45667016
  Scenario: C45667016: [Dynamic Risk Scoring On] Value Management - Risk Scoring Range - IntegraRating Model - Sorting and Pagination
    When User clicks Risk Model drop down
    And User selects risk model "IntegraRating" from dropdown
    Then Risk model "IntegraRating" is displayed
    And Value Management table is sorted by "Date Created" field in "DESC" order
    When User clicks Value Management "Value" column
    Then Value Management table is sorted by "Value" field in "ASC" order
    When User clicks Value Management "Value" column
    Then Value Management table is sorted by "Value" field in "DESC" order
    When User clicks Value Management "Scoring Range" column
    Then Value Management table is sorted by "Scoring Range" field in "ASC" order
    When User clicks Value Management "Scoring Range" column
    Then Value Management table is sorted by "Scoring Range" field in "DESC" order
    When User clicks Value Management "Color" column
    Then Value Management table is sorted by "Color" field in "ASC" order
    When User clicks Value Management "Color" column
    Then Value Management table is sorted by "Color" field in "DESC" order
    When User clicks Value Management "Date Created" column
    Then Value Management table is sorted by "Date Created" field in "ASC" order
    When User clicks Value Management "Date Created" column
    Then Value Management table is sorted by "Date Created" field in "DESC" order
    When User clicks Value Management "Last Updated" column
    Then Value Management table is sorted by "Last Updated" field in "ASC" order
    When User clicks Value Management "Last Updated" column
    Then Value Management table is sorted by "Last Updated" field in "DESC" order
    And Pagination section is displayed

  @C45667020 @core_regression
  Scenario: C45667020: [Dynamic Risk Scoring On] Value Management - Risk Scoring Range - Apply IntegraRating risk model
    When User clicks Risk Model drop down
    And User selects risk model "IntegraRating" from dropdown
    Then Risk model "IntegraRating" is displayed
    When User clicks Apply Risk Model button
    Then Alert Icon is displayed with text
      | IntegraRating Risk Model has been applied |