@ui @workflow_management
Feature: Adding/Editing Reviewers to Activities

  As a Supplier Integrity Administrator Creating an Onboarding Workflow
  I want to be able to add Reviewers for activities
  So that the completed activities can be reviewed to make sure that they are the right ones before proceeding to the next set of activities

  Background:
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
    And User fills in Activity "Assessment Activity" details
    And User clicks Activity "Add Reviewer" tab

  @C35881923 @C37428277
  @core_regression
  Scenario: C35881923, C37428277: [Workflows] - Adding Reviewer to Activities - additional Reviewer can be set to the workflow.
    Then Add reviewer button is disabled
    When User selects "Admin_AT_FN Admin_AT_LN" value for Default Reviewer
    And User fills "Activity Owner Division" in Reviewer details for 1 rule section
    Then Add reviewer button is enabled
    When User clicks Add reviewer button
    Then Add reviewer button is disabled
    And Rule section on position "2" is displayed
    And Rule section on position 1 has remove icon
    And Rule section on position 2 has remove icon
    When User fills "Activity Owner Group" in Reviewer details for 2 rule section
    And User clicks Add reviewer button
    Then Rule section on position "3" is displayed
    When User clicks remove icon for rule section on position 3
    Then Rule section on position 3 is disappeared
    When User clicks workflow button "Done"
    And User clicks "view" "Assessment Activity" activity
    And User clicks Activity "Reviewer" tab
    Then Reviewer overview page contains expected list details

  @C35884500
  @core_regression
  Scenario: C35884500: [Workflows] - Adding Reviewer to Activities - verify that Reviewer can be added to the Existing Activity
    When User clicks 'Add Existing Review Process' button
    Then Review Process table is displayed
    When User searches item by "Auto Review Process" keyword
    And User selects Review Process with name "Auto Review Process"
    And User clicks workflow button "Select"
    Then Reviewer edit page contains expected "Auto Review Process" details
    When User clicks workflow button "Done"
    And User clicks "view" "Assessment Activity" activity
    And User clicks Activity "Reviewer" tab
    Then Reviewer overview page contains expected "Auto Review Process" details

  @C35884515
  @full_regression
  Scenario: C35884515: [Workflows] - Adding Reviewer to Activities - overview of List of reviewal processes and Review process modal
    When User clicks 'Add Existing Review Process' button
    Then Review Process table is displayed
    And Page title is "REVIEW PROCESS"
    And Review Process table is displayed with columns
      | REVIEW PROCESS NAME | DESCRIPTION | STATUS |
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    When User selects "25" items per page
    Then Pagination option "25" is selected
    And Table displayed with up to 25 "review processes" for first page
    When User selects "50" items per page
    Then Pagination option "50" is selected
    And Table displayed with up to 50 "review processes" for first page
    When User selects "10" items per page
    Then Pagination option "10" is selected
    And Table displayed with up to 10 "review processes" for first page
    And Pagination buttons should be visible
      | first | previous | next | last |
    And Up to 5 numbered pages are displayed
    And Workflow button "Cancel" should be displayed
    And Workflow button "Select" should be displayed
    When User clicks "review processes" "last" pagination element
    Then Results "review processes" for current page is displayed
    When User clicks "review processes" "first" pagination element
    Then Results "review processes" for current page is displayed
    When User clicks "review processes" "next" pagination element
    Then Results "review processes" for current page is displayed
    When User clicks "review processes" "previous" pagination element
    Then Results "review processes" for current page is displayed
    And Pagination option "10" is selected
    When User searches review process with name "Auto Review Process"
    And User clicks first review process row
    Then Review Process modal 1 section is displayed with fields
      | Review Process Name |
      | Description         |
      | Active              |
    And Review Process modal 2 section is displayed with fields
      | Reviewer |
    And Review Process modal 3 section is displayed with fields
      | Add Rules For   |
      | Activity Owner  |
      | Reviewer        |
      | Reviewer Method |
    When User clicks workflow button "Back"
    Then Review Process table is displayed

  @C35884526 @C37428275
  @core_regression
  Scenario: C35884526, C37428275: [Workflows] - Editing Reviwer to Activities - verify that Reviwer can be edited
    When User selects "Admin_AT_FN Admin_AT_LN" value for Default Reviewer
    And User clicks Add reviewer button
    And User fills "Activity Owner Division" in Reviewer details for 1 rule section
    And User clicks workflow button "Done"
    And User clicks "edit" "Assessment Activity" activity
    Then Activity "Edit Activity" tab is displayed
    When User clicks Activity "Edit Reviewer" tab
    Then Reviewer edit page contains expected "Activity Owner Division" details
    When User clicks Add reviewer button
    And User fills "Activity Owner Group" in Reviewer details for 2 rule section
    And User clicks workflow button "Done"
    And User clicks "view" "Assessment Activity" activity
    And User clicks Activity "Reviewer" tab
    Then Reviewer overview page contains expected "Activity Owner Group" details

  @C35878699
  @full_regression
  Scenario: C35878699: [Workflows] - Adding Reviewer to Activities - page overview
    Then Default Reviewer field contains all Internal Active users in the system
    When User clicks Add reviewer button
    Then Add Reviewer tab 'Add Rules For' dropdown contains for rule with number 1
      | Activity Owner            |
      | Activity Owner Group      |
      | Activity Owner Department |
      | Activity Owner Division   |
      | Third-party Country       |
      | Third-party Region        |
      | Third-party Industry Type |
    When Close "Add Reviewer" tab 'Add Rules For' dropdown after check
    And User selects in Add Reviewer from dropdown "Add Rules For" value "Third-party Region" for rule with number 1
    And User selects in Add Reviewer from dropdown "Third-party Region" value "Americas" for rule with number 1
    And User selects in Add Reviewer from dropdown "Reviewer" value "Assignee_AT_FN Assignee_AT_LN" for rule with number 1
    And User fills "Activity Third-party Region" in Reviewer details for 1 rule section
    Then Add reviewer button is enabled

  @C35884525
  @full_regression
  Scenario: C35884525: [Workflows] - Adding Reviewer to Activities - searching of review processes in list of review processes
    When User clicks 'Add Existing Review Process' button
    Then Review Process table is displayed
    When User searches review process with name "notExisting"
    Then No Review Process Available message is displayed
    When User clicks workflow button "Cancel"
    And User clicks 'Add Existing Review Process' button
    And User searches review process with name "toBeReplaced"
    Then Searched Review Process "toBeReplaced" is shown
