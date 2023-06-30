@ui @full_regression @core_regression @arabica

Feature: Associated Individual Other Names - Add Other Name

  As a user,
  I want an ability to add a supplier contact using other names.
  So that I can see the results from all names.

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"

  @C37797252 @C37797260
  Scenario: C37797252 C37797260: Associated Individual - Other Name - Add and Edit - Verify SI display check type(s) are retrieved from tenant configuration
    When User creates Associated Party "with mandatory fields"
    And Add Name mandatory text field is displayed
    And User fills in Name field value "Test Other Name"
    And User selects Name type "Also Known As"
    Then Selected Name type "Also Known As" is disabled
    And Check Type label "World-Check" is displayed when API return "wc1Enabled"
    And "World-Check" check type is selected when API return "wc1Enabled"
    And Check Type label "Custom WatchList" is displayed when API return "wc1WatchlistEnabled"
    And "Custom WatchList" check type is selected when API return "wc1WatchlistEnabled"
    And Check Type label "Media Check" is displayed when API return "wc1MediaCheckEnabled"
    And "Media Check" check type is selected when API return "wc1MediaCheckEnabled"
    When User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Test Other Name" name
    Then Check Type label "World-Check" is displayed when API return "wc1Enabled"
    And "World-Check" check type is selected when API return "wc1Enabled"
    And Check Type label "Custom WatchList" is displayed when API return "wc1WatchlistEnabled"
    And "Custom WatchList" check type is selected when API return "wc1WatchlistEnabled"
    And Check Type label "Media Check" is displayed when API return "wc1MediaCheckEnabled"
    And "Media Check" check type is selected when API return "wc1MediaCheckEnabled"

  @C38370384
  Scenario: C38370384: Associated Individual - Other Name - Verify Add Other Name popup when Auto-Screen is OFF and don't change search criteria.
    When User creates Associated Party "with mandatory fields auto screen off"
    Then These fields from Other Name section are enabled
      | Name                |
      | Name Type           |
      | Country of Location |
      | Citizenship         |
      | Place of Birth      |
    And "World-Check" Check type is checked
    And "World-Check" Check type is disabled
    And "Custom WatchList" Check type is unchecked
    And "Custom WatchList" Check type is disabled
    And "Media Check" Check type is unchecked
    And "Media Check" Check type is disabled
    And "Add button" for other name is displayed
    And "Cancel Other Name button" for other name is displayed
    When User fills in Name field value "Test Other Name"
    Then User selects Name type "Also Known As"
    When User clicks on "Other Names Add|Save button"
    Then  User opens screening results for "Test Other Name" Other name
    When User clicks on "WORLD-CHECK" other name screening tab
    Then "WORLD-CHECK" other name tab is selected
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |
    And Other Name "CUSTOM WATCHLIST" tab is invisible
    And Other Name "MEDIA CHECK" tab is invisible

  @C38370830
  Scenario: C38370830: Associated Individual - Other Name - Verify Add Other Name popup when Auto-Screen is OFF and then changed the "Change Search Criteria".
    When User creates Associated Party "with mandatory fields auto screen off"
    And User clicks Enable screening button
    And User fills Search Term with "John"
    Then User clicks Search On Search criteria button
    And Screening results table is loaded
    And "World-Check" Check type is checked
    And "World-Check" Check type is disabled
    And "Custom WatchList" Check type is checked
    And "Custom WatchList" Check type is enabled
    And "Media Check" Check type is checked
    And "Media Check" Check type is enabled
    When User fills in Name field value "John"
    Then User selects Name type "Also Known As"
    When User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    And Other Name "WORLD-CHECK" tab is visible
    And Other Name "CUSTOM WATCHLIST" tab is visible
    And Other Name "MEDIA CHECK" tab is visible

  @C38371634
  Scenario: C38371634: Associated Individual - Other Name - Verify Edit Other Name popup when Auto-Screen is OFF and don't change search criteria.
    When User creates Associated Party "with mandatory fields auto screen off"
    Then User fills in Name field value "Test Other Name"
    And User selects Name type "Also Known As"
    When User clicks on "Other Names Add|Save button"
    Then "Other Names Table" for other name is displayed
    When User clicks on Edit Other Name Button for "Test Other Name" name
    Then These fields from Other Name section are enabled
      | Name                |
      | Name Type           |
      | Country of Location |
      | Citizenship         |
      | Place of Birth      |
    And "World-Check" Check type is checked
    And "World-Check" Check type is disabled
    And "Custom WatchList" Check type is unchecked
    And "Custom WatchList" Check type is disabled
    And "Media Check" Check type is unchecked
    And "Media Check" Check type is disabled
    And "Add button" for other name is displayed
    And "Cancel Other Name button" for other name is displayed
    When User fills in Name field value "John"
    And User clicks on "Other Names Add|Save button"
    Then "Other Names Table" for other name is displayed
    When User opens screening results for "John" Other name
    Then Other Name "WORLD-CHECK" tab is visible
    And "WORLD-CHECK" other name tab is selected
    And "Screening Result text" for other name screening is displayed with text
      | NO AVAILABLE DATA |
    And Other Name "CUSTOM WATCHLIST" tab is invisible
    And Other Name "MEDIA CHECK" tab is invisible

  @C38371802
  Scenario: C38371802: Associated Individual - Other Name - Verify Edit Other Name popup when Auto-Screen is OFF and then changed the "Change Search Criteria".
    When User creates Associated Party "with mandatory fields auto screen off"
    Then User fills in Name field value "Test Other Name"
    And User selects Name type "Also Known As"
    When User clicks on "Other Names Add|Save button"
    Then "Other Names Table" for other name is displayed
    And These fields from Other Name section are enabled
      | Name                |
      | Name Type           |
      | Country of Location |
      | Citizenship         |
      | Place of Birth      |
    And "World-Check" Check type is checked
    And "World-Check" Check type is disabled
    And "Custom WatchList" Check type is unchecked
    And "Custom WatchList" Check type is disabled
    And "Media Check" Check type is unchecked
    And "Media Check" Check type is disabled
    When User clicks Enable screening button
    And User fills Search Term with "John"
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    When User clicks on Edit Other Name Button for "Test Other Name" name
    Then "World-Check" Check type is checked
    And "World-Check" Check type is disabled
    And "Custom WatchList" Check type is unchecked
    And "Custom WatchList" Check type is enabled
    And "Media Check" Check type is unchecked
    And "Media Check" Check type is enabled
    And "Add button" for other name is displayed
    And "Cancel Other Name button" for other name is displayed
    When User clicks on "Cancel Other Name button"
    Then These fields from Other Name section are enabled
      | Name                |
      | Name Type           |
      | Country of Location |
      | Citizenship         |
      | Place of Birth      |
    And "World-Check" Check type is checked
    And "World-Check" Check type is disabled
    And "Custom WatchList" Check type is checked
    And "Custom WatchList" Check type is enabled
    And "Media Check" Check type is checked
    And "Media Check" Check type is enabled
