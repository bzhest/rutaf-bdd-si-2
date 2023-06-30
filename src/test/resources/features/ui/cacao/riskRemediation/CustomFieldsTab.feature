@ui @cacao @functional @risk_remediation @custom_fields
Feature: Risk Management tab - Verify Custom Field Tab

  @C43563944 @C43570224
  Scenario: C43563944, C43570224: [Risk Remediation] - Risk Management tab - Verify Custom Field Tab - Data present
    Given User logs into RDDC as "Admin"
    When User navigates to Custom Fields page
    And User clicks Add Custom Field button
    Then Custom Field "Add" page is displayed
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User populates in Custom Field Description with "Auto Description"
    And User selects Custom Field - Field Type "MultiSelect" from dropdown
    And User switches Manage Data Values checkbox On
    And User fills in Custom Field choice #1 value "Red Flag MultiSelect"
    And User fills in Custom Field choice #2 value "Red Flag MultiSelect 1"
    And User fills in Custom Field choice #3 value "No Red Flag MultiSelect"
    And User toggles Custom Field Red Flag option for Choice #1
    And User toggles Custom Field Red Flag option for Choice #2
    And User untoggles Custom Field Red Flag option for Choice #3
    And User clicks Save button for Custom Field
    And User remembers created Custom field 1 in context
    And User clicks Add Custom Field button
    Then Custom Field "Add" page is displayed
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User populates in Custom Field Description with "Auto Description 1"
    And User selects Custom Field - Field Type "SingleSelect" from dropdown
    And User switches Manage Data Values checkbox On
    And User fills in Custom Field choice #1 value "Red Flag SingleSelect"
    And User fills in Custom Field choice #2 value "No Red Flag SingleSelect"
    And User fills in Custom Field choice #3 value "No Red Flag SingleSelect 1"
    And User toggles Custom Field Red Flag option for Choice #1
    And User untoggles Custom Field Red Flag option for Choice #2
    And User untoggles Custom Field Red Flag option for Choice #3
    And User clicks Save button for Custom Field
    And User remembers created Custom field 2 in context
    And User creates third-party "with random ID name" via API and open it
    And User clicks General and Other Information section "Edit" button
    And User expands "Other Information" section
    And User adds "Red Flag MultiSelect" value to "customFieldNameNumber1" custom field
    And User adds "Red Flag MultiSelect 1" value to "customFieldNameNumber1" custom field
    And User adds "No Red Flag MultiSelect" value to "customFieldNameNumber1" custom field
    And User adds "Red Flag SingleSelect" value to "customFieldNameNumber2" custom field
    And User clicks General and Other Information section "Save" button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Custom Fields" tab
    Then Risk Remediation Custom Fields table is displayed with columns
      | CUSTOM FIELD |
      | VALUE        |
    And Risk Remediation Custom Fields table is displayed with next details
      | CUSTOM FIELD           | VALUE                                        |
      | customFieldNameNumber1 | Red Flag MultiSelect, Red Flag MultiSelect 1 |
      | customFieldNameNumber2 | Red Flag SingleSelect                        |
    When User clicks Risk Remediation Custom Fields "Custom Field" column
    Then Custom Fields Risk Remediation table is sorted by "Custom Field" in "ASC" order
    When User clicks Risk Remediation Custom Fields "Custom Field" column
    Then Custom Fields Risk Remediation table is sorted by "Custom Field" in "DESC" order
    When User clicks Risk Remediation Custom Fields "Value" column
    Then Custom Fields Risk Remediation table is sorted by "Value" in "ASC" order
    When User clicks Risk Remediation Custom Fields "Value" column
    Then Custom Fields Risk Remediation table is sorted by "Value" in "DESC" order
    And Pagination option "10" is selected
    And Pagination buttons should be visible
      | first page | previous page | next page | last page |
    When User clicks on Custom Fields Risk Remediation record "customFieldNameNumber1"
    Then Third-party Information tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId" endpoint
    And Risk Remediation breadcrumb is displayed
    When User clicks Risk Remediation breadcrumb
    And User clicks on Custom Fields Risk Remediation record "customFieldNameNumber2"
    And User clicks "Risk Remediation" breadcrumb Back icon
    Then Risk Remediation "Custom Fields" tab is displayed


