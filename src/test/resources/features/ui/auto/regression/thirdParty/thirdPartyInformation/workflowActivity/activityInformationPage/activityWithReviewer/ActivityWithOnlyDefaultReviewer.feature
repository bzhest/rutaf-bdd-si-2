@ui @full_regression @react @activity_with_reviewer @onlySingleThread
Feature: Activity Information Page - Activity with Reviewer

  As a RDDC user
  I want the activities to be reviewed by designated Reviewer before the activities is completed
  So that I could ensure that the correct activity was performed and was done properly

  @C38383219
  @core_regression
  Scenario: C38383219: Activity Information Page - Activity with Reviewer - Verify triggering of Review Activity with approver in the activity
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Approver "Admin_AT_FN Admin_AT_LN" and Reviewer "Admin_AT_FN Admin_AT_LN"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User approves all activities
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To             | Last Update  | Action | Status   |
      | Admin_AT_FN Admin_AT_LN |              |        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Approved |
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Cancel' activity button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "Not Started"
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |

  @C38620516
  @core_regression
  Scenario: C38620516: Activity Information Page - Activity with Reviewer - Verify triggering of Review Activity with no approver in the activity
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "Admin_AT_FN Admin_AT_LN"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Cancel' activity button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "Not Started"
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |

  @C38383256
  @core_regression
  Scenario: C38383256: Activity Information Page - Activity with Reviewer - Verify Reviewer Section and its content - Reassigned status
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "Admin_AT_FN Admin_AT_LN"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reassign" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User selects "Assignee_AT_FN Assignee_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status     |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                        | Reassigned |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending    |

  @C38383257 @C38383256
  @core_regression
  Scenario: C38383257, C38383256: Activity Information Page - Activity with Reviewer - Only Default Reviewer Set - Verify Default Review can review activity
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "Assignee_AT_FN Assignee_AT_LN"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Review" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Reviewed |

  @C38383258 @C38383256
  @core_regression
  Scenario: C38383258, C38383256: Activity Information Page - Activity with Reviewer - Only Default Reviewer Set - Verify Default Reviewer can reject activity
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "Assignee_AT_FN Assignee_AT_LN"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reject" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    And User clicks Cancel button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reject" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action               | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |                      | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced | Re-assign for Review | Rejected |

  @C38383260
  Scenario: C38383260: Activity Information Page - Activity with Reviewer - Only Default Reviewer Set - Verify Default Reviewer can reassign activity
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "Assignee_AT_FN Assignee_AT_LN"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reject" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    And User clicks Cancel button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reassign" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    And User selects "Admin_AT_FN Admin_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status     |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |                        | Reassigned |
      | Admin_AT_FN Admin_AT_LN       |              | Review,Reject,Reassign | Pending    |

  @C38383259
  @core_regression
  Scenario: C38383259: Activity Information Page - Activity with Reviewer - Only Default Reviewer Set - Verify Default Reviewer can re-assign for review a rejected activity
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "Assignee_AT_FN Assignee_AT_LN"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reject" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action               | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |                      | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced | Re-assign for Review | Rejected |
    When User clicks "Re-assign for Review" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |                        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |                        | Rejected |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced | Review,Reject,Reassign | Pending  |