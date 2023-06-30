@ui @suppliers @alamid @full_regression

Feature: Third-party Screening section

  As a user
  I want to add third-party with Screening Criteria
  So that I can see the third-party with different screening results

  Background:
    Given User logs into RDDC as "Admin"
    When User opens third-party creation form

  @C44910922
  Scenario: C44910922: Third-party - Change Search Criteria - Groups field is disabled
    When User fills third-party creation form with third-party's test data "Paris"
    And User expands the add third-party screening criteria accordion if it is collapsed
    And User selects other group 2
    And User submits Third-party creation form
    Then Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Groups" is
      | PEP Only |
    And Search criteria "Groups" is not blank
    And Groups field is disabled

  @C44961212
  Scenario: C44961212: Third-party - Change Search Criteria- Send WC Groups to WC
    When User fills third-party creation form with third-party's test data "Paris"
    And User expands the add third-party screening criteria accordion if it is collapsed
    And User selects other group 2
    And User submits Third-party creation form
    Then Screening results table is loaded
    When User clicks Change Search Criteria screening button
    And User changes Search Term to "Japan"
    And User changes Country of Registration value to "France"
    And User clicks Search On Search criteria button
    Then Screening results table is loaded