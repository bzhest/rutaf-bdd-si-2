@ui @cacao @functional @questionnaires @question
Feature: Questionnaire Management - Question Tab - Add/Edit Questionnaire

  As an Admin or Internal user that has access right
  I Want to display confirmations when user is update question that might impact other configuration such as branching and scoring
  So That User will be notified and has an option to proceed with the changes or not

  Background:
    Given User logs into RDDC as "Admin"


  @C46633152
  Scenario Outline: C46633152: [Questionnaire] - Add/Edit - Question Tab: Add/Edit Score - with existing Scoring Scheme - Multiple Choice
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "<questionType>" to active tab
    And User clicks Configuration icon
    And User configures question with data "Question with 3 Choices"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Configuration icon
    And User clicks Add button for question "Choice #3" choice
    And User fills choice name "Choice #4" with value "Check 4"
    And User fills in choice score on position 4 value "3"
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring scheme. If you want to proceed, all scoring schemes will be deleted. |
    When User clicks Cancel warning button
    Then Question Choice "Choice #4" value is "0"
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Scores are displayed on scoring table with provided details
    When User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    And User fills in choice score on position 4 value "3"
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring scheme. If you want to proceed, all scoring schemes will be deleted. |
    When User clicks Proceed warning button
    Then Question Choice "Choice #4" value is "3"
    When User clicks Questionnaire Setup button "Next"
    Then Scoring tab contains message "No Scoring Scheme is Available"
    When User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Configuration icon
    Then Question configuration Choices contain expected data "Question with 4 Choices"
    When User fills in choice score on position 1 value "1"
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring scheme. If you want to proceed, all scoring schemes will be deleted. |
    When User clicks Cancel warning button
    Then Question Choice "Choice #1" value is "0"
    When User fills in choice score on position 1 value "1"
    And User clicks Proceed warning button
    Then Question Choice "Choice #1" value is "1"
    When User clicks Questionnaire Setup button "Next"
    Then Scoring tab contains message "No Scoring Scheme is Available"
    When User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    And User fills in choice score on position 2 value "1"
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring scheme. If you want to proceed, all scoring schemes will be deleted. |
    When User clicks Cancel warning button
    Then Question Choice "Choice #2" value is "25"
    When User fills in choice score on position 2 value "1"
    And User clicks Proceed warning button
    Then Question Choice "Choice #2" value is "1"
    When User clicks Questionnaire Setup button "Next"
    Then Scoring tab contains message "No Scoring Scheme is Available"
    Examples:
      | questionType    |
      | Checkbox        |
      | SingleSelect    |
      | MultiSelect     |
      | Multiple Choice |

  @C46633152
  Scenario: C46633152: [Questionnaire] - Add/Edit - Question Tab: Add/Edit Score - with existing Scoring Scheme - Boolean Choices
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User fills in choice score on position 1 value "250"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Configuration icon
    And User fills in choice score on position 2 value "1"
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring scheme. If you want to proceed, all scoring schemes will be deleted. |
    When User clicks Cancel warning button
    Then Question Choice "Choice #2" value is "0"
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Scores are displayed on scoring table with provided details
    When User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    And User fills in choice score on position 2 value "1"
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring scheme. If you want to proceed, all scoring schemes will be deleted. |
    When User clicks Proceed warning button
    Then Question Choice "Choice #2" value is "1"
    When User clicks Questionnaire Setup button "Next"
    Then Scoring tab contains message "No Scoring Scheme is Available"
    When User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Configuration icon
    Then Question Choice "Choice #1" value is "250"
    And Question Choice "Choice #2" value is "1"
    When User fills in choice score on position 2 value "2"
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring scheme. If you want to proceed, all scoring schemes will be deleted. |
    When User clicks Cancel warning button
    Then Question Choice "Choice #2" value is "1"
    When User fills in choice score on position 2 value "2"
    And User clicks Proceed warning button
    Then Question Choice "Choice #2" value is "2"
    When User clicks Questionnaire Setup button "Next"
    Then Scoring tab contains message "No Scoring Scheme is Available"

  @C47335970
  Scenario Outline: C47335970: [Questionnaire] - Add/Edit - Question Tab: "Calculate highest score only" setting for Multiselect, Checkbox - with existing Scoring Scheme
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "<questionType>" to active tab
    And User clicks Configuration icon
    And User configures question with data "Question with 3 Choices"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Configuration icon
    And User turns On Calculate Highest Score Only question button
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring scheme. If you want to proceed, all scoring schemes will be deleted. |
    When User clicks Cancel warning button
    Then Question Calculate Highest Score Only is turned Off
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Scores are displayed on scoring table with provided details
    When User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    And User turns On Calculate Highest Score Only question button
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring scheme. If you want to proceed, all scoring schemes will be deleted. |
    When User clicks Proceed warning button
    Then Question Calculate Highest Score Only is turned On
    When User clicks Questionnaire Setup button "Next"
    Then Scoring tab contains message "No Scoring Scheme is Available"
    When User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Question configuration Choices contain expected data "Question with 3 Choices"
    And Question Calculate Highest Score Only is turned On
    When User turns Off Calculate Highest Score Only question button
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring scheme. If you want to proceed, all scoring schemes will be deleted. |
    When User clicks Cancel warning button
    Then Question Calculate Highest Score Only is turned On
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Scores are displayed on scoring table with provided details
    When User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    And User turns Off Calculate Highest Score Only question button
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring scheme. If you want to proceed, all scoring schemes will be deleted. |
    When User clicks Proceed warning button
    Then Question Calculate Highest Score Only is turned Off
    When User clicks Questionnaire Setup button "Next"
    Then Scoring tab contains message "No Scoring Scheme is Available"
    Examples:
      | questionType |
      | Checkbox     |
      | MultiSelect  |

  @C47337753
  Scenario Outline: C47337753: [Questionnaire] - Add/Edit - Question Tab: Mapping Multi select, Single select with Manage Data Values- with existing Scoring Scheme
    When User creates Custom Field "active <questionType> type" via API
    And User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "<questionType>" to active tab
    And User clicks Add question tab button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Text" to active tab
    And User clicks on Question tab with index 0
    And User clicks Configuration icon
    And User configures question with data "Multi Choices Question with 4 Choices and branching"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Mapping icon
    Then Question drop-down "Map To" selected value is "None"
    When User selects Question "Map To" "Update Custom Fields" drop-down value
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring & branching setting. If you want to proceed, scoring & branching settings will be automatically removed. |
    When User clicks Cancel warning button
    Then Question drop-down "Map To" selected value is "None"
    When User selects Question "Map To" "Update Custom Fields" drop-down value
    And User clicks Proceed warning button
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    And User clicks Mapping icon
    And User clicks Configuration icon
    Then Question configuration contains expected data "<questionType> with Custom Field values"
    When User fills in choice score on position 1 value "10"
    And User fills in choice score on position 2 value "20"
    And User fills in choice score on position 3 value "30"
    And User clicks Questionnaire Setup button "Next"
    Then Scoring tab contains message "No Scoring Scheme is Available"
    When User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks "Question" questionnaire tab
    And User clicks Mapping icon
    And User selects Question "Map To" "None" drop-down value
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring & branching setting. If you want to proceed, scoring & branching settings will be automatically removed. |
    When User clicks Cancel warning button
    Then Question drop-down "Map To" selected value is "Update Custom Fields"
    When User selects Question "Map To" "None" drop-down value
    And User clicks Proceed warning button
    And User clicks Mapping icon
    And User clicks Configuration icon
    Then Questionnaire choices with label "Choice #" 2 options are displayed
    And Question Choice "Choice #1" value is "0"
    And Question Choice "Choice #2" value is "0"
    When User clicks Questionnaire Setup button "Next"
    Then Scoring tab contains message "No Scoring Scheme is Available"
    Examples:
      | questionType |
      | SingleSelect |
      | MultiSelect  |

  @C47361047
    @RMS-30721
  Scenario Outline: C47361047: [Questionnaire] - Add/Edit - Question Tab: Mapping Multi select, Single select with "Map to*" Values- with existing Scoring Scheme
    When User creates Custom Field "active <questionType> type map to <mapTo>" via API
    And User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "<questionType>" to active tab
    And User clicks Add question tab button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Text" to active tab
    And User clicks on Question tab with index 0
    And User clicks Configuration icon
    And User configures question with data "Multi Choices Question with 4 Choices and branching"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Mapping icon
    Then Question drop-down "Map To" selected value is "None"
    When User selects Question "Map To" "Update Custom Fields" drop-down value
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring & branching setting. If you want to proceed, scoring & branching settings will be automatically removed. |
    When User clicks Cancel warning button
    Then Question drop-down "Map To" selected value is "None"
    When User selects Question "Map To" "Update Custom Fields" drop-down value
    And User clicks Proceed warning button
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    And User clicks Mapping icon
    And User clicks Configuration icon
