@ui @full_regression @core_regression @arabica

Feature: Third-party Other Names - Add Other Name

  As a user,
  I want an ability to screen a supplier using Other Names.
  So that I can see the results from all names.

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"

  @C37790947 @C37791042
  Scenario: C37790947 C37791042: Third-party - Other Name - Add and Edit - Verify SI display check type(s) are retrieved from tenant configuration
    Then Add Name mandatory text field is displayed
    And Check Type label "World-Check" is displayed when API return "wc1Enabled"
    And "World-Check" check type is selected when API return "wc1Enabled"
    And Check Type label "Custom WatchList" is displayed when API return "wc1WatchlistEnabled"
    And "Custom WatchList" check type is selected when API return "wc1WatchlistEnabled"
    And Check Type label "Media Check" is displayed when API return "wc1MediaCheckEnabled"
    And "Media Check" check type is selected when API return "wc1MediaCheckEnabled"
    When User fills in Name field value "Test Other Name"
    And User selects Name type "Other Name"
    Then Selected Name type "Other Name" is disabled
    When User clicks on "Other Names Add|Save button"
    And User clicks on Edit Other Name Button for "Test Other Name" name
    And Check Type label "World-Check" is displayed when API return "wc1Enabled"
    And "World-Check" check type is selected when API return "wc1Enabled"
    And Check Type label "Custom WatchList" is displayed when API return "wc1WatchlistEnabled"
    And "Custom WatchList" check type is selected when API return "wc1WatchlistEnabled"
    And Check Type label "Media Check" is displayed when API return "wc1MediaCheckEnabled"
    And "Media Check" check type is selected when API return "wc1MediaCheckEnabled"
