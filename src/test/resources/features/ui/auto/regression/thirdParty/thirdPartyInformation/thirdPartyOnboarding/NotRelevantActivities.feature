@ui @full_regression @workflow_completion
Feature: Not Relevant Activities behavior

  As a RDDC User Onboarding a Third-party
  I want to a specific behavior for Not relevant Activities
  So that I can avoid confusion in reviewing activities that are no longer needed for the Onboarding process

  @C37927170
  Scenario: C37927170: Verify that activity with CANCELLED status is hidden in the swimlane
    Given User logs into RDDC as "Admin"
    And User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User adds new Activity "Assign Questionnaire" with "Assign Questionnaire" data
    And User adds new Activity "AUTO_TEST_SIMPLE_ACTIVITY_TYPE_1" with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" data
    And User adds new Activity "AUTO_TEST_SIMPLE_ACTIVITY_TYPE_2" with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" data
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks "NEW COMPONENT" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status      | Assignee                | Reviewer                |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Unresponded | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN |
    When User clicks on Third-party Information tab
    Then Activities table should contain the following activity
      | Name                                    | Type                           | Assigned To                   | Due Date | Status      |
      | Assign Questionnaire                    | Assign Questionnaire           | Admin_AT_FN Admin_AT_LN       | TODAY+1  | Waiting     |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE_1        | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Assignee_AT_FN Assignee_AT_LN | TODAY+1  | Not Started |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE_2        | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Assignee_AT_FN Assignee_AT_LN | TODAY+1  | Not Started |
      | Internal Questionnaire for toBeReplaced | Questionnaire Assigned         | Admin_AT_FN Admin_AT_LN       | TODAY+0  | Not Started |
    When User clicks on "Assign Questionnaire" activity
    And User clicks Actions 'Cancel' button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks "Proceed" Alert dialog button
    Then Activity Information "Status" is displayed with "NOT STARTED"
    And Questionnaire Details table is empty with 'No Available Data' title
    When User clicks on Third-party Information tab
    Then Activities table should contain the following activity
      | Name                             | Type                           | Assigned To                   | Due Date | Status      |
      | Assign Questionnaire             | Assign Questionnaire           | Admin_AT_FN Admin_AT_LN       | TODAY+1  | Not Started |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE_1 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Assignee_AT_FN Assignee_AT_LN | TODAY+1  | Not Started |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE_2 | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Assignee_AT_FN Assignee_AT_LN | TODAY+1  | Not Started |
    And Activities table doesn't contain the following activity
      | Name                                    | Type                   |
      | Internal Questionnaire for toBeReplaced | Questionnaire Assigned |
    When User clicks on Questionnaire tab
    And Questionnaire tab is loaded
    And Questionnaire tab table should contain following questionnaires
      | Questionnaire Name               | Status    | Assignee                | Reviewer                |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Cancelled | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN |
    And User clicks on Risk Management tab
    And User clicks workflow with name "toBeReplaced" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User clicks "Internal Questionnaire for" Activity details on Workflow History page
    Then Workflow History Activity values should be displayed
      | Activity Type | Questionnaire Assigned                                           |
      | Description   | Click on the link below to view and/or answer the questionnaire. |
      | Assessment    |                                                                  |
      | Status        | Cancelled                                                        |
      | Assignee      | Admin_AT_FN Admin_AT_LN                                          |
      | Risk Area     |                                                                  |
      | Approvers     |                                                                  |
      | Reviewers     | Admin_AT_FN Admin_AT_LN                                          |
      | Start Date    | TODAY+0                                                          |
      | Due Date      | TODAY+0                                                          |
      | Last Update   |                                                                  |
    And Workflow History Questionnaire details is displayed
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Cancelled |

  @C38051199
  @onlySingleThread
  Scenario: C38051199: Verify all remaining activities are flagged as "Not Relevant" once the Approve/Decline onboarding activity is completed
    Given User logs into RDDC as "Assignee"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Ukraine"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_2"
    And User clicks Check button
    And User adds new Activity "Assign Questionnaire with Assignee user role"
    And User adds new Activity "World Check Screening Activity"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_3"
    And User clicks Check button
    And User adds new Activity "Approve Onboarding Activity"
    And User adds new Activity "Request for Due Diligence Activity"
    And User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User selects "Group 0" transfer to option
    And User clicks "Apply" grouping button
    And User ticks checkbox for activity on position 1
    And User ticks checkbox for activity on position 2
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 3
    And User ticks checkbox for activity on position 4
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Auto_Component_2" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks "Auto_Component_2" component tab
    And User clicks on "World Check Screening" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User navigates to Home page
    And User clicks 'Assigned Activities' widget
    Then Counter for Assigned Activities is displayed
    When Users clicks "Due Date" dashboard table column header
    And User waits for progress bar to disappear from page
    And User clicks on assigned activity with name "Approve Onboarding" for created third-party
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    When User navigates to Home page
    Then Last 3 Activities are excluded from Assigned Activities counter
    When User navigates to Reports page
    And User selects report category "My Third-party"
    And User inputs in Search Filter From "TODAY+0"
    And User inputs text in Search Filter To "TODAY+0"
    And User clicks on newly created Third-party on Report page
    Then Search result view "Third-party Status" is "ONBOARDED"
    And Search result view "Total No. of Activity" is "5"
    And Search result view "Total No. of Completed Activity" with "green_report" icon is "3"
    And Search result view "Total No. of Not Relevant Activity" with "grey_report" icon is "2"

  @C37995930
  Scenario: C37995930: Verify that the succeeding swim lanes is grayed out when all activities in component are NOT Relevant
    Given User logs into RDDC as "Assignee"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Ukraine"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "Assessment Activity With Assignee User"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_2"
    And User clicks Check button
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User adds new Activity "Assessment Three Field Custom Activity Assignee"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_3"
    And User clicks Check button
    And User adds new Activity "Approve Onboarding Activity"
    And User adds new Activity "Request for Due Diligence Activity"
    And User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 1
    And User ticks checkbox for activity on position 2
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 3
    And User ticks checkbox for activity on position 4
    And User selects "Group 3" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks workflow button "BRANCHING"
    And  User clicks on "Assessment Activity" branching modal activity
    Then Apply Branching modal is displayed
    When User selects "World Check Ongoing Screening Update" for "Deeper Dive" drop-down
    And User selects "Assessment Three Field Custom Activity Assignee" for "Resolved" drop-down
    And User clicks workflow button "Apply"
    And  User clicks on "Assessment Three Field Custom Activity Assignee" branching modal activity
    And User selects "Approve Onboarding" for "first" drop-down
    And User selects "Request for Due Diligence" for "second" drop-down
    And User clicks workflow button "Apply"
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Auto_Component_1" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "Deeper Dive"
    And User clicks 'Save' activity button
    Then Component's "Auto_Component_1" header swimlane text color is "light green"
    And Component's "Auto_Component_2" header swimlane text color is "dark blue"
    And Component's "Auto_Component_3" header swimlane text color is "black"
    When User clicks "Auto_Component_3" component tab
    Then Component's "Auto_Component_3" tooltip is shown: "All activities in this component are not relevant"