#    TODO update step implementation when RMS-30721 will be fixed
    Then Question configuration contains expected data "<questionType> with mapped values" with Custom Field mapped "<mapTo>" choices
    When User fills in choice score on position <valuePosition> value "250"
    And User clicks Questionnaire Setup button "Next"
    Then Scoring tab contains message "No Scoring Scheme is Available"
    When User clicks Add Scoring Scheme questionnaire button
    And User fills "Scheme 1: 1-50 range" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks "Question" questionnaire tab
    And User clicks Mapping icon
    And User selects Question "Map To" "None" drop-down value
    Then Warning Message is displayed with text
      | This action will have an effect to the scoring & branching setting. If you want to proceed, scoring & branching settings will be automatically removed. |
    When User clicks Cancel warning button
    Then Question drop-down "Map To" selected value is "Update Custom Fields"
    When User selects Question "Map To" "None" drop-down value
    And User clicks Proceed warning button
    And User clicks Mapping icon
    And User clicks Configuration icon
    Then Questionnaire choices with label "Choice #" 2 options are displayed
    And Question Choice "Choice #1" value is "0"
    And Question Choice "Choice #2" value is "0"
    When User clicks Questionnaire Setup button "Next"
    Then Scoring tab contains message "No Scoring Scheme is Available"
    Examples:
      | questionType | mapTo          | valuePosition |
      | SingleSelect | Country        | 229           |
      | MultiSelect  | Region         | 26            |
      | SingleSelect | Commodity Type | 40            |
      | MultiSelect  | Industry Type  | 54            |
      | MultiSelect  | Risk Tier      | 1             |

  @C48284066
  Scenario: C48284066: [Questionnaire] - Edit Question Tab: default view
    When User creates Custom Field "active SingleSelect type" via API
    And User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Add question tab button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Text" to active tab
    And User clicks on Question tab with index 0
    And User adds question with type "SingleSelect" to active tab
    And User clicks Mapping icon
    And User selects Question "Map To" "Update Custom Fields" drop-down value
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    And User clicks Configuration icon
    And User configures question with data "SingleSelect with Custom Field values"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    When User clicks "Question" questionnaire tab
    Then Questionnaire tab displayed in edit mode
    When User clicks Configuration icon
    Then Question configuration Choices contain expected data "SingleSelect with Custom Field values"
    When User clicks Configuration icon
    And User adds question with type "Text" to active tab
    Then Questionnaire question tab counter with value "2" is displayed for tab on position 1
    When User clicks delete question button for question on position 2
    Then Questionnaire question tab counter with value "1" is displayed for tab on position 1
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks edit added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in edit mode
    When User clicks "Question" questionnaire tab
    Then Questionnaire tab displayed in edit mode
    When User clicks Configuration icon
    Then Question configuration Choices contain expected data "SingleSelect with Custom Field values"
    When User clicks Configuration icon
    And User adds question with type "Text" to active tab
    Then Questionnaire question tab counter with value "2" is displayed for tab on position 1
    When User clicks delete question button for question on position 2
    Then Questionnaire question tab counter with value "1" is displayed for tab on position 1

  @C48296160
  Scenario: C48296160: [Questionnaire] - Edit Question Tab for "Save As Draft" Questionnaire
    When User creates Custom Field "active MultiSelect type" via API
    And User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Add question tab button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Text" to active tab
    And User clicks on Question tab with index 0
    And User adds question with type "Boolean" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "Currency" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User clicks Configuration icon for Question "MultiSelect"
    And User configures question with data "Multi Choices with Custom Field updated values"
    And User clicks Mapping icon
    And User selects Question "Map To" "Update Custom Fields" drop-down value
    And User clicks Proceed warning button
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in edit mode
    When User clicks "Question" questionnaire tab
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User clicks Configuration icon for Question "Multi Choices"
    Then Question configuration contains expected data "MultiSelect with Custom Field values"
    When User clicks Configuration icon
    And User adds question with type "Text" to active tab
    And User adds question with type "Text" to active tab
    Then Questionnaire question tab counter with value "14" is displayed for tab on position 1
    When User clicks delete question button for question on position 1
    Then Questionnaire question tab counter with value "13" is displayed for tab on position 1
    When User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    Then Questionnaire question tab counter with value "12" is displayed for tab on position 1
    When User clicks Configuration icon for Question "Multi Choices"
    Then Question configuration contains expected data "MultiSelect with Custom Field values"
    When User clicks Configuration icon
    And User adds question with type "Text" to active tab
    Then Questionnaire question tab counter with value "13" is displayed for tab on position 1
    When User clicks Questionnaire Setup button "Next"
    And User clicks "Question" questionnaire tab
    Then Questionnaire question tab counter with value "13" is displayed for tab on position 1
    When User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks on added questionnaire
    And User clicks "Question" questionnaire tab
    Then Questionnaire question tab counter with value "13" is displayed for tab on position 1

  @C48296187
  Scenario Outline: C48296187: [Questionnaire] - Edit Question Tab for Published Questionnaire (Active or Inactive Status)
    When User creates Custom Field "active MultiSelect type" via API
    And User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Add question tab button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Text" to active tab
    And User clicks on Question tab with index 0
    And User adds question with type "Boolean" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "Currency" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User clicks Configuration icon for Question "MultiSelect"
    And User configures question with data "Multi Choices with Custom Field updated values"
    And User clicks Mapping icon
    And User selects Question "Map To" "Update Custom Fields" drop-down value
    And User clicks Proceed warning button
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User selects "<status>" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in edit mode
    When User clicks "Question" questionnaire tab
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User clicks Configuration icon for Question "Multi Choices"
    Then Question configuration contains expected data "MultiSelect with Custom Field values"
    When User clicks Configuration icon
    And User adds question with type "Text" to active tab
    And User adds question with type "Text" to active tab
    Then Questionnaire question tab counter with value "14" is displayed for tab on position 1
    When User clicks delete question button for question on position 1
    Then Questionnaire question tab counter with value "13" is displayed for tab on position 1
    When User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    Then Questionnaire question tab counter with value "12" is displayed for tab on position 1
    When User clicks Configuration icon for Question "Multi Choices"
    Then Question configuration contains expected data "MultiSelect with Custom Field values"
    When User clicks Configuration icon
    And User adds question with type "Text" to active tab
    Then Questionnaire question tab counter with value "13" is displayed for tab on position 1
    When User clicks Questionnaire Setup button "Next"
    And User clicks "Question" questionnaire tab
    Then Questionnaire question tab counter with value "13" is displayed for tab on position 1
    When User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "<status>"
    When User clicks on added questionnaire
    And User clicks "Question" questionnaire tab
    Then Questionnaire question tab counter with value "13" is displayed for tab on position 1
    Examples:
      | status   |
      | Inactive |
      | Active   |
