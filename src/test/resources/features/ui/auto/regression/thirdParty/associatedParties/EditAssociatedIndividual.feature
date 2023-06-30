@ui @suppliers
Feature: Third-party Contact - Edit Contact

  As a Supplier Integrity User managing Supplier records
  I want I want to be able to edit the information of a Supplier Contact
  So that I can make changes to the Supplier Contact details when necessary

  Background:
    Given User logs into RDDC as "Admin"

  @C37108920
  @core_regression
  Scenario: C37108920: Third-party Associated individual - Edit full information from Edit Associated individual page
    When User creates valid email
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "with valid email"
    And User clicks Associated Party Overview contact button
    And User clicks edit contact with name "Test_First_Name"
    Then Associated Party's Email Address field is editable
    When User updates Associated Party's General Information section with values
      | Title      | First Name      | Last Name      | Middle Name      |
      | Edit Title | Edit First Name | Edit Last Name | Edit Middle Name |
    And User clicks Associated Party's General Information section "Cancel" button
    Then General Information section "Cancel" button is not displayed
    And General Information section "Save" button is not displayed
    And Associated Party's General Information section details are displayed with data
      | Title | First Name      | Last Name      | Middle Name |
      |       | Test_First_Name | Test_Last_Name |             |
    When User clicks Associated Party's General Information section "Edit" button
    And User updates Associated Party's General Information section with values
      | Title      | First Name      | Last Name      | Middle Name      |
      | Edit Title | Edit First Name | Edit Last Name | Edit Middle Name |
    And User clicks Associated Party's General Information section "Save" button
    Then Associated Party's General Information section details are displayed with populated data
    And General Information section "Cancel" button is not displayed
    And General Information section "Save" button is not displayed
    When User updates Associated Party's Address section on position 1 with values
      | Address Line      | City      | Zip/Postal Code      | State/Province      | Region       | Country |
      | Edit Address Line | Edit City | Edit Zip/Postal Code | Edit State/Province | toBeReplaced |         |
    And User clicks Associated Party's Address section "Cancel" button
    Then Address section "Cancel" button is not displayed
    And Address section "Save" button is not displayed
    And Associated Party's Address section details are displayed with data
      | Address Line | City | Zip/Postal Code | State/Province | Region | Country |
      |              |      |                 |                |        |         |
    When User clicks Associated Party's Address section "Edit" button
    And User updates Associated Party's Address section on position 1 with values
      | Address Line      | City      | Zip/Postal Code      | State/Province      | Region       | Country |
      | Edit Address Line | Edit City | Edit Zip/Postal Code | Edit State/Province | toBeReplaced |         |
    And User clicks Associated Party's Address section "Save" button
    And Associated Party's Address section details are displayed with populated data
    And Address section "Cancel" button is not displayed
    And Address section "Save" button is not displayed
    And User updates Associated Party's Contact section with values
      | Phone Number | Fax      | Website                  | Email Address |
      | 000000000000 | Edit Fax | http://www.edittest1.com | email         |
    And User clicks Associated Party's Contact section "Cancel" button
    Then Contact section "Cancel" button is not displayed
    And Contact section "Save" button is not displayed
    And Associated Party's Contact section details are displayed with data
      | Phone Number | Fax | Website | Email Address |
      |              |     |         | email         |
    When User clicks Associated Party's Contact section "Edit" button
    And User updates Associated Party's Contact section with values
      | Phone Number | Fax      | Website                  | Email Address |
      | 000000000000 | Edit Fax | http://www.edittest1.com | email         |
    When User checks 'Enabled as User' checkbox on Add contact screen
    And User clicks Associated Party's Contact section "Save" button
    And User clicks Associated Party's Contact section "Edit" button
    Then Associated Party's Email Address field is read-only
    And User clicks Associated Party's Contact section "Save" button
    And Associated Party's Contact section details are displayed with populated data
    And Contact section "Cancel" button is not displayed
    And Contact section "Save" button is not displayed
    And Add Name mandatory text field is displayed
    And Add Name Type mandatory drop-down field is displayed with list
      | Also Known As     |
      | Locally Known As  |
      | Formerly Known As |
    And Other Name Check Type checkbox fields are displayed with options
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    And Add "Country of Location" drop-down field is displayed with list of countries from WC1
    And Add "Citizenship" drop-down field is displayed with list of countries from WC1
    And Add "Place of Birth" drop-down field is displayed with list of countries from WC1
    And "Other Names Add|Save button" for other name is displayed
    And "Cancel Other Name button" for other name is displayed
    When User clicks on "Other Names Add|Save button"
    And Error message "This field is required" in red color is displayed near "Name"
    And Error message "This field is required" in red color is displayed near "Name Type"
    When User fills in Name field value "Test Other Name"
    And User selects Name type "Also Known As"
    Then Selected Name type "Also Known As" is disabled
    When User clicks on "Other Names Add|Save button"
    And Other Name dialog is loaded
    When User clicks Close Other Name Results button
    Then "Other Names Table" for other name is displayed
    And Other Name table is displayed with column names
      | NAME | NAME TYPE | DATE CREATED | LAST UPDATE |
    And Other Name table contains expected values
      | Test Other Name |
      | Also Known As   |
      | MM/dd/YYYY      |
      | MM/dd/YYYY      |
    And Edit Other Name button is displayed in the Other Names section after each record
    And Delete Other Name button is displayed in the Other Names section after each record
    And User fills in Associated Party's Description text "Description text"
    And User clicks Associated Party's Description section "Cancel" button
    Then Description section "Cancel" button is not displayed
    And Description section "Save" button is not displayed
    And Associated Party's Description section is not populated
    When User clicks Associated Party's Description section "Edit" button
    And User fills in Associated Party's Description text "Description text"
    And User clicks Associated Party's Description section "Save" button
    And Description section "Cancel" button is not displayed
    And Description section "Save" button is not displayed
    And Associated Party's Description section is populated with text "Description text"

  @C35742979
  @full_regression
  Scenario: C35742979: [TO CHECK] Third-party/Third-party Associated individual - Only eligible users can edit Associated individual
    When User creates third-party "with Operations division" via API and open it
    And User creates Associated Party "Individual" "with matched results" via API and open it
    And User navigates to Third-party page
    And User creates third-party "with MyDivision" via API and open it
    And User creates Associated Party "Individual" "with matched results" via API and open it
    And User navigates to Third-party page
    And User creates third-party "with MyDivision division and Admin double responsible party" via API and open it
    And User creates Associated Party "Individual" "with matched results" via API and open it
    And User clicks Log Out button
    And User logs into RDDC as "user without onboarding and renewal accesses"
    And User navigates to Third-party page
    And User clicks third-party with reference "with MyDivision"
    And User clicks on "Associated Parties" tab on Third-party page
    Then Edit button is not displayed for contact "with matched results"
    And User logs into RDDC as "Assignee"
    And User navigates to Third-party page
    Then Third-party "with MyDivision" does not appear in the Third-party Overview table
    When User clicks Log Out button
    And User logs into RDDC as "Admin double"
    And User navigates to Third-party page
    Then Third-party with reference "with MyDivision" is displayed in Third-party overview table
    When User clicks third-party with reference "with MyDivision division and Admin double responsible party"
    And User clicks on "Associated Parties" tab on Third-party page
    Then "Edit" tooltip is displayed when hover over edit button for contact "with matched results"
    And Edit button is enabled for contact "with matched results"

  @C35740761
  @full_regression
  Scenario: C35740761: Third-party Associated individual - Edit Third-party Associated individual- overview of Edit page
    When User creates valid email
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Individual" "with matched results" via API and open it
    And User clicks Associated Party Overview contact button
    And User clicks edit contact with name "Vladimir"
    And Current URL contains "/thirdparty/" endpoint
    And General Information section "Cancel" button is displayed
    And General Information section "Save" button is displayed
    And All Associated Party General Information section input fields are displayed
      | Title       |
      | First Name  |
      | Last Name   |
      | Middle Name |
    And Address section "Cancel" button is displayed
    And Address section "Save" button is displayed
    And All Associated Party Address section input fields are displayed
      | Address Line    |
      | City            |
      | Zip/Postal Code |
      | State/Province  |
      | Region          |
      | Country         |
    And Contact section "Cancel" button is displayed
    And Contact section "Save" button is displayed
    And All Associated Party Contact section input fields are displayed
      | Phone Number |
      | Fax          |
      | Website      |
    And Associated Party's Email Address field is editable
    When User enters Associated Party email with value "email"
    When User checks 'Enabled as User' checkbox on Add contact screen
    And User clicks Associated Party's Contact section "Save" button
    And User clicks Associated Party's Contact section "Edit" button
    Then Associated Party's Email Address field is read-only
    And "Other Names Add|Save button" for other name is displayed
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And Screening section Change Search Criteria button is displayed
    And Screening section Bell icon is displayed
    And Screening section Ongoing Screening slider is displayed
    And Screening section table displays expected columns
      | thirdPartyInformation.screening.columnName              |
      | thirdPartyInformation.screening.columnCountryOfLocation |
      | thirdPartyInformation.screening.columnType              |
      | thirdPartyInformation.screening.columnMatchStrength     |
      | thirdPartyInformation.screening.columnDataProvider      |
      | thirdPartyInformation.screening.columnReferenceId       |
      | thirdPartyInformation.screening.columnResolution        |
    And Associated Party contains a sub-section Description with input field

  @C35743354
  @full_regression
  Scenario: C35743354: Third-party Associated individual - Edit full information from Contact overview page
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Individual" "with matched results" via API and open it
    And User clicks Associated Party's General Information section "Edit" button
    Then Current URL contains "/thirdparty/" endpoint
    And General Information section "Cancel" button is displayed
    And General Information section "Save" button is displayed
    And All Associated Party General Information section input fields are displayed
      | Title       |
      | First Name  |
      | Last Name   |
      | Middle Name |
    When User updates Associated Party's General Information section with values
      | Title      | First Name      | Last Name      | Middle Name      |
      | Edit Title | Edit First Name | Edit Last Name | Edit Middle Name |
    And User clicks Associated Party's General Information section "Cancel" button
    Then General Information section "Cancel" button is not displayed
    And General Information section "Save" button is not displayed
    And All Associated Party General Information section view fields are displayed
      | Title       |
      | First Name  |
      | Last Name   |
      | Middle Name |
    And Associated Party's General Information section details are displayed with data
      | Title | First Name | Last Name | Middle Name |
      |       | Vladimir   | P         |             |
    When User clicks Associated Party's General Information section "Edit" button
    And User updates Associated Party's General Information section with values
      | Title      | First Name      | Last Name      | Middle Name      |
      | Edit Title | Edit First Name | Edit Last Name | Edit Middle Name |
    And User clicks Associated Party's General Information section "Save" button
    Then Current URL contains "/thirdparty/" endpoint
    And General Information section "Save" button is not displayed
    And General Information section "Cancel" button is not displayed
    And All Associated Party General Information section view fields are displayed
      | Title       |
      | First Name  |
      | Last Name   |
      | Middle Name |
    And Associated Party's General Information section details are displayed with data
      | Title      | First Name      | Last Name      | Middle Name      |
      | Edit Title | Edit First Name | Edit Last Name | Edit Middle Name |
    When User clicks Associated Party's Address section "Edit" button
    Then Current URL contains "/thirdparty/" endpoint
    And Address section "Cancel" button is displayed
    And Address section "Save" button is displayed
    And All Associated Party Address section input fields are displayed
      | Address Line    |
      | City            |
      | Zip/Postal Code |
      | State/Province  |
      | Region          |
      | Country         |
    When User updates Associated Party's Address section on position 1 with values
      | Address Line      | City      | Zip/Postal Code      | State/Province      | Region       | Country |
      | Edit Address Line | Edit City | Edit Zip/Postal Code | Edit State/Province | toBeReplaced |         |
    And User clicks Associated Party's Address section "Cancel" button
    Then Address section "Cancel" button is not displayed
    And Address section "Save" button is not displayed
    And All Associated Party Address section view fields are displayed
      | Address Line    |
      | City            |
      | Zip/Postal Code |
      | State/Province  |
      | Region          |
      | Country         |
    And Associated Party's Address section details are displayed with data
      | Address Line | City | Zip/Postal Code | State/Province | Region | Country |
      |              |      |                 |                |        | Ukraine |
    When User clicks Associated Party's Address section "Edit" button
    And User updates Associated Party's Address section on position 1 with values
      | Address Line      | City      | Zip/Postal Code      | State/Province      | Region       | Country |
      | Edit Address Line | Edit City | Edit Zip/Postal code | Edit State/Province | toBeReplaced |         |
    And User clicks Associated Party's Address section "Save" button
    Then Current URL contains "/thirdparty/" endpoint
    And Address section "Save" button is not displayed
    And Address section "Cancel" button is not displayed
    And All Associated Party Address section view fields are displayed
      | Address Line    |
      | City            |
      | Zip/Postal Code |
      | State/Province  |
      | Region          |
      | Country         |
    And Associated Party's Address section details are displayed with data
      | Address Line      | City      | Zip/Postal Code      | State/Province      | Region       | Country |
      | Edit Address Line | Edit City | Edit Zip/Postal code | Edit State/Province | toBeReplaced |         |
    When User clicks Associated Party's Contact section "Edit" button
    Then Current URL contains "/thirdparty/" endpoint
    And Contact section "Cancel" button is displayed
    And Contact section "Save" button is displayed
    And All Associated Party Contact section input fields are displayed
      | Phone Number |
      | Fax          |
      | Website      |
    When User updates Associated Party's Contact section with values
      | Phone Number | Fax      | Website             | Email Address    |
      | 000000000000 | Edit Fax | http://www.test.com | test@example.com |
    And User clicks Associated Party's Contact section "Cancel" button
    Then Contact section "Cancel" button is not displayed
    And Contact section "Save" button is not displayed
    And All Associated Party Contact section view fields are displayed
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |
    And Associated Party's Contact section details are displayed with data
      | Phone Number | Fax | Website | Email Address    |
      |              |     |         | test@example.com |
    When User clicks Associated Party's Contact section "Edit" button
    And User updates Associated Party's Contact section with values
      | Phone Number | Fax      | Website             | Email Address    |
      | 000000000000 | Edit Fax | http://www.test.com | test@example.com |
    And User clicks Associated Party's Contact section "Save" button
    Then Current URL contains "/thirdparty/" endpoint
    And Contact section "Cancel" button is not displayed
    And Contact section "Save" button is not displayed
    And All Associated Party Contact section view fields are displayed
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |
    And Associated Party's Contact section details are displayed with data
      | Phone Number | Fax      | Website             | Email Address    |
      | 000000000000 | Edit Fax | http://www.test.com | test@example.com |
    And Add Name mandatory text field is displayed
    And Add Name Type mandatory drop-down field is displayed with list
      | Also Known As     |
      | Locally Known As  |
      | Formerly Known As |
    And Add "Country of Location" drop-down field is displayed with list of countries from WC1
    And Add "Citizenship" drop-down field is displayed with list of countries from WC1
    And Add "Place of Birth" drop-down field is displayed with list of countries from WC1
    And "Other Names Add|Save button" for other name is displayed
    And "Cancel Other Name button" for other name is displayed
    When User clicks on "Other Names Add|Save button"
    And Error message "This field is required" in red color is displayed near "Name"
    And Error message "This field is required" in red color is displayed near "Name Type"
    When User fills in Name field value "Test Other Name"
    And User selects Name type "Also Known As"
    Then Selected Name type "Also Known As" is disabled
    When User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    Then "Other Names Table" for other name is displayed
    And Other Name table is displayed with column names
      | NAME | NAME TYPE | DATE CREATED | LAST UPDATE |
    And Other Name table contains expected values
      | Test Other Name |
      | Also Known As   |
      | MM/dd/YYYY      |
      | MM/dd/YYYY      |
    And Edit Other Name button is displayed in the Other Names section after each record
    And Delete Other Name button is displayed in the Other Names section after each record
    When User clicks Associated Party's Description section "Edit" button
    And User fills in Associated Party's Description text "Description text"
    And User clicks Associated Party's Description section "Cancel" button
    Then Description section "Cancel" button is not displayed
    And Description section "Save" button is not displayed
    And Associated Party's Description section is not populated
    When User clicks Associated Party's Description section "Edit" button
    And User fills in Associated Party's Description text "Description text"
    And User clicks Associated Party's Description section "Save" button
    Then Description section "Cancel" button is not displayed
    And Description section "Save" button is not displayed
    And Associated Party's Description section is populated with text "Description text"
