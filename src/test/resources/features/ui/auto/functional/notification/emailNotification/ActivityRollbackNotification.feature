@ui @functional @activity_rollback
Feature: Activity Rollback Email Notification

  As an Internal User
  I want to receive an email notification when an activity is reactivated/recalled
  So that I will not miss the task.

  Background:
    Given User logs into RDDC as "Admin"
    When User updates Activity Type "Assign Questionnaire" with following assessments via API
      | first  |
      | second |
    And User navigates to 'Workflow Management' block 'Workflow' section
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
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_2" with "Assessment One Field Custom Activity" data
    And User clicks Add Wizard Component button
    And User updates Component Name "Group_2"
    And User clicks Check button
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_1" with "Simple Custom Activity" data
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_2" with "Simple Custom Activity" data
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_3" with "Simple Custom Activity" data
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_4" with "Simple Custom Activity" data
    And User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User ticks checkbox for activity on position 1
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 2
    And User ticks checkbox for activity on position 3
    And User ticks checkbox for activity on position 4
    And User ticks checkbox for activity on position 5
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks workflow button "BRANCHING"
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" branching modal activity
    And User selects "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_1" for "first" drop-down
    And User selects "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_2" for "second" drop-down
    And User clicks workflow button "Apply"
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_2" branching modal activity
    And User selects "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_3" for "first" drop-down
    And User clicks workflow button "Apply"
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |
    When User creates third-party "with workflow group and assignee user responsible party"
    And User clicks Start Onboarding for third-party
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "first"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_2" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "first"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "In Progress"
    And User clicks 'Save' activity button
    And User clicks "Proceed" Alert dialog button

  @C36804992
  @onlySingleThread
  @email
  Scenario: C36804992: Activity Recalled Notification: Verify notifications for Assignee/ Approver/Responsible Party - subject and body
    Then Email notification "Refinitiv Due Diligence Centre - Activity: AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_1 has been recalled" is received by "Admin" user
    And Email contains the following text
      | Dear Admin_AT_FN                                                                                                     |
      | Activity                                                                                                             |
      | AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_1                                                                               |
      | has been recalled due to possible changes on previous activities.                                                    |
      | For support please visit <a href="https://my.refinitiv.com" target="_blank">MyRefinitiv</a> customer support portal. |
      | Best Regards                                                                                                         |
      | Refinitiv Due Diligence Centre                                                                                       |

  @C36823339
  @onlySingleThread
  @email
  Scenario: C36823339: Activity Reactivated Notification: Verify notifications for Reviewer/Responsible Party - subject and body
    Then Email notification "Refinitiv Due Diligence Centre - Activity: AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1 has been reactivated" is received by "Assignee" user
    And Email contains the following text
      | Dear Assignee_AT_FN                                                                                                      |
      | Activity                                                                                                                 |
      | AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1                                                                                   |
      | has been reactivated. Click on the following link to view the activity                                                   |
      | For support please visit the <a href="https://my.refinitiv.com" target="_blank">MyRefinitiv</a> customer support portal. |
      | Best Regards                                                                                                             |
      | Refinitiv Due Diligence Centre                                                                                           |
    When User opens "Refinitiv Due Diligence Centre - Activity: AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1 has been reactivated" email link
    Then Activity Information modal is displayed with details
      | Activity Name                          |
      | AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1 |
    When User clicks Back button to return from Activity modal
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "first"
    And User clicks 'Save' activity button
    And User clicks "Group_2" component tab
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_3" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_2_4" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    And Third-party's status should be shown - "ONBOARDED"
    When User opens "Refinitiv Due Diligence Centre - Activity: AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1 has been reactivated" email link
    Then User is redirected to page 404
    