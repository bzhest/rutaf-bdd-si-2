@ui @functional @dashboard
Feature: Home Page - My Tasks - Items To Review Widget - Questionnaire

  As an RDDC User
  I want a quick view of all the questionnaires assigned to me for review
  So that I can review the list without going through each Third-party Record

  @C43283395
  Scenario: C43283395: User is able to sort "QUESTIONNAIRES" table by "Third-party Name" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Questionnaire
    And Users clicks "Third-party Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Third-party Name" in "DESC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Third-party Name" in "ASC" order

  @C43283604
  Scenario: C43283604: User is able to sort "QUESTIONNAIRES" table by "Questionnaire Name" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Questionnaire
    And Users clicks "Questionnaire Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Name" in "ASC" order
    When Users clicks "Questionnaire Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Name" in "DESC" order
    When Users clicks "Questionnaire Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Name" in "ASC" order

  @C43283605
  Scenario: C43283605: User is able to sort "QUESTIONNAIRES" table by "Questionnaire Description" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Questionnaire
    And Users clicks "Questionnaire Description" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Description" in "ASC" order
    When Users clicks "Questionnaire Description" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Description" in "DESC" order
    When Users clicks "Questionnaire Description" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Description" in "ASC" order

  @C43283606
  Scenario: C43283606: User is able to sort "QUESTIONNAIRES" table by "Reviewer Name" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Questionnaire
    And Users clicks "Reviewer Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Reviewer Name" in "ASC" order
    When Users clicks "Reviewer Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Reviewer Name" in "DESC" order
    When Users clicks "Reviewer Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Reviewer Name" in "ASC" order

  @C43283607
  Scenario: C43283607: User is able to sort "QUESTIONNAIRES" table by "Questionnaire Due Date" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Questionnaire
    And Users clicks "Questionnaire Due Date" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Due Date" in "DESC" order
    When Users clicks "Questionnaire Due Date" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Due Date" in "ASC" order
    When Users clicks "Questionnaire Due Date" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Due Date" in "DESC" order

  @C43283608
  Scenario: C43283608: User is able to sort "QUESTIONNAIRES" table by "Questionnaire Status" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Questionnaire
    And Users clicks "Questionnaire Status" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Status" in "ASC" order
    When Users clicks "Questionnaire Status" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Status" in "DESC" order
    When Users clicks "Questionnaire Status" dashboard table column header
    Then "Items To Review" table displays records sorted by "Questionnaire Status" in "ASC" order

  @C35520549
  Scenario: C35520549: My Tasks - Items to review - Questionnaire - View the Questionnaire for review
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for"
    Then Activity Information page is displayed
    When User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" status should be "Submitted"
    When User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    And User saves Ad-Hoc Activity Id from URL in context
    When User navigates to Home page
    And User clicks 'Items To Review' widget
    Then Items To Review widget's counter displays sum of all items
    When User selects Items to Review Questionnaire
    Then Dashboard table name is "QUESTIONNAIRES"
    And Dashboard Items To Review table contains only expected questionnaire's statuses
    And Dashboard Items To Review table is displayed with column names
      | THIRD-PARTY NAME | QUESTIONNAIRE NAME | QUESTIONNAIRE DESCRIPTION | REVIEWER NAME | QUESTIONNAIRE DUE DATE | QUESTIONNAIRE STATUS |
    And Items to Review table contains activity
      | THIRD-PARTY NAME | QUESTIONNAIRE NAME               | QUESTIONNAIRE DESCRIPTION | REVIEWER NAME           | QUESTIONNAIRE DUE DATE | QUESTIONNAIRE STATUS |
      | toBeReplaced     | AUTO_TEST_INTERNAL_QUESTIONNAIRE |                           | Admin_AT_FN Admin_AT_LN | TODAY+0                | Submitted            |
    When User clicks on record "AUTO_TEST_INTERNAL_QUESTIONNAIRE" for created third-party
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type        | Activity Name        | Description                                                                       | Due Date | Assignee                | Status  |
      | Assign Questionnaire | Assign Questionnaire | This activity was automatically initiated through adhoc questionnaire assignment. | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Ad Hoc Activity page contains expected URL
    When User clicks review questionnaires
    And User clicks Questionnaire Overall Assessment button "Approve"
    And User clicks Questionnaire Overall Assessment button "Confirm"
    And User navigates to Home page
    Then Home page is loaded
    When User clicks 'Items To Review' widget
    Then Items to Review table doesn't contain activity
      | THIRD-PARTY NAME | QUESTIONNAIRE NAME               | QUESTIONNAIRE DESCRIPTION | REVIEWER NAME           | QUESTIONNAIRE DUE DATE | QUESTIONNAIRE STATUS |
      | toBeReplaced     | AUTO_TEST_INTERNAL_QUESTIONNAIRE |                           | Admin_AT_FN Admin_AT_LN | TODAY+0                | Submitted            |
    And Items To Review widget's counter displays sum of all items
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User refreshes page
    And User saves Ad-Hoc Activity Id from URL in context
    And User clicks Notification Bell
    Then "Questionnaire has been Assigned" notification displayed with text
      | Internal Questionnaire for |
      | thirdPartyName             |
    When User clicks "Questionnaire has been Assigned" "Internal Questionnaire for thirdPartyName" notification
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" status should be "Submitted"
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    Then Items To Review widget's counter displays sum of all items
    When User selects Items to Review Questionnaire
    Then Items to Review table contains activity
      | THIRD-PARTY NAME | QUESTIONNAIRE NAME               | QUESTIONNAIRE DESCRIPTION | REVIEWER NAME           | QUESTIONNAIRE DUE DATE | QUESTIONNAIRE STATUS |
      | toBeReplaced     | AUTO_TEST_INTERNAL_QUESTIONNAIRE |                           | Admin_AT_FN Admin_AT_LN | TODAY+0                | Submitted            |
    When User clicks on record "AUTO_TEST_INTERNAL_QUESTIONNAIRE" for created third-party
    Then Activity Information page is displayed
    And Activity Information page contains expected URL
    When User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks 'Change Reviewer' link
    And User selects reviewer "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" for Reviewer Flow for level "1"
    And User clicks button Save on Questionnaire tab for Reviewer Flow
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    Then Items To Review widget's counter displays sum of all items
    When User selects Items to Review Questionnaire
    Then Items to Review table doesn't contain activity
      | THIRD-PARTY NAME | QUESTIONNAIRE NAME               | QUESTIONNAIRE DESCRIPTION | REVIEWER NAME           | QUESTIONNAIRE DUE DATE | QUESTIONNAIRE STATUS |
      | toBeReplaced     | AUTO_TEST_INTERNAL_QUESTIONNAIRE |                           | Admin_AT_FN Admin_AT_LN | TODAY+0                | Submitted            |

  @C35604125
  Scenario: C35604125: My Tasks - Items to Review - Questionnaire - Verify that the records sorted by date creation (oldest being on top) in the list
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Questionnaire
    Then "Items To Review" table displays records sorted by "Questionnaire Due Date" in "ASC" order

  @C35604429
  Scenario: C35604429: My Tasks - Items to Review - Questionnaire - Verify that only third-party of an Onboarding Activity with ONBOARDING or RENEWING status should display
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks +Add Activity button
    And User fills in Activity "Request for Due Diligence Activity" details
    And User clicks Activity "Add Reviewer" tab
    And User selects "Admin_AT_FN Admin_AT_LN" value for Default Reviewer
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks "Decline Onboarding" third-party button
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    Then Items To Review widget's counter displays sum of all items
    When User selects Items to Review Questionnaire
    Then Items to Review table doesn't contain activity
      | THIRD-PARTY NAME | ACTIVITY NAME             | DESCRIPTION               | DUE DATE | ASSIGNED TO             | STATUS |
      | toBeReplaced     | Request for Due Diligence | Request for Due Diligence | TODAY+1  | Admin_AT_FN Admin_AT_LN | Done   |
