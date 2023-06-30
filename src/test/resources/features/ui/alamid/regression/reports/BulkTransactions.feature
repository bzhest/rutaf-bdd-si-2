@ui @bulkTransactions @alamid
Feature: Bulk Transactions

  As a user
  I would like to access Bulk Transactions page
  So that I can process bulk transactions

  @C37447470 @C44036498
  @full_regression
  Scenario: C37447470, C44036498: Reports - Bulk Process Type dropdown
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    Then Bulk Transactions buttons are shown
    When User clicks Bulk Process Type dropdown
    Then Bulk Process Type Drop down list is displayed with values
      | Third-party Add/Update/Delete                        |
      | Third-party Import                                   |
      | Third-party Associated Individuals Add/Update/Delete |
      | Internal users Add/Update                            |
      | Due Diligence Orders Import                          |
      | Due Diligence Orders Add                             |

  @C50210078
  @core_regression
  @onlySingleThread
  Scenario: C50210078: [Configurable TP Fields] - Bulk - Only required fields - Optional Config
    Given User logs into RDDC as "Admin"
    When User set default values for Third-party Fields via API
    And User unsets all required Custom Fields via API
    And User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    And User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "OnlyRequiredFieldsTP.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User navigates to Third-party page
    Then Third-party with name "AUTO_TEST_BULK_ONLY_MANDATORY_FIELDS" is displayed in Third-party overview table
    When User opens Third-party with name "AUTO_TEST_BULK_ONLY_MANDATORY_FIELDS"
    And User waits for progress bar to appear and disappear from page
    Then Third-party "Country" address details contains "Ukraine"
    When User navigates to Third-party page
    And User deletes Third-party with name "AUTO_TEST_BULK_ONLY_MANDATORY_FIELDS"
    And User clicks Delete button on confirmation window
    Then Third-party "AUTO_TEST_BULK_ONLY_MANDATORY_FIELDS" does not appear in the Third-party Overview table

  @C50210124
  @full_regression
  @onlySingleThread
  Scenario: C50210124: [Configurable TP Fields] - Bulk - All fields - Required Config
    Given User logs into RDDC as "Admin"
    When User set default values for Third-party Fields via API
    And User unsets all required Custom Fields via API
    And User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    And User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "allFieldsTP.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User navigates to Third-party page
    Then Third-party with name "AUTO_TEST_BULK_ALL_FIELDS" is displayed in Third-party overview table
    When User opens Third-party with name "AUTO_TEST_BULK_ALL_FIELDS"
    And User waits for progress bar to appear and disappear from page
    Then Third-party's 'General Information' section fields contain values
      | Name                  | AUTO_TEST_BULK_ALL_FIELDS              |
      | Industry Type         | Accident & Health Insurance            |
      | Date of Incorporation | 10/12/2022                             |
      | Responsible Party     | Admin_AT_FN Admin_AT_LN                |
      | Currency              | USD United States dollar               |
      | Liquidation Date      | 10/12/2022                             |
      | Company Type          | Cooperation                            |
      | Division              | MyDivision                             |
      | Business Category     | Property & Structure                   |
      | Affiliation           | State Owned Entity                     |
      | Organisation Size     | 5001-10,000 employees                  |
      | Workflow Group        | Default                                |
      | Revenue               | Less than 10 million in annual revenue |
    And Third-party's 'Third-party Segmentation' section fields contain values
      | Spend Category          | One time spend                                                |
      | Design Agreement        | Products purchased off the shelf                              |
      | Relationship Visibility | Little to no visibility of relationship                       |
      | Commodity Type          | 3PL Services                                                  |
      | Sourcing Method         | Purchased through distribution or agent from multiple sources |
      | Sourcing Type           | Multiple sources available                                    |
      | Product Impact          | Commoditized product                                          |
    And Third-party's 'Bank Details' section fields on position 1 contain values
      | Bank Name    | Auto Bank Name         |
      | Account No.  | Auto Account No.       |
      | Branch Name  | Auto Branch Name       |
      | Address Line | Auto Bank Address Line |
      | City         | Auto Bank City         |
      | Country      | Ukraine                |
    And Third-party's 'Address' section fields contain values
      | Address Line    | Auto Address |
      | City            | Auto City    |
      | State/Province  | Auto State   |
      | Zip/Postal Code | 12345        |
      | Region          | Europe       |
      | Country         | Ukraine      |
    And Third-party's 'Contact' section fields contain values
      | Phone Number  | 234234                  |
      | Fax           | 234234                  |
      | Website       | autowebsite@si.com      |
      | Email Address | autoemail@refinitiv.com |
    And Third-party's 'Description' section contain value
      | Auto Description |
    When User navigates to Third-party page
    And User deletes Third-party with name "AUTO_TEST_BULK_ALL_FIELDS"
    And User clicks Delete button on confirmation window
    Then Third-party "AUTO_TEST_BULK_ALL_FIELDS" does not appear in the Third-party Overview table

  @C50210126
  @full_regression
  @onlySingleThread
  Scenario: C50210126: [Configurable TP Fields] - Bulk - Validations - Required Config
    Given User logs into RDDC as "Admin"
    When User set default values for Third-party Fields via API
    And User unsets all required Custom Fields via API
    And User clicks Set Up option
    And User clicks Third-party Fields in Set Up menu
    Then Third-party Fields page is displayed
    When User clicks checkboxes in "Required" column of "General Information" table for fields
      | Industry Type         |
      | Date of Incorporation |
      | Currency              |
      | Liquidation Date      |
      | Company Type          |
      | Business Category     |
      | Affiliation           |
      | Organisation Size     |
      | Revenue               |
    And User clicks checkboxes in "Required" column of "Third-party Segmentation" table for fields
      | Spend Category          |
      | Design Agreement        |
      | Relationship Visibility |
      | Commodity Type          |
      | Sourcing Method         |
      | Sourcing Type           |
      | Product Impact          |
    And User clicks checkboxes in "Required" column of "Bank Details" table for fields
      | Bank Name    |
      | Account No.  |
      | Branch Name  |
      | Address Line |
      | City         |
      | Country      |
    And User clicks checkboxes in "Required" column of "Address" table for fields
      | Address Line    |
      | City            |
      | State/Province  |
      | Zip/Postal code |
      | Region          |
    And User clicks checkboxes in "Required" column of "Contact" table for fields
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |
    And User clicks checkboxes in "Required" column of "Description" table for fields
      | Description |
    And User clicks 'Save' button for Third-party Fields
    Then Third-party Fields page is displayed
    When User navigates to Custom Fields page
    And User clicks Add Custom Field button
    Then Custom Field "Add" page is displayed
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User selects Custom Field - Field Type "Text" from dropdown
    And User clicks on 'Required' custom fields checkbox
    And User clicks Save button for Custom Field
    And User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    And User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "allEmptyFields.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User downloads automatically generated Error File for the record on the 1 row of 'Bulk Transactions' table
    And User set default values for Third-party Fields via API
    Then ".csv" File with name "error_allEmptyFields_" and date format "MMddYYYY" downloaded
    And Automatically generated CSV report contains errors on line 3
      | Third-party Name - Missing field        |
      | Responsible Party - Missing field       |
      | Country - Missing field                 |
      | Workflow Group - Missing field          |
      | Division - Missing field                |
      | Industry Type - Missing field           |
      | Date of Incorporation - Missing field   |
      | Currency - Missing field                |
      | Liquidation Date - Missing field        |
      | Company Type - Missing field            |
      | Business Category - Missing field       |
      | Affiliation - Missing field             |
      | Organization Size - Missing field       |
      | Revenue - Missing field                 |
      | Spend Category - Missing field          |
      | Design Agreement - Missing field        |
      | Relationship Visibility - Missing field |
      | Commodity Type - Missing field          |
      | Sourcing Method - Missing field         |
      | Sourcing Type - Missing field           |
      | Product Impact - Missing field          |
      | Bank Name - Missing field               |
      | Account No. - Missing field             |
      | Branch Name - Missing field             |
      | Address Line - Missing field            |
      | City - Missing field                    |
      | Country - Missing field                 |
      | Address Line - Missing field            |
      | City - Missing field                    |
      | State/Province - Missing field          |
      | Zip/Postal Code - Missing field         |
      | Region - Missing field                  |
      | Phone Number - Missing field            |
      | Fax - Missing field                     |
      | Website - Missing field                 |
      | Email Address - Missing field           |
      | Description - Missing field             |
      | <toBeReplaced> - Missing field          |

  @C50209017
  @core_regression
  Scenario: C50209017: [Configurable TP Fields] - Bulk - PARTUPDATE
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User updates CSV file "partupdateOnlyName.csv" on line 2 with created Third-party ID
    And User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    And User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "partupdateOnlyName.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User opens previously created Third-party
    And User waits for progress bar to appear and disappear from page
    Then Third-party's 'General Information' section fields contain values
      | Name | AUTO_TEST_BULK_UPDATED |

  @C50724724
  @core_regression
  Scenario: C50724724: [Configurable TP Fields] - Bulk - FULLUPDATE
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User updates CSV file "allFieldsTpForUpdate.csv" on line 2 with created Third-party ID
    And User updates CSV file "allFieldsTpForUpdate.csv" on line 3 with created Third-party ID
    And User clicks Set Up option
    And User clicks Third-party Fields in Set Up menu
    Then Third-party Fields page is displayed
    When User clicks checkboxes in "Required" column of "General Information" table for fields
      | Industry Type         |
      | Date of Incorporation |
      | Currency              |
      | Liquidation Date      |
      | Company Type          |
      | Business Category     |
      | Affiliation           |
      | Organisation Size     |
      | Revenue               |
    And User clicks checkboxes in "Required" column of "Third-party Segmentation" table for fields
      | Spend Category          |
      | Design Agreement        |
      | Relationship Visibility |
      | Commodity Type          |
      | Sourcing Method         |
      | Sourcing Type           |
      | Product Impact          |
    And User clicks checkboxes in "Required" column of "Bank Details" table for fields
      | Bank Name    |
      | Account No.  |
      | Branch Name  |
      | Address Line |
      | City         |
      | Country      |
    And User clicks checkboxes in "Required" column of "Address" table for fields
      | Address Line    |
      | City            |
      | State/Province  |
      | Zip/Postal code |
      | Region          |
    And User clicks checkboxes in "Required" column of "Contact" table for fields
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |
    And User clicks checkboxes in "Required" column of "Description" table for fields
      | Description |
    And User clicks 'Save' button for Third-party Fields
    Then Third-party Fields page is displayed
    When User navigates to Custom Fields page
    And User clicks Add Custom Field button
    Then Custom Field "Add" page is displayed
    When User populates in Custom Field Name with "AUTO_TEST_"
    And User selects Custom Field - Field Type "Text" from dropdown
    And User clicks on 'Required' custom fields checkbox
    And User clicks Save button for Custom Field
    And User updates CSV file "allFieldsTpForUpdate.csv" on line 3 with created Custom Field name
    And User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    And User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "allFieldsTpForUpdate.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User opens previously created Third-party
    And User waits for progress bar to appear and disappear from page
    Then Third-party's 'General Information' section fields contain values
      | Name                  | AUTO_TEST_BULK_UPDATED                 |
      | Industry Type         | Accident & Health Insurance            |
      | Date of Incorporation | 10/12/2022                             |
      | Responsible Party     | Admin_AT_FN Admin_AT_LN                |
      | Currency              | USD United States dollar               |
      | Liquidation Date      | 10/12/2022                             |
      | Company Type          | Cooperation                            |
      | Division              | MyDivision                             |
      | Business Category     | Property & Structure                   |
      | Affiliation           | State Owned Entity                     |
      | Organisation Size     | 5001-10,000 employees                  |
      | Workflow Group        | Default                                |
      | Revenue               | Less than 10 million in annual revenue |
    And Third-party's 'Third-party Segmentation' section fields contain values
      | Spend Category          | One time spend                                                |
      | Design Agreement        | Products purchased off the shelf                              |
      | Relationship Visibility | Little to no visibility of relationship                       |
      | Commodity Type          | 3PL Services                                                  |
      | Sourcing Method         | Purchased through distribution or agent from multiple sources |
      | Sourcing Type           | Multiple sources available                                    |
      | Product Impact          | Commoditized product                                          |
    And Created Custom Field is displayed in Other Information section with value
      | AutoCustomFieldValue |
    And Third-party's 'Bank Details' section fields on position 1 contain values
      | Bank Name    | Auto Bank Name         |
      | Account No.  | Auto Account No.       |
      | Branch Name  | Auto Branch Name       |
      | Address Line | Auto Bank Address Line |
      | City         | Auto Bank City         |
      | Country      | Ukraine                |
    And Third-party's 'Address' section fields contain values
      | Address Line    | Auto Address |
      | City            | Auto City    |
      | State/Province  | Auto State   |
      | Zip/Postal Code | 12345        |
      | Region          | Europe       |
      | Country         | Ukraine      |
    And Third-party's 'Contact' section fields contain values
      | Phone Number  | 234234                  |
      | Fax           | 234234                  |
      | Website       | autowebsite@si.com      |
      | Email Address | autoemail@refinitiv.com |
    And Third-party's 'Description' section contain value
      | Auto Description |

  @C50709153
  @core_regression
  Scenario: C50709153: [Configurable TP Fields] - Bulk - Bank details validations - Active
    Given User logs into RDDC as "Admin"
    When User set default values for Third-party Fields via API
    And User unsets all required Custom Fields via API
    And User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    And User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "bankDetailsValidationsAdd.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User downloads automatically generated Error File for the record on the 1 row of 'Bulk Transactions' table
    Then ".csv" File with name "error_bankDetailsValidationsAdd_" and date format "MMddYYYY" downloaded
    And Automatically generated CSV report contains errors on line 2
      | Bank Address Line - Maximum length exceeded |
      | Bank Country - Invalid Value                |
      | Bank Name - Maximum length exceeded         |
      | Branch Name - Maximum length exceeded       |
      | Bank City - Maximum length exceeded         |
      | Bank Account No. - Maximum length exceeded  |
    When User creates third-party "with random ID name" via API and open it
    And User updates CSV file "bankDetailsValidationsFullUpdate.csv" on line 2 with created Third-party ID
    And User updates CSV file "bankDetailsValidationsPartUpdate.csv" on line 2 with created Third-party ID
    And User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    And User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "bankDetailsValidationsFullUpdate.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User downloads automatically generated Error File for the record on the 1 row of 'Bulk Transactions' table
    Then ".csv" File with name "error_bankDetailsValidationsFullUpdate_" and date format "MMddYYYY" downloaded
    And Automatically generated CSV report contains errors on line 2
      | Bank Address Line - Maximum length exceeded |
      | Bank Country - Invalid Value                |
      | Bank Name - Maximum length exceeded         |
      | Branch Name - Maximum length exceeded       |
      | Bank City - Maximum length exceeded         |
      | Bank Account No. - Maximum length exceeded  |
    When User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "bankDetailsValidationsPartUpdate.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User downloads automatically generated Error File for the record on the 1 row of 'Bulk Transactions' table
    Then ".csv" File with name "error_bankDetailsValidationsPartUpdate_" and date format "MMddYYYY" downloaded
    And Automatically generated CSV report contains errors on line 2
      | Bank Address Line - Maximum length exceeded |
      | Bank Country - Invalid Value                |
      | Bank Name - Maximum length exceeded         |
      | Branch Name - Maximum length exceeded       |
      | Bank City - Maximum length exceeded         |
      | Bank Account No. - Maximum length exceeded  |

  @C50709167
  @full_regression
  Scenario: C50709167: [Configurable TP Fields] - Bulk - Bank details validations - Required
    Given User logs into RDDC as "Admin"
    When User set default values for Third-party Fields via API
    And User unsets all required Custom Fields via API
    And User clicks Set Up option
    And User clicks Third-party Fields in Set Up menu
    Then Third-party Fields page is displayed
    When User clicks checkboxes in "Required" column of "Bank Details" table for fields
      | Bank Name    |
      | Account No.  |
      | Branch Name  |
      | Address Line |
      | City         |
      | Country      |
    And User clicks 'Save' button for Third-party Fields
    Then Third-party Fields page is displayed
    When User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    And User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "allFieldsTP.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User navigates to Third-party page
    Then Third-party with name "AUTO_TEST_BULK_ALL_FIELDS" is displayed in Third-party overview table
    When User opens Third-party with name "AUTO_TEST_BULK_ALL_FIELDS"
    And User copies Third-party ID from the URL and saves it in context
    And User updates CSV file "BankDetailsPartUpdate.csv" on line 2 with created Third-party ID
    And User updates CSV file "BankDetailsFullUpdate.csv" on line 2 with created Third-party ID
    And User updates CSV file "FullUpdateWithoutBankDetails.csv" on line 2 with created Third-party ID
    And User updates CSV file "PartUpdateEmptyBankDetails.csv" on line 2 with created Third-party ID
    And User updates CSV file "PartUpdateEmptyBankName.csv" on line 2 with created Third-party ID
    And User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    And User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "BankDetailsPartUpdate.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User opens previously created Third-party
    And User waits for progress bar to appear and disappear from page
    Then Third-party's 'General Information' section fields contain values
      | Name | AUTO_TEST_BULK_UPDATED |
    And Third-party's 'Bank Details' section fields on position 2 contain values
      | Bank Name    | Auto Bank Name UPDATED         |
      | Account No.  | Auto Account No. UPDATED       |
      | Branch Name  | Auto Branch Name UPDATED       |
      | Address Line | Auto Bank Address Line UPDATED |
      | City         | Auto Bank City UPDATED         |
      | Country      | Ukraine                        |
    When User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    And User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "BankDetailsFullUpdate.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User opens previously created Third-party
    And User waits for progress bar to appear and disappear from page
    Then Third-party's 'General Information' section fields contain values
      | Name | AUTO_TEST_BULK_FULL_UPDATED |
    And Third-party's 'Bank Details' section fields on position 1 contain values
      | Bank Name    | Auto Bank Name FULL UPDATED         |
      | Account No.  | Auto Account No. FULL UPDATED       |
      | Branch Name  | Auto Branch Name FULL UPDATED       |
      | Address Line | Auto Bank Address Line FULL UPDATED |
      | City         | Auto Bank City FULL UPDATED         |
      | Country      | Ukraine                             |
    When User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    And User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "AddWithoutBankDetails.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User downloads automatically generated Error File for the record on the 1 row of 'Bulk Transactions' table
    Then ".csv" File with name "error_AddWithoutBankDetails_" and date format "MMddYYYY" downloaded
    And Automatically generated CSV report contains errors on line 2
      | Bank Name - Missing field         |
      | Account No. - Missing field       |
      | Bank Country - Missing field      |
      | Branch Name - Missing field       |
      | Bank City - Missing field         |
      | Bank Address Line - Missing field |
    When User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "FullUpdateWithoutBankDetails.csv" file on 'Bulk Transactions' page
    And User refreshes page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User downloads automatically generated Error File for the record on the 1 row of 'Bulk Transactions' table
    Then ".csv" File with name "error_FullUpdateWithoutBankDetails_" and date format "MMddYYYY" downloaded
    And Automatically generated CSV report contains errors on line 2
      | Bank Name - Missing field         |
      | Account No. - Missing field       |
      | Bank Country - Missing field      |
      | Branch Name - Missing field       |
      | Bank City - Missing field         |
      | Bank Address Line - Missing field |
    When User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "PartUpdateEmptyBankDetails.csv" file on 'Bulk Transactions' page
    And User refreshes page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User opens previously created Third-party
    And User waits for progress bar to appear and disappear from page
    Then Third-party's 'General Information' section fields contain values
      | Name | AUTO_TEST_BULK_BANK_PRESENT |
    And Third-party's 'Bank Details' section fields on position 1 contain values
      | Bank Name    | Auto Bank Name FULL UPDATED         |
      | Account No.  | Auto Account No. FULL UPDATED       |
      | Branch Name  | Auto Branch Name FULL UPDATED       |
      | Address Line | Auto Bank Address Line FULL UPDATED |
      | City         | Auto Bank City FULL UPDATED         |
      | Country      | Ukraine                             |
    When User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    And User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "PartUpdateEmptyBankName.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User downloads automatically generated Error File for the record on the 1 row of 'Bulk Transactions' table
    Then ".csv" File with name "error_PartUpdateEmptyBankName_" and date format "MMddYYYY" downloaded
    And Automatically generated CSV report contains errors on line 2
      | Bank Name - Missing field         |

  @C50709158
  @full_regression
  Scenario: C50709158: [Configurable TP Fields] - Bulk - Bank details validations - Inactive
    Given User logs into RDDC as "Admin"
    When User set default values for Third-party Fields via API
    And User unsets all required Custom Fields via API
    And User clicks Set Up option
    And User clicks Third-party Fields in Set Up menu
    Then Third-party Fields page is displayed
    When User clicks checkboxes in "Active" column of "Bank Details" table for fields
      | Bank Name    |
      | Account No.  |
      | Branch Name  |
      | Address Line |
      | City         |
      | Country      |
    And User clicks 'Save' button for Third-party Fields
    Then Third-party Fields page is displayed
    When User navigates to Reports page
    And User selects Report Tab "Bulk Transactions"
    And User clicks Bulk Process Type dropdown
    And User clicks "Third-party Add/Update/Delete" option in Bulk Process Type dropdown
    And User uploads "bankDetailsValidationsAdd.csv" file on 'Bulk Transactions' page
    And User waits for 'Completed' status of the record on 1 row of 'Bulk Transactions' table
    And User downloads automatically generated Error File for the record on the 1 row of 'Bulk Transactions' table
    Then ".csv" File with name "error_bankDetailsValidationsAdd_" and date format "MMddYYYY" downloaded
    And Automatically generated CSV report contains errors on line 2
      | Bank Address Line - Maximum length exceeded |
      | Bank Country - Invalid Value                |
      | Bank Name - Maximum length exceeded         |
      | Branch Name - Maximum length exceeded       |
      | Bank City - Maximum length exceeded         |
      | Bank Account No. - Maximum length exceeded  |
