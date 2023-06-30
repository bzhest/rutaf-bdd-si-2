@ui @associated_parties @alamid

Feature: Edit Associated Organisation page

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Screening Management' section
    And User clicks on Enable screening when adding new associated party toggle
    And User creates third-party "with random ID name"
    And User clicks on "Associated Parties" tab on Third-party page

  @C45505846
  @full_regression
  Scenario: C45505846: Associated Organisation Information - Update Name or Country - Send Groups to WorldCheck
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "Samsung"
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks Save Associated Organisation button
    And User clicks Duplicate Check Confirm button
    Then Screening results table is loaded
    When User clicks Associated Party's General Information section "Edit" button
    And User updates General Information section with values
      | Name  |
      | Apple |
    And User clicks Associated Party's General Information section "Save" button
    And User clicks Duplicate Check Confirm button
    Then Screening results table is loaded
    When User clicks Associated Party's General Information section "Edit" button
    And User expands "Address" section
    And User updates Associated Party's Contact section with values
      | Country   |
      | Australia |
    And User clicks Associated Party's General Information section "Save" button
    Then Screening results table is loaded