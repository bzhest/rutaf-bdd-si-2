@ui @full_regression @supplier_onboarding
Feature: Supplier Onboarding

  As a Supplier Integrity User
  I want to verify Onboarding process is going right
  So that user would be sure in correctness on onboarding process


  @C35899546
  @core_regression
  Scenario: C35899546: [Supplier Onboarding] Start onboarding, Supplier has status NEW, workflow can be applied.
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineIndividual"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User clicks on created third-party
    Then Third-party's element "Start Onboarding" should be shown
    When User clicks Start Onboarding for third-party
    Then Third-party's element "Decline Onboarding" should be shown
    And Third-party's element "Stop Onboarding" should be shown
    And Onboarding Start Date should be TODAY+0
    And Third-party's onboarding workflow should be shown - "Automation Workflow Individual"
    And Third-party's onboarding workflow description should be shown - "Please DO NOT touch is being used for Automation purposes"
    And Third-party's status should be shown - "ONBOARDING"
    When User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "ONBOARDING"

  @C35908771
  Scenario: C35908771: [Supplier Onboarding] OFFBOARD flow and Start onboarding, Supplier has status Offboarded
    Given User logs into RDDC as "Admin"
    When User creates third-party "with renewal workflow Norway"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User clicks on created third-party
    And User clicks Start Onboarding for third-party
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    When User clicks Offboard button
    Then Message is displayed on confirmation window
      | Are you sure you want to Offboard this Third-party? |
      | This change cannot be undone.                       |
    And Confirmation button Cancel should be displayed
    And Confirmation button Offboard should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window should be Disappeared
    And Third-party's status should be shown - "ONBOARDED"
    When User clicks Offboard button
    And User clicks Offboard button on confirmation window
    Then Confirmation window should be Disappeared
    And Third-party's status should be shown - "OFFBOARDED"
    And Assessment section field "Offboarded Decision Date" is displayed
    And Assessment section field "Onboarded Decision Date" is not displayed
    And Offboarded Decision Date should be TODAY+0
    And Third-party's element "Offboard" should not be shown
    And Third-party's element "Start Onboarding" should be shown
    When User clicks Start Onboarding for third-party
    Then Third-party's element "Start Onboarding" should not be shown
    And Third-party's element "Decline Onboarding" should be shown
    And Third-party's element "Stop Onboarding" should be shown
    And Onboarding Start Date should be TODAY+0
    And Third-party's onboarding workflow should be shown - "Auto Workflow Renewal Workflow Low Risk Onboarding"
    And Third-party's onboarding workflow description should be shown - "Onboarding Workflow for automation test with For Renewal status"
    And Third-party's status should be shown - "ONBOARDING"
    When User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "ONBOARDING"

  @C35908782
  Scenario: C35908782: [Supplier Onboarding] Start onboarding, Supplier has status Onboarding Denied, workflow can be applied.
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Decline Onboarding" third-party button
    Then Message is displayed on confirmation window
      | Are you sure you want to decline the Onboarding Process? This cannot be undone and you will have to restart the Onboarding Process again. |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "ONBOARDING DENIED"
    And Onboarding Denied Date should be TODAY+0
    And Onboarded Decision Date field should be hidden
    And Third-party's element "Decline Onboarding" should not be shown
    And Third-party's element "Stop Onboarding" should not be shown
    And Third-party's element "Start Onboarding" should be shown
    And Onboarding Activities section is not displayed
    When User waits and clicks "Start Onboarding" third-party button
    Then Third-party's element "Start Onboarding" should not be shown
    And Third-party's element "Decline Onboarding" should be shown
    And Third-party's element "Stop Onboarding" should be shown
    And Onboarding Start Date should be TODAY+0
    And Third-party's status should be shown - "ONBOARDING"

  @C35916051
  Scenario: C35916051: [Supplier Onboarding] Check that starting, stopping, declining of Supplier onboarding is allowed for user under the certain conditions
    Given User logs into RDDC as "Admin"
    When User creates third-party "with Operations division"
    And User logs into RDDC as "Assignee"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User clicks on created third-party
    Then Third-party's element "Start Onboarding" should be shown
    When User clicks Start Onboarding for third-party
    Then Third-party's element "Decline Onboarding" should be shown
    And Third-party's element "Stop Onboarding" should be shown
    And Third-party's status should be shown - "ONBOARDING"
    When User clicks "Stop Onboarding" third-party button
    And User clicks Yes button on confirmation window
    Then Third-party's status should be shown - "NEW"
    When User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    Then Third-party's status should be shown - "ONBOARDING DENIED"
    When User logs into RDDC as "Admin"
    When User creates third-party "with MyDivision division and Admin double responsible party"
    And User logs into RDDC as "admin double"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User clicks on created third-party
    And User clicks Start Onboarding for third-party
    Then Third-party's element "Decline Onboarding" should be shown
    And Third-party's element "Stop Onboarding" should be shown
    And Third-party's status should be shown - "ONBOARDING"
    When User clicks "Stop Onboarding" third-party button
    And User clicks Yes button on confirmation window
    Then Third-party's status should be shown - "NEW"
    When User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    Then Third-party's status should be shown - "ONBOARDING DENIED"

  @C37889967
  Scenario: C37889967: [React migration] Visual representation of a completed workflow
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
    And User adds new Activity "Assign Questionnaire"
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_3"
    And User clicks Check button
    And User adds new Activity "Request for Due Diligence Activity"
    And User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User ticks checkbox for activity on position 1
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 2
    And User ticks checkbox for activity on position 3
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks workflow button "BRANCHING"
    And User clicks on "Assessment Activity" branching modal activity
    And User selects "Auto Activity" for "Deeper Dive" drop-down
    And User selects "World Check Ongoing Screening Update" for "Resolved" drop-down
    And User clicks workflow button "Apply"
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |
    When User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And Component's "Auto_Component_1" header swimlane text color is "dark blue"
    And Activity details table is loaded
    When User clicks "Auto_Component_1" component tab
    And User waits for progress bar to disappear from page
    Then All component's activities are "white" color
    When User clicks "Auto_Component_2" component tab
    Then All component's activities have transparency coefficient "0.5"
    And Component's "Auto_Component_2" tooltip is shown: "All activities in this component are still inactive"
    When User clicks "Auto_Component_1" component tab
    And User clicks on "Assessment" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "Resolved"
    And User clicks 'Save' activity button
    And User clicks on "World Check Ongoing Screening Update" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Activity details table is loaded
    And Component's "Auto_Component_1" header swimlane text color is "light green"
    When User clicks "Stop Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "Assessment" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "Issue Identified"
    And User clicks 'Save' activity button
    And User clicks on "World Check Ongoing Screening Update" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Activity details table is loaded
    And Component's "Auto_Component_2" header swimlane text color is "black"

  @C37890045
  Scenario: C37890045: [React migration] Third-party Onboarding: Verify that correct Workflow is triggering for Third Party
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Workflow Questionnaire Inactive Duplicate" with Activity "Assign Questionnaire"
    And User creates new Workflow "Automation Workflow Questionnaire Active Duplicate" with Activity "Assign Questionnaire"
    And User creates new Workflow "Automation Workflow Questionnaire Active Duplicate Medium" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's onboarding workflow description should be shown - "Automation Workflow Questionnaire Active Duplicate"
    When User clicks "Stop Onboarding" third-party button
    And User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    When User clicks General and Other Information section "Edit" button
    And User updates Address section with values
      | Country |
      | Ukraine |
    And User clicks General and Other Information section "Save" button
    And User clicks Start Onboarding for third-party
    Then Third-party's onboarding workflow description should be shown - "Automation Workflow Questionnaire Active Duplicate Medium"
    When User clicks "Stop Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User inactivates last created workflow
    And User clicks "Start Onboarding" third-party button
    Then Alert Icon is displayed with text
      | There is no workflow available. Please contact your administrator. |
    And Third-party's element "Start Onboarding" should be shown
    When User clicks General and Other Information section "Edit" button
    And User updates General Information section with values
      | Workflow Group      |
      | Auto Workflow Group |
    And User clicks General and Other Information section "Save" button
    And User clicks Start Onboarding for third-party
    Then Third-party's onboarding workflow should be shown - "Automation Workflow"
    And Third-party's onboarding workflow description should be shown - "Test Automation activity"

  @C37912238
  Scenario: C37912238: [React Migration] The calculation of Due Date
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
    And User adds new Activity "Assign Questionnaire"
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User ticks checkbox for activity on position 1
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 2
    And User ticks checkbox for activity on position 3
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks workflow button "BRANCHING"
    And User clicks on "Assessment Activity" branching modal activity
    And User selects "Auto Activity" for "Deeper Dive" drop-down
    And User selects "World Check Ongoing Screening Update" for "Resolved" drop-down
    And User clicks workflow button "Apply"
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |
    When User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    Then Activities table should contain the following activity
      | Name                                 | Type                                 | Assigned To                   | Due Date | Status      |
      | World Check Ongoing Screening Update | World Check Ongoing Screening Update | Assignee_AT_FN Assignee_AT_LN | TODAY+1  | Not Started |
      | Assessment Activity                  | Assessment                           | Assignee_AT_FN Assignee_AT_LN | TODAY+1  | Not Started |
    When User clicks "Auto_Component_2" component tab
    Then Activities table should contain the following activity
      | Name                                 | Type                                 | Assigned To                   | Due Date | Status      |
      | Auto Activity                        | Assign Questionnaire                 | Admin_AT_FN Admin_AT_LN       |          | Not Started |
      | World Check Ongoing Screening Update | World Check Ongoing Screening Update | Assignee_AT_FN Assignee_AT_LN |          | Not Started |

  @C37912339
  Scenario: C37912339: [React Migration] Start Onboarding: Trigger Activities in Group 1 and Zero
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
    And User adds new Activity "Assign Questionnaire"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_2"
    And User clicks Check button
    And User adds new Activity "Assessment Activity With Assignee User"
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_3"
    And User clicks Check button
    And User adds new Activity "Request for Due Diligence Activity"
    And User adds new Activity "Approve Onboarding Activity"
    And User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
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
    And User clicks workflow button "BRANCHING"
    And User clicks on "Assessment Activity" branching modal activity
    And User selects "Request for Due Diligence" for "Deeper Dive" drop-down
    And User selects "Approve Onboarding" for "Resolved" drop-down
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
    Then All component's activities have transparency coefficient "0.5"
    When User clicks "Auto_Component_2" component tab
    And User clicks on "Assessment" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "Resolved"
    And User clicks 'Save' activity button
    And User clicks "Auto_Component_3" component tab
    Then All component's activities are "white" color
    And Activities table should contain the following activity
      | Name               | Type               | Assigned To                   | Status      |
      | Approve Onboarding | Approve Onboarding | Assignee_AT_FN Assignee_AT_LN | Not Started |
    And Activities table doesn't contain the following activity
      | Name                      | Type                               | Assigned To                   | Status      |
      | Request for Due Diligence | Request for Due Diligence Activity | Assignee_AT_FN Assignee_AT_LN | Not Started |

  @C41171419
  Scenario: C41171419: [React migration] Displaying Activities in Onboarding/Renewal Activities section in read only mode
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User sets up role "AUTO_READ_ONLY_ACTIVITY" for user with firstname "User_Change_Role_AT_FN" via API
    And User navigates to Home page
    And User clicks Log Out button
    Then Login page is loaded
    When User logs into RDDC as "Changing role user"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    Then Edit button for "OrderDueDiligenceReport" activity row is not displayed
    When User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information Edit button is hidden

  @C37886408
  Scenario: C37886408: [React migration] Third-party Onboarding: Start onboarding, Third Party has NEW, ONBOARDING DENIED, OFFBOARDED, RENEWAL DENIED statuses, workflow can be applied
    Given User logs into RDDC as "Admin"
    When User creates third-party "with renewal workflow Norway" via API and open it
    And User navigates to Third-party page
    Then Third-party should have status "NEW"
    When User clicks on created third-party
    And User clicks Start Onboarding for third-party
    Then Third-party's element "Decline Onboarding" should be shown
    And Third-party's element "Stop Onboarding" should be shown
    And Third-party's element "Start Onboarding" should not be shown
    And Third-party's status should be shown - "ONBOARDING"
    When User navigates to Third-party page
    Then Third-party should have status "ONBOARDING"
    When User clicks on created third-party
    And User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "ONBOARDING DENIED"
    And Third-party's element "Decline Onboarding" should not be shown
    And Third-party's element "Stop Onboarding" should not be shown
    And Third-party's element "Start Onboarding" should be shown
    When User navigates to Third-party page
    Then Third-party should have status "ONBOARDING DENIED"
    When User clicks on created third-party
    And User clicks Start Onboarding for third-party
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks Offboard button
    And User clicks Offboard button on confirmation window
    Then Confirmation window should be Disappeared
    And Third-party's status should be shown - "OFFBOARDED"
    When User navigates to Third-party page
    Then Third-party should have status "OFFBOARDED"
    When User clicks on created third-party
    And User clicks Start Onboarding for third-party
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    Then Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    When User navigates to Third-party page
    And User clicks on created third-party
    And User clicks "Renew" for third-party
    And User clicks "Decline Renewal" for third-party
    And User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "RENEWAL DENIED"
    When User navigates to Third-party page
    Then Third-party should have status "RENEWAL DENIED"
