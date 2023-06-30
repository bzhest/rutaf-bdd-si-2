@ui @full_regression @alamid @workflow_management
Feature: Workflow Management - Approve and Decline Onboarding Branching Activities

  As a RDDC Administrator Creating a Onboarding/Renewing Workflow
  I want see the Approve/Decline Onboarding Activity Types are prohibited for branching

  Background:
    Given User logs into RDDC as "Admin"
    When User updates Activity Type "Approve Onboarding" with following assessments via API
      | Approved with Conditions |
    And User updates Activity Type "Decline Onboarding" with following assessments via API
      | Insufficient Requirements |
    And User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed

  @C54198981 @C54198982
  Scenario: C54198981 C54198982: Workflow - Onboarding - Branching on Approve/Decline Onboarding Activity with assessment is prohibited
    When User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Onboarding Custom TP Status"
    And User clicks Check button
    And User clicks +Add Activity button
    And User fills in Activity "Approve Onboarding Activity" details
    And User clicks workflow button "Done"
    Then Component on position 0 contains "Approve Onboarding Activity" activity assigned to "0" group
    When User clicks +Add Activity button
    And User fills in Activity "Decline Onboarding Activity" details
    And User clicks workflow button "Done"
    Then Component on position 0 contains "Decline Onboarding Activity" activity assigned to "0" group
    When User clicks workflow button "GROUPING"
    Then Workflow Grouping page is displayed
    When User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User ticks checkbox for activity on position 1
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks workflow button "BRANCHING"
    Then Branching modal is displayed
    When User clicks on "Approve Onboarding" branching modal activity
    Then Message is displayed on confirmation window
      | No available assessment |
    When User clicks Ok button on confirmation window
    Then Confirmation window is disappeared
    When User clicks on "Decline Onboarding" branching modal activity
    Then Message is displayed on confirmation window
      | No available assessment |
    When User clicks Ok button on confirmation window
    Then Confirmation window is disappeared

  @C54198983 @C54198984
  Scenario: C54198983 C54198984: Workflow - Renewing - Branching on Approve/Decline Onboarding Activity with assessment is prohibited
    When User fills in workflow details data "Renewal Workflow"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Renewing Custom TP Status"
    And User clicks Check button
    And User clicks +Add Activity button
    And User fills in Activity "Approve Onboarding Activity" details
    And User clicks workflow button "Done"
    Then Component on position 0 contains "Approve Onboarding Activity" activity assigned to "0" group
    When User clicks +Add Activity button
    And User fills in Activity "Decline Onboarding Activity" details
    And User clicks workflow button "Done"
    Then Component on position 0 contains "Decline Onboarding Activity" activity assigned to "0" group
    When User clicks workflow button "GROUPING"
    Then Workflow Grouping page is displayed
    When User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User ticks checkbox for activity on position 1
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks workflow button "BRANCHING"
    Then Branching modal is displayed
    When User clicks on "Approve Onboarding" branching modal activity
    Then Message is displayed on confirmation window
      | No available assessment |
    When User clicks Ok button on confirmation window
    Then Confirmation window is disappeared
    When User clicks on "Decline Onboarding" branching modal activity
    Then Message is displayed on confirmation window
      | No available assessment |
    When User clicks Ok button on confirmation window
    Then Confirmation window is disappeared
