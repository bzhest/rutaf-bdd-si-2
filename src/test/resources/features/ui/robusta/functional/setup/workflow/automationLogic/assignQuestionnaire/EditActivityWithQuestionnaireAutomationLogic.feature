@ui @robusta @automation_logic
Feature: Add/Edit Questionnaires with Automation Logic in Assign Questionnaire Modal

  As RDDC User
  I want to be able to pre-select the Questionnaires Type in the Add Activity
  So that I can guide the assignment of relevant questionnaires in the Onboarding/Renewal process for my Third parties

  Background:
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow" with Activity "Assign Questionnaire"
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"

  @C47575318
  Scenario: C47575318 - Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity - Change Questionnaire Type from Internal to External
    When User selects "Internal" Questionnaire Type
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE_SECOND" relevant questionnaire
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then "Internal" questionnaire type radio button should be selected
    When User selects "External" Questionnaire Type
    Then Relevant External Questionnaire field should be empty
    And External Relevant Questionnaires drop-down contains all external questionnaires
    When User selects "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" relevant questionnaire
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed

  @C47575319
  Scenario: C47575319 - Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity - Change Questionnaire Type from Internal to All
    When User selects "Internal" Questionnaire Type
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE_SECOND" relevant questionnaire
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then "Internal" questionnaire type radio button should be selected
    When User selects "All" Questionnaire Type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed

  @C47575320
  Scenario: C47575320 - Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity - Change Questionnaire Type from External to Internal
    When User selects "External" Questionnaire Type
    And User selects "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" relevant questionnaire
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then "External" questionnaire type radio button should be selected
    When User selects "Internal" Questionnaire Type
    Then Relevant Internal Questionnaire field should be empty
    And Internal Relevant Questionnaires drop-down contains all internal questionnaires
    When User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE_SECOND" relevant questionnaire
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed

  @C47575321
  Scenario: C47575321 - Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity - Change Questionnaire Type from External to All
    When User selects "External" Questionnaire Type
    And User selects "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" relevant questionnaire
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then "External" questionnaire type radio button should be selected
    When User selects "All" Questionnaire Type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed

  @C47575322
  Scenario: C47575322 - Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity - Change Questionnaire Type from All to Internal
    Then "All" questionnaire type radio button should be selected
    When User selects "Internal" Questionnaire Type
    Then Relevant Internal Questionnaire field should be empty
    And Internal Relevant Questionnaires drop-down contains all internal questionnaires
    When User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE_SECOND" relevant questionnaire
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed

  @C47575323
  Scenario: C47575323 - Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity - Change Questionnaire Type from All to External
    Then "All" questionnaire type radio button should be selected
    When User selects "External" Questionnaire Type
    Then Relevant External Questionnaire field should be empty
    And External Relevant Questionnaires drop-down contains all external questionnaires
    When User selects "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" relevant questionnaire
    When User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed
