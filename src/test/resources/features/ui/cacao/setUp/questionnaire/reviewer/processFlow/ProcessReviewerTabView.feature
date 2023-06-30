@ui @cacao @functional @questionnaires @questionnaireReviewers
Feature: Questionnaire Management - Process Reviewers Tab - View


  @C46435223
  Scenario: C46435223: [Questionnaire] - View- Reviewer Tab: Process Flow
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User select Questionnaire Process Flow decline next level "Level 2" for level 1
    And User select Questionnaire Process Flow decline next level "Level 3" for level 2
    And User select Questionnaire Process Flow decline next level "Level 4" for level 3
    And User select Questionnaire Process Flow decline next level "Level 5" for level 4
    And User fills Questionnaire Process Flow description "Auto Test Comment" for level 3
    And User select Questionnaire Process Flow approve next level "Level 5" for level 1
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION       | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |                   | Level 5              | Level 2              |
      | 2     |                   |                      | Level 3              |
      | 3     | Auto Test Comment |                      | Level 4              |
      | 4     |                   |                      | Level 5              |
      | 5     |                   | End                  | End                  |
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / toBeReplaced" is displayed
    And Questionnaire setup "Reviewers" tab is selected
    And Questionnaire setup "Process Flow" tab is selected
    And Questionnaire setup "Settings" tab is active
    And Questionnaire setup "Information" tab is active
    And Questionnaire setup "Question" tab is active
    And Questionnaire setup "Scoring" tab is active
    And Questionnaire setup "Rules" tab is active
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Next" is enabled
    And Questionnaire tab displayed in view mode
    And Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION       | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |                   | Level 5              | Level 2              |
      | 2     |                   |                      | Level 3              |
      | 3     | Auto Test Comment |                      | Level 4              |
      | 4     |                   |                      | Level 5              |
      | 5     |                   | End                  | End                  |
    And Questionnaire Process Flow checkbox is unchecked
    And Current URL matches ".+\/ui\/admin\/questionnaire-management\/questionnaires\/(\w+)" endpoint regex
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    When User clicks Questionnaire Setup button "Back"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    When User select Questionnaire Process Flow approve next level "End" for level 1
    And User clicks Questionnaire Process Flow checkbox
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION       | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |                   | End                  | Level 2              |
      | 2     |                   | End                  | Level 3              |
      | 3     | Auto Test Comment | End                  | Level 4              |
      | 4     |                   | End                  | Level 5              |
      | 5     |                   | End                  | End                  |
    And Questionnaire Process Flow checkbox is checked
    When User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / toBeReplaced" is displayed
    And Questionnaire setup "Reviewers" tab is selected
    And Questionnaire setup "Process Flow" tab is selected
    And Questionnaire setup "Settings" tab is active
    And Questionnaire setup "Information" tab is active
    And Questionnaire setup "Question" tab is active
    And Questionnaire setup "Scoring" tab is active
    And Questionnaire setup "Rules" tab is active
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Next" is enabled
    And Questionnaire tab displayed in view mode
    And Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION       | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |                   | End                  | Level 2              |
      | 2     |                   | End                  | Level 3              |
      | 3     | Auto Test Comment | End                  | Level 4              |
      | 4     |                   | End                  | Level 5              |
      | 5     |                   | End                  | End                  |
    And Questionnaire Process Flow checkbox is checked
    And Current URL matches ".+\/ui\/admin\/questionnaire-management\/questionnaires\/(\w+)" endpoint regex
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    When User clicks Questionnaire Setup button "Back"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    When User select Questionnaire Process Flow approve next level "Level 2" for level 1
    And User select Questionnaire Process Flow approve next level "Level 3" for level 2
    And User select Questionnaire Process Flow approve next level "Level 4" for level 3
    And User select Questionnaire Process Flow approve next level "Level 5" for level 4
    And User clicks Questionnaire Process Flow checkbox
    Then Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION       | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |                   | Level 2              | Level 2              |
      | 2     |                   | Level 3              | Level 3              |
      | 3     | Auto Test Comment | Level 4              | Level 4              |
      | 4     |                   | Level 5              | Level 5              |
      | 5     |                   | End                  | End                  |
    And Questionnaire Process Flow checkbox is unchecked
    When User clicks "Information" questionnaire tab
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / toBeReplaced" is displayed
    And Questionnaire setup "Reviewers" tab is selected
    And Questionnaire setup "Process Flow" tab is selected
    And Questionnaire setup "Settings" tab is active
    And Questionnaire setup "Information" tab is active
    And Questionnaire setup "Question" tab is active
    And Questionnaire setup "Scoring" tab is active
    And Questionnaire setup "Rules" tab is active
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Next" is enabled
    And Questionnaire tab displayed in view mode
    And Questionnaire Process Flow table is displayed with details
      | LEVEL | DESCRIPTION       | APPROVE (NEXT LEVEL) | DECLINE (NEXT LEVEL) |
      | 1     |                   | Level 2              | Level 2              |
      | 2     |                   | Level 3              | Level 3              |
      | 3     | Auto Test Comment | Level 4              | Level 4              |
      | 4     |                   | Level 5              | Level 5              |
      | 5     |                   | End                  | End                  |
    And Questionnaire Process Flow checkbox is unchecked
    And Current URL matches ".+\/ui\/admin\/questionnaire-management\/questionnaires\/(\w+)" endpoint regex
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    When User clicks Questionnaire Setup button "Back"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
