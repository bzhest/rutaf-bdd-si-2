@ui @full_regression @react @activity_with_reviewer
Feature: Activity Information Page - Activity with Multiple Reviewers Rules

  As a RDDC user
  I want the activities to be reviewed by designated Reviewer before the activities is completed
  So that I could ensure that the correct activity was performed and was done properly

  Background:
    Given User logs into RDDC as "Admin"

  @C38624080
  @core_regression
  Scenario: C38624080: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ALL' - Verify reviewer rule can review activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple reviewers ALL |
    And User creates third-party "with workflow group Ukraine" via API and open it
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
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are enabled
    When User clicks "Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                        | Reviewed |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending  |
    When User clicks "Review" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |        | Reviewed |
      | Assignee_AT_FN Assignee_AT_LN |              |        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Reviewed |

  @C38624081
  Scenario: C38624081: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ALL'  - Verify reviewer rule can reject activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple reviewers ALL |
    And User creates third-party "with workflow group Ukraine" via API and open it
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
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are enabled
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Cancel button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Re-assign for Review   | Rejected |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending  |
    When User clicks "Reject" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    And User clicks Cancel button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Re-assign for Review   | Rejected |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending  |
    When User clicks "Reject" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    And User clicks Proceed button on confirmation window
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action               | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                      | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Re-assign for Review | Rejected |
      | Assignee_AT_FN Assignee_AT_LN |              |                      | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced | Re-assign for Review | Rejected |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are enabled

  @C38624082
  Scenario: C38624082: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ALL  - Verify reviewer rule can re-assign for approval a rejected activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple reviewers ALL |
    And User creates third-party "with workflow group Ukraine" via API and open it
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
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Re-assign for Review   | Rejected |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending  |
    When User clicks "Re-assign for Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                        | Rejected |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Review,Reject,Reassign | Pending  |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending  |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are enabled

  @C38624083
  Scenario: C38624083: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ALL - Verify reviewer rule can reassign activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple reviewers ALL |
    And User creates third-party "with workflow group Ukraine" via API and open it
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
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reassign" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status                 |
      | Admin_AT_FN Admin_AT_LN       |              | Review,Reject,Reassign | Pending                |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |                        | Pending                |
      |                               |              |                        | Pending for Assignment |
    And Activity Information Assigned To drop-down contains only first 20 active Internal users
    When User selects "Admin_double_AT_FN Admin_double_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                           | Last Update  | Action                 | Status     |
      | Admin_AT_FN Admin_AT_LN               |              | Review,Reject,Reassign | Pending    |
      | Assignee_AT_FN Assignee_AT_LN         | toBeReplaced |                        | Reassigned |
      | Admin_double_AT_FN Admin_double_AT_LN |              | Review,Reject,Reassign | Pending    |
    When User clicks "Reassign" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                           | Last Update  | Action                 | Status                 |
      | Admin_AT_FN Admin_AT_LN               | toBeReplaced |                        | Pending                |
      |                                       |              |                        | Pending for Assignment |
      | Assignee_AT_FN Assignee_AT_LN         | toBeReplaced |                        | Reassigned             |
      | Admin_double_AT_FN Admin_double_AT_LN |              | Review,Reject,Reassign | Pending                |
    And Activity Information Assigned To drop-down contains only first 20 active Internal users
    When User selects "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                   | Last Update  | Action                 | Status     |
      | Admin_AT_FN Admin_AT_LN                       | toBeReplaced |                        | Reassigned |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN |              | Review,Reject,Reassign | Pending    |
      | Assignee_AT_FN Assignee_AT_LN                 | toBeReplaced |                        | Reassigned |
      | Admin_double_AT_FN Admin_double_AT_LN         |              | Review,Reject,Reassign | Pending    |
    And All action buttons for Activity reviewer "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" are enabled
    And All action buttons for Activity reviewer "Admin_double_AT_FN Admin_double_AT_LN" are enabled

  @C38624479
  @core_regression
  Scenario: C38624479: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method ' IN SEQUENCE' - Verify reviewer rule can review activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple reviewers IN SEQUENCE |
    And User creates third-party "with workflow group Ukraine" via API and open it
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
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled
    When User clicks "Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                        | Reviewed |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending  |
    When User clicks "Review" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |        | Reviewed |
      | Assignee_AT_FN Assignee_AT_LN |              |        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Reviewed |

  @C38624480
  Scenario: C38624480: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method ' IN SEQUENCE' - Verify reviewer rule can reject activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple reviewers IN SEQUENCE |
    And User creates third-party "with workflow group Ukraine" via API and open it
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
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Cancel button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Re-assign for Review   | Rejected |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending  |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled

  @C38624481
  Scenario: C38624481: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'IN SEQUENCE' - Verify reviewer rule can re-assign for review a rejected activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple reviewers IN SEQUENCE |
    And User creates third-party "with workflow group Ukraine" via API and open it
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
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Re-assign for Review   | Rejected |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending  |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled
    When User clicks "Re-assign for Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                        | Rejected |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Review,Reject,Reassign | Pending  |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending  |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled

  @C38624482
  Scenario: C38624482: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method ' IN SEQUENCE'  - Verify reviewer rule can reassign activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple reviewers IN SEQUENCE |
    And User creates third-party "with workflow group Ukraine" via API and open it
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
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled
    When User clicks "Reassign" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status                 |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                        | Pending                |
      |                               |              |                        | Pending for Assignment |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending                |
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled
    And Activity Information Assigned To drop-down contains only first 20 active Internal users
    When User selects "Admin_double_AT_FN Admin_double_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                           | Last Update  | Action                 | Status     |
      | Admin_AT_FN Admin_AT_LN               | toBeReplaced |                        | Reassigned |
      | Admin_double_AT_FN Admin_double_AT_LN |              | Review,Reject,Reassign | Pending    |
      | Assignee_AT_FN Assignee_AT_LN         |              | Review,Reject,Reassign | Pending    |
    And All action buttons for Activity reviewer "Admin_double_AT_FN Admin_double_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled

  @C38624678
  @core_regression
  Scenario: C38624678: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ANY' - Verify reviewer rule can review activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple reviewers ANY |
    And User creates third-party "with workflow group Ukraine" via API and open it
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
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are enabled
    When User clicks "Review" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action | Status   |
      | Assignee_AT_FN Assignee_AT_LN |              |        | Pending  |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Reviewed |

  @C38624679
  Scenario: C38624679: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ANY' - Verify reviewer  rule can reject activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple reviewers ANY |
    And User creates third-party "with workflow group Ukraine" via API and open it
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
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are enabled
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Cancel button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are enabled
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Re-assign for Review   | Rejected |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending  |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are enabled

  @C38624680
  Scenario: C38624680: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ANY' - Verify reviewer rule can re-assign for review a rejected activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple reviewers ANY |
    And User creates third-party "with workflow group Ukraine" via API and open it
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
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are enabled
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Re-assign for Review   | Rejected |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending  |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are enabled
    When User clicks "Re-assign for Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN       |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced |                        | Rejected |
      | Admin_AT_FN Admin_AT_LN       | toBeReplaced | Review,Reject,Reassign | Pending  |
      | Assignee_AT_FN Assignee_AT_LN |              | Review,Reject,Reassign | Pending  |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are enabled

  @C38624681
  Scenario: C38624681: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ANY' - Verify reviewer rule can reassign activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple reviewers ANY |
    And User creates third-party "with workflow group Ukraine" via API and open it
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
      | Assigned To                   | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN       |             | Review,Reject,Reassign | Pending |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reassign" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action                 | Status                 |
      | Admin_AT_FN Admin_AT_LN       |              | Review,Reject,Reassign | Pending                |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |                        | Pending                |
      |                               |              |                        | Pending for Assignment |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And Activity Information Assigned To drop-down contains only first 20 active Internal users
    When User selects "Admin_double_AT_FN Admin_double_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                           | Last Update  | Action                 | Status     |
      | Admin_AT_FN Admin_AT_LN               |              | Review,Reject,Reassign | Pending    |
      | Assignee_AT_FN Assignee_AT_LN         | toBeReplaced |                        | Reassigned |
      | Admin_double_AT_FN Admin_double_AT_LN |              | Review,Reject,Reassign | Pending    |
    And All action buttons for Activity reviewer "Admin_AT_FN Admin_AT_LN" are enabled
    And All action buttons for Activity reviewer "Admin_double_AT_FN Admin_double_AT_LN" are enabled