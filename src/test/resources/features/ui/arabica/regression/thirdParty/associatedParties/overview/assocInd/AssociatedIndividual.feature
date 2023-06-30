@ui @full_regression @core_regression @screening_management @arabica

Feature: Screening Management

  As an RDDC user who can add a new associated party and enable screening
  I want to make the screening default configuration to apply with all new associated parties added from Associated Parties Tab.
  So that I can have options whether to apply auto-screen to a new associated party or not

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API

  @C46320787
  @onlySingleThread
  Scenario: C46320787: Setup - Screening management -  Associated individual - Verify Enable screening when adding new associated party turn OFF from default value = OFF
    When User navigates 'Set Up' block 'Screening Management' section
    Then Screening Settings "Enable screening when adding new associated party" is turned "Off"
    When User creates third-party "Bank of China"
    And User creates Associated Party "Joe Biden"
    Then Screening date has value "LAST SCREENING DATE:"
    And Screening result displays No available data
    And OGS Toggle is disable
    When User creates Other name "Joe Biden" for Associated Party
    And User opens screening results for Associated Party "Joe Biden" Other name
    Then Other Name dialog is loaded
    And Associated Party Other Names screening date has value "LAST SCREENING DATE:"
    And Associated Party Other Names screening result displays No available data
    And Associated Party Other Names OGS Toggle is disable

  @C46556308
  @onlySingleThread
  Scenario: C46556308: Setup - Screening management - Associated individual -  Verify Enable screening when adding new associated party turn  ON from default value = OFF
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
    And User enters Associated Party first name with value "Joe"
    And User enters Associated Party last name with value "Biden"
    And User clicks on Save Associated Party button
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
    Then Add Name mandatory text field is displayed
    When User fills in Name field value "Joe Biden"
    And User selects Name type "Also Known As"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    And Associated Party Other Names Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    When User clicks Other Names OGS slider
    Then World-Check & Custom WatchList Ongoing Screening toggle is turned On
    And OGS alert message "Success! Ongoing screening is turned on." is displayed