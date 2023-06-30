@ui @full_regression @core_regression @questionnaires @react
Feature: Onboarding - Assign Questionnaire Activity - Role Permissions

  As a Supplier Integrity Administrator or Assign Questionnaire Activity assignee
  I want to assign a new Questionnaire for the Questionnaire activity with Questionnaire to Reviewer
  so only selected Reviewer will have access to review

  @C38394028
  Scenario: C38394028: Onboarding Supplier - Role Permission - Reviewer - not Reviewer can change the Questionnaire
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
    Then Questionnaires dropdown options are sorted alphabetically
    And Questionnaires dropdown options contains only active questionnaires
    When User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    When User clicks Back button to return from Activity modal
    And User clicks "New Component" component tab
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    When User logs into RDDC as "Approver"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then User shouldn't see Questionnaire Overall Assessment button "Reject"
    And User shouldn't see Questionnaire Overall Assessment button "Approve"

  @C38394029
  Scenario: C38394029: Onboarding Supplier - Role Permission - Reviewer - Verify that admin user with no system admin role cannot change the questionnaire reviewer
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
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    When User clicks Back button to return from Activity modal
    And User clicks "New Component" component tab
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    When User sets up role "Auto Test Full Permission Role" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "changing role user"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks "View" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then Questionnaire Change Reviewer link is not displayed

  @C38394030
  @email
  Scenario: C38394030: Onboarding Supplier - Role Permission - Reviewer - Only Sys. Admin can change Reviewer
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
    Then Questionnaires dropdown options are sorted alphabetically
    And Questionnaires dropdown options contains only active questionnaires
    When User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    When User clicks Back button to return from Activity modal
    And User clicks "New Component" component tab
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    When User logs into RDDC as "Assignee"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then Reviewer Flow table for Level "1" has reviewer "Assignee_AT_FN Assignee_AT_LN"
    When User clicks 'Change Reviewer' link
    And User selects reviewer "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" for Reviewer Flow for level "1"
    And User clicks button Save on Questionnaire tab for Reviewer Flow
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    | Assignee                | Reviewer                                      | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted | Admin_AT_FN Admin_AT_LN | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN | 0     |
    And Email notification "Refinitiv Due Diligence Centre - QA Regression : AUTO_TEST_INTERNAL_QUESTIONNAIRE has been assigned to you for review" is received by "approver" user

  @C38394031
  @email
  Scenario: C38394031: Onboarding Supplier - Role Permission - Assignor of Questionnaire - Verify that user can reassign reviewer of the questionnaire
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
    And User selects "Assignee_AT_FN Assignee_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    When User clicks Log Out button
    And User logs into RDDC as "Assignee"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    When User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks 'Change Reviewer' link
    And User selects reviewer "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" for Reviewer Flow for level "1"
    And User clicks button Save on Questionnaire tab for Reviewer Flow
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    | Assignee                      | Reviewer                                      | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted | Assignee_AT_FN Assignee_AT_LN | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN | 0     |
    And Email notification "Refinitiv Due Diligence Centre - QA Regression : AUTO_TEST_INTERNAL_QUESTIONNAIRE has been assigned to you for review" is received by "approver" user

  @C35962886
  @email
  Scenario: C35962886: Onboarding Supplier - Role Permission - System Admin Role - Verify that admin user can reassign the Assignee of the Assign Questionnaire & Questionnaire Assigned to another internal user and an email notification will be sent to the new assignee
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
    Then Questionnaires dropdown options are sorted alphabetically
    And Questionnaires dropdown options contains only active questionnaires
    When User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Questionnaire Assigned" activity
    And User clicks Edit button for Activity
    And User selects activity assignee "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Save' activity button
    Then Email notification "Refinitiv Due Diligence Centre - Internal Questionnaire for <Third_Party_Type> has been assigned to you" is received by "Assignee" user
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User selects activity assignee "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Save' activity button
    Then Email notification "Refinitiv Due Diligence Centre - Activity: Auto Activity has been assigned to you" is received by "Assignee" user

  @C35962649
  @email
  Scenario: C35962649: Onboarding Supplier - Role Permission - Assignee - Verify that user with no system admin role cannot change the assignee of Assign Questionnaire and Questionnaire Assigned activity
    Given User logs into RDDC as "Admin"
    And User sets up role "Auto Test Full Permission Role" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "changing role user"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Assignee_AT_FN Assignee_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User logs into RDDC as "changing role user"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    Then Activity Information Edit button is hidden