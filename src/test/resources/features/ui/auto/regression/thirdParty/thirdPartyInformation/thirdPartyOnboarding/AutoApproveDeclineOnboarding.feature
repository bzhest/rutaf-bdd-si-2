@ui @full_regression @workflow_completion
Feature: Auto Approve and Decline Onboarding Activity

  As a Supplier Integrity User Onboarding a Supplier
  I want auto-onboard/auto-decline supplier when default Approve Onboarding activity is compeleted
  So that it will satisfy the workflow process when client decide to approve/decline the supplier

  Background:
    Given User logs into RDDC as "Assignee"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button

  @C37926043
  Scenario: C37926043: Verify Auto Approve Onboarding
    When User adds new Activity "AUTO_TEST_WC_ONBOARDING_WAITING" with "World Check Screening Activity" data
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_2"
    And User clicks Check button
    And User adds new Activity "Approve Onboarding Activity"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_3"
    And User clicks Check button
    And User adds new Activity "Request for Due Diligence Activity"
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User adds new Activity "World Check Screening Activity"
    And User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 1
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 2
    And User selects "Group 3" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 3
    And User selects "Group 4" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group and assignee user responsible party" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "World Check Screening" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Activities table should contain the following activity
      | Name                            | Type                  | Assigned To                   | Status    | Due Date |
      | AUTO_TEST_WC_ONBOARDING_WAITING | World Check Screening | Assignee_AT_FN Assignee_AT_LN | Completed | TODAY+1  |
    And Third-party's status should be shown - "ONBOARDING"
    And Component's "Auto_Component_1" header swimlane text color is "light green"
    And Activity details table is loaded
    When User clicks "Auto_Component_2" component tab
    And User clicks on "Approve Onboarding" activity
    And User waits for progress bar to disappear from page
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    And Onboarding Start Date should be TODAY+0
    And Onboarded Decision Date should be TODAY+0

  @C37927060
  Scenario: C37927060: Verify Auto Decline Onboarding
    When User adds new Activity "AUTO_TEST_WC_ONBOARDING_WAITING" with "World Check Screening Activity" data
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_2"
    And User clicks Check button
    And User adds new Activity "Decline Onboarding Activity"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_3"
    And User clicks Check button
    And User adds new Activity "Request for Due Diligence Activity"
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User adds new Activity "World Check Screening Activity"
    And User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 1
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 2
    And User selects "Group 3" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 3
    And User selects "Group 4" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group and assignee user responsible party" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "World Check Screening" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Activities table should contain the following activity
      | Name                            | Type                  | Assigned To                   | Status    | Due Date |
      | AUTO_TEST_WC_ONBOARDING_WAITING | World Check Screening | Assignee_AT_FN Assignee_AT_LN | Completed | TODAY+1  |
    And Third-party's status should be shown - "ONBOARDING"
    And Component's "Auto_Component_1" header swimlane text color is "light green"
    And Activity details table is loaded
    When User clicks "Auto_Component_2" component tab
    And User clicks on "Decline Onboarding" activity
    And User waits for progress bar to disappear from page
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDING DENIED"
    And Third-party's element "Start Onboarding" should be shown
    And Onboarding Start Date should be TODAY+0
    And Onboarding Denied Date should be TODAY+0

  @C36021903
  Scenario: C36021903: [Workflow completion] Supplier Onboarding - Auto-Onboard supplier upon completion of Approve Onboarding Activity
    When User adds new Activity "Approve Onboarding Activity"
    And User adds new Activity "Order Due Diligence Report Activity"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Auto_Component_1" component tab
    And User clicks on "Approve Onboarding" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    And Third-party's element "Decline Onboarding" should not be shown
    And Third-party's element "Stop Onboarding" should not be shown
    And Third-party's element "Offboard" should be shown
    And Onboarded Decision Date should be TODAY+0

  @C36023576
  Scenario: C36023576: [Workflow completion] Supplier Onboarding - Auto-Decline supplier upon completion of Decline Onboarding Activity
    When User adds new Activity "Decline Onboarding Activity"
    And User adds new Activity "Order Due Diligence Report Activity"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Auto_Component_1" component tab
    And User clicks on "Decline Onboarding" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User waits for progress bar to disappear from page
    Then Third-party's status should be shown - "ONBOARDING DENIED"
    And Third-party's element "Decline Onboarding" should not be shown
    And Third-party's element "Stop Onboarding" should not be shown
    And Third-party's element "Start Onboarding" should be shown
    And Onboarding Denied Date should be TODAY+0

  @C38016216
  Scenario: C38016216: Verify Workflow autocompleting when all succeeding activities are Not Relevant when an Activity is Completed in Middle or Last Group
    When User adds new Activity "AUTO_TEST_WC_ONBOARDING_WAITING" with "World Check Screening Activity" data
    And User adds new Activity "AUTO_TEST_WC_ONBOARDING_WAITING_2" with "World Check Ongoing Screening Update Activity" data
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_2"
    And User clicks Check button
    And User adds new Activity "AUTO_TEST_WC_ONBOARDING_WAITING_3" with "World Check Screening Activity" data
    And User adds new Activity "Approve Onboarding Activity"
    And User adds new Activity "Request for Due Diligence Activity"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_3"
    And User clicks Check button
    And User adds new Activity "Request for Due Diligence Activity"
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
    And User ticks checkbox for activity on position 4
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 5
    And User selects "Group 3" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 6
    And User selects "Group 4" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group and description" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "World Check Screening" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "World Check Ongoing Screening Update" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Activities table should contain the following activity
      | Name                              | Type                                 | Assigned To                   | Status    | Due Date |
      | AUTO_TEST_WC_ONBOARDING_WAITING   | World Check Screening                | Assignee_AT_FN Assignee_AT_LN | Completed | TODAY+1  |
      | AUTO_TEST_WC_ONBOARDING_WAITING_2 | World Check Ongoing Screening Update | Assignee_AT_FN Assignee_AT_LN | Completed | TODAY+1  |
    When User clicks "Auto_Component_2" component tab
    And User clicks on "AUTO_TEST_WC_ONBOARDING_WAITING_3" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks "Auto_Component_2" component tab
    And User clicks on "Approve Onboarding" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    And Third-party's element "Offboard" should be shown
    And Onboarding Start Date should be TODAY+0
    And Onboarded Decision Date should be TODAY+0
    When User navigates to Reports page
    And User selects report category "My Third-party"
    And User inputs in Search Filter From "TODAY-1"
    And User inputs text in Search Filter To "TODAY+1"
    And User clicks on newly created Third-party on Report page
    Then Search result view "Third-party Status" is "ONBOARDED"
    And Search result view "Country" is "Norway"
    And Search result view "Total No. of Activity" is "7"
    And Search result view "Total No. of Completed Activity" with "green_report" icon is "4"
    And Search result view "Total No. of Not Relevant Activity" with "grey_report" icon is "3"
