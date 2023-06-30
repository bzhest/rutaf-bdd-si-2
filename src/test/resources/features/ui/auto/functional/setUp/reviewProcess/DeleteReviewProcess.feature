@ui @functional @review_process
Feature: Set Up - Review Process - Delete

  As a RDDC User with appropriate permissions
  I want to be able to delete Review Processes
  So that I can delete the Review Processes that are no longer being used


  @C45149769
  Scenario: C45149769: (Set Up/Approval Process) - User can delete Approval process
    Given User logs into RDDC as "Admin"
    When User navigates to Review Process page
    And User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity Owner Group" data
    And User clicks 'Add Review Process' "Save" button
    And User hovers "Delete" button for first Review Process
    Then Tooltip text is displayed
      | Delete |
    And First Review Process "Delete" button color is expected
    When User clicks "Delete" for created Review Process
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Review Process? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then User should see created Review Process by name
    When User clicks "Delete" for created Review Process
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Review Process has been deleted. |
    And User should not see created Review Process by "reviewProcessName" name reference
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "Assessment Activity" details
    And User clicks Activity "Add Reviewer" tab
    And User clicks 'Add Existing Review Process' button
    Then Review Process table is displayed
    When User searches item by "reviewProcessName" keyword
    Then No Review Process Available message is displayed