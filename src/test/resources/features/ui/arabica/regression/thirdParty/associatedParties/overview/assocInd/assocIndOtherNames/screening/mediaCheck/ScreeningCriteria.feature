@ui @core_regression @arabica

Feature: Associated Individual Other Names - Add Screening Criteria to add/edit Contacts

  As a RDDC user
  I want new screening criteria
  So that I can select which screening type I would like to see the results

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name"
    And User creates Associated Party "with mandatory fields"

  @C37816438
  Scenario: C37816438: Add Associated Individual Other Names - Verify display tabs according to the selected check type(s)
    When Screening results table is loaded
    And User clicks on "Other Names Add|Save button"
    And User fills in Name field value "RANDOMNAME"
    And User selects Name type "Also Known As"
    Then Other Name Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    When User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
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
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "RANDOMNAME" name
    And User clicks on Other name Check Type "Media Check"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
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
    Then Other Name dialog is loaded
    And "WORLD-CHECK" other name tab is selected
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |