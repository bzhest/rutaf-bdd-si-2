@ui @full_regression @core_regression @screening_management @arabica

Feature: Screening Management

  As an RDDC user who has a permission for 'Set Up'
  I want to have a new vertical tab, 'Screening Management' and new switches inside the tab, 'Screening Management' under 'Set Up' page.
  So that I can access set configurations regarding to auto-screening and ongoing screening.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API

  @C46320076
  @onlySingleThread
  Scenario: C46320076: Setup - Screening management - Verify user is able to see 'Screening Management' at the left vertical tab with default value
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And "Screening Management" position is under Due Diligence Order Management
    And Screening Settings "Enable screening when adding new associated party" is turned "Off"
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    And Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "Off"

  @C46406229
  @onlySingleThread
  Scenario: C46406229: Setup - Screening management - Verify Enable screening when adding new associated party  can be set ON/OFF and independently to others
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new associated party" is turned "Off"
    And Cancel button is "enabled"
    And Save button is "disabled"
    When User clicks on Enable screening when adding new associated party toggle
    Then Cancel button is "enabled"
    And Save button is "enabled"
    When User clicks cancel button
    Then Screening Settings "Enable screening when adding new associated party" is turned "Off"
    And Cancel button is "enabled"
    And Save button is "disabled"
    When User clicks on Enable screening when adding new associated party toggle
    Then Cancel button is "enabled"
    And Save button is "enabled"
    When User clicks save button
    Then Alert message "Success! Screening Management setting has been updated" is displayed
    And Screening Settings "Enable screening when adding new associated party" is turned "On"
    When User clicks on Enable screening when adding new associated party toggle
    And User clicks save button
    Then Alert message "Success! Screening Management setting has been updated" is displayed

  @C46406228
  @onlySingleThread
  Scenario: C46406228: Setup - Screening management - Verify Enable screening when adding new third-party can be set ON/OFF and independently to others
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    And Cancel button is "enabled"
    And Save button is "disabled"
    When User clicks on Enable screening when adding new third-party toggle
    Then Cancel button is "enabled"
    And Save button is "enabled"
    When User clicks cancel button
    Then Screening Settings "Enable screening when adding new third-party" is turned "On"
    And Cancel button is "enabled"
    And Save button is "disabled"
    When User clicks on Enable screening when adding new third-party toggle
    Then Cancel button is "enabled"
    And Save button is "enabled"
    When User clicks save button
    Then Alert message "Success! Screening Management setting has been updated" is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Alert message "Success! Screening Management setting has been updated" is displayed

  @C46406230
  @onlySingleThread
  Scenario: C46406230: Setup - Screening management - Verify Enable World-Check and Custom Watchlist Ongoing Screening can be set ON/OFF and independently to others
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "Off"
    And Cancel button is "enabled"
    And Save button is "disabled"
    When User clicks on Enable World-Check and Custom Watchlist Ongoing Screening toggle
    Then Cancel button is "enabled"
    And Save button is "enabled"
    When User clicks cancel button
    Then Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "Off"
    And Cancel button is "enabled"
    And Save button is "disabled"
    When User clicks on Enable World-Check and Custom Watchlist Ongoing Screening toggle
    Then Cancel button is "enabled"
    And Save button is "enabled"
    When User clicks save button
    Then Alert message "Success! Screening Management setting has been updated" is displayed
    And Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "On"
    When User clicks on Enable World-Check and Custom Watchlist Ongoing Screening toggle
    And User clicks save button
    Then Alert message "Success! Screening Management setting has been updated" is displayed
    And Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "Off"

  @C47116849
  @onlySingleThread
  Scenario: C47116849: Screening management  -  Verify In screening section of an Associated individual, the ongoing screening check box will be ticked or not depending on the switch, 'Enable World-Check and Custom Watchlist Ongoing Screening' is OFF
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    And Screening Settings "Enable screening when adding new associated party" is turned "Off"
    And Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "Off"
    When User creates third-party "Bank of China"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And  User clicks Auto-screen button to ON
    And User enters Associated Party first name with value "Joe"
    And User enters Associated Party last name with value "Biden"
    Then Contact's Ongoing Screening "World-Check" is unchecked
    When User clicks on Save Associated Party button
    Then Screening results table is loaded
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And OGS slider is turned OFF
    When User fills in Name field value "Joe Biden"
    And User selects Name type "Also Known As"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    And Associated Party Other Names Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And World-Check & Custom WatchList Ongoing Screening toggle is turned Off

  @C53363852
  @onlySingleThread
  Scenario: C53363852: Screening management  -  Verify In screening section of Associated Organisation, the ongoing screening check box will be ticked or not depending on the switch, 'Enable World-Check and Custom Watchlist Ongoing Screening' is OFF
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    And Screening Settings "Enable screening when adding new associated party" is turned "Off"
    And Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "Off"
    When User creates third-party "Bank of China"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And  User clicks Auto-screen button to ON
    And User populates Name field with value "Apple"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    Then Contact's Ongoing Screening "World-Check" is unchecked
    When User clicks Save Associated Organisation button
    Then Screening results table is loaded
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And OGS slider is turned OFF
    When User fills in Name field value "Apple"
    And User selects Name type "Other Name"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    And Associated Party Other Names Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And World-Check & Custom WatchList Ongoing Screening toggle is turned Off

  @C46320786
  @onlySingleThread
  Scenario: C46320786: Screening management - Verify Enable screening when adding new third-party turn OFF
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User opens third-party creation form
    And User fills third-party creation form with third-party's test data "with defined name"
    Then "Contact" section for add third-party is displayed between "Address" and "Description" sections
    When User submits Third-party creation form
    Then Screening results table is loaded
    And No Available Data on "WORLD-CHECK" tab is displayed
    And OGS Toggle is disable
    And Enable screening button is displayed
    When User creates Other name "TOT"
    And User opens screening results for "TOT" Other name
    Then Other Name dialog is loaded
    When User clicks on "WORLD-CHECK" other name screening tab
    Then "WORLD-CHECK" other name tab is selected
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |
    And OGS Toggle Other Name is disable

  @C46604662
  @onlySingleThread
  Scenario: C46604662: Screening management - Verify Enable screening when adding new third-party turn ON
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User opens third-party creation form
    And User fills third-party creation form with third-party's test data "with defined name"
    Then "Screening Criteria" section for add third-party is displayed between "Contact" and "Description" sections
    And User expands the add third-party screening criteria accordion if it is collapsed
    And Search Term Value on Screening Criteria section is pre-populated with third-party's Name from test data "with defined name"
    And Country of Registration Value on Screening Criteria section is pre-populated with Country from test data "with defined name"
    When User submits Third-party creation form
    Then Screening results table is loaded
    And No Available Data on "WORLD-CHECK" tab is displayed
    And OGS slider is turned OFF
    And Screening section Change Search Criteria button is displayed
    When User creates Other name "TOT"
    And User opens screening results for "TOT" Other name
    Then Other Name dialog is loaded
    And User turns On Other Names OGS slider

  @C47116044
  @onlySingleThread
  Scenario: C47116044: Screening management  -  Verify A new third party or associated party will be with auto-screen and ongoing screening
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    And Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "Off"
    When User clicks on Enable World-Check and Custom Watchlist Ongoing Screening toggle
    And User clicks save button
    Then Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "On"
    When User opens third-party creation form
    And User fills third-party creation form with third-party's test data "with defined name"
    Then "Screening Criteria" section for add third-party is displayed between "Contact" and "Description" sections
    When User expands the add third-party screening criteria accordion if it is collapsed
    Then Search Term Value on Screening Criteria section is pre-populated with third-party's Name from test data "with defined name"
    And Country of Registration Value on Screening Criteria section is pre-populated with Country from test data "with defined name"
    And Ongoing Screening "World-Check" is checked
    When User submits Third-party creation form
    Then Screening results table is loaded
    And No Available Data on "WORLD-CHECK" tab is displayed
    And OGS slider is turned ON
    And Screening section Change Search Criteria button is displayed
    When User creates Other name "TOT"
    And User opens screening results for "TOT" Other name
    Then Other Name dialog is loaded
    And OGS Other Name is turned ON

  @C47116359
  @onlySingleThread
  Scenario: C47116359: Screening management  -  Verify A new third party or associated party will be with auto-screen but no ongoing screening
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    And Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "Off"
    When User opens third-party creation form
    And User fills third-party creation form with third-party's test data "with defined name"
    Then "Screening Criteria" section for add third-party is displayed between "Contact" and "Description" sections
    When User expands the add third-party screening criteria accordion if it is collapsed
    Then Search Term Value on Screening Criteria section is pre-populated with third-party's Name from test data "with defined name"
    And Country of Registration Value on Screening Criteria section is pre-populated with Country from test data "with defined name"
    And Ongoing Screening "World-Check" is unchecked
    When User submits Third-party creation form
    Then Screening results table is loaded
    And No Available Data on "WORLD-CHECK" tab is displayed
    And OGS slider is turned OFF
    And Screening section Change Search Criteria button is displayed
    When User creates Other name "TOT"
    And User opens screening results for "TOT" Other name
    Then Other Name dialog is loaded
    And OGS Other Name is turned OFF