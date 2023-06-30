@ui @full_regression @suppliers

Feature: Risk Management Overview - Display Approvers in Activity Details
  As a Compliance Group User
  I want the system to save the workflow details triggered for Third-Parties
  So that I can have a record of the workflows for future references

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "workflowGroupUkraineOrganizationWithApprover"

  @C35804295
  Scenario: C35804295: Third-Party - Risk Management Overview - Display Approvers in Activity Details - Pending/Approved
    When User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Organization with Approver" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User clicks "OrderDueDiligenceReport" Activity details on Workflow History page
    Then Workflow History Activity values should be displayed
      | Approvers | Admin_AT_FN Admin_AT_LN |
    And Workflow History Activity Approver "Admin_AT_FN Admin_AT_LN" Pending 'Check' icon is displayed
    And Workflow History Activity Approver Pending 'Check' icon is grey
    When User hovers over Workflow History Activity Approver "Admin_AT_FN Admin_AT_LN" Pending 'Check' icon
    Then Approver tooltip with text "Pending" appears
    When User clicks Workflow History arrow button
    And User clicks on Third-party Information tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And User approves all activities
    And User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Organization with Approver" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User clicks "OrderDueDiligenceReport" Activity details on Workflow History page
    Then Workflow History Activity Approver "Admin_AT_FN Admin_AT_LN" Pending 'Check' icon is displayed
    And Workflow History Activity Approver Pending 'Check' icon is grey
    When User hovers over Workflow History Activity Approver "Admin_AT_FN Admin_AT_LN" Pending 'Check' icon
    Then Approver tooltip with text "Pending" appears
    When User refreshes page
    Then Workflow History Activity Approver "Admin_AT_FN Admin_AT_LN" Approved 'Check' icon is displayed
    And Workflow History Activity Approver Approved 'Check' icon is green
    When User hovers over Workflow History Activity Approver "Admin_AT_FN Admin_AT_LN" Approved 'Check' icon
    Then Approver tooltip with text "Approved" appears

  @C35804295
  Scenario: C35804295: Third-Party - Risk Management Overview - Display Approvers in Activity Details - Reassigned/Rejected
    When User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And User clicks "Reassign" approve action button for "Admin_AT_FN Admin_AT_LN" user
    And User assigns approver "Assignee_AT_FN Assignee_AT_LN"
    And User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Organization with Approver" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User clicks "OrderDueDiligenceReport" Activity details on Workflow History page
    Then Workflow History Activity values should be displayed
      | Approvers | Admin_AT_FN Admin_AT_LN |
    And Workflow History Activity Approver "Admin_AT_FN Admin_AT_LN" Reassigned 'Check' icon is displayed
    And Workflow History Activity Approver Reassigned 'Check' icon is grey
    When User hovers over Workflow History Activity Approver "Admin_AT_FN Admin_AT_LN" Reassigned 'Check' icon
    Then Approver tooltip with text "Reassigned" appears
    And Workflow History Activity Approver "Assignee_AT_FN Assignee_AT_LN" Pending 'Check' icon is displayed
    And Workflow History Activity Approver Pending 'Check' icon is grey
    When User hovers over Workflow History Activity Approver "Assignee_AT_FN Assignee_AT_LN" Pending 'Check' icon
    Then Approver tooltip with text "Pending" appears
    When User logs into RDDC as "Assignee"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User waits for progress bar to disappear from page
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And User clicks "Reject" approve action button for "Assignee_AT_FN Assignee_AT_LN" user
    And User clicks Reject button on confirmation window
    Then Confirmation window is disappeared
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Organization with Approver" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User clicks "OrderDueDiligenceReport" Activity details on Workflow History page
    Then Workflow History Activity Approver "Admin_AT_FN Admin_AT_LN" Reassigned 'Check' icon is displayed
    And Workflow History Activity Approver Reassigned 'Check' icon is grey
    When User hovers over Workflow History Activity Approver "Admin_AT_FN Admin_AT_LN" Reassigned 'Check' icon
    Then Approver tooltip with text "Reassigned" appears
    And Workflow History Activity Approver "Assignee_AT_FN Assignee_AT_LN" Pending 'Check' icon is displayed
    And Workflow History Activity Approver Pending 'Check' icon is grey
    When User hovers over Workflow History Activity Approver "Assignee_AT_FN Assignee_AT_LN" Pending 'Check' icon
    Then Approver tooltip with text "Pending" appears
    When User refreshes page
    Then Workflow History Activity Approver "Assignee_AT_FN Assignee_AT_LN" Rejected 'Check' icon is displayed
    And Workflow History Activity Approver Rejected 'Check' icon is red
    When User hovers over Workflow History Activity Approver "Assignee_AT_FN Assignee_AT_LN" Rejected 'Check' icon
    Then Approver tooltip with text "Rejected" appears
