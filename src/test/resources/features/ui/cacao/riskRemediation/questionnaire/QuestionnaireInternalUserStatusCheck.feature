@ui @cacao @functional @risk_remediation @questionnaire
Feature: Risk Management tab - Verify Questionnaire Tab

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on Third-party Information tab
    Then Activity details table is loaded
    When User clicks "New Component" component tab
    And User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" in Questionnaire Details table
    And User answers Question Boolean on tab 0 with value "Yes"
    And User answers Question "Currency" on tab 0 with "defined" values
    And User answers Question "Multi Select" on tab 0 with "defined" values
    And User answers Question Multiple Choice on tab 0 with value "Option"
    And User answers Question "Single Select" on tab 0 with "defined" values
    And User answers Question "Checkbox" on tab 0 with "defined" values
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "defined" values
    And User answers Question "Text" on tab 0 with "defined" values
    And User answers Question "Date" on tab 0 with "defined" values
    And User answers Question "Number" on tab 0 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" status should be "Submitted"
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" clicks link "Review"

  @C44019454
  Scenario: C44019454: [Risk Remediation] - Questionnaire Tab: Data Displayed - Internal Questionnaire - Workflow - REVISION SUBMMITTED
    When User clicks '+' to add Assessment for Question "Currency" on tab 0
    And User adds comment "Currency Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "MultiSelect" on tab 0
    And User adds comment "MultiSelect Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Boolean" on tab 0
    And User adds comment "Boolean Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Multiple Choice" on tab 0
    And User adds comment "Multiple Choice Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "SingleSelect" on tab 0
    And User adds comment "SingleSelect Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                 | Status            | Assignee                | Reviewer                | Score |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Requires Revision | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |
    When User clicks Back button to return from Activity modal
    And User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Reply Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire1" activity
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                 | Status             | Assignee                | Reviewer                | Score |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Revision Submitted | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                 | QUESTION        | ANSWER | ATTACHMENT | ASSIGNEE                | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Currency        | AED 10 |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | MultiSelect     | Drop   |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Boolean         | Yes    |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Multiple Choice | Option |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | SingleSelect    | Drop   |            | Admin_AT_FN Admin_AT_LN | TODAY+         |

  @C45199740
  Scenario: C45199740: [Risk Remediation] - Questionnaire Tab: Data Displayed - Internal Questionnaire - Workflow - Reviewer Assessment with Red flag - ALL WORKFLOW STATUSES
    When User clicks '+' to add Assessment for Question "Currency" on tab 0
    And User adds comment "Currency Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks on "Save" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                 | Status    |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | In Review |
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    And User selects "Max" items per page
    Then Risk Remediation Questionnaire table is displayed with columns
      | QUESTIONNAIRE ASSIGNMENT ID |
      | QUESTIONNAIRE NAME          |
      | QUESTION                    |
      | ANSWER                      |
      | ATTACHMENT                  |
      | ASSIGNEE                    |
      | DATE SUBMITTED              |
    And Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                 | QUESTION | ANSWER | ATTACHMENT | ASSIGNEE                | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Currency | AED 10 |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
    When User applies "Stop Onboarding" action to workflow via API
    And User refreshes page
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                 | QUESTION | ANSWER | ATTACHMENT | ASSIGNEE                | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Currency | AED 10 |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
    When User applies "Start Onboarding" action to workflow via API
    And User refreshes page
    And User applies "Decline Onboarding" action to workflow via API
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    And User selects "Max" items per page
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                 | QUESTION | ANSWER | ATTACHMENT | ASSIGNEE                | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Currency | AED 10 |            | Admin_AT_FN Admin_AT_LN | TODAY+         |

  @C44020782
  Scenario: C44020782: [Risk Remediation] - Questionnaire Tab - NO DATA
    When User clicks '+' to add Assessment for Question "Currency" on tab 0
    And User adds comment "Currency Auto Assessment Comment" for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "MultiSelect" on tab 0
    And User adds comment "MultiSelect Auto Assessment Comment" for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Boolean" on tab 0
    And User adds comment "Boolean Auto Assessment Comment" for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Multiple Choice" on tab 0
    And User adds comment "Multiple Choice Auto Assessment Comment" for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "SingleSelect" on tab 0
    And User adds comment "SingleSelect Auto Assessment Comment" for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                 | Status            | Assignee                | Reviewer                | Score |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Requires Revision | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |
    When User clicks Back button to return from Activity modal
    And User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Reply Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire1" activity
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                 | Status             | Assignee                | Reviewer                | Score |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Revision Submitted | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table displays No Available Data