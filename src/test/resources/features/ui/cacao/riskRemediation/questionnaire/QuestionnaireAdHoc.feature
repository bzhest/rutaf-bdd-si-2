@ui @cacao @functional @risk_remediation @questionnaire
Feature: Risk Management tab - Verify Questionnaire Tab

  @C44056274
  Scenario: C44056274: [Risk Remediation] - Questionnaire Tab: Data Displayed - AD HOC- Mapped Assessment with Red flag changed by Reviewer- IN REVIEW
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name"
    And User clicks on "Questionnaire" tab on Third-party page
    Then Questionnaire tab is loaded
    When User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" in Questionnaire Details table
    And User answers Question Boolean on tab 0 with value "Yes"
    And User answers Question "Checkbox" on tab 0 with "defined" values
    And User answers Question "Currency" on tab 0 with "defined" values
    And User answers Question "Single Select" on tab 0 with "defined" values
    And User answers Question "Multi Select" on tab 0 with "defined" values
    And User answers Question Multiple Choice on tab 0 with value "Option"
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" status should be "Submitted"
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" clicks link "Review"
    And User clicks '+' to add Assessment for Question "MultiSelect" on tab 0
    And User adds comment "MultiSelect Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Boolean" on tab 0
    And User adds comment "Boolean Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Checkbox" on tab 0
    And User adds comment "Checkbox Auto Assessment Comment" for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "SingleSelect" on tab 0
    And User adds comment "SingleSelect Auto Assessment Comment" for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks Questionnaire Overall Assessment button "Save"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                 | Status    | Assignee                | Reviewer                | Score | Button |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | In Review | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     | REVIEW |
    When User clicks Back button to return from Activity modal
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                 | QUESTION    | ANSWER | ATTACHMENT | ASSIGNEE                | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Boolean     | Yes    |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | MultiSelect | Drop   |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
    When User clicks on "Assign Questionnaire" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" clicks link "Review"
    And User clicks '+' to add Assessment for Question "Multiple Choice" on tab 0
    And User adds comment "Multiple Choice Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks 'edit' icon for Assessment for Question "Boolean" on tab 0
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks Questionnaire Overall Assessment button "Save"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                 | Status    | Assignee                | Reviewer                | Score | Button |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | In Review | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     | REVIEW |
    When User clicks Back button to return from Activity modal
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                 | QUESTION        | ANSWER | ATTACHMENT | ASSIGNEE                | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Multiple Choice | Option |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | MultiSelect     | Drop   |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
