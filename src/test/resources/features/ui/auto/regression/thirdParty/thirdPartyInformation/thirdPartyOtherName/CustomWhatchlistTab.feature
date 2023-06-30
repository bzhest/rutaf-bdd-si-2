@ui @full_regression @react @third_party_other_names
Feature: Third-party Other Names - Screening - Custom Watchlist tab

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"

  @C39420921
  Scenario: C39420921: Third-party Other Name - Screening results- Verify Custom Watchlist tab
    When User creates Other name "Samsung"
    And User opens screening results for "Samsung" Other name
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    And "CUSTOM WATCHLIST" other name tab is selected
    And "Other Name Last Screening Date" for other name screening is displayed with text
      | thirdPartyInformation.screening.lastScreeningDate: d MMMM YYYY |
    And Other Name OGS Toggle Label should display as "World-Check & Custom WatchList Ongoing Screening"
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page

  @C39466621
  @core_regression
  Scenario: C39466621: Third-party Other Names - Screening - CUSTOM WATCHLIST tab - Mark record as POSITIVE - Verify that OGS toggle is turned on and Positive record is moved to main screening
    When User creates Other name "Samsung"
    And User opens screening results for "Samsung" Other name
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Other name screening record under number 1 does not appear in the other name screening table
    And World-Check & Custom WatchList Ongoing Screening toggle is turned On
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on "CUSTOM WATCHLIST" tab
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And Sorted search "Custom WatchList" results for "supplier" appear in main screening table for current page with "Samsung" other name positive or possible resolved results

  @C39466622
  @core_regression
  Scenario: C39466622: Third-party Other Names - Screening - CUSTOM WATCHLIST tab - Mark record as POSITIVE from Record Details page - Verify that OGS toggle is turned on and Positive record is moved to main screening
    When User creates Other name "Samsung"
    And User opens screening results for "Samsung" Other name
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page
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
      | Success! Resolution type has been updated to positive. |
    And Screening profiles Resolution Type is "POSITIVE"
    When User clicks on the 'Screening Results' screening profile button
    Then Other Name dialog is loaded
    And Other name screening record under number 1 does not appear in the other name screening table
    And World-Check & Custom WatchList Ongoing Screening toggle is turned On
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on "CUSTOM WATCHLIST" tab
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And Sorted search "Custom WatchList" results for "supplier" appear in main screening table for current page with "Samsung" other name positive or possible resolved results

  @C39466625
  Scenario: C39466625: Third party Other Names - Screening - CUSTOM WATCHLIST tab - Mark record as FALSE - Verify that False record is Not moved in Main Screening
    When User creates Other name "Samsung"
    And User opens screening results for "Samsung" Other name
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Mark record from profile as FALSE comment"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    When User clicks Other Name screening results 'last page' button
    Then Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on "CUSTOM WATCHLIST" tab
    Then Screening record under number 1 does not appear in the main screening table
    And Sorted search "Custom WatchList" results for "supplier" appear in main screening table for current page with "Samsung" other name positive or possible resolved results

  @C39466628
  @core_regression
  Scenario: C39466628: Third-party Other Names - Screening -CUSTOM WATCHLIST tab - Change multiple Positive Other name record's resolution
    When User creates Other name "Samsung"
    And User opens screening results for "Samsung" Other name
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page
    When User selects Other Name screening record for "supplier" on position 1
    And User selects Other Name screening record for "supplier" on position 2
    And User selects Other Name screening record for "supplier" on position 3
    And User clicks on "Resolve As" Other name screening element
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    When User clicks "Positive" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then World-Check & Custom WatchList Ongoing Screening toggle is turned On
    When User clicks Close Other Name Results button
    And User clicks on "CUSTOM WATCHLIST" tab
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 2 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 3 appears in the main screening table with "POSITIVE" resolution
    When User clicks resolve Other Name screening record under number 1 on main screening list as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 1 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 2 on main screening list as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 2 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 3 on main screening list as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 3 appears in the main screening table with "POSSIBLE" resolution
    When User opens screening results for "Samsung" Other name
    And User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    When User clicks Other Name screening results 'last page' button
    Then Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    And Other name screening record under number 2 appears in the other name screening table with 'UNSPECIFIED' resolution
    And Other name screening record under number 3 does not appear in the other name screening table
    When User clicks on 4 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 4 record as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks on the "Back To Screening Results Button" screening profile
    And User clicks Other Name screening results 'first page' button
    Then Other Name dialog is loaded
    When User clicks on 5 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 5 record as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    When User clicks on 6 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 6 record as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    And User clicks on "CUSTOM WATCHLIST" tab
    Then Screening record under number 4 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 5 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 6 appears in the main screening table with "POSITIVE" resolution
    When User clicks resolve Other Name screening record under number 4 on main screening list as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 4 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 5 on main screening list as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    And Screening record under number 5 does not appear in the main screening table
    And User clicks resolve Other Name screening record under number 6 on main screening list as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 6 appears in the main screening table with "POSSIBLE" resolution
    When User opens screening results for "Samsung" Other name
    And User clicks on "CUSTOM WATCHLIST" other name screening tab
    And User clicks Other Name screening results 'last page' button
    Then Other name screening record under number 4 appears in the other name screening table with "FALSE" resolution
    And Other name screening record under number 5 appears in the other name screening table with 'UNSPECIFIED' resolution
    And Other name screening record under number 6 does not appear in the other name screening table

  @C39466631
  @core_regression
  Scenario: C39466631: Third-party Other Names - Screening - CUSTOM WATCHLIST tab - Mark multiple records to Positive - Verify that positive records are moved to main screening table
    When User creates Other name "Samsung"
    And User opens screening results for "Samsung" Other name
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page
    When User selects all Other name screening records for "supplier" and resolve as "Positive"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page
    And World-Check & Custom WatchList Ongoing Screening toggle is turned On
    When User clicks Close Other Name Results button
    And User clicks on "CUSTOM WATCHLIST" tab
    Then Sorted search "Custom WatchList" results for "supplier" appear in main screening table for current page with "Samsung" other name positive or possible resolved results

  @C39466636
  Scenario: C39466636: Third-party Other Names - Screening -CUSTOM WATCHLIST tab - Remove Resolution Type
    When User creates Other name "Samsung"
    And User opens screening results for "Samsung" Other name
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Resolve as False"
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Other Name screening results 'last page' button
    Then Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Resolve as False"
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 1 appears in the other name screening table with "UNSPECIFIED" resolution
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page

  @C39466637
  Scenario: C39466637: Third-party Other Name- Screening - CUSTOM WATCHLIST tab - Verify sorting resolution type
    When User creates Other name "Samsung"
    And User opens screening results for "Samsung" Other name
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Resolve as False"
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks resolve Other Name screening record for "supplier" under number 2 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Resolve as False"
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Other Name screening results 'last page' button
    Then Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    When User clicks resolve Other Name screening record for "supplier" under number 2 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Resolve as False"
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks resolve Other Name screening record for "supplier" under number 3 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks resolve Other Name screening record for "supplier" under number 4 as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on "CUSTOM WATCHLIST" tab
    Then Screening record under number 3 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 4 appears in the main screening table with "POSSIBLE" resolution
    When User clicks resolve Other Name screening record under number 3 on main screening list as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 3 does not appear in the main screening table
    When User opens screening results for "Samsung" Other name
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    When User clicks Other Name screening results 'last page' button
    Then Other Name dialog is loaded
    And Other name screening record under number 3 appears in the other name screening table with "UNSPECIFIED" resolution
    And Sorted search "Custom WatchList" results for "Samsung" "supplier" appear in other names screening table for current page

  @C39466638
  Scenario: C39466638: Third-party Other Name - Screening - CUSTOM WATCHLIST tab - No Available Data
    When User creates Other name "qwert123!@#$"
    And User opens screening results for "qwert123!@#$" Other name
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |

  @C39466640
  Scenario: C39466640: Third-party Other Names - Screening - CUSTOM WATCHLIST tab - Verify Resolution Type modal
    When User creates Other name "Samsung"
    And User opens screening results for "Samsung" Other name
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "POSITIVE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSITIVE        |
      | Risk Level      |
      | Reason          |
      | Comment         |
      | Tag As Red Flag |
      | CANCEL          |
      | SAVE            |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And "Risk Level" is a mandatory field
    And "Reason" is a mandatory field
    And Add Comment modal "Risk Level" drop-down contains values
      | Unknown |
      | High    |
      | Medium  |
      | Low     |
    And Add Comment modal "Reason" drop-down contains values
      | Full Match    |
      | No Match      |
      | Partial Match |
      | Unknown       |
    And Add Comment modal character counter "0/900" is displayed
    When User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    Then Add Comment modal character counter "900/900" is displayed
    And Comment modal Tag as red is turned off
    When User clicks "Cancel" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 1 appears in the other name screening table with "UNRESOLVED" resolution
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "POSITIVE"
    Then Add Comment modal is displayed
    When User clicks "Save" Add Comment modal button
    Then "Risk Level" dropdown should show "This field is required" message
    And "Reason" dropdown should show "This field is required" message
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 1 does not appear in the other name screening table
    And World-Check & Custom WatchList Ongoing Screening toggle is turned On
    When User clicks Close Other Name Results button
    And User clicks on "CUSTOM WATCHLIST" tab
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And 'Tag as red flag' is turned on
    And Risk Level value on Screening profile page is "MEDIUM"
    And Reason value on Screening profile page is "FULL MATCH"
    And Comment profile section contains expected text "Comment text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date