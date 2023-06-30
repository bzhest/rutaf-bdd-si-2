@ui @associated_parties @alamid @full_regression

Feature: Associated Organisation Other Name Page

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Screening Management' section
    And User clicks on Enable screening when adding new associated party toggle
    And User creates third-party "with random ID name"
    And User clicks on "Associated Parties" tab on Third-party page

  @C45483985
  Scenario: C45483985: Add Associated Organisation Other Names - Group Field - Auto-Screen=ON
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "Samsung"
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks Save Associated Organisation button
    Then Associated Organisation Other Name Groups field value is default to "All"
    When User hovers to Other Name groups dropdown 3
    Then Other Name Group tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed
    When User selects other name group 3
    And User hovers to Other Name Group field
    Then Other Name Group tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed

  @C45483986
  Scenario: C45483986: Add Associated Organisation Other Names - Group Field - Auto-Screen=OFF
    When User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User populates Name field with value "Samsung"
    And User clicks Auto-screen button to OFF
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks Save Associated Organisation button
    Then Associated Organisation Other Name Groups field value is default to "All"
    When User hovers to Other Name groups dropdown 3
    Then Other Name Group tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed
    When User selects other name group 3
    And User hovers to Other Name Group field
    Then Other Name Group tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed
