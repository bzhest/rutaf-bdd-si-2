@ui @cacao @functional @questionnaires @question
Feature: Questionnaire Management - Question Tab - Heading Question Type

  As Admin or Internal User that has access rights in User Management
  I want to setup questions
  So that User will be able to set up different question type, description and choices

  Background:
    Given User logs into RDDC as "Admin"

  @C46694293
  Scenario: C46694293: Add Question - Heading - Add/Edit - Responder Use: Configuration
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Tab One" tab is selected
    When User adds question with type "Heading" to active tab
    Then Questionnaire "Heading" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Heading" configuration section appears with expected elements for "Responder use"
    When User configures question with data "Heading question configuration"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Preview"
    And User switches to a new tab
    Then Questionnaire Preview contains question "Heading question configuration" on position 1
    When User navigates back to RDDC page
    And User clicks Configuration icon
    And User configures question with data "Heading question configuration mandatory"
    Then Question label "Required" by QID is shown
    And Question label "Attachment" by QID is shown
    When User clicks Configuration icon
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Question configuration contains expected data "Heading question configuration mandatory"

  @C46694294
  Scenario: C46694294: Add Question - Heading - Add/Edit - Reviewer Use: Configuration
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Tab One" tab is selected
    When User adds question with type "Heading" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Heading" to active tab
    Then Questionnaire "Heading" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Heading" configuration section appears with expected elements for "Reviewer use"
    When User configures question with data "Heading question configuration"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Preview"
    And User switches to a new tab
    Then Questionnaire Preview contains question "Heading question configuration" on position 1
    When User navigates back to RDDC page
    And User clicks Configuration icon
    And User configures question with data "Heading question configuration mandatory"
    Then Question label "Required" by QID is shown
    And Question label "Attachment" by QID is shown
    When User clicks Configuration icon
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question configuration contains expected data "Heading question configuration mandatory Reviewer Use"

  @C46694295
  Scenario: C46694295: Add Question - Heading - Add/Edit - Delete
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Heading" to active tab
    And User clicks Configuration icon
    And User configures question with data "Heading question configuration"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User adds question with type "Heading" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Heading" to active tab
    And User clicks Configuration icon
    And User configures question with data "Heading question configuration"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    And User configures question with data "Heading question configuration"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User adds question with type "Heading" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Heading" to active tab
    And User clicks Configuration icon
    And User configures question with data "Heading question configuration"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
