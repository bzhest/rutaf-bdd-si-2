@ui @core_regression @arabica

Feature: Third-party Other Names - Screening Result - Ongoing Screening

  As a RDDC user
  I want an ability to monitor OGS for supplier.
  So that I can be informed of any relevant new data or data updates.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"

  @C36624224
  Scenario: C36624224: Third-party Other Names - Verify that user with Ongoing Screening role permission can turn on/off OGS toggle
    When User creates Other name "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH"
    And User opens screening results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" Other name
    Then Other Name dialog is loaded
    And Other Name OGS Toggle Label should display as "World-Check & Custom WatchList Ongoing Screening"
    And World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    When User clicks Other Names OGS slider
    Then World-Check & Custom WatchList Ongoing Screening toggle is turned On
    And OGS alert message "Success! Ongoing screening is turned on." is displayed
    When User clicks Other Names OGS slider
    Then World-Check & Custom WatchList Ongoing Screening toggle is turned Off
    And OGS alert message "Success! Ongoing screening is turned off." is displayed

  @C41763070
  Scenario: C41763070: Third-party Other Names -  Verify if there is a positive/possible record, The OGS should be automatically turn on and  record moved to the main screening
    When User creates Other name "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH"
    And User opens screening results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" Other name
    Then Other Name dialog is loaded
    And World-Check & Custom WatchList Ongoing Screening toggle is turned Off
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
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 1 does not appear in the other name screening table
    And World-Check & Custom WatchList Ongoing Screening toggle is turned On
    When User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution