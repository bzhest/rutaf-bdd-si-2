@ui @functional @wc1 @other_names @screening_result
Feature: Third-party - Information - Other Name - World Check Tab - Screening

  As a user,
  I want to see the supplier other name results from WC1.
  So that I can process the supplier other name information.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name" via API and open it

  @C33592814
  Scenario: C33592814: Supplier - Check WC1 screening results for added Other name with empty country
    When User fills in Name field value "Bank of China"
    And User selects Name type "Other Name"
    And User clicks on "Other Names Add|Save button"
    And User opens screening results for "Bank of China" Other name
    Then Other Name dialog is loaded
    And Checkbox is displayed in front of table header and each row
    And Screening Table for Other name displays up to 10 items per page
    And Screening Table displays '10' pagination selection
    And Sorted search "World-Check" results for "Bank of China" "supplier" appear in other names screening table for current page
    And "Screening Result pop-up header" for other name screening is displayed with text
      | OTHER NAME: BANK OF CHINA |
    And "Other Name Last Screening Date" for other name screening is displayed with text
      | LAST SCREENING DATE: d MMMM YYYY |

  @C34085521
  Scenario: C34085521: Supplier - Check WC1 screening results for added Other name with country
    When User fills in Name field value "PetroChina"
    And User selects Name type "Other Name"
    And User edits "Country of Registration" field with value "China"
    And User clicks on "Other Names Add|Save button"
    And User opens screening results for "PetroChina" Other name
    Then Other Name dialog is loaded
    And Checkbox is displayed in front of table header and each row
    And Screening Table for Other name displays up to 10 items per page
    And Screening Table displays '10' pagination selection
    And Sorted search "World-Check" results for "PetroChina" "supplier" appear in other names screening table for current page
    And "Screening Result pop-up header" for other name screening is displayed with text
      | OTHER NAME: PETROCHINA |
    And "Other Name Last Screening Date" for other name screening is displayed with text
      | LAST SCREENING DATE: d MMMM YYYY |

  @C33592815
  Scenario: C33592815: Supplier - Check WC1 screening results pagination
      #   Test name with no results
    When User fills in Name field value "Auto_TestNotMatchedOtherName1234567890"
    And User selects Name type "Local Language Name"
    And User clicks on "Other Names Add|Save button"
    And User opens screening results for "Auto_TestNotMatchedOtherName1234567890" Other name
    Then "Screening Result pop-up header" for other name screening is displayed with text
      | LOCAL LANGUAGE NAME: AUTO_TESTNOTMATCHEDOTHERNAME1234567890 |
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |
    And "Other Name Screening Refresh Button" for other name screening is not displayed
    And User clicks Close Other Name Results button
    #  Test name with less then 10 records
    When User fills in Name field value "CHUNG KUO INSURANCE CO LTD"
    And User selects Name type "Other Name"
    And User clicks on "Other Names Add|Save button"
    And User opens screening results for "CHUNG KUO INSURANCE CO LTD" Other name
    Then Sorted search "World-Check" results for "CHUNG KUO INSURANCE CO LTD" "supplier" appear in other names screening table for current page
    And "Screening Result pop-up header" for other name screening is displayed with text
      | OTHER NAME: CHUNG KUO INSURANCE CO LTD |
    And Other Name Screening Pagination is disabled
    And User clicks Close Other Name Results button
    #  Test name with less more than 10 records
    And User fills in Name field value "China"
    And User selects Name type "Other Name"
    And User clicks on "Other Names Add|Save button"
    And User opens screening results for "China" Other name
    Then Other Name dialog is loaded
    And "Screening Result pop-up header" for other name screening is displayed with text
      | OTHER NAME: CHINA |
    And "Other Name Screening Pagination" for other name screening is displayed
    And "Other Name Screening Pagination Drop-Down" for other name screening is displayed
    When User clicks on "Other Name Screening Pagination Drop-Down" Other name screening element
    Then Other Name Screening Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    When User selects 10 rows per page
    Then Sorted search "World-Check" results for "China" "supplier" appear in other names screening table for current page
    And Screening Table for Other name displays up to 10 items per page
    And Screening Table displays '10' pagination selection
    When User clicks on "Other Name Screening Pagination Drop-Down" Other name screening element
    And User selects 25 rows per page
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 25 items per page
    And Screening Table displays '25' pagination selection
    When User clicks on "Other Name Screening Pagination Drop-Down" Other name screening element
    And User selects 50 rows per page
    And Other Name dialog is loaded
    Then Screening Table for Other name displays up to 50 items per page
    And Screening Table displays '50' pagination selection
    When User clicks Other Name screening results 'next page' button
    Then Sorted search "World-Check" results for "China" "supplier" appear in other names screening table for current page
    When User clicks Other Name screening results 'previous page' button
    Then Sorted search "World-Check" results for "China" "supplier" appear in other names screening table for current page
    When User clicks Other Name screening results 'last page' button
    Then Sorted search "World-Check" results for "China" "supplier" appear in other names screening table for current page
    When User clicks Other Name screening results 'first page' button
    Then Sorted search "World-Check" results for "China" "supplier" appear in other names screening table for current page

  @C33592808
  Scenario: C33592808: Supplier - Check WC1 screening results for edited Other name and Supplier's Country
    Given User creates Other name "with mandatory fields"
    Then Edit Other Name button is displayed in the Other Names section after each record
    When User clicks on Edit Other Name Button for "Test Other Name" name
    And User fills in Name field value "Apple"
    And User selects Name type "Former Name"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Success!                          |
      | Other name Apple has been updated |
    When User opens screening results for "Apple" Other name
    And Sorted search "World-Check" results for "Apple" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks General and Other Information section "Edit" button
    And User updates Address section with values
      | Country              |
      | United Arab Emirates |
    And User clicks General and Other Information section "Save" button
    Then Save button is disappeared
    When User opens screening results for "Apple" Other name
    Then Sorted search "World-Check" results for "Apple" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Apple" name
    Then Field "Country of Registration" for other name is empty
