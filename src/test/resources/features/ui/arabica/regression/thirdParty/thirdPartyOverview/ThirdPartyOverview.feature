@ui @arabica

Feature: Third-party Overview - Screening Status (WC and Custom WL)

  As an RDDC user
  I want to include the status, 'Not Screened' as a value of 'Screening Status (WC and Custom WL)' in the page, 'Third Party Overview'
  So that the screening status is shown accurately with precise status.

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API

  @C49167683
  @core_regression
  @onlySingleThread
  Scenario: C49167683: Third-party Overview -  the value of Screening Status (WC and Custom WL) = 'Not Screened' after Third-party is created
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User creates third-party "with random ID name"
    And User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "NOT SCREENED"

  @C49167700
  @full_regression
  @onlySingleThread
  Scenario: C49167700: Third-party Overview -  the value of Screening Status (WC and Custom WL) =  'Not Screened' after Third-party and other names  are  created
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User creates third-party "with random ID name"
    And User creates Other name "3M"
    And User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "NOT SCREENED"

  @C49167748
  @core_regression
  @onlySingleThread
  Scenario: C49167748: Third-party Overview -  the value of Screening Status (WC and Custom WL) = Existing status after Third-party is created and enable screening
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User creates third-party "with random ID name"
    And User creates Other name "3M"
    And User clicks Enable screening button
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    When User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "NO RESULTS"

  @C49167954
  @core_regression
  @onlySingleThread
  Scenario: C49167954:Third-party Overview -  the value of Screening Status (WC and Custom WL) =  'Not Screened' after Third-party and associated individual are  created
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User creates third-party "with random ID name"
    And User creates Associated Party "with mandatory fields auto screen off"
    And User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "NOT SCREENED"

  @C49168093
  @core_regression
  @onlySingleThread
  Scenario: C49168093:Third-party Overview -  the value of Screening Status (WC and Custom WL) =  'Not Screened' after Third-party and associated organisation are  created
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User creates third-party "with random ID name"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User populates Name field with value "Apple"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "NOT SCREENED"

  @C49168159
  @full_regression
  @onlySingleThread
  Scenario: C49168159:Third-party Overview -  the value of Screening Status (WC and Custom WL) =  'Not Screened' after Third-party ,third-party other names  and associated individual are created
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User creates third-party "with random ID name"
    And User creates Other name "3M"
    And User creates Associated Party "with mandatory fields auto screen off"
    And User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "NOT SCREENED"

  @C49168177
  @full_regression
  @onlySingleThread
  Scenario: C49168177:Third-party Overview -  the value of Screening Status (WC and Custom WL) =  'Not Screened' after Third-party ,third-party other names  , associated individual and associated individual  other names are created
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User creates third-party "with random ID name"
    And User creates Other name "3M"
    And User creates Associated Party "with mandatory fields auto screen off"
    And User creates Other name "Donald Trump for Associated Individual" for Associated Party
    And User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "NOT SCREENED"

  @C49168179
  @full_regression
  @onlySingleThread
  Scenario: C49168179:Third-party Overview -  the value of Screening Status (WC and Custom WL) =  'Not Screened' after Third-party ,third-party other names  ,associated organisation and associated organisation other names are created
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User creates third-party "with random ID name"
    And User creates Other name "3M"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User populates Name field with value "Apple"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks Save Associated Organisation button
    And User fills in Name field value "Apple"
    And User selects Name type "Former Name"
    And User clicks on "Other Names Add|Save button"
    Then Other name "Apple" is created
    When User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "NOT SCREENED"

  @C49168183
  @full_regression
  @onlySingleThread
  Scenario: C49168183:Third-party Overview -  the value of Screening Status (WC and Custom WL) =  'Not Screened' after Third-party ,associated organisation and associated individual are created
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User creates third-party "with random ID name"
    And User creates Other name "3M"
    And User creates Associated Party "with mandatory fields auto screen off"
    And User creates Other name "Donald Trump for Associated Individual" for Associated Party
    And User clicks Associated Party Overview contact button
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User populates Name field with value "Apple"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks Save Associated Organisation button
    And User fills in Name field value "Apple"
    And User selects Name type "Former Name"
    And User clicks on "Other Names Add|Save button"
    Then Other name "Apple" is created
    When User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "NOT SCREENED"

  @C49168189
  @core_regression
  @onlySingleThread
  Scenario: C49168189:Third-party Overview -  the value of Screening Status (WC and Custom WL) =  'Existing status' after Third-party ,associated organisation and associated individual are created
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User creates third-party "with random ID name"
    And User creates Other name "3M"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User populates Name field with value "Apple"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks Save Associated Organisation button
    And User fills in Name field value "Apple"
    And User selects Name type "Former Name"
    And User clicks on "Other Names Add|Save button"
    Then Other name "Apple" is created
    When User clicks Associated Party Overview contact button
    And User creates Associated Party "with mandatory fields auto screen off"
    And User creates Other name "Donald Trump for Associated Individual" for Associated Party
    And User clicks Enable screening button
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    When User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "NO RESULTS"

  @C49177482
  @core_regression
  @onlySingleThread
  Scenario: C49177482:Third-party Overview -  the value of Screening Status (WC and Custom WL) =  'Not Screened' after Third-party and create associated individual from ETEP questionnaire
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User navigates to Questionnaire Management page
    And User searches questionnaire "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    And User clicks edit questionnaire with name "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    Then Add Questionnaire setup page displayed
    When User selects "Active" questionnaire status
    And User selects in Question Assignee Type "Internal"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Success!                       |
      | Questionnaire has been updated |
    When User creates third-party "with random ID name"
    And User creates Other name "3M"
    And User clicks on Questionnaire tab
    Then Questionnaire tab is loaded
    When User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User refreshes page
    And User clicks Notification Bell
    Then "Questionnaire has been Assigned" notification displayed with text
      | Internal Questionnaire for |
      | thirdPartyName             |
    When User clicks "Questionnaire has been Assigned" "Internal Questionnaire for thirdPartyName" notification
    And User for questionnaire "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS" clicks link "Answer"
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "enhancedText" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS" status should be "Submitted"
    When User refreshes page
    And User clicks Notification Bell
    And User clicks "Questionnaire to Review" "Internal Questionnaire for thirdPartyName" notification
    Then Activity Information page is displayed
    When User clicks review questionnaires
    Then Questionnaire details page is displayed
    When User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    When User clicks on "Associated Parties" tab on Third-party page
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name      | Last Name      | Country | Status   |
      | false         |       | Auto First Name | Auto Last Name |         | Inactive |
    And User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    And Third-party should have status "NEW"
    And Third-party should have Screening Status "NOT SCREENED"
    When User navigates to Questionnaire Management page
    And User searches questionnaire "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    And User clicks edit questionnaire with name "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    Then Add Questionnaire setup page displayed
    When User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Success!                       |
      | Questionnaire has been updated |

  @C37454614 @C37454502
  @full_regression
  Scenario: C37454614, C37454502: Third-party Overview - change label to Screening Status (WC & Custom WL) by using ellipses and display tooltip
    When User navigates to Third-party page
    Then Third-party Overview tab is loaded
    And Third-party Table Column "Screening Status (WC & Custom WL)" is displayed
    And User should be able to see new label "SCREENING STATUS (WC & CUSTOM WL)" of Screening Status as "Screening Status (WC & Custom WL)" "Unresolved" in AdvanceSearch