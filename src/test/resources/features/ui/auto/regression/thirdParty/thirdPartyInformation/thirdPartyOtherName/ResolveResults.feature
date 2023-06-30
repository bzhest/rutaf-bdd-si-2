@ui @full_regression @react @wc1 @other_names
Feature: Third-Party Other Names - Screening - World-Check tab

  As a SI user,
  I want an ability to change the resolution type.
  So that I can manage the results.

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"

  @C33631310
  @core_regression
  Scenario: C33631310: Third-party Other Names - Screening - World-Check tab - Change multiple Positive Other name record's resolution - Screening Table
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "ROSHEN" "supplier" appear in other names screening table for current page
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
    When User opens screening results for "ROSHEN" Other name
    Then Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    And Other name screening record under number 2 appears in the other name screening table with 'UNSPECIFIED' resolution
    And Other name screening record under number 3 does not appear in the other name screening table

  @C33631310
  @core_regression
  Scenario: C33631310: Third-party Other Names - Screening - World-Check tab - Change multiple Positive Other name record's resolution - Record Details Page
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "ROSHEN" "supplier" appear in other names screening table for current page
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
    When User opens screening results for "ROSHEN" Other name
    Then Other name screening record under number 4 appears in the other name screening table with "FALSE" resolution
    And Other name screening record under number 5 appears in the other name screening table with 'UNSPECIFIED' resolution
    And Other name screening record under number 6 does not appear in the other name screening table

  @C33632214
  @core_regression
  Scenario: C33632214: Third-party Other Names- Screening - World-Check tab - Change multiple POSSIBLE Other name record's resolution - Screening Table
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "ROSHEN" "supplier" appear in other names screening table for current page
    When User selects Other Name screening record for "supplier" on position 1
    And User selects Other Name screening record for "supplier" on position 2
    And User selects Other Name screening record for "supplier" on position 3
    And User clicks on "Resolve As" Other name screening element
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    When User clicks "Possible" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then World-Check & Custom WatchList Ongoing Screening toggle is turned On
    When User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 2 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 3 appears in the main screening table with "POSSIBLE" resolution
    When User clicks resolve Other Name screening record under number 1 on main screening list as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 1 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 2 on main screening list as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 2 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 3 on main screening list as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 3 appears in the main screening table with "POSITIVE" resolution
    When User opens screening results for "ROSHEN" Other name
    Then Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    And Other name screening record under number 2 appears in the other name screening table with 'UNSPECIFIED' resolution
    And Other name screening record under number 3 does not appear in the other name screening table

  @core_regression
  Scenario: C33632214: Third-party Other Names- Screening - World-Check tab - Change multiple POSSIBLE Other name record's resolution - Record Details Page
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "ROSHEN" "supplier" appear in other names screening table for current page
    When User clicks on 4 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 4 record as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    When User clicks on 5 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 5 record as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    When User clicks on 6 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 6 record as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    Then Screening record under number 4 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 5 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 6 appears in the main screening table with "POSSIBLE" resolution
    When User clicks resolve Other Name screening record under number 4 on main screening list as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 4 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 5 on main screening list as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 5 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 6 on main screening list as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 6 appears in the main screening table with "POSITIVE" resolution
    When User opens screening results for "ROSHEN" Other name
    Then Other name screening record under number 4 appears in the other name screening table with "FALSE" resolution
    And Other name screening record under number 5 appears in the other name screening table with 'UNSPECIFIED' resolution
    And Other name screening record under number 6 does not appear in the other name screening table

  @C33632216
  @core_regression
  Scenario: C33632216: Third-party Other Names- Screening - World-Check tab - Change multiple False Other name record's resolution
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "ROSHEN" "supplier" appear in other names screening table for current page
    When User selects Other Name screening record for "supplier" on position 1
    And User selects Other Name screening record for "supplier" on position 2
    And User selects Other Name screening record for "supplier" on position 3
    And User clicks on "Resolve As" Other name screening element
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    When User clicks "False" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    When User clicks Close Other Name Results button
    Then Screening record under number 1 does not appear in the main screening table
    And Screening record under number 2 does not appear in the main screening table
    And Screening record under number 3 does not appear in the main screening table
    When User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Mark record from profile as FALSE comment"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks resolve Other Name screening record for "supplier" under number 2 as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks resolve Other Name screening record for "supplier" under number 3 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Other name screening record under number 1 appears in the other name screening table with 'UNRESOLVED' resolution
    And Other name screening record under number 2 does not appear in the other name screening table
    And Other name screening record under number 3 does not appear in the other name screening table
    When User clicks Close Other Name Results button
    Then Screening record under number 3 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 2 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 1 does not appear in the main screening table

  @C33631295
  @core_regression
  Scenario: C33631295: Third-party Other Names - Screening - World-Check tab - Mark record as POSITIVE - Verify that OGS toggle is turned on and Positive record is moved to main screening
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "Bank"
    And User opens screening results for "Bank" Other name
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    And "WORLD-CHECK" other name tab is selected
    When User clicks resolve Other Name screening record for "supplier" under number 10 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Other name screening record under number 10 does not appear in the other name screening table
    And Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    And World-Check & Custom WatchList Ongoing Screening toggle is turned On
    When User clicks Close Other Name Results button
    Then Screening record under number 10 appears in the main screening table with "POSITIVE" resolution
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "Bank" other name positive or possible resolved results

  @C33631305
  @core_regression
  Scenario: C33631305: Third-party Other Names - Screening - World-Check tab - Move POSITIVE records to the main screening page-Third-party WITHOUT screening result
    When User creates Other name "PetroChina"
    And User opens screening results for "PetroChina" Other name
    And Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "PetroChina" "supplier" appear in other names screening table for current page
    And "WORLD-CHECK" other name tab is selected
    When User clicks resolve Other Name screening record for "supplier" under number 7 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns off 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Other name screening record under number 7 does not appear in the other name screening table
    And Sorted search "World-Check" results for "PetroChina" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    Then Screening record under number 7 appears in the main screening table with "POSITIVE" resolution
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "PetroChina" other name positive or possible resolved results

  @C33632157
  Scenario: C33632157: Third-party Other Names - Screening - World-Check tab - Mark record as POSSIBLE - Verify that OGS toggle is turned on and Possible record is moved to main screening
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "Роснефть"
    And User opens screening results for "Роснефть" Other name
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "Роснефть" "supplier" appear in other names screening table for current page
    And "WORLD-CHECK" other name tab is selected
    When User clicks resolve Other Name screening record for "supplier" under number 3 as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Other name screening record under number 3 does not appear in the other name screening table
    And Sorted search "World-Check" results for "Роснефть" "supplier" appear in other names screening table for current page
    And World-Check & Custom WatchList Ongoing Screening toggle is turned On
    When User clicks Close Other Name Results button
    Then Screening record under number 3 appears in the main screening table with "POSSIBLE" resolution
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "Роснефть" other name positive or possible resolved results

  @C33632220
  Scenario: C33632220: Third-party Other Names - Screening - World-Check tab - Mark record as POSITIVE from Record Details page - Verify that OGS toggle is turned on and Positive record is moved to main screening
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "Bank"
    And User opens screening results for "Bank" Other name
    And Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    And "WORLD-CHECK" other name tab is selected
    When User clicks on 4 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 4 record as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns off 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    And Other name screening record under number 4 does not appear in the other name screening table
    And Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    And World-Check & Custom WatchList Ongoing Screening toggle is turned On
    When User clicks Close Other Name Results button
    Then Screening record under number 4 appears in the main screening table with "POSITIVE" resolution
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "Bank" other name positive or possible resolved results

  @C33632404
  @core_regression
  Scenario: C33632404: Third-party Other Names - Screening - World-Check tab - Mark record as POSSIBLE from Record Details page - Verify that OGS toggle is turned on and Possible record is moved to main screening
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "Роснефть"
    And User opens screening results for "Роснефть" Other name
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "Роснефть" "supplier" appear in other names screening table for current page
    And "WORLD-CHECK" other name tab is selected
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 1 record as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns off 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    And Other name screening record under number 1 does not appear in the other name screening table
    And Sorted search "World-Check" results for "Роснефть" "supplier" appear in other names screening table for current page
    And World-Check & Custom WatchList Ongoing Screening toggle is turned On
    When User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "Роснефть" other name positive or possible resolved results

  @C33632158
  @core_regression
  Scenario: C33632158: Third party Other Names - Screening - World-Check tab - Mark record as FALSE - Verify that False record is Not moved in Main Screening
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED"
    And User opens screening results for "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED" Other name
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED" "supplier" appear in other names screening table for current page
    And "WORLD-CHECK" other name tab is selected
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Mark record from profile as FALSE comment"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    And Sorted search "World-Check" results for "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED" "supplier" appear in other names screening table for current page
    And World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    When User clicks Close Other Name Results button
    Then Screening record under number 1 does not appear in the main screening table
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED" other name positive or possible resolved results

  @C33632533
  @core_regression
  Scenario: C33632533: Third party Other Names - Screening - World-Check tab - Mark record as FALSE from Record Details - Verify that False record is Not moved in Main Screening
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED"
    And User opens screening results for "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED" Other name
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED" "supplier" appear in other names screening table for current page
    And "WORLD-CHECK" other name tab is selected
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 1 record as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Mark record from profile as FALSE comment"
    And User turns off 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    And Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    And Sorted search "World-Check" results for "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED" "supplier" appear in other names screening table for current page
    And World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    When User clicks Close Other Name Results button
    Then Screening record under number 1 does not appear in the main screening table
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED" other name positive or possible resolved results

  @C33641920
  @core_regression
  Scenario: C33641920: Third-party Other Names - Screening - World-Check tab - Mark multiple records to Positive - Verify that positive records are moved to main screening table
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "Bank"
    And User opens screening results for "Bank" Other name
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    And "WORLD-CHECK" other name tab is selected
    When User selects all Other name screening records for "supplier" and resolve as "Possible"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns off 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    And World-Check & Custom WatchList Ongoing Screening toggle is turned On
    When User clicks Close Other Name Results button
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "Bank" other name positive or possible resolved results

  @C33642049
  @core_regression
  Scenario: C33642049: Third-party Other Names - Screening - World-Check tab - Mark multiple records to Possible - Verify that possible records are moved to main screening table
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "Amazon"
    And User opens screening results for "Amazon" Other name
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "Amazon" "supplier" appear in other names screening table for current page
    And "WORLD-CHECK" other name tab is selected
    When User selects all Other name screening records for "supplier" and resolve as "Possible"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns off 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Sorted search "World-Check" results for "Amazon" "supplier" appear in other names screening table for current page
    And World-Check & Custom WatchList Ongoing Screening toggle is turned On
    When User clicks Close Other Name Results button
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "Amazon" other name positive or possible resolved results

  @C33642050
  @core_regression
  Scenario: C33642050: Third-party Other Names - Screening - World-Check tab - Mark multiple records to False- Verify that false records are NOT moved to main screening table
    And User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    And Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "ROSHEN" "supplier" appear in other names screening table for current page
    And "WORLD-CHECK" other name tab is selected
    When User selects all Other name screening records for "supplier" and resolve as "False"
    Then Add Comment modal is displayed
    When User fills in comment "Mark record from profile as FALSE comment"
    And User turns off 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Sorted search "World-Check" results for "ROSHEN" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "ROSHEN" other name positive or possible resolved results

  @C33642051
  @core_regression
  Scenario: C33642051: Third-party Other Names - Screening - World-Check tab - Mark multiple records to Unresolved- Verify that false records are NOT moved to main screening table
    When User changes Search Criteria "Search Term" with value "Apple"
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "ROSHEN" "supplier" appear in other names screening table for current page
    And "WORLD-CHECK" other name tab is selected
    When User selects all Other name screening records for "supplier" and resolve as "Unresolved"
    Then Add Comment modal is displayed
    When User fills in comment "Mark record from profile as Unresolved comment"
    And User turns off 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    Then Sorted search "World-Check" results for "ROSHEN" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "ROSHEN" other name positive or possible resolved results

  @C33705782
  @core_regression
  Scenario: C33705782: Third-party Other Names - Screening - World-Check tab - Cancel changing resolution of multiple records
    When User creates Other name "Bank"
    And User opens screening results for "Bank" Other name
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    And "WORLD-CHECK" other name tab is selected
    When User clicks on "Select All" Other name screening element
    Then All Other name screening records on current page are selected
    When User clicks on "Resolve As" Other name screening element
    And User clicks on "Cancel" Other name screening element
    Then All Other name screening records on current page are not selected
