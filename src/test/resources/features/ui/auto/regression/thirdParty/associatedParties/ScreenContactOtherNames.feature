@ui @full_regression @react @wc1 @other_names @screening_result
Feature: Contact Other Names - Display Screening Results

  As a user,
  I want to see the contact other name results from WC1.
  So that I can process the supplier other name information.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    When User creates third-party "with random ID name"
    And User creates Associated Party "with mandatory fields"

  @C33436782
  @core_regression
  Scenario: C33436782: SI-WC1-Contact-Other Names- Check WC1 results- Other name added
    When User clicks on "Other Names Add|Save button"
    And User fills in Name field value "James"
    And User selects Name type "Also Known As"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    And "WORLD-CHECK" other name tab is selected
    And WC1 case contains "" provided "LOCATION" for "contact" "James" other name secondary field
    And Checkbox is displayed in front of table header and each row
    And Screening Table for Other name displays up to 10 items per page
    And Screening Table displays '10' pagination selection
    When User clicks on "Other Name Screening Pagination Drop-Down" Other name screening element
    Then Other Name Screening Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    And Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on Screen Other Name Button for "James" name
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    And "Screening Result pop-up header" for other name screening is displayed with text
      | ALSO KNOWN AS: JAMES |
    And "Other Name Last Screening Date" for other name screening is displayed with text
      | LAST SCREENING DATE: d MMMM YYYY |
    And "WORLD-CHECK" tab on modal is displayed

  @C33438036
  Scenario: C33438036: SI-WC1-Contact-Other Names- Check WC1 and CWL results-Pagination - World-Check
      #   Test name with no results
    When User fills in Name field value "Auto_TestNotMatchedOtherName1234567890"
    And User selects Name type "Locally Known As"
    And User clicks on "Other Names Add|Save button"
    And "Screening Result pop-up header" for other name screening is displayed with text
      | LOCALLY KNOWN AS: AUTO_TESTNOTMATCHEDOTHERNAME1234567890 |
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |
    And "Other Name Screening Refresh Button" for other name screening is not displayed
    And "WORLD-CHECK" other name tab is selected
    And User clicks Close Other Name Results button
    And "Other Name Screening Pagination" for other name screening is not displayed
    #  Test name with less then 10 records
    When User clicks on "Other Names Add|Save button"
    And User fills in Name field value "Gary TRUMP"
    And User selects Name type "Also Known As"
    And User clicks on "Other Names Add|Save button"
    Then Sorted search "World-Check" results for "Gary TRUMP" "contact" appear in other names screening table for current page
    And "Screening Result pop-up header" for other name screening is displayed with text
      | ALSO KNOWN AS: GARY TRUMP |
    And Other Name Screening Pagination is disabled
    And User clicks Close Other Name Results button
    #  Test name with more than 10 records
    When User clicks on "Other Names Add|Save button"
    And User fills in Name field value "James"
    And User selects Name type "Formerly Known As"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    And "Screening Result pop-up header" for other name screening is displayed with text
      | FORMERLY KNOWN AS: JAMES |
    And "Other Name Screening Pagination" for other name screening is displayed
    And "Other Name Screening Pagination Drop-Down" for other name screening is displayed
    When User clicks on "Other Name Screening Pagination Drop-Down" Other name screening element
    Then Other Name Screening Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    When User selects 10 rows per page
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    And Screening Table for Other name displays up to 10 items per page
    And Screening Table displays '10' pagination selection
    When User clicks on "Other Name Screening Pagination Drop-Down" Other name screening element
    And User selects 25 rows per page
    And Other Name dialog is loaded
    Then Screening Table for Other name displays up to 25 items per page
    And Screening Table displays '25' pagination selection
    When User clicks on "Other Name Screening Pagination Drop-Down" Other name screening element
    And User selects 50 rows per page
    And Other Name dialog is loaded
    Then Screening Table for Other name displays up to 50 items per page
    And Screening Table displays '50' pagination selection
    When User clicks Other Name screening results 'next page' button
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    When User clicks Other Name screening results 'previous page' button
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    When User clicks Other Name screening results 'last page' button
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    When User clicks Other Name screening results 'first page' button
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page

  @C33438036
  Scenario: C33438036: SI-WC1-Contact-Other Names- Check WC1 and CWL results-Pagination - Custom Watchlist
    #   Test name with no results
    When User fills in Name field value "Auto_TestNotMatchedOtherName1234567890"
    And User selects Name type "Locally Known As"
    And User clicks on "Other Names Add|Save button"
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then "CUSTOM WATCHLIST" other name tab is selected
    And "Screening Result pop-up header" for other name screening is displayed with text
      | LOCALLY KNOWN AS: AUTO_TESTNOTMATCHEDOTHERNAME1234567890 |
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |
    And "Other Name Screening Refresh Button" for other name screening is not displayed
    And "Other Name Screening Pagination" for other name screening is not displayed
    When User clicks Close Other Name Results button
    #  Test name with less then 10 records
    And User fills in Name field value "Gary TRUMP"
    And User selects Name type "Also Known As"
    And User clicks on "Other Names Add|Save button"
    And User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then "CUSTOM WATCHLIST" other name tab is selected
    And Sorted search "Custom WatchList" results for "Gary TRUMP" "contact" appear in other names screening table for current page
    And "Screening Result pop-up header" for other name screening is displayed with text
      | ALSO KNOWN AS: GARY TRUMP |
    And Other Name Screening Pagination is disabled
    When User clicks Close Other Name Results button
    #  Test name with less more than 10 records
    And User fills in Name field value "Anna"
    And User selects Name type "Formerly Known As"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then "CUSTOM WATCHLIST" other name tab is selected
    And "Screening Result pop-up header" for other name screening is displayed with text
      | FORMERLY KNOWN AS: ANNA |
    And "Other Name Screening Pagination" for other name screening is displayed
    And "Other Name Screening Pagination Drop-Down" for other name screening is displayed
    When User clicks on "Other Name Screening Pagination Drop-Down" Other name screening element
    Then Other Name Screening Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    When User selects 10 rows per page
    Then Sorted search "Custom WatchList" results for "Anna" "contact" appear in other names screening table for current page
    And Screening Table for Other name displays up to 10 items per page
    And Screening Table displays '10' pagination selection
    When User clicks on "Other Name Screening Pagination Drop-Down" Other name screening element
    And User selects 50 rows per page
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 50 items per page
    And Screening Table displays '50' pagination selection
    When User clicks on "Other Name Screening Pagination Drop-Down" Other name screening element
    And User selects 25 rows per page
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 25 items per page
    And Screening Table displays '25' pagination selection
    When User clicks Other Name screening results 'next page' button
    Then Sorted search "Custom WatchList" results for "Anna" "contact" appear in other names screening table for current page
    When User clicks Other Name screening results 'previous page' button
    Then Sorted search "Custom WatchList" results for "Anna" "contact" appear in other names screening table for current page
    When User clicks Other Name screening results 'last page' button
    Then Sorted search "Custom WatchList" results for "Anna" "contact" appear in other names screening table for current page
    When User clicks Other Name screening results 'first page' button
    Then Sorted search "Custom WatchList" results for "Anna" "contact" appear in other names screening table for current page

  @C33436784
  Scenario: C33436784: SI-WC1-Contact-Other Names-Check WC1 Results- Other name/Country edited
    And User creates Other name "contact other name" for Associated Party
    And User clicks Close Other Name Results button
    And Edit Other Name button is displayed in the Other Names section after each record
    When User clicks on Edit Other Name Button for "Test Other Name" name
    And User fills in Name field value "James"
    And User selects Name type "Formerly Known As"
    And User clicks on "Other Names Add|Save button"
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    And User clicks Close Other Name Results button
    When User clicks Associated Party's Address section "Edit" button
    And User updates Associated Party's Address section on position 1 with values
      | Country       |
      | United States |
    And User clicks Associated Party's Address section "Save" button
    And User opens screening results for "James" Other name
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    And User clicks Close Other Name Results button
    When User clicks on Edit Other Name Button for "James" name
    Then Field "Country of Location" for other name is empty

  @C33415140
  @RMS-16039
  Scenario: C33415140: SI-WC1-Contact-Other Names- Check WC1 profile details-Other name added
    When User clicks on "Other Names Add|Save button"
    And User fills in Name field value "James"
    And User selects Name type "Formerly Known As"
    And User clicks on "Other Names Add|Save button"
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening "contact" profile header contains correspond data
    And Screening profiles Resolution Type contains correspond data
    And "Legal Notice" profile details is displayed
    And "Add Comment Button" profile details is displayed
    #    TODO Update validation when bug RMS-16039 will be fixed
    And Screening result "contact" profile Key Data tab displays correspond data
    And Screening result "contact" profile Aliases tab displays correspond data
    And Screening result "contact" profile Further Information tab displays correspond data
    And Screening result "contact" profile Keywords tab displays correspond data
    And Screening result "contact" profile Connections and Relationships tab displays correspond data
    And Screening result "contact" profile Sources tab displays correspond data
    When User clicks on the "Back To Screening Results Button" screening profile
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    When User clicks on 2 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening "contact" profile header contains correspond data
    And Screening profiles Resolution Type contains correspond data
    And "Legal Notice" profile details is displayed
    And "Add Comment Button" profile details is displayed
    And Screening result "contact" profile Key Data tab displays correspond data
    And Screening result "contact" profile Aliases tab displays correspond data
    And Screening result "contact" profile Further Information tab displays correspond data
    And Screening result "contact" profile Keywords tab displays correspond data
    And Screening result "contact" profile Connections and Relationships tab displays correspond data
    And Screening result "contact" profile Sources tab displays correspond data
    When User clicks on the "Back To Screening Results Button" screening profile
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    When User clicks on 3 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening "contact" profile header contains correspond data
    And Screening profiles Resolution Type contains correspond data
    And "Legal Notice" profile details is displayed
    And "Add Comment Button" profile details is displayed
    And Screening result "contact" profile Key Data tab displays correspond data
    And Screening result "contact" profile Aliases tab displays correspond data
    And Screening result "contact" profile Further Information tab displays correspond data
    And Screening result "contact" profile Keywords tab displays correspond data
    And Screening result "contact" profile Connections and Relationships tab displays correspond data
    And Screening result "contact" profile Sources tab displays correspond data

  @C33415141
  @RMS-16039
  Scenario: C33415141: SI-WC1-Contact-Other Names- Check WC1 profile details-Other name edited
    When User creates Other name "contact other name" for Associated Party
    And User clicks Close Other Name Results button
    Then Edit Other Name button is displayed in the Other Names section after each record
    When User clicks on Edit Other Name Button for "Test Other Name" name
    And User fills in Name field value "James"
    And User selects Name type "Formerly Known As"
    And User clicks on "Other Names Add|Save button"
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening "contact" profile header contains correspond data
    And Screening profiles Resolution Type contains correspond data
    And "Legal Notice" profile details is displayed
    And "Add Comment Button" profile details is displayed
