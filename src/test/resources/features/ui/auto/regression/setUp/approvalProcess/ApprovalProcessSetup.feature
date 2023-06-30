@ui @full_regression @approvalProcess
Feature: Approval Process Setup

  As a Supplier Integrity Administrator
  I want to designate Approvers to Approval Processes based on the Third-Party
  So that So that the approval of the activities can be automatically assigned accordingly

  @C35849788
  @core_regression
  Scenario: C35849788: Supplier - Approval Process Setup - Add Approval Process - Allow user to setup rule to trigger Approver
    Given User logs into RDDC as "Admin"
    And User clicks Set Up option
    When User clicks Approval Process in Set Up menu
    And User clicks Add Approval Process button
    Then Approval Process "ADD APPROVAL PROCESS" modal is displayed
    When User fills in Approval Process Name with "Auto Test Approval Process"
    And User selects in Approval Process Default Approver dropdown value "Admin_AT_FN Admin_AT_LN"
    And User selects in Approval Process Add Rules For dropdown value "Third-party Region" for rule with number 1
    Then Approval process drop-down "Third-party Region" becomes required
    And Approval process drop-down "Approver" becomes required
    When User selects rule value "Americas" for rule "Third-party Region" with number 1
    And User selects in Approval Process Approver dropdown value "Admin_AT_FN Admin_AT_LN" for rule with number 1
    Then Approval Process Add button becomes enabled
    When User clicks Approval Process Add button
    Then Approval Process "Add Rules For" field for rule with number 2 is displayed
    And Approval Process "Rule Value" field for rule with number 2 is displayed
    And Approval Process "Approver" field for rule with number 2 is displayed
    And Approval Process "Approver Method" field for rule with number 2 is displayed
    And Approval Process Remove button is displayed for rule with number 1 is displayed
    And Approval Process Remove button is displayed for rule with number 2 is displayed
    When User clicks Approval Process Remove button for rule with number 2
    Then Approval Rule with number 2 is not displayed
    When User clicks Approval Process "Save" button
    Then Added Approval Process is displayed on top of Overview table

  @C35851445
  @RMS-12583
  @core_regression
  Scenario: C35851445: Supplier - Approval Process Setup - Edit Approval Process from Overview Page
    Given User logs into RDDC as "Admin"
    And User creates Approval Process with "approval process with required fields" via API
    And User clicks Set Up option
    And User clicks Approval Process in Set Up menu
#  TODO Uncomment when RMS-12583 is fixed
#    When User clicks Edit button for created Approval Process
#    Then Approval Process "Edit Approval Process" modal is displayed
#    When User fills in Approval Process Name with "alreadyExistingName"
#    And User clicks Approval Process "Save" button
#    Then Alert Icon for Approval Process is displayed with text
#      | Cannot Save       |
#      | %s already exists |
    And User clicks Edit button for created Approval Process
    Then Approval Process "Edit" modal is displayed
    When User clears Approval Process Default Approver dropdown
    And User clicks Approval Process "Save" button
    Then Alert Icon is displayed with text
      | Cannot save                          |
      | Please complete the required fields. |
    And Error message "This field is required" in red color is displayed near "Approver" approval process field
    When User selects in Approval Process Default Approver dropdown value "Admin_AT_FN Admin_AT_LN"
    And User clicks Approval Process "Save" button
    Then Alert Icon is displayed with text
      | Success!                             |
      | approvalProcessName has been updated |
    When User waits for progress bar to disappear from page
    And User clicks Edit button for created Approval Process
    Then Approval Process "Edit" modal is displayed
    When User fills in Approval Process Name with "Cancel Update Approval Process Name"
    And User clicks Approval Process "Cancel" button
    Then Approval Process "added" is displayed in Overview table
    And Approval Process "updated" is not displayed in Overview table

  @C35811508
  @RMS-12583
  Scenario: C35811508: Supplier - Approval Process Setup - Add Approval Process
    Given User logs into RDDC as "Admin"
    And User clicks Set Up option
    And User clicks Approval Process in Set Up menu
    And User clicks Add Approval Process button
    Then Approval Process "ADD APPROVAL PROCESS" modal is displayed
    And Activity process record should have next fields
      | Approval Process Name | Description | Approver | Add Rules For | Rule Value |
    And Approval Process page button "Save" should be visible
    And Approval Process page button "Cancel" should be visible
    When User clicks Approval Process "Save" button
    Then Alert Icon is displayed with text
      | Cannot save                          |
      | Please complete the required fields. |
    And Error message "This field is required" in red color is displayed near "Approval Process Name" approval process field
    And Error message "This field is required" in red color is displayed near "Approver" approval process field
