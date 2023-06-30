@ui @cacao @functional @questionnaires @question
Feature: Questionnaire Management - Question Tab - Text Entry Plus Question Type

  As Admin or Internal User that has access rights in User Management
  I want to setup questions
  So that User will be able to set up different question type, description and choices

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"

  @C46716301
  Scenario: C46716301: [Questionnaire] - Add/Edit Question - Text Entry Plus - Responder tab
    Then Questionnaire setup "Tab One" tab is selected
    When User adds question with type "TextEntryPlus" to active tab
    Then Questionnaire "TextEntryPlus" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "TextEntryPlus" configuration section appears with expected elements for "Responder use"
    When User clicks Delete button for question "Sub-question #2" choice
    Then Questionnaire choices with label "Sub-question #" 1 options are displayed
    And Questionnaire choices "Sub-question #" Delete buttons are not displayed
    And Questionnaire choices counter is "Sub-questions: 1/10"
    When User clicks Add button for question "Sub-question #1" choice
    Then Questionnaire choices with label "Sub-question #" 2 options are displayed
    And Questionnaire choices "Sub-question #" Delete buttons are displayed
    And Questionnaire choices counter is "Sub-questions: 2/10"
    When User clicks Add button for question "Sub-question #2" choice
    And User clicks Add button for question "Sub-question #3" choice
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Sub-question #" 4 options are displayed
    When User clicks Questionnaire question configuration "See less" button
    Then Questionnaire question configuration "See more" button is displayed
    And Questionnaire choices with label "Sub-question #" 3 options are displayed
    When User clicks Questionnaire question configuration "See more" button
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Sub-question #" 4 options are displayed
    When User toggles Mandatory for choice "Sub-question #1"
    And User clicks Questionnaire Setup button "Preview"
    And User switches to a new tab
    Then Questionnaire Preview contains required indicator for field "Text" for question on position 1
    When User navigates back to RDDC page
    And User configures question with data "TextEntryPlus question configuration with 5 sub-question"
    Then Questionnaire choices counter is "Sub-questions: 5/10"
    When User clicks Configuration icon
    And User clicks Questionnaire question "See more" button
    Then Question fields are
      | Number 1 |
      | Text 2   |
      | Number 3 |
      | Text 4   |
      | Number 5 |
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Question configuration contains expected data "TextEntryPlus question configuration with 5 sub-question"
    When User configures question with data "TextEntryPlus question configuration with 6 sub-question"
    Then Questionnaire choices counter is "Sub-questions: 6/10"
    When User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Question configuration contains expected data "TextEntryPlus question configuration with 6 sub-question"

  @C46718936
  Scenario: C46718936: [Questionnaire] - Add/Edit Question - Text Entry Plus - Reviewer tab - changed number of reviewers
    When User adds question with type "TextEntryPlus" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "TextEntryPlus" to active tab
    Then Questionnaire "TextEntryPlus" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "TextEntryPlus" configuration section appears with expected elements for "Reviewer use"
    When User clicks Delete button for question "Sub-question #2" choice
    Then Questionnaire choices with label "Sub-question #" 1 options are displayed
    And Questionnaire choices "Sub-question #" Delete buttons are not displayed
    And Questionnaire choices counter is "Sub-questions: 1/10"
    When User clicks Add button for question "Sub-question #1" choice
    Then Questionnaire choices with label "Sub-question #" 2 options are displayed
    And Questionnaire choices "Sub-question #" Delete buttons are displayed
    And Questionnaire choices counter is "Sub-questions: 2/10"
    When User clicks Add button for question "Sub-question #2" choice
    And User clicks Add button for question "Sub-question #3" choice
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Sub-question #" 4 options are displayed
    When User clicks Questionnaire question configuration "See less" button
    Then Questionnaire question configuration "See more" button is displayed
    And Questionnaire choices with label "Sub-question #" 3 options are displayed
    When User clicks Questionnaire question configuration "See more" button
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Sub-question #" 4 options are displayed
    When User toggles Mandatory for choice "Sub-question #1"
    And User clicks Questionnaire Setup button "Preview"
    And User switches to a new tab
    Then Questionnaire Preview contains required indicator for field "Text" for question on position 1
    When User navigates back to RDDC page
    And User configures question with data "TextEntryPlus question configuration with 5 sub-question"
    Then Questionnaire choices counter is "Sub-questions: 5/10"
    When User clicks Configuration icon
    And User clicks Questionnaire question "See more" button
    Then Question fields are
      | Number 1 |
      | Text 2   |
      | Number 3 |
      | Text 4   |
      | Number 5 |
    When User clicks "Reviewers" questionnaire tab
    And User selects Number of Reviewer Levels "5"
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question Reviewer level drop-down options are
      | Level 1 |
      | Level 2 |
      | Level 3 |
      | Level 4 |
      | Level 5 |
    When User selects Question Reviewer level "Level 3"
    And User clicks "Reviewers" questionnaire tab
    And User selects Number of Reviewer Levels "4"
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question Reviewer level is "Level 3"
    And Question Reviewer level drop-down options are
      | Level 1 |
      | Level 2 |
      | Level 3 |
      | Level 4 |
    When User clicks "Reviewers" questionnaire tab
    And User selects Number of Reviewer Levels "2"
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question Reviewer level is "Level 2"
    And Question Reviewer level drop-down options are
      | Level 1 |
      | Level 2 |
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question configuration contains expected data "TextEntryPlus question configuration with Level 2 reviewer"
    When User configures question with data "TextEntryPlus question configuration with 6 sub-question with Level 2 reviewer"
    Then Questionnaire choices counter is "Sub-questions: 6/10"
    When User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question configuration contains expected data "TextEntryPlus question configuration with 6 sub-question with Level 2 reviewer"

  @C46718937
  Scenario: C46718937: [Questionnaire] - Add/Edit Question - Text Entry Plus - Delete
    When User adds question with type "TextEntryPlus" to active tab
    And User clicks Configuration icon
    And User configures question with data "TextEntryPlus question configuration with 5 sub-question"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User adds question with type "TextEntryPlus" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "TextEntryPlus" to active tab
    And User clicks Configuration icon
    And User configures question with data "TextEntryPlus question configuration with 5 sub-question"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    And User configures question with data "TextEntryPlus question configuration with 5 sub-question"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User adds question with type "TextEntryPlus" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "TextEntryPlus" to active tab
    And User clicks Configuration icon
    And User configures question with data "TextEntryPlus question configuration with 5 sub-question"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
