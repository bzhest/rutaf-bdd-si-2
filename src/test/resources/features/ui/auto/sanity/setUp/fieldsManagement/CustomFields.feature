@ui @sanity @custom_fields @multilanguage
Feature: Manage Custom Fields

  As an Admin user,
  I want to create/edit/delete custom fields,
  So then use them in Supplier Onboarding

  Background:
    Given User logs into RDDC as "Admin"
    When User sets up language via API

  @C32988214
  Scenario: C32988214: Set Up - Custom Fields - Add Custom Field
    And User navigates to Custom Fields page
    And User clicks Add Custom Field button
    Then Custom Field "Add" page is displayed
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User populates in Custom Field Description with "Auto Description"
    And User selects Custom Field - Field Type "Text" from dropdown
    And User clicks Save button for Custom Field
    Then Created Custom Field is displayed with values
      | Name         | Field Type | Description      | Status | Date Created | Last Update Date |
      | toBeReplaced | Text       | Auto Description | Active | MM/dd/YYYY   |                  |
    When User creates third-party "workflowGroupUkraine"
    Then User verifies third-party is created
    And Created Custom Field is displayed in Other Information section

  @C32988215
  Scenario: C32988215: Set Up - Custom Fields - Edit Custom Field
    And User creates Custom Field "active with description and Text type" via API
    And User navigates to Custom Fields page
    When User clicks Edit button for Custom Field
    Then Custom Field "Edit" page is displayed
    When User updates Custom Field Name with "customFieldNameAPI"
    And User updates Custom Field Description with "Auto Description updated"
    And User clicks Save button for Custom Field
    And User clicks Proceed button in the 'Edit Custom Field' modal window
    Then Custom Field "customFieldName" is displayed with values
      | Name            | Field Type | Description              | Status | Date Created | Last Update |
      | customFieldName | Text       | Auto Description updated | Active | MM/dd/YYYY   | MM/dd/YYYY  |
    When User creates third-party "workflowGroupUkraine"
    Then User verifies third-party is created
    And Custom Field "toBeReplaced" is displayed in Other Information section
