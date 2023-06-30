@ui @suppliers @alamid @full_regression

Feature:  Edit Associated Individual

  @C44963030
  Scenario: C44963030: Edit Associate Individual - Update First and Last Name - Send Groups to WorldCheck
    Given User logs into RDDC as "Admin"
    When User creates third-party "Samsung"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User enters Associated Party first name with value "John"
    And User enters Associated Party last name with value "Smith"
    And User clicks Auto-screen button to ON
    And User selects a Screening Group 2
    And User clicks on Save Associated Party button
    Then Screening results table is loaded
    When User clicks Associated Party's General Information section "Edit" button
    And User updates Associated Party's General Information section with values
      | First Name | Last Name |
      | Jane       | Miller    |
    And User clicks Associated Party's General Information section "Save" button
    Then Screening results table is loaded
    And "WORLD-CHECK" tab is displayed
    And "CUSTOM WATCHLIST" tab is displayed
    And "MEDIA CHECK" tab is displayed