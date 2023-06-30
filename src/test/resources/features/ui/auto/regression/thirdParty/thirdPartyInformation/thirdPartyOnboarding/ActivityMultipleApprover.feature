@ui @workflow_completion
Feature: Assign Activity Approver based on rules

  As a Supplier Integrity User Onboarding a Supplier
  I want the right Approvers to be assigned to triggered activities
  So that I am sure that the activities are reviewed by the right users

  Background:
    Given User logs into RDDC as "Admin"

  @C36053069
  @full_regression
  Scenario: C36053069 [Activity Approval] Multiple Approver Rules set with no Rule satisfied
    When User creates third-party "belizeWithApprover" via API and open it
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks 'Edit' button on created third-party
    Then Overall Risk Score is in range of Workflow Risk Score values - 1.6 to 2.5
    When User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "NoSatisfiedApprovalRule" activity
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update | Action                  | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Approve,Reject,Reassign | Pending |

  @C36066481
  @core_regression
  Scenario: C36066481 [Activity Approval] Multiple Approver Rules set with multiple Rules satisfied
    When User creates third-party "belizeWithApproverWithIndustryType"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks 'Edit' button on created third-party
    Then Overall Risk Score is in range of Workflow Risk Score values - 1.6 to 2.5
    When User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "TwoApprovalRulesSatisfiedInSequence" activity
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                   | Last Update | Action                  | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Approve,Reject,Reassign | Pending |

  @C36053066
  @core_regression
  Scenario: C36053066 [Activity Approval] Multiple Approver Rules set for Activity with one Approver Rule satisfied
    When User creates third-party "belizeWithApproverWithIndustryType"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "NoSatisfiedApprovalRule" activity
    Then Activity Information Approvers table should contain the following approvers
      | Assigned To                                   | Last Update | Action                  | Status  |
      | Questionnaire_Approver_AT_FN Quest_Appr_AT_LN |             | Approve,Reject,Reassign | Pending |
    When User logs into RDDC as "Approver"
    And User clicks 'Items To Approve' widget
    Then Assigned Activity for third-party is displayed