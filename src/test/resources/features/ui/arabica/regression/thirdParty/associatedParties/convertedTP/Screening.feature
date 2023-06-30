@ui @full_regression @arabica

Feature: associatedOrganization - Auto-screen switch

  As an RDDC user.
  I want to retain auto-screen for an associated organisation which will be converted to become a third party.
  So that I can keep monitor on the screening results of the associated organisation even when it becomes a third party.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API

  @C50666209
  @onlySingleThread
  Scenario: C50666209: Associated Organisation - Verify Once a third party is converted. The converted third party is still with auto-screen and its screening results/data are retained.
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And "Screening Management" position is under Due Diligence Order Management
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    And Screening Settings "Enable screening when adding new associated party" is turned "Off"
    When User clicks on Enable screening when adding new associated party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new associated party" is turned "On"
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
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    Then "Screening Criteria" section for add third-party is displayed between "Contact" and "Description" sections
    When User submits Third-party creation form
    Then Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Search Term" is
      | Apple |
    And Search criteria value of "Country of Registration" is
      | Afghanistan |

  @C50666210
  @onlySingleThread
  Scenario: C50666210: Associated Organisation - Verify Once a third party is converted. The converted third party is still without auto-screen and ongoing screening
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And "Screening Management" position is under Due Diligence Order Management
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    And Screening Settings "Enable screening when adding new associated party" is turned "Off"
    And Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "Off"
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
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    Then "Contact" section for add third-party is displayed between "Address" and "Description" sections
    When User submits Third-party creation form
    Then Screening results table is loaded
    And Enable screening button is displayed
    And OGS Toggle is disable
    When User navigates to Third-party page
    And User searches third-party with name "Apple"
    Then Third-party with name "Apple" is displayed in Third-party overview table
    When User clicks 'Delete' button on third-party name "Apple"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared

  @C50666211
  @onlySingleThread
  Scenario: C50666211: Associated Organisation - Verify The converted third party is with auto-screen based on the searching criteria a user selects and ongoing screening check box is ticked or not based on 'Enable World-Check and Custom Watchlist Ongoing Screening'
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And "Screening Management" position is under Due Diligence Order Management
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    And Screening Settings "Enable screening when adding new associated party" is turned "Off"
    And Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "Off"
    When User clicks on Enable World-Check and Custom Watchlist Ongoing Screening toggle
    And User clicks save button
    Then Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "On"
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
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    Then "Screening Criteria" section for add third-party is displayed between "Contact" and "Description" sections
    And Add Third-party Search criteria Ongoing Screening World-check checkbox is checked
    When User submits Third-party creation form
    Then Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Search Term" is
      | Apple |
    And Search criteria value of "Country of Registration" is
      | Afghanistan |
    When User clicks Cancel search criteria button
    Then OGS slider is turned ON
    When User navigates to Third-party page
    And User searches third-party with name "Bank of China"
    Then Third-party with name "Bank of China" is displayed in Third-party overview table
    When User clicks 'Delete' button on third-party name "Bank of China"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    When User searches third-party with name "Apple"
    Then Third-party with name "Apple" is displayed in Third-party overview table
    When User clicks 'Delete' button on third-party name "Apple"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And "Screening Management" position is under Due Diligence Order Management
    And Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "On"
    When User clicks on Enable World-Check and Custom Watchlist Ongoing Screening toggle
    And User clicks save button
    Then Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "Off"
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
    When User clicks Convert to third-party button
    Then CONVERT TO THIRD PARTY modal is displayed
    When User clicks "proceed" on Convert to third-party modal
    Then "Screening Criteria" section for add third-party is displayed between "Contact" and "Description" sections
    And Add Third-party Search criteria Ongoing Screening World-check checkbox is unchecked
    When User submits Third-party creation form
    Then Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Search Term" is
      | Apple |
    And Search criteria value of "Country of Registration" is
      | Afghanistan |
    When User clicks Cancel search criteria button
    Then OGS slider is turned OFF
    When User navigates to Third-party page
    And User searches third-party with name "Apple"
    Then Third-party with name "Apple" is displayed in Third-party overview table
    When User clicks 'Delete' button on third-party name "Apple"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared