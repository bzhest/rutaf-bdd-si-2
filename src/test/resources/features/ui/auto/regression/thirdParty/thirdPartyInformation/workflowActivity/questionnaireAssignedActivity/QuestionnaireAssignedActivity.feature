@ui @core_regression @questionnaires
Feature: Third-party Information - Workflow Activity - Activity Visibility - Questionnaire Assigned Activity

  As as Assignee of Questionnaire
  I Want To auto generate a new activity for the questionnaire assignee/responder upon assignment
  So That Questionnaire Assignee/Responder will be notified and see list of questionnaire to be answered

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks "Assign Questionnaire Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
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

  @C38384414
  Scenario: C38384414: Questionnaire Assigned Activity - UNRESPONDED - Verify questionnaire details
    When User clicks on "Questionnaire Assigned" activity
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status      |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Unresponded |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "Answer" is displayed

  @C38384415
  Scenario: C38384415: Questionnaire Assigned Activity - SAVE AS DRAFT - Verify questionnaire details
    When User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Save As Draft" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status        |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Save as Draft |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "Answer" is displayed

  @C38384416
  Scenario: C38384416: Questionnaire Assigned Activity - SUBMITTED - Verify questionnaire details
    When User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "View" is displayed

  @C38384417
  Scenario: C38384417: Questionnaire Assigned Activity - IN REVIEW - Verify questionnaire details
    When User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Save"
    And User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Level 1 In Review |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "View" is displayed

  @C38384418
  Scenario: C38384418: Questionnaire Assigned Activity - REQUIRES REVISION - Verify questionnaire details
    When User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    And User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Requires Revision |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "Answer" is displayed

  @C38384419
  Scenario: C38384419: Questionnaire Assigned Activity - REVISION IN DRAFT - Verify questionnaire details
    When User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    And User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Save as Draft" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Revision in Draft |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "Answer" is displayed

  @C38384420
  Scenario: C38384420: Questionnaire Assigned Activity - REVISION SUBMITTED- Verify questionnaire details
    When User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    And User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Reply Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Level 1 In Review |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "View" is displayed


  @C38384421
  Scenario: C38384421: Questionnaire Assigned Activity - COMPLETED - Verify questionnaire details
    When User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    And User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Reply Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Questionnaire Overall Assessment button "Approve"
    And User clicks Questionnaire Overall Assessment button "Confirm"
    And User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Completed |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "View" is displayed

  @C38394006
  Scenario: C38394006: Questionnaire Assigned Activity - Activity Information - Verify activity details
    When User clicks on "Questionnaire Assigned" activity
    Then Activity Information page is displayed
    And Activity information Attachment block is expanded
    And Activity information page comment section is expanded
    And Activity Information modal is displayed with details
      | Activity Type          | Activity Name                             | Description                                                      | Due Date | Assignee                | Status      |
      | Questionnaire Assigned | Internal Questionnaire for thirdPartyName | Click on the link below to view and/or answer the questionnaire. | TODAY+0  | Admin_AT_FN Admin_AT_LN | Not Started |
    When User clicks Edit button for Activity
    Then Activity Information "Activity Name" field should be disabled
    And Activity Information "Due Date" field should be disabled
    And Activity Information Assignee can be edited
    And Activity Information "Description" field should be disabled
    And Activity Information "Status" field should be disabled

  @C38394007
  Scenario: C38394007: Questionnaire Assigned Activity - Activity Status DONE- Verify activity status when questionnaire status is Submitted/Revision Submitted
    When User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "View" is displayed
    And Activity Information modal is displayed with details
      | Status |
      | Done   |

  @C38394008
  Scenario: C38394008: Questionnaire Assigned Activity - Verify answer link is working
    When User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then Questionnaire details page is displayed
    And Questionnaire Overall Assessment button "Cancel" is enabled
    And Questionnaire Overall Assessment button "Save As Draft" is enabled
    And Questionnaire Overall Assessment button "Submit" is enabled
    When User selects "Yes" questionnaire answer option
    Then Questionnaire Overall Assessment button "Cancel" is enabled
    And Questionnaire Overall Assessment button "Save As Draft" is enabled
    And Questionnaire Overall Assessment button "Submit" is enabled
    When User clicks on "Save As Draft" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status        |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Save as Draft |
    When User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Cancel" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status        |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Save as Draft |
    When User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Cancel" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status        |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Save as Draft |
    When User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then Questionnaire Overall Assessment button "Cancel" is enabled
    And Questionnaire Overall Assessment button "Save As Draft" is enabled
    And Questionnaire Overall Assessment button "Submit" is enabled
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
