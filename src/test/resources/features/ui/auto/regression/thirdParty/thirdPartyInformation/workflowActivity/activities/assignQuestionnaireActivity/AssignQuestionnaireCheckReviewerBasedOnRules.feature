@ui @full_regression @core_regression @questionnaires @react
Feature: Onboarding - Assign Questionnaire Activity - Reviewer Based On Reviewer Rule

  As a Supplier Integrity Administrator or Assign Questionnaire Activity assignee
  I want to assign a new Questionnaire for the Questionnaire activity with Questionnaire based on Reviewer rules
  so Questionnaire Reviewer should be selected depending on default Reviewer selected

  @C38383070
  Scenario Outline: C38383070: Assign Questionnaire Activity - Reviewer - Verify reviewer based on reviewer rule
    Given User logs into RDDC as "Admin"
    When User navigates to Questionnaire Management page
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Country" Reviewer "Rule" from drop-down
    And User fills "Norway" Reviewer "Third-party Country"
    And User selects "<rule>" as Reviewer
    And User fills user "<defaultReviewer>" as Questionnaire Reviewer
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User should be able to add up to 1 questions with multiply types for active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table
    When User navigates to Third-party page
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And Activity Information page is displayed
    And Activity Information modal is displayed with details
      | Status  |
      | Waiting |
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name       | Status      | Assignee                | Reviewer       |
      | questionnaireNameContext | Unresponded | Admin_AT_FN Admin_AT_LN | <reviewerName> |
    Examples:
      | rule              | defaultReviewer               | reviewerName                  |
      | User              | Assignee_AT_FN Assignee_AT_LN | Assignee_AT_FN Assignee_AT_LN |
      | User Group        | Assignee Group                | Assignee Group                |
      | Responsible Party |                               | Admin_AT_FN Admin_AT_LN       |
