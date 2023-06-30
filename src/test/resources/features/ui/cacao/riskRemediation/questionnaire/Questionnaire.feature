@ui @cacao @functional @risk_remediation @questionnaire
Feature: Risk Management tab - Verify Questionnaire Tab

  @C44022942
  Scenario: C44022942: [Risk Remediation] - Questionnaire Tab: Data Displayed - External Questionnaire - Workflow- Reviewer Assessment with Red flag - LEVEL 1-6 IN REVIEW
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow"
    And User navigates 'Set Up' block 'User' section
    And User searches User by name "External_Questionnaire_User"
    And User clicks edit user button for user with First Name "External_Questionnaire_User"
    Then Edit User page is displayed
    When User selects "with questionnaire workflow" user Third-party
    And User checks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    And User navigates to Third-party page
    And User opens previously created Third-party
    And User clicks Start Onboarding for third-party
    Then Activity details table is loaded
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_Questionnaire_User" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User logs into RDDC as "External User for Questionnaire"
    And User click on "Due within 5 days" widget for External user
    And User clicks first activity for third-party "thirdPartyName"
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW" in Questionnaire Details table
    And User answers Question "Currency" on tab 0 with "defined" values
    And User clicks on "Next" button while giving an answer on Questionnaire form page
    And User answers Question "Multi Select" on tab 1 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW" status should be "Submitted"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    Then Activity details table is loaded
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW" clicks link "Review"
    And User clicks '+' to add Assessment for Question "Currency" on tab 0
    And User adds comment "Currency Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks Questionnaire Overall Assessment button "Save"
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                         | Status            | Assignee                                                     | Reviewer                      | Score |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW | Level 1 In Review | External_Questionnaire_User External_Questionnaire_User_Last | Assignee_AT_FN Assignee_AT_LN | 0     |
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                         | QUESTION | ANSWER | ATTACHMENT | ASSIGNEE                                                     | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW | Currency | AED 10 |            | External_Questionnaire_User External_Questionnaire_User_Last | TODAY+         |
    When User clicks on Third-party Information tab
    Then Activity details table is loaded
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW" clicks link "Review"
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                         | Status            | Assignee                                                     | Reviewer                      | Score |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW | Requires Revision | External_Questionnaire_User External_Questionnaire_User_Last | Assignee_AT_FN Assignee_AT_LN | 0     |
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Management Questionnaire section message "NO AVAILABLE DATA" is displayed if table is empty
    When User logs into RDDC as "External User for Questionnaire"
    And User click on "Due within 5 days" widget for External user
    And User clicks first activity for third-party "thirdPartyName"
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Reply Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    Then Activity details table is loaded
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                         | Status            | Assignee                                                     | Reviewer                      | Score |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW | Level 1 In Review | External_Questionnaire_User External_Questionnaire_User_Last | Assignee_AT_FN Assignee_AT_LN | 0     |
    When User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW" clicks link "Review"
    And User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                         | Status            |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW | Level 2 In Review |
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                         | QUESTION | ANSWER | ATTACHMENT | ASSIGNEE                                                     | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW | Currency | AED 10 |            | External_Questionnaire_User External_Questionnaire_User_Last | TODAY+         |
    When User clicks on Third-party Information tab
    Then Activity details table is loaded
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW" clicks link "Review"
    And User clicks Questionnaire Answer Form tab "Tab Two"
    And User clicks '+' to add Assessment for Question "MultiSelect" on tab 1
    And User adds comment "MultiSelect Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                         | Status            |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW | Level 3 In Review |
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                         | QUESTION    | ANSWER | ATTACHMENT | ASSIGNEE                                                     | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW | Currency    | AED 10 |            | External_Questionnaire_User External_Questionnaire_User_Last | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW | MultiSelect | Drop   |            | External_Questionnaire_User External_Questionnaire_User_Last | TODAY+         |