#    TODO - uncomment when RMS-12583 will be fixed
#    When User fills in Approval Process Name with "alreadyExistingName"
#    And User selects in Approval Process Default Approver dropdown value "Admin_AT_FN Admin_AT_LN"
#    And User clicks Approval Process "Save" button
#    Then Alert Icon for Approval Process is displayed with text
#      | Cannot Save       |
#      | %s already exists |
#    And Error message "%s already exists" in red color is displayed near "Approval Process Name" approval process field
    When User fills in Approval Process Name with "toBeReplaced"
    And User clicks Approval Process "Cancel" button
    And Approval Process item modal window should be closed
    And Approval Process item should not be saved
    And User clicks Add Approval Process button
    And User fills in Approval Process Name with "toBeReplaced"
    And User selects in Approval Process Default Approver dropdown value "Admin_AT_FN Admin_AT_LN"
    And User clicks Approval Process "Save" button
    Then Added Approval Process is displayed on top of Overview table
    Then Approval Process "added" is displayed in Overview table

  @C35871724
  @RMS-12583
  Scenario: C35871724: Supplier - Approval Process Setup - Edit Approval Process from Details Page
    Given User logs into RDDC as "Admin"
    When User creates Approval Process with "approval process with required fields" via API
    And User clicks Set Up option
    And User clicks Approval Process in Set Up menu
    And User selects "10" items per page
    And User clicks on Approval process with name "toBeReplaced" on overview page
    And User clicks Edit button on Approval Process details page
    Then Approval Process "Edit" modal is displayed
    When User clears Approval Process Default Approver dropdown
    And User clicks Approval Process "Save" button
    Then Alert Icon is displayed with text
      | Cannot save                          |
      | Please complete the required fields. |
    And Error message "This field is required" in red color is displayed near "Approver" approval process field
    When User fills in Approval Process Name with "Cancel Update Approval Process Name"
    And User clicks Approval Process "Cancel" button
    And Approval Process item modal window should be closed
    And Approval Process "updated" is not displayed in Overview table
#    TODO uncomment when RMS-12583 will be fixed
#    When User clicks on Approval process with name "toBeReplaced" on overview page
#    And User clicks Edit button on Approval Process details page
#    Then Approval Process "Edit Approval Process" modal is displayed
#    When User fills in Approval Process Name with "alreadyExistingName"
#    And User clicks Approval Process "Save" button
#    Then Alert Icon for Approval Process is displayed with text
#      | Cannot Save       |
#      | %s already exists |
#    And Error message "%s already exists" in red color is displayed near "Approval Process Name" approval process field
    And User clicks on Approval process with name "toBeReplaced" on overview page
    And User clicks Edit button on Approval Process details page
    And User fills in Approval Process Name with "toBeReplaced"
    And User selects in Approval Process Default Approver dropdown value "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Approval Process "Save" button
    Then Alert Icon is displayed with text
      | Success!                             |
      | approvalProcessName has been updated |
    When User selects "10" items per page
    Then Approval Process "added" is displayed in Overview table
    When User clicks on Approval process with name "toBeReplaced" on overview page
    And Approval Process display page is displayed with values
      | Approval Process Name | Default Approver              |
      | toBeReplaced          | Assignee_AT_FN Assignee_AT_LN |

  @C35881924
  Scenario: C35881924: Supplier - Approval Process Setup - Delete Approval Process
    Given User logs into RDDC as "Assignee"
    When User creates Approval Process with "approval process with required fields" via API
    And User clicks Set Up option
    And User clicks Approval Process in Set Up menu
    And User selects "10" items per page
    And User clicks 'Delete' button for Approval Process with name "toBeReplaced"
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Approval Process? |
      | This change cannot be undone.                          |
    When User clicks Cancel button on confirmation window
    Then Approval Process "added" is displayed in Overview table
    And User clicks 'Delete' button for Approval Process with name "toBeReplaced"
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Approval Process? |
      | This change cannot be undone.                          |
    When User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success!                             |
      | approvalProcessName has been deleted |
    And Approval Process "added" is not displayed in Overview table
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User clicks +Add Activity button
    And User clicks Activity "Add Approver" tab
    And User clicks 'Add Existing Approval Process' button
    And User searches approval process with name "approvalProcessName"
    Then No Approval Process Available message is displayed

  @C35916034
  Scenario: C35916034: Supplier - Approval Process Setup - Deactivating an Approval Process
    Given User logs into RDDC as "Admin"
    When User creates Approval Process with "approval process with required fields" via API
    And User clicks Set Up option
    And User clicks Approval Process in Set Up menu
    And User selects "10" items per page
    And User clicks on Approval process with name "toBeReplaced" on overview page
    And User clicks Edit button on Approval Process details page
    And User unchecks 'Active' checkbox on Approval Process page
    And User clicks Approval Process "Save" button
    And User selects "10" items per page
    Then Approval Process is displayed in Overview table with data
      | Approval Process Name | Description | Status   |
      | toBeReplaced          |             | Inactive |
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User clicks +Add Activity button
    And User clicks Activity "Add Approver" tab
    And User clicks 'Add Existing Approval Process' button
    And User searches approval process with name "approvalProcessName"
    Then No Approval Process Available message is displayed

  @C35916050
  Scenario: C35916050: Supplier - Approval Process Setup - Activating an Approval Process
    Given User logs into RDDC as "Admin"
    When User creates Approval Process with "approval process with all fields inactive" via API
    And User clicks Set Up option
    And User clicks Approval Process in Set Up menu
    And User selects "10" items per page
    And User clicks on Approval process with name "toBeReplaced" on overview page
    And User clicks Edit button on Approval Process details page
    And User checks 'Active' checkbox on Approval Process page
    And User clicks Approval Process "Save" button
    And User selects "10" items per page
    Then Approval Process is displayed in Overview table with data
      | Approval Process Name | Description | Status |
      | toBeReplaced          |             | Active |
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User clicks +Add Activity button
    And User clicks Activity "Add Approver" tab
    And User clicks 'Add Existing Approval Process' button
    And User selects approval process with name "approvalProcessName"
    And User click approval process button "Select"
    Then 'Add Approver' tab is populated with values
      | Default Approver        | Add Rules For  | Activity Owner                | Approver                | Approver Method |
      | Admin_AT_FN Admin_AT_LN | Activity Owner | Assignee_AT_FN Assignee_AT_LN | Admin_AT_FN Admin_AT_LN | In Sequence     |

