@ui @full_regression @core_regression @arabica

Feature: Associated Individual - Add Screening Criteria to add/edit Contacts

  As a RDDC user
  I want new screening criteria
  So that I can select which screening type I would like to see the results

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"
    And User clicks on "Associated Parties" tab on Third-party page

  @C37452747
  Scenario: C37452747: Add Associated Individual - Verify Ongoing Screening default = Unchecked and Check Type default: select all
    When User clicks on ADD ASSOCIATED PARTY button
    Then User clicks Auto-screen button to ON
    And Contact's Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    When User clicks on Contact's Check Type "Custom WatchList"
    And User clicks on Contact's Check Type "Media Check"
    And User clicks on Contact's Check Type "World-Check"
    Then Contact's Check Type is unchecked
      | Custom WatchList |
      | Media Check      |
    And Contact's Check Type is checked
      | World-Check |
    And Contact's Ongoing Screening "World-Check" is unchecked
    And User creates Associated Party "with mandatory fields"
    Then Associated Party page is loaded
    And Screening results table is loaded
    And Screening section Ongoing Screening slider is displayed
    When User clicks OGS slider to ON
    And User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with user role "ADMIN" recipient

  @C37452750
  Scenario: C37452750: Add Associated Individual -Verify Notification recipients enable only "User" radio button (pre-selected)
    When User clicks on ADD ASSOCIATED PARTY button
    Then User clicks Auto-screen button to ON
    And User enters Associated Party first name with value "Test_First_Name"
    And User enters Associated Party last name with value "Test_Last_Name"
    And User enters Associated Party email with value "test@test.com"
    Then Contact's Ongoing Screening "World-Check" is unchecked
    When User clicks on Contact's Ongoing Screening "World-Check"
    Then Contact's Ongoing Screening "World-Check" is checked
    And Contact's Notification Recipients "User" is checked
    And User "ADMIN" was assigned to Notification Recipients
    And User clicks on Save Associated Party button
    Then Associated Party page is loaded
    And Screening results table is loaded
    And Screening section Ongoing Screening slider is displayed
    When User clicks OGS slider to OFF
    And User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with user role "ADMIN" recipient

  @C37452746
  Scenario: C37452746: Add Associated Individual - Verify Associated Individual First Name and Last Name is pre-populated in the Search Term
    When User clicks on ADD ASSOCIATED PARTY button
    And User clicks Auto-screen button to ON
    And User clicks on Save Associated Party button
    Then Error message "This field is required" in red color is displayed on General Information section on field
      | First Name |
      | Last Name  |
    And Error message "This field is required" in red color is displayed on Screening Criteria section on field
      | Search Term |
    When User enters Associated Party first name with value "Test_First_Name"
    And User enters Associated Party last name with value "Test_Last_Name"
    Then Search Term Value on Screening Criteria section is pre-populated with Full Name "Test_First_Name Test_Last_Name"

  @C37452748
  Scenario: C37452748: Add Associated Individual - Verify Associated Individual is created with correct Search Term , Country of Location,Place of Birth,Citizenship
    When User clicks on ADD ASSOCIATED PARTY button
    And User clicks Auto-screen button to ON
    And User enters Associated Party first name with value "Test_First_Name"
    And User enters Associated Party last name with value "Test_Last_Name"
    And User enters Associated Party email with value "test@test.com"
    Then "Country of Location" Value on Screening Criteria section is not pre-populated and Displayed as empty
    And "Place of Birth" Value on Screening Criteria section is not pre-populated and Displayed as empty
    And "Citizenship" Value on Screening Criteria section is not pre-populated and Displayed as empty
    When User clicks on Save Associated Party button
    Then Associated Party page is loaded
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria "Search Term" contains "Test_First_Name Test_Last_Name" value
    And  Search criteria value of "Country of Location" is
      |  |
    And Search criteria value of "Place of Birth" is
      |  |
    And Search criteria value of "Citizenship" is
      |  |

  @C38579704
  Scenario: C38579704: Add Associated Individual - Verify Associated Individual is created with the new value of the Search Term After pre-populated
    When User clicks on ADD ASSOCIATED PARTY button
    And User clicks Auto-screen button to ON
    And User enters Associated Party first name with value "Test_First_Name"
    And User enters Associated Party last name with value "Test_Last_Name"
    And User enters Associated Party email with value "test@test.com"
    And User changes Contact's Search Term current value "Test_First_Name Test_Last_Name" with value "joe biden"
    And User clicks on Save Associated Party button
    Then Associated Party page is loaded
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria "Search Term" contains "joe biden" value
    And  Search criteria value of "Country of Location" is
      |  |
    And Search criteria value of "Place of Birth" is
      |  |
    And Search criteria value of "Citizenship" is
      |  |

  @C38579842
  Scenario: C38579842: Add Associated Individual - Verify Associated Individual is created with the value of First Name ,Last name ,Nationality , Country of Location and Place of Birth
    When User clicks on ADD ASSOCIATED PARTY button
    And User clicks Auto-screen button to ON
    And User enters Associated Party first name with value "Test_First_Name"
    And User enters Associated Party last name with value "Test_Last_Name"
    And User enters Associated Party email with value "test@test.com"
    And User deletes First Name current value "Test_First_Name"
    And User deletes Last Name current value "Test_Last_Name"
    And User enters Associated Party first name with value "Change_First_Name"
    And User enters Associated Party last name with value "Change_Last_Name"
    And User enters Citizenship On Screening Criteria section with value "United States"
    And User enters Country of Location On Screening Criteria Section with value "Netherlands"
    And User enters Place of Birth On Screening Criteria Section with value "Syrian Arab Republic"
    And User clicks on Save Associated Party button
    Then Associated Party page is loaded
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria "Search Term" contains "Change_First_Name Change_Last_Name" value
    And Search criteria "Country of Location" contains "Netherlands" value
    And Search criteria "Place of Birth" contains "Syrian Arab Republic" value
    And Search criteria "Citizenship" contains "United States" value

  @C38583462
  Scenario: C38583462: Add Associated Individual - Verify Search Term is updated when input first name and last name
    When User clicks on ADD ASSOCIATED PARTY button
    And User clicks Auto-screen button to ON
    Then "Screening Criteria" section for add contact is displayed between "Contact" and "Description" sections
    When User enters Associated Party first name with value "Test_First_Name"
    And User enters Associated Party last name with value "Test_Last_Name"
    And User changes Contact's Search Term current value "Test_First_Name Test_Last_Name" with value "joe biden"
    When User deletes First Name current value "Test_First_Name"
    And User deletes Last Name current value "Test_Last_Name"
    Then User enters Associated Party first name with value "Test_First_Name Add more chars"
    And User enters Associated Party last name with value "Test_Last_Name Add more chars"
    And User enters Country of Location On Screening Criteria Section with value "Netherlands"
    And User clicks on Save Associated Party button
    Then Associated Party page is loaded
    And "Address" for contact is displayed between "General Information" and "Contact" sections
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria "Search Term" contains "Test_First_Name Add more chars Test_Last_Name Add more chars" value

  @C37452822
  Scenario: C37452822: Add Associated Individual - Verify Auto-Screen toggle OFF
    When User creates Associated Party "with mandatory fields auto screen off"
    Then Associated Party page is loaded
    And Screening results table is loaded
    When User clicks Enable screening button
    Then Search criteria "Search Term" contains "Test_First_Name Test_Last_Name" value
    And Check Type is checked
      | World-Check |
      | Custom WatchList |
      | Media Check      |
    And  Search criteria value of "Country of Location" is
      |  |
    And Search criteria value of "Place of Birth" is
      |  |
    And Search criteria value of "Citizenship" is
      |  |

  @C37816428
  Scenario: C37816428: Add Associated Individual - Verify display tabs according to the selected check type(s)
    When User clicks on ADD ASSOCIATED PARTY button
    And User clicks Auto-screen button to ON
    And User enters Associated Party first name with value "Test_First_Name"
    And User enters Associated Party last name with value "Test_Last_Name"
    And User enters Associated Party email with value "test@test.com"
    Then Contact's Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    When User clicks on Save Associated Party button
    Then Associated Party page is loaded
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    When User clicks Cancel search criteria button
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And No Available Data on "MEDIA CHECK" tab is displayed
    When User clicks on "CUSTOM WATCHLIST" tab
    Then "CUSTOM WATCHLIST" tab is displayed
    And No Available Data on "CUSTOM WATCHLIST" tab is displayed
    When User clicks on "WORLD-CHECK" tab
    Then "WORLD-CHECK" tab is displayed
    And No Available Data on "WORLD-CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    And User clicks on Check Type "Media Check"
    And User clicks Search On Search criteria button
    Then Screening results table is loaded
    When User clicks on "CUSTOM WATCHLIST" tab
    Then "CUSTOM WATCHLIST" tab is displayed
    And No Available Data on "CUSTOM WATCHLIST" tab is displayed
    When User clicks on "WORLD-CHECK" tab
    Then "WORLD-CHECK" tab is displayed
    And No Available Data on "WORLD-CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    And User clicks on Check Type "Custom WatchList"
    And User clicks Search On Search criteria button
    And Screening results table is loaded
    Then "WORLD-CHECK" tab is displayed
    And No Available Data on "WORLD-CHECK" tab is displayed