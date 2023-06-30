@ui @associated_parties @alamid

Feature: Associated Organisation Screening Section page

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Screening Management' section
    And User clicks on Enable screening when adding new associated party toggle
    And User creates third-party "with random ID name"
    And User clicks on "Associated Parties" tab on Third-party page

  @C45530501
  @core_regression
  Scenario: C45530501: Associated Organisation Information - Change Search Criteria - Auto Screen ON - Groups field is displayed and disabled
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "Apple"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User selects a Associated Organisation Screening Group 2
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Groups" is
      | PEP Only |
    And Search criteria "Groups" is not blank
    And Groups field is disabled

  @C45532010 @C45531019
  @core_regression
  Scenario: C45532010, C45531019: Associated Organisation Information - Change Search Criteria - Auto Screen OFF - Groups field is displayed and enabled
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to OFF
    And User populates Name field with value "Apple"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User clicks Enable screening button
    Then Search criteria "Groups" is not blank
    And Search criteria value of "Groups" is
      | All |
    When User selects a Screening Group 3 from Search Criteria
    And User hovers to Screening Groups field in Search Criteria
    Then Screening Groups tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" in Search Criteria is displayed
    When User selects a Screening Group 1 from Search Criteria
    And User selects a Screening Group 2 from Search Criteria
    And User clicks Cancel search criteria button
    Then Search Criteria modal is disappeared

  @C45505848
  @full_regression
  Scenario: C45505848: Associated Organisation Information - Change Search Criteria- AutoScreen=OFF - Send Groups to WorldCheck
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to OFF
    And User populates Name field with value "Samsung"
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks Save Associated Organisation button
    And User clicks Enable screening button
    And User selects a Screening Group 2 from Search Criteria
    And User clicks on Check Type "Custom WatchList"
    And User clicks on Check Type "Media Check"
    And User changes Country of Registration value to "United States"
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    And "WORLD-CHECK" tab is displayed
    When User clicks on "CUSTOM WATCHLIST" tab
    Then "CUSTOM WATCHLIST" tab is displayed
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed

  @C45505847
  @full_regression
  Scenario: C45505847: Associated Organisation Information - Change Search Criteria- AutoScreen=ON - Send Groups to WorldCheck
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "Samsung"
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    When User clicks Change Search Criteria screening button
    And User changes Search Term to "Apple"
    And User changes Country of Registration value to "United States"
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    And "WORLD-CHECK" tab is displayed
    When User clicks on "CUSTOM WATCHLIST" tab
    Then "CUSTOM WATCHLIST" tab is displayed
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
