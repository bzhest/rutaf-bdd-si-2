@ui @core_regression @activity_details
Feature: Third-party Information - Workflow Activity - Activity Information Page - Edit Activity Information

  As a user
  I want ability to reassign assignee of an activity based on the setup
  So that I can reassign activity to the responsible person


  @C43358453
  Scenario: C43358453: Activity Information Page - Activity Assignee - Logged in User not the activity assignee nor has the System Admin role
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
    And Activity information page comment section text area is not displayed

  @C43358451
  Scenario: C43358451: Activity Information Page - Activity Assignee - Logged in User is the activity assignee and has the System Admin role
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And User selects activity assignee "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Save' activity button
    And User logs into RDDC as "Assignee"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description              | Order Details                  | Due Date | Priority | Assessment | Assignee                      | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | Test Automation activity | ORDER DETAILS: NO ORDER PLACED | TODAY+1  |          |            | Assignee_AT_FN Assignee_AT_LN | Not Started |
    When User clicks Edit button for Activity
    And User selects activity assignee "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN"
    And User clicks 'Save' activity button
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description              | Order Details                  | Due Date | Priority | Assessment | Assignee                                      | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | Test Automation activity | ORDER DETAILS: NO ORDER PLACED | TODAY+1  |          |            | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN | Not Started |
    And Email notification "Activity Assigned" with following values is received by "Approver" user
      | <Activity_Name> | OrderDueDiligenceReport |

  @C43358452
  Scenario: C43358452: Activity Information Page - Activity Assignee - Logged in User not the activity assignee but has the System Admin role
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And User selects activity assignee "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Save' activity button
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description              | Order Details                  | Due Date | Priority | Assessment | Assignee                      | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | Test Automation activity | ORDER DETAILS: NO ORDER PLACED | TODAY+1  |          |            | Assignee_AT_FN Assignee_AT_LN | Not Started |
    When User clicks Edit button for Activity
    And User selects activity assignee "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN"
    And User clicks 'Save' activity button
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description              | Order Details                  | Due Date | Priority | Assessment | Assignee                                      | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | Test Automation activity | ORDER DETAILS: NO ORDER PLACED | TODAY+1  |          |            | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN | Not Started |
    And Email notification "Activity Assigned" with following values is received by "Approver" user
      | <Activity_Name> | OrderDueDiligenceReport |
    And User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
      | FIELD ORIGINAL VALUE NEW VALUE                                                       |
      | Assignee Assignee_AT_FN Assignee_AT_LN Questionnaire_Approver_AT_FN Quest_Appr_AT_LN |

  @C43358454
  Scenario: C43358454: Activity Information Page - Activity Assignee - User Group - Logged in User is a member of the User Group and has System Admin role
    Given User logs into RDDC as "Approver"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "With Multi Users Group Assignee" details
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "With Multi Users Group Assignee" activity
    Then Activity Information modal is displayed with details
      | Activity Type         | Activity Name                   | Description                     | Due Date | Assignee               | Status      |
      | World Check Screening | With Multi Users Group Assignee | With Group Assignee description | TODAY+1  | Group With Multi Users | Not Started |
    When User clicks Edit button for Activity
    Then Assignee drop-down contains all the Active Members of "Group With Multi Users" group
    When User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Save' activity button
    And User clicks on "With Multi Users Group Assignee" activity
    Then Activity Information modal is displayed with details
      | Activity Type         | Activity Name                   | Description                     | Due Date | Assignee                      | Status      |
      | World Check Screening | With Multi Users Group Assignee | With Group Assignee description | TODAY+1  | Assignee_AT_FN Assignee_AT_LN | Not Started |
    And Email notification "Activity Assigned" with following values is received by "Assignee" user
      | <Activity_Name> | With Multi Users Group Assignee |

  @C43358455
  @onlySingleThread
  Scenario: C43358455: Activity Information Page - Activity Assignee - User Group - Logged in User is NOT a member of the User Group but has System Admin role
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "With Multi Users Group Assignee" details
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "With Multi Users Group Assignee" activity
    Then Activity Information modal is displayed with details
      | Activity Type         | Activity Name                   | Description                     | Due Date | Assignee               | Status      |
      | World Check Screening | With Multi Users Group Assignee | With Group Assignee description | TODAY+1  | Group With Multi Users | Not Started |
    When User clicks Edit button for Activity
    Then Assignee drop-down contains all the Active Members of "Group With Multi Users" group
    When User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User updates test start date
    And User clicks 'Save' activity button
    And User clicks on "With Multi Users Group Assignee" activity
    Then Activity Information modal is displayed with details
      | Activity Type         | Activity Name                   | Description                     | Due Date | Assignee                      | Status      |
      | World Check Screening | With Multi Users Group Assignee | With Group Assignee description | TODAY+1  | Assignee_AT_FN Assignee_AT_LN | Not Started |
    And Email notification "Activity Assigned" with following values is received by "Assignee" user
      | <Activity_Name> | With Multi Users Group Assignee |
    And Email notification "Activity Assigned" with following values is not received by "Approver" user
      | <Activity_Name> | With Multi Users Group Assignee |
    And User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
      | FIELD ORIGINAL VALUE NEW VALUE                                |
      | Assignee Group With Multi Users Assignee_AT_FN Assignee_AT_LN |

  @C43358456
  Scenario: C43358456: Activity Information Page - Activity Assignee - User Group - Logged in User is NOT a member of the User Group nor has System Admin role
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "With Multi Users Group Assignee" details
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User sets up role "AUTO_READ_ONLY_ACTIVITY" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    Then Edit button for "With Multi Users Group Assignee" activity row is not displayed
    When User clicks on "With Multi Users Group Assignee" activity
    Then Activity Information Edit button is hidden
    And Activity information page comment section text area is not displayed

  @C43412759
  Scenario: C43412759: Activity Information Page - Activity Permission - System Admin Role - Edit other user activities with no assessment
    Given User logs into RDDC as "Assignee"
    When User creates "Activity Type" "without assessment" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User adds new Activity "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" data
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" with "Assign Questionnaire" data
    And User clicks Save button for Workflow
    Then Workflow Table is displayed
    When User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks on "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" activity
    And User clicks Edit button for Activity
    Then Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Waiting     |
      | Done        |
    And Activity Information Status field should be enabled
    And Activity Information Assignee can be edited
    When User selects activity status "Done"
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Status      | Assignee                      |
      | Not Started | Assignee_AT_FN Assignee_AT_LN |
    And Activity Information button 'Save' is not displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" activity
    Then Activity Information modal is displayed with details
      | Status    | Assignee                |
      | Completed | Admin_AT_FN Admin_AT_LN |
    And User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
      | FIELD ORIGINAL VALUE NEW VALUE                                 |
      | Assignee Assignee_AT_FN Assignee_AT_LN Admin_AT_FN Admin_AT_LN |
      | Status Not Started Done                                        |

  @C43412760
  Scenario: C43412760: Activity Information Page - Activity Permission - System Admin Role - Edit other user activities with assessment
    Given User logs into RDDC as "Assignee"
    When User creates "Activity Type" "with 1 assessment fields" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User adds new Activity "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE" with "Assessment One Field Custom Activity" data
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" with "Assign Questionnaire" data
    And User clicks Save button for Workflow
    Then Workflow Table is displayed
    When User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks on "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE" activity
    And User clicks Edit button for Activity
    Then Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Waiting     |
      | Done        |
    And Activity Information Assessment field should be enabled
    And Activity Information Status field should be enabled
    And Activity Information Assignee can be edited
    When User selects activity status "Done"
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Save' activity button
    Then Alert Icon is displayed with text
      | Cannot Save. Please fill up Assessment field before changing Activity status to completed. |
    And Activity Information "Assessment" field message "This field is required" is displayed
    When User selects activity Assessment "first"
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Assessment | Status      | Assignee                      |
      |            | Not Started | Assignee_AT_FN Assignee_AT_LN |
    And Activity Information button 'Save' is not displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User selects activity Assessment "first"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE" activity
    Then Activity Information modal is displayed with details
      | Assessment | Status    | Assignee                |
      | first      | Completed | Admin_AT_FN Admin_AT_LN |
    And User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
      | FIELD ORIGINAL VALUE NEW VALUE                                 |
      | Assignee Assignee_AT_FN Assignee_AT_LN Admin_AT_FN Admin_AT_LN |
      | Status Not Started Done                                        |
      | Assessment - first                                             |

  @C43412761
  Scenario: C43412761: Activity Information Page - Activity Permission - System Admin Role - Edit other user activities with approver and assessment
    Given User logs into RDDC as "Assignee"
    When User creates "Activity Type" "with 1 assessment fields" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "Assessment One Field Custom Activity" details
    And User selects Workflow Assignee(s) as "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Activity "Add Approver" tab
    And User selects "Assignee_AT_FN Assignee_AT_LN" value for Default Approver
    And User clicks workflow button "Done"
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" with "Assign Questionnaire" data
    And User clicks Save button for Workflow
    Then Workflow Table is displayed
    When User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks on "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE" activity
    And User clicks Edit button for Activity
    And Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Approve" button
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE" activity
    And User clicks Edit button for Activity
    Then Activity Information Assessment field should be enabled
    And Activity Information Status field should be enabled
    And Activity Information Assignee can be edited
    And Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Waiting     |
      | Done        |
    When User selects activity status "Done"
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Save' activity button
    Then Alert Icon is displayed with text
      | Cannot Save. Please fill up Assessment field before changing Activity status to completed. |
    And Activity Information "Assessment" field message "This field is required" is displayed
    When User selects activity Assessment "first"
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Assessment | Status      | Assignee                      |
      |            | Not Started | Assignee_AT_FN Assignee_AT_LN |
    And Activity Information button 'Save' is not displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User selects activity Assessment "first"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE" activity
    Then Activity Information modal is displayed with details
      | Assessment | Status    | Assignee                |
      | first      | Completed | Admin_AT_FN Admin_AT_LN |
    And User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
      | FIELD ORIGINAL VALUE NEW VALUE                                 |
      | Assignee Assignee_AT_FN Assignee_AT_LN Admin_AT_FN Admin_AT_LN |
      | Status Not Started Done                                        |
      | Assessment - first                                             |

  @C43412762
  Scenario: C43412762: Activity Information Page - Activity Permission - System Admin Role - Edit other user activities with approver
    Given User logs into RDDC as "Assignee"
    When User creates "Activity Type" "without assessment" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" details
    And User selects Workflow Assignee(s) as "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Activity "Add Approver" tab
    And User selects "Assignee_AT_FN Assignee_AT_LN" value for Default Approver
    And User clicks workflow button "Done"
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" with "Assign Questionnaire" data
    And User clicks Save button for Workflow
    Then Workflow Table is displayed
    When User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks on "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" activity
    And User clicks Edit button for Activity
    And Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Approve" button
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" activity
    And User clicks Edit button for Activity
    Then Activity Information Status field should be enabled
    And Activity Information Assignee can be edited
    And Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Waiting     |
      | Done        |
    When User selects activity status "Done"
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Status      | Assignee                      |
      | Not Started | Assignee_AT_FN Assignee_AT_LN |
    And Activity Information button 'Save' is not displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" activity
    Then Activity Information modal is displayed with details
      | Status    | Assignee                |
      | Completed | Admin_AT_FN Admin_AT_LN |
    And User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
      | FIELD ORIGINAL VALUE NEW VALUE                                 |
      | Assignee Assignee_AT_FN Assignee_AT_LN Admin_AT_FN Admin_AT_LN |
      | Status Not Started Done                                        |

  @C43412763
  Scenario: C43412763: Activity Information Page - Activity Permission - System Admin Role - Edit other user activities with reviewer
    Given User logs into RDDC as "Assignee"
    When User creates "Activity Type" "without assessment" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" details
    And User selects Workflow Assignee(s) as "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Activity "Add Approver" tab
    And User selects "Assignee_AT_FN Assignee_AT_LN" value for Default Approver
    And User clicks Activity "Add Reviewer" tab
    And User selects "Assignee_AT_FN Assignee_AT_LN" value for Default Reviewer
    And User clicks workflow button "Done"
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" with "Assign Questionnaire" data
    And User clicks Save button for Workflow
    Then Workflow Table is displayed
    When User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks on "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" activity
    And User clicks Edit button for Activity
    And Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Approve" button
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" activity
    And User clicks Edit button for Activity
    Then Activity Information Status field should be enabled
    And Activity Information Assignee can be edited
    And Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Waiting     |
      | Done        |
    When User selects activity status "Done"
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Status      | Assignee                      |
      | Not Started | Assignee_AT_FN Assignee_AT_LN |
    And Activity Information button 'Save' is not displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" activity
    Then Activity Information modal is displayed with details
      | Status | Assignee                |
      | Done   | Admin_AT_FN Admin_AT_LN |
    And User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
      | FIELD ORIGINAL VALUE NEW VALUE                                 |
      | Assignee Assignee_AT_FN Assignee_AT_LN Admin_AT_FN Admin_AT_LN |
      | Status Not Started Done                                        |
    When User clicks "Review" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Activity Information modal is displayed with details
      | Status    |
      | Completed |
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Reviewed |

  @C43426153
  Scenario: C43426153: Activity Information Page - Activity Permission - System Admin Role - Activity assigned to User Group
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "With Multi Users Group Assignee" details
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "With Multi Users Group Assignee" activity
    Then Activity Information modal is displayed with details
      | Activity Type         | Activity Name                   | Description                     | Due Date | Assignee               | Status      |
      | World Check Screening | With Multi Users Group Assignee | With Group Assignee description | TODAY+1  | Group With Multi Users | Not Started |
    When User clicks Edit button for Activity
    Then Assignee drop-down contains all the Active Members of "Group With Multi Users" group
    When User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Assignee               |
      | Group With Multi Users |
    And Activity Information button 'Save' is not displayed
    When User clicks Edit button for Activity
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Save' activity button
    And User clicks on "With Multi Users Group Assignee" activity
    Then Activity Information modal is displayed with details
      | Assignee                      |
      | Assignee_AT_FN Assignee_AT_LN |
    And User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
      | FIELD ORIGINAL VALUE NEW VALUE                                |
      | Assignee Group With Multi Users Assignee_AT_FN Assignee_AT_LN |

  @C43427376
  Scenario: C43427376: Activity Information Page - Activity Permission - System Admin Role - Edit other user activities with DONE or COMPLETED status
    Given User logs into RDDC as "Assignee"
    When User creates "Activity Type" "without assessment" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User adds new Activity "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" data
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" with "Assign Questionnaire" data
    And User clicks Save button for Workflow
    Then Workflow Table is displayed
    When User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks on "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" activity
    And User clicks Edit button for Activity
    And User selects activity status "In Progress"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Status    | Assignee                      |
      | Completed | Assignee_AT_FN Assignee_AT_LN |
    When User clicks Edit button for Activity
    And User selects activity status "In Progress"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Save' activity button
    Then Alert Dialog with text is displayed
      | Are you sure you want to change the status to In Progress? |
    When User clicks "Proceed" Alert dialog button
    And User clicks on "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" activity
    Then Activity Information modal is displayed with details
      | Status      | Assignee                |
      | In Progress | Admin_AT_FN Admin_AT_LN |
    And User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
      | FIELD ORIGINAL VALUE NEW VALUE                                 |
      | Status Completed In Progress                                   |
      | Assignee Assignee_AT_FN Assignee_AT_LN Admin_AT_FN Admin_AT_LN |

  @C43429185
  Scenario: C43429185: Activity Information Page - Activity Permission - System Admin Role - Edit activities pending for assignment
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User adds new Activity "With Pending For Assignment"
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" with "Assign Questionnaire" data
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "World Check Screening" activity
    Then Activity Information modal is displayed with details
      | Activity Type         | Activity Name          | Description            | Due Date | Assignee | Status      |
      | World Check Screening | Pending For Assignment | Pending For Assignment | TODAY+1  |          | Not Started |
    And User "" was assigned to this activity
    When User clicks Edit button for Activity
    Then Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Done        |
    When User selects activity status "Done"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User selects activity assessment
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Activity Type         | Activity Name          | Description            | Due Date | Status      |
      | World Check Screening | Pending For Assignment | Pending For Assignment | TODAY+1  | Not Started |
    And User "" was assigned to this activity
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "World Check Screening" activity
    Then Activity Information modal is displayed with details
      | Status    | Assignee                      |
      | Completed | Assignee_AT_FN Assignee_AT_LN |
    And User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
      | FIELD ORIGINAL VALUE NEW VALUE           |
      | Status Not Started Done                  |
      | Assignee - Assignee_AT_FN Assignee_AT_LN |
