@ui @cacao @functional @risk_remediation @questionnaire @onlySingleThread
Feature: Risk Management tab - Verify Questionnaire Tab

  Background:
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

  @C44009889
  Scenario: C44009889: [Risk Remediation] - Questionnaire Tab: Data NOT Displayed - Workflow- No questionnaire record - UNRESPONDED
    When User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_Questionnaire_User" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                | Status      | Assignee                                                     | Reviewer                      | Score |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL | Unresponded | External_Questionnaire_User External_Questionnaire_User_Last | Assignee_AT_FN Assignee_AT_LN |       |
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Management Questionnaire section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44009931
  Scenario: C44009931: [Risk Remediation] - Questionnaire Tab: Data NOT Displayed - Workflow- No questionnaire record- SAVED AS DRAFT
    When User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_Questionnaire_User" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User logs into RDDC as "External User for Questionnaire"
    And User click on "Due within 5 days" widget for External user
    And User selects "Max" items per page
    And User clicks first activity for third-party "thirdPartyName"
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" in Questionnaire Details table
    And User answers Question Boolean on tab 0 with value "Yes"
    And User answers Question "Checkbox" on tab 0 with "defined" values
    And User answers Question "Single Select" on tab 0 with "defined" values
    And User answers Question Multiple Choice on tab 0 with value "Option"
    And User answers Question "Multi Select" on tab 0 with "defined" values
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "defined" values
    And User answers Question "Text" on tab 0 with "defined" values
    And User answers Question "Date" on tab 0 with "defined" values
    And User answers Question "Number" on tab 0 with "defined" values
    And User answers Question "Currency" on tab 0 with "defined" values
    And User clicks on "Save As Draft" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                | Status        |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL | Save as Draft |
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    Then Activity details table is loaded
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Management Questionnaire section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44057318
  Scenario: C44057318: [Risk Remediation] - Questionnaire Tab: Data NOT Displayed - Workflow- No questionnaire record - RESPONDED
    When User selects "AUTO_TEST_2_QUESTIONNAIRES_WITH_RISK_REMEDIATION_EXTERNAL" questionnaires
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_Questionnaire_User" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User logs into RDDC as "External User for Questionnaire"
    And User click on "Due within 5 days" widget for External user
    And User selects "Max" items per page
    And User clicks first activity for third-party "thirdPartyName"
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" in Questionnaire Details table
    And User answers Question Boolean on tab 0 with value "Yes"
    And User answers Question "Checkbox" on tab 0 with "defined" values
    And User answers Question "Single Select" on tab 0 with "defined" values
    And User answers Question Multiple Choice on tab 0 with value "Option"
    And User answers Question "Multi Select" on tab 0 with "defined" values
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "defined" values
    And User answers Question "Text" on tab 0 with "defined" values
    And User answers Question "Date" on tab 0 with "defined" values
    And User answers Question "Number" on tab 0 with "defined" values
    And User answers Question "Currency" on tab 0 with "defined" values
    And User clicks on "Save" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" status should be "Responded"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    Then Activity details table is loaded
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Management Questionnaire section message "NO AVAILABLE DATA" is displayed if table is empty