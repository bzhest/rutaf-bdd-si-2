@ui @core_regression @workflow_management
Feature: Editing Existing Workflows

  As a Supplier Integrity Administrator
  I want to be able to Edit Workflows
  So that I can Edit the general workflow details that need to be updated

  Background:
    Given User logs into RDDC as "Admin"
    And User navigates to 'Workflow Management' block 'Workflow' section
    And Workflow Table is displayed
    And User clicks Add Workflow button
    And Workflow Create Workflow page is displayed
    And User creates new Workflow "Onboarding Workflow Low Risk Scoring" with Activity "Assign Questionnaire"

  @C35776954
  @onlySingleThread
  Scenario: C35776954: Workflow Management - Workflow - Edit Workflow General Details from Workflow List
    When User clicks 'Edit' button for created Workflow
    Then Workflow "Workflow Name" input field is required
    And Workflow "Workflow Type" input field is required
    And Workflow "Description" input field is not required
    And Workflow Active checkbox is ticked
    And Workflow page is displayed with expected details
    And Workflow button "Cancel" should be displayed
    And Workflow button "Next" should be displayed
    And Workflow Group drop down contains all active workflow groups
    And Risk Scoring Range drop down contains all ranges sorted in Ascending order
    And Workflow Type drop down contains the following options
      | Renewal    |
      | Onboarding |
    When User clicks workflow button "Cancel"
    Then Workflow Table is displayed
    When User clicks 'Edit' button for created Workflow
    Then Workflow "Workflow Name" input field is required
    And Workflow "Workflow Type" input field is required
    And Workflow "Description" input field is not required
    And Workflow Active checkbox is ticked
    And Workflow page is displayed with expected details
    And Workflow button "Cancel" should be displayed
    And Workflow button "Next" should be displayed
    And Workflow Type drop down contains the following options
      | Renewal    |
      | Onboarding |
    And Workflow Group drop down contains all active workflow groups
    And Risk Scoring Range drop down contains all ranges sorted in Ascending order
    When User clears workflow "Workflow Group" input field
    And User clears workflow "Risk Scoring Range" input field
    And User clicks workflow button "Next"
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Risk Scoring Range" field
    And Error message "This field is required" in red color is displayed near "Workflow Group" field
    When User clears workflow "Workflow Type" input field
    And User clears workflow "Workflow Name" input field
    And User clicks workflow button "Next"
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Workflow Name" field
    And Error message "This field is required" in red color is displayed near "Workflow Type" field
    When User updates Workflow Name with "AUTO_TEST_Workflow_"
    And User fills in Workflow Type "Onboarding"
    And User selects Risk scoring range and Workflow group combination of existing "Workflow - do not edit" workflow
    And User clicks workflow button "Next"
    Then Alert Icon is displayed with text
      | Cannot save! Workflow group and risk scoring range already exists. |
    And Workflow "Workflow Name" input field contains value "workflowName"
    And Workflow "Workflow Type" input field contains value "Onboarding"
    And Error message "Risk scoring range already exists" in red color is displayed near "Risk Scoring Range" field
    And Error message "Workflow group already exists" in red color is displayed near "Workflow Group" field

  @C35777842
  @onlySingleThread
  Scenario: C35777842: Workflow Management - Workflow - Edit Workflow General Details from View Workflow Details
    When User clicks on created Workflow
    Then Workflow overview is displayed
    And Workflow page is displayed with expected details
    And Workflow button "Next" should be displayed
    And Workflow button "Cancel" should be displayed
    When User clicks Edit workflow button
    Then Workflow button "Cancel" should be displayed
    And Workflow button "Next" should be displayed
    And Workflow "Workflow Name" input field is required
    And Workflow "Workflow Type" input field is required
    And Workflow "Description" input field is not required
    And Workflow Active checkbox is ticked
    And Workflow page is displayed with expected details
    And Workflow button "Cancel" should be displayed
    And Workflow button "Next" should be displayed
    And Workflow Group drop down contains all active workflow groups
    And Risk Scoring Range drop down contains all ranges sorted in Ascending order
    And Workflow Type drop down contains the following options
      | Renewal    |
      | Onboarding |
    When User clicks workflow button "Cancel"
    Then Workflow Table is displayed
    When User clicks on created Workflow
    Then Workflow overview is displayed
    And Workflow page is displayed with expected details
    When User clicks Edit workflow button
    Then Workflow button "Cancel" should be displayed
    And Workflow button "Next" should be displayed
    And Workflow "Workflow Name" input field is required
    And Workflow "Workflow Type" input field is required
    And Workflow "Description" input field is not required
    And Workflow Active checkbox is ticked
    And Workflow page is displayed with expected details
    And Workflow button "Cancel" should be displayed
    And Workflow button "Next" should be displayed
    And Workflow Type drop down contains the following options
      | Renewal    |
      | Onboarding |
    And Workflow Group drop down contains all active workflow groups
    And Risk Scoring Range drop down contains all ranges sorted in Ascending order
    When User clears workflow "Workflow Group" input field
    And User clears workflow "Risk Scoring Range" input field
    And User clicks workflow button "Next"
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Risk Scoring Range" field
    And Error message "This field is required" in red color is displayed near "Workflow Group" field
    When User clears workflow "Workflow Type" input field
    And User clears workflow "Workflow Name" input field
    And User clicks workflow button "Next"
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near "Workflow Name" field
    And Error message "This field is required" in red color is displayed near "Workflow Type" field
    When User updates Workflow Name with "AUTO_TEST_Workflow_"
    And User fills in Workflow Type "Onboarding"
    And User selects Risk scoring range and Workflow group combination of existing "Workflow - do not edit" workflow
    And User clicks workflow button "Next"
    Then Alert Icon is displayed with text
      | Cannot save! Workflow group and risk scoring range already exists |
    And Workflow "Workflow Name" input field contains value "workflowName"
    And Workflow "Workflow Type" input field contains value "Onboarding"
    And Error message "Risk scoring range already exists" in red color is displayed near "Risk Scoring Range" field
    And Error message "Workflow group already exists" in red color is displayed near "Workflow Group" field
