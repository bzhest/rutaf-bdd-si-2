@ui @screening_status @arabica

Feature: World Check - screening status

  As an RDDC user.
  I want to see a converted third party and its original third party in Third Party Overview with the screening status according to itself and its original third party
  So that I can see and track the screening status of the original third party and the converted third party correctly.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API

  @C50734645
  @full_regression
  Scenario: C50734645: World Check - Verify the screening status is Pending Review when the  associated org of the TP contains Pending Review record
    When User creates third-party "with random ID name"
    And User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    When User clicks on created third-party
    Then Third-party Information tab is loaded
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "Apple"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    When User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "PENDING REVIEW"

  @C50736241
  @core_regression
  Scenario: C50736241: World Check - Verify the screening status of the third-party does not include the converted third-party's associated ind in the calculation
    When User creates third-party "ORIGINAL_TP"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "Honda2"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country       |
      | United States |
    And User clicks Save Associated Organisation button
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
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    Then "Screening Criteria" section for add third-party is displayed between "Contact" and "Description" sections
    When User submits Third-party creation form
    Then Third-party Information tab is loaded
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks Auto-screen button to ON
    And User enters Associated Party first name with value "Joe"
    And User enters Associated Party last name with value "Biden"
    And User clicks on Save Associated Party button
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User navigates to Third-party page
    And User searches third-party with name "ORIGINAL_TP_AUTO"
    Then Third-party with name "ORIGINAL_TP_AUTO" is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "UNRESOLVED"
    When User searches third-party with name "Honda2"
    Then  Third-party with name "Honda2" is displayed in Third-party overview table
    When User clicks 'Delete' button on third-party name "Honda2"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared

  @C51680788
  @core_regression
  Scenario: C51680788: World Check - Verify the screening status of the third-party does not include the screening status of the converted third-party if the converted third-party is deleted
    When User creates third-party "ORIGINAL_TP"
    Then No Available Data on "WORLD-CHECK" tab is displayed
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
    And Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    And User changes Search Term to "Apple"
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    When User navigates to Third-party page
    And User searches third-party with name "ORIGINAL_TP_AUTO"
    Then Third-party with name "ORIGINAL_TP_AUTO" is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "PENDING REVIEW"
    When User searches third-party with name "CONVERTED_TP"
    Then Third-party with name "CONVERTED_TP" is displayed in Third-party overview table
    When User clicks 'Delete' button on third-party name "CONVERTED_TP"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    When User searches third-party with name "ORIGINAL_TP_AUTO"
    Then  Third-party with name "ORIGINAL_TP_AUTO" is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "NO RESULTS"

  @C51680900
  @core_regression
  Scenario: C51680900: World Check - Verify the screening status of the third-party does not include the screening status of the converted third-party if the relationship is removed
    When User creates third-party "ORIGINAL_TP"
    Then No Available Data on "WORLD-CHECK" tab is displayed
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
    And Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    And User changes Search Term to "Apple"
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    When User navigates to Third-party page
    And User searches third-party with name "ORIGINAL_TP_AUTO"
    Then Third-party with name "ORIGINAL_TP_AUTO" is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "PENDING REVIEW"
    When User searches third-party with name "CONVERTED_TP"
    Then Third-party with name "CONVERTED_TP" is displayed in Third-party overview table
    When User clicks on third-party "CONVERTED_TP"
    Then Third-party Information tab is loaded
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks delete button for Associated Party "ORIGINAL_TP_AUTO"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    When User navigates to Third-party page
    And User searches third-party with name "ORIGINAL_TP_AUTO"
    Then Third-party with name "ORIGINAL_TP_AUTO" is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "NO RESULTS"
    When User searches third-party with name "CONVERTED_TP"
    Then Third-party with name "CONVERTED_TP" is displayed in Third-party overview table
    When User clicks 'Delete' button on third-party name "CONVERTED_TP"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared