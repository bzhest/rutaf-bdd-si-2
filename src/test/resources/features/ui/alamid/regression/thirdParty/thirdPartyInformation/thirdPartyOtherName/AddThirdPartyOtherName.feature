@ui @other_names @alamid @full_regression

Feature: Third-party Other Name

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"

  @C44905069 @core_regression
  Scenario: C44905069: Add Third-party Other Name with Groups
    When User fills in Name field value "China"
    And User selects Name type "Other Name"
    Then Other Name Groups field is displayed with default value "All"
    When User selects other name group 2
    And User clicks on "Other Names Add|Save button"
    Then Other name "China" is created

  @C44905104
  Scenario: C44905104: Add Third-party Other Name - Groups field - Tooltip displayed when hovered for selected long Group Name that doesn't fit in the field
    When User fills in Name field value "China"
    And User selects Name type "Other Name"
    And User hovers to Other Name groups dropdown 3
    Then Other Name Groups dropdown tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed
    When User selects other name group 3
    And User hovers to Other Name Group field
    Then Other Name Group tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed
