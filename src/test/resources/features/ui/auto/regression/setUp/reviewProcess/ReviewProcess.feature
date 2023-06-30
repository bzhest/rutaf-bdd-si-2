@ui @full_regression @review_process
Feature: Create Review Process

  As a Supplier Integrity Administrator
  I want to be able to create Review Processes
  So that the System Administrators can just select an Review Process when configuring the Workflow Activities

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Review Process page
    And User clicks 'Add Review Process' button

  @C35984944
  @core_regression
  Scenario: C35984944: Supplier - Review Process Setup - Add Review Process
    Then Review process modal should have Main block fields
      | Review Process Name | Description | Active |
    And Review process modal should have Default Reviewer block fields
      | Reviewer |
    And Review process modal should have fields for Reviewer block "1"
      | Add Rules For | Rule Value | Reviewer | Reviewer Method |
    And Modal 'Add review process' button "Save" is displayed
    And Modal 'Add review process' button "Cancel" is displayed
    When User clicks 'Add Review Process' "Save" button
    Then Alert Icon is displayed with text
      | Cannot save. Please complete the required fields. |
    When User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User waits for progress bar to disappear from page
    And User selects "Max" items per page
    And User should see created Review Process on the top of the list
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Cancel" button
    Then ADD REVIEW PROCESS Review Process page is disappeared
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with already created Review Process name with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    Then Review Process Toast message is displayed with text
      | Cannot save. toBeReplaced already exists |

  @C35997359
  @core_regression
  Scenario: C35997359: Supplier - Review Process Setup - Add Review Process - Setup rule to trigger Review
    When User fills Add Review Process form with "Review Process with Third-party Region" data
    And User fills in Review Process Add Rule For input "Third-party Region" data
    And User clicks 'Add Review Process' "Save" button
    Then Error message 'This field is required' is displayed for the next fields on Review Process form
      | Third-party Region |
      | Reviewer           |
    And Alert Icon is displayed with text
      | Cannot save                          |
      | Please complete the required fields. |
    When User clicks 'Add Review Process' "Cancel" button
    And User clicks 'Add Review Process' button
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User fills Add Review Process form with "Review Process with Activity owner" data
    Then Add Review button should be enabled
    When User clicks Review Process form Add Reviewer button
    Then Review process modal should have fields for Reviewer block "2"
      | Add Rules For | Rule Value | Reviewer | Reviewer Method |
    When User removes Reviewers block "2"
    Then Review process modal should not have fields for Reviewer block "2"
      | Add Rules For | Rule Value | Reviewer | Reviewer Method |
    When User clicks 'Add Review Process' "Save" button
    And User waits for progress bar to disappear from page
    And User selects "Max" items per page
    And User should see created Review Process on the top of the list

  @C36021955
  @core_regression
  @onlySingleThread
  Scenario: C36021955: Supplier - Review Process Setup - Edit Review Process from Overview Page
    Then Review process modal should have Main block fields
      | Review Process Name | Description | Active |
    And Review process modal should have Default Reviewer block fields
      | Reviewer |
    And Review process modal should have fields for Reviewer block "1"
      | Add Rules For | Rule Value | Reviewer | Reviewer Method |
    And Modal 'Add review process' button "Save" is displayed
    And Modal 'Add review process' button "Cancel" is displayed
    When User clicks 'Add Review Process' "Save" button
    Then Alert Icon is displayed with text
      | Cannot save                          |
      | Please complete the required fields. |
    When User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User waits for progress bar to disappear from page
    And User selects "Max" items per page
    Then User should see created Review Process by name
    When User clicks "Edit" for created Review Process
    Then Edit Review Process page is displayed
    When User clears Review Process required fields
    And User fills Add Review Process form with already created Review Process name with "Review Process with Third-party Region" data
    And User clicks 'Add Review Process' "Save" button
    Then Review Process Toast message is displayed with text
      | Cannot save. Auto Review Process already exists |
    When User clicks 'Add Review Process' "Cancel" button
    And User waits for progress bar to disappear from page
    And User clicks "Edit" for created Review Process
    And User clears Review Process required fields
    And User clicks 'Add Review Process' "Save" button
    Then Alert Icon is displayed with text
      | Cannot save. Please complete the required fields. |
    And Error message 'This field is required' is displayed for the next fields on Review Process form
      | Review Process Name |
      | Reviewer            |
      | Activity Owner      |
    When User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Third-party Region" data
    And User clicks 'Add Review Process' "Save" button
    Then Review Process Toast message is displayed with text
      | Success! toBeReplaced has been updated |
    And User waits for progress bar to disappear from page
    And User selects "Max" items per page
    Then User should see created Review Process by name
    When User clicks "Edit" for created Review Process
    Then Edit Review Process page is displayed
    When User fills Add Review Process form with already created Review Process name with "Review Process with Third-party Region" data
    And User clicks 'Add Review Process' "Cancel" button
    And User selects "Max" items per page
    Then User should not see created Review Process by "newReviewName" name reference

  @C36023670
  @onlySingleThread
  Scenario: C36023670: Supplier - Review Process Setup - Edit Review Process from Details Page
    When User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User selects "Max" items per page
    And User clicks "View" for created Review Process
    And User clicks Review Process Edit button
    Then Edit Review Process page is displayed
    And Review Process fields are enabled
      | Review Process Name |
      | Description         |
      | Active              |
      | Reviewer            |
      | Add Rules For       |
      | Activity Owner      |
      | Reviewer            |
      | Reviewer Method     |
    And Modal 'Edit review process' button "Save" is displayed
    And Modal 'Edit review process' button "Cancel" is displayed
    When User fills in Review Process Name "Auto Review Process"
    And User clicks 'Edit Review Process' "Save" button
    Then Review Process Toast message is displayed with text
      | Cannot save. Auto Review Process already exists |
    When User clears Review Process required fields
    And User clicks 'Add Review Process' "Save" button
    Then Alert Icon is displayed with text
      | Cannot save                          |
      | Please complete the required fields. |
    And Error message 'This field is required' is displayed for the next fields on Review Process form
      | Review Process Name |
      | Reviewer            |
      | Activity Owner      |
    When User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Third-party Region" data
    And User clicks 'Add Review Process' "Save" button
    Then Review Process Toast message is displayed with text
      | Success! toBeReplaced has been updated |
    When User selects "Max" items per page
    And User waits for progress bar to disappear from page
    Then User should see created Review Process by name
    When User clicks "Edit" for created Review Process
    Then Edit Review Process page is displayed
    When User fills Add Review Process form with already created Review Process name with "Review Process with Third-party Region" data
    And User clicks 'Add Review Process' "Cancel" button
    And User selects "Max" items per page
    Then User shouldn't find Review Process by description

  @C36052123
  Scenario: C36052123: Supplier - Review Process Setup - Deactivating a Review Process
    When User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User selects "Max" items per page
    Then User should see created Review Process by name
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "Assessment Activity" details
    And User clicks Activity "Add Reviewer" tab
    And User clicks 'Add Existing Review Process' button
    And User searches item by "reviewProcessName" keyword
    And User selects Review Process with name "reviewProcessName"
    And User clicks workflow button "Select"
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User waits for progress bar to disappear from page
    And User navigates to Review Process page
    And User selects "Max" items per page
    And User clicks "View" for created Review Process
    And User clicks Review Process Edit button
    Then Edit Review Process page is displayed
    And Review Process fields are enabled
      | Review Process Name |
      | Description         |
      | Active              |
      | Reviewer            |
      | Add Rules For       |
      | Activity Owner      |
      | Reviewer            |
      | Reviewer Method     |
    And Modal 'Edit review process' button "Save" is displayed
    And Modal 'Edit review process' button "Cancel" is displayed
    When User clicks Review Process "unchecked" Active checkbox
    And User clicks 'Edit Review Process' "Save" button
    And User selects "Max" items per page
    And User waits for progress bar to disappear from page
    Then Created Review Process status is "Inactive"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks 'Edit' button for created Workflow
    And User clicks workflow button "Next"
    And User clicks "edit" "Assessment Activity" activity
    And User clicks Activity "Edit Reviewer" tab
    And User clicks 'Add Existing Review Process' button
    Then Review Process table is displayed
    When User searches item by "reviewProcessName" keyword
    Then No Review Process Available message is displayed

  @C36052181
  @onlySingleThread
  Scenario: C36052181: Supplier - Review Process Setup - Activating a Review Process
    When User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User selects "Max" items per page
    And User clicks "Edit" for created Review Process
    And User clicks Review Process "unchecked" Active checkbox
    And User clicks 'Edit Review Process' "Save" button
    And User waits for progress bar to disappear from page
    And User clicks "View" for created Review Process
    And User clicks Review Process Edit button
    Then Edit Review Process page is displayed
    And Review Process fields are enabled
      | Review Process Name |
      | Description         |
      | Active              |
      | Reviewer            |
      | Add Rules For       |
      | Activity Owner      |
      | Reviewer            |
      | Reviewer Method     |
    And Modal 'Edit review process' button "Save" is displayed
    And Modal 'Edit review process' button "Cancel" is displayed
    When User clicks Review Process "checked" Active checkbox
    And User clicks 'Edit Review Process' "Save" button
    And User selects "Max" items per page
    Then Created Review Process status is "Active"
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "Assessment Activity" details
    And User clicks Activity "Add Reviewer" tab
    And User clicks 'Add Existing Review Process' button
    And User searches item by "reviewProcessName" keyword
    Then Search item "reviewProcessName" is shown

  @C36052182
  Scenario: C36052182: Supplier - Review Process Setup - Delete Review Proccess
    When User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User selects "Max" items per page
    And User clicks "Delete" for created Review Process
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Review Process? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    And User selects "Max" items per page
    Then User should see created Review Process by name
    When User clicks "Delete" for created Review Process
    And User clicks Delete button on confirmation window
    And User selects "Max" items per page
    Then User should not see created Review Process by "reviewProcessName" name reference
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
