@ui @associated_parties @alamid

Feature: Associated Organisation page

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Screening Management' section
    And User clicks on Enable screening when adding new associated party toggle
    And User creates third-party "with random ID name"
    And User clicks on "Associated Parties" tab on Third-party page

  @C45484146
  @core_regression
  Scenario: C45484146: Add Associated Organisation - Screening Criteria - Create Associated Organisation with selected Groups
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "Apple"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    Then Associated Organisation Groups field value in Screening Criteria is default to "All"
    When User selects a Associated Organisation Screening Group 1
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded

  @C45484147
  @full_regression
  Scenario: C45484147: Add Associated Organisation - Screening Criteria - Groups field - Tooltip displayed when hovered for selected Group Name that doesn't fit in the field
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "Apple"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    Then Associated Organisation Groups field value in Screening Criteria is default to "All"
    When User hovers to Associated Organisation groups dropdown 3
    Then Screening Groups dropdown tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed
    When User selects a Associated Organisation Screening Group 3
    And User hovers to Associated Organisation Groups field
    Then Associated Organisation Screening Groups tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed

  @C45504241
  @core_regression
  Scenario: C45504241: Add Associated Organisation - Screening - Send WC Groups to WC
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "Apple"
    And User clicks on "Address" collapse button
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    Then Associated Organisation Groups field value in Screening Criteria is default to "All"
    When User selects a Associated Organisation Screening Group 1
    And User clicks Save Associated Organisation button
    Then Screening results table is loaded
    And "WORLD-CHECK" tab is displayed
    When User clicks on "CUSTOM WATCHLIST" tab
    Then "CUSTOM WATCHLIST" tab is displayed
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
