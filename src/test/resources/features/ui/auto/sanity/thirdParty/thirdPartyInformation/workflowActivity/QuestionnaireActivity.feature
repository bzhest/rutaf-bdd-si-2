@ui @sanity @questionnaires
Feature: Questionnaire Activity

  As as Admin Or Internal User that has access right
  I Want To be able to assign Questionnaire to either Internal or External user
  So That Client should be able to gather relevant information in order to make better decision in onboarding supplier

  @C32988294
  @email
  Scenario: C32988294: Third-party Onboarding - Internal User - Review Assigned Questionnaire Activity
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And  User navigates to Third-party page
    Then Third-party Overview tab is loaded
    When User searches third-party with name "Supplier_Internal_User"
    And User clicks third-party with name "Supplier_Internal_User"
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE_CONFIG" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Questionnaire_Approver_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User logs into RDDC as "Approver"
    And User sets up language via API
    Then Email notification "Questionnaire Assigned" with following values is received by "APPROVER" user
      | <Activity_Name> | Internal Questionnaire for Supplier_Internal_User DO NOT DELETE |
    When User opens email link
    Then Activity Information page is displayed
    When User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE_CONFIG" clicks link "activity.answerLink"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE_CONFIG" status should be "Submitted"
    And Email notification "Questionnaire Review" with following values is received by "Approver" user
      | <Questionnaire_Name> | AUTO_TEST_INTERNAL_QUESTIONNAIRE_CONFIG |
    And Email contains the following text
      | Dear Questionnaire_Approver_AT_FN,                                                                        |
      | Questionnaire has been assigned to you for review. Click on the following link to view the questionnaire. |
      | Best Regards,                                                                                             |
      | Refinitiv Due Diligence Centre                                                                            |
    When User logs into RDDC as "Approver"
    And User sets up language via API
    And User opens email link
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE_CONFIG" clicks link "questionnaire.review"
    Then User should see Questionnaire Overall Assessment button "questionnaire.rejectButton"
    And User should see Questionnaire Overall Assessment button "questionnaire.approveButton"
    When User clicks Questionnaire Overall Assessment button "questionnaire.approveButton"
    Then Overall Assessment confirmation modal appears
    When User fills in Comment text "AUTO_TEST"
    And User clicks Questionnaire Overall Assessment button "questionnaire.confirmButton"
    Then Activity Information page is displayed
    And Activity Information "activity.status" is displayed with "In Progress"
    And Email notification "Questionnaire Completed" with following values is received by "Admin" user
      | <Questionnaire_Name> | AUTO_TEST_INTERNAL_QUESTIONNAIRE_CONFIG |
    And Email notification "Activity Assigned" with following values is received by "Admin" user
      | <Activity_Name> | Assign Questionnaire |

  @C32988295
  @multilanguage
  @email
  Scenario: C32988295: Third-party Onboarding - Internal User - Attach file in Activity (Assign Questionnaire)
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And  User navigates to Third-party page
    Then Third-party Overview tab is loaded
    When User searches third-party with name "Supplier_Internal_User"
    And User clicks third-party with name "Supplier_Internal_User"
    And User clicks on Questionnaire tab
    When User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Questionnaire_Approver_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    When User logs into RDDC as "APPROVER"
    And User sets up language via API
    Then Email notification "Questionnaire Assigned" with following values is received by "APPROVER" user
      | <Activity_Name> | Internal Questionnaire for Supplier_Internal_User DO NOT DELETE |
    When User opens email link
    Then Activity Information page is displayed
    When User adds Activity attachment
      | logo.jpg | Activity description |
    Then Activity information page Attachment table row appears
      | File Name | Description          | Upload Date |
      | logo.jpg  | Activity description | TODAY       |
    When User clicks Back button to return from Activity modal
    Then Activity Information modal is closed
    And Risk Management page is displayed

  @C36136287 @C32988297
  @core_regression
  Scenario: C36136287, C32988297: Third-party Onboarding - Internal User - Assigned Questionnaire Activity - Update Status to Done
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User navigates to Home page
    And User clicks 'Assigned Activities' widget
    And User selects "Max" items per page
    And Users clicks "Third-party Name" dashboard table column header
    Then Assigned Activity for third-party is displayed
    When User clicks on assigned activity for created third-party
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    And Third-party's element "Offboard" should be shown
