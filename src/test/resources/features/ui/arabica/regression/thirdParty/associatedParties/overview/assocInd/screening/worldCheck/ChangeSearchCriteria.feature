@ui @full_regression @core_regression @arabica

Feature: Associated Individual - Change Search Criteria

  As a RDDC user
  I want Change Search Criteria button to be adjusted
  So that I can choose to screen for World-Check, Custom WatchList, Media Check results or all of them

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "Bank of China"

  @C39187382
  Scenario: C39187382: Add Associated Individual - Verify  Change Search Media modal
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Groups" is
      | All |
    And Search criteria "Search Term" contains "Barac Obama" value
    And Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    When User clicks on Check Type "World-Check"
    And User clicks on Check Type "Custom WatchList"
    And User clicks on Check Type "Media Check"
    Then Check Type is checked
      | World-Check |
    And Check Type is unchecked
      | Custom WatchList |
      | Media Check      |
    And  Search criteria value of "Country of Location" is
      |  |
    And Search criteria value of "Place of Birth" is
      |  |
    And Search criteria value of "Citizenship" is
      |  |
    When User edits "Country of Location" field with value "Russian Federation" on Change Search Criteria
    And User edits "Place of Birth" field with value "Montenegro" on Change Search Criteria
    And User edits "Citizenship" field with value "Montenegro" on Change Search Criteria
    And User edits Search Term with value "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultriedddddd"
    Then Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria "Search Term" contains "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultriedddddd" value
    And Search criteria value of "Groups" is
      | All |
    And Check Type is checked
      | World-Check |
    And  Search criteria value of "Country of Location" is
      | Russian Federation |
    And Search criteria value of "Place of Birth" is
      | Montenegro |
    And Search criteria value of "Citizenship" is
      | Montenegro |

  @C39520725 @C39520726
  Scenario: C39520725, C39520726: Associated Individual - Screening - Change Search Criteria (Check type) and 'World Check' cannot be uncheck
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    And User clicks Auto-screen button to ON
    And User clicks on "Custom WatchList" checkbox to "unselect" in add contact page
    And User clicks on "Media Check" checkbox to "unselect" in add contact page
    And User creates Associated Party "with mandatory fields"
    Then Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Check Type is checked
      | World-Check |
    And Check Type is unchecked
      | Custom WatchList |
      | Media Check      |
    When User clicks on Check Type "World-Check"
    And User clicks on Check Type "Custom WatchList"
    And User clicks on Check Type "Media Check"
    Then Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    When User clicks on screening confirmation button with name "SEARCH"
    Then Screening results table is loaded
    And "WORLD-CHECK" tab is displayed
    And "CUSTOM WATCHLIST" tab is displayed
    And "MEDIA CHECK" tab is displayed

  @C39187758
  Scenario: C39187758: Associated Individual - Change Search Criteria - Verify the screening results must not update when a user changes the search term value but hitting the cancel button
    When User creates Associated Party "Joe Biden"
    And User clicks Enable screening button
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    When User gets Screening Number before Re-Screening
    And User clicks Change Search Criteria screening button
    And User changes Search Term to "John Smith"
    And User clicks Cancel search criteria button
    Then Screening results table is loaded
    And The system re-screening with the original search term and screening results shouldn't be updated

  @C39187761
  Scenario: C39187761: Associated Individual - Change Search Criteria - Verify the screening results must update when a user changes the search term value and hitting the SEARCH button
    When User creates Associated Party "Joe Biden"
    And User clicks Enable screening button
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    When User gets Screening Number before Re-Screening
    And User clicks Change Search Criteria screening button
    And User changes Search Term to "John Smith"
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    And The system re-screening with the new search term and screening results should be updated

  @C37800170
  Scenario: C37800170: Associated Individual - Change Search Criteria -  Verify the Country of Location field is pre-populated value correctly
    When User creates Associated Party "John Paul"
    Then Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Country of Location" is
      | Australia |

  @C37800172
  Scenario: C37800172: Associated Individual - Change Search Criteria -  Verify Place of Birth and Citizenship fields are pre-populated value correctly
    When User creates Associated Party "John Paul"
    Then Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Place of Birth" is
      | Aruba |
    And Search criteria value of "Citizenship" is
      | United Kingdom |

  @C39271709
  Scenario: C39271709: Associated Individual - Change Search Criteria - Verify Search Term display as the same value on the create TP step
    When User creates Associated Party "Joe Biden"
    And User clicks Enable screening button
    Then Search criteria "Search Term" contains "Joe Biden" value
    When User clicks Search On Search criteria button
    Then Screening results table is loaded
    When User clicks Associated Party's General Information section "Edit" button
    And User updates Associated Party's General Information section with values
      | First Name | Last Name |
      | John       | Smith     |
    And User clicks Associated Party's General Information section "Save" button
    Then Associated Party's General Information section details are displayed with populated data
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria "Search Term" contains "John Smith" value

  @C39187761
  Scenario: C39187761: Associated Individual - Change Search Criteria - Verify the screening results must update when a user changes the search term value and hitting the SEARCH button
    When User creates Associated Party "Joe Biden"
    And User clicks Enable screening button
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    When User gets Screening Number before Re-Screening
    And User clicks Change Search Criteria screening button
    And User changes Search Term to "John Smith"
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    And The system re-screening with the new search term and screening results should be updated