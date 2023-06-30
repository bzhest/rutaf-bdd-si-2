@ui @full_regression @core_regression @adhoc_activity @react

Feature: Ad hoc activities with notifications

  As a SI user
  I want to verify notifications for Adhoc activity
  So that notifications should be received for different Activities states

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineIndividual"
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management page is displayed
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "Request for Due Diligence Activity"
    And User fills in "Activity Name" field with "Request for Due Diligence Activity Name"
    And User fills in "Description" field with "Request for Due Diligence Activity Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    Then Activity Information "Reviewer" field should be enabled
    And 'Reviewer' dropdown contains all Internal Active users
    When User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Done button in Activity Reviewers section
    Then Review icon Delete icon for "Admin_AT_FN Admin_AT_LN" user should be displayed
    And Review icon Edit icon for "Admin_AT_FN Admin_AT_LN" user should be displayed
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks Back button to return from Activity modal
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User refreshes page
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks 'Save' activity button
    And User navigates to Home page
    Then Home page is loaded
    And Notification Bell Icon contains 1 new notification
    When User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And Notification Bell Icon counter is not displayed
    And "Activity to Review" notification displayed with text
      | Request for Due Diligence Activity Name |
    When User clicks "Activity to Review" "Request for Due Diligence Activity Name" notification
    Then Activity Information modal is displayed with details
      | Activity Type                      | Activity Name                           | Description                                    | Due Date | Assignee                      | Status |
      | Request for Due Diligence Activity | Request for Due Diligence Activity Name | Request for Due Diligence Activity Description | TODAY+0  | Assignee_AT_FN Assignee_AT_LN | Done   |
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |

  @C38647983
  Scenario: C38647983: Third-party - Ad Hoc Activity - Review Activity
    When User clicks "Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action | Status   |
      | Admin_AT_FN Admin_AT_LN |              |        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Reviewed |
    And "Reviewer" dropdown not displayed on Activity Information page on Risk Management tab
    And Review icon Delete icon for "Admin_AT_FN Admin_AT_LN" user should not be displayed
    And Review icon Edit icon for "Admin_AT_FN Admin_AT_LN" user should not be displayed

  @C38647984
  Scenario: C38647984: Third-party - Ad Hoc Activities - Reject Activity
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Cancel button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action               | Status   |
      | Admin_AT_FN Admin_AT_LN |              |                      | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced | Re-assign for Review | Rejected |

  @C38647985
  Scenario: C38647985: Third-party - Ad Hoc Activities - Reassign Rejected Activity
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Cancel button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action               | Status   |
      | Admin_AT_FN Admin_AT_LN |              |                      | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced | Re-assign for Review | Rejected |
    When User clicks "Re-assign for Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |                        | Rejected |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced | Review,Reject,Reassign | Pending  |

  @C38647986
  Scenario: C38647986: Third-party - Ad Hoc Activity - Reassign Review Activity
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Cancel button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reassign" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action | Status                 |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Pending                |
      |                         |              |        | Pending for Assignment |
    When User selects "Admin_double_AT_FN Admin_double_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                           | Last Update  | Action                 | Status     |
      | Admin_AT_FN Admin_AT_LN               | toBeReplaced |                        | Reassigned |
      | Admin_double_AT_FN Admin_double_AT_LN |              | Review,Reject,Reassign | Pending    |