@ui @full_regression @custom_fields
Feature: Custom Fields - Editing Custom Fields

  As an Admin user,
  I want to edit custom fields,
  So then use them in Supplier Onboarding

  Background:
    Given User logs into RDDC as "Admin"

  @C36051650
  Scenario: C36051650: [Custom Field Setup] Editing - Fields Validations
    When User creates Custom Field "active with random name and Text type" via API
    And User navigates to Custom Fields page
    And User clicks Edit button for Custom Field
    And User populates in Custom Field Name with ""
    And User clicks Save button for Custom Field
    Then Alert Icon is displayed with text
      | Cannot Save! Please complete the required field(s). |
    And Error message 'This field is required' is displayed for the next fields on Custom Field form
      | Field Name |
    When User populates in Custom Field Name with "alreadyExistName"
    And User clicks Save button for Custom Field
    And User clicks Proceed button on confirmation window
    Then Alert Icon is displayed with text
      | Cannot Save! Name already exists. |
    And Error message 'Name already exists' is displayed for the next fields on Custom Field form
      | Field Name |

  @C36051653 @C35533134 @C35533138 @C35533140
  Scenario Outline: C36051653, C35533134, C35533138, C35533140: [Custom Field Setup] Editing - Edit "Data/Text/Number" Custom Field in Active/Inactive status from Custom Field List
    When User creates Custom Field "<customField>" via API
    And User navigates to Custom Fields page
    And User clicks Edit button for Custom Field
    And User populates in Custom Field Name with "AUTO_TEST_UPDATE_" and then cancel form
    And User populates in Custom Field Description with "Updated Description"
    Then Custom Field Field Type is disabled
    When User clicks Cancel button for Custom Field
    Then Created Custom Field is displayed with values
      | Name               | Field Type  | Status | Date Created | Description           |
      | customFieldNameAPI | <fieldType> | Active | MM/dd/YYYY   | Auto Test description |
    When User clicks Edit button for Custom Field
    And User populates in Custom Field Name with "AUTO_TEST_UPDATE_"
    And User populates in Custom Field Description with "Updated Description"
    And User switches Active Custom Field checkbox Off
    And User clicks Save button for Custom Field
    And User clicks Proceed button on confirmation window
    Then Created Custom Field is displayed with values
      | Name         | Field Type  | Status   | Date Created | Last Update | Description         |
      | toBeReplaced | <fieldType> | Inactive | MM/dd/YYYY   | MM/dd/YYYY  | Updated Description |
    When User clicks Edit button for Custom Field
    And User switches Active Custom Field checkbox On
    And User clicks on 'Required' custom fields checkbox
    And User clicks Save button for Custom Field
    And User clicks Proceed button in the 'Edit Custom Field' modal window
    And User navigates to Third-party page
    And User clicks Add Third-party button
    And User expands "Other Information" section
    Then Custom field is displayed in Other Information section in edit mode
    And Custom field is required in Other Information section in edit mode
    Examples:
      | customField                             | fieldType |
      | active with random name and Text type   | Text      |
      | active with random name and Date type   | Date      |
      | active with random name and Number type | Number    |

  @C36051671
  @onlySingleThread
  Scenario: C36051671: [Custom Field Setup] Editing - Deactivate Custom Field and verify that only Active CFs are displayed on the Supplier Information page
    When User creates Custom Field "active with random name and Date type" via API
    And User creates third-party "with random ID name" via API and open it
    Then Third-party Information should have all Active Custom Fields fields
    And Third-party Information "customFieldNameAPI" field is displayed
    When User navigates to Custom Fields page
    And User clicks Edit button for Custom Field
    And User switches Active Custom Field checkbox Off
    And User clicks Save button for Custom Field
    And User clicks Proceed button on confirmation window
    Then Created Custom Field is displayed with values
      | Name               | Field Type | Status   | Date Created | Last Update | Description           |
      | customFieldNameAPI | Date       | Inactive | MM/dd/YYYY   | MM/dd/YYYY  | Auto Test description |
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then Third-party Information "customFieldNameAPI" field is invisible

  @C36380563 @C35533141
  Scenario Outline: C36380563, C35533141: [Custom Field Setup] Editing - Edit "Multi/Single Select" Custom Field from Custom Field List
    When User creates Custom Field "active <fieldType> Select type" via API
    And User navigates to Custom Fields page
    And User clicks Edit button for Custom Field
    Then Delete icons should be enabled for all Choices
    And Plus icons should be enabled for all Choices
    And Custom Field Field Type is disabled
    And Custom Field Manage Data is disabled
    When User populates in Custom Field Name with "Update_Name_"
    And User populates in Custom Field Description with "Updated Description"
    And User switches Active Custom Field checkbox Off
    And User clicks Save button for Custom Field
    Then Message is displayed on confirmation window
      | Any update on this custom field will apply in all existing third-parties with corresponding data. |
      | Are you sure you want to update this field?                                                       |
    When User clicks Proceed button on confirmation window
    Then Created Custom Field is displayed with values
      | Name         | Field Type      | Status   | Date Created | Last Update | Description         |
      | toBeReplaced | <fieldTypeName> | Inactive | MM/dd/YYYY   | MM/dd/YYYY  | Updated Description |
    When User clicks Delete button for Custom Field
    And User clicks Delete button on confirmation window
    Then Custom field with name "customFieldNameAPI" does not exist
    When User creates Custom Field "active <fieldType> Select type" via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks General and Other Information section "Edit" button
    And User expands "Other Information" section
    And User selects "customFieldNameAPI" custom field value "1"
    And User clicks General and Other Information section "Save" button
    And User navigates to Custom Fields page
    And User clicks Edit button for Custom Field
    Then Delete icons should be disabled for "1" Choice
    And Delete icons should be enabled for "2" Choice
    And Delete icons should be enabled for "3" Choice
    And Plus icons should be enabled for all Choices
    And Custom Field Field Type is disabled
    And Custom Field Manage Data is disabled
    When User populates in Custom Field Name with "Update_Name_"
    And User populates in Custom Field Description with "Updated Description"
    And User switches Active Custom Field checkbox Off
    And User clicks Save button for Custom Field
    And User clicks Proceed button on confirmation window
    Then Created Custom Field is displayed with values
      | Name         | Field Type      | Status   | Date Created | Last Update | Description         |
      | toBeReplaced | <fieldTypeName> | Inactive | MM/dd/YYYY   | MM/dd/YYYY  | Updated Description |
    When User clicks Delete button for Custom Field
    And User clicks Delete button on confirmation window
    Then Custom field with name "customFieldNameAPI" does not exist
    When User creates Custom Field "active <fieldType> Select type Map To country" via API
    And User navigates to Custom Fields page
    And User clicks Edit button for Custom Field
    Then Custom Field Field Type is disabled
    And Custom Field Manage Data is disabled
    And Custom Field Map to is disabled
    When User populates in Custom Field Name with "Update_Name_"
    And User populates in Custom Field Description with "Updated Description"
    And User switches Active Custom Field checkbox Off
    And User clicks Save button for Custom Field
    And User clicks Proceed button on confirmation window
    Then Created Custom Field is displayed with values
      | Name         | Field Type      | Status   | Date Created | Last Update | Description         |
      | toBeReplaced | <fieldTypeName> | Inactive | MM/dd/YYYY   | MM/dd/YYYY  | Updated Description |
    Examples:
      | fieldType | fieldTypeName |
      | Multi     | Multi Select  |
      | Single    | Single Select |

  @C36380592
  Scenario Outline: C36380592: [Custom Field Setup] Editing - Edit Custom Fields in "Saved as Draft" status from Custom Field List
    When User creates Custom Field "<fieldType>" via API
    And User navigates to Custom Fields page
    And User clicks Edit button for Custom Field
    And User populates in Custom Field Name with "Update_Name_"
    And User populates in Custom Field Description with "Updated Description"
    And User selects Custom Field - Field Type "<newFieldTypeName1>" from dropdown
    And User clicks Save as draft button for Custom Field
    Then Custom Field "Edit Custom Field" modal is not displayed
    And Created Custom Field is displayed with values
      | Name         | Field Type          | Status         | Date Created | Last Update | Description         |
      | toBeReplaced | <newFieldTypeName1> | Saved As Draft | MM/dd/YYYY   | MM/dd/YYYY  | Updated Description |
    When User clicks Edit button for Custom Field
    And User populates in Custom Field Name with "Update_Name_"
    And User populates in Custom Field Description with "New Updated Description"
    And User selects Custom Field - Field Type "<newFieldTypeName2>" from dropdown
    And User clicks Save button for Custom Field
    Then Created Custom Field is displayed with values
      | Name         | Field Type          | Status | Date Created | Last Update | Description             |
      | toBeReplaced | <newFieldTypeName2> | Active | MM/dd/YYYY   | MM/dd/YYYY  | New Updated Description |
    When User clicks Edit button for Custom Field
    And User populates in Custom Field Name with "Update_Name_" and then cancel form
    And User populates in Custom Field Description with "One More New Updated Description"
    And User switches Active Custom Field checkbox Off
    And User clicks Cancel button for Custom Field
    Then Created Custom Field is displayed with values
      | Name         | Field Type          | Status | Date Created | Last Update | Description             |
      | toBeReplaced | <newFieldTypeName2> | Active | MM/dd/YYYY   | MM/dd/YYYY  | New Updated Description |
    Examples:
      | fieldType                                    | newFieldTypeName1 | newFieldTypeName2 |
      | draft with description and Date type         | Text              | Date              |
      | draft with description and Text type         | Date              | Number            |
      | draft with random name and Number type       | Date              | Text              |
      | draft with random name and MultiType type    | Text              | Number            |
      | draft with random name and SingleSelect type | Number            | Date              |
