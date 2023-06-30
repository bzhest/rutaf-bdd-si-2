@ui @cacao @functional @questionnaires @question
Feature: Questionnaire Management - Question Tab - Text Question Type

  As Admin or Internal User that has access rights in User Management
  I want to setup questions
  So that User will be able to set up different question type, description and choices

  Background:
    Given User logs into RDDC as "Admin"


  @C46641140
  Scenario: C46641140: Add Question - Text - Add/Edit - Responder Use: Configuration
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Tab One" tab is selected
    When User adds question with type "Text" to active tab
    Then Questionnaire "Text" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Text" configuration section appears with expected elements for "Responder use"
    When User configures question with data "Text question configuration"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Preview"
    And User switches to a new tab
    Then Questionnaire Preview contains question "Text question configuration" on position 1
    When User navigates back to RDDC page
    And User clicks Configuration icon
    And User configures question with data "Text question configuration mandatory"
    Then Question label "Required" by QID is shown
    And Question label "Attachment" by QID is shown
    When User clicks Configuration icon
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Question configuration contains expected data "Text question configuration mandatory"

  @C46663086
  Scenario: C46663086: Add Question - Text - Add/Edit - Reviewer Use: Configuration
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Tab One" tab is selected
    When User adds question with type "Text" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Text" to active tab
    Then Questionnaire "Text" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Text" configuration section appears with expected elements for "Reviewer use"
    When User configures question with data "Text question configuration"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Preview"
    And User switches to a new tab
    Then Questionnaire Preview contains question "Text question configuration" on position 1
    When User navigates back to RDDC page
    And User clicks Configuration icon
    And User configures question with data "Text question configuration mandatory"
    Then Question label "Required" by QID is shown
    And Question label "Attachment" by QID is shown
    When User clicks Configuration icon
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question configuration contains expected data "Text question configuration mandatory Reviewer Use"

  @C46670838
  Scenario Outline: C46670838: Add Question - Text - Add/Edit - Mapping setting
    When User creates Custom Field "active with description and Text type" via API
    And User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Text" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "<tabType>" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Text" to active tab
    And User clicks Mapping icon
    Then Question drop-down "Map To" selected value is "None"
    When User selects Question "Map To" "Update Custom Fields" drop-down value
    Then Question Mapping section is displayed with default data for "Text" question type
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

  @C46670853
  Scenario: C46670853: Add Question - Text - Add/Edit - Delete
    When User creates Custom Field "active with description and Text type" via API
    And User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Text" to active tab
    And User clicks Configuration icon
    And User configures question with data "Text question configuration"
    And User clicks Configuration icon
    And User clicks Mapping icon
    And User selects Question "Map To" "Update Custom Fields" drop-down value
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    And User clicks Mapping icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User adds question with type "Text" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Text" to active tab
    And User clicks Configuration icon
    And User configures question with data "Text question configuration"
    And User clicks Configuration icon
    And User clicks Mapping icon
    And User selects Question "Map To" "Update Custom Fields" drop-down value
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    And User clicks Mapping icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    And User configures question with data "Text question configuration"
    And User clicks Configuration icon
    And User clicks Mapping icon
    And User selects Question "Map To" "Update Custom Fields" drop-down value
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    And User clicks Mapping icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User adds question with type "Text" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Text" to active tab
    And User clicks Configuration icon
    And User configures question with data "Text question configuration"
    And User clicks Configuration icon
    And User clicks Mapping icon
    And User selects Question "Map To" "Update Custom Fields" drop-down value
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    And User clicks Mapping icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
