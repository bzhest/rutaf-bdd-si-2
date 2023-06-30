@ui @full_regression @robusta @activity_rollback
Feature: Assign Questionnaire Activity

  As a Supplier Integrity Administrator or Assign Questionnaire Activity assignee
  I want to assign a new Questionnaire for the Questionnaire activity
  so that I will have the ability to add more Questionnaires for the Assign Questionnaire Activity.

  Background:
    Given User creates valid email
    When User logs into RDDC as "Admin"
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User creates Associated Party "for questionnaire activity"
    Then Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    And User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity

  @C36936607
  @WSO2email
  Scenario: C36936607: Add Questionnaire if Assign Questionnaire Activity is in WAITING status (EXTERNAL user) - Onboarding
    When User clicks 'Assign Questionnaire' Activity Information button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_First_Name" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then 'Assign New' Questionnaire button should be displayed
    When User click on 'Assign New' Questionnaire button
    Then Assign Questionnaire window is opened
    And "Select Questionnaire" field is editable on Assign Questionnaire window
    When User clicks "Back" Assign Questionnaire dialog button
    Then "Select Type" field is not editable on Assign Questionnaire window
    When User selects "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    Then "Select Assignee" field is not editable on Assign Questionnaire window
    And "Select Due Date" field is editable on Assign Questionnaire window
    When User fills in due date - today +1 day
    And User clicks "Next" Assign Questionnaire dialog button
    Then "Assign Overall Reviewer" field is editable on Assign Questionnaire window
    When User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                      | Status      | Assignee                               | Reviewer                      |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE        | Unresponded | External_First_Name External_Last_Name | Admin_AT_FN Admin_AT_LN       |
      | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE | Unresponded | External_First_Name External_Last_Name | Assignee_AT_FN Assignee_AT_LN |
    When User clicks Actions 'View' button for Activity "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then 'Due date' should be today +0 days
    When User clicks on "Cancel" button while giving an answer on Questionnaire form page
    And User clicks Actions 'View' button for Activity "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" in Questionnaire Details table
    Then 'Due date' should be today +1 day
    When User clicks on "Cancel" button while giving an answer on Questionnaire form page
    Then Activity Information "Status" is displayed with "WAITING"
    When User clicks Back button to return from Activity modal
    And User clicks "New Component" component tab
    And User clicks on "Questionnaire Assigned" activity
    Then Activity Information "Status" is displayed with "NOT STARTED"
    And Activity Information "Assignee" is displayed with "External_First_Name External_Last_Name"
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                      | Status      |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE        | Unresponded |
      | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE | Unresponded |
    When User logs into RDDC as "user created during test"
    And User click on "Due within 5 days" widget for External user
    And User clicks on assigned activity for created third-party
    And User clicks "Answer" button for Activity "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                      | Status      |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE        | Responded   |
      | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE | Unresponded |
    When User logs into RDDC as "Admin"

  @C36936607
  @WSO2email
  Scenario: C36936607: Add Questionnaire if Assign Questionnaire Activity is in WAITING status (EXTERNAL user) - Onboarding - Activity In progress status
    When User clicks 'Assign Questionnaire' Activity Information button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_First_Name" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    When User logs into RDDC as "user created during test"
    And User click on "Due within 5 days" widget for External user
    And User clicks on assigned activity for created third-party
    And User clicks "Answer" button for Activity "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User logs into RDDC as "Admin"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Questionnaire Assigned" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE | Submitted |
    When User clicks Back button to return from Activity modal
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Questionnaire Overall Assessment button "Approve"
    And User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information "Status" is displayed with "IN PROGRESS"
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then 'Assign New' Questionnaire button should be displayed
    When User click on 'Assign New' Questionnaire button
    Then Assign Questionnaire window is opened
    And "Select Questionnaire" field is editable on Assign Questionnaire window
    When User clicks "Back" Assign Questionnaire dialog button
    Then "Select Type" field is not editable on Assign Questionnaire window
    When User selects "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    Then "Select Assignee" field is not editable on Assign Questionnaire window
    And "Select Due Date" field is editable on Assign Questionnaire window
    When User fills in due date - today +1 day
    And User clicks "Next" Assign Questionnaire dialog button
    Then "Assign Overall Reviewer" field is editable on Assign Questionnaire window
    When User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                      | Status      | Assignee                               | Reviewer                      | Overall Assessment | Score |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE        | Completed   | External_First_Name External_Last_Name | Admin_AT_FN Admin_AT_LN       | Approved           | 0     |
      | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE | Unresponded | External_First_Name External_Last_Name | Assignee_AT_FN Assignee_AT_LN |                    |       |
    And Activity Information "Status" is displayed with "WAITING"
    When User clicks Actions 'View' button for Activity "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then 'Due date' should be today +0 days
    When User clicks on "Cancel" button while giving an answer on Questionnaire form page
    And User clicks Actions 'View' button for Activity "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" in Questionnaire Details table
    Then 'Due date' should be today +1 day
    When User clicks on "Cancel" button while giving an answer on Questionnaire form page
    Then Activity Information "Status" is displayed with "WAITING"
    When User clicks Back button to return from Activity modal
    And User clicks "New Component" component tab
    And User clicks on "Questionnaire Assigned" activity
    Then Activity Information "Status" is displayed with "IN PROGRESS"
    And Activity Information "Assignee" is displayed with "External_First_Name External_Last_Name"
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                      | Status      |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE        | Completed   |
      | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE | Unresponded |
    When User logs into RDDC as "user created during test"
    And User click on "Due within 5 days" widget for External user
    And User clicks on assigned activity for created third-party
    And User clicks "Answer" button for Activity "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                      | Status    |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE        | Completed |
      | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE | Submitted |
    When User logs into RDDC as "Admin"

  @C36936607
  @WSO2email
  Scenario: C36936607: Add Questionnaire if Assign Questionnaire Activity is in WAITING status (EXTERNAL user) - Renewal
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "toBeReplaced" is updated with type "Renewal"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User clicks on created third-party
    And User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_First_Name" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then 'Assign New' Questionnaire button should be displayed
    When User click on 'Assign New' Questionnaire button
    Then Assign Questionnaire window is opened
    And "Select Questionnaire" field is editable on Assign Questionnaire window
    When User clicks "Back" Assign Questionnaire dialog button
    Then "Select Type" field is not editable on Assign Questionnaire window
    When User selects "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    Then "Select Assignee" field is not editable on Assign Questionnaire window
    And "Select Due Date" field is editable on Assign Questionnaire window
    When User fills in due date - today +1 day
    And User clicks "Next" Assign Questionnaire dialog button
    Then "Assign Overall Reviewer" field is editable on Assign Questionnaire window
    When User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                      | Status      | Assignee                               | Reviewer                      |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE        | Unresponded | External_First_Name External_Last_Name | Admin_AT_FN Admin_AT_LN       |
      | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE | Unresponded | External_First_Name External_Last_Name | Assignee_AT_FN Assignee_AT_LN |
    When User clicks Actions 'View' button for Activity "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then 'Due date' should be today +0 days
    When User clicks on "Cancel" button while giving an answer on Questionnaire form page
    And User clicks Actions 'View' button for Activity "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" in Questionnaire Details table
    Then 'Due date' should be today +1 day
    When User clicks on "Cancel" button while giving an answer on Questionnaire form page
    Then Activity Information "Status" is displayed with "WAITING"
    When User clicks Back button to return from Activity modal
    And User clicks "New Component" component tab
    And User clicks on "Questionnaire Assigned" activity
    Then Activity Information "Status" is displayed with "NOT STARTED"
    And Activity Information "Assignee" is displayed with "External_First_Name External_Last_Name"
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                      | Status      |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE        | Unresponded |
      | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE | Unresponded |
    When User logs into RDDC as "user created during test"
    And User click on "Due within 5 days" widget for External user
    And User clicks on assigned activity for created third-party
    And User clicks "Answer" button for Activity "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                      | Status      |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE        | Responded   |
      | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE | Unresponded |
    When User logs into RDDC as "Admin"

  @C36936607
  @WSO2email
  Scenario: C36936607: Add Questionnaire if Assign Questionnaire Activity is in WAITING status (EXTERNAL user) - Renewal - Activity In Progress status
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    Then Workflow "toBeReplaced" is updated with type "Renewal"
    When User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User clicks on created third-party
    And User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_First_Name" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    When User logs into RDDC as "user created during test"
    And User click on "Due within 5 days" widget for External user
    And User clicks on assigned activity for created third-party
    And User clicks "Answer" button for Activity "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE | Submitted |
    When User logs into RDDC as "Admin"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Questionnaire Overall Assessment button "Approve"
    And User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information "Status" is displayed with "IN PROGRESS"
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then 'Assign New' Questionnaire button should be displayed
    When User click on 'Assign New' Questionnaire button
    Then Assign Questionnaire window is opened
    And "Select Questionnaire" field is editable on Assign Questionnaire window
    When User clicks "Back" Assign Questionnaire dialog button
    Then "Select Type" field is not editable on Assign Questionnaire window
    When User selects "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    Then "Select Assignee" field is not editable on Assign Questionnaire window
    And "Select Due Date" field is editable on Assign Questionnaire window
    When User fills in due date - today +1 day
    And User clicks "Next" Assign Questionnaire dialog button
    Then "Assign Overall Reviewer" field is editable on Assign Questionnaire window
    When User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                      | Status      | Assignee                               | Reviewer                      | Overall Assessment | Score |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE        | Completed   | External_First_Name External_Last_Name | Admin_AT_FN Admin_AT_LN       | Approved           | 0     |
      | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE | Unresponded | External_First_Name External_Last_Name | Assignee_AT_FN Assignee_AT_LN |                    |       |
    And Activity Information "Status" is displayed with "WAITING"
    When User clicks Actions 'View' button for Activity "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then 'Due date' should be today +0 days
    When User clicks on "Cancel" button while giving an answer on Questionnaire form page
    And User clicks Actions 'View' button for Activity "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" in Questionnaire Details table
    Then 'Due date' should be today +1 day
    When User clicks on "Cancel" button while giving an answer on Questionnaire form page
    Then Activity Information "Status" is displayed with "WAITING"
    When User clicks Back button to return from Activity modal
    And User clicks "New Component" component tab
    And User clicks on "Questionnaire Assigned" activity
    Then Activity Information "Status" is displayed with "IN PROGRESS"
    And Activity Information "Assignee" is displayed with "External_First_Name External_Last_Name"
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                      | Status      |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE        | Completed   |
      | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE | Unresponded |
    When User logs into RDDC as "user created during test"
    And User click on "Due within 5 days" widget for External user
    And User clicks on assigned activity for created third-party
    And User clicks "Answer" button for Activity "AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name                      | Status    |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE        | Completed |
      | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE | Submitted |
    When User logs into RDDC as "Admin"
