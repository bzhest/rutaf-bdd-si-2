@ui @suppliers
Feature: Third-party Information - Add Third-party

  As a Supplier Integrity User
  I want I want to be able to create new Suppliers
  So that I can process the Suppliers that need to be Onboarded for the Organisation

  Background:
    Given User logs into RDDC as "Admin"

  @C35617383
  @core_regression
  Scenario: C35617383: Supplier - Add Supplier with required fields only
    When User opens third-party creation form
    And User fills third-party creation form with third-party's test data "with defined name"
    And User submits Third-party creation form
    Then User verifies third-party is created
    And Third-party Information details are displayed with populated data
    And Third-party's status should be shown - "NEW"
    And Third-party's Risk Tier should be shown - "MEDIUM"
    And Third-party's Overall Risk Score should be generated - "3.0"
    When User navigates to Third-party page
    Then Third-party with name "AUTO_TEST_THIRD_PARTY" is displayed in Third-party overview table
    When User clicks on created third-party
    Then Third-party Information details are displayed with populated data
    When User navigates to Third-party page
    And User searches third-party with name "AUTO_TEST_THIRD_PARTY"
    Then Third-party with name "AUTO_TEST_THIRD_PARTY" is displayed in Third-party overview table

  @C35619181
  @core_regression
  Scenario: C35619181: Supplier - Add Supplier - validation for required fields
    When User opens third-party creation form
    And User clears 'Division' Add Third-party form field
    And User submits Third-party creation form
    Then Error message "This field is required" in red color is displayed on field
      | Name     |
      | Division |
    And Error message "This field is required" in red color is displayed on Address section on field
      | Country |

  @C35619363
  @core_regression
  Scenario: C35619363: Supplier - Add supplier - Validate that a new supplier can be created via Save and new button
    When User opens third-party creation form
    And User fills third-party creation form with third-party's test data "with random ID name"
    And User clicks 'Save and New' Add Third-party button
    Then Add Third-party window is displayed
    And Add Third-party window's button with name "Cancel" is displayed and enabled
    And Add Third-party window's button with name "Save" is displayed and enabled
    And Add Third-party window's button with name "Save and New" is displayed and enabled
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then Third-party Information details are displayed with populated data

  @C35619947
  Scenario: C35619947: Supplier - Add Supplier - Cancel Supplier creation
    When User opens third-party creation form
    And User fills third-party creation form with third-party's test data "with random ID name"
    And User clicks 'Cancel' Add Third-party button
    Then Third-party "with random ID name" does not appear in the Third-party Overview table

  @C50082198
  @core_regression
  Scenario: C50082198: [Configurable TP Fields] - Add - General and Other Information section - All fields displayed - 'Save' Button
    When User opens third-party creation form
    Then Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    And Asterisk is displayed for "Name" field of "General Information" section
    And Asterisk is displayed for "Responsible Party" field of "General Information" section
    And Asterisk is displayed for "Division" field of "General Information" section
    And Asterisk is displayed for "Workflow Group" field of "General Information" section
    And Asterisk is displayed for "Country" field of "Address" section
    When User fills third-party creation form with third-party's test data "with MyDivision division and Admin double responsible party"
    And User submits Third-party creation form
    Then User verifies third-party is created
    And Third-party Information details are displayed with populated data

  @C50082198
  @core_regression
  Scenario: C50082198: [Configurable TP Fields] - Add - General and Other Information section - All fields displayed - 'Save and New' Button
    When User opens third-party creation form
    Then Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Screening Criteria       | collapsed |
      | Description              | collapsed |
    And Fields asterisk should be shown according to table
      | Name              | General Information | displayed |
      | Responsible Party | General Information | displayed |
      | Division          | General Information | displayed |
      | Workflow Group    | General Information | displayed |
      | Country           | Address             | displayed |
    When User fills third-party creation form with third-party's test data "with MyDivision division and Admin double responsible party"
    And User clicks 'Save and New' Add Third-party button
    Then Add Third-party window is displayed
    And Add Third-party window's button with name "Cancel" is displayed and enabled
    And Add Third-party window's button with name "Save" is displayed and enabled
    And Add Third-party window's button with name "Save and New" is displayed and enabled

  @C50099013
  @core_regression
  @onlySingleThread
  Scenario: C50099013: [Configurable TP Fields] - Add - General and Other Information section - All fields displayed - Required
    When User sets required values for Third-party General Information fields via API
    And User opens third-party creation form
    Then Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    And Fields asterisk should be shown according to table
      | Name                  | General Information | displayed |
      | Responsible Party     | General Information | displayed |
      | Division              | General Information | displayed |
      | Workflow Group        | General Information | displayed |
      | Reference No.         | General Information | displayed |
      | Industry Type         | General Information | displayed |
      | Date of Incorporation | General Information | displayed |
      | Currency              | General Information | displayed |
      | Company Type          | General Information | displayed |
      | Business Category     | General Information | displayed |
      | Affiliation           | General Information | displayed |
      | Liquidation Date      | General Information | displayed |
      | Organisation Size     | General Information | displayed |
      | Revenue               | General Information | displayed |
    When User submits Third-party creation form
    Then Error message "This field is required" in red color is displayed on General Information section on field
      | Name                  |
      | Reference No.         |
      | Industry Type         |
      | Date of Incorporation |
      | Currency              |
      | Company Type          |
      | Business Category     |
      | Affiliation           |
      | Liquidation Date      |
      | Organisation Size     |
      | Revenue               |
    And Third-party sections color should be highlighted red
      | General Information |
      | Address             |
    When User fills third-party creation form with third-party's test data "General Information fields + country"
    And User submits Third-party creation form
    Then User verifies third-party is created

  @C50099821
  @core_regression
  @onlySingleThread
  Scenario: C50099821: [Configurable TP Fields] - Add - General and Other Information section - All Sub-section does not have active fields
    When User set default values for Third-party Fields via API
    And User opens third-party creation form
    Then Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    And Fields asterisk should be shown according to table
      | Name              | General Information | displayed |
      | Responsible Party | General Information | displayed |
      | Division          | General Information | displayed |
      | Workflow Group    | General Information | displayed |
    When User submits Third-party creation form
    Then Error message "This field is required" in red color is displayed on General Information section on field
      | Name |
    And Third-party sections color should be highlighted red
      | General Information |
      | Address             |
    When User fills third-party creation form with third-party's test data "with mandatory fields"
    And User submits Third-party creation form
    Then User verifies third-party is created

  @C50099848
  @core_regression
  @onlySingleThread
  Scenario: C50099848: [Configurable TP Fields] - Add - General and Other Information section - 1 sub-section does not have active fields
    When User inactivates values for Third-party Segmentations Fields via API
    And User opens third-party creation form
    Then Third-Party section should be in correct state
      | General Information | expanded  |
      | Other Information   | collapsed |
      | Bank Details        | collapsed |
      | Address             | collapsed |
      | Contact             | collapsed |
      | Description         | collapsed |
    And Third-Party section should be hidden
      | Third-party Segmentation |
    And Fields asterisk should be shown according to table
      | Name              | General Information | displayed |
      | Responsible Party | General Information | displayed |
      | Division          | General Information | displayed |
      | Workflow Group    | General Information | displayed |
    When User submits Third-party creation form
    Then Error message "This field is required" in red color is displayed on General Information section on field
      | Name |
    And Third-party sections color should be highlighted red
      | General Information |
      | Address             |
    When User fills third-party creation form with third-party's test data "with mandatory fields"
    And User submits Third-party creation form
    Then User verifies third-party is created

  @C50099849
  @core_regression
  @onlySingleThread
  Scenario: C50099849: [Configurable TP Fields] - Add - General and Other Information section - Sub-sections has several active fields
    When User sets custom values for Third-party Fields via API
    And User opens third-party creation form
    Then Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    And Fields asterisk should be shown according to table
      | Name              | General Information | displayed |
      | Responsible Party | General Information | displayed |
      | Division          | General Information | displayed |
      | Bank Name         | Bank Details        | displayed |
      | Account No.       | Bank Details        | displayed |
      | Phone Number      | Contact             | displayed |
      | Fax               | Contact             | displayed |
      | Website           | Contact             | displayed |
      | Email Address     | Contact             | displayed |
    When User submits Third-party creation form
    Then Third-party sections color should be highlighted red
      | General Information |
      | Bank Details        |
      | Contact             |
    When User fills third-party creation form with third-party's test data "with random ID name and custom fields"
    And User submits Third-party creation form
    Then User verifies third-party is created

  @C50099821
  @core_regression
  @onlySingleThread
  Scenario: C50099821: [Configurable TP Fields] - Add - General and Other Information section - All Sub-section does not have active fields
    When User set default values for Third-party Fields via API
    And User opens third-party creation form
    Then Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    And Fields asterisk should be shown according to table
      | Name              | General Information | displayed |
      | Responsible Party | General Information | displayed |
      | Division          | General Information | displayed |
      | Workflow Group    | General Information | displayed |
    When User submits Third-party creation form
    Then Error message "This field is required" in red color is displayed on General Information section on field
      | Name |
    And Third-party sections color should be highlighted red
      | General Information |
      | Address             |
    When User fills third-party creation form with third-party's test data "with mandatory fields"
    And User submits Third-party creation form
    Then User verifies third-party is created

  @C50099852
  @core_regression
  Scenario: C50099852: [Configurable TP Fields] - Add - General and Other Information section - Custom fields verification
    When User navigates to Custom Fields page
    And User clicks Add Custom Field button
    Then Custom Field "Add" page is displayed
    When User populates in Custom Field Name with "AUTO_TEST_MultiSelect_"
    And User populates in Custom Field Description with "Auto Description 1"
    And User selects Custom Field - Field Type "MultiSelect" from dropdown
    And User switches Manage Data Values checkbox On
    And User fills in Custom Field choice #1 value "MultiSelect 1"
    And User fills in Custom Field choice #2 value "MultiSelect 2"
    And User fills in Custom Field choice #3 value "MultiSelect 3"
    And User clicks on 'Required' custom fields checkbox
    And User clicks Save button for Custom Field
    And User remembers created Custom field 1 in context
    And User clicks Add Custom Field button
    Then Custom Field "Add" page is displayed
    When User populates in Custom Field Name with "AUTO_TEST_SingleSelect_"
    And User populates in Custom Field Description with "Auto Description 2"
    And User selects Custom Field - Field Type "SingleSelect" from dropdown
    And User switches Manage Data Values checkbox On
    And User fills in Custom Field choice #1 value "SingleSelect 1"
    And User fills in Custom Field choice #2 value "SingleSelect 2"
    And User fills in Custom Field choice #3 value "SingleSelect 3"
    And User clicks Save button for Custom Field
    And User remembers created Custom field 2 in context
    And User navigates to Home page
    And User opens third-party creation form
    Then Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    And Fields asterisk should be shown according to table
      | Name                   | General Information | displayed     |
      | Responsible Party      | General Information | displayed     |
      | Division               | General Information | displayed     |
      | Workflow Group         | General Information | displayed     |
      | customFieldNameNumber1 | Other Information   | displayed     |
      | customFieldNameNumber2 | Other Information   | not displayed |
    When User submits Third-party creation form
    Then Third-party sections color should be highlighted red
      | General Information |
      | Address             |
      | Other Information   |
    When User fills third-party creation form with third-party's test data "with mandatory fields"
    And User expands "Other Information" section
    And User adds "MultiSelect 1" value to "customFieldNameNumber1" custom field
    And User submits Third-party creation form
    Then User verifies third-party is created

  @C50099850
  @core_regression
  Scenario: C50099850: [Configurable TP Fields] - Add - General and Other Information section - Cancel
    When User inactivates values for Third-party Segmentations Fields via API
    And User opens third-party creation form
    And User fills third-party creation form with third-party's test data "with random ID name"
    And User clicks 'Cancel' Add Third-party button
    Then Third-party "with random ID name" does not appear in the Third-party Overview table