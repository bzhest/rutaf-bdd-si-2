@ui @cacao @functional @questionnaires @question
Feature: Questionnaire Management - Question Tab - Question Tab Management

  As an RDDC User with the permissions to manage questionnaires
  I want to be able to add more tabs in questionnaire
  So that I can add different questions to different tabs and define the Responder and Reviewer

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"

  @C46596738
  Scenario: C46596738: Tab Management: Add/Edit QSST - Verify the tabs management - Add
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User fills Questionnaire Process Flow description "Auto test" for level 1
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Tab One" tab is selected
    And Questionnaire question active tab type is "RESPONDER USE"
    And Questionnaire question tab Edit button is displayed for tab on position 1
    And Questionnaire question tab counter with value "0" is displayed for tab on position 1
    And Question tab Plus icon is disabled
    And Questionnaire Plus icon counter is displayed with value "1"
    And Questionnaire question tab Delete button is not displayed for tab on position 1
    And User should be able to edit Question tab name with 100 characters name
    When User adds question with type "Checkbox" to active tab
    Then Question tab Plus icon is enabled
    And Questionnaire question tab counter with value "1" is displayed for tab on position 1
    When User adds question with type "Boolean" to active tab
    And User adds question with type "Number" to active tab
    Then Questionnaire question tab counter with value "3" is displayed for tab on position 1
    When User clicks Add question tab button
    Then Question Create Tab modal is displayed
    And Question Create Tab modal "Cancel" button is displayed
    And Question Create Tab modal "Create" button is displayed
    And Question Create Tab modal radio buttons are displayed
      | Responder use |
      | Reviewer use  |
    And Question Create Tab modal radio button "Responder use" is selected
    When User clicks Create Tab modal "Cancel" button
    Then Question Create Tab modal is not displayed
    And Questionnaire Plus icon counter is displayed with value "1"
    When User clicks Add question tab button
    And User clicks Create Tab modal "Create" button
    Then Question tab name on position 2 is "NEW TAB"
    When User clicks on Question tab with index 1
    Then Questionnaire question tab Delete button is displayed for tab on position 2
    And Questionnaire Plus icon counter is displayed with value "2"
    And Question tab Plus icon is disabled
    And Questionnaire question active tab type is "RESPONDER USE"
    When User adds question with type "Boolean" to active tab
    Then Question tab Plus icon is enabled
    And Questionnaire question tab counter with value "1" is displayed for tab on position 2
    When User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    Then Question tab name on position 3 is "NEW TAB"
    When User clicks on Question tab with index 2
    Then Questionnaire question tab Delete button is displayed for tab on position 3
    And Questionnaire Plus icon counter is displayed with value "3"
    And Question tab Plus icon is disabled
    And Questionnaire question active tab type is "REVIEWER USE"

  @C46596738
  Scenario: C46596738: Tab Management: Add/Edit QSST - Verify the tabs management - Edit
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User fills Questionnaire Process Flow description "Auto test" for level 1
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Tab One" tab is selected
    And Questionnaire question active tab type is "RESPONDER USE"
    And Questionnaire question tab Edit button is displayed for tab on position 1
    And Questionnaire question tab counter with value "0" is displayed for tab on position 1
    And Question tab Plus icon is disabled
    And Questionnaire Plus icon counter is displayed with value "1"
    And Questionnaire question tab Delete button is not displayed for tab on position 1
    And User should be able to edit Question tab name with 100 characters name
    When User adds question with type "Checkbox" to active tab
    Then Question tab Plus icon is enabled
    And Questionnaire question tab counter with value "1" is displayed for tab on position 1
    When User adds question with type "Boolean" to active tab
    And User adds question with type "Number" to active tab
    Then Questionnaire question tab counter with value "3" is displayed for tab on position 1
    When User clicks Add question tab button
    Then Question Create Tab modal is displayed
    And Question Create Tab modal "Cancel" button is displayed
    And Question Create Tab modal "Create" button is displayed
    And Question Create Tab modal radio buttons are displayed
      | Responder use |
      | Reviewer use  |
    And Question Create Tab modal radio button "Responder use" is selected
    When User clicks Create Tab modal "Cancel" button
    Then Question Create Tab modal is not displayed
    And Questionnaire Plus icon counter is displayed with value "1"
    When User clicks Add question tab button
    And User clicks Create Tab modal "Create" button
    Then Question tab name on position 2 is "NEW TAB"
    When User clicks on Question tab with index 1
    Then Questionnaire question tab Delete button is displayed for tab on position 2
    And Questionnaire Plus icon counter is displayed with value "2"
    And Question tab Plus icon is disabled
    And Questionnaire question active tab type is "RESPONDER USE"
    When User adds question with type "Boolean" to active tab
    Then Question tab Plus icon is enabled
    And Questionnaire question tab counter with value "1" is displayed for tab on position 2
    When User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    Then Question tab name on position 3 is "NEW TAB"
    When User clicks on Question tab with index 2
    Then Questionnaire question tab Delete button is displayed for tab on position 3
    And Questionnaire Plus icon counter is displayed with value "3"
    And Question tab Plus icon is disabled
    And Questionnaire question active tab type is "REVIEWER USE"

  @C46609253
  Scenario: C46609253: Tab Management: Add/Edit QSST - Verify that only 25 tabs can be added - Add
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User fills Questionnaire Process Flow description "Auto test" for level 1
    And User clicks Questionnaire Setup button "Next"
    And User adds 12 new tabs with default "New Tab" name
    Then Question tab name on position 12 is "NEW TAB"
    And Questionnaire question tab Delete button is displayed for tab on position 12
    And Questionnaire Plus icon counter is displayed with value "13"
    And User adds question with type "Boolean" to active tab
    And Question tab Plus icon is enabled
    And Questionnaire question active tab type is "RESPONDER USE"
    When User adds 12 new tabs with default "New Tab" name with "Reviewer use" use type
    Then Question tab name on position 24 is "NEW TAB"
    And Questionnaire question tab Delete button is displayed for tab on position 24
    And Questionnaire Plus icon counter is displayed with value "25"
    And Question tab Plus icon is disabled
    And Questionnaire question active tab type is "REVIEWER USE"

  @C46609253
  Scenario: C46609253: Tab Management: Add/Edit QSST - Verify that only 25 tabs can be added - Edit
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User fills Questionnaire Process Flow description "Auto test" for level 1
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds 12 new tabs with default "New Tab" name
    Then Question tab name on position 12 is "NEW TAB"
    And Questionnaire question tab Delete button is displayed for tab on position 12
    And Questionnaire Plus icon counter is displayed with value "13"
    And User adds question with type "Boolean" to active tab
    And Question tab Plus icon is enabled
    And Questionnaire question active tab type is "RESPONDER USE"
    When User adds 12 new tabs with default "New Tab" name with "Reviewer use" use type
    Then Question tab name on position 24 is "NEW TAB"
    And Questionnaire question tab Delete button is displayed for tab on position 24
    And Questionnaire Plus icon counter is displayed with value "25"
    And Question tab Plus icon is disabled
    And Questionnaire question active tab type is "REVIEWER USE"

  @C46620161
  Scenario: C46620161: Tab Management: Add/Edit QSST - Verify that the tab can be deleted
    When User clicks Questionnaire Setup button "Next"
    And User adds 2 new tabs with default "New Tab" name
    And User adds question with type "Boolean" to active tab
    Then Question tab name on position 1 is "TAB ONE"
    And Question tab name on position 2 is "NEW TAB"
    And Question tab name on position 3 is "NEW TAB"
    And Questionnaire question tab Delete button is not displayed for tab on position 1
    And Questionnaire question tab Delete button is displayed for tab on position 2
    And Questionnaire question tab Delete button is displayed for tab on position 3
    And Questionnaire question tab counter with value "1" is displayed for tab on position 1
    And Questionnaire question tab counter with value "1" is displayed for tab on position 2
    And Questionnaire question tab counter with value "1" is displayed for tab on position 3
    And Questionnaire Plus icon counter is displayed with value "3"
    And Question tab Plus icon is enabled
    When User clicks on Question tab with index 1
    And User clicks delete button for tab on position 2
    Then Warning Message is displayed with text
      | Are you sure you want to remove this tab? This change cannot be undone. |
    When User clicks Cancel warning button
    Then Question setting page contains 3 tabs
    When User clicks delete button for tab on position 2
    Then Warning Message is displayed with text
      | Are you sure you want to remove this tab? This change cannot be undone. |
    When User clicks Proceed warning button
    Then Question setting page contains 2 tabs
    And Questionnaire Plus icon counter is displayed with value "2"
    And Question tab Plus icon is enabled
    And Questionnaire setup "Tab One" tab is selected
    When User adds 1 new tabs with default "New Tab" name
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Question tab name on position 1 is "TAB ONE"
    And Question tab name on position 2 is "NEW TAB"
    And Question tab name on position 3 is "NEW TAB"
    And Questionnaire question tab Delete button is not displayed for tab on position 1
    And Questionnaire question tab Delete button is displayed for tab on position 2
    And Questionnaire question tab Delete button is displayed for tab on position 3
    And Questionnaire question tab counter with value "1" is displayed for tab on position 1
    And Questionnaire question tab counter with value "1" is displayed for tab on position 2
    And Questionnaire question tab counter with value "1" is displayed for tab on position 3
    And Questionnaire Plus icon counter is displayed with value "3"
    And Question tab Plus icon is enabled
    When User clicks on Question tab with index 1
    And User clicks delete button for tab on position 2
    Then Warning Message is displayed with text
      | Are you sure you want to remove this tab? This change cannot be undone. |
    When User clicks Cancel warning button
    Then Question setting page contains 3 tabs
    When User clicks delete button for tab on position 2
    Then Warning Message is displayed with text
      | Are you sure you want to remove this tab? This change cannot be undone. |
    When User clicks Proceed warning button
    Then Question setting page contains 2 tabs
    And Questionnaire Plus icon counter is displayed with value "2"
    And Question tab Plus icon is enabled
    And Questionnaire setup "Tab One" tab is selected