@ui @associated_parties @alamid @full_regression

Feature: Associated Organisation Other Name Screening section

  @C45521326
  Scenario: C45521326: Add Associated Organisation Other Names - Send WC Groups to WorldCheck
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Screening Management' section
    And User clicks on Enable screening when adding new associated party toggle
    And User creates third-party "with random ID name"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User clicks Auto-screen button to ON
    And User populates Name field with value "Samsung"
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks Save Associated Organisation button
    And User fills in Name field value "Apple"
    And User selects Name type "Former Name"
    And User selects other name group 2
    And User clicks on "Other Names Add|Save button"
    Then Other name "Apple" is created
    And Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded