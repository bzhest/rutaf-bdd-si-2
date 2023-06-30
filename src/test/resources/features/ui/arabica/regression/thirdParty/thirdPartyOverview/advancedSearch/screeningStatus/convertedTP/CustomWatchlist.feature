@ui @screening_status @arabica

Feature: Custom Watchlist - screening status

  As an RDDC user.
  I want to see a converted third party and its original third party in Third Party Overview with the screening status according to itself and its original third party
  So that I can see and track the screening status of the original third party and the converted third party correctly.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API

  @C50731153
  @full_regression
  Scenario: C50731153: Custom Watchlist - Verify the screening status is Cleared when the original third-party contains all false record
    When User creates third-party "MK"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "CONVERTED_TP"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country       |
      | United States |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    And User submits Third-party creation form
    Then Third-party Information tab is loaded
    When User navigates to Third-party page
    And User searches third-party with name "MK"
    Then Third-party with name "MK" is displayed in Third-party overview table
    When User clicks on third-party "MK"
    Then Third-party Information tab is loaded
    When User selects "50" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    And Rows per page dropdown value should be "50"
    When User selects all screening results
    And User clicks Resolve As screening button
    And User clicks "FALSE" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Mark all as false"
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution type "FALSE" is selected for each record in the main screening table
    When User clicks on "CUSTOM WATCHLIST" tab
    And User selects all screening results
    And User clicks Resolve As screening button
    And User clicks "FALSE" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Mark all as false"
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution type "FALSE" is selected for each record in the main screening table
    When User navigates to Third-party page
    And User searches third-party with name "CONVERTED_TP"
    Then Third-party with name "CONVERTED_TP" is displayed in Third-party overview table
    And Third-party name "CONVERTED_TP" should have status "NEW"
    And Third-party name "CONVERTED_TP" should have Screening Status "CLEARED"
    When User clicks 'Delete' button on third-party name "CONVERTED_TP"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared

  @C50731688
  @full_regression
  Scenario: C50731688: Custom Watchlist - Verify the screening status is Possible when the converted third-party/associated ind contains Possible record
    When User creates third-party "ORIGINAL_TP"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "CONVERTED_TP"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country       |
      | United States |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    And User submits Third-party creation form
    Then Third-party Information tab is loaded
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks Auto-screen button to ON
    And User enters Associated Party first name with value "Joe"
    And User enters Associated Party last name with value "Biden"
    And User clicks on Save Associated Party button
    Then Screening results table is loaded
    When User selects all screening results
    And User clicks Resolve As screening button
    And User clicks "FALSE" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Mark all as false"
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution type "FALSE" is selected for each record in the main screening table
    When User clicks on "CUSTOM WATCHLIST" tab
    And User selects all screening results
    And User clicks Resolve As screening button
    And User clicks "FALSE" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Mark all as false"
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution type "FALSE" is selected for each record in the main screening table
    When User clicks on "WORLD-CHECK" tab
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    Then Add Comment modal is displayed
    When User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    When User navigates to Third-party page
    And User searches third-party with name "CONVERTED_TP"
    Then Third-party with name "CONVERTED_TP" is displayed in Third-party overview table
    And Third-party name "CONVERTED_TP" should have status "NEW"
    And Third-party name "CONVERTED_TP" should have Screening Status "POSSIBLE"
    When User clicks 'Delete' button on third-party name "CONVERTED_TP"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared

  @C50734653
  @full_regression
  Scenario: C50734653: Custom Watchlist - Verify the screening status is Positive when the converted third-party/associated org contains Positive record
    When User creates third-party "ORIGINAL_TP"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "CONVERTED_TP"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country       |
      | United States |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    And User submits Third-party creation form
    Then Third-party Information tab is loaded
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "MK"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country       |
      | United States |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User selects "50" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    And Rows per page dropdown value should be "50"
    When User selects all screening results
    And User clicks Resolve As screening button
    And User clicks "FALSE" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Mark all as false"
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution type "FALSE" is selected for each record in the main screening table
    When User clicks on "CUSTOM WATCHLIST" tab
    And User selects all screening results
    And User clicks Resolve As screening button
    And User clicks "FALSE" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Mark all as false"
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution type "FALSE" is selected for each record in the main screening table
    When User clicks on "WORLD-CHECK" tab
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    Then Add Comment modal is displayed
    When User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    When User navigates to Third-party page
    And User searches third-party with name "CONVERTED_TP"
    Then Third-party with name "CONVERTED_TP" is displayed in Third-party overview table
    And Third-party name "CONVERTED_TP" should have status "NEW"
    And Third-party name "CONVERTED_TP" should have Screening Status "POSITIVE"
    When User clicks 'Delete' button on third-party name "CONVERTED_TP"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared

  @C50710718
  @full_regression
  Scenario: C50710718: Custom Watchlist - Verify the screening status is No Result when the  associated org (it's original TP)/other name of the converted TP contains no screening record.
    When User creates third-party "ORIGINAL_TP"
    And User fills in Name field value "ORIGINAL_TP_OTHER_NAME"
    And User selects Name type "Other Name"
    And User clicks on "Other Names Add|Save button"
    Then Screening results table is loaded
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "CONVERTED_TP"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country       |
      | United States |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    And User submits Third-party creation form
    Then Third-party Information tab is loaded
    When User navigates to Third-party page
    And User searches third-party with name "CONVERTED_TP"
    Then Third-party with name "CONVERTED_TP" is displayed in Third-party overview table
    And Third-party name "CONVERTED_TP" should have status "NEW"
    And Third-party name "CONVERTED_TP" should have Screening Status "NO RESULTS"
    When User clicks 'Delete' button on third-party name "CONVERTED_TP"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared

  @C50731284
  @full_regression
  Scenario: C50731284:Custom Watchlist - Verify the screening status is Positive when the associated ind/other name of the converted contains Positive record
    When User creates third-party "ORIGINAL_TP"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "CONVERTED_TP"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country       |
      | United States |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    And User submits Third-party creation form
    Then Third-party Information tab is loaded
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks Auto-screen button to ON
    And User enters Associated Party first name with value "ASSOCIATED"
    And User enters Associated Party last name with value "INDIVIDUAL"
    And User clicks on Save Associated Party button
    Then Screening results table is loaded
    When User fills in Name field value "Joe Biden"
    And User selects Name type "Also Known As"
    Then Selected Name type "Also Known As" is disabled
    When User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    And "WORLD-CHECK" other name tab is selected
    When User selects all Other name screening records for "supplier" and resolve as "False"
    Then Add Comment modal is displayed
    When User fills in comment "Mark record as FALSE comment"
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then "CUSTOM WATCHLIST" other name tab is selected
    And Other Name dialog is loaded
    When User selects all Other name screening records for "supplier" and resolve as "False"
    Then Add Comment modal is displayed
    When User fills in comment "Mark record as FALSE comment"
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks on "WORLD-CHECK" other name screening tab
    Then "WORLD-CHECK" other name tab is selected
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Mark record as POSITIVE comment"
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    When User navigates to Third-party page
    And User searches third-party with name "CONVERTED_TP"
    Then Third-party with name "CONVERTED_TP" is displayed in Third-party overview table
    And Third-party name "CONVERTED_TP" should have status "NEW"
    And Third-party name "CONVERTED_TP" should have Screening Status "POSITIVE"
    When User clicks 'Delete' button on third-party name "CONVERTED_TP"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared

  @C50735041
  @core_regression
  Scenario: C50735041: Custom Watchlist - Verify the screening status of the converted third-party does not include the original third-party's associated ind in the calculation
    When User creates third-party "MK"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks Auto-screen button to ON
    And User enters Associated Party first name with value "Joe"
    And User enters Associated Party last name with value "Biden"
    And User clicks on Save Associated Party button
    Then Screening results table is loaded
    When User clicks Associated Party Overview contact button
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "Honda"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country       |
      | United States |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    And User submits Third-party creation form
    Then Third-party Information tab is loaded
    When User navigates to Third-party page
    And User searches third-party with name "MK"
    Then Third-party with name "MK" is displayed in Third-party overview table
    When User clicks on third-party "MK"
    Then Third-party Information tab is loaded
    When User selects "50" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    And Rows per page dropdown value should be "50"
    When User selects all screening results
    And User clicks Resolve As screening button
    And User clicks "FALSE" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Mark all as false"
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution type "FALSE" is selected for each record in the main screening table
    When User clicks on "CUSTOM WATCHLIST" tab
    And User selects all screening results
    And User clicks Resolve As screening button
    And User clicks "FALSE" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Mark all as false"
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution type "FALSE" is selected for each record in the main screening table
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks Auto-screen button to ON
    And User enters Associated Party first name with value "Joe"
    And User enters Associated Party last name with value "Biden"
    And User clicks on Save Associated Party button
    Then Screening results table is loaded
    When User clicks on "CUSTOM WATCHLIST" tab
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User navigates to Third-party page
    And User searches third-party with name "Honda"
    Then Third-party with name "Honda" is displayed in Third-party overview table
    And Third-party name "Honda" should have status "NEW"
    And Third-party name "Honda" should have Screening Status "UNRESOLVED"
    When User clicks 'Delete' button on third-party name "Honda"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared

  @C51682538
  @core_regression
  Scenario: C51682538: Custom Watchlist - Verify the screening status of the converted third-party does not include the screening status of the original third-party if the original third-party is deleted
    When User creates third-party "MK"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "CONVERTED_TP"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country       |
      | United States |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    And User submits Third-party creation form
    Then Third-party Information tab is loaded
    When User navigates to Third-party page
    And User searches third-party with name "MK"
    Then Third-party with name "MK" is displayed in Third-party overview table
    When User clicks on third-party "MK"
    Then Third-party Information tab is loaded
    When User selects "50" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    And Rows per page dropdown value should be "50"
    When User selects all screening results
    And User clicks Resolve As screening button
    And User clicks "FALSE" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Mark all as false"
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution type "FALSE" is selected for each record in the main screening table
    When User clicks on "CUSTOM WATCHLIST" tab
    And User selects all screening results
    And User clicks Resolve As screening button
    And User clicks "FALSE" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Mark all as false"
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution type "FALSE" is selected for each record in the main screening table
    When User navigates to Third-party page
    And User searches third-party with name "CONVERTED_TP"
    Then Third-party with name "CONVERTED_TP" is displayed in Third-party overview table
    And Third-party name "CONVERTED_TP" should have status "NEW"
    And Third-party name "CONVERTED_TP" should have Screening Status "CLEARED"
    When User searches third-party with name "MK"
    Then Third-party with name "MK" is displayed in Third-party overview table
    When User clicks 'Delete' button on third-party name "MK"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    When User searches third-party with name "CONVERTED_TP"
    Then Third-party with name "CONVERTED_TP" is displayed in Third-party overview table
    And Third-party name "CONVERTED_TP" should have status "NEW"
    And Third-party name "CONVERTED_TP" should have Screening Status "NO RESULTS"
    When User clicks 'Delete' button on third-party name "CONVERTED_TP"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared

  @C51682539
  @core_regression
  Scenario: C51682539: Custom Watchlist - Verify the screening status of the converted third-party does not include the screening status of the original third-party if the relationship is removed
    When User creates third-party "MK"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "CONVERTED_TP"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country       |
      | United States |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    And User submits Third-party creation form
    Then Third-party Information tab is loaded
    When User navigates to Third-party page
    And User searches third-party with name "MK"
    Then Third-party with name "MK" is displayed in Third-party overview table
    When User clicks on third-party "MK"
    Then Third-party Information tab is loaded
    When User selects "50" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    And Rows per page dropdown value should be "50"
    When User selects all screening results
    And User clicks Resolve As screening button
    And User clicks "FALSE" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Mark all as false"
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution type "FALSE" is selected for each record in the main screening table
    When User clicks on "CUSTOM WATCHLIST" tab
    And User selects all screening results
    And User clicks Resolve As screening button
    And User clicks "FALSE" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Mark all as false"
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution type "FALSE" is selected for each record in the main screening table
    When User navigates to Third-party page
    And User searches third-party with name "CONVERTED_TP"
    Then Third-party with name "CONVERTED_TP" is displayed in Third-party overview table
    And Third-party name "CONVERTED_TP" should have status "NEW"
    And Third-party name "CONVERTED_TP" should have Screening Status "CLEARED"
    When User searches third-party with name "MK"
    Then Third-party with name "MK" is displayed in Third-party overview table
    When User clicks on third-party "MK"
    Then Third-party Information tab is loaded
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks delete button for Associated Party "CONVERTED_TP"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    When User navigates to Third-party page
    And User searches third-party with name "CONVERTED_TP"
    Then Third-party with name "CONVERTED_TP" is displayed in Third-party overview table
    And Third-party name "CONVERTED_TP" should have status "NEW"
    And Third-party name "CONVERTED_TP" should have Screening Status "NO RESULTS"
    When User clicks 'Delete' button on third-party name "CONVERTED_TP"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared

  @C50709171
  @full_regression
  Scenario: C50709171: Custom Watchlist - Verify the screening status is Positive when the converted third-party other name contains Positive record
    When User creates third-party "ORIGINAL_TP"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "CONVERTED_TP"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country       |
      | United States |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    And User submits Third-party creation form
    Then Third-party Information tab is loaded
    When User fills in Name field value "MK"
    And User selects Name type "Other Name"
    And User clicks on "Other Names Add|Save button"
    Then Screening results table is loaded
    When User opens screening results for "MK" Other name
    Then Other Name dialog is loaded
    And "WORLD-CHECK" other name tab is selected
    When User selects "50" option from Rows Per Page dropdown list on Other Names
    Then Other Name dialog is loaded
    When User selects all Other name screening records for "supplier" and resolve as "False"
    Then Add Comment modal is displayed
    When User fills in comment "Mark record as FALSE comment"
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then "CUSTOM WATCHLIST" other name tab is selected
    And Other Name dialog is loaded
    When User selects all Other name screening records for "supplier" and resolve as "False"
    Then Add Comment modal is displayed
    When User fills in comment "Mark record as FALSE comment"
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Mark record as POSITIVE comment"
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    Then Screening results table is loaded
    When User clicks on "CUSTOM WATCHLIST" tab
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    When User navigates to Third-party page
    And User searches third-party with name "CONVERTED_TP"
    Then Third-party with name "CONVERTED_TP" is displayed in Third-party overview table
    And Third-party name "CONVERTED_TP" should have status "NEW"
    And Third-party name "CONVERTED_TP" should have Screening Status "POSITIVE"
    When User clicks 'Delete' button on third-party name "CONVERTED_TP"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared