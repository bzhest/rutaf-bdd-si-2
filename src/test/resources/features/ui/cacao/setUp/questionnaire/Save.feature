@ui @cacao @functional @questionnaires
Feature: Questionnaire Management - Save

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page


  @C46323541
  Scenario: C46323541: [Questionnaire] - Add - Save only in Scoring tab
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save" is enabled
    When User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been saved |
    And Questionnaire is displayed on questionnaires table
    When User clicks Add Questionnaire button
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User fills in choice score on position 1 value "1"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Add Scoring Scheme questionnaire button
    And User fills "with completed data" scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been saved |
    And Questionnaire is displayed on questionnaires table

  @C46324403
  Scenario: C46324403: [Questionnaire] - Edit - Save on each tab
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    Then Questionnaire Setup button "Save" is enabled
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save" is enabled
    When User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Setup button "Save" is enabled
    When User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Setup button "Save" is enabled
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save" is enabled
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Setup button "Save" is enabled
    When User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    And Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    And Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    And Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    And Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    And User selects "Active" questionnaire status
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    And Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    And Questionnaire is displayed on questionnaires table

  @C46324519
  Scenario Outline: C46324519: [Questionnaire] - Edit - Save - Validations
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User selects "<status>" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Hide total score from reviewers" option on Reviewers tab
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Hide from" field
    And Questionnaire "Reviewers" tab is highlighted
    And Questionnaire "Settings" tab is highlighted
    When User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire "Reviewers" tab is highlighted
    And Questionnaire "Settings" tab is highlighted
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire "Reviewers" tab is highlighted
    When User clicks "Scoring" questionnaire tab
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Hide from" field
    And Questionnaire "Reviewers" tab is highlighted
    And Questionnaire "Settings" tab is highlighted
    When User selects Number of Reviewer Levels "4"
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User select Questionnaire Process Flow approve next level "Level 4" for level 1
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    When User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire Process Flow "Approve" input for level 2 is highlighted with error message "This field is required"
    And Questionnaire Process Flow "Approve" input for level 3 is highlighted with error message "This field is required"
    And Questionnaire "Reviewers" tab is highlighted
    And Questionnaire "Process Flow" tab is highlighted
    When User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire "Reviewers" tab is highlighted
    And Questionnaire "Settings" tab is highlighted
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire "Reviewers" tab is highlighted
    When User clicks "Scoring" questionnaire tab
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Hide from" field
    And Questionnaire "Reviewers" tab is highlighted
    And Questionnaire "Settings" tab is highlighted
    And Questionnaire "Process Flow" tab is highlighted
    When User clicks Questionnaire Reviewers "Settings" tab
    And User selects Reviewers Settings "Hide total score from reviewers" drop-down value "Level 1"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User" as Main Reviewer
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Questionnaire "Reviewers" tab is highlighted
    And Questionnaire "Rules" tab is highlighted
    And Error message "This field is required" is displayed near Questionnaire Rules Main Reviewer input
    When User clicks Questionnaire Reviewers "Process Flow" tab
    Then Questionnaire "Reviewers" tab is highlighted
    And Questionnaire "Rules" tab is highlighted
    And Questionnaire "Process Flow" tab is highlighted
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire "Reviewers" tab is highlighted
    When User clicks "Scoring" questionnaire tab
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Questionnaire "Reviewers" tab is highlighted
    And Questionnaire "Rules" tab is highlighted
    And Questionnaire "Process Flow" tab is highlighted
    And Error message "This field is required" is displayed near Questionnaire Rules Main Reviewer input
    When User selects "Responsible Party" as Main Reviewer
    And User clicks Questionnaire Reviewers "Process Flow" tab
    And User select Questionnaire Process Flow approve next level "End" for level 1
    And User clicks "Question" questionnaire tab
    And User clicks delete question button for question on position 1
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Questionnaire "Question" tab is highlighted
    When User clicks "Information" questionnaire tab
    Then Questionnaire "Question" tab is highlighted
    When User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Questionnaire "Question" tab is highlighted
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire "Question" tab is highlighted
    When User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Questionnaire "Question" tab is highlighted
    When User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    And Questionnaire is displayed on questionnaires table
    Examples:
      | status   |
      | Inactive |
      | Active   |
