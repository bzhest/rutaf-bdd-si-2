@ui @functional @associated_parties @alamid @qa-sprint2

Feature: Add Associated Organisation page

  @C49202543 @C49202862
  Scenario: C49202543, C49202862: Add Associated Organisation - SAVE - Verify pop up message for Duplicate Associated Organisation
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name"
    And User creates Associated Party "Organisation" "ABC" via API and open it
    And User clicks Associated Party Overview contact button
    And User clicks 'Add Associated Party' button on Associated Parties Overview
    And User clicks on Associated Organisation
    And User populates Name field with value "ABC"
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks on Save and New Associated Party button
    Then Duplicate Check modal is displayed with text
      | DUPLICATE CHECK                                                                |
      | This record may already exist. Please check the duplicates before you proceed. |
      | 1. ABC                                                                         |
    When User clicks the Duplicate Check modal hyperlink "ABC"
    Then Duplicate Associated Organisation "ABC" is displayed in new tab
    When User navigates back to RDDC page
    And User clicks Duplicate Check Cancel button
    Then Duplicate Check modal is closed
    When User clicks on Save and New Associated Party button
    Then Duplicate Check modal is displayed
    When User clicks Duplicate Check Confirm button
    Then Alert Icon is displayed with text
      | Success! New Associated Party has been saved. |
    And Associated Party page is loaded
    When User populates Name field with value "ABC"
    And User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    And User clicks on Save Associated Party button
    Then Duplicate Check modal is displayed with text
      | DUPLICATE CHECK                                                                |
      | This record may already exist. Please check the duplicates before you proceed. |
      | 1. ABC                                                                         |
    When User clicks the Duplicate Check modal hyperlink "ABC"
    Then Duplicate Associated Organisation "ABC" is displayed in new tab
    When User navigates back to RDDC page
    And User clicks Duplicate Check Cancel button
    Then Duplicate Check modal is closed
    When User clicks on Save Associated Party button
    Then Duplicate Check modal is displayed
    When User clicks Duplicate Check Confirm button
    Then Alert Icon is displayed with text
      | Success! New Associated Party has been saved. |
    And Associated Party page is loaded
