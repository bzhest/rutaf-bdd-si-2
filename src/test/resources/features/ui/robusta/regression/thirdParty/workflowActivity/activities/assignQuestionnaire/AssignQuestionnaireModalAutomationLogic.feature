@ui @robusta @automation_logic
Feature: Add/Edit Questionnaires with Automation Logic in Assign Questionnaire Modal

  As RDDC User
  I want to be able to pre-select the Questionnaires Type in the Add Activity
  So that I can guide the assignment of relevant questionnaires in the Onboarding/Renewal process for my Third parties

  Background:
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group"

  @C47656980 @core_regression
  Scenario: C47656980 - Assign Questionnaire Activity - Assign Questionnaire Modal - Questionnaire Type in WF setup: Internal Questionnaire
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    And User selects "Internal" Questionnaire Type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    And User opens previously created Third-party
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks on Assign Questionnaire button
    Then Assign Questionnaire window is opened
    And "Select Type" field is not editable on Assign Questionnaire window
    And "Select Questionnaire" field is editable on Assign Questionnaire window
    When User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been assigned |

  @C47656981 @core_regression
  Scenario: C47656981 - Assign Questionnaire Activity - Assign Questionnaire Modal - Questionnaire Type in WF setup: External Questionnaire
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    And User selects "External" Questionnaire Type
    And User clicks Done button for Activity
    And User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    And User creates valid email
    And User creates Associated Party "Individual" "with valid email and enabled as user" via API and open it
    And User clicks on Third-party Information tab
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks on Assign Questionnaire button
    Then Assign Questionnaire window is opened
    And "Select Type" field is not editable on Assign Questionnaire window
    And "Select Questionnaire" field is editable on Assign Questionnaire window
    When User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Test_First_Name Test_Last_Name" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been assigned |

  @C47656982 @core_regression
  Scenario: C47656982 - Assign Questionnaire Activity - Assign Questionnaire Modal - Questionnaire Type in WF setup: All Questionnaire
    When User opens previously created Third-party
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks on Assign Questionnaire button
    Then Assign Questionnaire window is opened
    And "Select Type" field is editable on Assign Questionnaire window
    When User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    Then "Select Questionnaire" field is editable on Assign Questionnaire window
    When User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been assigned |
