@ui @cacao @functional @questionnaires @question
Feature: Questionnaire Management - Question Tab - Boolean Question Type

  As as Admin or Internal User that has access rights in User Management
  I want to setup questions
  So that User will be able to set up different question type, description and choices

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"

  @C46564893
  Scenario: C46564893: [Questionnaire] - Add Question - Boolean - Responder tab
    Then Questionnaire setup "Tab One" tab is selected
    When User adds question with type "Boolean" to active tab
    Then Questionnaire "Boolean" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Boolean" configuration section appears with expected elements for "Responder use"
    When User configures question with data "Boolean question configuration"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Question configuration contains expected data "Boolean question configuration"

  @C46580571
  Scenario: C46580571: [Questionnaire] - Add/Edit Question - Boolean - Reviewer tab - changed number of reviewers
    When User adds question with type "Boolean" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Boolean" to active tab
    Then Questionnaire "Boolean" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Boolean" configuration section appears with expected elements for "Reviewer use"
    When User configures question with data "Boolean question configuration"
    And User clicks Configuration icon
    And User clicks "Reviewers" questionnaire tab
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
    When User configures question with data "Boolean question configuration with Level 2 reviewer"
    And User selects Question Reviewer level "Level 3"
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
    Then Question configuration contains expected data "Boolean question configuration with Level 2 reviewer"

  @C46622356
  Scenario: C46622356: [Questionnaire] - Edit Question - Boolean - Responder tab - Save as draft
    When User adds question with type "Text" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Text" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User selects Number of Reviewer Levels "5"
    And User clicks "Question" questionnaire tab
    And User adds question with type "Boolean" to active tab
    Then Questionnaire "Boolean" question on position 2 is displayed with default elements
    When User clicks Configuration icon for Question on position 2
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Boolean" configuration section appears with expected elements for "Responder use"
    When User configures question with data "Boolean question configuration"
    And User clicks Configuration icon
    And User clicks on Question tab with index 1
    And User adds question with type "Boolean" to active tab
    Then Questionnaire "Boolean" question on position 2 is displayed with default elements
    When User clicks Configuration icon for Question on position 2
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Boolean" configuration section appears with expected elements for "Reviewer use"
    When User configures question with data "Boolean question configuration with Level 2 reviewer"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon for Question on position 2
    And User configures question with data "Boolean question configuration Completed Data"
    And User clicks Configuration icon
    And User clicks on Question tab with index 1
    And User clicks Configuration icon for Question on position 2
    And User configures question with data "Boolean question configuration with Level 1 reviewer"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon for Question on position 2
    Then Question configuration contains expected data "Boolean question configuration Completed Data"
    When User clicks on Question tab with index 1
    And User clicks Configuration icon for Question on position 2
    Then Question configuration contains expected data "Boolean question configuration with Level 1 reviewer"

  @C46622356
  Scenario Outline: C46622356: [Questionnaire] - Edit Question - Boolean - Responder tab - Save
    When User adds question with type "Text" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Text" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User selects "<status>" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User selects Number of Reviewer Levels "5"
    And User clicks "Question" questionnaire tab
    And User adds question with type "Boolean" to active tab
    Then Questionnaire "Boolean" question on position 2 is displayed with default elements
    When User clicks Configuration icon for Question on position 2
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Boolean" configuration section appears with expected elements for "Responder use"
    When User configures question with data "Boolean question configuration"
    And User clicks Configuration icon
    And User clicks on Question tab with index 1
    And User adds question with type "Boolean" to active tab
    Then Questionnaire "Boolean" question on position 2 is displayed with default elements
    When User clicks Configuration icon for Question on position 2
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Boolean" configuration section appears with expected elements for "Reviewer use"
    When User configures question with data "Boolean question configuration with Level 1 reviewer"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon for Question on position 2
    And User configures question with data "Boolean question configuration Completed Data"
    And User clicks Configuration icon
    And User clicks on Question tab with index 1
    And User clicks Configuration icon for Question on position 2
    And User configures question with data "Boolean question configuration with Level 2 reviewer"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon for Question on position 2
    Then Question configuration contains expected data "Boolean question configuration Completed Data"
    When User clicks on Question tab with index 1
    And User clicks Configuration icon for Question on position 2
    Then Question configuration contains expected data "Boolean question configuration with Level 2 reviewer"
    Examples:
      | status   |
      | Active   |
      | Inactive |

  @C46565464
  Scenario: C46565464: [Questionnaire] - Add/Edit Question - Boolean - Delete
    When User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User configures question with data "Boolean question configuration"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User configures question with data "Boolean question configuration with Level 1 reviewer"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
