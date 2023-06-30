@ui @full_regression @custom_fields
Feature: Custom Fields - Adding Custom Fields

  As an Admin user,
  I want to create custom fields,
  So then use them in Supplier Onboarding

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Custom Fields page
    And User clicks Add Custom Field button

  @C36050611
  @core_regression
  Scenario: C36050611: [Custom Field Setup] Adding - Check that Add Custom Fields modal has correct content and view
    Then Custom Field "Add" page is displayed
    And Add Custom Field window contains fields
      | Field Name* | Description | Field Type* |
    And Required checkbox is displayed
    And Custom Fields buttons should be in correct state
      | Cancel        | enabled |
      | Save as draft | enabled |
      | Save          | enabled |
    And User should see a note after Description block - "Note: This will be displayed as help text of the field name."
    And Add Custom Field window should have Field type options
      | Date | Number | Text | MultiSelect | SingleSelect |
    When User selects Custom Field - Field Type "MultiSelect" from dropdown
    And User switches Manage Data Values checkbox On
    Then Add Custom Field window should have 3 Choice rows with all required elements
    When User selects Custom Field - Field Type "SingleSelect" from dropdown
    And User switches Manage Data Values checkbox On
    Then Add Custom Field window should have 3 Choice rows with all required elements
    When User selects Custom Field - Field Type "MultiSelect" from dropdown
    And User switches Manage Data Values checkbox Off
    Then Add Custom Field window "Map To*" label with dropdown options should be displayed
      | Country | Region | Commodity type | Industry type | Risk tier |
    When User selects Custom Field Map To "Region" from dropdown
    And User switches Manage Data Values checkbox Off
    Then Add Custom Field window "Map To*" label with dropdown options should be displayed
      | Country | Region | Commodity type | Industry type | Risk tier |

  @C36050632
    @core_regression
  Scenario Outline: C36050632: [Custom Field Setup]  Verify that a Custom Field can be created with field Type Date/Text/Num
    Then Custom Field "Add" page is displayed
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User populates in Custom Field Description with "Auto Description"
    And User selects Custom Field - Field Type "<fieldType>" from dropdown
    And User clicks Save button for Custom Field
    Then Created Custom Field is displayed with values
      | Name         | Field Type  | Description      | Status | Date Created | Last Update Date |
      | toBeReplaced | <fieldType> | Auto Description | Active | MM/dd/YYYY   |                  |
    When User clicks Add Custom Field button
    Then Custom Field "Add" page is displayed
    When User populates in Custom Field Name with "Cancel Custom field" and then cancel form
    And User populates in Custom Field Description with "Auto Description"
    And User selects Custom Field - Field Type "Date" from dropdown
    And User clicks Cancel button for Custom Field
    Then Custom Field "Add Custom Field" modal is not displayed
    And Custom field with name "Cancel Custom field" does not exist
    Examples:
      | fieldType |
      | Date      |
      | Text      |
      | Number    |

  @C36050650
    @core_regression
  Scenario Outline: C36050650: [Custom Field Setup]  Adding - Verify that a Custom Field can be created/saved as a draft with field Type
    Then Custom Field "Add" page is displayed
    When User selects Custom Field - Field Type "<fieldType>" from dropdown
    And User switches Manage Data Values checkbox On
    Then Add Custom Field window should have 3 Choice rows with all required elements
    When User deletes Custom Field choice #2
    Then Add Custom Field window should have 2 Choice rows with all required elements
    And Newly added row took correct place when + button was clicked on last Choice row
    When User clicks Cancel button for Custom Field
    And User clicks Add Custom Field button
    Then Custom Field "Add" page is displayed
    When User selects Custom Field - Field Type "<fieldType>" from dropdown
    Then Newly added row took correct place when + button was clicked on not last Choice row
    When User adds 250 Custom Field choices
    Then Plus icons should be invisible for all Choices
    When User clicks Cancel button for Custom Field
    And User clicks Add Custom Field button
    Then Custom Field "Add" page is displayed
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User populates in Custom Field Description with "Auto Description"
    And User selects Custom Field - Field Type "<fieldType>" from dropdown
    And User fills all choices with random values
    And User clicks Save as draft button for Custom Field
    Then Created Custom Field is displayed with values
      | Name         | Field Type       | Description      | Status         | Date Created | Last Update Date |
      | toBeReplaced | <tableFieldType> | Auto Description | Saved As Draft | MM/dd/YYYY   |                  |
    Examples:
      | fieldType    | tableFieldType |
      | SingleSelect | Single Select  |
      | MultiSelect  | Multi Select   |

  @C36363528
  Scenario: C36363528: [Custom Field Setup] Adding - Fields Validations
    When User populates in Custom Field Description with "Auto Description"
    And User clicks Save button for Custom Field
    Then Alert Icon is displayed with text
      | Cannot Save! Please complete the required field(s). |
    And Error message 'This field is required' is displayed for the next fields on Custom Field form
      | Field Name |
      | Field Type |
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User clicks Save button for Custom Field
    Then Alert Icon is displayed with text
      | Cannot Save! Please complete the required field(s). |
    And Error message 'This field is required' is displayed for the next fields on Custom Field form
      | Field Type |
    When User populates in Custom Field Name with "alreadyExistName"
    And User selects Custom Field - Field Type "Text" from dropdown
    And User clicks Save button for Custom Field
    Then Alert Icon is displayed with text
      | Cannot Save! Name already exists. |
    And Error message 'Name already exists' is displayed for the next fields on Custom Field form
      | Field Name |
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User selects Custom Field - Field Type "SingleSelect" from dropdown
    And User fills in Custom Field choice #1 value "1"
    And User fills in Custom Field choice #3 value "3"
    And User clicks Save button for Custom Field
    Then Alert Icon is displayed with text
      | Cannot Save! Please complete the required field(s). |
    And Error message 'This field is required' is displayed for the next fields on Custom Field form
      | Choice #2 |
    When User selects Custom Field - Field Type "Text" from dropdown
    And User selects Custom Field - Field Type "MultiSelect" from dropdown
    And User fills in Custom Field choice #1 value "1"
    And User fills in Custom Field choice #3 value "3"
    And User clicks Save button for Custom Field
    Then Alert Icon is displayed with text
      | Cannot Save! Please complete the required field(s). |
    And Error message 'This field is required' is displayed for the next fields on Custom Field form
      | Choice #2 |

  @C36363673
  Scenario Outline: C36363673: [Custom Field Setup] Adding - Verify that a Custom Field can be saved as a draft with field Type Date/Text/Number
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User selects Custom Field - Field Type "<fieldType>" from dropdown
    And User clicks Save as draft button for Custom Field
    Then Created Custom Field is displayed with values
      | Name         | Field Type  | Status         | Date Created |
      | toBeReplaced | <fieldType> | Saved As Draft | MM/dd/YYYY   |
    Examples:
      | fieldType |
      | Date      |
      | Text      |
      | Number    |

  @C36363740
  Scenario Outline: C36363740: [Custom Field Setup] Adding - Verify that a Custom Field can be created/saved as a draft with field Type Multi Select/Single Select and Manage Data Values is OFF
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User selects Custom Field - Field Type "<fieldType>" from dropdown
    Then Custom Field Manage Data Value checkbox is selected
    And Add Custom Field window should have 3 Choice rows with all required elements
    When User switches Manage Data Values checkbox Off
    Then Add Custom Field window "Map To*" label with dropdown options should be displayed
      | Country        |
      | Region         |
      | Commodity type |
      | Industry type  |
      | Risk tier      |
    When User selects Custom Field Map To "Region" from dropdown
    And User clicks <button> button for Custom Field
    Then Created Custom Field is displayed with values
      | Name         | Field Type       | Status   | Date Created |
      | toBeReplaced | <tableFieldType> | <status> | MM/dd/YYYY   |
    Examples:
      | fieldType    | button        | status         | tableFieldType |
      | SingleSelect | Save as draft | Saved As Draft | Single Select  |
      | SingleSelect | Save          | Active         | Single Select  |
      | MultiSelect  | Save as draft | Saved As Draft | Multi Select   |
      | MultiSelect  | Save          | Active         | Multi Select   |

  @C35346712 @C35351998 @C35352002
    @core_regression
  Scenario Outline: C35346712, C35351998, C35352002: Set Up - Add Custom Field - Type "Date, Number, Text" - Verify page elements Save and displaying in table
    Then Custom Field "Add" page is displayed
    And Custom Fields form "name" field max length is "100" symbols
    And Custom Fields form "description" field max length is "500" symbols
    And User should see a note after Description block - "Note: This will be displayed as help text of the field name."
    And Add Custom Field window contains fields
      | Field Name* | Description | Field Type* |
    And Add Custom Field window should have Field type options
      | Date | Number | Text | MultiSelect | SingleSelect |
    And Custom field 'Required' checkbox is unchecked
    And Custom Fields buttons should be in correct state
      | Cancel        | enabled |
      | Save as draft | enabled |
      | Save          | enabled |
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User populates in Custom Field Description with "Auto Description"
    And User selects Custom Field - Field Type "<fieldType>" from dropdown
    And User clicks on 'Required' custom fields checkbox
    And User clicks Save button for Custom Field
    Then Created Custom Field is displayed with values
      | Name         | Field Type  | Description      | Status | Date Created | Last Update Date |
      | toBeReplaced | <fieldType> | Auto Description | Active | MM/dd/YYYY   |                  |
    When User clicks created Custom Field
    Then Custom Field "View" page is displayed
    And View Custom Field 'Edit' button is displayed
    And Custom Field overview is displayed with values
      | Name            | Field Type  | Description      |
      | customFieldName | <fieldType> | Auto Description |
    And Custom field 'Required' checkbox is checked
    And Custom Field Active checkbox is selected
    When User navigates to Third-party page
    And User clicks Add Third-party button
    And User expands "Other Information" section
    Then Custom field is displayed in Other Information section in edit mode
    And Custom field is required in Other Information section in edit mode
    Examples:
      | fieldType |
      | Number    |
      | Text      |
      | Date      |

  @C35351856
  @core_regression
  @onlySingleThread
  Scenario: C35351856: Set Up - Add Custom Field - Type "Single Select"-Manage Data Values is On - Verify page elements, Save and displaying in the table
    Then Custom Field "Add" page is displayed
    And Add Custom Field window should have Field type options
      | Date | Number | Text | MultiSelect | SingleSelect |
    And Add Custom Field window contains fields
      | Field Name* | Description | Field Type* |
    When User selects Custom Field - Field Type "SingleSelect" from dropdown
    Then Custom field 'Manage Data Values' checkbox is checked
    And Custom Fields choice # 1 field max length is "500" symbols
    And Custom Fields choice # 2 field max length is "500" symbols
    And Custom Fields choice # 3 field max length is "500" symbols
    And Add Custom Field window should have 3 Choice rows with all required elements
    When User deletes Custom Field choice #2
    Then Add Custom Field window should have 2 Choice rows with all required elements
    And Newly added row took correct place when + button was clicked on last Choice row
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User populates in Custom Field Description with "Auto Description"
    And User switches Manage Data Values checkbox On
    And User clicks on 'Required' custom fields checkbox
    And User fills in Custom Field choice #1 value "SingleSelect 1"
    And User fills in Custom Field choice #3 value "3"
    And User toggles Custom Field Red Flag option for Choice #1
    And User clicks Save button for Custom Field
    Then Created Custom Field is displayed with values
      | Name         | Field Type    | Description      | Status | Date Created | Last Update Date |
      | toBeReplaced | Single Select | Auto Description | Active | MM/dd/YYYY   |                  |
    When User clicks created Custom Field
    Then Custom Field "View" page is displayed
    And Custom Field overview is displayed with values
      | Name            | Field Type   | Description      |
      | customFieldName | SingleSelect | Auto Description |
    And Custom Field Active checkbox is selected
    And Custom Field Manage Data Value checkbox is selected
    And Custom Field Manage Data Value list contains option 1 with true red flag
    And Custom Field Map to is invisible
    When User navigates to Third-party page
    And User clicks Add Third-party button
    And User expands "Other Information" section
    Then Custom field is displayed in Other Information section in edit mode
    And Custom field is required in Other Information section in edit mode

  @C35353376 @C35353378
    @core_regression
  Scenario Outline: C35353376, C35353378: Set Up - Add Custom Field - Type "Single Select/ Multi Select"-Manage Data Values is Off - Save/Save as Draft
    Then Custom Field "Add" page is displayed
    And Add Custom Field window should have Field type options
      | Date | Number | Text | MultiSelect | SingleSelect |
    And Add Custom Field window contains fields
      | Field Name* | Description | Field Type* |
    When User selects Custom Field - Field Type "<fieldType>" from dropdown
    Then Custom field 'Manage Data Values' checkbox is checked
    And Custom Fields choice # 1 field max length is "500" symbols
    And Custom Fields choice # 2 field max length is "500" symbols
    And Custom Fields choice # 3 field max length is "500" symbols
    When User switches Manage Data Values checkbox Off
    Then Add Custom Field window "Map To*" label with dropdown options should be displayed
      | Country | Region | Commodity type | Industry type | Risk tier |
    When User selects Custom Field Map To "Region" from dropdown
    And User switches Manage Data Values checkbox Off
    And User populates in Custom Field Name with "AUTO_TEST_"
    And User populates in Custom Field Description with "Auto Description"
    And User clicks on 'Required' custom fields checkbox
    And User clicks <buttonToClick> button for Custom Field
    Then Created Custom Field is displayed with values
      | Name         | Field Type       | Description      | Status   | Date Created | Last Update Date |
      | toBeReplaced | <tableFieldType> | Auto Description | <status> | MM/dd/YYYY   |                  |
    When User clicks created Custom Field
    Then Custom Field "View" page is displayed
    And Custom Field overview is displayed with values
      | Name            | Field Type  | Description      |
      | customFieldName | <fieldType> | Auto Description |
    And Custom Field Active checkbox is <activeCheckbox>
    And Custom Field Manage Data Value checkbox is unselected
    And Custom field 'Required' checkbox is checked
    Examples:
      | tableFieldType | fieldType    | buttonToClick | status         | activeCheckbox |
      | Single Select  | SingleSelect | Save          | Active         | selected       |
      | Single Select  | SingleSelect | Save as draft | Saved As Draft | invisible      |
      | Multi Select   | MultiSelect  | Save          | Active         | selected       |
      | Multi Select   | MultiSelect  | Save as draft | Saved As Draft | invisible      |

  @C35353379 @C35504265
    @core_regression
  Scenario Outline: C35353379, C35504265: Set Up - Add Custom Field - Type "Multi Select/ Single Select"-Manage Data Values is On - Save/Save as Draft
    Then Custom Field "Add" page is displayed
    And Add Custom Field window should have Field type options
      | Date | Number | Text | MultiSelect | SingleSelect |
    And Add Custom Field window contains fields
      | Field Name* | Description | Field Type* |
    When User selects Custom Field - Field Type "<fieldType>" from dropdown
    Then Custom field 'Manage Data Values' checkbox is checked
    And Custom Fields choice # 1 field max length is "500" symbols
    And Custom Fields choice # 2 field max length is "500" symbols
    And Custom Fields choice # 3 field max length is "500" symbols
    And Add Custom Field window should have 3 Choice rows with all required elements
    When User deletes Custom Field choice #2
    Then Add Custom Field window should have 2 Choice rows with all required elements
    And Newly added row took correct place when + button was clicked on last Choice row
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User populates in Custom Field Description with "Auto Description"
    And User switches Manage Data Values checkbox On
    And User clicks on 'Required' custom fields checkbox
    And User fills in Custom Field choice #1 value "<fieldType> 1"
    And User fills in Custom Field choice #3 value "3"
    And User toggles Custom Field Red Flag option for Choice #1
    And User untoggles Custom Field Red Flag option for Choice #2
    And User toggles Custom Field Red Flag option for Choice #3
    And User clicks <buttonToClick> button for Custom Field
    Then Created Custom Field is displayed with values
      | Name         | Field Type       | Description      | Status   | Date Created | Last Update Date |
      | toBeReplaced | <tableFieldType> | Auto Description | <status> | MM/dd/YYYY   |                  |
    When User clicks created Custom Field
    Then Custom Field "View" page is displayed
    And Custom Field overview is displayed with values
      | Name            | Field Type  | Description      |
      | customFieldName | <fieldType> | Auto Description |
    And Custom Field Active checkbox is <activeCheckbox>
    And Custom Field Manage Data Value checkbox is selected
    And Custom Field Manage Data Value list contains option 1 with true red flag
    And Custom Field Manage Data Value list contains option 2 with false red flag
    And Custom Field Manage Data Value list contains option 3 with true red flag
    And Custom Field Map to is invisible
    When User navigates to Third-party page
    And User clicks Add Third-party button
    And User expands "Other Information" section
    Then Custom field is <isFieldDisplayed> in Other Information section in edit mode
    Examples:
      | tableFieldType | fieldType    | buttonToClick | status         | isFieldDisplayed | activeCheckbox |
      | Single Select  | SingleSelect | Save          | Active         | displayed        | selected       |
      | Single Select  | SingleSelect | Save as draft | Saved As Draft | not displayed    | invisible      |
      | Multi Select   | MultiSelect  | Save          | Active         | displayed        | selected       |
      | Multi Select   | MultiSelect  | Save as draft | Saved As Draft | not displayed    | invisible      |
