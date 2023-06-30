@ui @robusta @automation_logic
Feature: Add/Edit Questionnaires with Automation Logic

  As RDDC User
  I want to be able to pre-select the Questionnaires Type in the Add Activity
  So that I can guide the assignment of relevant questionnaires in the Onboarding/Renewal process for my Third parties

  Background:
    Given User logs into RDDC as "Admin"
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User creates new Workflow "Onboarding Workflow" with Activity "Simple Custom Activity"
    And User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks +Add Activity button
    Then Activity "Add Activity" tab is displayed

  @C54406028 @core_regression
  Scenario: C54406028: Workflow Activity - Assign Questionnaire - Automation Logic - Add Assign Questionnaire activity - Retrieve questionnaire reviewer is ON and filter questionnaire to Internal Questionnaire Type
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Assign Questionnaire"
    And User selects "Internal" Questionnaire Type
    Then "Internal" questionnaire type radio button should be selected
    And "External" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "Internal" Relevant Questionnaire dropdown button should be enabled
    And Internal Relevant Questionnaires drop-down contains all internal questionnaires
    When User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" relevant questionnaire
    And User ticks Retrieve the reviewer of each questionnaire setup checkbox
    And User populates Activity Description with "Assign Questionnaire"
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been added. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow should be created

  @C54406029 @core_regression
  Scenario: C54406029: Workflow Activity - Assign Questionnaire - Automation Logic - Add Assign Questionnaire activity - Retrieve questionnaire reviewer is ON and filter questionnaire to External Questionnaire Type
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Assign Questionnaire"
    And User selects "External" Questionnaire Type
    Then "External" questionnaire type radio button should be selected
    And "Internal" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "External" Relevant Questionnaire dropdown button should be enabled
    And External Relevant Questionnaires drop-down contains all external questionnaires
    When User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" relevant questionnaire
    And User ticks Retrieve the reviewer of each questionnaire setup checkbox
    And User populates Activity Description with "Assign Questionnaire"
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been added. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow should be created