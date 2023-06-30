@ui @functional @questionnaires
Feature: Set Up - Questionnaire Management - Edit Questionnaire

  As an Admin,
  I want to edit questions.
  So that user will be able to set up different question type, translation per language and scoring per choices.

  Background:
    Given User logs into RDDC as "Admin"
    And User navigates to Questionnaire Management page
    And Questionnaire Overview page is displayed
    And User clicks Add Questionnaire button
    And User creates questionnaire "with random ID name" with 1 "New Tab" tabs
    And Questionnaire is displayed on questionnaires table

  @C32969710
  @flaky @180_questions
  Scenario: C32969710: Verify that user should be able to add new tab when editing questionnaire
    When User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    And Questionnaire Name field is displayed as required
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    Then "Reviewers" Tab is displayed
    When User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    When User selects "User" as Main Reviewer
    Then Main Reviewer field is displayed as required
    When User fills current user name as Main Reviewer
    And User selects "Third-party Country" Reviewer "Rule" from drop-down
    And User fills "Afghanistan" Reviewer "Third-party Country"
    And User selects "user" as Reviewer
    And User fills current user name as Reviewer
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds 8 new tabs with default "New Tab" name
    Then Question tab count contains 8 new tabs
    And User should be able to edit Question tab name with 100 characters name
    And User should be able to add up to 180 questions with multiply types for active tab
    And Manage buttons are displayed for each added question type
    When User clicks Questionnaire Setup button "Next"
    Then "Scoring" Tab is displayed
    When User fills "with random ID name" required questionnaire scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Questionnaire Scores are displayed on scoring table with provided details
    When User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success!                       |
      | Questionnaire has been updated |
    And Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    And Add Questionnaire setup page displayed
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Question contains 10 tabs
    And Tab on position 10 contains 180 questions

  @C33163371
  Scenario: C33163371: Verify that user should be able to remove the added tab and see the warning message when editing questionnaire
    When User clicks edit added questionnaire
    And User waits for progress bar to disappear from page
    Then "Information" Tab is displayed
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds 1 new tabs with default "New Tab" name
    Then Question tab count contains 1 new tabs
    When User clicks delete button for tab on position 3
    Then Warning Message is displayed with text
      | Are you sure you want to remove this tab? This change cannot be undone. |
    When User clicks Cancel warning button
    Then Question setting page contains 3 tabs
    When User clicks delete button for tab on position 3
    Then Warning Message is displayed with text
      | Are you sure you want to remove this tab? This change cannot be undone. |
    When User clicks Proceed warning button
    Then Question setting page contains 2 tabs

  @C34433691
  Scenario: C34433691: Verify that Internal User should be able to add up to 25 tabs when editing existing questionnaire template
    When User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds 23 new tabs with default "New Tab" name
    Then Question tab count contains 23 new tabs
    And Question tab Plus icon is disabled
