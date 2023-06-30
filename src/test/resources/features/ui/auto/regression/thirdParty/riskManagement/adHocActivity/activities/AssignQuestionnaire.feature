@ui @full_regression @core_regression @questionnaires @react
Feature: Ad Hoc - Assign Questionnaire Activity

  As a Supplier Integrity Administrator or Assign Questionnaire Activity assignee
  I want to assign a new Ad-Hoc Questionnaire
  so that I will have the ability to add more Questionnaires.

  Background:
    When User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"
    And User clicks on "Questionnaire" tab on Third-party page
    Then Questionnaire tab is loaded
    When User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button

  @C39468906
  Scenario: C39468906: Ad Hoc - Assign Questionnaire Activity - UNRESPONDED - Verify questionnaire details
    When User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status      | Assignee                | Reviewer                      |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Unresponded | Admin_AT_FN Admin_AT_LN | Assignee_AT_FN Assignee_AT_LN |

  @C39468907
  Scenario: C39468907: Ad hoc - Assign Questionnaire Activity - SAVE AS DRAFT - Verify questionnaire details
    When User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Save As Draft" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status        | Assignee                | Reviewer                      |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Save as Draft | Admin_AT_FN Admin_AT_LN | Assignee_AT_FN Assignee_AT_LN |

  @C39468908
  Scenario: C39468908: Ad hoc - Assign Questionnaire Activity - SUBMITTED - Verify questionnaire details
    When User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    | Assignee                | Reviewer                      | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted | Admin_AT_FN Admin_AT_LN | Assignee_AT_FN Assignee_AT_LN | 0     |

  @C39468909
  Scenario: C39468909: Ad Hoc - Assign Questionnaire Activity - IN REVIEW - Verify questionnaire details
    When User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Save"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    | Assignee                | Reviewer                | Score | Button |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | In Review | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     | REVIEW |

  @C39468910
  Scenario: C39468910: Ad Hoc - Assign Questionnaire Activity - REQUIRES REVISION - Verify questionnaire details
    When User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            | Assignee                | Reviewer                | Score | Button |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Requires Revision | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     | VIEW   |

  @C39468911
  Scenario: C39468911: Ad hoc - Assign Questionnaire Activity - REVISION IN DRAFT - Verify questionnaire details
    When User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            | Assignee                | Reviewer                | Score | Button |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Requires Revision | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     | VIEW   |
    When User clicks Back button to return from Activity modal
    And User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Save as Draft" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            | Assignee                | Reviewer                | Score | Button |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Revision in Draft | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     | VIEW   |

  @C39468912
  Scenario: C39468912: Ad hoc - Assign Questionnaire Activity - REVISION SUBMITTED - Verify questionnaire details
    When User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            | Assignee                | Reviewer                | Score | Button |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Requires Revision | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     | VIEW   |
    When User clicks Back button to return from Activity modal
    And User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Reply Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status             | Assignee                | Reviewer                | Score | Button |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Revision Submitted | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     | REVIEW |

  @C39468913
  Scenario: C39468913: Ad hoc - Assign Questionnaire Activity - COMPLETED - Verify questionnaire details
    When User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Questionnaire Overall Assessment button "Reject"
    And User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    | Assignee                | Reviewer                | Overall Assessment | Score | Button |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Completed | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | Rejected           | 0     | VIEW   |

  @C39468914
  Scenario: C39468914: Ad hoc - Assign Questionnaire Activity - Reviewer - Verify user select overall reviewer
    When User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Assign Questionnaire" activity
    Then Activity Information "Status" is displayed with "WAITING"
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status      | Assignee                | Reviewer                      |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Unresponded | Admin_AT_FN Admin_AT_LN | Assignee_AT_FN Assignee_AT_LN |