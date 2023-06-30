@ui @core_regression @full_regression @workflow_completion
Feature: Activity Review

  As a Supplier Integrity User Onboarding a Supplier
  I want the activities to be reviewed by designated reviewers before they are set to completed
  So that I can make sure that the activities are correct before the next activities are triggered

  Background:
    Given User logs into RDDC as "Assignee"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    When User adds new Activity "World Check Ongoing Screening Update Activity"
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
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "Request for Due Diligence" activity
    And User clicks "Approve" approve action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Back button to return from Activity modal
    Then Activity details table is loaded
    When User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity

  @C36068814 @C41174541
  @email
  Scenario: C36068814, C41174541: [Activity Review] Reviewing Activities - Triggering the review of activity.
    Then Activity Information Reviewers section is not shown
    When User selects activity status "In Progress"
    And User clicks 'Save' activity button
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    Then Activity Information Reviewers section is not shown
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Request for Due Diligence" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User navigates to Home page
    And User clicks 'Items To Review' widget
    Then Items to Review table contains activity
      | THIRD-PARTY NAME | ACTIVITY NAME             | DESCRIPTION               | DUE DATE | ASSIGNED TO                   | STATUS |
      | toBeReplaced     | Request for Due Diligence | Request for Due Diligence | TODAY+1  | Assignee_AT_FN Assignee_AT_LN | Done   |
    When User clicks Notification Bell
    Then "Activity to Review" notification displayed with text
      | Request for Due Diligence |
    And Email notification "Request for Review" with following values is received by "Assignee" user
      | <Activity_Name> | Request for Due Diligence |

  @C36068935
  Scenario: C36068935: [Activity Review] Approving Reviewing Activities by the default Reviewer
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Request for Due Diligence" activity
    Then Activity Information page is displayed
    When User clicks "Review" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Activity Information modal is displayed with details
      | Status    |
      | Completed |
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Reviewed |

  @C36084943
  Scenario: C36084943: [Activity Review] Rejecting Reviewing Activities by the default Reviewer
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Request for Due Diligence" activity
    Then Activity Information page is displayed
    When User clicks "Reject" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    And User clicks Reject button on confirmation window
    Then Confirmation window is disappeared
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action               | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |                      | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced | Re-assign for Review | Rejected |

  @C36084968
  @email
  Scenario: C36084968: [Activity Review] Re-assign Reviewing Activities by the default Reviewer
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Request for Due Diligence" activity
    Then Activity Information page is displayed
    When User clicks "Reassign" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action | Status                 |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Pending                |
      |                               |              |        | Pending for Assignment |
    And Activity Information Assigned To drop-down contains only active internal users
    When User selects "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                   | Last Update  | Action                 | Status     |
      | Assignee_AT_FN Assignee_AT_LN                 | toBeReplaced |                        | Reassigned |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN |              | Review,Reject,Reassign | Pending    |
    When User logs into RDDC as "Approver"
    And User clicks 'Items To Review' widget
    Then Items to Review table contains activity
      | THIRD-PARTY NAME | ACTIVITY NAME             | DESCRIPTION               | DUE DATE | ASSIGNED TO                   | STATUS |
      | toBeReplaced     | Request for Due Diligence | Request for Due Diligence | TODAY+1  | Assignee_AT_FN Assignee_AT_LN | Done   |
    When User clicks Notification Bell
    Then "Activity to Review" notification displayed with text
      | Request for Due Diligence |
    And Email notification "Request for Review" with following values is received by "Approver" user
      | <Activity_Name> | Request for Due Diligence |
