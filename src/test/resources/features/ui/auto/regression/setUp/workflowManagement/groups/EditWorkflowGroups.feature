@ui @full_regression @workflow_management
Feature: Workflow Group - Edit Workflow Group

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Groups' section
    And User clicks Add Workflow Group button
    And User populates Workflow Group Name
    And User clicks "Save" button for Workflow Group
    And Workflow Group is displayed with values
      | WORKFLOW GROUP NAME | STATUS | DATE CREATED | LAST UPDATED |
      | toBeReplaced        | Active | MM/dd/YYYY   |              |

  @C35741303
  Scenario: C35741303: Workflow Management - Workflow Groups - Edit and Cancel Edit Workflow Group from List
    Then Edit icon is displayed in each row of the Workflow Group table
    When User clicks the Edit icon for created workflow group
    Then Workflow Group "Edit Group" page is displayed
    And Workflow Group Name field is required
    And Workflow Group Name field is populated
    And Workflow Group Active checkbox is ticked
    And Workflow Group page "Save" button is displayed
    And Workflow Group page "Cancel" button is displayed
    When User populates Workflow Group Name with "Auto Workflow Group"
    And User clicks "Save" button for Workflow Group
    Then Alert Icon is displayed with text
      | Cannot save! Workflow group already exists |
    When User updates Workflow Group Name
    And User clicks "Cancel" button for Workflow Group
    Then Workflow Group "Edit Group" page is not displayed
    And Workflow Group is displayed with values
      | WORKFLOW GROUP NAME | STATUS | DATE CREATED | LAST UPDATED |
      | toBeReplaced        | Active | MM/dd/YYYY   |              |
    When User clicks the Edit icon for created workflow group
    And User populates Workflow Group Name
    And User clicks "Save" button for Workflow Group
    Then Workflow Group "Edit Group" page is not displayed
    And Workflow Group is displayed with values
      | WORKFLOW GROUP NAME | STATUS | DATE CREATED | LAST UPDATED |
      | toBeReplaced        | Active | MM/dd/YYYY   | MM/dd/YYYY   |

  @C35741403
  Scenario: C35741403: Workflow Management - Workflow Groups - Edit and Cancel Edit Workflow Group from Group Details
    When User opens created workflow group
    Then Workflow Group "workflowGroupName" page is displayed
    And Workflow Group Name input field is not displayed
    And Workflow Group Active checkbox is not editable
    When User clicks "Edit" button for Workflow Group
    Then Workflow Group "Edit Group" page is displayed
    And Workflow Group Name field is required
    And Workflow Group Name field is populated
    And Workflow Group Active checkbox is ticked
    And Workflow Group page "Save" button is displayed
    And Workflow Group page "Cancel" button is displayed
    When User populates Workflow Group Name with "Auto Workflow Group"
    And User clicks "Save" button for Workflow Group
    Then Alert Icon is displayed with text
      | Cannot save! Workflow group already exists |
    When User updates Workflow Group Name
    And User clicks "Cancel" button for Workflow Group
    Then Workflow Group "Edit Group" page is not displayed
    And Workflow Group is displayed with values
      | WORKFLOW GROUP NAME | STATUS | DATE CREATED | LAST UPDATED |
      | toBeReplaced        | Active | MM/dd/YYYY   |              |
    When User opens created workflow group
    And User clicks "Edit" button for Workflow Group
    And User populates Workflow Group Name
    And User clicks "Save" button for Workflow Group
    Then Workflow Group "Edit Group" page is not displayed
    And Workflow Group is displayed with values
      | WORKFLOW GROUP NAME | STATUS | DATE CREATED | LAST UPDATED |
      | toBeReplaced        | Active | MM/dd/YYYY   | MM/dd/YYYY   |