@ui @cacao @functional @questionnaires @question
Feature: Questionnaire Management - Question Tab - Checkbox Question Type

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"

  @C46633055
  Scenario: C46633055: [Questionnaire] - Add/Edit Question - Checkbox - Responder tab
    Then Questionnaire setup "Tab One" tab is selected
    When User adds question with type "Checkbox" to active tab
    Then Questionnaire "Checkbox" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Checkbox" configuration section appears with expected elements for "Responder use"
    When User clicks Delete button for question "Choice #3" choice
    Then Questionnaire choices with label "Choice #" 2 options are displayed
    And Questionnaire choices "Choice #" Delete buttons are not displayed
    And Questionnaire choices counter is "Choices: 2/25"
    When User clicks Add button for question "Choice #2" choice
    Then Questionnaire choices with label "Choice #" 3 options are displayed
    And Questionnaire choices "Choice #" Delete buttons are displayed
    And Questionnaire choices counter is "Choices: 3/25"
    When User clicks Add button for question "Choice #3" choice
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Choice #" 4 options are displayed
    When User clicks Questionnaire question configuration "See less" button
    Then Questionnaire question configuration "See more" button is displayed
    And Questionnaire choices with label "Choice #" 3 options are displayed
    When User clicks Questionnaire question configuration "See more" button
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Choice #" 4 options are displayed
    When User configures question with data "Checkbox question configuration with 25 choices"
    Then Questionnaire choices counter is "Choices: 25/25"
    And Questionnaire choices "Choice #" Add buttons are not displayed
    When User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Question configuration contains expected data "Checkbox question configuration with 25 choices"

  @C46633124
  Scenario: C46633124: [Questionnaire] - Add/Edit Question - Checkbox - Reviewer tab - changed number of reviewers
    When User adds question with type "Checkbox" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Checkbox" to active tab
    Then Questionnaire "Checkbox" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "Checkbox" configuration section appears with expected elements for "Reviewer use"
    When User clicks Delete button for question "Choice #3" choice
    Then Questionnaire choices with label "Choice #" 2 options are displayed
    And Questionnaire choices "Choice #" Delete buttons are not displayed
    And Questionnaire choices counter is "Choices: 2/25"
    When User clicks Add button for question "Choice #2" choice
    Then Questionnaire choices with label "Choice #" 3 options are displayed
    And Questionnaire choices "Choice #" Delete buttons are displayed
    And Questionnaire choices counter is "Choices: 3/25"
    When User clicks Add button for question "Choice #3" choice
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Choice #" 4 options are displayed
    When User clicks Questionnaire question configuration "See less" button
    Then Questionnaire question configuration "See more" button is displayed
    And Questionnaire choices with label "Choice #" 3 options are displayed
    When User clicks Questionnaire question configuration "See more" button
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Choice #" 4 options are displayed
    When User configures question with data "Checkbox question configuration"
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
    When User configures question with data "Checkbox question configuration with Level 2 reviewer"
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
    Then Question configuration contains expected data "Checkbox question configuration with Level 2 reviewer"

  @C46641073
  Scenario Outline: C46641073: [Questionnaire] - Add/Edit Question - Checkbox - Bulk Choices - Add
    When User adds question with type "Checkbox" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "<tabType>" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Checkbox" to active tab
    And User clicks Configuration icon
    Then Questionnaire Setup button "Add Bulk Choices" is displayed
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    Then Questionnaire Add Bulk 25 Choices modal is displayed with default elements
    When User fills in Bulk Choices values
      | 4DdkyVBA5Qn9AfPRi2LdCR8xbmMPbHQt9d6G6TjEHFgx7WuiWP92zagYOD0pGE1A08kjMGl0EqvnGUsp95NPgt3noHjo4thl1sOeEgJ4vPuqaCAThnmJQaacAX1d1DEitzIFcy3HVUvn3GIG9IU6ZvAQxO5a16KRdzjHsQRZ3sdLuDQUfdf8U9zoM0PjLRiJn39uXdwym0fUacuq7BFz2ZFkcOhrGrhJRC0EifOU0rLbLE2y4Xgyp0P8EZvpSrq0l9NurFGLQGNWLNeWN72NYyXTuNzALfMpGfXA6NWylQkGDNG7YejbgpwkqeCIAP3jmFYSLgZBPfV2kOti4ggkbVaUHtI367TtPxWowIWv4ENH2qlRuWJUvdII0yYEWCDamN0mkJb0zVDO9wb5bKUdB4qYm2pi7KS3EFxCBFJnJHLtvNoTyFuHTfp4x436xjHFPhOZOm1zNKwqfwmYD4G69Vk8NA7vq4WPyimMDQJ2wqrA9IjFn4aOS\|1 |
      | 5\|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 6\|12345                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
    Then Questionnaire Add Bulk Choices modal button "Add Bulk Choices" is enabled
    When User clicks Questionnaire Add Bulk Choices button "Cancel"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Questionnaire "Checkbox" configuration section appears with expected elements for "<tabType>"
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    Then Questionnaire Add Bulk 25 Choices modal is displayed with default elements
    When User fills in Bulk Choices values
      | 4DdkyVBA5Qn9AfPRi2LdCR8xbmMPbHQt9d6G6TjEHFgx7WuiWP92zagYOD0pGE1A08kjMGl0EqvnGUsp95NPgt3noHjo4thl1sOeEgJ4vPuqaCAThnmJQaacAX1d1DEitzIFcy3HVUvn3GIG9IU6ZvAQxO5a16KRdzjHsQRZ3sdLuDQUfdf8U9zoM0PjLRiJn39uXdwym0fUacuq7BFz2ZFkcOhrGrhJRC0EifOU0rLbLE2y4Xgyp0P8EZvpSrq0l9NurFGLQGNWLNeWN72NYyXTuNzALfMpGfXA6NWylQkGDNG7YejbgpwkqeCIAP3jmFYSLgZBPfV2kOti4ggkbVaUHtI367TtPxWowIWv4ENH2qlRuWJUvdII0yYEWCDamN0mkJb0zVDO9wb5bKUdB4qYm2pi7KS3EFxCBFJnJHLtvNoTyFuHTfp4x436xjHFPhOZOm1zNKwqfwmYD4G69Vk8NA7vq4WPyimMDQJ2wqrA9IjFn4aOS\|1 |
      | 5\|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 6\|12345                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Question configuration Choices contain expected data "Checkbox question configuration with 6 choices bulk added"
    And Questionnaire Setup button "Add Bulk Choices" is enabled
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    And User fills in Bulk Choices values
      | 7\|7    |
      | 8\|1    |
      | 9\|1234 |
      | 10\|1   |
      | 11\|0   |
      | 12\|1   |
      | 13\|1   |
      | 14\|1   |
      | 15\|1   |
      | 16\|1   |
      | 17\|1   |
      | 18\|1   |
      | 19\|1   |
      | 20\|1   |
      | 21\|1   |
      | 22\|22  |
      | 23\|23  |
      | 24\|1   |
      | 25\|1   |
      | 26\|1   |
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Questionnaire Setup button "Add Bulk Choices" is disabled
    When User clicks Configuration icon
    And User clicks Configuration icon
    Then Question configuration Choices contain expected data "Checkbox question configuration with 25 choices bulk added"
    When User clicks Configuration icon
    And User adds question with type "Checkbox" to active tab
    And User clicks Configuration icon for Question on position 2
    And User clicks Questionnaire Setup button "Add Bulk Choices"
    And User fills in Bulk Choices values
      | 4DdkyVBA5Qn9AfPRi2LdCR8xbmMPbHQt9d6G6TjEHFgx7WuiWP92zagYOD0pGE1A08kjMGl0EqvnGUsp95NPgt3noHjo4thl1sOeEgJ4vPuqaCAThnmJQaacAX1d1DEitzIFcy3HVUvn3GIG9IU6ZvAQxO5a16KRdzjHsQRZ3sdLuDQUfdf8U9zoM0PjLRiJn39uXdwym0fUacuq7BFz2ZFkcOhrGrhJRC0EifOU0rLbLE2y4Xgyp0P8EZvpSrq0l9NurFGLQGNWLNeWN72NYyXTuNzALfMpGfXA6NWylQkGDNG7YejbgpwkqeCIAP3jmFYSLgZBPfV2kOti4ggkbVaUHtI367TtPxWowIWv4ENH2qlRuWJUvdII0yYEWCDamN0mkJb0zVDO9wb5bKUdB4qYm2pi7KS3EFxCBFJnJHLtvNoTyFuHTfp4x436xjHFPhOZOm1zNKwqfwmYD4G69Vk8NA7vq4WPyimMDQJ2wqrA9IjFn4aOS\|1 |
      | 5\|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 6\|12345                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | 7\|7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
      | 8\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
      | 9\|1234                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
      | 10\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 11\|0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 12\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 13\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 14\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 15\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 16\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 17\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 18\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 19\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 20\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 21\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 22\|22                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
      | 23\|23                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
      | 24\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 25\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Questionnaire Setup button "Add Bulk Choices" is disabled
    And Question configuration Choices contain expected data "Checkbox question configuration with 25 choices bulk added"
    When User clicks Delete button for question "Choice #25" choice
    Then Questionnaire Setup button "Add Bulk Choices" is enabled
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    And User fills in Bulk Choices values
      | 25\|1 |
      | 26\|1 |
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    When User clicks Configuration icon
    And User clicks Configuration icon for Question on position 2
    Then Question configuration Choices contain expected data "Checkbox question configuration with 25 choices bulk added"
    When User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<button>"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon for Question on position 1
    Then Question configuration Choices contain expected data "Checkbox question configuration with 25 choices bulk added"
    When User clicks Configuration icon
    And User clicks Configuration icon for Question on position 2
    Then Question configuration Choices contain expected data "Checkbox question configuration with 25 choices bulk added"
    Examples:
      | tabType       | button        |
      | Reviewer use  | Save          |
      | Responder use | Save as draft |

  @C46641073
  Scenario Outline: C46641073: [Questionnaire] - Add/Edit Question - Checkbox - Bulk Choices - Edit
    When User adds question with type "Checkbox" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<button>"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Add question tab button
    And User clicks Create tab "<tabType>" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Checkbox" to active tab
    And User clicks Configuration icon
    Then Questionnaire Setup button "Add Bulk Choices" is displayed
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    Then Questionnaire Add Bulk 25 Choices modal is displayed with default elements
    When User fills in Bulk Choices values
      | 4DdkyVBA5Qn9AfPRi2LdCR8xbmMPbHQt9d6G6TjEHFgx7WuiWP92zagYOD0pGE1A08kjMGl0EqvnGUsp95NPgt3noHjo4thl1sOeEgJ4vPuqaCAThnmJQaacAX1d1DEitzIFcy3HVUvn3GIG9IU6ZvAQxO5a16KRdzjHsQRZ3sdLuDQUfdf8U9zoM0PjLRiJn39uXdwym0fUacuq7BFz2ZFkcOhrGrhJRC0EifOU0rLbLE2y4Xgyp0P8EZvpSrq0l9NurFGLQGNWLNeWN72NYyXTuNzALfMpGfXA6NWylQkGDNG7YejbgpwkqeCIAP3jmFYSLgZBPfV2kOti4ggkbVaUHtI367TtPxWowIWv4ENH2qlRuWJUvdII0yYEWCDamN0mkJb0zVDO9wb5bKUdB4qYm2pi7KS3EFxCBFJnJHLtvNoTyFuHTfp4x436xjHFPhOZOm1zNKwqfwmYD4G69Vk8NA7vq4WPyimMDQJ2wqrA9IjFn4aOS\|1 |
      | 5\|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 6\|12345                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
    Then Questionnaire Add Bulk Choices modal button "Add Bulk Choices" is enabled
    When User clicks Questionnaire Add Bulk Choices button "Cancel"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Questionnaire "Checkbox" configuration section appears with expected elements for "<tabType>"
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    Then Questionnaire Add Bulk 25 Choices modal is displayed with default elements
    When User fills in Bulk Choices values
      | 4DdkyVBA5Qn9AfPRi2LdCR8xbmMPbHQt9d6G6TjEHFgx7WuiWP92zagYOD0pGE1A08kjMGl0EqvnGUsp95NPgt3noHjo4thl1sOeEgJ4vPuqaCAThnmJQaacAX1d1DEitzIFcy3HVUvn3GIG9IU6ZvAQxO5a16KRdzjHsQRZ3sdLuDQUfdf8U9zoM0PjLRiJn39uXdwym0fUacuq7BFz2ZFkcOhrGrhJRC0EifOU0rLbLE2y4Xgyp0P8EZvpSrq0l9NurFGLQGNWLNeWN72NYyXTuNzALfMpGfXA6NWylQkGDNG7YejbgpwkqeCIAP3jmFYSLgZBPfV2kOti4ggkbVaUHtI367TtPxWowIWv4ENH2qlRuWJUvdII0yYEWCDamN0mkJb0zVDO9wb5bKUdB4qYm2pi7KS3EFxCBFJnJHLtvNoTyFuHTfp4x436xjHFPhOZOm1zNKwqfwmYD4G69Vk8NA7vq4WPyimMDQJ2wqrA9IjFn4aOS\|1 |
      | 5\|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 6\|12345                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Question configuration Choices contain expected data "Checkbox question configuration with 6 choices bulk added"
    And Questionnaire Setup button "Add Bulk Choices" is enabled
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    And User fills in Bulk Choices values
      | 7\|7    |
      | 8\|1    |
      | 9\|1234 |
      | 10\|1   |
      | 11\|0   |
      | 12\|1   |
      | 13\|1   |
      | 14\|1   |
      | 15\|1   |
      | 16\|1   |
      | 17\|1   |
      | 18\|1   |
      | 19\|1   |
      | 20\|1   |
      | 21\|1   |
      | 22\|22  |
      | 23\|23  |
      | 24\|1   |
      | 25\|1   |
      | 26\|1   |
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Questionnaire Setup button "Add Bulk Choices" is disabled
    When User clicks Configuration icon
    And User clicks Configuration icon
    Then Question configuration Choices contain expected data "Checkbox question configuration with 25 choices bulk added"
    When User clicks Configuration icon
    And User adds question with type "Checkbox" to active tab
    And User clicks Configuration icon for Question on position 2
    And User clicks Questionnaire Setup button "Add Bulk Choices"
    And User fills in Bulk Choices values
      | 4DdkyVBA5Qn9AfPRi2LdCR8xbmMPbHQt9d6G6TjEHFgx7WuiWP92zagYOD0pGE1A08kjMGl0EqvnGUsp95NPgt3noHjo4thl1sOeEgJ4vPuqaCAThnmJQaacAX1d1DEitzIFcy3HVUvn3GIG9IU6ZvAQxO5a16KRdzjHsQRZ3sdLuDQUfdf8U9zoM0PjLRiJn39uXdwym0fUacuq7BFz2ZFkcOhrGrhJRC0EifOU0rLbLE2y4Xgyp0P8EZvpSrq0l9NurFGLQGNWLNeWN72NYyXTuNzALfMpGfXA6NWylQkGDNG7YejbgpwkqeCIAP3jmFYSLgZBPfV2kOti4ggkbVaUHtI367TtPxWowIWv4ENH2qlRuWJUvdII0yYEWCDamN0mkJb0zVDO9wb5bKUdB4qYm2pi7KS3EFxCBFJnJHLtvNoTyFuHTfp4x436xjHFPhOZOm1zNKwqfwmYD4G69Vk8NA7vq4WPyimMDQJ2wqrA9IjFn4aOS\|1 |
      | 5\|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 6\|12345                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | 7\|7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
      | 8\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
      | 9\|1234                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
      | 10\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 11\|0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 12\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 13\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 14\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 15\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 16\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 17\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 18\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 19\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 20\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 21\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 22\|22                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
      | 23\|23                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
      | 24\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 25\|1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    And Questionnaire Setup button "Add Bulk Choices" is disabled
    And Question configuration Choices contain expected data "Checkbox question configuration with 25 choices bulk added"
    When User clicks Delete button for question "Choice #25" choice
    Then Questionnaire Setup button "Add Bulk Choices" is enabled
    When User clicks Questionnaire Setup button "Add Bulk Choices"
    And User fills in Bulk Choices values
      | 25\|1 |
      | 26\|1 |
    And User clicks Questionnaire Add Bulk Choices button "Add Bulk Choices"
    Then Questionnaire Add Bulk Choices modal is not displayed
    When User clicks Configuration icon
    And User clicks Configuration icon for Question on position 2
    Then Question configuration Choices contain expected data "Checkbox question configuration with 25 choices bulk added"
    When User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<button>"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon for Question on position 1
    Then Question configuration Choices contain expected data "Checkbox question configuration with 25 choices bulk added"
    When User clicks Configuration icon
    And User clicks Configuration icon for Question on position 2
    Then Question configuration Choices contain expected data "Checkbox question configuration with 25 choices bulk added"
    Examples:
      | tabType       | button        |
      | Reviewer use  | Save          |
      | Responder use | Save as draft |

  @C46633127
  Scenario: C46633127: [Questionnaire] - Add/Edit Question - Checkbox - Delete
    When User adds question with type "Checkbox" to active tab
    And User clicks Configuration icon
    And User configures question with data "Checkbox question configuration"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "Checkbox" to active tab
    And User clicks Configuration icon
    And User configures question with data "Checkbox question configuration"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User adds question with type "Checkbox" to active tab
    And User clicks Configuration icon
    And User configures question with data "Checkbox question configuration"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"
    When User clicks on Question tab with index 1
    And User adds question with type "Checkbox" to active tab
    And User clicks Configuration icon
    And User configures question with data "Checkbox question configuration"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 1
    Then Question panel message is displayed "Drag a question from the left panel onto this area"

