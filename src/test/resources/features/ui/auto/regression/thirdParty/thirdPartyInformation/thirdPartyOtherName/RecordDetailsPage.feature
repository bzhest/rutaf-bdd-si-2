@ui @full_regression @react @third_party_other_names
Feature: Third-party Other Names - Screening - Custom Watchlist tab - Record Details Page

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    When User creates third-party "with random ID name"
    And User creates Other name "Samsung"
    And User opens screening results for "Samsung" Other name
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then "CUSTOM WATCHLIST" other name tab is selected
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page

  @C39466649
  @core_regression
  Scenario: C39466649: Third-party Other Names -Screening - CUSTOM WATCHLIST tab - Select record - Verify record details page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Other name screening result contains 'Refinitiv World-Check' logo
    And Screening "supplier" profile header contains correspond data
    And Screening profile's Resolution is displayed
    And Resolution type contains following tooltip text when hover on it
      | Positive |
      | Possible |
      | False    |
    And Other Names Screening results tabs are present
      | Key data | Aliases | Further information | Keywords | Connections/Relationships | Sources |

  @C39466650
  @core_regression
  Scenario: C39466650: Third-party Other Names - Screening - CUSTOM WATCHLIST tab - Select record - Export to PDF
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks on the "Export To PDF" screening profile
    Then ".pdf" File with name "RDDCentre_<recordName1>_Profile_Page_" and date format "ddMMYYYY" downloaded
    And Other Names Screening profile details are present in PDF file "downloadedFileName"

  @C39466643
  @core_regression
  Scenario: C39466643: Third-party Other Names - Screening - CUSTOM WATCHLIST tab - Select record - Verify Legal Notice footer
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And "Legal Notice" profile details is displayed
    When User clicks screening profile Legal Notice link
    Then New window should be opened

  @C39466651
  @core_regression
  Scenario: C39466651: Third-party Other Names - Screening - CUSTOM WATCHLIST tab - Select record - Mark record as Positive
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 1 record as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                     |
      | Resolution type has been updated to positive |
    And 'Tag as red flag' is turned on
    And Screening profiles Resolution Type is "POSITIVE"
    And Risk Level value on Screening profile page is "MEDIUM"
    And Reason value on Screening profile page is "FULL MATCH"
    And Comment profile section contains expected text "Comment text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date

  @C39466654
  @core_regression
  Scenario: C39466654: Third-party Other Names - Screening - CUSTOM WATCHLIST tab - Select record - Remove Resolution Type
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks last page icon
    Then Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    When User clicks on 1 number Other name screening record
    And User selects "false" resolution in screening detail page
    Then Add Comment modal is displayed
    When User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User fills in comment "Comment text new"
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success! Resolution type has been removed |
    And Screening profiles Resolution Type is "UNSPECIFIED"
    And 'Tag as red flag' is turned off
    And Screening profiles Resolution Type contains correspond data
    And Risk Level value on Screening profile page is "UNKNOWN"
    And Reason value on Screening profile page is "UNKNOWN"
    And Comment profile section contains expected text "Comment text new"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date

  @C39466665
  @core_regression
  Scenario: C39466665: Third-party Other Names - Screening - Record Details page - Cancel/Add Comment
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening profile page comment section button "Comment" is disabled
    And Screening profile page comment section button "Cancel" is enabled
    And Screening profile page comment section text input area is displayed
    When User fills in screening profile comment "Text text"
    Then Screening profile page comment text area contains "Text text"
    And Screening profile page comment section button "Comment" is enabled
    When User clicks screening profile comment button "Cancel"
    Then Screening profile page comment text area contains ""
    And Comment profile section is not displayed
    When User fills in screening profile comment "Text text"
    And User clicks screening profile Comment button
    Then Created comments on screening profile page are displayed and sorted by upload date

  @C39466669
  @core_regression
  Scenario: C39466669: Third-party Other Names - Screening - Record Details page - Edit and Save Comment
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User on Screening profile page adds 3 comments "Screening profile comment text N"
    Then Created comments on screening profile page are displayed and sorted by upload date
    When User on Screening Profile page edits comment "Screening profile comment text N3" with text "Edited #3 text"
    And User clicks screening profile comment button "Save"
    Then Edited comment on Screening Profile page is displayed
    And Edited comment on Screening Profile page is marked with 'Edited' label
    And Edited comment on Screening Profile is on initial position in comments list

  @C39466671
  @core_regression
  Scenario: C39466671: Third-party Other Names - Screening - Record Details page - Verify that user can delete its own comment
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User fills in screening profile comment "Test Text"
    And User clicks screening profile Comment button
    And User clicks on the 'Screening Results' screening profile button
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Created comments on screening profile page are displayed and sorted by upload date
    When User on Screening Profile page deletes comment "Test Text"
    Then Message is displayed on confirmation window
      | DELETE COMMENT                                                              |
      | Are you sure you want to delete this Comment? This change cannot be undone. |
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Created comments on screening profile page are displayed and sorted by upload date
    When User on Screening Profile page deletes comment "Test Text"
    And User clicks Delete button on confirmation window
    Then Screening profile comment is deleted from list

  @C39466626
  Scenario: C39466626: Third party Other Names - Screening - Custom Watchlist tab - Mark record as FALSE from Record Details - Verify that False record is Not moved in Main Screening
    When User clicks on 1 number Other name screening record
    And User selects "false" resolution in screening detail page
    Then Add Comment modal is displayed
    When User fills in comment "Mark record from profile as FALSE comment"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    When User clicks on the 'Screening Results' screening profile button
    Then Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page
    When User clicks last page icon
    Then Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    And World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    When User clicks Close Other Name Results button
    Then Screening record under number 1 does not appear in the main screening table
    And Sorted search "Custom WatchList" results for "supplier" appear in main screening table for current page with "Samsung" other name positive or possible resolved results
