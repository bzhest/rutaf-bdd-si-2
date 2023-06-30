@ui @cacao @functional @questionnaires @question
Feature: Questionnaire Management - Question Tab - Mapping Improvement

  As Admin or Internal User that has access rights in User Management
  I want to have an option to preview the questionnaire
  So that User can review the questionnaire


  @C47835327
  Scenario Outline: C47835327: [Questionnaire] - Add/Edit Question - Mapping - Validation for used custom field
    Given User logs into RDDC as "Admin"
    When User creates Custom Field "<customField>" via API
    And User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "<questionType>" to active tab
    And User clicks Mapping icon
    And User selects Question "Map To" "Update Custom Fields" drop-down value
    And User selects Question "Custom Fields" "customFieldName" drop-down value
    And User clicks Mapping icon
    And User clicks Mapping icon
    Then Question drop-down "Custom Fields" selected value is "customFieldName"
    When User clicks Mapping icon
    And User adds question with type "<questionType>" to active tab
    And User clicks Mapping icon for Question on position 2
    And User selects Question "Map To" "Update Custom Fields" drop-down value
    Then Question "Custom Fields" drop-down value "customFieldName" is disabled
    When User selects Question "Custom Fields" "firstAvailableValue" drop-down value
    And User clicks Mapping icon
    And User clicks Mapping icon for Question on position 2
    Then Question drop-down "Custom Fields" selected value is "firstAvailableValue"
    Examples:
      | questionType | customField                             |
      | Date         | active with random name and Date type   |
      | SingleSelect | active Single Select type               |
      | MultiSelect  | active Multi Select type                |
      | Number       | active with random name and Number type |
