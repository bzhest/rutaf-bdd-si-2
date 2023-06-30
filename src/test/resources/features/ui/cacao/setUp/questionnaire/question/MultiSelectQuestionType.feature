@ui @cacao @functional @questionnaires @question
Feature: Questionnaire Management - Question Tab - Multi Select Question Type

  As Admin or Internal User that has access rights in User Management
  I want to setup questions
  So that User will be able to set up different question type, description and choices

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"

  @C46740446
  Scenario: C46740446: [Questionnaire] - Add/Edit Question - Multi Select - Responder tab
    Then Questionnaire setup "Tab One" tab is selected
    When User adds question with type "MultiSelect" to active tab
    Then Questionnaire "MultiSelect" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "MultiSelect" configuration section appears with expected elements for "Responder use"
    And Questionnaire choices "Choice #" Delete buttons are not displayed
    And Questionnaire choices counter is "Choices: 2/250"
    When User clicks Add button for question "Choice #2" choice
    Then Questionnaire choices with label "Choice #" 3 options are displayed
    And Questionnaire choices "Choice #" Delete buttons are displayed
    And Questionnaire choices counter is "Choices: 3/250"
    When User clicks Delete button for question "Choice #3" choice
    Then Questionnaire choices with label "Choice #" 2 options are displayed
    And Questionnaire choices counter is "Choices: 2/250"
    When User clicks Add button for question "Choice #2" choice
    And User clicks Add button for question "Choice #3" choice
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Choice #" 4 options are displayed
    When User clicks Questionnaire question configuration "See less" button
    Then Questionnaire question configuration "See more" button is displayed
    And Questionnaire choices with label "Choice #" 3 options are displayed
    When User clicks Questionnaire question configuration "See more" button
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Choice #" 4 options are displayed
    When User configures question with data "MultiSelect question configuration with 5 choices"
    Then Questionnaire choices counter is "Choices: 5/250"
    When User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Question configuration contains expected data "MultiSelect question configuration with 5 choices"
    When User configures question with data "MultiSelect question configuration with 6 choices"
    Then Questionnaire choices counter is "Choices: 6/250"
    When User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Question configuration contains expected data "MultiSelect question configuration with 6 choices"

  @C46740447
  Scenario: C46740447: [Questionnaire] - Add/Edit Question - Multi Select - Reviewer tab - changed MultiSelect of reviewers
    When User adds question with type "MultiSelect" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "MultiSelect" to active tab
    Then Questionnaire "MultiSelect" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "MultiSelect" configuration section appears with expected elements for "Reviewer use"
    When User clicks Add button for question "Choice #2" choice
    Then Questionnaire choices with label "Choice #" 3 options are displayed
    And Questionnaire choices "Choice #" Delete buttons are displayed
    And Questionnaire choices counter is "Choices: 3/250"
    When User clicks Delete button for question "Choice #3" choice
    Then Questionnaire choices with label "Choice #" 2 options are displayed
    And Questionnaire choices counter is "Choices: 2/250"
    When User clicks Add button for question "Choice #2" choice
    And User clicks Add button for question "Choice #3" choice
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Choice #" 4 options are displayed
    When User clicks Questionnaire question configuration "See less" button
    Then Questionnaire question configuration "See more" button is displayed
    And Questionnaire choices with label "Choice #" 3 options are displayed
    When User clicks Questionnaire question configuration "See more" button
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Choice #" 4 options are displayed
    When User configures question with data "MultiSelect question configuration"
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
    When User configures question with data "MultiSelect question configuration with Level 2 reviewer"
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
    Then Question configuration contains expected data "MultiSelect question configuration with Level 2 reviewer"

  @C46740449
  Scenario Outline: C46740449: [Questionnaire] - Add/Edit Question - Multi Select - Bulk Choices - Add
    When User adds question with type "MultiSelect" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "<tabType>" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "MultiSelect" to active tab
    And User clicks Configuration icon
    Then Questionnaire Setup button "Add Bulk Choices" is displayed
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    Then Questionnaire Add Bulk 250 Choices modal is displayed with default elements
    When User fills in Bulk Choices values
      | 4DdkyVBA5Qn9AfPRi2LdCR8xbmMPbHQt9d6G6TjEHFgx7WuiWP92zagYOD0pGE1A08kjMGl0EqvnGUsp95NPgt3noHjo4thl1sOeEgJ4vPuqaCAThnmJQaacAX1d1DEitzIFcy3HVUvn3GIG9IU6ZvAQxO5a16KRdzjHsQRZ3sdLuDQUfdf8U9zoM0PjLRiJn39uXdwym0fUacuq7BFz2ZFkcOhrGrhJRC0EifOU0rLbLE2y4Xgyp0P8EZvpSrq0l9NurFGLQGNWLNeWN72NYyXTuNzALfMpGfXA6NWylQkGDNG7YejbgpwkqeCIAP3jmFYSLgZBPfV2kOti4ggkbVaUHtI367TtPxWowIWv4ENH2qlRuWJUvdII0yYEWCDamN0mkJb0zVDO9wb5bKUdB4qYm2pi7KS3EFxCBFJnJHLtvNoTyFuHTfp4x436xjHFPhOZOm1zNKwqfwmYD4G69Vk8NA7vq4WPyimMDQJ2wqrA9IjFn4aOS\|1 |
      | 5\|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 6\|12345                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
    Then Questionnaire Add Bulk Choices modal button "Add Bulk Choices" is enabled
    When User clicks Questionnaire Add Bulk Choices button "Cancel"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Questionnaire "MultiSelect" configuration section appears with expected elements for "<tabType>"
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    Then Questionnaire Add Bulk 250 Choices modal is displayed with default elements
    When User fills in Bulk Choices values
      | 4DdkyVBA5Qn9AfPRi2LdCR8xbmMPbHQt9d6G6TjEHFgx7WuiWP92zagYOD0pGE1A08kjMGl0EqvnGUsp95NPgt3noHjo4thl1sOeEgJ4vPuqaCAThnmJQaacAX1d1DEitzIFcy3HVUvn3GIG9IU6ZvAQxO5a16KRdzjHsQRZ3sdLuDQUfdf8U9zoM0PjLRiJn39uXdwym0fUacuq7BFz2ZFkcOhrGrhJRC0EifOU0rLbLE2y4Xgyp0P8EZvpSrq0l9NurFGLQGNWLNeWN72NYyXTuNzALfMpGfXA6NWylQkGDNG7YejbgpwkqeCIAP3jmFYSLgZBPfV2kOti4ggkbVaUHtI367TtPxWowIWv4ENH2qlRuWJUvdII0yYEWCDamN0mkJb0zVDO9wb5bKUdB4qYm2pi7KS3EFxCBFJnJHLtvNoTyFuHTfp4x436xjHFPhOZOm1zNKwqfwmYD4G69Vk8NA7vq4WPyimMDQJ2wqrA9IjFn4aOS\|1 |
      | 5\|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 6\|12345                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Question configuration Choices contain expected data "MultiSelect question configuration with 5 choices bulk added"
    And Questionnaire Setup button "Add Bulk Choices" is enabled
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    And User fills in 25 Bulk Choices "question #1" values
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Questionnaire Setup button "Add Bulk Choices" is enabled
    When User clicks Configuration icon
    And User clicks Configuration icon
    Then Question configuration Choices contain added "question #1" Bulk Choices
    When User clicks Configuration icon
    And User adds question with type "MultiSelect" to active tab
    And User clicks Configuration icon for Question on position 2
    And User clicks Questionnaire Setup button "Add Bulk Choices"
    And User fills in 250 Bulk Choices "question #2" values
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Questionnaire Setup button "Add Bulk Choices" is disabled
    And Question configuration Choices contain added "question #2" Bulk Choices
    When User clicks Delete button for question Choice #250 bulk added "question #2" Bulk Choices
    Then Questionnaire Setup button "Add Bulk Choices" is enabled
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    And User fills in 2 Bulk Choices "question #2" values
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    When User clicks Configuration icon
    And User clicks Configuration icon for Question on position 2
    Then Question configuration Choices contain added "question #2" Bulk Choices
    When User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<button>"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon for Question on position 1
    Then Question configuration Choices contain added "question #1" Bulk Choices
    When User clicks Configuration icon
    And User clicks Configuration icon for Question on position 2
    Then Question configuration Choices contain added "question #2" Bulk Choices
    Examples:
      | tabType       | button        |
      | Reviewer use  | Save          |
      | Responder use | Save as draft |

  @C46740449
  Scenario Outline: C46740449: [Questionnaire] - Add/Edit Question - Multi Select - Bulk Choices - Edit
    When User adds question with type "MultiSelect" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<button>"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Add question tab button
    And User clicks Create tab "<tabType>" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "MultiSelect" to active tab
    And User clicks Configuration icon
    Then Questionnaire Setup button "Add Bulk Choices" is displayed
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    Then Questionnaire Add Bulk 250 Choices modal is displayed with default elements
    When User fills in Bulk Choices values
      | 4DdkyVBA5Qn9AfPRi2LdCR8xbmMPbHQt9d6G6TjEHFgx7WuiWP92zagYOD0pGE1A08kjMGl0EqvnGUsp95NPgt3noHjo4thl1sOeEgJ4vPuqaCAThnmJQaacAX1d1DEitzIFcy3HVUvn3GIG9IU6ZvAQxO5a16KRdzjHsQRZ3sdLuDQUfdf8U9zoM0PjLRiJn39uXdwym0fUacuq7BFz2ZFkcOhrGrhJRC0EifOU0rLbLE2y4Xgyp0P8EZvpSrq0l9NurFGLQGNWLNeWN72NYyXTuNzALfMpGfXA6NWylQkGDNG7YejbgpwkqeCIAP3jmFYSLgZBPfV2kOti4ggkbVaUHtI367TtPxWowIWv4ENH2qlRuWJUvdII0yYEWCDamN0mkJb0zVDO9wb5bKUdB4qYm2pi7KS3EFxCBFJnJHLtvNoTyFuHTfp4x436xjHFPhOZOm1zNKwqfwmYD4G69Vk8NA7vq4WPyimMDQJ2wqrA9IjFn4aOS\|1 |
      | 5\|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 6\|12345                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
    Then Questionnaire Add Bulk Choices modal button "Add Bulk Choices" is enabled
    When User clicks Questionnaire Add Bulk Choices button "Cancel"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Questionnaire "MultiSelect" configuration section appears with expected elements for "<tabType>"
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    Then Questionnaire Add Bulk 250 Choices modal is displayed with default elements
    When User fills in Bulk Choices values
      | 4DdkyVBA5Qn9AfPRi2LdCR8xbmMPbHQt9d6G6TjEHFgx7WuiWP92zagYOD0pGE1A08kjMGl0EqvnGUsp95NPgt3noHjo4thl1sOeEgJ4vPuqaCAThnmJQaacAX1d1DEitzIFcy3HVUvn3GIG9IU6ZvAQxO5a16KRdzjHsQRZ3sdLuDQUfdf8U9zoM0PjLRiJn39uXdwym0fUacuq7BFz2ZFkcOhrGrhJRC0EifOU0rLbLE2y4Xgyp0P8EZvpSrq0l9NurFGLQGNWLNeWN72NYyXTuNzALfMpGfXA6NWylQkGDNG7YejbgpwkqeCIAP3jmFYSLgZBPfV2kOti4ggkbVaUHtI367TtPxWowIWv4ENH2qlRuWJUvdII0yYEWCDamN0mkJb0zVDO9wb5bKUdB4qYm2pi7KS3EFxCBFJnJHLtvNoTyFuHTfp4x436xjHFPhOZOm1zNKwqfwmYD4G69Vk8NA7vq4WPyimMDQJ2wqrA9IjFn4aOS\|1 |
      | 5\|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 6\|12345                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Question configuration Choices contain expected data "MultiSelect question configuration with 5 choices bulk added"
    And Questionnaire Setup button "Add Bulk Choices" is enabled
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    And User fills in 25 Bulk Choices "question #1" values
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Questionnaire Setup button "Add Bulk Choices" is enabled
    When User clicks Configuration icon
    And User clicks Configuration icon
    Then Question configuration Choices contain added "question #1" Bulk Choices
    When User clicks Configuration icon
    And User adds question with type "MultiSelect" to active tab
    And User clicks Configuration icon for Question on position 2
    And User clicks Questionnaire Setup button "Add Bulk Choices"
    And User fills in 250 Bulk Choices "question #2" values
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Questionnaire Setup button "Add Bulk Choices" is disabled
    And Question configuration Choices contain added "question #2" Bulk Choices
    When User clicks Delete button for question "Choice #250" choice
    Then Questionnaire Setup button "Add Bulk Choices" is enabled
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    And User fills in 2 Bulk Choices "question #2" values
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    When User clicks Configuration icon
    And User clicks Configuration icon for Question on position 2
    Then Question configuration Choices contain added "question #2" Bulk Choices
    When User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<button>"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon for Question on position 1
    Then Question configuration Choices contain added "question #1" Bulk Choices
    When User clicks Configuration icon
    And User clicks Configuration icon for Question on position 2
    Then Question configuration Choices contain added "question #2" Bulk Choices
    Examples:
      | tabType       | button        |
      | Reviewer use  | Save          |
      | Responder use | Save as draft |

  @C46740450
  Scenario Outline: C46740450: [Questionnaire] - Add/Edit Question - Multi Select - Mapping
    When User creates Custom Field "active Multi Select type" via API
    And User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "MultiSelect" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "<tabType>" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "MultiSelect" to active tab
    And User clicks Mapping icon
    Then Question drop-down "Map To" selected value is "None"
    When User selects Question "Map To" "Update Custom Fields" drop-down value
    Then Question Mapping section is displayed with default data for "MultiSelect" question type
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