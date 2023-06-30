@ui @cacao @functional @questionnaires
Feature: Questionnaire Management - Information Tab - View Questionnaire

  As an RDDC user with permissions to manage questionnaires
  I want to be able to review the configuration of the questionnaire
  So that I can ensure that the configuration does not need changes.

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page

  @C46307840
  Scenario: C46307840: [Questionnaire] - Information Tab - View - Saved as Draft
    When User fills "with completed Internal data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    Then Questionnaire tab displayed in view mode
    And Current URL matches ".+\/ui\/admin\/questionnaire-management\/questionnaires\/(\w+)" endpoint regex
    And Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / toBeReplaced" is displayed
    And Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire setup "Question" tab is active
    And Questionnaire setup "Scoring" tab is active
    And Questionnaire Setup button "Next" is enabled
    And Questionnaire Setup button "Back To Overview" is enabled
    When User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Back To Overview"
    Then Questionnaire Overview page is displayed
    When User clicks on added questionnaire
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Information" tab is active
    And Questionnaire setup "Reviewers" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode

  @C46307861
  Scenario: C46307861: [Questionnaire] - Information Tab - View - Published (Active or Inactive Status)
    When User fills "with completed Internal data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire tab displayed in view mode
    And Current URL matches ".+\/ui\/admin\/questionnaire-management\/questionnaires\/(\w+)" endpoint regex
    And Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / toBeReplaced" is displayed
    And Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire setup "Question" tab is active
    And Questionnaire setup "Scoring" tab is active
    And Questionnaire Setup button "Next" is enabled
    And Questionnaire Setup button "Back To Overview" is enabled
    When User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Back To Overview"
    Then Questionnaire Overview page is displayed
    When User clicks on added questionnaire
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Information" tab is active
    And Questionnaire setup "Reviewers" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode