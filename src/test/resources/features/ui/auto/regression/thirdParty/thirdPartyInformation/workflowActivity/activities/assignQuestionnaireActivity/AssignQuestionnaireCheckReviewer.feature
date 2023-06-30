@ui @full_regression @core_regression @questionnaires @react
Feature: Onboarding - Assign Questionnaire Activity - Overall Reviewer

  As a Supplier Integrity Administrator or Assign Questionnaire Activity assignee
  I want to assign a new Questionnaire for the Questionnaire activity with Questionnaire Reviewer
  so Questionnaire Reviewer should be selected correct person

  @C38383068
  Scenario: C38383068: Assign Questionnaire Activity - Reviewer - Verify user select overall reviewer
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status      | Assignee                | Reviewer                      |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Unresponded | Admin_AT_FN Admin_AT_LN | Assignee_AT_FN Assignee_AT_LN |