#    TODO Update validation when bug RMS-16039 will be fixed
    And Screening result "contact" profile Key Data tab displays correspond data
    And Screening result "contact" profile Aliases tab displays correspond data
    And Screening result "contact" profile Further Information tab displays correspond data
    And Screening result "contact" profile Keywords tab displays correspond data
    And Screening result "contact" profile Connections and Relationships tab displays correspond data
    And Screening result "contact" profile Sources tab displays correspond data
    When User clicks on the "Back To Screening Results Button" screening profile
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    When User clicks on 2 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening "contact" profile header contains correspond data
    And Screening profiles Resolution Type contains correspond data
    And "Legal Notice" profile details is displayed
    And "Add Comment Button" profile details is displayed
    And Screening result "contact" profile Key Data tab displays correspond data
    And Screening result "contact" profile Aliases tab displays correspond data
    And Screening result "contact" profile Further Information tab displays correspond data
    And Screening result "contact" profile Keywords tab displays correspond data
    And Screening result "contact" profile Connections and Relationships tab displays correspond data
    And Screening result "contact" profile Sources tab displays correspond data
    When User clicks on the "Back To Screening Results Button" screening profile
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    When User clicks on 3 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening "contact" profile header contains correspond data
    And Screening profiles Resolution Type contains correspond data
    And "Legal Notice" profile details is displayed
    And "Add Comment Button" profile details is displayed
    And Screening result "contact" profile Key Data tab displays correspond data
    And Screening result "contact" profile Aliases tab displays correspond data
    And Screening result "contact" profile Further Information tab displays correspond data
    And Screening result "contact" profile Keywords tab displays correspond data
    And Screening result "contact" profile Connections and Relationships tab displays correspond data
    And Screening result "contact" profile Sources tab displays correspond data