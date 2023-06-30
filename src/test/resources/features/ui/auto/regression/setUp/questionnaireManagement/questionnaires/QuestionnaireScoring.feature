@ui @core_regression @full_regression @questionnaires
Feature: Questionnaire Setup - Questionnaire Scoring

  As an Admin or Internal User that has access right
  I Want to add scoring to categorize the questionnaire score range for assessment reference what the score means
  So that client should be able to easily identify and assess their suppliers based on their score

  @C35997402
  Scenario: C35997402: Questionnaire Setup - Scoring - verify that user can add Scoring to the Questionnaire
    Given User logs into RDDC as "Admin"
    When User navigates to Questionnaire Management page
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User fills in choice score on position 1 value "1"
    And User clicks Questionnaire Setup button "Next"
    Then "Scoring" Tab is displayed
    And Scoring tab contains message "No Scoring Scheme is Available"
    When User clicks Add Scoring Scheme questionnaire button
    Then Scoring tab form contains message "Minimum score is 0 Maximum score should not be higher than 1"
    When User fills "with completed data" scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Questionnaire Scores are displayed on scoring table with provided details
    When User clicks edit button for score range on position 1
    And User fills "with 0-1 scoring range" scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Questionnaire Scores are displayed on scoring table with provided details
    When User clicks delete button for score range on position 1
    Then Score is not displayed on scoring table
    When User clicks Add Scoring Scheme questionnaire button
    And User fills "with completed data" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Scoring" questionnaire tab
    Then Questionnaire Scores are displayed on scoring table with provided details
    When User clicks edit button for score range on position 1
    And User fills "with 0-1 scoring range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Scoring" questionnaire tab
    Then Questionnaire Scores are displayed on scoring table with provided details
