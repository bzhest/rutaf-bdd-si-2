@ui @cacao @functional @questionnaires @questionnaireReviewers
Feature: Questionnaire Management - Scoring Tab - Add/View

  As an Admin or Internal User that has access right
  I Want to add scoring to categorize the questionnaire score range for assessment reference what the score means
  So that client should be able to easily identify and assess their suppliers based on their score


  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"

  @C46438090 @C46470110
  Scenario: C46438090, C46470110: [Questionnaire] - Scoring Tab - Add QSST - Add Scoring Scheme - Save/Save as Draft
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User fills in choice score on position 1 value "250"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Scoring" tab is selected
    And Scoring tab contains message "No Scoring Scheme is Available"
    And Questionnaire Setup button "Add Scoring Scheme" is enabled
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Save" is enabled
    When User clicks Add Scoring Scheme questionnaire button
    Then Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Save" is enabled
    And Questionnaire form Scoring Name field max length is "250" symbols
    And Questionnaire form "Scoring Name" field is required
    And Scoring tab form contains message "Minimum score is 0 Maximum score should not be higher than 250"
    And Questionnaire form "Min" field is required
    And Questionnaire form "Max" field is required
    And Questionnaire form selected Scoring Level of Reviewer is "1"
    When User fills in Questionnaire scoring Min value "251"
    Then Questionnaire scoring Min value is "25"
    When User fills in Questionnaire scoring Min value "-1"
    Then Questionnaire scoring Min value is "1"
    When User fills in Questionnaire scoring Min value "0.1"
    Then Questionnaire scoring Min value is "1"
    When User fills "with completed data" scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Scoring tab form contains message "Minimum score is 1 Maximum score should not be higher than 250"
    And Questionnaire Scoring table is displayed with columns and expected buttons
      | SCORING NAME       |
      | RISK SCORING RANGE |
      | LEVEL OF REVIEWER  |
    When User clicks delete button for score range on position 1
    Then Score "Scoring Test Name" is not displayed on scoring table
    And Scoring tab contains message "No Scoring Scheme is Available"
    And Questionnaire Setup button "Add Scoring Scheme" is enabled
    When User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 0-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User fills "Scheme 2: 51-100 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User fills "Scheme 3: 101-150 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User fills "Scheme 4: 151-200 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User fills "Scheme 5: 201-250 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Questionnaire Scores are displayed on scoring table with provided details
    When User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Scores are displayed on scoring table with provided details
    And Questionnaire tab displayed in view mode
    And Questionnaire Setup button "Back To Overview" is enabled
    When User clicks Questionnaire Setup button "Back To Overview"
    Then Questionnaire Overview page is displayed

  @C46465021
  Scenario: C46465021: [Questionnaire] - Scoring Tab - Add QSST - Add Scoring Scheme - Validations
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User fills in choice score on position 1 value "250"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Add Scoring Scheme questionnaire button
    And User fills in Questionnaire scoring name "Test Name"
    And User clicks Questionnaire Setup button "Done"
    Then Error message "This field is required" is displayed for Questionnaire "Min" field
    And Error message "This field is required" is displayed for Questionnaire "Max" field
    When User fills in Questionnaire scoring Min value "0"
    And User fills in Questionnaire scoring Max value "1"
    And User fills in Questionnaire scoring name ""
    And User clicks Questionnaire Setup button "Done"
    Then Error message "This field is required" is displayed for Questionnaire "Scoring Name" field
    When User fills "Scheme 1: 100-99 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Error message "Minimum score should not be greater than calculated maximum score" is displayed for Questionnaire "Min" field
    When User fills "Scheme 1: 1-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Scoring tab form contains message "Minimum score is 0 Maximum score should not be higher than 250"
    When User fills "Scheme 1: 0-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Error message "Scoring name already exists" is displayed for Questionnaire "Scoring Name" field
    When User fills in Questionnaire scoring name "Scheme 2"
    And User fills in Questionnaire scoring Min value "0"
    And User fills in Questionnaire scoring Max value "100"
    And User clicks Questionnaire Setup button "Done"
    Then Error message "Scoring range already exists" is displayed for Questionnaire "Min" field
    When User fills in Questionnaire scoring Min value "1"
    And User clicks Questionnaire Setup button "Done"
    Then Error message "Scoring range already exists" is displayed for Questionnaire "Min" field
    When User fills in Questionnaire scoring Min value "49"
    And User clicks Questionnaire Setup button "Done"
    Then Error message "Scoring range already exists" is displayed for Questionnaire "Min" field
    When User fills in Questionnaire scoring Min value "50"
    And User clicks Questionnaire Setup button "Done"
    Then Error message "Scoring range already exists" is displayed for Questionnaire "Min" field

  @C46465025 @C46470110
  Scenario: C46465025, C46470110: [Questionnaire] - Scoring Tab - Add QSST - Edit Scoring Scheme - Save/Save as Draft
    When User selects Number of Reviewer Levels "3"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User fills in choice score on position 1 value "250"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-100 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User fills "Scheme 2: 101-170 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User fills "Scheme 3: 171-250 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks edit button for score range on position 2
    Then Questionnaire Setup button "Done" is enabled
    When User fills in Questionnaire scoring Min value ""
    And User fills in Questionnaire scoring Max value ""
    And User clicks Questionnaire Setup button "Done"
    Then Error message "This field is required" is displayed for Questionnaire "Min" field
    And Error message "This field is required" is displayed for Questionnaire "Max" field
    When User fills in Questionnaire scoring Min value "101"
    And User fills in Questionnaire scoring Max value "170"
    And User fills in Questionnaire scoring name ""
    And User clicks Questionnaire Setup button "Done"
    Then Error message "This field is required" is displayed for Questionnaire "Scoring Name" field
    When User fills in Questionnaire scoring name "Scheme 2"
    And User fills in Questionnaire scoring Min value "150"
    And User fills in Questionnaire scoring Max value "149"
    And User clicks Questionnaire Setup button "Done"
    Then Error message "Minimum score should not be greater than calculated maximum score" is displayed for Questionnaire "Min" field
    When User fills in Questionnaire scoring name "Scheme 1"
    And User fills in Questionnaire scoring Min value "101"
    And User fills in Questionnaire scoring Max value "135"
    And User clicks Questionnaire Setup button "Done"
    Then Error message "Scoring name already exists" is displayed for Questionnaire "Scoring Name" field
    When User fills in Questionnaire scoring name "Scheme 2"
    And User fills in Questionnaire scoring Min value "0"
    And User fills in Questionnaire scoring Max value "150"
    And User clicks Questionnaire Setup button "Done"
    Then Error message "Scoring range already exists" is displayed for Questionnaire "Min" field
    When User fills in Questionnaire scoring Min value "1"
    And User clicks Questionnaire Setup button "Done"
    Then Error message "Scoring range already exists" is displayed for Questionnaire "Min" field
    When User fills in Questionnaire scoring Min value "100"
    And User fills in Questionnaire scoring Max value "170"
    And User clicks Questionnaire Setup button "Done"
    Then Error message "Scoring range already exists" is displayed for Questionnaire "Min" field
    When User fills in Questionnaire scoring Min value "101"
    And User fills in Questionnaire scoring Max value "171"
    And User clicks Questionnaire Setup button "Done"
    Then Error message "Scoring range already exists" is displayed for Questionnaire "Min" field
    When User fills "Scheme 2: 101-170 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Questionnaire Scores are displayed on scoring table with provided details
    When User clicks edit button for score range on position 1
    And User fills "Scheme 1: 0-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Questionnaire Scores are displayed on scoring table with provided details
    And Scoring tab form contains message "Minimum score is 51 Maximum score should not be higher than 250"
    When User clicks delete button for score range on position 3
    Then Score "Scheme 3" is not displayed on scoring table
    And Questionnaire Scores are displayed on scoring table with provided details
    When User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Scores are displayed on scoring table with provided details
    And Questionnaire tab displayed in view mode
    And Questionnaire Setup button "Back To Overview" is enabled
    When User clicks Questionnaire Setup button "Back To Overview"
    Then Questionnaire Overview page is displayed

  @C46625881
  Scenario: C46625881: [Questionnaire] - Scoring Tab - Add QSST - Add/Edit Scoring Scheme - Cancel
    When User selects Number of Reviewer Levels "2"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User fills in choice score on position 1 value "250"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-100 range" scoring information
    And User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User selects Number of Reviewer Levels "2"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User fills in choice score on position 1 value "250"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-100 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks edit button for score range on position 1
    Then Questionnaire scoring input fields contains expected "Scheme 1: 1-100 range" data
    When User fills "Scheme 2: 51-100 range" scoring information
    And User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table

  @C46470135
  Scenario Outline: C46470135: [Questionnaire] - Scoring Tab - Add/View QSST - Save/Save as Draft Without Scoring
    When User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User fills in choice score on position 1 value "250"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<button>"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Scoring tab contains message "No Scoring Scheme is Available"
    And Questionnaire tab displayed in view mode
    And Questionnaire Setup button "Back To Overview" is enabled
    When User clicks Questionnaire Setup button "Back To Overview"
    Then Questionnaire Overview page is displayed
    Examples:
      | button        |
      | Save          |
      | Save as draft |