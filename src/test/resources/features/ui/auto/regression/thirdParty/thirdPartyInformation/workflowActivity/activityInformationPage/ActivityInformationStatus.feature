@ui @full_regression @core_regression @react @activity_status
Feature: Activity Information Page - Activity Status

  As a RDDC User
  I want to add the comment to activity information
  so that I will be able to all comment related to the activity

  @C38549662
  Scenario: C38549662: Activity Information Page - Verify change activity status to DONE or COMPLETED with no assessment
    Given User logs into RDDC as "Admin"
    When User creates "Activity Type" "without assessment" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User adds new Activity "AUTO_TEST_SIMPLE_ACTIVITY_TYPE_1" with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" data
    And User adds new Activity "AUTO_TEST_SIMPLE_ACTIVITY_TYPE_2" with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" data
    And User clicks Save button for Workflow
    Then Workflow Table is displayed
    When User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "AUTO_TEST_SIMPLE_ACTIVITY_TYPE_1" activity
    And User clicks Edit button for Activity
    Then Activity Information Assessment field should be enabled
    And Activity Information Status field should be enabled
    And Activity Information Assignee can be edited
    When User selects activity status "Done"
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Status      |
      | Not Started |
    And Activity Information button 'Cancel' is not displayed
    And Activity Information button 'Save' is not displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_SIMPLE_ACTIVITY_TYPE_1" activity
    Then Activity Information modal is displayed with details
      | Assessment | Status    |
      |            | Completed |

  @C38549663
  Scenario: C38549663: Activity Information Page - Verify change activity status to DONE or COMPLETED with assesssment
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineOrganizationWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "Auto Test Custom Activity name" activity
    And User clicks Edit button for Activity
    Then Activity Information Assessment field should be enabled
    And Activity Information Status field should be enabled
    And Activity Information Assignee can be edited
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Assessment | Status      |
      |            | Not Started |
    And Activity Information button 'Cancel' is not displayed
    And Activity Information button 'Save' is not displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Alert Icon is displayed with text
      | Cannot Save. Please fill up Assessment field before changing Activity status to completed. |
    And Activity Information "Assessment" field message "This field is required" is displayed
    When User selects activity assessment
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Assessment | Status      |
      |            | Not Started |
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "custom"
    And User clicks 'Save' activity button
    And User clicks on "Auto Test Custom Activity name" activity
    Then Activity Information modal is displayed with details
      | Assessment | Status    |
      | custom     | Completed |

  @C38549664
  Scenario: C38549664: Activity Information Page - Verify change activity status to DONE or COMPLETED with activity approver and assesssment
    Given User logs into RDDC as "Admin"
    When User creates "Activity Type" "with 1 assessment fields" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User adds new Activity "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1" with "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1" data
    And User clicks "Edit" icon for Activity "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1"
    And User clicks Activity "Edit Approver" tab
    And User selects "Admin_AT_FN Admin_AT_LN" value for Default Approver
    And User clicks workflow button "Done"
    And User adds new Activity "AUTO_TEST_SIMPLE_ACTIVITY_TYPE_2" with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" data
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1" activity
    And User clicks Edit button for Activity
    Then Activity Information Assessment field should be disabled
    And Activity Information Status field should be disabled
    And Activity Information Assignee can be edited
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    Then Activity Information Assessment field should be enabled
    And Activity Information Status field should be enabled
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Assessment | Status      |
      |            | Not Started |
    And Activity Information button 'Cancel' is not displayed
    And Activity Information button 'Save' is not displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Alert Icon is displayed with text
      | Cannot Save. Please fill up Assessment field before changing Activity status to completed. |
    And Activity Information "Assessment" field message "This field is required" is displayed
    When User selects activity assessment
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Assessment | Status      |
      |            | Not Started |
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "first"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1" activity
    Then Activity Information modal is displayed with details
      | Assessment | Status    |
      | first      | Completed |

  @C38549665
  Scenario: C38549665: Activity Information Page - Verify change activity status to DONE or COMPLETED with activity approver
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "NoSatisfiedApprovalRule" activity
    And User clicks Edit button for Activity
    Then Activity Information Assessment field should be disabled
    And Activity Information Status field should be disabled
    And Activity Information Assignee can be edited
    When Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Approve" button
    And User selects activity status "Done"
    And User selects activity assignee "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Status      |
      | Not Started |
    And Activity Information button 'Cancel' is not displayed
    And Activity Information button 'Save' is not displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assignee "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Save' activity button
    And User clicks "New Component" component tab
    And User clicks on "NoSatisfiedApprovalRule" activity
    Then Activity Information modal is displayed with details
      | Status    |
      | Completed |

  @C38549666
  Scenario: C38549666: Activity Information Page - Verify change activity status to DONE or COMPLETED with activity reviewer
    Given User logs into RDDC as "Admin"
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User adds new Activity "Assessment Activity" with "Assessment Activity" data
    And User clicks "Edit" icon for Activity "Assessment Activity"
    And User clicks Activity "Edit Approver" tab
    And User selects "Admin_AT_FN Admin_AT_LN" value for Default Approver
    And User clicks Activity "Add Reviewer" tab
    And User selects "Admin_AT_FN Admin_AT_LN" value for Default Reviewer
    And User clicks workflow button "Done"
    And User adds new Activity "AUTO_TEST_SIMPLE_ACTIVITY_TYPE_2" with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE" data
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    Then Activity Information Assessment field should be disabled
    And Activity Information Status field should be disabled
    And Activity Information Assignee can be edited
    When Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    Then Alert Icon is displayed with text
      | Success!                  |
      | Activity has been updated |
    When User clicks 'Save' activity button
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    Then Activity Information Assessment field should be enabled
    And Activity Information Status field should be enabled
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Cancel' activity button
    Then Activity Information modal is displayed with details
      | Status      |
      | Not Started |
    And Activity Information button 'Cancel' is not displayed
    And Activity Information button 'Save' is not displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information modal is displayed with details
      | Status |
      | Done   |
    When User clicks Edit button for Activity
    Then Activity Information Assessment field should be enabled
    And Activity Information Status field should be enabled
    And Activity Information Assignee can be edited
    When User clicks "Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks 'Save' activity button
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information modal is displayed with details
      | Status    |
      | Completed |
