@ui @suppliers @alamid @full_regression

Feature: Edit Third-party General Information section

  @C44944535
  Scenario: C44944535: Edit Third-party Name - Send WC Groups to WC
    Given User logs into RDDC as "Admin"
    When User opens third-party creation form
    And User fills third-party creation form with third-party's test data "Paris"
    And User expands the add third-party screening criteria accordion if it is collapsed
    And User selects other group 2
    And User submits Third-party creation form
    Then Screening results table is loaded
    When User clicks General and Other Information section "Edit" button
    And User updates General Information section with values
      | Name  |
      | Japan |
    And User clicks General and Other Information section "Save" button
    Then Screening results table is loaded