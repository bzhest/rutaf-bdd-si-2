@ui @sanity @questionnaires @multilanguage
Feature: Questionnaire Setup

  As as Admin
  I want to allow user to add new questionnaire
  So that user can setup new questionnaire that can be assigned to Supplier for further data gathering

  Background:
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User navigates to Questionnaire Management page
    And Questionnaire Overview page is displayed
    And User clicks Add Questionnaire button

  @C32988231
  Scenario: C32988231: Questionnaire Setup - Add a Questionnaire (Simple Questionnaire)
    Then Add Questionnaire setup page displayed
    When User fills "with completed data and 1 to 5 scoring range" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    Then "Reviewers" Tab is displayed
    When User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds question with type "Multiple Choice" to active tab
    And User clicks Configuration icon
    And User fills "with completed data" question details
    And User fills in choice score on position 1 value "5"
    And User clicks Questionnaire Setup button "Next"
    And User clicks "Question" questionnaire tab
    And "Question" Tab is displayed
    And User clicks Configuration icon
    Then Question fields contains provided data
    When User clicks Questionnaire Setup button "Next"
    Then "Scoring" Tab is displayed
    And Scoring tab contains message "No Scoring Scheme is Available"
    When User fills "with completed data and 1 to 5 scoring range" required questionnaire scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Questionnaire Scores are displayed on scoring table with provided details
    When User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table

  @C32988232
  Scenario: C32988232: Questionnaire Setup - Edit a Questionnaire
    And User creates questionnaire "with random ID name" with 1 "New Tab" tabs
    And Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    When User fills "with completed data" required questionnaire setup information
    When User clicks Questionnaire Setup button "Save"
    And User navigates to Questionnaire Management page
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    Then Add Questionnaire setup page displayed
    Then Questionnaire's Setup Information page contains provided details
