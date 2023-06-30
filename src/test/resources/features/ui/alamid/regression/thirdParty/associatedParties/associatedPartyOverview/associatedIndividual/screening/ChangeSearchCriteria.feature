@ui @suppliers @alamid @full_regression

Feature: Associated Individual Screening section

  Background:
    Given User logs into RDDC as "ADMIN"
    When User navigates 'Set Up' block 'Screening Management' section
    And User clicks on Enable screening when adding new associated party toggle
    And User creates third-party "Samsung"
    And User clicks on "Associated Parties" tab on Third-party page

  @C44902023
  Scenario: C44902023: Add Associated Individual - Auto Screening is ON - Send Groups to WorldCheck
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User enters Associated Party first name with value "John"
    And User enters Associated Party last name with value "Smith"
    And User clicks Auto-screen button to ON
    And User selects a Screening Group 2
    And User clicks on Save Associated Party button
    Then Screening results table is loaded
    And "WORLD-CHECK" tab is displayed
    And "CUSTOM WATCHLIST" tab is displayed
    And "MEDIA CHECK" tab is displayed

  @C44732149
  Scenario: C44732149: Add Associated Individual Page - Screening Criteria - Add Associated Individual with Groups
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User enters Associated Party first name with value "John"
    And User enters Associated Party last name with value "Smith"
    And User clicks Auto-screen button to ON
    Then Groups field value in Screening Criteria is default to "All"
    When User selects a Screening Group 3
    And User hovers to Screening Groups field
    Then Screening Groups tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed

  @C44809205
  Scenario: C44809205: Associated Individual - Auto-Screen=ON - Change Search Criteria
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User enters Associated Party first name with value "John"
    And User enters Associated Party last name with value "Smith"
    And User clicks Auto-screen button to ON
    And User selects a Screening Group 2
    And User clicks on Save Associated Party button
    And User clicks Change Search Criteria screening button
    Then Screening Groups field contains "PEP Only"
    And Groups field is disabled

  @C44809206
  Scenario: C44809206: Associated Individual - Auto-Screen=OFF - Change Search Criteria
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User enters Associated Party first name with value "John"
    And User enters Associated Party last name with value "Smith"
    And User clicks Auto-screen button to OFF
    And User clicks on Save Associated Party button
    And User clicks Enable screening button
    Then Groups field value in Search Criteria modal is default to "All"
    When User selects a Screening Group 3 from Search Criteria
    And User hovers to Screening Groups field in Search Criteria
    Then Screening Groups tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" in Search Criteria is displayed

  @C44933337
  Scenario: C44933337: Associate Individual - Change Search Criteria - Send Groups to WorldCheck after Auto-Screen = ON
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User enters Associated Party first name with value "John"
    And User enters Associated Party last name with value "Smith"
    And User clicks Auto-screen button to OFF
    And User clicks on Save Associated Party button
    And User clicks Enable screening button
    And User selects a Screening Group 2 from Search Criteria
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    And "WORLD-CHECK" tab is displayed
    And "CUSTOM WATCHLIST" tab is displayed
    And "MEDIA CHECK" tab is displayed

  @C44964904
  Scenario: C44964904: Associated Individual - Change Search Criteria - Verify if Groups are sent to WC when modifying search criteria
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User enters Associated Party first name with value "John"
    And User enters Associated Party last name with value "Smith"
    And User clicks Auto-screen button to ON
    And User selects a Screening Group 2
    And User clicks on Save Associated Party button
    Then Screening results table is loaded
    When User clicks Change Search Criteria screening button
    And User changes Search Term to "Jane Miller"
    And User selects Country of Location value to "Afghanistan"
    And User selects Place of Birth value to "Philippines"
    And User selects Citizenship value to "Canada"
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    And "WORLD-CHECK" tab is displayed
    And "CUSTOM WATCHLIST" tab is displayed
    And "MEDIA CHECK" tab is displayed