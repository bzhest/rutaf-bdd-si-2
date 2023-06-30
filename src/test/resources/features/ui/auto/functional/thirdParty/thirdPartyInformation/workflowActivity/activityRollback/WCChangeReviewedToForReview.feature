@ui @functional @activity_rollback
Feature: Activity Rollback - World Check - Change "Reviewed" to "For Review"

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Group_1"
    And User clicks Check button

  @C36839899 @C41174617
  @email
  Scenario: C36839899, C41174617: [1] Change Review tasks from Reviewed to "For Review" in World Check activity - Onboarding - IN PROGRESS
    When User adds new Activity "AUTO_TEST_WC_ONBOARDING_IN_PROGRESS" with "World Check Screening Activity" data
    And User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |
    When User creates third-party "with workflow group and assignee user responsible party"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    And User clicks on "AUTO_TEST_WC_ONBOARDING_IN_PROGRESS" activity
    And User clicks Actions button for 1 Review Task
    And User clicks "Revert to For Review" action option
    Then Alert Dialog with text is displayed
      | Are you sure you want to revert this review task to For Review? This cannot be undone. |
    And Alert Dialog "Cancel" button displayed
    And Alert Dialog "Proceed" button displayed
    When User clicks "Proceed" Alert dialog button
    Then Activity Information modal is displayed with details
      | Status  |
      | Waiting |
    And Review Task table contains row on position 1 with Review Status "For Review"
    And Review action for row on position 1 is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on 1 number screening record
    Then Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Reviewer Assigned By is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Email notification "Screening Delegation" with following values is received by "Admin" user
      | <WC1_Record_Name> | 1 |

  @C36839899
  @email
  Scenario: C36839899: [1] Change Review tasks from Reviewed to "For Review" in World Check activity - Onboarding - WAITING
    When User adds new Activity "AUTO_TEST_WC_ONBOARDING_WAITING" with "World Check Screening Activity" data
    And User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |
    When User creates third-party "with workflow group and assignee user responsible party"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    And User clicks on 2 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Screening Results' screening profile button
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_WC_ONBOARDING_WAITING" activity
    And User clicks Actions button for 1 Review Task
    And User clicks "Revert to For Review" action option
    Then Alert Dialog with text is displayed
      | Are you sure you want to revert this review task to For Review? This cannot be undone. |
    And Alert Dialog "Cancel" button displayed
    And Alert Dialog "Proceed" button displayed
    When User clicks "Proceed" Alert dialog button
    Then Activity Information modal is displayed with details
      | Status  |
      | Waiting |
    And Review Task table contains row on position 1 with Review Status "For Review"
    And Review action for row on position 1 is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on 1 number screening record
    Then Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Reviewer Assigned By is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Email notification "Screening Delegation" with following values is received by "Admin" user
      | <WC1_Record_Name> | 1 |

  @C36839899
  @email
  Scenario: C36839899: [1] Change Review tasks from Reviewed to "For Review" in World Check activity - Renewal - IN PROGRESS
    When User adds new Activity "AUTO_TEST_WC_RENEWAL_IN_PROGRESS" with "World Check Screening Activity" data
    And User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |
    When User creates third-party "with workflow group and assignee user responsible party"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_WC_RENEWAL_IN_PROGRESS" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "toBeReplaced" is updated with type "Renewal"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "Renew" for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_WC_RENEWAL_IN_PROGRESS" activity
    And User clicks Actions button for 1 Review Task
    And User clicks "Revert to For Review" action option
    Then Alert Dialog with text is displayed
      | Are you sure you want to revert this review task to For Review? This cannot be undone. |
    And Alert Dialog "Cancel" button displayed
    And Alert Dialog "Proceed" button displayed
    When User clicks "Proceed" Alert dialog button
    Then Activity Information modal is displayed with details
      | Status  |
      | Waiting |
    And Review Task table contains row on position 1 with Review Status "For Review"
    And Review action for row on position 1 is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on 1 number screening record
    Then Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Reviewer Assigned By is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Email notification "Screening Delegation" with following values is received by "Admin" user
      | <WC1_Record_Name> | 1 |

  @C36839899
  @email
  Scenario: C36839899: [1] Change Review tasks from Reviewed to "For Review" in World Check activity - Renewal - WAITING
    When User adds new Activity "AUTO_TEST_WC_RENEWAL_WAITING" with "World Check Screening Activity" data
    And User clicks Save button for Workflow
    Then Created Workflow is displayed in table with values
      | WORKFLOW NAME | WORKFLOW TYPE | DATE CREATED | LAST UPDATED | STATUS |
      | toBeReplaced  | Onboarding    | MM/dd/YYYY   |              | Active |
    When User creates third-party "with workflow group and assignee user responsible party"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_WC_RENEWAL_WAITING" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "toBeReplaced" is updated with type "Renewal"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "Renew" for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    And User clicks on 2 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Screening Results' screening profile button
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_WC_RENEWAL_WAITING" activity
    And User clicks Actions button for 1 Review Task
    And User clicks "Revert to For Review" action option
    Then Alert Dialog with text is displayed
      | Are you sure you want to revert this review task to For Review? This cannot be undone. |
    And Alert Dialog "Cancel" button displayed
    And Alert Dialog "Proceed" button displayed
    When User clicks "Proceed" Alert dialog button
    Then Activity Information modal is displayed with details
      | Status  |
      | Waiting |
    And Review Task table contains row on position 1 with Review Status "For Review"
    And Review action for row on position 1 is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on 1 number screening record
    Then Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Reviewer Assigned By is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Email notification "Screening Delegation" with following values is received by "Admin" user
      | <WC1_Record_Name> | 1 |
