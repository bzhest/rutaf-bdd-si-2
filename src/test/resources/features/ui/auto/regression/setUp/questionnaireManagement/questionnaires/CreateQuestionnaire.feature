@ui @full_regression @questionnaires
Feature: Questionnaire Setup - Creating Questionnaires

  As an Admin or Internal User that has access rights in User Management
  I want to setup questions
  So that User will be able to set up different question type, description and choices

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Questionnaire Management page
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button

  @C35942358
  @core_regression
  Scenario: C35942358: Questionnaire Setup - verify that user can create Internal/External Questionnaire
    Then Add Questionnaire setup page displayed
    When User fills "with completed data" required questionnaire setup information
    When User clicks Questionnaire Setup button "Next"
    Then "Reviewers" Tab is displayed
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    And User should be able to add up to 1 questions with multiply types for active tab
    When User clicks Configuration icon
    And User fills "with completed data" question details
    And User clicks Questionnaire Setup button "Next"
    And User clicks "Question" questionnaire tab
    And "Question" Tab is displayed
    And User clicks Configuration icon
    Then Question fields contains provided data
    When User clicks Questionnaire Setup button "Next"
    Then "Scoring" Tab is displayed
    And Scoring tab contains message "No Scoring Scheme is Available"
    When User fills "with completed data" required questionnaire scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Questionnaire Scores are displayed on scoring table with provided details
    When User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Success!                     |
      | Questionnaire has been saved |
    And Questionnaire is displayed on questionnaires table

  @C35942359
  @core_regression
  Scenario: C35942359: Questionnaire Setup - verify that user can edit existing Questionnaire setup - Edit Existing Active/Inactive Questionnaire
    When User creates questionnaire "with random ID name" with 1 "New Tab" tabs
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    Then Add Questionnaire setup page displayed
    When User clicks Questionnaire Setup button "Back To Overview"
    Then Questionnaire Overview page is displayed
    When User clicks on added questionnaire
    Then Add Questionnaire setup page displayed
    When User clicks "Reviewers" questionnaire tab
    And User clicks Back questionnaire button
    Then "Information" Tab is displayed
    When User clicks "Question" questionnaire tab
    And User clicks Back questionnaire button
    Then "Reviewers" Tab is displayed
    When User clicks "Information" questionnaire tab
    And User clicks Questionnaire Setup button "Next"
    Then "Reviewers" Tab is displayed
    When User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User clicks Questionnaire Setup button "Next"
    Then "Scoring" Tab is displayed
    When User clicks "Information" questionnaire tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks on added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks on added questionnaire
    And User clicks "Scoring" questionnaire tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks edit added questionnaire
    Then Questionnaire tab displayed in edit mode
    When User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Inactive"
    When User clicks edit added questionnaire
    Then Questionnaire tab displayed in edit mode
    When User selects "Active" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks edit added questionnaire
    And User clears Questionnaire Name
    When User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    When User fills "with completed data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks delete question button for question on position 1
    When User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    When User should be able to add up to 1 questions with multiply types for active tab
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User" as Main Reviewer
    When User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    When User fills current user name as Main Reviewer
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Success!                       |
      | Questionnaire has been updated |

  @C35942359
  @core_regression
  Scenario: C35942359: Questionnaire Setup - verify that user can edit existing Questionnaire setup - Cancel Edit Existing Questionnaire
    When User creates questionnaire "with random ID name" with 1 "New Tab" tabs
    Then Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    When User fills "with completed data" required questionnaire setup information without save in context
    And User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    Then Add Questionnaire setup page displayed
    And Questionnaire's Setup Information page contains provided details

  @C35942359
  @core_regression
  Scenario: C35942359: Questionnaire Setup - verify that user can edit existing Questionnaire setup - Edit Existing Saved as Draft Questionnaire
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    When User fills "with completed data" required questionnaire setup information
    Then Questionnaire Setup button "Save as draft" is displayed
    When User clicks Questionnaire Setup button "Next"
    Then "Reviewers" Tab is displayed
    And Questionnaire Setup button "Save as draft" is displayed
    When User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    And User should be able to add up to 1 questions with multiply types for active tab
    When User clicks Configuration icon
    And User fills "with completed data" question details
    Then Questionnaire Setup button "Save as draft" is displayed
    When User clicks Questionnaire Setup button "Next"
    And User clicks "Question" questionnaire tab
    Then "Question" Tab is displayed
    When User clicks Configuration icon
    Then Question fields contains provided data
    When User clicks Questionnaire Setup button "Next"
    Then "Scoring" Tab is displayed
    And Scoring tab contains message "No Scoring Scheme is Available"
    When User fills "with completed data" required questionnaire scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Questionnaire Scores are displayed on scoring table with provided details
    And Questionnaire Setup button "Save as draft" is displayed
    When User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Success!                       |
      | Questionnaire has been updated |
    When User navigates to Questionnaire Management page
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    Then Add Questionnaire setup page displayed
    And Questionnaire's Setup Information page contains provided details

  @C35991666
  Scenario: C35991666: Questionnaire Setup - verify that user can clone Questionnaire
    When User creates questionnaire "with random ID name" with 1 "New Tab" tabs
    Then Questionnaire is displayed on questionnaires table
    And Clone button is displayed for created Questionnaire
    When User clicks Clone questionnaire button for created Questionnaire
    Then Clone Questionnaire pop-up appears with Questionnaire Name
    When User clears New Questionnaire Name field
    And User clicks Clone Questionnaire modal "Clone" button
    Then Alert Icon for Questionnaire page is displayed with text
      | Cannot save                        |
      | Please complete the required field |
    And New Questionnaire Name field highlighted RED with "This field is required" message
    When User fills in New Questionnaire Name field with "toBeReplaced"
    And User clicks Clone Questionnaire modal "Clone" button
    Then Cloned Questionnaire is displayed on questionnaires table
    And Cloned Questionnaire is the same as Initial one
