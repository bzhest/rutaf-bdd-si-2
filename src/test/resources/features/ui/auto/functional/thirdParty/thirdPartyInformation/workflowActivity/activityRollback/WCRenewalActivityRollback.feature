@ui @functional @activity_rollback
Feature: Activity Rollback - World Check Renewal Activity Rollback

  As Supplier Integrity Administrator or Internal User that has access rights to the Rollback functionality
  I want to change the status of the activity
  so that I will have the ability to revert or change the details of activities that have already been Completed.

  Background:
    Given User logs into RDDC as "Admin"
    When User updates Activity Type "World Check Screening" with following assessments via API
      | World Check Screening was completed     |
      | World Check Screening was not completed |
      | World Check Screening is not required   |
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
    And User adds new Activity "AUTO_TEST_WC_RENEWAL_1_1" with "World Check Screening Activity" data
    And User adds new Activity "AUTO_TEST_WC_RENEWAL_1_2" with "Simple Custom Activity" data
    And User adds new Activity "AUTO_TEST_WC_RENEWAL_1_3" with "Assessment One Field Custom Activity" data
    And User clicks Add Wizard Component button
    And User updates Component Name "Group_2"
    And User clicks Check button
    And User adds new Activity "AUTO_TEST_WC_RENEWAL_2_1" with "Simple Custom Activity" data
    And User adds new Activity "AUTO_TEST_WC_RENEWAL_2_2" with "Simple Custom Activity" data
    And User adds new Activity "AUTO_TEST_WC_RENEWAL_2_3" with "Simple Custom Activity" data
    And User adds new Activity "AUTO_TEST_WC_RENEWAL_2_4" with "Simple Custom Activity" data
    And User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User ticks checkbox for activity on position 1
    And User ticks checkbox for activity on position 2
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 3
    And User ticks checkbox for activity on position 4
    And User ticks checkbox for activity on position 5
    And User ticks checkbox for activity on position 6
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks workflow button "BRANCHING"
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_1" branching modal activity
    And User selects "AUTO_TEST_WC_RENEWAL_2_1" for "World Check Screening was completed" drop-down
    And User selects "AUTO_TEST_WC_RENEWAL_2_2" for "World Check Screening was not completed" drop-down
    And User clicks workflow button "Apply"
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_3" branching modal activity
    And User selects "AUTO_TEST_WC_RENEWAL_2_3" for "first" drop-down
    And User clicks workflow button "Apply"
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |
    When User creates third-party "with workflow group and assignee user responsible party"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    When User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "World Check Screening was completed"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_2" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_3" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "first"
    And User clicks 'Save' activity button
    And User clicks "Group_2" component tab
    And User clicks on "AUTO_TEST_WC_RENEWAL_2_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_WC_RENEWAL_2_3" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_WC_RENEWAL_2_4" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    When User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "toBeReplaced" is updated with type "Renewal"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "Renew" for third-party
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "World Check Screening was completed"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_2" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_3" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "first"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "In Progress"
    And User clicks 'Save' activity button
    Then Alert Dialog with text is displayed
      | Are you sure you want to change the status to In Progress?   |
      | The following activities may be recalled due to this change: |
      | AUTO_TEST_WC_RENEWAL_2_1                                     |
      | AUTO_TEST_WC_RENEWAL_2_4                                     |
    And Alert Dialog "Cancel" button displayed
    And Alert Dialog "Proceed" button displayed
    When User clicks "Proceed" Alert dialog button
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_1" activity
    Then Activity Information modal is displayed with details
      | Status      |
      | In Progress |
    And User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
      | FIELD ORIGINAL VALUE NEW VALUE |
      | Status Completed In Progress   |
    When User clicks Back button to return from Activity modal
    And User clicks "Group_2" component tab
    Then Activities table should contain the following activity
      | Name                     | Type                           | Assigned To             | Due Date | Status      |
      | AUTO_TEST_WC_RENEWAL_2_1 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Admin_AT_FN Admin_AT_LN | TODAY+1  | Not Started |
      | AUTO_TEST_WC_RENEWAL_2_2 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Admin_AT_FN Admin_AT_LN |          | Not Started |
      | AUTO_TEST_WC_RENEWAL_2_3 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Admin_AT_FN Admin_AT_LN | TODAY+1  | Not Started |
      | AUTO_TEST_WC_RENEWAL_2_4 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Admin_AT_FN Admin_AT_LN | TODAY+1  | Not Started |
    And Email notification "Activity Assigned" with following values is received by "Admin" user
      | <Activity_Name> | AUTO_TEST_WC_RENEWAL_2_3 |

  @C36696211
  @onlySingleThread
  @email
  Scenario: C36696211: [1] Supplier Onboarding - Rollback World Check Activity - Change Completed->In progress if succeeding activities not started, no approver - Renewal - Leave assessment activity
    Then Email notification "Activity Assigned" with following values is received by "Assignee" user
      | <Activity_Name> | AUTO_TEST_WC_RENEWAL_1_1 |
    And Email notification "Activity Recalled" with following values is received by "Admin" user
      | <Activity_Name> | AUTO_TEST_WC_RENEWAL_2_1 |
    And Email notification "Activity Recalled" with following values is received by "Admin" user
      | <Activity_Name> | AUTO_TEST_WC_RENEWAL_2_4 |
    And Email notification "Activity Reactivated" with following values is received by "Assignee" user
      | <Activity_Name> | AUTO_TEST_WC_RENEWAL_1_1 |
    And Email notification "Activity Recalled" with following values is received by "Assignee" user
      | <Activity_Name> | AUTO_TEST_WC_RENEWAL_2_1 |
    And Email notification "Activity Recalled" with following values is received by "Assignee" user
      | <Activity_Name> | AUTO_TEST_WC_RENEWAL_2_4 |
    When User deletes last emails for user "Admin"
    And User deletes last emails for user "Assignee"
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Screening Results' screening profile button
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_1" activity
    Then Activity Information modal is displayed with details
      | Status  |
      | Waiting |
    When User clicks Back button to return from Activity modal
    And User clicks on 1 number screening record
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_1" activity
    Then Activity Information modal is displayed with details
      | Status      |
      | In Progress |
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_1" activity
    Then Activity Information modal is displayed with details
      | Status    |
      | Completed |
    When User clicks Back button to return from Activity modal
    And User clicks "Group_2" component tab
    Then Activities table should contain the following activity
      | Name                     | Type                           | Assigned To             | Due Date | Status      |
      | AUTO_TEST_WC_RENEWAL_2_1 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Admin_AT_FN Admin_AT_LN | TODAY+1  | Not Started |
      | AUTO_TEST_WC_RENEWAL_2_3 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Admin_AT_FN Admin_AT_LN | TODAY+1  | Not Started |
      | AUTO_TEST_WC_RENEWAL_2_4 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Admin_AT_FN Admin_AT_LN | TODAY+1  | Not Started |
    And Activities table doesn't contain the following activity
      | Name                     | Type                           | Assigned To             | Due Date | Status      |
      | AUTO_TEST_WC_RENEWAL_2_2 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Admin_AT_FN Admin_AT_LN |          | Not Started |
    And Email notification "Activity Assigned" with following values is received by "Admin" user
      | <Activity_Name> | AUTO_TEST_WC_RENEWAL_2_1 |
    And Email notification "Activity Assigned" with following values is received by "Admin" user
      | <Activity_Name> | AUTO_TEST_WC_RENEWAL_2_4 |
    And Email notification "Activity Assigned" with following values is not received by "Admin" user
      | <Activity_Name> | AUTO_TEST_WC_RENEWAL_2_3 |
    When User clicks "Group_2" component tab
    And User clicks on "AUTO_TEST_WC_RENEWAL_2_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_WC_RENEWAL_2_3" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_WC_RENEWAL_2_4" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    And Third-party's status should be shown - "ONBOARDED"

  @C36696211
  @onlySingleThread
  @email
  Scenario: C36696211: [1] Supplier Onboarding - Rollback World Check Activity - Change Completed->In progress if succeeding activities not started, no approver - Renewal - Edit assessment activity
    When User deletes last emails for user "Admin"
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "World Check Screening was not completed"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_WC_RENEWAL_1_1" activity
    Then Activity Information modal is displayed with details
      | Status    |
      | Completed |
    When User clicks Back button to return from Activity modal
    And User clicks "Group_2" component tab
    Then Activities table should contain the following activity
      | Name                     | Type                           | Assigned To             | Due Date | Status      |
      | AUTO_TEST_WC_RENEWAL_2_2 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Admin_AT_FN Admin_AT_LN | TODAY+1  | Not Started |
      | AUTO_TEST_WC_RENEWAL_2_3 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Admin_AT_FN Admin_AT_LN | TODAY+1  | Not Started |
      | AUTO_TEST_WC_RENEWAL_2_4 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Admin_AT_FN Admin_AT_LN | TODAY+1  | Not Started |
    And Activities table doesn't contain the following activity
      | Name                     | Type                           | Assigned To             | Due Date | Status      |
      | AUTO_TEST_WC_RENEWAL_2_1 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Admin_AT_FN Admin_AT_LN | TODAY+1  | Not Started |
    And Email notification "Activity Assigned" with following values is received by "Admin" user
      | <Activity_Name> | AUTO_TEST_WC_RENEWAL_2_2 |
    And Email notification "Activity Assigned" with following values is received by "Admin" user
      | <Activity_Name> | AUTO_TEST_WC_RENEWAL_2_4 |
    And Email notification "Activity Assigned" with following values is not received by "Admin" user
      | <Activity_Name> | AUTO_TEST_WC_RENEWAL_2_3 |
