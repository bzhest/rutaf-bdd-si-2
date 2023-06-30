@ui @cacao @functional @questionnaires @questionnaireReviewers
Feature: Questionnaire Management - Process Reviewers Tab - Edit

  AS an RDDC user with permission to manage questionnaires
  I WANT TO be able to manage edit saved questionnaires
  SO THAT I can update the information to actual

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"

  @C46608841
  Scenario: C46608841: [Questionnaire] - Edit - Reviewer Tab:Process Flow - Active/Inactive - Edit from different pages
    When User clicks Questionnaire Setup button "Next"
    And User adds up to 1 questions with multiply types for active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | End                  |
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User clicks Questionnaire Reviewers "Settings" tab
    And User selects Number of Reviewer Levels "3"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User fills Questionnaire Process Flow description "Edit from Main Page" for level 1
    And User select Questionnaire Process Flow approve next level "End" for level 2
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION         | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Main Page | Level 2              | End                  |
      | 2     |                     | End                  | End                  |
      | 3     |                     | End                  | End                  |
    When User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Inactive"
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION         | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Main Page | Level 2              | End                  |
      | 2     |                     | End                  | End                  |
      | 3     |                     | End                  | End                  |
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User fills Questionnaire Process Flow description "Edit from Process Flow tab" for level 1
    And User select Questionnaire Process Flow approve next level "Level 3" for level 2
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION                | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Process Flow tab | Level 2              | End                  |
      | 2     |                            | Level 3              | End                  |
      | 3     |                            | End                  | End                  |
    When User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Inactive"
    When User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User selects "Active" questionnaire status
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION                | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Process Flow tab | Level 2              | End                  |
      | 2     |                            | Level 3              | End                  |
      | 3     |                            | End                  | End                  |
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User clicks Questionnaire Reviewers "Settings" tab
    And User selects Number of Reviewer Levels "4"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User fills Questionnaire Process Flow description "Edit from other tab" for level 1
    And User select Questionnaire Process Flow approve next level "End" for level 3
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION         | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from other tab | Level 2              | End                  |
      | 2     |                     | Level 3              | End                  |
      | 3     |                     | End                  | End                  |
      | 4     |                     | End                  | End                  |
    When User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION         | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from other tab | Level 2              | End                  |
      | 2     |                     | Level 3              | End                  |
      | 3     |                     | End                  | End                  |
      | 4     |                     | End                  | End                  |
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User fills Questionnaire Process Flow description "Edit from Settings tab" for level 1
    And User select Questionnaire Process Flow approve next level "End" for level 3
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION            | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Settings tab | Level 2              | End                  |
      | 2     |                        | Level 3              | End                  |
      | 3     |                        | End                  | End                  |
      | 4     |                        | End                  | End                  |
    When User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION            | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Settings tab | Level 2              | End                  |
      | 2     |                        | Level 3              | End                  |
      | 3     |                        | End                  | End                  |
      | 4     |                        | End                  | End                  |

  @C46608846
  Scenario: C46608846: [Questionnaire] - Edit - Reviewer Tab:Process Flow - Saved as Draft - Edit from different pages
    When User clicks Questionnaire Setup button "Next"
    And User adds up to 1 questions with multiply types for active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | End                  |
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User clicks Questionnaire Reviewers "Settings" tab
    And User selects Number of Reviewer Levels "3"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User fills Questionnaire Process Flow description "Edit from Main Page" for level 1
    And User select Questionnaire Process Flow approve next level "End" for level 2
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION         | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Main Page | Level 2              | End                  |
      | 2     |                     | End                  | End                  |
      | 3     |                     | End                  | End                  |
    When User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION         | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Main Page | Level 2              | End                  |
      | 2     |                     | End                  | End                  |
      | 3     |                     | End                  | End                  |
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User fills Questionnaire Process Flow description "Edit from Process Flow tab" for level 1
    And User select Questionnaire Process Flow approve next level "Level 3" for level 2
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION                | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Process Flow tab | Level 2              | End                  |
      | 2     |                            | Level 3              | End                  |
      | 3     |                            | End                  | End                  |
    When User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION                | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Process Flow tab | Level 2              | End                  |
      | 2     |                            | Level 3              | End                  |
      | 3     |                            | End                  | End                  |
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User clicks Questionnaire Reviewers "Settings" tab
    And User selects Number of Reviewer Levels "4"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User fills Questionnaire Process Flow description "Edit from other tab" for level 1
    And User select Questionnaire Process Flow approve next level "End" for level 3
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION         | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from other tab | Level 2              | End                  |
      | 2     |                     | Level 3              | End                  |
      | 3     |                     | End                  | End                  |
      | 4     |                     | End                  | End                  |
    When User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION         | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from other tab | Level 2              | End                  |
      | 2     |                     | Level 3              | End                  |
      | 3     |                     | End                  | End                  |
      | 4     |                     | End                  | End                  |
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User fills Questionnaire Process Flow description "Edit from Settings tab" for level 1
    And User select Questionnaire Process Flow approve next level "End" for level 3
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION            | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Settings tab | Level 2              | End                  |
      | 2     |                        | Level 3              | End                  |
      | 3     |                        | End                  | End                  |
      | 4     |                        | End                  | End                  |
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION            | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Settings tab | Level 2              | End                  |
      | 2     |                        | Level 3              | End                  |
      | 3     |                        | End                  | End                  |
      | 4     |                        | End                  | End                  |

  @C46607718
  Scenario: C46607718: [Questionnaire] - Edit - Reviewer Tab: Process Flow - Level 1
    When User clicks Questionnaire Setup button "Next"
    And User adds up to 1 questions with multiply types for active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | End                  |
    And Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / toBeReplaced / EDIT" is displayed
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow checkbox is displayed
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User fills Questionnaire Process Flow description "Edit Level 1" for level 1
    And User clicks Questionnaire Setup button "Save"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION  | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit Level 1 | End                  | End                  |

  @C46608853
  Scenario Outline: C46608853: [Questionnaire] - Edit - Reviewer Tab: Process Flow - Change Settings after Setup - Level 1-5
    Then "Reviewers" Tab is displayed
    When User clicks Questionnaire Setup button "Next"
    And User adds up to 1 questions with multiply types for active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<buttonName>"
    Then Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    When User clicks Questionnaire Setup button "Next"
    And User selects Number of Reviewer Levels "5"
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

  @C46608849
  Scenario: C46608849: [Questionnaire] - Edit - Reviewer Tab: Process Flow - Validations
    When User clicks Questionnaire Setup button "Next"
    And User adds up to 1 questions with multiply types for active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User selects Number of Reviewer Levels "4"
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

  @C46608851
  Scenario: C46608851: [Questionnaire] - Edit- Reviewer Tab: Process Flow - Cancel
    When User clicks Questionnaire Setup button "Next"
    And User adds up to 1 questions with multiply types for active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | End                  |
    When User fills Questionnaire Process Flow description "Edit from Main Page - Cancel" for level 1
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION                  | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Main Page - Cancel | End                  | End                  |
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | End                  |
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User clicks Edit questionnaire button
    And User fills Questionnaire Process Flow description "Edit from Process Flow tab - Cancel" for level 1
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION                         | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Process Flow tab - Cancel | End                  | End                  |
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | End                  |
    When User clicks "Information" questionnaire tab
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User fills Questionnaire Process Flow description "Edit from other tab - Cancel" for level 1
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION                  | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from other tab - Cancel | End                  | End                  |
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | End                  |
    When User fills Questionnaire Process Flow description "Edit from Settings tab - Cancel" for level 1
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION                     | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     | Edit from Settings tab - Cancel | End                  | End                  |
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |             | End                  | End                  |
