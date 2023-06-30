@ui @full_regression @react @third_party_other_names
Feature: Third-party Other Name - Screening

  As a user,
  I want to see the WC screening results for Third-party Other Names.
  So that I can manage the Third-party risk management.

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    When User creates third-party "with questionnaire workflow" via API and open it

  @C36491686
  Scenario: C36491686: Third-party Other Name - Verify that Other name will not automatically screen upon creation
    Then "Other Names Section" for other name is displayed
    And Add Name mandatory text field is displayed
    And Add Name Type mandatory drop-down field is displayed with list
      | Local Language Name |
      | Doing Business As   |
      | Former Name         |
      | Subsidiary          |
      | Other Name          |
    And Other Name Check Type checkbox fields are displayed with options
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    And Other Name Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    And Other Name Check Type "World-Check" is disabled
    When User fills in Name field value "John"
    And User selects Name type "Doing Business As"
    And User edits "Country of Registration" field with value "United Kingdom"
    And User clicks on "Other Names Add|Save button"
    Then Other Name table is displayed with column names
      | NAME | NAME TYPE | DATE CREATED | LAST UPDATE |
    And Other Name table contains expected values
      | John              |
      | Doing Business As |
      | MM/dd/YYYY        |
      | MM/dd/YYYY        |
    And Delete Other Name button is displayed in the Other Names section after each record
    And Edit Other Name button is displayed in the Other Names section after each record
    And Screening Other Name button is displayed in the Other Names section after each record

  @C36491723
  Scenario: C36491723: Third-party Other Names - When the user hits 'Screening' icon, send the other name to screen against WC1
    When User fills in Name field value "John"
    And User selects Name type "Doing Business As"
    And User edits "Country of Registration" field with value "United Kingdom"
    And User clicks on "Other Names Add|Save button"
    And User opens screening results for "John" Other name
    Then Other Name dialog is loaded
    And Other Name "WORLD-CHECK" tab is visible
    And Other Name "CUSTOM WATCHLIST" tab is visible
    And Other Name "MEDIA CHECK" tab is visible
    And Sorted search "World-Check" results for "John" "supplier" appear in other names screening table for current page
    And "Screening Result pop-up header" for other name screening is displayed with text
      | DOING BUSINESS AS: JOHN |

  @C39420899
  Scenario: C39420899: Third-party Other Name - Screening results- Verify World Check tab
    When User creates Other name "Bank"
    And User opens screening results for "Bank" Other name
    Then Other Name dialog is loaded
    And "WORLD-CHECK" other name tab is selected
    And "Other Name Last Screening Date" for other name screening is displayed with text
      | thirdPartyInformation.screening.lastScreeningDate: d MMMM YYYY |
    And Other Name OGS Toggle Label should display as "World-Check & Custom WatchList Ongoing Screening"
    And Other Name screening table displays expected columns
      | thirdPartyInformation.screening.columnName                  |
      | thirdPartyInformation.screening.columnCountryOfRegistration |
      | thirdPartyInformation.screening.columnType                  |
      | thirdPartyInformation.screening.columnMatchStrength         |
      | thirdPartyInformation.screening.columnDataProvider          |
      | thirdPartyInformation.screening.columnReferenceId           |
      | thirdPartyInformation.screening.columnResolution            |
    And Resolution type contains following tooltip text when hover on it
      | Positive |
      | Possible |
      | False    |
    And Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page

  @C39451920
  Scenario: C39451920: Third-party Other Names - Screening - World-Check tab - Remove Resolution Type
    When User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Resolve as False"
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Resolve as False"
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 1 appears in the other name screening table with "UNSPECIFIED" resolution
    And Sorted search "World-Check" results for "ROSHEN" "supplier" appear in other names screening table for current page

  @C36183098
  Scenario: C36183098: Third-party Other Name- Verify sorting resolution type
    When User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
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
    And Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
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
    And Sorted search "World-Check" results for "ROSHEN" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
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
    When User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    And Other name screening record under number 3 appears in the other name screening table with "UNSPECIFIED" resolution
    And Sorted search "World-Check" results for "ROSHEN" "supplier" appear in other names screening table for current page

  @C39421015
  Scenario: C39421015: Third-party Other Name - Screening result - No Available Data
    When User creates Other name "qwert123!@#$"
    And User opens screening results for "qwert123!@#$" Other name
    Then Other Name dialog is loaded
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |

  @C39421079
  Scenario: C39421079: Third-party Other Names - Screening - World-Check tab - Verify Pagination
    When User creates Other name "Bank"
    And User opens screening results for "Bank" Other name
    Then Other Name dialog is loaded
    And "WORLD-CHECK" other name tab is selected
    And Screening Table for Other name displays up to 10 items per page
    And Screening Table displays '10' pagination selection
    When User clicks on "Other Name Screening Pagination Drop-Down" Other name screening element
    Then Other Name Screening Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    And Label for "World-Check" results "Bank" "supplier" Other Name is expected
    And Results page number for "World-Check" results "Bank" "supplier" Other Name is expected
    When User clicks Other Name screening results 'next page' button
    Then Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    When User clicks Other Name screening results 'previous page' button
    Then Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    When User clicks Other Name screening results 'last page' button
    Then Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    When User clicks Other Name screening results 'first page' button
    Then Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    When User clicks Other Name screening results "3" button
    Then Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    When User selects 25 rows per page
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 25 items per page
    And Screening Table displays '25' pagination selection
    When User clicks on "Other Name Screening Pagination Drop-Down" Other name screening element
    And User selects 50 rows per page
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 50 items per page
    And Screening Table displays '50' pagination selection
    When User clicks on "Other Name Screening Pagination Drop-Down" Other name screening element
    And User selects 10 rows per page
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Screening Table displays '10' pagination selection

  @C39451684
  Scenario: C39451684: Third-party Other Names - Screening - World-Check tab - Verify Resolution Type modal
    When User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
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
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And 'Tag as red flag' is turned on
    And Risk Level value on Screening profile page is "MEDIUM"
    And Reason value on Screening profile page is "FULL MATCH"
    And Comment profile section contains expected text "Comment text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date

  @C39466688
  @core_regression
  Scenario: C39466688: Third-party Other Names - Screening - World-Check tab - Verify that user with Ongoing Screening role permission can turn on/off OGS toggle
    When User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    And "WORLD-CHECK" other name tab is selected
    And Other Name OGS Toggle Label should display as "World-Check & Custom WatchList Ongoing Screening"
    And World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    When User clicks Other Names OGS slider
    Then OGS alert message "Success! Ongoing screening is turned on." is displayed
    And World-Check & Custom WatchList Ongoing Screening toggle is turned On
    And Ongoing Screening toggle contains "World-Check & Custom WatchList Ongoing Screening: On" tooltip text when hover on it
    When User clicks Other Names OGS slider
    Then OGS alert message "Success! Ongoing screening is turned off." is displayed
    And World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    And Ongoing Screening toggle contains "World-Check & Custom WatchList Ongoing Screening: Off" tooltip text when hover on it

  @C39466689
  @core_regression
  Scenario: C39466689: Third-party Other Names - Screening - World-Check tab - Verify that OGS toggle is hidden for user without
    When User logs into RDDC as "user media check permission off"
    And User opens previously created Third-party
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    And "WORLD-CHECK" other name tab is selected
    And Other Names OGS Toggle label is hidden
    And Other Names OGS Toggle is hidden
