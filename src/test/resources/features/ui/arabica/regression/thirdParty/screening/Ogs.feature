@ui @core_regression @arabica

Feature: Third-party - Screening Result - Ongoing Screening

  As a RDDC user
  I want an ability to monitor OGS for supplier.
  So that I can be informed of any relevant new data or data updates.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "Bank of China"

  @C39516058
  Scenario: C39516058: Third-party - Verify OGS button should enable when have 'Ongoing Screening' permission
    When Screening results table is loaded
    Then Label toggle is displayed as "World-Check & Custom WatchList Ongoing Screening"
    And OGS slider is turned OFF
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    Then Add Comment modal is displayed
    When User fills in comment "OGS button should enable when there is a POSITIVE/POSSIBLE record"
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And OGS slider is turned ON

  @C39516059
  Scenario: C39516059: Third-party -  Verify OGS button should enable when there is a POSITIVE/POSSIBLE record
    When Screening results table is loaded
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    Then Add Comment modal is displayed
    When User fills in comment "OGS button should enable when there is a POSITIVE/POSSIBLE record"
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And OGS slider is turned ON
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "FALSE" resolution
    Then Add Comment modal is displayed
    When User fills in comment "OGS button should enable when there is a POSITIVE/POSSIBLE record"
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening results table is loaded
    And OGS slider is turned OFF
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    Then Add Comment modal is displayed
    When User fills in comment "OGS button should enable when there is a POSITIVE/POSSIBLE record"
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    And OGS slider is turned ON