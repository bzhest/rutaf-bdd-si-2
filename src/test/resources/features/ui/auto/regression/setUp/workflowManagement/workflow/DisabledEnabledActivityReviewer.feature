@ui @full_regression @workflow_management
Feature: Disabled/Enabled Reviewer tab for Activity

  As a Supplier Integrity Administrator Creating an Onboarding Workflow
  I want to be able to add Reviewers for activities
  So that the completed activities can be reviewed to make sure
  that they are the right ones before proceeding to the next set of activities

  @C35859581
  Scenario: C35859581: [Workflows] - Adding Reviewer to Activities
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User clicks +Add Activity button
    Then Activity Type drop-down value makes Add Reviewer tab in state
      | Approve Onboarding                   | disabled |
      | Decline Onboarding                   | disabled |
      | Assign Questionnaire                 | disabled |
      | World Check Screening                | disabled |
      | Request for Due Diligence Activity   | enabled  |
      | Order Due Diligence Report           | enabled  |
      | World Check Ongoing Screening Update | enabled  |
      | Assessment                           | enabled  |
