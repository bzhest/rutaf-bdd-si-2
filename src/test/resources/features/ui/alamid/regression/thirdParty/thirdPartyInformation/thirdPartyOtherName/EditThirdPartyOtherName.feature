@ui @other_names @alamid @full_regression

Feature: Third-party Other Name

  @C44944518
  Scenario: C44944518: Edit Other Name - Groups field disabled
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name"
    And User fills in Name field value "China"
    And User selects Name type "Other Name"
    Then Other Name Groups field is displayed with default value "All"
    When User selects other name group 2
    And User clicks on "Add button"
    Then Other name "China" is created
    When User clicks on Edit Other Name Button for "China" name
    Then Other Name Groups field value is "PEP Only"
    And Other Name "Groups" field is not blank
    And Other Name Groups field is disabled