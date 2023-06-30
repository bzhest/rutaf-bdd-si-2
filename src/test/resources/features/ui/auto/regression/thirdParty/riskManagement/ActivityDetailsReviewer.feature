@ui @full_regression @suppliers

Feature: Risk Management Overview - Display Reviewers in Activity Details
  As a Compliance Group User
  I want the system to save the workflow details triggered for Third-Parties
  So that I can have a record of the workflows for future references

  Background:
    Given User logs into RDDC as "Assignee"
    And User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks +Add Activity button
    And User fills in Activity "Request for Due Diligence Activity" details
    And User clicks Activity "Add Approver" tab
    And User clicks 'Add Existing Approval Process' button
    And User selects approval process with name "Automation Approval Process"
    And User click approval process button "Select"
    And User clicks Activity "Add Reviewer" tab
    And User selects "Assignee_AT_FN Assignee_AT_LN" value for Default Reviewer
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "Request for Due Diligence" activity
    And User approves all activities
    And User clicks Back button to return from Activity modal
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button

  @C35804325
  Scenario: C35804325: Supplier - Risk Management Overview - Display Reviewers in Activity Details - Pending/Reviewed
    When User waits for progress bar to disappear from page
    And User clicks on Risk Management tab
    And User clicks workflow with name "toBeReplaced" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User clicks "Request for Due Diligence" Activity details on Workflow History page
    Then Workflow History Activity values should be displayed
      | Reviewers | Assignee_AT_FN Assignee_AT_LN |
    And Workflow History Activity Reviewer "Assignee_AT_FN Assignee_AT_LN" Pending 'Check' icon is displayed
    And Workflow History Activity Reviewer Pending 'Check' icon is grey
    When User hovers over Workflow History Activity Reviewer "Assignee_AT_FN Assignee_AT_LN" Pending 'Check' icon
    Then Reviewer tooltip with text "Pending" appears
    When User clicks Workflow History arrow button
    And User clicks on Third-party Information tab
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    And User reviews all activities
    And User clicks on Risk Management tab
    And User clicks workflow with name "toBeReplaced" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User clicks "Request for Due Diligence" Activity details on Workflow History page
    Then Workflow History Activity Reviewer "Assignee_AT_FN Assignee_AT_LN" Pending 'Check' icon is displayed
    And Workflow History Activity Reviewer Pending 'Check' icon is grey
    When User hovers over Workflow History Activity Reviewer "Assignee_AT_FN Assignee_AT_LN" Pending 'Check' icon
    Then Reviewer tooltip with text "Pending" appears
    When User refreshes page
    Then Workflow History Activity Reviewer "Assignee_AT_FN Assignee_AT_LN" Reviewed 'Check' icon is displayed
    And Workflow History Activity Reviewer Reviewed 'Check' icon is green
    When User hovers over Workflow History Activity Reviewer "Assignee_AT_FN Assignee_AT_LN" Reviewed 'Check' icon
    Then Reviewer tooltip with text "Reviewed" appears

  @C35804325
  Scenario: C35804325: Supplier - Risk Management Overview - Display Reviewers in Activity Details - Reassigned/Rejected
    When User clicks on "Request for Due Diligence" activity
    And User clicks "Reassign" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    And User selects "Admin_AT_FN Admin_AT_LN" reviewer user
    And User clicks on Risk Management tab
    And User clicks workflow with name "toBeReplaced" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User clicks "Request for Due Diligence" Activity details on Workflow History page
    Then Workflow History Activity values should be displayed
      | Reviewers | Assignee_AT_FN Assignee_AT_LN |
    And Workflow History Activity Reviewer "Assignee_AT_FN Assignee_AT_LN" Reassigned 'Check' icon is displayed
    And Workflow History Activity Reviewer Pending 'Check' icon is grey
    When User hovers over Workflow History Activity Reviewer "Assignee_AT_FN Assignee_AT_LN" Reassigned 'Check' icon
    Then Reviewer tooltip with text "Reassigned" appears
    When User clicks Workflow History arrow button
    And User clicks on Third-party Information tab
    And User clicks on "Request for Due Diligence" activity
    And User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Reject button on confirmation window
    Then Confirmation window is disappeared
    When User clicks on Risk Management tab
    And User clicks workflow with name "toBeReplaced" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User clicks "Request for Due Diligence" Activity details on Workflow History page
    Then Workflow History Activity Reviewer "Assignee_AT_FN Assignee_AT_LN" Reassigned 'Check' icon is displayed
    And Workflow History Activity Reviewer Pending 'Check' icon is grey
    When User hovers over Workflow History Activity Reviewer "Assignee_AT_FN Assignee_AT_LN" Reassigned 'Check' icon
    Then Reviewer tooltip with text "Reassigned" appears
    When User refreshes page
    Then Workflow History Activity Reviewer "Admin_AT_FN Admin_AT_LN" Rejected 'Check' icon is displayed
    And Workflow History Activity Reviewer Rejected 'Check' icon is red
    When User hovers over Workflow History Activity Reviewer "Admin_AT_FN Admin_AT_LN" Rejected 'Check' icon
    Then Reviewer tooltip with text "Rejected" appears
