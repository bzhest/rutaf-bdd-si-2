@ui @full_regression @questionnaires @react
Feature: Onboarding - Assign Questionnaire Activity - Internal Assignee

  As a Supplier Integrity Administrator or Assign Questionnaire Activity assignee
  I want to assign a new Questionnaire for the Questionnaire activity
  so that I will have the ability to add more Questionnaires for the Assign Questionnaire Activity.

  Background:
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    Then Active Internal Questionnaires are displayed alphabetically in Assign Questionnaire dialog window
    When User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    When User clicks Back button to return from Activity modal

  @core_regression
  @C38370235 @C38369128 @C39656896
  Scenario: C38370235, C38369128, C39656896: Assign Questionnaire Activity - UNRESPONDED - Verify questionnaire details
    When User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status      | Assignee                | Reviewer                |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Unresponded | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions buttons are
      | View | Cancel |

  @C38370236
  @core_regression
  Scenario: C38370236: Assign Questionnaire Activity - SAVE AS DRAFT - Verify questionnaire details
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Save As Draft" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status        | Assignee                | Reviewer                |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Save as Draft | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions buttons are
      | View | Cancel |

  @C38370237
  @core_regression
  Scenario: C38370237: Assign Questionnaire Activity - SUBMITTED - Verify questionnaire details
    When User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    | Assignee                | Reviewer                | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |

  @C38370238
  @core_regression
  Scenario: C38370238: Assign Questionnaire Activity - IN REVIEW - Verify questionnaire details
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Questionnaire Overall Assessment button "Approve"
    And User clicks Questionnaire Overall Assessment button "Confirm"
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    | Assignee                | Reviewer                | Overall Assessment | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Completed | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | Approved           | 0     |
    When User clicks "Actions" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on Activity Information Page for Questionnaire Details on 'Revert to in Review' button
    And User clicks "Proceed" Alert dialog button
    And Activity Information "Status" is displayed with "Waiting"
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            | Assignee                | Reviewer                | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Level 1 In Review | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            | Assignee                | Reviewer                | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Level 1 In Review | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |

  @C38370239
  @core_regression
  Scenario: C38370239: Assign Questionnaire Activity - REQUIRES REVISION - Verify questionnaire details
    And User clicks on "Questionnaire Assigned" activity
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
      | Questionnaire Name               | Status            | Assignee                | Reviewer                | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Requires Revision | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            | Assignee                | Reviewer                | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Requires Revision | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |

  @C38370240
  @core_regression
  Scenario: C38370240: Assign Questionnaire Activity - REVISION IN DRAFT - Verify questionnaire details
    And User clicks on "Questionnaire Assigned" activity
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
      | Questionnaire Name               | Status            | Assignee                | Reviewer                | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Requires Revision | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |
    When User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Save as Draft" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            | Assignee                | Reviewer                | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Revision in Draft | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |

  @C38370984
  @core_regression
  Scenario: C38370984: Assign Questionnaire Activity - REVISION SUBMITTED - Verify questionnaire details
    And User clicks on "Questionnaire Assigned" activity
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
      | Questionnaire Name               | Status            | Assignee                | Reviewer                | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Requires Revision | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |
    When User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Reply Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            | Assignee                | Reviewer                | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Level 1 In Review | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |

  @C38370241
  @core_regression
  Scenario: C38370241: Assign Questionnaire Activity - COMPLETED - Verify questionnaire details
    When User clicks "New Component" component tab
    And User clicks on "Questionnaire Assigned" activity
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
      | Questionnaire Name               | Status    | Assignee                | Reviewer                | Overall Assessment | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Completed | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | Rejected           | 0     |

  @C39657319
  Scenario: C39657319: Assign Questionnaire Activity - Activity Status - WAITING - Verify that status is disabled with Waiting status
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    Then Activity Information Status field should be disabled