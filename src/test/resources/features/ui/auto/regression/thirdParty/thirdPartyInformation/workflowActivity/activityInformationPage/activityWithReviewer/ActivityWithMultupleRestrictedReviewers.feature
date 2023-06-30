@ui @full_regression @react @activity_with_reviewer
Feature: Activity Information Page - Activity with Multiple Reviewers Rules, Reviewers with Edit permissions

  As a RDDC user
  I want the activities to be reviewed by designated Reviewer before the activities is completed
  So that I could ensure that the correct activity was performed and was done properly

  Background:
    Given User logs into RDDC as "admin"

  @C43655042
  @core_regression
  Scenario: C43655042: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ALL' - Verify reviewer rule can review OWN activity only
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple Restricted reviewers ALL |
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When User clicks "Review" review action button for "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              | Review,Reject,Reassign | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |                        | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |                        | Reviewed |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    When User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    When User clicks "Review" review action button for "Autouser_Edit_FN Autouser_Edit_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |        | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |        | Reviewed |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |        | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |        | Reviewed |

  @C43655607
  Scenario: C43655607: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ALL'  - Verify reviewer rule can reject OWN activity only
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple Restricted reviewers ALL |
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When User clicks "Reject" review action button for "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" user
    And User clicks Cancel button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When User clicks "Reject" review action button for "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              | Review,Reject,Reassign | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |                        | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced | Re-assign for Review   | Rejected |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              | Review,Reject,Reassign | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |                        | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced | Re-assign for Review   | Rejected |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User clicks "Reject" review action button for "Autouser_Edit_FN Autouser_Edit_LN" user
    And User clicks Cancel button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              | Review,Reject,Reassign | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |                        | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced | Re-assign for Review   | Rejected |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User clicks "Reject" review action button for "Autouser_Edit_FN Autouser_Edit_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action               | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                      | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced | Re-assign for Review | Rejected |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |                      | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced | Re-assign for Review | Rejected |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled

  @C43656661 @C43657844 @C43657994
  Scenario Outline: C43656661, C43657844, C43657994: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ALL/IN SEQUENCE/ANY'  - Verify only the reviewer rule can re-assign for approval a rejected activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | <reviewerRule> |
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    When User clicks "Reject" review action button for "Autouser_Edit_FN Autouser_Edit_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                       | Last Update  | Action                 | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN |              |                        | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced | Re-assign for Review   | Rejected |
      | Assignee_AT_FN Assignee_AT_LN     |              | Review,Reject,Reassign | Pending  |
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                       | Last Update  | Action                 | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN |              |                        | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced | Re-assign for Review   | Rejected |
      | Assignee_AT_FN Assignee_AT_LN     |              | Review,Reject,Reassign | Pending  |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled
    When User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                       | Last Update  | Action                 | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN |              |                        | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced | Re-assign for Review   | Rejected |
      | Assignee_AT_FN Assignee_AT_LN     |              | Review,Reject,Reassign | Pending  |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled
    When User clicks "Re-assign for Review" review action button for "Autouser_Edit_FN Autouser_Edit_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                       | Last Update  | Action                 | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN |              |                        | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced |                        | Rejected |
      | Autouser_Edit_FN Autouser_Edit_LN | toBeReplaced | Review,Reject,Reassign | Pending  |
      | Assignee_AT_FN Assignee_AT_LN     |              | Review,Reject,Reassign | Pending  |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled
    Examples:
      | reviewerRule                                                          |
      | Activity Owner Division Multiple reviewers one restricted ALL         |
      | Activity Owner Division Multiple reviewers one restricted IN SEQUENCE |
      | Activity Owner Division Multiple reviewers one restricted ANY         |

  @C43656858 @C43658044
  Scenario Outline: C43656858, C43658044: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ALL/ANY' - Verify reviewer rule can reassign OWN activity only
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | <reviewerRule> |
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When User clicks "Reassign" review action button for "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status                 |
      | Autouser_Edit_FN Autouser_Edit_LN               |              | Review,Reject,Reassign | Pending                |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |                        | Pending                |
      |                                                 |              |                        | Pending for Assignment |
    And Activity Information Assigned To drop-down contains only first 20 active Internal users
    When User selects "Admin_double_AT_FN Admin_double_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status     |
      | Autouser_Edit_FN Autouser_Edit_LN               |              | Review,Reject,Reassign | Pending    |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |                        | Reassigned |
      | Admin_double_AT_FN Admin_double_AT_LN           |              | Review,Reject,Reassign | Pending    |
    And All action buttons for Activity reviewer "Admin_double_AT_FN Admin_double_AT_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status     |
      | Autouser_Edit_FN Autouser_Edit_LN               |              | Review,Reject,Reassign | Pending    |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |                        | Reassigned |
      | Admin_double_AT_FN Admin_double_AT_LN           |              | Review,Reject,Reassign | Pending    |
    And All action buttons for Activity reviewer "Admin_double_AT_FN Admin_double_AT_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    When User clicks "Reassign" review action button for "Autouser_Edit_FN Autouser_Edit_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status                 |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                        | Pending                |
      |                                                 |              |                        | Pending for Assignment |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |                        | Reassigned             |
      | Admin_double_AT_FN Admin_double_AT_LN           |              | Review,Reject,Reassign | Pending                |
    And Activity Information Assigned To drop-down contains only first 20 active Internal users
    When User selects "Assignee_AT_FN Assignee_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status     |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                        | Reassigned |
      | Assignee_AT_FN Assignee_AT_LN                   |              | Review,Reject,Reassign | Pending    |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |                        | Reassigned |
      | Admin_double_AT_FN Admin_double_AT_LN           |              | Review,Reject,Reassign | Pending    |
    And All action buttons for Activity reviewer "Admin_double_AT_FN Admin_double_AT_LN" are disabled
    And All action buttons for Activity reviewer "Assignee_AT_FN Assignee_AT_LN" are disabled

    Examples:
      | reviewerRule                                              |
      | Activity Owner Division Multiple Restricted reviewers ALL |
      | Activity Owner Division Multiple Restricted reviewers ANY |

  @C43657535
  @core_regression
  Scenario: C43657535: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method ' IN SEQUENCE' - Verify reviewer rule can review OWN activity only
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple Restricted reviewers IN SEQUENCE |
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User clicks "Review" review action button for "Autouser_Edit_FN Autouser_Edit_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                        | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                        | Reviewed |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Review,Reject,Reassign | Pending  |
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    And User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    When User clicks "Review" review action button for "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |        | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |        | Reviewed |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |        | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |        | Reviewed |

  @C43657793
  Scenario: C43657793: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method ' IN SEQUENCE' - Verify reviewer rule can reject OWN activity only
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple Restricted reviewers IN SEQUENCE |
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User clicks "Reject" review action button for "Autouser_Edit_FN Autouser_Edit_LN" user
    And User clicks Cancel button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User clicks "Reject" review action button for "Autouser_Edit_FN Autouser_Edit_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                        | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced | Re-assign for Review   | Rejected |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Review,Reject,Reassign | Pending  |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              |                        | Pending  |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced | Re-assign for Review   | Rejected |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Review,Reject,Reassign | Pending  |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled

  @C43657854
  Scenario: C43657854: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'IN SEQUENCE'  - Verify reviewer rule can reassign OWN activity only
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple Restricted reviewers IN SEQUENCE |
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User clicks "Reassign" review action button for "Autouser_Edit_FN Autouser_Edit_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status                 |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                        | Pending                |
      |                                                 |              |                        | Pending for Assignment |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Review,Reject,Reassign | Pending                |
    And Activity Information Assigned To drop-down contains only first 20 active Internal users
    When User selects "Admin_double_AT_FN Admin_double_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status     |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                        | Reassigned |
      | Admin_double_AT_FN Admin_double_AT_LN           |              | Review,Reject,Reassign | Pending    |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Review,Reject,Reassign | Pending    |
    And All action buttons for Activity reviewer "Admin_double_AT_FN Admin_double_AT_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    And User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status     |
      | Autouser_Edit_FN Autouser_Edit_LN               | toBeReplaced |                        | Reassigned |
      | Admin_double_AT_FN Admin_double_AT_LN           |              | Review,Reject,Reassign | Pending    |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              | Review,Reject,Reassign | Pending    |
    And All action buttons for Activity reviewer "Admin_double_AT_FN Admin_double_AT_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled

  @C43657979
  @core_regression
  Scenario: C43657979: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ANY' - Verify reviewer rule can review activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple Restricted reviewers ANY |
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When User clicks "Review" review action button for "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action | Status   |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |        | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced |        | Reviewed |

  @C43657986
  Scenario: C43657986: Activity Information Page - Activity with Reviewer - Reviewer Rules with Multiple Reviewers using method 'ANY' - Verify reviewer  rule can reject OWN activity only
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple Restricted reviewers ANY |
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are enabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are disabled
    When User logs into RDDC as "second with edit permissions"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Assessment Activity" activity
    Then Activity Information Reviewers section is shown
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When User clicks "Reject" review action button for "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" user
    And User clicks Cancel button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update | Action                 | Status  |
      | Autouser_Edit_FN Autouser_Edit_LN               |             | Review,Reject,Reassign | Pending |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |             | Review,Reject,Reassign | Pending |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled
    When User clicks "Reject" review action button for "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" user
    And User clicks Proceed button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                                     | Last Update  | Action                 | Status   |
      | Autouser_Edit_FN Autouser_Edit_LN               |              | Review,Reject,Reassign | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN |              |                        | Pending  |
      | Autouser_Second_Edit_FN Autouser_Second_Edit_LN | toBeReplaced | Re-assign for Review   | Rejected |
    And All action buttons for Activity reviewer "Autouser_Edit_FN Autouser_Edit_LN" are disabled
    And All action buttons for Activity reviewer "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" are enabled