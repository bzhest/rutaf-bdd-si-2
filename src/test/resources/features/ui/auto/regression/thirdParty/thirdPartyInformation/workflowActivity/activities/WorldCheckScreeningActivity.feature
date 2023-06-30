@ui @full_regression @core_regression @react @supplier_onboarding
Feature: Onboarding - World Check Screening Activity

  As a RDDC User
  I want to see review task in the World-Check Screening activity
  so that I can see it was created upon delegation of WC1 record

  @C33199853
  Scenario: C33199853: Third-party - Add Third-party - Assign to Workflow Group with World Check Screening activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    Then User verifies third-party is created

  @C33199854
  Scenario: C33199854: Third-party Onboarding - Start Onboarding Third-party with Workflow that have World Check Screening Activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "New Component" component tab
    Then Activities table should contain the following activity
      | Name                     | Type                  | Assigned To                   | Due Date | Status      |
      | OneSatisfiedApprovalRule | World Check Screening | Assignee_AT_FN Assignee_AT_LN | TODAY+1  | Not Started |

  @C33199855
  Scenario: C33199855: [Internal User] Third-party Onboarding - View World Check Screening Activity - Assigned to User (RMS-453, RMS-886)
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on 1 number screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" reviewer due to today date
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    Then Activities table should contain the following activity
      | Name                     | Type                  | Assigned To                   | Due Date | Status  |
      | OneSatisfiedApprovalRule | World Check Screening | Assignee_AT_FN Assignee_AT_LN | TODAY+1  | Waiting |
    When User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                      | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Assignee_AT_FN Assignee_AT_LN | For Review    | TODAY+0  | THIRD-PARTY | VIEW        |

  @C33199859
  Scenario: C33199859: [Reviewer] Third-party Onboarding - View World Check Screening Activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    Then Activities table should contain the following activity
      | Name                     | Type                  | Assigned To                   | Due Date | Status  |
      | OneSatisfiedApprovalRule | World Check Screening | Assignee_AT_FN Assignee_AT_LN | TODAY+1  | Waiting |
    When User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Admin_AT_FN Admin_AT_LN | For Review    | TODAY+0  | THIRD-PARTY | REVIEW      |

  @C33199860
  Scenario: C33199860: [Reviewer] Third-party Onboarding - View World Check Screening Activity - User Group
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on 1 number screening record
    And User adds screening record "User Group" "AUTO_GROUP" reviewer due to today date
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    Then Activities table should contain the following activity
      | Name                     | Type                  | Assigned To                   | Due Date | Status  |
      | OneSatisfiedApprovalRule | World Check Screening | Assignee_AT_FN Assignee_AT_LN | TODAY+1  | Waiting |
    When User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer   | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | AUTO_GROUP | For Review    | TODAY+0  | THIRD-PARTY | REVIEW      |

  @C33199861
  Scenario: C33199861: [Reviewer] Third-party Onboarding - World Check Screening activity - View Third-party record
    Given User logs into RDDC as "Assignee"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information modal is displayed with details
      | Status  |
      | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Admin_AT_FN Admin_AT_LN | For Review    | TODAY+0  | THIRD-PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Reviewer Assigned By is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review button is enabled

  @C33199862
  Scenario: C33199862: [Reviewer] Third-party Onboarding - World Check Screening activity - View Third-party Contact record
    Given User logs into RDDC as "Assignee"
    When User creates third-party "belizeWithApprover"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User creates Associated Party "John SMITH"
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information modal is displayed with details
      | Status  |
      | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                | Review Status | Due Date | Type             | Button Name |
      | recordName1 | recordId1    | Admin_AT_FN Admin_AT_LN | For Review    | TODAY+0  | ASSOCIATED PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Reviewer Assigned By is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review button is enabled

  @C33222278
  Scenario: C33222278: [Reviewer] Third-party Onboarding - World Check Screening activity - View Third-party record - Click Review
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Screening Results' screening profile button
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    And User clicks Actions button for 1 Review Task
    And User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"

  @C33222280
  Scenario: C33222280: [Reviewer] Third-party Onboarding - View World Check Screening activity - Verify that review status is changed to Reviewed
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Admin_AT_FN Admin_AT_LN | Reviewed      | TODAY+0  | THIRD-PARTY | ACTIONS     |

  @C33894205
  Scenario: C33894205: [Reviewer-User Group] Third-party Onboarding - World Check Screening activity - View Third-party record - Click Review
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    And User clicks Edit button for Activity
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Save' activity button
    And User clicks on 1 number screening record
    And User adds screening record "User Group" "AUTO_GROUP" reviewer due to today date
    And User clicks on the 'Screening Results' screening profile button
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information modal is displayed with details
      | Status  |
      | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer   | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | AUTO_GROUP | For Review    | TODAY+0  | THIRD-PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review button is enabled
    When User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"

  @C33894206
  Scenario: C33894206: [Reviewer] Third-party Onboarding - World Check Screening activity - View Third-party contact record - Click Review
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User creates Associated Party "John SMITH"
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    And User clicks Actions button for 1 Review Task
    And User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"

  @C33222281
  Scenario: C33222281: [Reviewer-User Group] Third-party Onboarding - World Check Screening activity - View Third-party contact record - Click Review
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    And User clicks Edit button for Activity
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Save' activity button
    And User creates Associated Party "John SMITH"
    And User clicks on 1 number screening record
    And User adds screening record "User Group" "AUTO_GROUP" reviewer due to today date
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information modal is displayed with details
      | Status  |
      | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer   | Review Status | Due Date | Type             | Button Name |
      | recordName1 | recordId1    | AUTO_GROUP | For Review    | TODAY+0  | ASSOCIATED PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review button is enabled
    When User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"

  @C33433619
  @email
  Scenario: C33433619: [Reviewer] Third-party Onboarding - Review record - Reassign record to another internal user
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And Users clicks "Due Date" dashboard table column header
    And User selects "Max" items per page
    Then Assigned Activity for third-party is displayed
    When User clicks on assigned activity for created third-party
    And User edits screening record reviewer to "Assignee_AT_FN Assignee_AT_LN"
    Then Email notification "Screening Delegation" with following values is received by "Assignee" user
      | <WC1_Record_Name> | 1 |
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                      | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Assignee_AT_FN Assignee_AT_LN | For Review    | TODAY+0  | THIRD-PARTY | VIEW        |

  @C33476721
  Scenario: C33476721: [Assignee] Third-party Onboarding - World Check Screening Activity - Edit Activity Status is enabled when no delegated task is added
    Given User logs into RDDC as "Assignee"
    When User creates third-party "belizeWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    And User approves all activities
    And User clicks Edit button for Activity
    Then Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Done        |
    When User selects activity status "In Progress"
    And User selects activity assessment
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Save' activity button
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information modal is displayed with details
      | Status      |
      | In Progress |

  @C33476723
  Scenario: C33476723: [Assignee] Third-party Onboarding - World Check Screening Activity - Update Activity status to Done when all review tasks are Reviewed
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User clicks Start Onboarding for third-party
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    And User approves all activities
    And User clicks Edit button for Activity
    And User selects activity assignee "Admin_AT_FN Admin_AT_LN"
    And User clicks 'Save' activity button
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    And User clicks Edit button for Activity
    Then Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Waiting     |
      | Done        |
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information modal is displayed with details
      | Status    |
      | Completed |

  @C33888665
  Scenario: C33888665: Third-party Onboarding - Stop Onboarding - with Reviewed Record
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    And User clicks on 2 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Screening Results' screening profile button
    And User clicks "New Component" component tab
    And User clicks on "OneSatisfiedApprovalRule" activity
    Then Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Admin_AT_FN Admin_AT_LN | Reviewed      | TODAY+0  | THIRD-PARTY | ACTIONS     |
      | recordName2 | recordId2    | Admin_AT_FN Admin_AT_LN | For Review    | TODAY+0  | THIRD-PARTY | REVIEW      |
    When User clicks Back button to return from Activity modal
    And User clicks "Stop Onboarding" third-party button
    Then Message is displayed on confirmation window
      | Are you sure you want to stop the Onboarding Process? This cannot be undone and you will have to restart the Onboarding Process again. |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "NEW"
    And Third-party's element "Start Onboarding" should be shown
    When User clicks on 1 number screening record
    Then Screening profile's Review Status is "Reviewed"
    And Text of screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    When User clicks on the 'Screening Results' screening profile button
    And User clicks on 2 number screening record
    Then Screening profile's Reviewer Details is not displayed

  @C33888666
  Scenario: C33888666: Third-party Onboarding - Decline Onboarding - with Reviewed Record
    Given User logs into RDDC as "Admin"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    And User clicks on 2 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Screening Results' screening profile button
    And User clicks "Decline Onboarding" third-party button
    Then Message is displayed on confirmation window
      | Are you sure you want to decline the Onboarding Process? This cannot be undone and you will have to restart the Onboarding Process again. |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "ONBOARDING DENIED"
    And Third-party's element "Start Onboarding" should be shown
    When User clicks on 1 number screening record
    Then Screening profile's Review Status is "Reviewed"
    And Text of screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    When User clicks on the 'Screening Results' screening profile button
    And User clicks on 2 number screening record
    Then Screening profile's Reviewer Details is not displayed
