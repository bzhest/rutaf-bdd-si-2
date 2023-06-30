@ui @core_regression @arabica

Feature: Associated Individual Other Names - Screening Result - Ongoing Screening

  As a RDDC user
  I want an ability to monitor OGS for Associated Individual.
  So that I can be informed of any relevant new data or data updates.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"
    And User creates Associated Party "with mandatory fields"

  @C37454853
  Scenario: C37454853: Associated Individual - Other Name - Verify OGS Toggle label
    When User creates Other name "contact other name" for Associated Party
    And User clicks on "WORLD-CHECK" other name screening tab
    Then Other Name OGS Toggle Label should display as "World-Check & Custom WatchList Ongoing Screening"
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name OGS Toggle Label should display as "World-Check & Custom WatchList Ongoing Screening"
    When User clicks on "MEDIA CHECK" other name screening tab
    Then MEDIA CHECK page is hidden OGS Toggle for Other Name section

  @C39520365
  Scenario: C39520365: Associated Individual Other Names - Verify that user with Ongoing Screening role permission can turn on/off OGS toggle
    When User creates Other name "contact other name" for Associated Party
    Then Other Name dialog is loaded
    And Other Name OGS Toggle Label should display as "World-Check & Custom WatchList Ongoing Screening"
    And World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    When User clicks Other Names OGS slider
    Then World-Check & Custom WatchList Ongoing Screening toggle is turned On
    And OGS alert message "Success! Ongoing screening is turned on." is displayed
    When User clicks Other Names OGS slider
    Then World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    And OGS alert message "Success! Ongoing screening is turned off." is displayed

  @C39520367
  Scenario: C39520367: Associated Individual Other Names -  Verify if there is a positive/possible record, The OGS should be automatically turn on and  record moved to the main screening
    When User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    And  World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    And World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 1 does not appear in the other name screening table
    And World-Check & Custom WatchList Ongoing Screening toggle is turned On
    When User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution