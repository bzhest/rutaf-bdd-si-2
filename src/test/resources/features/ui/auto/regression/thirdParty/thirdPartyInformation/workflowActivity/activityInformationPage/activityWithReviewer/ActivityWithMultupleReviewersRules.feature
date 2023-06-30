@ui @full_regression @react @activity_with_reviewer
Feature: Activity Information Page - Activity with Multiple Reviewers Rules

  As a RDDC user
  I want the activities to be reviewed by designated Reviewer before the activities is completed
  So that I could ensure that the correct activity was performed and was done properly

  Background:
    Given User logs into RDDC as "Admin"

  @C38383261
  @core_regression
  Scenario: C38383261: Activity Information Page - Activity with Reviewer - Multiple Reviewer Rules set but only one rule is satisfied - Verify reviewer rule can review activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division          |
      | Auto Review Process Admin Double |
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
    When User clicks "Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action | Status   |
      | Admin_AT_FN Admin_AT_LN |              |        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Reviewed |

  @C38383262
  Scenario: C38383262: Activity Information Page - Activity with Reviewer - Multiple Reviewer Rules set but only one rule is satisfied - Verify reviewer rule can reject activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division          |
      | Auto Review Process Admin Double |
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

  @C38383263
  @core_regression
  Scenario: C38383263: Activity Information Page - Activity with Reviewer - Multiple Reviewer Rules set but only one rule is satisfied - Verify approver rule can re-assign for review a rejected activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division          |
      | Auto Review Process Admin Double |
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

  @C38383264
  @core_regression
  Scenario: C38383264: Activity Information Page - Activity with Reviewer - Multiple Reviewer Rules set but only one rule is satisfied - Verify reviewer rule can reassign activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division          |
      | Auto Review Process Admin Double |
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
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action | Status                 |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Pending                |
      |                         |              |        | Pending for Assignment |
    And Activity Information Assigned To drop-down contains only first 20 active Internal users
    When User selects "Admin_double_AT_FN Admin_double_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                           | Last Update  | Action                 | Status     |
      | Admin_AT_FN Admin_AT_LN               | toBeReplaced |                        | Reassigned |
      | Admin_double_AT_FN Admin_double_AT_LN |              | Review,Reject,Reassign | Pending    |

  @C38383265
  Scenario: C38383265: Activity Information Page - Activity with Reviewer - Multiple Reviewer Rules Set and multiple rules are satisfied - Verify reviewer rule can review activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division                        |
      | Activity Owner Division Multiple reviewers ALL |
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
    When User clicks "Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action | Status   |
      | Admin_AT_FN Admin_AT_LN |              |        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Reviewed |

  @C38383266
  Scenario: C38383266: Activity Information Page - Activity with Reviewer - Multiple Reviewer Rules Set and multiple rules are satisfied - Verify reviewer rule can reject activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division                        |
      | Activity Owner Division Multiple reviewers ALL |
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

  @C38383267
  @core_regression
  Scenario: C38383267: Activity Information Page - Activity with Reviewer - Multiple Reviewer Rules Set and multiple rules are satisfied - Verify reviewer rule can re-assign for review a rejected activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division                        |
      | Activity Owner Division Multiple reviewers ALL |
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

  @C38383268
  Scenario: C38383268: Activity Information Page - Activity with Reviewer - Multiple Reviewer Rules Set and multiple rules are satisfied - Verify reviewer rule can reassign activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division                        |
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
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reassign" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action | Status                 |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Pending                |
      |                         |              |        | Pending for Assignment |
    And Activity Information Assigned To drop-down contains only first 20 active Internal users
    When User selects "Admin_double_AT_FN Admin_double_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                           | Last Update  | Action                 | Status     |
      | Admin_AT_FN Admin_AT_LN               | toBeReplaced |                        | Reassigned |
      | Admin_double_AT_FN Admin_double_AT_LN |              | Review,Reject,Reassign | Pending    |

  @C38383269
  Scenario: C38383269: Activity Information Page - Activity with Reviewer - Multiple Reviewer Rules Set but no rule is satisfied - Verify default reviewer can review activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "Assignee_AT_FN" with Reviewer rules
      | Auto Review Process Questionnaire Approver |
      | Auto Review Process Admin Double           |
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

  @C38383270
  Scenario: C38383270: Activity Information Page - Activity with Reviewer - Multiple Reviewer Rules Set but no rule is satisfied - Verify default reviewer can reject activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "Assignee_AT_FN" with Reviewer rules
      | Auto Review Process Questionnaire Approver |
      | Auto Review Process Admin Double           |
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

  @C38383271
  Scenario: C38383271: Activity Information Page - Activity with Reviewer - Multiple Reviewer Rules Set but no rule is satisfied - Verify default reviewer can re-assign for review a rejected activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "Assignee_AT_FN" with Reviewer rules
      | Auto Review Process Questionnaire Approver |
      | Auto Review Process Admin Double           |
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

  @C38383272
  Scenario: C38383272: Activity Information Page - Activity with Reviewer - Multiple Reviewer Rules Set but no rule is satisfied - Verify default reviewer can reassign activity
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "Assignee_AT_FN Assignee_AT_LN" with Reviewer rules
      | Auto Review Process Questionnaire Approver |
      | Auto Review Process Admin Double           |
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
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks "Reassign" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update  | Action | Status                 |
      | Assignee_AT_FN Assignee_AT_LN | toBeReplaced |        | Pending                |
      |                               |              |        | Pending for Assignment |
    And Activity Information Assigned To drop-down contains only first 20 active Internal users
    When User selects "Admin_double_AT_FN Admin_double_AT_LN" reviewer user
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                           | Last Update  | Action                 | Status     |
      | Assignee_AT_FN Assignee_AT_LN         | toBeReplaced |                        | Reassigned |
      | Admin_double_AT_FN Admin_double_AT_LN |              | Review,Reject,Reassign | Pending    |