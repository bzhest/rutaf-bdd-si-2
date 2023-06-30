@ui @cacao @functional @questionnaires @question
Feature: Questionnaire Management - Question Tab - Number Question Type

  As Admin or Internal User that has access rights in User Management
  I want to setup questions
  So that User will be able to set up different question type, description and choices

  Background:
    Given User logs into RDDC as "Admin"

  @C46657890
  Scenario: C46657890: [Questionnaire] - Add/Edit Question - Number - Add - Responder tab
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Tab One" tab is selected
    When User adds question with type "Number" to active tab
    Then Questionnaire "Number" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Number" configuration section appears with expected elements for "Responder use"
    When User configures question with data "Number question configuration mandatory"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Question configuration contains expected data "Number question configuration mandatory"

  @C46826334
  Scenario: C46826334: [Questionnaire] - Add/Edit Question - Number - Add - Reviewer tab
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Tab One" tab is selected
    When User adds question with type "Number" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Number" to active tab
    Then Questionnaire "Number" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Number" configuration section appears with expected elements for "Reviewer use"
    When User configures question with data "Number question configuration with Level 1 reviewer"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question configuration contains expected data "Number question configuration with Level 1 reviewer"

  @C46826337
  Scenario: C46826337: [Questionnaire] - Add/Edit Question - Number - Delete
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Number" to active tab
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User adds question with type "Number" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Number" to active tab
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"

  @C46838048
  Scenario Outline: C46838048: [Questionnaire] - Add/Edit Question - Number - Mapping
    When User creates Custom Field "active with random name and Number type" via API
    And User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Number" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "<tabType>" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Number" to active tab
    And User clicks Mapping icon
    Then Question drop-down "Map To" selected value is "None"
    When User selects Question "Map To" "Update Custom Fields" drop-down value
    Then Question Mapping section is displayed with default data for "Number" question type
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    When User clicks clear icon for "Custom Fields" drop-down value
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Error! The field has mapping category, but no mapping field is specified. |
    When User clicks on Question tab with index 1
    And User clicks Mapping icon
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    And User clicks clear mapping button
    Then Question drop-down "Map To" selected value is "None"
    And Mapping details are hidden
    When User selects Question "Map To" "Update Custom Fields" drop-down value
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    And User selects Question "Map To" "None" drop-down value
    Then Mapping details are hidden
    When User selects Question "Map To" "Update Custom Fields" drop-down value
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<button>"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Mapping icon
    Then Question drop-down "Map To" selected value is "Update Custom Fields"
    And Question drop-down "Custom Fields" selected value is "customFieldName"
    When User selects Question "Map To" "None" drop-down value
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<button>"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Mapping icon
    Then Question drop-down "Map To" selected value is "None"
    And Mapping details are hidden
    Examples:
      | tabType       | button        |
      | Reviewer use  | Save          |
      | Responder use | Save as draft |
