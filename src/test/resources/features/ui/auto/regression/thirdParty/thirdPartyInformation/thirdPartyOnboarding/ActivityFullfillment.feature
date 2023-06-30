@ui @full_regression @workflow_completion
Feature: Activity Fulfillment/Completion

  As an Internal User Onboarding a Supplier
  I want to view the details of triggered/Enabled Onboarding activities
  So that I can manage the activities and monitor them accodingly

  @C40459261 @C40459262
  @email
  Scenario: C40459261, C40459262: Email Notification- Verify that Activity Assignee should not received email notification
    Given User logs into RDDC as "Admin"
    And User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Ukraine"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks +Add Activity button
    And User fills in Activity "Request for Due Diligence Activity" details
    And User clicks Activity "Add Approver" tab
    And User clicks 'Add Existing Approval Process' button
    And User selects approval process with name "Automation Approval Process"
    And User click approval process button "Select"
    And User clicks Activity "Add Reviewer" tab
    And User selects "Assignee_AT_FN Assignee_AT_LN" value for Default Reviewer
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group Ukraine"
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "Request for Due Diligence" activity
    And User approves all activities
    When User clicks on Risk Management tab
    And User clicks workflow with name "toBeReplaced" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User uploads "logo.jpg" Attachment on Workflow History page
    And User clicks "UPLOAD" button for Workflow History Activity Attachment
    And User fills in comment field "Auto Activity Comment test" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    Then Email notification "Request for Review" with following values is not received by "Assignee" user
      | <Activity_Name> | Request for Due Diligence |

  @C35942582
  Scenario: C35942582: [Workflow completion] Viewing of activities in Supplier information page
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineIndividualWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    Then Activities table should contain the following activity
      | Name                    | Type                       | Assigned To             | Due Date | Status      |
      | OrderDueDiligenceReport | Order Due Diligence Report | Admin_AT_FN Admin_AT_LN | TODAY+1  | Not Started |
    When User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description | Order Details                  | Due Date | Priority | Assessment | Assignee                | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | description | ORDER DETAILS: NO ORDER PLACED | TODAY+1  |          |            | Admin_AT_FN Admin_AT_LN | Not Started |
    And Activity Information Edit button is displayed
    And Activity Information Approvers table should contain the following columns
      | ASSIGNED TO | LAST UPDATE | ACTION | STATUS |
    And Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update | Action                  | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Approve,Reject,Reassign | Pending |

  @C35942588
  @core_regression
  Scenario: C35942588: [Workflow completion] Assigning Activities to Users
    Given User logs into RDDC as "Assignee"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "World Check Screening Activity with Group"
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "New Component" component tab
    And User clicks on "World Check Screening" activity
    Then Activity Information modal is displayed with details
      | Assignee       |
      | Assignee Group |
    When User clicks Edit button for Activity
    Then User "Assignee" was assigned to this activity
    And Assignee drop-down contains all the Active Members of "Assignee Group" group

  @C35953941
  Scenario: C35953941: [Workflow completion] Changing activity status - From Completed
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks "Assign Questionnaire Component" component tab
    And User clicks on "Assign Questionnaire" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    Then Activity Information Status field should be disabled
    When User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Activity Information page is displayed
    When User approves all activities
    And User clicks Edit button for Activity
    Then Activity Information Status field should be enabled
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Assign Questionnaire" activity
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "Completed"
    When User clicks Edit button for Activity
    Then Activity Information Status field should be enabled
    And Activity Status drop-down contains the next options
      | In Progress |
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Approver "Admin_AT_FN" and Reviewer "Admin_AT_FN"
    And User creates third-party "with workflow group Ukraine"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User clicks Back button to return from Activity modal
    And User clicks on "Assessment Activity" activity
    And User approves all activities
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Assessment Activity" activity
    Then Activity Information "Status" is displayed with "Done"
    When User clicks Edit button for Activity
    Then Activity Information Status field should be enabled
    And Activity Status drop-down contains the next options
      | In Progress |

  @C35971761
  @core_regression
  Scenario: C35971761: [Workflow completion] Edit Activity that is DONE/COMPLETED
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineOrganizationWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "Auto Test Custom Activity name" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Auto Test Custom Activity name" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    Then Activity Information page is displayed
    And Activity Information button 'Save' is displayed
    And Activity Information button 'Cancel' is displayed
    And Activity Information Status field should be enabled
    When User selects activity assignee "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN"
    And User clicks Back button to return from Activity modal
    Then Activities table displays Activity "Auto Test Custom Activity name" with Assignee "Admin_AT_FN Admin_AT_LN"
    When User clicks on "Auto Test Custom Activity name" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User selects activity assignee "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN"
    And User clicks 'Save' activity button
    Then Activities table displays Activity "Auto Test Custom Activity name" with Assignee "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN"

  @C35983599
  Scenario: C35983599: [Workflow completion] Adding comments to the Activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineIndividualWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    When User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds comment "Activity comment text N1"
    And User on Activity information page adds comment "Activity comment text N2"
    And User on Activity information page deletes comment "Activity comment text N2"
    And User clicks "Delete" Alert dialog button
    And User waits for progress bar to disappear from page
    Then Comment "Activity comment text N2" on Activity information page should not be shown
    And User on Activity information page adds comment "Activity comment text N3"
    And User on Activity information page Edit comment "Activity comment text N3" with text "Activity comment text N4"
    And User clicks Activity Information comment button "Save"
    Then Edited comment on Activity Information page is displayed
    When User on Activity information page deletes comment "Activity comment text N4"
    And User clicks "Delete" Alert dialog button
    And User waits for progress bar to disappear from page
    Then Comment "Activity comment text N4 " on Activity information page should not be shown

  @C35972887
  Scenario: C35972887: [Workflow completion] Adding attachment to the Activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineIndividualWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    When User clicks on "OrderDueDiligenceReport" activity
    Then Activity information Attachment block elements are displayed
    When User uploads file on Activity page
      | file_example_WAV_1MG.wav |
    Then Message "The file type is not supported." appears under uploads file input
    When User adds Activity attachment
      | logo.jpg | Activity description |
    Then Activity information page Attachment table row appears
      | File Name | Description          | Upload Date |
      | logo.jpg  | Activity description | TODAY       |
    When User adds Activity attachment
      | logo.jpg    | Activity description 1 |
      | racoon1.jpg | Activity description 2 |
    And Users clicks "File Name" column header on Activity attachment table
    Then Activity Information page Attachment table sorted by "File Name" in "DESC" order
    When Users clicks "File Name" column header on Activity attachment table
    Then Activity Information page Attachment table sorted by "File Name" in "ASC" order
    When Users clicks "Description" column header on Activity attachment table
    Then Activity Information page Attachment table sorted by "Description" in "DESC" order
    When Users clicks "Description" column header on Activity attachment table
    Then Activity Information page Attachment table sorted by "Description" in "ASC" order
    When Users clicks "Upload Date" column header on Activity attachment table
    Then Activity Information page Attachment table sorted by "Upload Date" in "DESC" order
    When Users clicks "Upload Date" column header on Activity attachment table
    Then Activity Information page Attachment table sorted by "Upload Date" in "ASC" order
    When User clicks delete icon for attachment "racoon1.jpg"
    And User clicks Delete button on confirmation window
    Then Attachment "racoon1.jpg" should be deleted

  @C35983714 @C41174262
  @core_regression
  @email
  Scenario: C35983714, C41174262: [Workflow completion] Activity Assigned Email
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire with Approver user"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And Email notification "Activity Assigned" with following values is received by "Approver" user
      | <Activity_Name> | Auto Activity |
    When User updates created Workflow activity with "Assign Questionnaire With Group Assignee" via API
    And User clicks "Stop Onboarding" third-party button
    And User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    When User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And Email notification "Activity Assigned" with following values is received by "Assignee" user
      | <Activity_Name> | Auto Activity |
    When User updates created Workflow activity with "Assign Questionnaire with Admin user role" via API
    And User clicks "Stop Onboarding" third-party button
    And User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    When User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And Email notification "Activity Assigned" with following values is received by "Admin" user
      | <Activity_Name> | Auto Activity |

  @C36021819
  @core_regression
  Scenario: C36021819: [Workflow completion] Activity Completed Email Notification and Screen notification for Responsible party
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User navigates to Home page
    And User clicks Notification Bell
    Then "Activity has been Completed" notification displayed with text
      | Assign Questionnaire1 |
    When User clicks "Activity has been Completed" "Assign Questionnaire1" notification
    Then Activity Information modal is displayed with details
      | Activity Type        | Activity Name         | Due Date | Assignee                |
      | Assign Questionnaire | Assign Questionnaire1 | TODAY+2  | Admin_AT_FN Admin_AT_LN |
    When User clicks Back button to return from Activity modal
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Assign Questionnaire" activity
    And User approves all activities
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User navigates to Home page
    And User clicks Notification Bell
    Then "Activity has been Completed" notification displayed with text
      | Assign Questionnaire |
    When User clicks "Activity has been Completed" "Assign Questionnaire" notification
    Then User is redirected to page 404
    And User opens previously created Third-party
    And User clicks Offboard button
    Then Message is displayed on confirmation window
      | Are you sure you want to Offboard this Third-party? |
      | This change cannot be undone.                       |
    When User clicks Offboard button on confirmation window
    Then Confirmation window should be Disappeared
    And Third-party's status should be shown - "OFFBOARDED"
    When User navigates to Home page
    And User clicks Notification Bell
    Then "Activity has been Completed" notification displayed with text
      | Assign Questionnaire |
    When User clicks "Activity has been Completed" "Assign Questionnaire" notification
    Then User is redirected to page 404
    When User clicks 'Back to home' button
    Then Home page is loaded
    When User logs into RDDC as "Assignee"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks Start Onboarding for third-party
    And User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    When User logs into RDDC as "Admin"
    And User clicks Notification Bell
    Then "Activity has been Completed" notification displayed with text
      | Assign Questionnaire |
    When User clicks "Activity has been Completed" "Assign Questionnaire" notification
    Then User is redirected to page 404

  @C36101746
  @core_regression
  Scenario: C36101746: [Workflow completion] Change color of Swimlane based on the status of its activities (with using of groups and branching)
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
    And User adds new Activity "Assessment Activity With Assignee User"
    And User adds new Activity "World Check Screening Activity"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_2"
    And User clicks Check button
    And User adds new Activity "Assign Questionnaire"
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User adds new Activity "World Check Screening Activity"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_3"
    And User clicks Check button
    And User adds new Activity "Request for Due Diligence Activity"
    And User adds new Activity "Approve Onboarding Activity"
    And User adds new Activity "Decline Onboarding Activity"
    And User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 1
    And User ticks checkbox for activity on position 2
    And User ticks checkbox for activity on position 3
    And User ticks checkbox for activity on position 4
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 6
    And User ticks checkbox for activity on position 7
    And User ticks checkbox for activity on position 8
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks workflow button "BRANCHING"
    And User clicks on "Assessment Activity" branching modal activity
    And User selects "Request for Due Diligence" for "Deeper Dive" drop-down
    And User selects "Approve Onboarding" for "Resolved" drop-down
    And User selects "Decline Onboarding" for "Issue Identified" drop-down
    And User clicks workflow button "Apply"
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And Component's "Auto_Component_1" header swimlane text color is "dark blue"
    And Activity details table is loaded
    When User clicks "Auto_Component_1" component tab
    And User waits for progress bar to disappear from page
    Then All component's activities are "white" color
    And Activity details table is loaded
    And Component's "Auto_Component_2" header swimlane text color is "dark blue"
    When User clicks "Auto_Component_2" component tab
    Then All component's activities are "white" color
    And Activity details table is loaded
    When User clicks "Auto_Component_3" component tab
    Then Component's "Auto_Component_3" tooltip is shown: "All activities in this component are still inactive"
    And All component's activities have transparency coefficient "0.5"
    When User clicks "Auto_Component_1" component tab
    And User clicks on "Assessment" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "Resolved"
    And User clicks 'Save' activity button
    Then Component's "Auto_Component_2" header swimlane text color is "dark blue"
    When User clicks "Auto_Component_3" component tab
    Then All component's activities have transparency coefficient "0.5"
    And Activities table should contain the following activity
      | Name               | Type               | Assigned To                   | Status      |
      | Approve Onboarding | Approve Onboarding | Assignee_AT_FN Assignee_AT_LN | Not Started |
    And Activities table doesn't contain the following activity
      | Name                      | Type                               | Assigned To                   | Status      |
      | Request for Due Diligence | Request for Due Diligence Activity | Assignee_AT_FN Assignee_AT_LN | Not Started |
      | Decline Onboarding        | Decline Onboarding                 | Assignee_AT_FN Assignee_AT_LN | Not Started |
    When User clicks "Auto_Component_1" component tab
    And User clicks on "World Check Ongoing Screening Update" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Activity details table is loaded
    When User clicks on "World Check Screening" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Component's "Auto_Component_1" header swimlane text color is "light green"
    When User clicks "Auto_Component_2" component tab
    Then Activity details table is loaded
    And Component's "Auto_Component_1" header swimlane text color is "light green"
    When User clicks on "Auto Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Activity details table is loaded
    When User clicks on "World Check Ongoing Screening Update" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Activity details table is loaded
    When User clicks on "World Check Screening" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Activity details table is loaded
    And User clicks "Auto_Component_3" component tab
    And User waits for progress bar to disappear from page
    Then All component's activities are "white" color
    And All component's activities have transparency coefficient "1"

  @C36138243
  @core_regression
  Scenario: C36138243: [Workflow completion] Check logic of grouping and branching of activities
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
    And User adds new Activity "Assessment Activity With Assignee User"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_2"
    And User clicks Check button
    And User adds new Activity "Request for Due Diligence Activity"
    And User adds new Activity "Approve Onboarding Activity"
    And User adds new Activity "Decline Onboarding Activity"
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
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks workflow button "BRANCHING"
    And User clicks on "Assessment Activity" branching modal activity
    And User selects "Request for Due Diligence" for "Deeper Dive" drop-down
    And User selects "Approve Onboarding" for "Resolved" drop-down
    And User selects "Decline Onboarding" for "Issue Identified" drop-down
    And User clicks workflow button "Apply"
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Auto_Component_1" component tab
    And User clicks on "Assessment" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "Deeper Dive"
    And User clicks 'Save' activity button
    Then Activity details table is loaded
    When User clicks "Auto_Component_2" component tab
    Then All component's activities have transparency coefficient "0.5"
    And Activities table should contain the following activity
      | Name                      | Type                               | Assigned To                   | Status      |
      | Request for Due Diligence | Request for Due Diligence Activity | Assignee_AT_FN Assignee_AT_LN | Not Started |
    And Activities table doesn't contain the following activity
      | Name               | Type               | Assigned To                   | Status      |
      | Approve Onboarding | Approve Onboarding | Assignee_AT_FN Assignee_AT_LN | Not Started |
      | Decline Onboarding | Decline Onboarding | Assignee_AT_FN Assignee_AT_LN | Not Started |
    When User clicks "Auto_Component_1" component tab
    And User clicks on "World Check Ongoing Screening Update" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Activity details table is loaded
    When User clicks "Auto_Component_2" component tab
    Then All component's activities are "white" color
    When User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"

  @C36155877
  @core_regression
  Scenario: C36155877: [Workflow completion] Grouping of activities: activity Groups Should be Completed in Sequence
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
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_2"
    And User clicks Check button
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User adds new Activity "World Check Screening Activity"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_3"
    And User clicks Check button
    And User adds new Activity "Approve Onboarding Activity"
    And User adds new Activity "Decline Onboarding Activity"
    And User adds new Activity "Request for Due Diligence Activity"
    And User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 2
    And User ticks checkbox for activity on position 3
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 4
    And User ticks checkbox for activity on position 5
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group Ukraine"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Auto_Component_1" component tab
    And User clicks on "Assessment" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "Resolved"
    And User clicks 'Save' activity button
    And User clicks on "World Check Ongoing Screening Update" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Activity details table is loaded
    When User clicks "Auto_Component_3" component tab
    And User clicks on "Request for Due Diligence" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then "Request for Due Diligence" component's activity is "white" color
    And "Approve Onboarding" component's activity has opacity "0.5"
    And "Decline Onboarding" component's activity has opacity "0.5"
    When User clicks "Auto_Component_2" component tab
    And User clicks on "World Check Ongoing Screening Update" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks on "World Check Screening" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Activity details table is loaded
    When User clicks "Auto_Component_3" component tab
    Then All component's activities are "white" color
    When User clicks on "Approve Onboarding" activity
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on "Decline Onboarding" activity
    Then Activity Information page is displayed
