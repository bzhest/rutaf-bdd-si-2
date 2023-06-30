@ui @core_regression @arabica

Feature: Associated Individual - Screening Result - Ongoing Screening

  As a RDDC user
  I want an ability to monitor OGS for Associated Individual.
  So that I can be informed of any relevant new data or data updates.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"
    And User creates Associated Party "John SMITH"
    And Screening results table is loaded

  @C39520430
  Scenario: C39520430: Associated Individual -  Verify toast message is displayed when OGS button turn ON/OFF
    When Label toggle is displayed as "World-Check & Custom WatchList Ongoing Screening"
    Then OGS slider is turned OFF
    When User clicks OGS slider to ON
    Then OGS slider is turned ON
    And OGS alert message "Success! Ongoing screening is turned on." is displayed
    When User clicks OGS slider to OFF
    Then OGS slider is turned OFF
    And OGS alert message "Success! Ongoing screening is turned off." is displayed

  @C39520432
  Scenario: C39520432: Associated Individual -  Verify OGS button should enable when there is a POSITIVE/POSSIBLE record
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    Then Add Comment modal is displayed
    When User fills in comment "OGS button should enable when there is a POSITIVE/POSSIBLE record"
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And OGS slider is turned ON
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "FALSE" resolution
    Then Add Comment modal is displayed
    And User fills in comment "OGS button should enable when there is a POSITIVE/POSSIBLE record"
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening results table is loaded
    And OGS slider is turned OFF
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    Then Add Comment modal is displayed
    And User fills in comment "OGS button should enable when there is a POSITIVE/POSSIBLE record"
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    And OGS slider is turned ON

  @C39514954 @C39514955
  Scenario: C39514954 C39514955: Associated Individual - Screening - Verify OGS Toggle Label
    When User clicks WORLD-CHECK tab and "CUSTOM WATCHLIST" tab is appeared
    Then Label toggle is displayed as "World-Check & Custom WatchList Ongoing Screening"
    When User clicks CUSTOM WATCHLIST tab at Screening section
    Then Label toggle is displayed as "World-Check & Custom WatchList Ongoing Screening"
    When User clicks Media Check tab on Screening section
    Then MEDIA CHECK page is hidden OGS Toggle "World-Check & Custom WatchList Ongoing Screening" for Screening section