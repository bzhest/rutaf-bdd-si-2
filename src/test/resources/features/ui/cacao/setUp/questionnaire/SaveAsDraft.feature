@ui @cacao @functional @questionnaires
Feature: Questionnaire Management - Save as Draft

  As an RDDC user with permissions to manage Questionnaires
  I want to be able to save a new questionnaire as a draft
  So that I can continue editing it when needed

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page

  @C46320818
  Scenario: C46320818: [Questionnaire] - Add - Save as Draft is displayed
    Then Questionnaire Setup button "Save as draft" is enabled
    When User clicks Questionnaire Setup button "Save as draft"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save as draft" is enabled
    When User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Setup button "Save as draft" is enabled
    When User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Setup button "Save as draft" is enabled
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save as draft" is enabled
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save as draft" is enabled
    When User clicks "Information" questionnaire tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Allow total score adjustment by entering a number" option on Reviewers tab
    And User clicks Questionnaire Setup button "Save as draft"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been Saved As Draft |
    And Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks Add Questionnaire button
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks Add Questionnaire button
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks Add Questionnaire button
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks Add Questionnaire button
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    Then Questionnaire's Setup Information page contains provided details

  @C46321067
  Scenario: C46321067: [Questionnaire] - Edit Saved as Draft - Save as Draft is displayed
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    Then Questionnaire Setup button "Save as draft" is enabled
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save as draft" is enabled
    When User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Setup button "Save as draft" is enabled
    When User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Setup button "Save as draft" is enabled
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save as draft" is enabled
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save as draft" is enabled
    When User clicks "Information" questionnaire tab
    And User clears Questionnaire Name
    And User clicks Questionnaire Setup button "Save as draft"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Allow total score adjustment by entering a number" option on Reviewers tab
    And User clicks Questionnaire Setup button "Save as draft"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been Saved As Draft |
    And Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    Then Questionnaire's Setup Information page contains provided details

  @C46321075
  Scenario: C46321075: [Questionnaire] - Edit Active/Inactive - Save as Draft not displayed
    When User fills "with completed data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    Then Questionnaire Setup button "Save as draft" is not displayed
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save as draft" is not displayed
    When User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Setup button "Save as draft" is not displayed
    When User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Setup button "Save as draft" is not displayed
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save as draft" is not displayed
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save as draft" is not displayed
    When User clicks "Information" questionnaire tab
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    Then Questionnaire Setup button "Save as draft" is not displayed
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save as draft" is not displayed
    When User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Setup button "Save as draft" is not displayed
    When User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Setup button "Save as draft" is not displayed
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save as draft" is not displayed
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save as draft" is not displayed
