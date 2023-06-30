@ui @cacao @functional @risk_remediation @questionnaire
Feature: Risk Management tab - Verify Questionnaire Tab

  @C44008497
  Scenario: C44008497: [Risk Remediation] - Risk Management tab - Verify Questionnaire Tab: Data Displayed - Onboarding - Reviewer Assessment with Red flag - IN REVIEW
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User refreshes page
    And User clicks Notification Bell
    Then "Questionnaire has been Assigned" notification displayed with text
      | Internal Questionnaire for |
      | thirdPartyName             |
    When User clicks "Questionnaire has been Assigned" "Internal Questionnaire for thirdPartyName" notification
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW" clicks link "Answer"
    And User answers Question "Currency" on tab 0 with "defined" values
    And User adds Attachment "logo.jpg" to Question "Boolean" on tab 0
    And User checks Question Checkbox on tab 0 with value "Auto Test Checkbox"
    And User checks Question Checkbox on tab 0 with value "Auto Checkbox Test"
    And User answers Question "Single Select" on tab 0 with "defined" values
    And User clicks on "Next" button while giving an answer on Questionnaire form page
    And User answers Question "EnhancedTextEntryPlus" on tab 1 with "defined" values
    And User clicks on "Next" button while giving an answer on Questionnaire form page
    And User answers Question "EnhancedTextEntryPlus" on tab 2 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW" status should be "Submitted"
    And Activity Information page is displayed
    When User clicks on Third-party Information tab
    Then Activity details table is loaded
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW" clicks link "Review"
    And User clicks '+' to add Assessment for Question "Currency" on tab 0
    And User adds comment "Currency Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Boolean" on tab 0
    And User adds comment "Boolean Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "MultiSelect" on tab 0
    And User adds comment "MultiSelect Auto Assessment Comment" for Question Assessment
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
    And User clicks '+' to add Assessment for Question "Checkbox" on tab 0
    And User adds comment "Checkbox Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks Answer Questionnaire "Tab two" tab
    And User clicks '+' to add Assessment for Question "Heading" on tab 1
    And User adds comment "Heading Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "EnhancedTextEntryPlus" on tab 1
    And User adds comment "EnhancedTextEntryPlus Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "TextEntryPlus" on tab 1
    And User adds comment "TextEntryPlus Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Number" on tab 1
    And User adds comment "Number Choice Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Text" on tab 1
    And User adds comment "Text Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Date" on tab 1
    And User adds comment "Date Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks on "Save" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                              | Status    |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | In Review |
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    And User selects "25" items per page
    Then Risk Remediation Questionnaire table is displayed with columns
      | QUESTIONNAIRE ASSIGNMENT ID |
      | QUESTIONNAIRE NAME          |
      | QUESTION                    |
      | ANSWER                      |
      | ATTACHMENT                  |
      | ASSIGNEE                    |
      | DATE SUBMITTED              |
    And Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                              | QUESTION              | ANSWER                                 | ATTACHMENT | ASSIGNEE                | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Boolean               |                                        | logo.jpg   | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | MultiSelect           |                                        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Multiple Choice       |                                        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | SingleSelect          | Drop                                   |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Checkbox              | Auto Test Checkbox, Auto Checkbox Test |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Currency              | AED 10                                 |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Heading               |                                        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Date                  |                                        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | EnhancedTextEntryPlus |                                        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | TextEntryPlus         |                                        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Number                |                                        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Text                  |                                        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |

  @C45224465
  @onlySingleThread
  Scenario: C45224465: [Risk Remediation] - Questionnaire Tab: Data Displayed - External Questionnaire - Workflow- Reviewer Assessment with Red flag - LEVEL 2 IN REVIEW
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
    And User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_2_IN_REVIEW" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_Questionnaire_User" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User logs into RDDC as "External User for Questionnaire"
    And User click on "Due within 5 days" widget for External user
    And User clicks first activity for third-party "thirdPartyName"
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_2_IN_REVIEW" in Questionnaire Details table
    And User answers Question "Currency" on tab 0 with "defined" values
    And User clicks on "Next" button while giving an answer on Questionnaire form page
    And User answers Question "Multi Select" on tab 1 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_2_IN_REVIEW" status should be "Submitted"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    Then Activity details table is loaded
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_2_IN_REVIEW" clicks link "Review"
    And User clicks Questionnaire Answer Form tab "Tab two"
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
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_2_IN_REVIEW | Level 2 In Review |
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                         | QUESTION    | ANSWER | ATTACHMENT | ASSIGNEE                                                     | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_2_IN_REVIEW | MultiSelect | Drop   |            | External_Questionnaire_User External_Questionnaire_User_Last | TODAY+         |

  @C44011714
  Scenario: C44011714: [Risk Remediation] - Questionnaire Tab: Data Displayed -Internal Questionnaire - Workflow- Reviewer Assessment with Red flag - COMPLETED
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User refreshes page
    And User clicks Notification Bell
    Then "Questionnaire has been Assigned" notification displayed with text
      | Internal Questionnaire for |
      | thirdPartyName             |
    When User clicks "Questionnaire has been Assigned" "Internal Questionnaire for thirdPartyName" notification
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" clicks link "Answer"
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" status should be "Submitted"
    When User clicks Back button to return from Activity modal
    And User clicks "NEW COMPONENT" tab
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" clicks link "Review"
    And User clicks '+' to add Assessment for Question "Currency" on tab 0
    And User adds comment "Currency Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Boolean" on tab 0
    And User adds comment "Boolean Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "MultiSelect" on tab 0
    And User adds comment "MultiSelect Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                 | Status    |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Completed |
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                 | QUESTION    | ANSWER | ATTACHMENT | ASSIGNEE                | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Currency    |        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | MultiSelect |        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Boolean     |        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |

  @C44022960
  @onlySingleThread
  Scenario: C44022960: [Risk Remediation] - Questionnaire Tab: Data Displayed - External - AD HOC- Reviewer Assessment with Red flag - IN REVIEW
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
    And User clicks on Questionnaire tab
    Then Questionnaire tab is loaded
    When User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_Questionnaire_User" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User logs into RDDC as "External User for Questionnaire"
    And User click on "Due within 5 days" widget for External user
    And User clicks first activity for third-party "thirdPartyName"
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" in Questionnaire Details table
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" status should be "Submitted"
    When User logs into RDDC as "Admin"
    And User clicks Notification Bell
    And User clicks "Questionnaire to Review" "External Questionnaire for thirdPartyName" notification
    Then Activity Information page is displayed
    When User clicks review questionnaires
    Then Questionnaire details page is displayed
    When User clicks '+' to add Assessment for Question "Currency" on tab 0
    And User adds comment "Currency Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Heading" on tab 0
    And User adds comment "Heading Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Date" on tab 0
    And User adds comment "Date Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks on "Save" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                | Status    |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL | In Review |
    When User clicks on Third-party Information tab
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                | QUESTION | ANSWER | ATTACHMENT | ASSIGNEE                                                     | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL | Currency |        |            | External_Questionnaire_User External_Questionnaire_User_Last | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL | Date     |        |            | External_Questionnaire_User External_Questionnaire_User_Last | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL | Heading  |        |            | External_Questionnaire_User External_Questionnaire_User_Last | TODAY+         |

  @C44057387
  @onlySingleThread
  Scenario: C44057387: [Risk Remediation] - Questionnaire Tab: Data Displayed - External Questionnaire - Workflow - BRANCHING question - LEVEL 1-2 IN REVIEW
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
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_Questionnaire_User" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User logs into RDDC as "External User for Questionnaire"
    And User click on "Due within 5 days" widget for External user
    And User clicks first activity for third-party "thirdPartyName"
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS" in Questionnaire Details table
    And User answers Question Boolean on tab 0 with value "No"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS" status should be "Submitted"
    When User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User opens previously created Third-party
    And User clicks "NEW COMPONENT" tab
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS" clicks link "Review"
    And User clicks to add Comment for Question "Boolean" on tab 0
    And User fills comment "Auto test Comment" for Question
    And User clicks Send Comment button for Question
    And User clicks Done comment button
    And User clicks on "Save" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                           | Status            |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS | Level 1 In Review |
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table displays No Available Data
    When User clicks on Third-party Information tab
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS" clicks link "Review"
    And User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                           | Status            |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS | Level 2 In Review |
    When User clicks on Third-party Information tab
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS" clicks link "Review"
    And User clicks Revision questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Add comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                           | Status            |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS | Requires Revision |
    When User logs into RDDC as "External User for Questionnaire"
    And User click on "Due within 5 days" widget for External user
    And User clicks first activity for third-party "thirdPartyName"
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS" in Questionnaire Details table
    And User answers Question Boolean on tab 0 with value "Yes"
    And User answers Question Single Select on tab 0 with value "Single Select 1"
    And User clicks Comment questionnaire button
    And User fills in Reply Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                           | Status            |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS | Level 2 In Review |
    When User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                           | QUESTION     | ANSWER          | ATTACHMENT | ASSIGNEE                                                     | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS | Boolean      | Yes             |            | External_Questionnaire_User External_Questionnaire_User_Last | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS | SingleSelect | Single Select 1 |            | External_Questionnaire_User External_Questionnaire_User_Last | TODAY+         |

  @C44020989
  Scenario: C44020989: [Risk Remediation] - Questionnaire Tab: Data Displayed -Internal Questionnaire - Workflow- Mapped Assessment with Red flag from settings- COMPLETED
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User refreshes page
    And User clicks Notification Bell
    Then "Questionnaire has been Assigned" notification displayed with text
      | Internal Questionnaire for |
      | thirdPartyName             |
    When User clicks "Questionnaire has been Assigned" "Internal Questionnaire for thirdPartyName" notification
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT" clicks link "Answer"
    And User answers Question Boolean on tab 0 with value "Yes"
    And User answers Question "Checkbox" on tab 0 with "defined" values
    And User answers Question "Single Select" on tab 0 with "defined" values
    And User answers Question Multiple Choice on tab 0 with value "Option"
    And User answers Question "Multi Select" on tab 0 with "defined" values
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT" status should be "Submitted"
    When User clicks Back button to return from Activity modal
    And User clicks "NEW COMPONENT" tab
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT" clicks link "Review"
    And User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                         | Status    |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT | Completed |
    When User clicks on Third-party Information tab
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                                         | QUESTION        | ANSWER | ATTACHMENT | ASSIGNEE                | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT | Boolean         | Yes    |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT | MultiSelect     | Drop   |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT | Multiple Choice | Option |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT | SingleSelect    | Drop   |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT | Checkbox        | Check  |            | Admin_AT_FN Admin_AT_LN | TODAY+         |

  @C44018979
  Scenario: C44018979: [Risk Remediation] - Questionnaire Tab: Data NOT Displayed - Workflow- No questionnaire record- REQUIRES REVISION
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User refreshes page
    And User clicks Notification Bell
    Then "Questionnaire has been Assigned" notification displayed with text
      | Internal Questionnaire for |
      | thirdPartyName             |
    When User clicks "Questionnaire has been Assigned" "Internal Questionnaire for thirdPartyName" notification
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" clicks link "Answer"
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" status should be "Submitted"
    When User clicks Back button to return from Activity modal
    And User clicks "NEW COMPONENT" tab
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" clicks link "Review"
    And User clicks '+' to add Assessment for Question "Currency" on tab 0
    And User adds comment "Currency Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Heading" on tab 0
    And User adds comment "Heading Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Date" on tab 0
    And User adds comment "Date Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks to add Comment for Question "Boolean" on tab 0
    And User fills comment "Auto test Comment" for Question
    And User clicks Send Comment button for Question
    And User clicks Done comment button
    And User clicks on "Send to assignee" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                 | Status            |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED | Requires Revision |
    When User clicks on Third-party Information tab
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table displays No Available Data

  @C43693454
  @onlySingleThread
  Scenario: C43693454: [Risk Remediation] - Questionnaire tab - Verify Sorting and Pagination
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
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User refreshes page
    And User clicks Notification Bell
    Then "Questionnaire has been Assigned" notification displayed with text
      | Internal Questionnaire for |
      | thirdPartyName             |
    When User clicks "Questionnaire has been Assigned" "Internal Questionnaire for thirdPartyName" notification
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT" clicks link "Answer"
    And User answers Question Boolean on tab 0 with value "Yes"
    And User answers Question "Checkbox" on tab 0 with "defined" values
    And User answers Question "Single Select" on tab 0 with "defined" values
    And User answers Question Multiple Choice on tab 0 with value "Option"
    And User answers Question "Multi Select" on tab 0 with "defined" values
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT" status should be "Submitted"
    When User clicks Back button to return from Activity modal
    And User clicks "NEW COMPONENT" tab
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT" clicks link "Review"
    And User clicks to add Comment for Question "Boolean" on tab 0
    And User fills comment "Auto test Comment" for Question
    And User clicks Send Comment button for Question
    And User clicks Done comment button
    And User clicks on "Save" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                         | Status    |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT | In Review |
    When User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_Questionnaire_User" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User logs into RDDC as "External User for Questionnaire"
    And User click on "Due within 5 days" widget for External user
    And User clicks first activity for third-party "thirdPartyName"
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" in Questionnaire Details table
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "defined" values
    And User adds Attachment "logo.jpg" to Question "Currency" on tab 0
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" status should be "Submitted"
    When User logs into RDDC as "Admin"
    And User clicks Notification Bell
    And User clicks "Questionnaire to Review" "External Questionnaire for thirdPartyName" notification
    Then Activity Information page is displayed
    When User clicks review questionnaires
    Then Questionnaire details page is displayed
    When User clicks '+' to add Assessment for Question "Currency" on tab 0
    And User adds comment "Currency Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Heading" on tab 0
    And User adds comment "Heading Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks '+' to add Assessment for Question "Date" on tab 0
    And User adds comment "Date Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                                | Status    |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL | Completed |
    When User clicks on Third-party Information tab
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Pagination option "10" is selected
    And Pagination buttons should be visible
      | first page | previous page | next page | last page |
    And Questionnaire Risk Remediation table is sorted by "Questionnaire Name" in "ASC" order
    And Questionnaire Risk Remediation Question column has default sorting
      | Currency        |
      | Date            |
      | Heading         |
      | Boolean         |
      | SingleSelect    |
      | MultiSelect     |
      | Multiple Choice |
      | Checkbox        |
    When User clicks Questionnaire Risk Remediation "Questionnaire Assignment ID" column
    Then Questionnaire Risk Remediation table is sorted by "Questionnaire Assignment ID" in "ASC" order
    When User clicks Questionnaire Risk Remediation "Questionnaire Assignment ID" column
    Then Questionnaire Risk Remediation table is sorted by "Questionnaire Assignment ID" in "DESC" order
    When User clicks Questionnaire Risk Remediation "Questionnaire Name" column
    Then Questionnaire Risk Remediation table is sorted by "Questionnaire Name" in "ASC" order
    When User clicks Questionnaire Risk Remediation "Questionnaire Name" column
    Then Questionnaire Risk Remediation table is sorted by "Questionnaire Name" in "DESC" order
    When User clicks Questionnaire Risk Remediation "Question" column
    Then Questionnaire Risk Remediation table is sorted by "Question" in "ASC" order
    When User clicks Questionnaire Risk Remediation "Question" column
    Then Questionnaire Risk Remediation table is sorted by "Question" in "DESC" order
    When User clicks Questionnaire Risk Remediation "Answer" column
    Then Questionnaire Risk Remediation table is sorted by "Answer" in "ASC" order
    When User clicks Questionnaire Risk Remediation "Answer" column
    Then Questionnaire Risk Remediation table is sorted by "Answer" in "DESC" order
    When User clicks Questionnaire Risk Remediation "Attachment" column
    Then Questionnaire Risk Remediation table is sorted by "Attachment" in "ASC" order
    When User clicks Questionnaire Risk Remediation "Attachment" column
    Then Questionnaire Risk Remediation table is sorted by "Attachment" in "DESC" order
    When User clicks Questionnaire Risk Remediation "Assignee" column
    Then Questionnaire Risk Remediation table is sorted by "Assignee" in "ASC" order
    When User clicks Questionnaire Risk Remediation "Assignee" column
    Then Questionnaire Risk Remediation table is sorted by "Assignee" in "DESC" order
    When User clicks Questionnaire Risk Remediation "Date Submitted" column
    Then Questionnaire Risk Remediation table is sorted by "Date Submitted" in "ASC" order
    When User clicks Questionnaire Risk Remediation "Date Submitted" column
    Then Questionnaire Risk Remediation table is sorted by "Date Submitted" in "DESC" order

  @C43973403
  Scenario: C43973403: [Risk Remediation] - Questionnaire Tab - Verify View Record Details page
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User refreshes page
    And User clicks Notification Bell
    Then "Questionnaire has been Assigned" notification displayed with text
      | Internal Questionnaire for |
      | thirdPartyName             |
    When User clicks "Questionnaire has been Assigned" "Internal Questionnaire for thirdPartyName" notification
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW" clicks link "Answer"
    And User answers Question "Currency" on tab 0 with "defined" values
    And User clicks on "Next" button while giving an answer on Questionnaire form page
    And User answers Question "EnhancedTextEntryPlus" on tab 1 with "defined" values
    And User clicks on "Next" button while giving an answer on Questionnaire form page
    And User answers Question "EnhancedTextEntryPlus" on tab 2 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW" status should be "Submitted"
    And Activity Information page is displayed
    When User clicks on Third-party Information tab
    Then Activity details table is loaded
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW" clicks link "Review"
    And User clicks '+' to add Assessment for Question "Currency" on tab 0
    And User adds comment "Currency Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks Answer Questionnaire "Tab two" tab
    And User clicks '+' to add Assessment for Question "Heading" on tab 1
    And User adds comment "Heading Auto Assessment Comment" for Question Assessment
    And User toggles 'Tag as red flag' for Question Assessment
    And User clicks Question Assessment Add button
    And User clicks on "Save" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                              | Status    |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | In Review |
    When User clicks on Third-party Information tab
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Questionnaire" tab
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                              | QUESTION | ANSWER | ATTACHMENT | ASSIGNEE                | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Currency | AED 10 |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Heading  |        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
    When User clicks on Questionnaire Risk Remediation record "Heading"
    Then Questionnaire details page is displayed
    And Questionnaire Answer Form tab "Tab two" is displayed
    And Current URL contains "/thirdparty/thirdPartyId/questionnaire/" endpoint
    When User clicks back browser button
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                              | QUESTION | ANSWER | ATTACHMENT | ASSIGNEE                | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Currency | AED 10 |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Heading  |        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
    When User clicks on Questionnaire Risk Remediation record "Currency"
    Then Questionnaire details page is displayed
    And Questionnaire Answer Form tab "Tab One" is displayed
    And Current URL contains "/thirdparty/thirdPartyId/questionnaire/" endpoint
    When User clicks Questionnaire Details Cancel button
    Then Risk Remediation Questionnaire table is displayed with next details
      | QUESTIONNAIRE NAME                              | QUESTION | ANSWER | ATTACHMENT | ASSIGNEE                | DATE SUBMITTED |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Currency | AED 10 |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW | Heading  |        |            | Admin_AT_FN Admin_AT_LN | TODAY+         |
