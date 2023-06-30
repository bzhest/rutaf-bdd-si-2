@ui @full_regression @thirdPartyFields
Feature: Third Party Fields

  As a user
  I want to see Third-party Fields set up page
  So that I can config visibility and mandatory fields for TP

  @C49960265
  Scenario: C49960265: [Fields Management] - View Third-Party Fields page
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User clicks Third-party Fields in Set Up menu
    Then Third-party Fields page is displayed
    And Information message is displayed with text on top of Third-party Fields page
      | Any changes to the configurable fields will not be reflected in third-parties |
      | that have onboarding or renewing statuses.                                    |
    And Save button is displayed on Third-party Fields page
    And Reset button is displayed on Third-party Fields page
    And Dismiss button is displayed on Third-party Fields page
    When User clicks on 'Dismiss' button for information message on top of Third-party Fields page
    Then Information message is not displayed with text on top of Third-party Fields page
      | Any changes to the configurable fields will not be reflected in third-parties |
      | that have onboarding or renewing statuses.                                    |
    And "General Information" table contains values
      | Name                  |
      | Reference No.         |
      | Industry Type         |
      | Date of Incorporation |
      | Responsible Party     |
      | Currency              |
      | Liquidation Date      |
      | Company Type          |
      | Division              |
      | Business Category     |
      | Affiliation           |
      | Organisation Size     |
      | Workflow Group        |
      | Revenue               |
    And 'Required' checkboxes for default required fields are disabled and checked in "General Information" table
      | Name              |
      | Responsible Party |
      | Division          |
      | Workflow Group    |
    And 'Active' checkboxes for default required fields are disabled and checked in "General Information" table
      | Name              |
      | Responsible Party |
      | Division          |
      | Workflow Group    |
    And "Third-party Segmentation" table contains values
      | Spend Category          |
      | Design Agreement        |
      | Relationship Visibility |
      | Commodity Type          |
      | Sourcing Method         |
      | Sourcing Type           |
      | Product Impact          |
    And "Bank Details" table contains values
      | Bank Name    |
      | Account No.  |
      | Branch Name  |
      | Address Line |
      | City         |
      | Country      |
    And "Address" table contains values
      | Address Line    |
      | City            |
      | State/Province  |
      | Zip/Postal code |
      | Region          |
      | Country         |
    And 'Required' checkboxes for default required fields are disabled and checked in "Address" table
      | Country |
    And 'Active' checkboxes for default required fields are disabled and checked in "Address" table
      | Country |
    And "Contact" table contains values
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |
    And "Description" table contains values
      | Description |
    And Current URL contains "/ui/admin/fields-management/third-party-fields" endpoint

  @C49962197
  @onlySingleThread
  Scenario: C49962197: [Fields Management] - Edit Third-Party fields - Save
    Given User logs into RDDC as "Admin"
    When User set default values for Third-party Fields via API
    And User clicks Set Up option
    And User clicks Third-party Fields in Set Up menu
    Then Third-party Fields page is displayed
    When User clicks checkboxes in "Active" column of "General Information" table for fields
      | Reference No. |
      | Currency      |
    And User clicks checkboxes in "Required" column of "Address" table for fields
      | Region |
      | City   |
    And User clicks 'Save' button for Third-party Fields
    Then Alert Icon is displayed with text
      | Success!                                |
      | Third party field(s) have been updated. |
    And Third-party Fields page is displayed
    When User clicks on 'Dismiss' button for information message on top of Third-party Fields page
    And User opens Value Management page
    And User clicks Third-party Fields in Set Up menu
    Then Third-party Fields page is displayed
    And Information message is displayed with text on top of Third-party Fields page
      | Any changes to the configurable fields will not be reflected in third-parties |
      | that have onboarding or renewing statuses.                                    |
    And Checkboxes are unchecked in 'Active' column of "General Information" table for fields
      | Reference No. |
      | Currency      |
    And Checkboxes are checked in 'Required' column of "Address" table for fields
      | Region |
      | City   |
    And Checkboxes are checked in 'Active' column of "Address" table for fields
      | Region |
      | City   |
      # Optional steps to return default values in TP-Fields
    When User set default values for Third-party Fields via API
    Then Third-party Fields page is displayed

  @C49966307
  @onlySingleThread
  Scenario: C49966307: [Fields Management] - Edit Third-Party Fields - Checkboxes behavior
    Given User logs into RDDC as "Admin"
    When User set default values for Third-party Fields via API
    And User clicks Set Up option
    And User clicks Third-party Fields in Set Up menu
    Then Third-party Fields page is displayed
    And "General Information" table contains default values for fields
    And "Third-party Segmentation" table contains default values for fields
    And "Bank Details" table contains default values for fields
    And "Address" table contains default values for fields
    And "Contact" table contains default values for fields
    And "Description" table contains default values for fields
      # 1st case, "Possible to select only Active"
    When User clicks checkboxes in "Active" column of "General Information" table for fields
      | Industry Type |
      | Currency      |
    Then Checkboxes are unchecked in 'Active' column of "General Information" table for fields
      | Industry Type |
      | Currency      |
    And Checkboxes are unchecked in 'Required' column of "General Information" table for fields
      | Industry Type |
      | Currency      |
    When User clicks checkboxes in "Active" column of "General Information" table for fields
      | Industry Type |
      | Currency      |
    Then Checkboxes are checked in 'Active' column of "General Information" table for fields
      | Industry Type |
      | Currency      |
    And Checkboxes are unchecked in 'Required' column of "General Information" table for fields
      | Industry Type |
      | Currency      |
      # 2nd case, "Possible to select Active and Required"
    When User clicks checkboxes in "Required" column of "General Information" table for fields
      | Industry Type |
      | Currency      |
    Then Checkboxes are checked in 'Active' column of "General Information" table for fields
      | Industry Type |
      | Currency      |
    And Checkboxes are checked in 'Required' column of "General Information" table for fields
      | Industry Type |
      | Currency      |
      # 3rd case, "Possible to select Required (Active is selected automatically)"
    When User clicks checkboxes in "Active" column of "Address" table for fields
      | Region |
      | City   |
    And User clicks checkboxes in "Required" column of "Address" table for fields
      | Region |
      | City   |
    Then Checkboxes are checked in 'Active' column of "Address" table for fields
      | Region |
      | City   |
    And Checkboxes are checked in 'Required' column of "Address" table for fields
      | Region |
      | City   |
      # 4th case, "Possible unselect Required (Active is not changed)"
    When User clicks checkboxes in "Required" column of "Bank Details" table for fields
      | Bank Name   |
      | Branch Name |
    Then Checkboxes are checked in 'Required' column of "Bank Details" table for fields
      | Bank Name   |
      | Branch Name |
    When User clicks checkboxes in "Required" column of "Bank Details" table for fields
      | Bank Name   |
      | Branch Name |
    Then Checkboxes are unchecked in 'Required' column of "Bank Details" table for fields
      | Bank Name   |
      | Branch Name |
    And Checkboxes are checked in 'Active' column of "Bank Details" table for fields
      | Bank Name   |
      | Branch Name |
      # 5th case, Possible to unselect Active (Required is unselected automatically)
    When User clicks checkboxes in "Required" column of "Contact" table for fields
      | Fax     |
      | Website |
    And User clicks checkboxes in "Active" column of "Contact" table for fields
      | Fax     |
      | Website |
    Then Checkboxes are unchecked in 'Active' column of "Contact" table for fields
      | Fax     |
      | Website |
    And Checkboxes are unchecked in 'Required' column of "Contact" table for fields
      | Fax     |
      | Website |
    When User clicks 'Save' button for Third-party Fields
    And User refreshes Third-party Fields page
    Then Third-party Fields page is displayed
    And Checkboxes are checked in 'Active' column of "General Information" table for fields
      | Industry Type |
      | Currency      |
    And Checkboxes are checked in 'Required' column of "General Information" table for fields
      | Industry Type |
      | Currency      |
    And Checkboxes are checked in 'Active' column of "Address" table for fields
      | Region |
      | City   |
    And Checkboxes are checked in 'Required' column of "Address" table for fields
      | Region |
      | City   |
    And Checkboxes are unchecked in 'Required' column of "Bank Details" table for fields
      | Bank Name   |
      | Branch Name |
    And Checkboxes are checked in 'Active' column of "Bank Details" table for fields
      | Bank Name   |
      | Branch Name |
    And Checkboxes are unchecked in 'Active' column of "Contact" table for fields
      | Fax     |
      | Website |
    And Checkboxes are unchecked in 'Required' column of "Contact" table for fields
      | Fax     |
      | Website |
      # Optional steps to return default values in TP-Fields
    When User set default values for Third-party Fields via API
    Then Third-party Fields page is displayed

  @C50033243
  @onlySingleThread
  Scenario: C50033243: [Fields Management] - Edit Third-Party Fields - Check applying for TP
    Given User logs into RDDC as "Admin"
    When User set default values for Third-party Fields via API
    And User clicks Set Up option
    And User clicks Third-party Fields in Set Up menu
    Then Third-party Fields page is displayed
    When User clicks checkboxes in "Active" column of "General Information" table for fields
      | Currency |
      | Revenue  |
    And User clicks checkboxes in "Required" column of "General Information" table for fields
      | Currency |
      | Revenue  |
    And User clicks checkboxes in "Required" column of "General Information" table for fields
      | Currency |
      | Revenue  |
    And User clicks checkboxes in "Required" column of "Bank Details" table for fields
      | Bank Name   |
      | Branch Name |
    And User clicks checkboxes in "Active" column of "Contact" table for fields
      | Fax     |
      | Website |
    And User clicks 'Save' button for Third-party Fields
    Then Third-party Fields page is displayed
    And Checkboxes are checked in 'Active' column of "General Information" table for fields
      | Currency |
      | Revenue  |
    And Checkboxes are unchecked in 'Required' column of "General Information" table for fields
      | Currency |
      | Revenue  |
    And Checkboxes are checked in 'Active' column of "Bank Details" table for fields
      | Bank Name   |
      | Branch Name |
    And Checkboxes are checked in 'Required' column of "Bank Details" table for fields
      | Bank Name   |
      | Branch Name |
    And Checkboxes are unchecked in 'Active' column of "Contact" table for fields
      | Fax     |
      | Website |
    And Checkboxes are unchecked in 'Required' column of "Contact" table for fields
      | Fax     |
      | Website |
    When User navigates to Third-party page
    And User clicks Add Third-party button
    Then Third-party Information should have General Information fields
      | Name | Responsible Party | Division | Workflow Group | Currency | Revenue |
    And Asterisk is displayed for "Name" field of "General Information" section
    And Asterisk is displayed for "Responsible Party" field of "General Information" section
    And Asterisk is displayed for "Division" field of "General Information" section
    And Asterisk is displayed for "Workflow Group" field of "General Information" section
    And Third-party Information should have Bank Details fields
      | Bank Name | Branch Name |
    And Asterisk is displayed for "Bank Name" field of "Bank Details" section
    And Asterisk is displayed for "Branch Name" field of "Bank Details" section
    And Asterisk is displayed for "Country" field of "Address" section
    And Third-party Information should not have Contact fields
      | Fax | Website |
    When User fills third-party creation form with third-party's test data "with workflow group, random ID name, Zimbabwe country and Bank Details"
    And User submits Third-party creation form
    And User clicks General and Other Information section "Edit" button
    Then Third-party Information should have General Information fields
      | Name | Responsible Party | Division | Workflow Group | Currency | Revenue |
    And Asterisk is displayed for "Name" field of "General Information" section
    And Asterisk is displayed for "Responsible Party" field of "General Information" section
    And Asterisk is displayed for "Division" field of "General Information" section
    And Asterisk is displayed for "Workflow Group" field of "General Information" section
    And Third-party Information should have Bank Details fields
      | Bank Name | Branch Name |
    And Asterisk is displayed for "Bank Name" field of "Bank Details" section
    And Asterisk is displayed for "Branch Name" field of "Bank Details" section
    And Asterisk is displayed for "Country" field of "Address" section
    And Third-party Information should not have Contact fields
      | Fax | Website |
    When User clicks General and Other Information section "Cancel" button
    Then Third-party Information should have General Information fields
      | Name | Responsible Party | Division | Workflow Group | Currency | Revenue |
    And Third-party Information should have Bank Details fields
      | Bank Name | Branch Name |
    And Third-party Information should have Address fields
      | Country |
    And Third-party Information should not have Contact fields
      | Fax | Website |
    When User clicks Start Onboarding for third-party
    Then Third-party Information should have General Information fields
      | Name | Responsible Party | Division | Workflow Group | Currency | Revenue |
    And Third-party Information should have Bank Details fields
      | Bank Name | Branch Name |
    And Third-party Information should have Address fields
      | Country |
    And Third-party Information should not have Contact fields
      | Fax | Website |