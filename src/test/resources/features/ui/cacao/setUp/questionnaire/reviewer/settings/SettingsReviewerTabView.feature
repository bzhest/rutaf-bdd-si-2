@ui @cacao @functional @questionnaires @questionnaireReviewers
Feature: Questionnaire Management - Settings Reviewers Tab - View

  As an RDDC user with permission to manage questionnaires
  I want to be able to manage edit saved questionnaires
  So that I can update the information to actual


  @C46307851
  Scenario: C46307851: [Questionnaire] - View - Reviewer Tab - Settings
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User selects Number of Reviewer Levels "5"
    And User clicks toggle "Allow total score adjustment by entering a number" option on Reviewers tab
    And User selects Reviewers Settings "Allow total score adjustment by entering a number" drop-down value "Level 1"
    And User clicks toggle "Hide total score from reviewers" option on Reviewers tab
    And User selects Reviewers Settings "Hide total score from reviewers" drop-down value "Level 2"
    And User clicks toggle "Hide question score from reviewers" option on Reviewers tab
    And User selects Reviewers Settings "Hide question score from reviewers" drop-down value "Level 5"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    Then Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / toBeReplaced" is displayed
    And Questionnaire tab displayed in view mode
    And Questionnaire setup "Information" tab is active
    And Questionnaire setup "Reviewers" tab is selected
    And Questionnaire setup "Question" tab is active
    And Questionnaire setup "Scoring" tab is active
    And Questionnaire Setup button "Next" is enabled
    And Questionnaire Setup button "Back" is enabled
    And Current URL matches ".+\/ui\/admin\/questionnaire-management\/questionnaires\/(\w+)" endpoint regex
    And Questionnaire Reviewers Number of Reviewer levels is "5"
    And Questionnaire Reviewers Setting toggles are set to "On" and "disabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |
      | Hide total score from reviewers                   | Hide from   |
      | Hide question score from reviewers                | Hide from   |
    And Questionnaire Reviewers Setting toggles are set to "Off" and "disabled" drop-down
      | Require mandatory comment for review and changes | Required for |
    And Questionnaire Reviewers Settings "Hide total score from reviewers" selected values are
      | Level 2 |
    And Questionnaire Reviewers Settings "Hide question score from reviewers" selected values are
      | Level 5 |
    And Questionnaire Reviewers Settings "Require mandatory comment for review and changes" selected values are
      |  |
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    When User clicks Questionnaire Setup button "Back"
    And User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
