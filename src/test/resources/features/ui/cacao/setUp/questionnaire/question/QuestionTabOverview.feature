@ui @cacao @functional @questionnaires @question
Feature: Questionnaire Management - Question Tab - Overview

  As an RDDC Internal user AND permissions to manage questionnaires AND click Set up> Questionnaire
  I Want to click on Question tab
  So That show Question tab with edit and manage abilities

  Background:
    Given User logs into RDDC as "Admin"

  @C46592557
  Scenario: C46592557: [Questionnaire] - Question Tab: Overview - Add QSST - Save/Save as Draft
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User fills in Questionnaire Language "Afar"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    And Questionnaire Setup button "Preview" is enabled
    And Question panel message is displayed "Drag a question from the left panel onto this area"
    And Question panel additional message is displayed "Require at least one question to proceed."
    And Questionnaire setup "Tab One" tab is selected
    And Questionnaire question active tab type is "RESPONDER USE"
    And Questionnaire question tab Delete button is not displayed for tab on position 1
    And Question drop-down "Language" selected value is "English"
    And Question drop-down "Language" options are
      | English |
      | Afar    |
    When User selects Question "Language" "English" drop-down value
    Then Question draggable options are
      | Boolean               |
      | Checkbox              |
      | Currency              |
      | Date                  |
      | SingleSelect          |
      | Heading               |
      | Multiple Choice       |
      | MultiSelect           |
      | Number                |
      | Text                  |
      | TextEntryPlus         |
      | EnhancedTextEntryPlus |
    When User adds question with type "Boolean" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "Currency" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    Then Manage buttons are displayed for each added question type
    When User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table
    When User clicks Add Questionnaire button
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "Currency" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks Add Questionnaire button
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "Currency" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"

  @C46626315
  Scenario: C46626315: [Questionnaire] - Question Tab: Overview - Edit QSST - Save/Save as Draft - Published
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User fills in Questionnaire Language "Afar"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "Currency" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Text" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in edit mode
    When User clicks "Question" questionnaire tab
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save" is enabled
    And Questionnaire Setup button "Next" is enabled
    And Questionnaire Setup button "Preview" is enabled
    And Questionnaire question tab counter with value "12" is displayed for tab on position 1
    And Questionnaire setup "Tab One" tab is selected
    And Questionnaire question active tab type is "RESPONDER USE"
    And Question drop-down "Language" selected value is "English"
    And Question drop-down "Language" options are
      | Afar    |
      | English |
    When User selects Question "Language" "English" drop-down value
    Then Question draggable options are
      | Boolean               |
      | Checkbox              |
      | Currency              |
      | Date                  |
      | SingleSelect          |
      | Heading               |
      | Multiple Choice       |
      | MultiSelect           |
      | Number                |
      | Text                  |
      | TextEntryPlus         |
      | EnhancedTextEntryPlus |
    When User adds question with type "Boolean" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "Currency" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    Then Manage buttons are displayed for each added question type
    And Questionnaire question tab counter with value "24" is displayed for tab on position 1
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    Then Questionnaire question tab counter with value "12" is displayed for tab on position 1
    When User adds question with type "Boolean" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "Currency" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    Then Manage buttons are displayed for each added question type
    And Questionnaire question tab counter with value "24" is displayed for tab on position 1
    When User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    Then Questionnaire question tab counter with value "24" is displayed for tab on position 1

  @C46626315
  Scenario: C46626315: [Questionnaire] - Question Tab: Overview - Edit QSST - Save/Save as Draft - Saved as Draft
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User fills in Questionnaire Language "Afar"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in edit mode
    When User clicks "Question" questionnaire tab
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    And Questionnaire Setup button "Preview" is enabled
    And Questionnaire question tab counter with value "0" is displayed for tab on position 1
    And Questionnaire setup "Tab One" tab is selected
    And Questionnaire question active tab type is "RESPONDER USE"
    And Question drop-down "Language" selected value is "English"
    And Question drop-down "Language" options are
      | English |
      | Afar    |
    When User selects Question "Language" "English" drop-down value
    Then Question draggable options are
      | Boolean               |
      | Checkbox              |
      | Currency              |
      | Date                  |
      | SingleSelect          |
      | Heading               |
      | Multiple Choice       |
      | MultiSelect           |
      | Number                |
      | Text                  |
      | TextEntryPlus         |
      | EnhancedTextEntryPlus |
    When User adds question with type "Boolean" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "Currency" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    Then Manage buttons are displayed for each added question type
    And Questionnaire question tab counter with value "12" is displayed for tab on position 1
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    Then Questionnaire question tab counter with value "12" is displayed for tab on position 1
    When User adds question with type "Boolean" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "Currency" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    Then Manage buttons are displayed for each added question type
    And Questionnaire question tab counter with value "24" is displayed for tab on position 1
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    Then Questionnaire question tab counter with value "24" is displayed for tab on position 1
