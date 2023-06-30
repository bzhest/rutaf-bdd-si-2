@ui @cacao @functional @questionnaires
Feature: Questionnaire Management - Clone

  AS Admin or Internal user that has access right to set up questionnaire
  I WANT TO be able to clone the questionnaire
  SO THAT I can implement small changes and save time in redoing the questionnaire

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Questionnaire Management page


  @C46284792 @C49023490
  Scenario: C46284792, C49023490: [Questionnaire] - Main page - Clone - Validations
  Trigger screening from QST-Support Clone Questionnaire- Verify that the user can clone the questionnaire
    When User searches item by "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW" keyword
    And User clicks Clone questionnaire button for "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW" Questionnaire
    Then Clone Questionnaire pop-up appears with Questionnaire Name
    When User clears New Questionnaire Name field
    And User clicks Clone Questionnaire modal "Clone" button
    Then Alert Icon is displayed with text
      | Cannot save. Please complete the required field |
    And New Questionnaire Name field highlighted RED with "This field is required" message
    When User fills in New Questionnaire Name field with "AUTO_TEST_EXTERNAL_QUESTIONNAIRE"
    And User clicks Clone Questionnaire modal "Clone" button
    Then Alert Icon is displayed with text
      | Cannot Save. Questionnaire with this name already exists. |
    And New Questionnaire Name field highlighted RED with "Questionnaire with this name already exists" message

  @C46284801
  Scenario: C46284801: [Questionnaire] - Main page - Clone
    When User searches item by "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" keyword
    And User clicks Clone questionnaire button for "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" Questionnaire
    Then Clone Questionnaire pop-up appears with Questionnaire Name
    And Questionnaire New Questionnaire Name field is displayed as required
    And Questionnaire Management "Cancel" button is displayed
    And Questionnaire Management "Clone" button is displayed
    When User fills in New Questionnaire Name field with "toBeReplaced"
    And User clicks Clone Questionnaire modal "Clone" button
    Then Alert Icon is displayed with text
      | Success! A new questionnaire has been saved. |
    When User clears search input field
    Then Cloned Questionnaire is displayed on questionnaires table

  @C49023491
  Scenario: C49023491: Trigger screening from QST-Support Clone Questionnaire- Verify that the user can save clone the questionna
    When User clicks Add Questionnaire button
    And User creates Questionnaire with "with random ID name" data with "EnhancedTextEntryPlus" question
    Then Questionnaire is displayed on questionnaires table
    When User clicks Clone questionnaire button for created Questionnaire
    And User fills in New Questionnaire Name field with "toBeReplaced"
    And User clicks Clone Questionnaire modal "Cancel" button
    Then Cloned Questionnaire is not displayed on questionnaires table
    When User clicks Clone questionnaire button for created Questionnaire
    And User fills in New Questionnaire Name field with "toBeReplaced"
    And User clicks Clone Questionnaire modal "Clone" button
    Then Cloned Questionnaire is displayed on questionnaires table
    And Cloned Questionnaire is the same as Initial one
