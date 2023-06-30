@ui @core_regression @arabica

Feature: Third-party Other Names - Add Screening Criteria to add/edit Supplier

  As a RDDC user
  I want new screening criteria
  So that I can select which screening type I would like to see the results

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"

  @C37816417
  Scenario: C37816417: Add Third-Party Other Names - Verify display tabs according to the selected check type(s)
    When User fills in Name field value "RANDOMNAME"
    And User selects Name type "Doing Business As"
    Then Other Name Check Type is checked
      | World-Check      |
      | Custom WatchList |
    When User clicks on "Add button"
    And User clicks on Screen Other Name Button for "RANDOMNAME" name
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then "CUSTOM WATCHLIST" other name tab is selected
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |
    When User clicks on "WORLD-CHECK" other name screening tab
    Then "WORLD-CHECK" other name tab is selected
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |
    And User clicks Close Other Name Results button
    When User clicks on Edit Other Name Button for "RANDOMNAME" name
    And User clicks on Other name Check Type "Media Check"
    And User clicks on "Add button"
    And User clicks on Screen Other Name Button for "RANDOMNAME" name
    Then Screening results table is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then "CUSTOM WATCHLIST" other name tab is selected
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |
    When User clicks on "WORLD-CHECK" other name screening tab
    Then "WORLD-CHECK" other name tab is selected
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "RANDOMNAME" name
    And User clicks on Other name Check Type "Custom WatchList"
    And User clicks on "Other Names Add|Save button"
    And User clicks on Screen Other Name Button for "RANDOMNAME" name
    Then Screening results table is loaded
    And "WORLD-CHECK" other name tab is selected
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |