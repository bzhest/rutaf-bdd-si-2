@ui @full_regression @robusta @activity_rollback
Feature: Activity Rollback - Questionnaire status can be returned to 'In Review' status

  As Supplier Integrity Administrator or Internal User that has access rights to the Rollback functionality
  I want to change the status of the activity
  So that I will have the ability to revert or change the details of activities that have already been Completed to 'In Review' .

  @C36806608
  Scenario: C36806608: Put Completed Questionnaires back to "In Review" in the Assign Questionnaire Activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User clicks on created third-party
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And Alert Icon is displayed with text
      | Success!                        |
      | Questionnaire has been assigned |
    And Activity Information Details page should have Questionnaire details "AUTO_TEST_INTERNAL_QUESTIONNAIRE" with status "Unresponded"
    When User clicks Back button to return from Activity modal
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Internal Questionnaire for" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" status should be "Submitted"
    When User clicks Back button to return from Activity modal
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Assign Questionnaire" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Review"
    And User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    And User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "In Progress"
    And Activity Information Details page should have Questionnaire details "AUTO_TEST_INTERNAL_QUESTIONNAIRE" with Reviewer Assessment "Approved"
    When User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Actions"
    And User clicks on Activity Information Page for Questionnaire Details on 'Revert to in Review' button
    And User clicks "Proceed" Alert dialog button
    And Activity Information "Status" is displayed with "Waiting"
    And Activity Information Details page should have Questionnaire details "AUTO_TEST_INTERNAL_QUESTIONNAIRE" with status "Level 1 In Review"
    And User clicks Back button to return from Activity modal
    And User clicks "Assign Questionnaire Component" tab
    Then Activities table should contain the following activity
      | Name                                    | Type                   | Assigned To             | Due Date | Status  |
      | Assign Questionnaire                    | Assign Questionnaire   | Admin_AT_FN Admin_AT_LN | TODAY+1  | Waiting |
      | Internal Questionnaire for toBeReplaced | Questionnaire Assigned | Admin_AT_FN Admin_AT_LN | TODAY+0  | Done    |

  @C36806608
  Scenario: C36806608: Put Completed Questionnaires back to "In Review" in the Assign Questionnaire Activity for Third Party in 'For Renewal' status
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Group_1"
    And User clicks Check button
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" with "Assign Questionnaire" data
    And User clicks Add Wizard Component button
    And User updates Component Name "Group_2"
    And User clicks Check button
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_1" with "Assessment One Field Custom Activity" data
    And User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |
    When User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks "Group_2" component tab
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    When User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User clicks on created third-party
    And Workflow "toBeReplaced" is updated with type "Renewal"
    And User clicks "Renew" for third-party
    And User clicks "Group_2" component tab
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks "Group_1" tab
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And Activity Information Details page should have Questionnaire details "AUTO_TEST_INTERNAL_QUESTIONNAIRE" with status "Unresponded"
    When User clicks Back button to return from Activity modal
    And User clicks "Group_1" tab
    And User clicks on "Internal Questionnaire for" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" status should be "Submitted"
    When User clicks Back button to return from Activity modal
    And User clicks "Group_1" tab
    And User clicks on "Assign Questionnaire" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Review"
    And User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    And User clicks Questionnaire Overall Assessment button "Confirm"
    And Activity Information page is displayed
    And Activity Information "Status" is displayed with "In Progress"
    And Activity Information Details page should have Questionnaire details "AUTO_TEST_INTERNAL_QUESTIONNAIRE" with Reviewer Assessment "Approved"
    When User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Actions"
    And User clicks on Activity Information Page for Questionnaire Details on 'Revert to in Review' button
    And User clicks "Proceed" Alert dialog button
    And Activity Information "Status" is displayed with "Waiting"
    And Activity Information Details page should have Questionnaire details "AUTO_TEST_INTERNAL_QUESTIONNAIRE" with status "Level 1 In Review"
    And User clicks Back button to return from Activity modal
    And User clicks "Group_1" tab
    Then Activities table should contain the following activity
      | Name                                    | Type                   | Assigned To             | Due Date | Status  |
      | AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1  | Assign Questionnaire   | Admin_AT_FN Admin_AT_LN | TODAY+1  | Waiting |
      | Internal Questionnaire for toBeReplaced | Questionnaire Assigned | Admin_AT_FN Admin_AT_LN | TODAY+0  | Done    |
