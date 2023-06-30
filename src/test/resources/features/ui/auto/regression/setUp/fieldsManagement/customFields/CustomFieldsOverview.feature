@ui @full_regression @custom_fields
Feature: Custom Fields Overview

  As an Admin user,
  I want to view custom fields,
  So then use them in Supplier Onboarding

  @C36050519 @C35504369
  Scenario: C36050519, C35504369: [Custom Field Setup] Overview - Check that Custom Fields page has correct content
    Given User logs into RDDC as "Admin"
    When User navigates to Custom Fields page
    Then Custom Fields table displayed with following columns
      | NAME         |
      | FIELD TYPE   |
      | DESCRIPTION  |
      | STATUS       |
      | DATE CREATED |
      | LAST UPDATED |
    And Show Drop-Down list is displayed with values
      | All            |
      | Active         |
      | Inactive       |
      | Saved as draft |
    And Add Custom Field button is displayed
    And Reorder button is displayed
    And Items per page drop-down should be displayed
    And Custom Fields table is sorted according to "DATE CREATED" field in "DESC" order
    When User clicks Custom Field table "Name" field
    Then Custom Fields table is sorted according to "Name" field in "ASC" order
    When User clicks Custom Field table "Name" field
    Then Custom Fields table is sorted according to "Name" field in "DESC" order
    When User clicks Custom Field table "Field Type" field
    Then Custom Fields table is sorted according to "Field Type" field in "ASC" order
    When User clicks Custom Field table "Field Type" field
    Then Custom Fields table is sorted according to "Field Type" field in "DESC" order
    When User clicks Custom Field table "Description" field
    Then Custom Fields table is sorted according to "Description" field in "ASC" order
    When User clicks Custom Field table "Description" field
    Then Custom Fields table is sorted according to "Description" field in "DESC" order
    When User clicks Custom Field table "Status" field
    Then Custom Fields table is sorted according to "Status" field in "ASC" order
    When User clicks Custom Field table "Status" field
    Then Custom Fields table is sorted according to "Status" field in "DESC" order
    When User clicks Custom Field table "Date Created" field
    Then Custom Fields table is sorted according to "Date Created" field in "ASC" order
    When User clicks Custom Field table "Date Created" field
    Then Custom Fields table is sorted according to "Date Created" field in "DESC" order
    When User clicks Custom Field table "Last Updated" field
    Then Custom Fields table is sorted according to "Last Updated" field in "ASC" order
    When User clicks Custom Field table "Last Updated" field
    Then Custom Fields table is sorted according to "Last Updated" field in "DESC" order
    And For each Custom Field record controls buttons should be displayed

  @C36050542
  Scenario: C36050542: [Custom Field Setup] - Verify that only the authorized users are able to configure the CFS in the System
    Given User logs into RDDC as "user without onboarding and renewal accesses"
    When User clicks Set Up option
    Then Custom Fields tab is not displayed
    When User opens Custom Fields page "/ui/admin/fields-management/custom-fields"
    Then Current URL contains endpoint "/ui/forbidden"
    When User opens Custom Fields page "/ui/admin/fields-management/custom-fields/add"
    Then Current URL contains endpoint "/ui/forbidden"
    When User opens Custom Fields page "/ui/admin/fields-management/custom-fields/customFieldId/edit"
    Then Current URL contains endpoint "/ui/forbidden"
    When User opens Custom Fields page "/ui/admin/fields-management/custom-fields/customFieldId"
    Then Current URL contains endpoint "/ui/forbidden"
    When User opens Custom Fields page "/ui/admin/fields-management/custom-fields/reorder"
    Then Current URL contains endpoint "/ui/forbidden"
    And The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    And Back button is displayed

  @C36051487 @C35361332
  @onlySingleThread
  Scenario: C36051487, C35361332: [Custom Field Setup] - Custom Field List Filter - Verify that user can use filtering options on the Custom fields page
    Given User logs into RDDC as "Admin"
    When User navigates to Custom Fields page
    Then Show Drop-Down current option should be "All"
    When User selects "Active" show option
    Then Custom Fields for page size 10 displayed with all recalculated "ACTIVE" items
    When User selects "Inactive" show option
    Then Custom Fields for page size 10 displayed with all recalculated "INACTIVE" items
    When User selects "Saved as draft" show option
    Then Custom Fields for page size 10 displayed with all recalculated "DRAFT" items
    When User selects "All" show option
    Then Custom Fields for page size 10 displayed with all recalculated "ALL" items

  @C36051616 @C35504273
  @onlySingleThread
  Scenario: C36051616, C35504273: [Custom Field Setup] - Custom Field List Pagination
    Given User logs into RDDC as "Admin"
    When User navigates to Custom Fields page
    Then Pagination option "10" is selected
    When User clicks "Custom Fields" "last" pagination element
    Then Results "Custom Fields" for current page is displayed
    When User clicks "Custom Fields" "first" pagination element
    Then Results "Custom Fields" for current page is displayed
    When User clicks "Custom Fields" "next" pagination element
    Then Results "Custom Fields" for current page is displayed
    When User clicks "Custom Fields" "previous" pagination element
    Then Results "Custom Fields" for current page is displayed
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    When User refreshes page
    And User selects "Saved as draft" show option
    And User selects "10" items per page
    Then Custom Fields for page size 10 displayed with all recalculated "DRAFT" items
    When User selects "Inactive" show option
    And User selects "25" items per page
    Then Custom Fields for page size 25 displayed with all recalculated "INACTIVE" items
    When User selects "All" show option
    And User selects "50" items per page
    Then Custom Fields for page size 50 displayed with all recalculated "ALL" items
    When User selects "Active" show option
    And User selects "25" items per page
    Then Custom Fields for page size 25 displayed with all recalculated "ACTIVE" items

  @C36051991 @C35397707
  @onlySingleThread
  Scenario: C36051991, C35397707: [Custom Field Setup] - Reordering of Custom Fields in the Supplier profile
    Given User logs into RDDC as "Admin"
    When User navigates to Custom Fields page
    And User clicks Reorder Custom Fields button
    Then Custom Fields reorder page is displayed
    And Custom Field "Reorder" page is displayed
    And All active Custom Fields are displayed in the list
    And Custom Fields buttons should be in correct state
      | Cancel | enabled  |
      | Save   | disabled |
    And Reorder Custom Fields Chevron buttons are disabled
    When User selects Custom Field on position "2"
    And User clicks "<" reorder chevron button
    And User clicks "<" reorder chevron button
    Then Moved Custom Field on position "0"
    When User selects Custom Field on position "1"
    And User clicks ">" reorder chevron button
    Then Moved Custom Field on position "2"
    When User selects Custom Field on position "3"
    And User clicks "<<" reorder chevron button
    Then Moved Custom Field on position "0"
    When User selects Custom Field on position "1"
    And User clicks ">>" reorder chevron button
    Then Moved Custom Field on position "last"
    When User clicks "Save" Custom Fields reorder button
    Then Alert Icon is displayed with text
      | Success! Custom Fields has been updated |
    When User clicks Reorder Custom Fields button
    Then Custom Fields is sorted in "reorderedFields" order
    And Custom Fields reorder page is displayed
    When User selects Custom Field on position "2"
    And User clicks "<" reorder chevron button
    And User clicks "<" reorder chevron button
    Then Moved Custom Field on position "0"
    When User selects Custom Field on position "1"
    And User clicks ">" reorder chevron button
    Then Moved Custom Field on position "2"
    When User selects Custom Field on position "3"
    And User clicks "<<" reorder chevron button
    Then Moved Custom Field on position "0"
    When User selects Custom Field on position "1"
    And User clicks ">>" reorder chevron button
    Then Moved Custom Field on position "last"
    When User clicks "Cancel" Custom Fields reorder button
    And User clicks Reorder Custom Fields button
    Then Custom Fields is sorted in "initialFields" order

  @C36364478
  Scenario: C36364478: [Custom Field Setup] View Custom Field - Verify View custom fields and edit redirect
    Given User logs into RDDC as "Admin"
    When User creates Custom Field "active with random name and Text type" via API
    And User navigates to Custom Fields page
    And User clicks created Custom Field
    Then Custom Field "View" page is displayed
    And View Custom Field 'Edit' button is displayed
    And Custom Field overview is displayed with values
      | Name               | Field Type | Description           |
      | customFieldNameAPI | Text       | Auto Test description |
    And Custom Field Active checkbox is selected
    And Custom Field Manage Data Value checkbox is invisible
    And Custom Field Map to is invisible
    When User clicks 'Back' button for Custom Field
    And User clicks Delete button for Custom Field
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Custom field with name "customFieldNameAPI" does not exist
    When User creates Custom Field "draft without description and Date type" via API
    And User navigates to Custom Fields page
    And User clicks created Custom Field
    Then Custom Field "View" page is displayed
    And View Custom Field 'Edit' button is displayed
    And Custom Field overview is displayed with values
      | Name               | Field Type |
      | customFieldNameAPI | Date       |
    And Custom Field Active checkbox is invisible
    And Custom Field Manage Data Value checkbox is invisible
    And Custom Field Map to is invisible
    When User clicks 'Back' button for Custom Field
    And User clicks Delete button for Custom Field
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Custom field with name "customFieldNameAPI" does not exist
    When User creates Custom Field "inactive without description name and Number type" via API
    And User navigates to Custom Fields page
    And User clicks created Custom Field
    Then Custom Field "View" page is displayed
    And View Custom Field 'Edit' button is displayed
    And Custom Field overview is displayed with values
      | Name               | Field Type |
      | customFieldNameAPI | Number     |
    And Custom Field Active checkbox is unselected
    And Custom Field Manage Data Value checkbox is invisible
    And Custom Field Map to is invisible
    When User clicks 'Back' button for Custom Field
    And User clicks Delete button for Custom Field
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Custom field with name "customFieldNameAPI" does not exist
    When User creates Custom Field "active with description and 10 options red flag true and SingleSelect type" via API
    And User navigates to Custom Fields page
    And User clicks created Custom Field
    Then Custom Field "View" page is displayed
    And View Custom Field 'Edit' button is displayed
    And Custom Field overview is displayed with values
      | Name               | Field Type   | Description           |
      | customFieldNameAPI | SingleSelect | Auto Test description |
    And Custom Field Active checkbox is selected
    And Custom Field Manage Data Value checkbox is selected
    And Custom Field Manage Data Value list contains 10 options with "true" red flag
    And Custom Field Map to is invisible
    When User clicks 'Back' button for Custom Field
    And User clicks Delete button for Custom Field
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Custom field with name "customFieldNameAPI" does not exist
    When User creates Custom Field "draft with 500 symbols description and 11 options red flag false and MultiSelect type" via API
    And User navigates to Custom Fields page
    And User clicks created Custom Field
    Then Custom Field "View" page is displayed
    And View Custom Field 'Edit' button is displayed
    And Custom Field overview is displayed with values
      | Name               | Field Type  | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
      | customFieldNameAPI | MultiSelect | FWVcNUY9qBdvzupW3xbWuY68znhP8dcqSpACZ52enrhM0yUuDoLPlwB5VOOu5iJLRqvuD5hEEH9P6xiRyH8KsNAGnzbp9NzM3ppmWq7VHzdYMxry12jLQYe2D64tGHtubTSkeHUZo1Okg4vD9J0FiX3Ns77y1who0GSnd0uIdbyc8RFrtxhM7L9ELiJ3IR3oUtiPiADfSbNyPnVl86XRlZRTrsnKHIZLUnYebSAxARPmPlXn7SVO1bTrtiR0ayPW0tdpbnfj86osy44ydoTKZ6K15Vk0ryL1sjKZMnAaY3Iddo9hfSFaW0oAjKh3eBoCD8CqSy2mviwsQxMHEVT3QzwQVaWAV3fwxjiFe1C0zhnlhR4ugaMLallFIJa05CKxrluQxbtvH0azPmlXD5U5n9hwCGE6gvapDlj5oembkrCxWh7eGGO8vua5ycjVBXcnjoniT90O5pDtU6f30URCX41AYIMAxcbaCqM8dhyWLC7SVSH6hfAF |
    And Custom Field Active checkbox is invisible
    And Custom Field Manage Data Value checkbox is selected
    And Custom Field Manage Data Value list contains 11 options with "false" red flag
    And Custom Field Map to is invisible
    When User clicks 'Back' button for Custom Field
    And User clicks Delete button for Custom Field
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Custom field with name "customFieldNameAPI" does not exist
    When User creates Custom Field "inactive MultiSelect type Map To country without description" via API
    And User navigates to Custom Fields page
    And User clicks created Custom Field
    Then Custom Field "View" page is displayed
    And View Custom Field 'Edit' button is displayed
    And Custom Field overview is displayed with values
      | Name               | Field Type  |
      | customFieldNameAPI | MultiSelect |
    And Custom Field Active checkbox is unselected
    And Custom Field Manage Data Value checkbox is unselected
    And Custom Field Map to contains "Country"

  @C35361017
  Scenario: C35361017: Set Up - Custom Field Overview-Verify page elements
    Given User logs into RDDC as "Admin"
    When User creates Custom Field "active with description and Text type" via API
    And User remembers created Custom field 1 in context
    And User creates Custom Field "active with random name and Date type" via API
    And User remembers created Custom field 2 in context
    And User creates Custom Field "active Multi Select type" via API
    And User remembers created Custom field 3 in context
    And User creates Custom Field "inactive with description and Text type" via API
    And User remembers created Custom field 4 in context
    And User creates Custom Field "inactive without description name and Number type" via API
    And User remembers created Custom field 5 in context
    And User creates Custom Field "inactive MultiSelect type Map To country without description" via API
    And User remembers created Custom field 6 in context
    And User creates Custom Field "draft with random name and SingleSelect type" via API
    And User remembers created Custom field 7 in context
    And User creates Custom Field "draft with description and Text type" via API
    And User remembers created Custom field 8 in context
    And User creates Custom Field "draft with description and Date type" via API
    And User remembers created Custom field 9 in context
    And User navigates to Custom Fields page
    Then Custom Fields are displayed with values
      | Name                   | Field Type    | Description           | Status         | Date Created | Last Update Date |
      | customFieldNameNumber1 | Text          | Auto Test description | Active         | MM/dd/YYYY   |                  |
      | customFieldNameNumber2 | Date          | Auto Test description | Active         | MM/dd/YYYY   |                  |
      | customFieldNameNumber3 | Multi Select  | Auto Test description | Active         | MM/dd/YYYY   |                  |
      | customFieldNameNumber4 | Text          | Auto Test description | Inactive       | MM/dd/YYYY   |                  |
      | customFieldNameNumber5 | Number        |                       | Inactive       | MM/dd/YYYY   |                  |
      | customFieldNameNumber6 | Multi Select  |                       | Inactive       | MM/dd/YYYY   |                  |
      | customFieldNameNumber7 | Single Select | Auto Test description | Saved As Draft | MM/dd/YYYY   |                  |
      | customFieldNameNumber8 | Text          | Auto Test description | Saved As Draft | MM/dd/YYYY   |                  |
      | customFieldNameNumber9 | Date          | Auto Test description | Saved As Draft | MM/dd/YYYY   |                  |
    And For each Custom Field record controls buttons should be displayed
    And Show Drop-Down list is displayed with values
      | All            |
      | Active         |
      | Inactive       |
      | Saved as draft |
    And Add Custom Field button is displayed
    And Reorder button is displayed
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |