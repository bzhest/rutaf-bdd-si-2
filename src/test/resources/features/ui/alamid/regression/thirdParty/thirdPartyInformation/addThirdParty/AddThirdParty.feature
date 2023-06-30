@ui @suppliers @alamid @full_regression

Feature: Add Third-party Screening Criteria section

  As a user
  I want to add third-party with Screening Criteria
  So that I can see the third-party with different screening results

  Background:
    Given User logs into RDDC as "Admin"
    When User opens third-party creation form

  @C44804099 @C44795692 @core_regression
  Scenario: C44804099, C44795692: Add Third-party - Screening Criteria - Create third-party with selected Groups
    When User fills third-party creation form with third-party's test data "Paris"
    And User expands the add third-party screening criteria accordion if it is collapsed
    And Groups field is displayed in Screening Criteria with default value "All"
    And User hovers to groups dropdown 3
    Then Groups dropdown tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed
    And User selects other group 3
    And User hovers to Groups field
    Then Groups tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed
    When User selects other group 2
    And User submits Third-party creation form
    Then Screening results table is loaded
