@ui @suppliers
Feature: Third-party Information - Edit Third-party

  As a Supplier Integrity User
  I want I want to be able to create new Suppliers
  So that I can process the Suppliers that need to be Onboarded for the Organisation

  Background:
    Given User logs into RDDC as "Admin"

  @C35624707
  @RMS-28297
  @core_regression
  Scenario: C35624707: Supplier - Edit Third-party with complete details - Save changes
    When User creates third-party "with workflow group" via API and open it
    And User navigates to Third-party page
    And Current URL contains "/thirdparty" endpoint
    And User searches created third-party
    Then Third-party Overview tab is loaded
    When User clicks 'Edit' button on created third-party
    Then Renewal Cycle input field should be editable
    When User updates Renewal Cycle with value "1"
    And User clicks Assessment Details section "Save" button
    Then Assessment Details button "Save" is not displayed
    And Assessment Details button "Cancel" is not displayed
    And Renewal Cycle input field should be not editable
     #    TODO update step implementation when RMS-28297 will be fixed
    When User updates General Information section with values
      | Reference No. | Name                         | Company Type | Organisation Size | Date of Incorporation | Responsible Party             | Division   | Workflow Group      | Currency         | Industry Type               | Business Category    | Revenue      | Liquidation Date | Affiliation     |
      | toBeReplaced  | AUTO_TEST_EDITED_THIRD_PARTY | Company      | 11-50 employees   | 06/20/2021            | Assignee_AT_FN Assignee_AT_LN | Operations | Auto Workflow Group | ALL Albanian lek | Accident & Health Insurance | Property & Structure | toBeReplaced | 06/15/2021       | Publicly Traded |
    And User clicks General and Other Information section "Save" button
    Then General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    And General Information section details are displayed with populated data
    And User clicks General and Other Information section "Edit" button
    When User updates Third-party Segmentation section with values
      | Spend Category          | Design Agreement                 | Relationship Visibility                 | Commodity Type | Sourcing Method                                               | Sourcing Type  | Product Impact       |
      | Regularly sourcing from | Products purchased off the shelf | Little to no visibility of relationship | toBeReplaced   | Purchased through distribution or agent from multiple sources | Single sourced | Critical to business |
    And User clicks General and Other Information section "Save" button
    Then Third-party Segmentation section details are displayed with populated data
    Then General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    And User clicks General and Other Information section "Edit" button
    When User updates Bank Details on position 1 with values
      | Bank Name      | Account No.      | Branch Name      | Bank Address Line | Bank City | Bank Country |
      | Edit Bank Name | Edit Account No. | Edit Branch Name | Edit Address Line | Edit City | Afghanistan  |
    And User clicks General and Other Information section "Save" button
    Then Bank Details section details are displayed with populated data on position 1
    Then General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    And User clicks General and Other Information section "Edit" button
    When User updates Address section with values
      | Address Line      | City      | Zip/Postal Code      | State/Province      | Region | Country   |
      | Edit Address Line | Edit City | Edit Zip/Postal Code | Edit State/Province | toBeReplaced |         |
    And User clicks General and Other Information section "Save" button
    Then Address section details are displayed with populated data
    And User clicks General and Other Information section "Edit" button
    When User updates Contact section with values
      | Phone Number | Fax      | Website              | Email Address      |
      | 000000000000 | Edit Fax | http://edit@test.com | editEmail@test.com |
    And User clicks General and Other Information section "Save" button
    Then Contact section details are displayed with populated data
    Then General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    And User clicks General and Other Information section "Edit" button
    And User updates Description section with text "Some text"
    And User clicks General and Other Information section "Save" button
    Then Description section details are displayed with populated data

  @C35633476
  @full_regression
  Scenario: C35633476: Third-party - Edit Supplier from Third-party Information page
    When User creates third-party "with random ID name" via API and open it
    Then All Assessment Details section view fields are displayed
      | Renewal Cycle |
    And Onboarding Start Date field should be hidden
    And Onboarded Decision Date field should be hidden
    When User clicks Assessment Details section "Edit" button
    Then All Assessment Details section input fields are displayed
      | Renewal Cycle |
    And Assessment Details button "Save" is displayed
    And Assessment Details button "Cancel" is displayed
    And All General Information section view fields are displayed
      | Reference No.         |
      | Name                  |
      | Company Type          |
      | Organisation Size     |
      | Date of Incorporation |
      | Responsible Party     |
      | Division              |
      | Workflow Group        |
      | Currency              |
      | Industry Type         |
      | Business Category     |
      | Revenue               |
      | Liquidation Date      |
      | Affiliation           |
    Then All Third-party Segmentation section view fields are displayed
      | Spend Category          |
      | Design Agreement        |
      | Relationship Visibility |
      | Commodity Type          |
      | Sourcing Method         |
      | Sourcing Type           |
      | Product Impact          |
    And All Other Information section view fields are displayed
    And All Bank Details section view fields are displayed
      | Bank Name    |
      | Account No.  |
      | Branch Name  |
      | Address Line |
      | City         |
      | Country      |
    And All Address section view fields are displayed
      | Address Line    |
      | City            |
      | Zip/Postal Code |
      | State/Province  |
      | Region          |
      | Country         |
    Then All Contact section view fields are displayed
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |
    Then Description section text input area is not editable
    And General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    When User clicks General and Other Information section "Edit" button
    Then All General Information section input fields are displayed
      | Reference No.         |
      | Name                  |
      | Company Type          |
      | Organisation Size     |
      | Date of Incorporation |
      | Responsible Party     |
      | Division              |
      | Workflow Group        |
      | Currency              |
      | Industry Type         |
      | Business Category     |
      | Revenue               |
      | Liquidation Date      |
      | Affiliation           |
    Then All Third-party Segmentation section input fields are displayed
      | Spend Category          |
      | Design Agreement        |
      | Relationship Visibility |
      | Commodity Type          |
      | Sourcing Method         |
      | Sourcing Type           |
      | Product Impact          |
    And All Other Information section input fields are displayed
    And All Bank Details section input fields are displayed
      | Bank Name    |
      | Account No.  |
      | Branch Name  |
      | Address Line |
      | City         |
      | Country      |
    And All Address section input fields are displayed
      | Address Line    |
      | City            |
      | Zip/Postal Code |
      | State/Province  |
      | Region          |
      | Country         |
    Then All Contact section input fields are displayed
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |
    Then Description section text input area is editable
    And General and Other Information button "Save" is displayed
    And General and Other Information button "Cancel" is displayed

  @C35633673
  @full_regression
  Scenario: C35633673: Third-party - Edit Third-party - Edit Bank Details
    When User creates third-party "with random ID name" via API and open it
    And User waits for progress bar to disappear from page
    And User clicks General and Other Information section "Edit" button
    Then All Bank Details section input fields are displayed
      | Bank Name    |
      | Account No.  |
      | Branch Name  |
      | Address Line |
      | City         |
      | Country      |
    And General and Other Information button "Save" is displayed
    And General and Other Information button "Cancel" is displayed
    When User updates Bank Details on position 1 with values
      | Bank Name      | Account No.      | Branch Name      | Bank Address Line | Bank City | Bank Country |
      | Edit Bank Name | Edit Account No. | Edit Branch Name | Edit Address Line | Edit City | Afghanistan  |
    Then Add Bank Details button becomes active
    When User clicks Bank Details section "Add" button
    And User updates Bank Details on position 2 with values
      | Bank Name        | Account No.        | Branch Name        | Bank Address Line   | Bank City   | Bank Country |
      | Edit Bank Name 2 | Edit Account No. 2 | Edit Branch Name 2 | Edit Address Line 2 | Edit City 2 | Albania      |
    Then Remove Bank Details button for bank on position 1 is displayed
    And Remove Bank Details button for bank on position 2 is displayed
    When User clicks Remove Bank Details button for bank on position 2
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this bank detail? |
      | This change cannot be undone.                     |
    And Confirmation button Cancel should be displayed
    And Confirmation button Delete should be displayed
    When User clicks Delete button on confirmation window
    And User clicks General and Other Information section "Save" button
    Then Alert Icon is displayed with text
      | Success!                     |
      | Third-party has been updated |
    And Bank Details section details are displayed with populated data on position 1
    And Bank Details section details are not displayed with populated data on position 2
    When User clicks General and Other Information section "Edit" button
    And User clicks Bank Details section "Add" button
    And User updates Bank Details on position 2 with values
      | Bank Name        | Account No.        | Branch Name        | Bank Address Line   | Bank City   | Bank Country |
      | Edit Bank Name 2 | Edit Account No. 2 | Edit Branch Name 2 | Edit Address Line 2 | Edit City 2 | Albania      |
    And User clicks Remove Bank Details button for bank on position 2
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this bank detail? |
      | This change cannot be undone.                     |
    When User clicks Cancel button on confirmation window
    And User clicks General and Other Information section "Save" button
    Then Alert Icon is displayed with text
      | Success!                     |
      | Third-party has been updated |
    And General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    And Bank Details section details are displayed with populated data on position 1
    And Bank Details section details are displayed with populated data on position 2
    And All Bank Details section view fields are displayed
      | Bank Name    |
      | Account No.  |
      | Branch Name  |
      | Address Line |
      | City         |
      | Country      |

  @C35655260
  @full_regression
  Scenario: C35655260: Third-party - Edit Third-party - Validations for the editable fields
    When User creates third-party "with random ID name" via API and open it
    And User logs into RDDC as "Assignee"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks 'Edit' button on created third-party
    Then All General Information section input fields are displayed
      | Reference No.         |
      | Name                  |
      | Company Type          |
      | Organisation Size     |
      | Date of Incorporation |
      | Responsible Party     |
      | Division              |
      | Workflow Group        |
      | Currency              |
      | Industry Type         |
      | Business Category     |
      | Revenue               |
      | Liquidation Date      |
      | Affiliation           |
    And General and Other Information button "Save" is displayed
    And General and Other Information button "Cancel" is displayed
    And Division drop-down list contains enabled options
      | Operations |
    And Division drop-down list contains disabled options
      | MyDivision |
    And Delete button for "Operations" division is enabled
    And Delete button for "MyDivision" division is disabled
    When User clicks delete button for "Operations" division
    Then Division "Operation" is not selected

  @C35371560
  @full_regression
  Scenario: C35371560: Third-party - Edit Third-party - Add Other Names section - Verify
    When User creates third-party "with random ID name" via API and open it
    And Add Name mandatory text field is displayed
    And Add Name Type mandatory drop-down field is displayed with list
      | Local Language Name |
      | Doing Business As   |
      | Former Name         |
      | Subsidiary          |
      | Other Name          |
    When User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save                         |
      | Please complete the required fields |
    And Error message "This field is required" in red color is displayed near "Name"
    And Error message "This field is required" in red color is displayed near "Name Type"
    When User clicks on "Cancel Other Name button"
    And User creates Other name "with mandatory fields"
    And User creates Other name "with mandatory fields for editing"
    And User clicks on Edit Other Name Button for "Test Other Name For Editing" name
    And User fills in Name field value "Test Other Name"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save                   |
      | Test Other Name already exist |

  @C35629921
  @full_regression
  Scenario: C35629921: Supplier - Edit Third-party with complete details - Cancel change
    When User creates Custom Field "active with description and Text type" via API
    And User creates third-party "with random ID name" via API and open it
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks 'Edit' button on created third-party
    And User updates Renewal Cycle with value "1"
    And User clicks Assessment Details section "Cancel" button
    Then All Assessment Details section view fields are displayed
      | Renewal Cycle |
    And Onboarding Start Date field should be hidden
    And Onboarded Decision Date field should be hidden
    And Assessment Details button "Save" is not displayed
    And Assessment Details button "Cancel" is not displayed
    And Renewal Cycle is "0"
    When User updates General Information section with values
      | Reference No. | Name                         | Company Type | Organisation Size | Date of Incorporation | Responsible Party             | Division   | Workflow Group      | Currency         | Industry Type               | Business Category    | Revenue      | Liquidation Date | Affiliation     |
      | toBeReplaced  | AUTO_TEST_EDITED_THIRD_PARTY | Company      | 11-50 employees   | 06/20/2021            | Assignee_AT_FN Assignee_AT_LN | MyDivision | Auto Workflow Group | ALL Albanian lek | Accident & Health Insurance | Property & Structure | toBeReplaced | 06/15/2021       | Publicly Traded |
    And User clicks General and Other Information section "Cancel" button
    Then All General Information section view fields are displayed
      | Reference No.         |
      | Name                  |
      | Company Type          |
      | Organisation Size     |
      | Date of Incorporation |
      | Responsible Party     |
      | Division              |
      | Workflow Group        |
      | Currency              |
      | Industry Type         |
      | Business Category     |
      | Revenue               |
      | Liquidation Date      |
      | Affiliation           |
    And General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    And Current URL contains "/thirdparty/" endpoint
    And User clicks General and Other Information section "Edit" button
    When User updates Third-party Segmentation section with values
      | Spend Category          | Design Agreement                 | Relationship Visibility                 | Commodity Type | Sourcing Method                                               | Sourcing Type  | Product Impact       |
      | Regularly sourcing from | Products purchased off the shelf | Little to no visibility of relationship | toBeReplaced   | Purchased through distribution or agent from multiple sources | Single sourced | Critical to business |
    And User clicks General and Other Information section "Cancel" button
    Then All Third-party Segmentation section view fields are displayed
      | Spend Category          |
      | Design Agreement        |
      | Relationship Visibility |
      | Commodity Type          |
      | Sourcing Method         |
      | Sourcing Type           |
      | Product Impact          |
    And General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    And Current URL contains "/thirdparty/" endpoint
    And User clicks General and Other Information section "Edit" button
    And User expands "Other Information" section
    When User fills in "customFieldNameAPI" custom field value "some text"
    And User clicks General and Other Information section "Cancel" button
    Then All Other Information section view fields are displayed
    And General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    And Custom field "customFieldNameAPI" is empty
    And Current URL contains "/thirdparty/" endpoint
    And User clicks General and Other Information section "Edit" button
    When User updates Bank Details on position 1 with values
      | Bank Name      | Account No.      | Branch Name      | Bank Address Line | Bank City | Bank Country |
      | Edit Bank Name | Edit Account No. | Edit Branch Name | Edit Address Line | Edit City | Afghanistan  |
    And User clicks General and Other Information section "Cancel" button
    Then All Bank Details section view fields are displayed
      | Bank Name    |
      | Account No.  |
      | Branch Name  |
      | Address Line |
      | City         |
      | Country      |
    And General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    And Bank Details section details are not displayed with populated data on position 1
    And Current URL contains "/thirdparty/" endpoint
    And User clicks General and Other Information section "Edit" button
    When User updates Address section with values
      | Address Line      | City      | Zip/Postal Code      | State/Province      | Region       | Country |
      | Edit Address Line | Edit City | Edit Zip/Postal Code | Edit State/Province | toBeReplaced |         |
    And User clicks General and Other Information section "Cancel" button
    Then All Address section view fields are displayed
      | Address Line    |
      | City            |
      | Zip/Postal Code |
      | State/Province  |
      | Region          |
      | Country         |
    And General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    And Current URL contains "/thirdparty/" endpoint
    And User clicks General and Other Information section "Edit" button
    When User updates Contact section with values
      | Phone Number | Fax      | Website              | Email Address      |
      | 000000000000 | Edit Fax | http://www.test1.com | editEmail@test.com |
    And User clicks General and Other Information section "Cancel" button
    Then All Contact section view fields are displayed
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |
    And General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    And Current URL contains "/thirdparty/" endpoint
    And User clicks General and Other Information section "Edit" button
    And User updates Description section with text "Some text"
    And User clicks General and Other Information section "Cancel" button
    Then Description section text input area is not editable
    And General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    And Third-party Information details are displayed with populated data
    And Current URL contains "/thirdparty/" endpoint

  @C36977912
  @core_regression
  Scenario: C36977912: Internal User- Change currency input of Third-Party using type ahead feature
    When User creates third-party "with AED currency"
    Then Third-party Information details are displayed with populated data
    When User clicks General and Other Information section "Edit" button
    And User updates General Information section with values
      | Currency                 |
      | USD United States dollar |
    And User clicks General and Other Information section "Save" button
    Then Alert Icon is displayed with text
      | Success!                     |
      | Third-party has been updated |
    And General Information section details are displayed with populated data

  @C36977913
  @core_regression
  Scenario: C36977913: Internal User- Revert back the currency input of Third-Party using type
    When User creates third-party "with AED currency"
    Then Third-party Information details are displayed with populated data
    When User clicks General and Other Information section "Edit" button
    And User updates General Information section with values
      | Currency                 |
      | USD United States dollar |
    And User clicks General and Other Information section "Save" button
    Then General Information section details are displayed with populated data
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks General and Other Information section "Edit" button
    And User updates General Information section with values
      | Currency                        |
      | AED United Arab Emirates dirham |
    And User clicks General and Other Information section "Save" button
    Then General Information section details are displayed with populated data
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then General Information section details are displayed with populated data

  @C50045275
  @core_regression
  Scenario: C50045275: [Configurable TP Fields] - Edit - General and Other Information section - All fields displayed - Optional
    When User creates third-party "with mandatory fields"
    And User clicks General and Other Information section "Edit" button
    Then Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    When User collapses section "General and Other Information" for third-party
    Then General and Other Information inner sections are not displayed
    When User expands section "General and Other Information" for third-party
    Then General and Other Information inner sections are displayed
    When User clicks General and Other Information section "Save" button
    Then General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    When User clicks General and Other Information section "Edit" button
    And User updates General Information section with values
      | Currency                 | Reference No. | Industry Type | Organisation Size |
      | USD United States dollar | 1             | Aerospace     | 1-10 employees    |
    And User clicks General and Other Information section "Save" button
    Then General Information section details are displayed with populated data
    When User expands section "Third-party Segmentation" for third-party
    And User collapses section "General and Other Information" for third-party
    And User expands section "General and Other Information" for third-party
    Then Third-Party section should be in correct state
      | General Information      | collapsed |
      | Third-party Segmentation | expanded  |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    When User collapses section "General and Other Information" for third-party
    And User clicks on Risk Management tab
    Then Workflow History table shows 'No Available Data' message
    When User clicks on Third-party Information tab
    And User expands section "General and Other Information" for third-party
    Then Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    When User clicks General and Other Information section "Edit" button
    And User expands section "Bank Details" for third-party
    And User updates Address section with values
      | Address Line      | City      | Zip/Postal Code      | State/Province      | Region       | Country |
      | Edit Address Line | Edit City | Edit Zip/Postal Code | Edit State/Province | toBeReplaced |         |
    And User clicks General and Other Information section "Save" button
    Then Address section details are displayed with populated data

  @C50115987
  @core_regression
  @onlySingleThread
  Scenario: C50115987: [Configurable TP Fields] - Edit - General and Other Information section - All fields displayed - Required
    When User sets required values for General Information and Third-party Segmentations Fields via API
    And User refreshes Third-party Fields page
    And User creates third-party "with complete General Information and TP Segmentation and country Ukraine"
    And User clicks General and Other Information section "Edit" button
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
    When User clears next fields values
      | Workflow Group    |
      | Industry Type     |
      | Currency          |
      | Company Type      |
      | Business Category |
      | Affiliation       |
      | Organisation Size |
      | Revenue           |
    And User clicks General and Other Information section "Save" button
    Then Error message "This field is required" in red color is displayed on General Information section on field
      | Workflow Group    |
      | Industry Type     |
      | Currency          |
      | Company Type      |
      | Business Category |
      | Affiliation       |
      | Organisation Size |
      | Revenue           |
    And Third-party sections color should be highlighted red
      | General Information |
    When User updates General Information section with values
      | Company Type | Currency                        | Workflow Group      | Industry Type               | Business Category    | Affiliation        | Organisation Size | Revenue      |
      | Corporation  | AED United Arab Emirates dirham | Auto Workflow Group | Accident & Health Insurance | Property & Structure | State Owned Entity | 1-10 employees    | toBeReplaced |
    And User clicks General and Other Information section "Save" button
    And User clicks General and Other Information section "Edit" button
    And User expands "Third-party Segmentation" section
    And User clears next fields values
      | Spend Category          |
      | Design Agreement        |
      | Relationship Visibility |
      | Commodity Type          |
      | Sourcing Method         |
      | Sourcing Type           |
      | Product Impact          |
    And User clicks General and Other Information section "Save" button
    Then Error message "This field is required" in red color is displayed on General Information section on field
      | Spend Category          |
      | Design Agreement        |
      | Relationship Visibility |
      | Commodity Type          |
      | Sourcing Method         |
      | Sourcing Type           |
      | Product Impact          |
    And Third-party sections color should be highlighted red
      | Third-party Segmentation |
    When User updates Third-party Segmentation section with values
      | Spend Category          | Design Agreement                 | Relationship Visibility                                 | Commodity Type | Sourcing Method                         | Sourcing Type              | Product Impact                                  |
      | Regularly sourcing from | Products purchased off the shelf | Products rebranded from Original Equipment Manufacturer | toBeReplaced   | Directly sourced with contract in place | Multiple sources available | Alternate sources require qualification process |
    And User clicks General and Other Information section "Save" button
    Then Save button is disappeared

  @C50116084 @C50542806
  @core_regression
  @onlySingleThread
  Scenario: C50116084 C50542806: [Configurable TP Fields] - Edit - General and Other Information section - All Sub-section does not have active fields
    When User inactivates values for Third-party Segmentations Fields via API
    And User creates third-party "with mandatory fields"
    And User clicks General and Other Information section "Edit" button
    Then Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | hidden    |
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
    When User clears next fields values
      | Workflow Group    |
      | Industry Type     |
      | Currency          |
      | Company Type      |
      | Business Category |
      | Affiliation       |
      | Organisation Size |
      | Revenue           |
    And User expands "Address" section
    And User clears next fields values
      | Country |
    And User clicks General and Other Information section "Save" button
    Then Error message "This field is required" in red color is displayed on Address section on field
      | Country |
    And Third-party sections color should be highlighted red
      | General Information |
      | Address             |
    When User updates Address section with values
      | Country |
      | Ukraine |
    And User expands "General Information" section
    And User updates General Information section with values
      | Company Type | Currency                        | Workflow Group      | Industry Type               | Business Category    | Affiliation        | Organisation Size | Revenue      |
      | Corporation  | AED United Arab Emirates dirham | Auto Workflow Group | Accident & Health Insurance | Property & Structure | State Owned Entity | 1-10 employees    | toBeReplaced |
    And User clicks General and Other Information section "Save" button
    Then Save button is disappeared

  @C50542954
  @core_regression
  @onlySingleThread
  Scenario: C50542954: [Configurable TP Fields] - Edit - General and Other Information section - Bank Details
    When User sets defaults values with required Bank Details and Contacts for Third-party Fields via API
    And User refreshes page
    And User creates third-party "with Complete Details and country Ukraine"
    And User clicks General and Other Information section "Edit" button
    And User expands "Bank Details" section
    Then Fields asterisk should be shown according to table
      | Bank Name   | Bank Details | displayed |
      | Account No. | Bank Details | displayed |
    And Third Party Bank Details section fields are shown according to table
      | Bank Name    | displayed |
      | Account No.  | displayed |
      | Branch Name  | displayed |
      | Address Line | displayed |
      | City         | displayed |
      | Country      | displayed |
    And Add Bank Details button becomes active
    When User clears next fields values
      | Bank Name    |
      | Account No.  |
      | Branch Name  |
      | Address Line |
      | City         |
      | Country      |
    Then Add Bank Details button is inactive
    When User clears next fields values
      | Bank Name   |
      | Account No. |
    And User updates Bank Details on position 1 with values
      | Bank Name      | Account No.      |
      | Edit Bank Name | Edit Account No. |
    And User clicks Bank Details section "Add" button
    And User updates Bank Details on position 2 with values
      | Bank Name        | Account No.        |
      | Edit Bank Name 2 | Edit Account No. 2 |
    And User expands "Contact" section
    Then Fields asterisk should be shown according to table
      | Phone Number  | Contact | displayed |
      | Fax           | Contact | displayed |
      | Website       | Contact | displayed |
      | Email Address | Contact | displayed |
    When User clears next fields values
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |
    Then Contact add fields button should be in next states
      | Add Phone Number  | disabled |
      | Add Fax           | disabled |
      | Add Website       | disabled |
      | Add Email Address | disabled |
    When User updates Contact section with values
      | Phone Number | Fax      | Website              | Email Address      |
      | 000000000000 | Edit Fax | http://edit@test.com | editEmail@test.com |
    Then Contact add fields button should be in next states
      | Add Phone Number  | enabled |
      | Add Fax           | enabled |
      | Add Website       | enabled |
      | Add Email Address | enabled |
    When User clicks General and Other Information section "Save" button
    Then Save button is disappeared
