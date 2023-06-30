@ui @cacao @functional @questionnaires @questionnaireReviewers
Feature: Questionnaire Management - Process Reviewers Tab - Add

  As an internal RDDC user,
  I want to be able to add Reviewer to the new questionnaire,
  So that I can configure the questionnaire

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"


  @C46347977
  Scenario: C46347977: [Questionnaire] - Add - Reviewer Tab: Process Flow - Level 1 -Page elements
    When User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / ADD QUESTIONNAIRE" is displayed
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    And User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire setup "Reviewers" tab is selected
    And Questionnaire setup "Process Flow" tab is selected
    And Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | End                  |
    And Questionnaire Process Flow checkbox is displayed
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled

  @C46354968
  Scenario: C46354968: [Questionnaire] - Add - Reviewer Tab: Process Flow - Save with Default values - Level 1-5
    When User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | End                  |
    When User clicks Questionnaire Reviewers "Settings" tab
    And User selects Number of Reviewer Levels "2"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 2              | End                  |
      | 2     |             | End                  | End                  |
    And Questionnaire Process Flow level 1 Description field length is "250" symbols
    And Questionnaire Process Flow level 2 Description field length is "250" symbols
    And Questionnaire Process Flow level 2 Approve drop-down options are
      | End |
    And Questionnaire Process Flow level 2 Decline drop-down options are
      | End |
    And Questionnaire Process Flow level 1 Approve drop-down options are
      | Level 2 |
      | End     |
    And Questionnaire Process Flow level 1 Decline drop-down options are
      | Level 2 |
      | End     |
    When User clicks Questionnaire Reviewers "Settings" tab
    And User selects Number of Reviewer Levels "3"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 2              | End                  |
      | 2     |             | Level 3              | End                  |
      | 3     |             | End                  | End                  |
    When User clicks Questionnaire Reviewers "Settings" tab
    And User selects Number of Reviewer Levels "4"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 2              | End                  |
      | 2     |             | Level 3              | End                  |
      | 3     |             | Level 4              | End                  |
      | 4     |             | End                  | End                  |
    When User clicks Questionnaire Reviewers "Settings" tab
    And User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 2              | End                  |
      | 2     |             | Level 3              | End                  |
      | 3     |             | Level 4              | End                  |
      | 4     |             | Level 5              | End                  |
      | 5     |             | End                  | End                  |
    And Questionnaire Process Flow level 1 Description field length is "250" symbols
    And Questionnaire Process Flow level 2 Description field length is "250" symbols
    And Questionnaire Process Flow level 3 Description field length is "250" symbols
    And Questionnaire Process Flow level 4 Description field length is "250" symbols
    And Questionnaire Process Flow level 5 Description field length is "250" symbols
    And Questionnaire Process Flow level 5 Approve drop-down options are
      | End |
    And Questionnaire Process Flow level 5 Decline drop-down options are
      | End |
    And Questionnaire Process Flow level 4 Approve drop-down options are
      | Level 5 |
      | End     |
    And Questionnaire Process Flow level 4 Decline drop-down options are
      | End |
    And Questionnaire Process Flow level 3 Approve drop-down options are
      | Level 4 |
      | Level 5 |
      | End     |
    And Questionnaire Process Flow level 3 Decline drop-down options are
      | End |
    And Questionnaire Process Flow level 2 Approve drop-down options are
      | Level 3 |
      | Level 4 |
      | Level 5 |
      | End     |
    And Questionnaire Process Flow level 2 Decline drop-down options are
      | End |
    And Questionnaire Process Flow level 1 Approve drop-down options are
      | Level 2 |
      | Level 3 |
      | Level 4 |
      | Level 5 |
      | End     |
    And Questionnaire Process Flow level 1 Decline drop-down options are
      | Level 2 |
      | Level 3 |
      | Level 4 |
      | Level 5 |
      | End     |
    When User fills Questionnaire Process Flow description "Auto test" for level 1
    And User select Questionnaire Process Flow approve next level "End" for level 1
    And User select Questionnaire Process Flow decline next level "End" for level 4
    And User clicks Questionnaire Setup button "Next"
    And User adds up to 1 questions with multiply types for active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Auto test   | End                  | End                  |
      | 2     |             | End                  | End                  |
      | 3     |             | End                  | End                  |
      | 4     |             | End                  | End                  |
      | 5     |             | End                  | End                  |

  @C46424954
  Scenario: C46424954: [Questionnaire] - Add - Reviewer Tab: Process Flow - Level 2 - Next
    When User selects Number of Reviewer Levels "2"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 2              | End                  |
      | 2     |             | End                  | End                  |
    When User select Questionnaire Process Flow approve next level "End" for level 1
    And User select Questionnaire Process Flow decline next level "Level 2" for level 1
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected

  @C46425212
  Scenario: C46425212: [Questionnaire] - Add - Reviewer Tab: Process Flow - Level 3
    When User selects Number of Reviewer Levels "3"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 2              | End                  |
      | 2     |             | Level 3              | End                  |
      | 3     |             | End                  | End                  |
    When User select Questionnaire Process Flow approve next level "Level 3" for level 1
    And User select Questionnaire Process Flow decline next level "Level 2" for level 1
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 3              | Level 2              |
      | 2     |             |                      | End                  |
      | 3     |             | End                  | End                  |
    When User select Questionnaire Process Flow approve next level "End" for level 1
    And User select Questionnaire Process Flow decline next level "Level 3" for level 1
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | Level 3              |
      | 2     |             | End                  | End                  |
      | 3     |             | End                  | End                  |
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | Level 3              |
      | 2     |             | End                  | End                  |
      | 3     |             | End                  | End                  |

  @C46425351
  Scenario: C46425351: [Questionnaire] - Add - Reviewer Tab: Process Flow - Level 4
    When User selects Number of Reviewer Levels "4"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 2              | End                  |
      | 2     |             | Level 3              | End                  |
      | 3     |             | Level 4              | End                  |
      | 4     |             | End                  | End                  |
    When User select Questionnaire Process Flow approve next level "Level 3" for level 1
    And User select Questionnaire Process Flow decline next level "Level 2" for level 1
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 3              | Level 2              |
      | 2     |             |                      | End                  |
      | 3     |             | Level 4              | End                  |
      | 4     |             | End                  | End                  |
    When User select Questionnaire Process Flow approve next level "Level 4" for level 2
    And User select Questionnaire Process Flow decline next level "Level 3" for level 2
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 3              | Level 2              |
      | 2     |             | Level 4              | Level 3              |
      | 3     |             |                      | End                  |
      | 4     |             | End                  | End                  |
    When User select Questionnaire Process Flow approve next level "End" for level 3
    And User select Questionnaire Process Flow decline next level "Level 4" for level 3
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 3              | Level 2              |
      | 2     |             | Level 4              | Level 3              |
      | 3     |             | End                  | Level 4              |
      | 4     |             | End                  | End                  |
    When User clicks Questionnaire Setup button "Next"
    And User adds up to 1 questions with multiply types for active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 3              | Level 2              |
      | 2     |             | Level 4              | Level 3              |
      | 3     |             | End                  | Level 4              |
      | 4     |             | End                  | End                  |

  @C46425437
  Scenario: C46425437: [Questionnaire] - Add - Reviewer Tab: Process Flow - Level 5
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 2              | End                  |
      | 2     |             | Level 3              | End                  |
      | 3     |             | Level 4              | End                  |
      | 4     |             | Level 5              | End                  |
      | 5     |             | End                  | End                  |
    When User select Questionnaire Process Flow decline next level "Level 2" for level 1
    And User select Questionnaire Process Flow decline next level "Level 3" for level 2
    And User select Questionnaire Process Flow decline next level "Level 4" for level 3
    And User select Questionnaire Process Flow decline next level "Level 5" for level 4
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 2              | Level 2              |
      | 2     |             | Level 3              | Level 3              |
      | 3     |             | Level 4              | Level 4              |
      | 4     |             | Level 5              | Level 5              |
      | 5     |             | End                  | End                  |
    When User select Questionnaire Process Flow approve next level "Level 5" for level 1
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 5              | Level 2              |
      | 2     |             |                      | Level 3              |
      | 3     |             |                      | Level 4              |
      | 4     |             |                      | Level 5              |
      | 5     |             | End                  | End                  |
    When User select Questionnaire Process Flow approve next level "End" for level 1
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | Level 2              |
      | 2     |             | End                  | Level 3              |
      | 3     |             | End                  | Level 4              |
      | 4     |             | End                  | Level 5              |
      | 5     |             | End                  | End                  |
    When User select Questionnaire Process Flow decline next level "Level 5" for level 3
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | Level 2              |
      | 2     |             | End                  | Level 3              |
      | 3     |             | End                  | Level 5              |
      | 4     |             | End                  |                      |
      | 5     |             | End                  | End                  |
    When User select Questionnaire Process Flow decline next level "End" for level 4
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | Level 2              |
      | 2     |             | End                  | Level 3              |
      | 3     |             | End                  | Level 5              |
      | 4     |             | End                  | End                  |
      | 5     |             | End                  | End                  |
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | Level 2              |
      | 2     |             | End                  | Level 3              |
      | 3     |             | End                  | Level 5              |
      | 4     |             | End                  | End                  |
      | 5     |             | End                  | End                  |

  @C46434537
  Scenario Outline: C46434537: [Questionnaire] - Add - Reviewer Tab: Process Flow - Change Settings after Setup
    Then "Reviewers" Tab is displayed
    And Questionnaire Reviewers subtab "Settings" is displayed
    And Questionnaire Reviewers Number of Reviewer levels is "1"
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 2              | End                  |
      | 2     |             | Level 3              | End                  |
      | 3     |             | Level 4              | End                  |
      | 4     |             | Level 5              | End                  |
      | 5     |             | End                  | End                  |
    When User fills Questionnaire Process Flow description "Auto test" for level 1
    And User select Questionnaire Process Flow approve next level "Level 3" for level 1
    And User select Questionnaire Process Flow approve next level "End" for level 4
    And User select Questionnaire Process Flow decline next level "Level 4" for level 1
    And User select Questionnaire Process Flow decline next level "Level 5" for level 2
    And User clicks Questionnaire Reviewers "Settings" tab
    And User selects Number of Reviewer Levels "3"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Auto test   | Level 2              | End                  |
      | 2     |             | Level 3              | End                  |
      | 3     |             | End                  | End                  |
    When User clicks Questionnaire Reviewers "Settings" tab
    And User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Auto test   | Level 2              | End                  |
      | 2     |             | Level 3              | End                  |
      | 3     |             | Level 4              | End                  |
      | 4     |             | Level 5              | End                  |
      | 5     |             | End                  | End                  |
    When User select Questionnaire Process Flow decline next level "Level 2" for level 1
    And User select Questionnaire Process Flow decline next level "Level 3" for level 2
    And User select Questionnaire Process Flow decline next level "Level 4" for level 3
    And User select Questionnaire Process Flow decline next level "Level 5" for level 4
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Auto test   | Level 2              | Level 2              |
      | 2     |             | Level 3              | Level 3              |
      | 3     |             | Level 4              | Level 4              |
      | 4     |             | Level 5              | Level 5              |
      | 5     |             | End                  | End                  |
    When User select Questionnaire Process Flow approve next level "End" for level 1
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Auto test   | End                  | Level 2              |
      | 2     |             | End                  | Level 3              |
      | 3     |             | End                  | Level 4              |
      | 4     |             | End                  | Level 5              |
      | 5     |             | End                  | End                  |
    When User select Questionnaire Process Flow decline next level "Level 5" for level 3
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Auto test   | End                  | Level 2              |
      | 2     |             | End                  | Level 3              |
      | 3     |             | End                  | Level 5              |
      | 4     |             | End                  |                      |
      | 5     |             | End                  | End                  |
    When User select Questionnaire Process Flow decline next level "End" for level 4
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Auto test   | End                  | Level 2              |
      | 2     |             | End                  | Level 3              |
      | 3     |             | End                  | Level 5              |
      | 4     |             | End                  | End                  |
      | 5     |             | End                  | End                  |
    When User clicks Questionnaire Setup button "Next"
    And User adds up to 1 questions with multiply types for active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<buttonName>"
    Then Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Auto test   | End                  | Level 2              |
      | 2     |             | End                  | Level 3              |
      | 3     |             | End                  | Level 5              |
      | 4     |             | End                  | End                  |
      | 5     |             | End                  | End                  |
    Examples:
      | buttonName    |
      | Save          |
      | Save as draft |

  @C46424267
  Scenario: C46424267: [Questionnaire] - Add - Reviewer Tab: Process Flow - Validations
    When User selects Number of Reviewer Levels "4"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 2              | End                  |
      | 2     |             | Level 3              | End                  |
      | 3     |             | Level 4              | End                  |
      | 4     |             | End                  | End                  |
    When User select Questionnaire Process Flow approve next level "Level 4" for level 1
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Questionnaire Process Flow "Approve" input for level 2 is highlighted with error message "This field is required"
    And Questionnaire Process Flow "Approve" input for level 3 is highlighted with error message "This field is required"
    And Questionnaire "Reviewers" tab is highlighted
    And Questionnaire "Process Flow" tab is highlighted
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 4              | End                  |
      | 2     |             |                      | End                  |
      | 3     |             |                      | End                  |
      | 4     |             | End                  | End                  |

  @C46441434
  Scenario: C46441434: [Questionnaire] - Add - Reviewer Tab: Process Flow - Cancel
    When User selects Number of Reviewer Levels "4"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | Level 2              | End                  |
      | 2     |             | Level 3              | End                  |
      | 3     |             | Level 4              | End                  |
      | 4     |             | End                  | End                  |
    When User select Questionnaire Process Flow approve next level "Level 4" for level 1
    And User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table