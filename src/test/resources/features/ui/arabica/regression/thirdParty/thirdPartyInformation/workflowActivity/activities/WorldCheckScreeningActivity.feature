@ui @core_regression @arabica
Feature: Onboarding - World Check Screening Activity

  As an RDDC user.
  I want to retain all existing screening activities when the auto-screen switches are applied
  So that I can keep current screening activities to work correctly and no interruption regarding to auto-screen switches

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API

  @C51784448
  @onlySingleThread
  Scenario: C51784448: Onboarding - World Check Screening activity - Verify  Start Onboarding Third-party with Workflow that have World Check Screening Activity when the switch, 'Enable screening when adding new third-party' is OFF
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Settings "Enable screening when adding new third-party" is turned "On"
    And Cancel button is "enabled"
    And Save button is "disabled"
    When User clicks on Enable screening when adding new third-party toggle
    Then Cancel button is "enabled"
    And Save button is "enabled"
    When User clicks save button
    Then Alert message "Success! Screening Management setting has been updated" is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User creates third-party "belizeWithApprover"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "New Component" component tab
    Then Activities table should contain the following activity
      | Name                     | Type                  | Assigned To                   | Due Date | Status      |
      | OneSatisfiedApprovalRule | World Check Screening | Assignee_AT_FN Assignee_AT_LN | TODAY+1  | Not Started |

  @C51784502
  @onlySingleThread
  Scenario: C51784502: [Internal User] Onboarding - World Check Screening activity - View World Check Screening Activity - Assigned to User when the switch, 'Enable screening when adding new third-party' is OFF
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Settings "Enable screening when adding new third-party" is turned "On"
    And Cancel button is "enabled"
    And Save button is "disabled"
    When User clicks on Enable screening when adding new third-party toggle
    Then Cancel button is "enabled"
    And Save button is "enabled"
    When User clicks save button
    Then Alert message "Success! Screening Management setting has been updated" is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
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

  @C51784503
  @onlySingleThread
  Scenario: C51784503: [Reviewer] Onboarding - World Check Screening activity - View World Check Screening Activity - User when the switch, 'Enable screening when adding new third-party' is OFF
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Settings "Enable screening when adding new third-party" is turned "On"
    And Cancel button is "enabled"
    And Save button is "disabled"
    When User clicks on Enable screening when adding new third-party toggle
    Then Cancel button is "enabled"
    And Save button is "enabled"
    When User clicks save button
    Then Alert message "Success! Screening Management setting has been updated" is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User creates third-party "belizeWithApprover"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
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