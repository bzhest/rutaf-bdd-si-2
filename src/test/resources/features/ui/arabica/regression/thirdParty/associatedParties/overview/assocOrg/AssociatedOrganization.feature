@ui @full_regression @core_regression @screening_management @arabica

Feature: Screening Management

  As an RDDC user who has a permission for 'Set Up'
  I want to have a new vertical tab, 'Screening Management' and new switches inside the tab, 'Screening Management' under 'Set Up' page.
  So that I can access set configurations regarding to auto-screening and ongoing screening.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API

  @C46556703
  @onlySingleThread
  Scenario: C46556703: Setup - Screening management -  Associated Organisation  - Verify Enable screening when adding new associated party turn ON from default value = OFF
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new associated party" is turned "Off"
    When User clicks on Enable screening when adding new associated party toggle
    And User clicks save button
    Then Alert message "Success! Screening Management setting has been updated" is displayed
    And Screening Settings "Enable screening when adding new associated party" is turned "On"
    When User creates third-party "Bank of China"
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
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    When User clicks OGS slider to ON
    Then Alert Icon is displayed with text
      | Success!                        |
      | Ongoing screening is turned on. |
    And OGS slider is turned ON
    When User clicks Change Search Criteria screening button
    Then Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    When  User clicks Cancel search criteria button
    When User fills in Name field value "Apple"
    And User selects Name type "Other Name"
    And User clicks on "Add button"
    Then Other name "Apple" is created
    Then Other Name dialog is loaded
    And Associated Party Other Names Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    When User clicks Other Names OGS slider
    Then World-Check & Custom WatchList Ongoing Screening toggle is turned On
    And OGS alert message "Success! Ongoing screening is turned on." is displayed

  @C46457844
  @onlySingleThread
  Scenario: C46457844: Setup - Screening management -  Associated Organisation  - Verify Enable screening when adding new associated party turn OFF from default value = OFF
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new associated party" is turned "Off"
    When User creates third-party "Bank of China"
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
    And Screening date has value "LAST SCREENING DATE:"
    And Screening result displays No available data
    And OGS Toggle is disable
    When User fills in Name field value "Bank of China"
    And User selects Name type "Other Name"
    And User clicks on "Add button"
    Then Other name "Bank of China" is created
    When User opens screening results for "Bank of China" Other name
    Then Other Name dialog is loaded
    And Associated Party Other Names screening date has value "LAST SCREENING DATE:"
    And Associated Party Other Names screening result displays No available data
    And Associated Party Other Names OGS Toggle is disable