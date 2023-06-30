@ui @functional @questionnaires
Feature: Set Up - Questionnaire Management - Add Questionnaire

  As an Admin,
  I want to setup questions.
  So that user will be able to set up different question type, translation per language and scoring per choices.

  Background:
    Given User logs into RDDC as "Admin"
    And User navigates to Questionnaire Management page
    And Questionnaire Overview page is displayed

  @C32969642
  @flaky @180_questions
  Scenario: C32969642: Verify that user should be able to add additional tab when creating new questionnaire
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "with random ID name and 180 questions" required questionnaire setup information
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
    When User adds 24 new tabs with default "New Tab" name
    Then Question tab count contains 24 new tabs
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
      | Success! Questionnaire has been saved |
    And Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    And Add Questionnaire setup page displayed
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Question contains 25 tabs
    And Tab on position 25 contains 180 questions

  @C32969786
  Scenario: C32969786: Verify that user should be able to remove tab and see the warning message
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds 1 new tabs with default "New Tab" name
    Then Question tab count contains 1 new tabs
    When User clicks delete button for tab on position 2
    Then Warning Message is displayed with text
      | Are you sure you want to remove this tab? This change cannot be undone. |
    When User clicks Cancel warning button
    Then Question setting page contains 2 tabs
    When User clicks delete button for tab on position 2
    Then Warning Message is displayed with text
      | Are you sure you want to remove this tab? This change cannot be undone. |
    When User clicks Proceed warning button
    Then Question setting page contains 1 tabs

  @C32970002
  Scenario: C32970002: Verify that user should be able to click Cancel and changes should not be saved
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds 2 new tabs with default "New Tab" name
    Then Question tab count contains 2 new tabs
    When User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table

  @C34430822
  Scenario: C34430822: Verify that Internal User should be able to add up to 25 Tabs
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds 24 new tabs with default "New Tab" name
    Then Question tab count contains 24 new tabs
    And User should be able to add up to 1 questions with multiply types for active tab
    And Question tab Plus icon is disabled
