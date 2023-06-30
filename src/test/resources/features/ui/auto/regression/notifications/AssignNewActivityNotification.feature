@ui @full_regression @notification
Feature: On Screen Notifications - New Activity is Assigned

  As an Internal User Onboarding a Third-party
  I want to be notified whenever an activity is triggered and is assigned to me
  So that I won't miss the task and halt the Onboarding process

  @C35952557 @C35942370
  @onlySingleThread
  Scenario: C35952557, C35942370: [On Screen Notification] New Activity is Assigned to the User - onboarding
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine"
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks Start Onboarding for third-party
    And User navigates to Home page
    Then Notification Bell Icon contains 1 new notification
    When User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    When User clicks Notification Bell
    Then The list with notifications is closed
    When User clicks Notification Bell
    Then "Activity has been Assigned" notification displayed with text
      | OrderDueDiligenceReport |
    When User clicks "Activity has been Assigned" "OrderDueDiligenceReport" notification
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description              | Order Details                  | Due Date | Assignee                | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | Test Automation activity | ORDER DETAILS: NO ORDER PLACED | TODAY+1  | Admin_AT_FN Admin_AT_LN | Not Started |

  @C35952596
  @onlySingleThread
  @core_regression
  Scenario: C35952596: [On Screen Notification] New Activity is Assigned to the User - adhoc activity
    Given User logs into RDDC as "Assignee"
    When User creates third-party "with random ID name" via API and open it
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User navigates to Home page
    Then Notification Bell Icon contains 1 new notification
    When User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    And "Activity has been Assigned" notification displayed with text
      | AUTO_TEST_ACTIVITY_NAME |
    When User clicks "Activity has been Assigned" "AUTO_TEST_ACTIVITY_NAME" notification
    Then Activity Information modal is displayed with details
      | Activity Type                  | Activity Name           | Description           | Due Date | Assignee                      | Status      |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Assignee_AT_FN Assignee_AT_LN | Not Started |

  @C35952635
  @onlySingleThread
  @core_regression
  Scenario: C35952635: [On Screen Notification] New Activity assigned to a User Group is triggered - onboarding
    Given User logs into RDDC as "Assignee"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    And Workflow Create Workflow page is displayed
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    Then New Component is created
    And User clicks +Add Activity button
    And User fills in Activity "Assign Questionnaire With Group Assignee" details
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group"
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks Start Onboarding for third-party
    And User navigates to Home page
    Then Notification Bell Icon contains 1 new notification
    When User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    And "Activity has been Assigned" notification displayed with text
      | Auto Activity |
    When User clicks "Activity has been Assigned" "Auto Activity" notification
    Then Activity Information modal is displayed with details
      | Activity Type        | Activity Name | Description          | Due Date | Assignee       | Status      |
      | Assign Questionnaire | Auto Activity | Activity Description | TODAY+1  | Assignee Group | Not Started |

  @C35952681
  @onlySingleThread
  Scenario: C35952681: [On Screen Notification] Re-assign activity to another user in Onboarding
    Given User logs into RDDC as "Assignee"
    When User creates third-party "workflowGroupUkraine"
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "Admin"
    When User clicks Notification Bell
    Then "Activity has been Assigned" notification displayed with text
      | OrderDueDiligenceReport |
    When User clicks "Activity has been Assigned" "OrderDueDiligenceReport" notification
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description              | Order Details                  | Due Date | Assignee                | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | Test Automation activity | ORDER DETAILS: NO ORDER PLACED | TODAY+1  | Admin_AT_FN Admin_AT_LN | Not Started |
    When User logs into RDDC as "Assignee"
    And User opens previously created Activity
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks Edit button for Activity
    And User selects activity assignee "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Save' activity button
    Then Activity Information modal is closed
    When User refreshes page
    Then Notification Bell Icon contains 1 new notification
    When User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    And "Activity has been Assigned" notification displayed with text
      | OrderDueDiligenceReport |
    When User clicks "Activity has been Assigned" "OrderDueDiligenceReport" notification
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description              | Order Details                  | Due Date | Assignee                      | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | Test Automation activity | ORDER DETAILS: NO ORDER PLACED | TODAY+1  | Assignee_AT_FN Assignee_AT_LN | Not Started |

  @C35952777
  @onlySingleThread
  Scenario: C35952777: [On Screen Notification] Activity is set to Pending Assignment assigned to a User in Onboarding
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "With Pending For Assignment"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User refreshes page
    And User clicks Notification Bell
    Then "Activity has been Assigned" notification not displayed with text
      | Pending For Assignment |
    When User opens previously created Activity
    Then Activity Information modal is displayed with details
      | Activity Type         | Activity Name          | Description            | Due Date | Assignee | Status      |
      | World Check Screening | Pending For Assignment | Pending For Assignment | TODAY+1  |          | Not Started |
    When User clicks Edit button for Activity
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Activity Information modal is closed
    When User logs into RDDC as "Assignee"
    And User clicks Notification Bell
    Then "Activity has been Assigned" notification displayed with text
      | Pending For Assignment |
    When User clicks "Activity has been Assigned" "Pending For Assignment" notification
    Then Activity Information modal is displayed with details
      | Activity Type         | Activity Name          | Description            | Due Date | Assignee                      | Status      |
      | World Check Screening | Pending For Assignment | Pending For Assignment | TODAY+1  | Assignee_AT_FN Assignee_AT_LN | Not Started |

  @C35952794
  @onlySingleThread
  Scenario: C35952794: [On Screen Notification]  Activity originally assigned to a user group is re-assigned to a User in Onboarding
    Given User logs into RDDC as "Assignee"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "With Group Assignee" details
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User refreshes page
    And User clicks Notification Bell
    Then "Activity has been Assigned" notification displayed with text
      | With Group Assignee |
    When User clicks "Activity has been Assigned" "With Group Assignee" notification
    Then Activity Information modal is displayed with details
      | Activity Type         | Activity Name       | Description                     | Due Date | Assignee       | Status      |
      | World Check Screening | With Group Assignee | With Group Assignee description | TODAY+1  | Assignee Group | Not Started |
    When User clicks Edit button for Activity
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "Assignee"
    And User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And "Activity has been Assigned" notification displayed with text
      | With Group Assignee |
    When User clicks "Activity has been Assigned" "With Group Assignee" notification
    Then Activity Information modal is displayed with details
      | Activity Type         | Activity Name       | Description                     | Due Date | Assignee                      | Status      |
      | World Check Screening | With Group Assignee | With Group Assignee description | TODAY+1  | Assignee_AT_FN Assignee_AT_LN | Not Started |

  @C35952990
  Scenario: C35952990: [On Screen Notification] New Activity is Assigned to the User - onboarding - 404 error page
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User refreshes page
    And User clicks Notification Bell
    When User clicks "Activity has been Assigned" "OrderDueDiligenceReport" notification
    Then User is redirected to page 404

  @C35952990
  Scenario: C35952990: [On Screen Notification]  Activity originally assigned to a user group is re-assigned to a User in Onboarding - 404 error page
    Given User logs into RDDC as "Assignee"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "With Group Assignee" details
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User refreshes page
    And User clicks Notification Bell
    And User clicks "Activity has been Assigned" "With Group Assignee" notification
    And User clicks Edit button for Activity
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User opens previously created Third-party
    And User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User clicks Notification Bell
    And User clicks "Activity has been Assigned" "With Group Assignee" notification
    Then User is redirected to page 404

  @C35952990
  Scenario: C35952990: [On Screen Notification] Re-assign activity to another user in Onboarding - 404 error page
    Given User logs into RDDC as "Assignee"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User opens previously created Activity
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks Edit button for Activity
    And User selects activity assignee "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Save' activity button
    Then Activity Information modal is closed
    When User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User refreshes page
    And User clicks Notification Bell
    And User clicks "Activity has been Assigned" "OrderDueDiligenceReport" notification
    Then User is redirected to page 404

  @C35952990
  Scenario: C35952990: [On Screen Notification] Activity is set to Pending Assignment assigned to a User in Onboarding - 404 error page
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "With Pending For Assignment"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User opens previously created Activity
    And User clicks Edit button for Activity
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User logs into RDDC as "Assignee"
    And User clicks Notification Bell
    And User clicks "Activity has been Assigned" "Pending For Assignment" notification
    Then User is redirected to page 404

  @C35952990
  Scenario: C35952990: [On Screen Notification] New Activity assigned to a User Group is triggered - onboarding - 404 error page
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "Assign Questionnaire With Group Assignee" details
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User logs into RDDC as "Assignee"
    And User clicks Notification Bell
    And User clicks "Activity has been Assigned" "Auto Activity" notification
    Then User is redirected to page 404