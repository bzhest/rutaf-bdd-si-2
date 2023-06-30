@ui @full_regression @core_regression @arabica

Feature: Third-party - Add Screening Criteria to add/edit Supplier

  As a RDDC user
  I want new screening criteria
  So that I can select which screening type I would like to see the results

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    When User opens third-party creation form

  @C37452731
  Scenario: C37452731: third-Party - Verify Third-Party Name is pre-populated in the Search Term and Country is pre-populated in Country of Registration
    When "Screening Criteria" section for add third-party is displayed between "Contact" and "Description" sections
    And User submits Third-party creation form
    Then Error message "This field is required" in red color is displayed on field
      | Name |
    When User expands "Address" section
    Then Error message "This field is required" in red color is displayed on Address section on field
      | Country |
    When User expands the add third-party screening criteria accordion if it is collapsed
    Then Error message "This field is required" in red color is displayed near on Screening Criteria section on field
      | Search Term |
    When User fills third-party creation form with third-party's test data "with mandatory fields"
    And User expands the add third-party screening criteria accordion if it is collapsed
    Then Search Term Value on Screening Criteria section is pre-populated with third-party's Name from test data "with mandatory fields"
    And Country of Registration Value on Screening Criteria section is pre-populated with Country from test data "with mandatory fields"
    And Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    When User clicks on Check Type "Custom WatchList"
    And User clicks on Check Type "Media Check"
    And User clicks on Check Type "World-Check"
    Then Check Type is unchecked
      | Custom WatchList |
      | Media Check      |
    And Check Type is checked
      | World-Check |

  @C37688630
  Scenario: C37688630: third-Party - Verify Third Party is created with correct Search Term and Country
    When User fills third-party creation form with third-party's test data "with defined name"
    And User submits Third-party creation form
    Then Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Search Term" is
      | AUTO_TEST_THIRD_PARTY |
    And Search criteria value of "Country of Registration" is
      | Afghanistan |

  @C37704073
  Scenario: C37704073: third-Party - Verify third Party is created with the new value of the Search Term After pre-populated
    When User fills third-party creation form with third-party's test data "with defined name"
    And User expands the add third-party screening criteria accordion if it is collapsed
    Then Search Term Value on Screening Criteria section is pre-populated with third-party's Name from test data "with defined name"
    And Country of Registration Value on Screening Criteria section is pre-populated with Country from test data "with defined name"
    When User changes Search Term current value "AUTO_TEST_THIRD_PARTY" with value "Apple"
    And User clicks Same as address country checkbox of Country of Registration
    And User fills Country Of Registration "United Kingdom" Value
    Then Country Value "United Kingdom" in Country Of Registration on Screening Criteria section is displayed
    And Search Term Value "Apple" on Screening Criteria section is displayed
    When User submits Third-party creation form
    Then Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Search Term" is
      | Apple |
    And  Search criteria value of "Country of Registration" is
      | United Kingdom |

  @C37777518
  Scenario: C37777518: third-Party - Verify third Party is created with update value of name and country
    When User fills third-party creation form with third-party's test data "with defined name"
    And User expands the add third-party screening criteria accordion if it is collapsed
    Then Search Term Value on Screening Criteria section is pre-populated with third-party's Name from test data "with defined name"
    And Country of Registration Value on Screening Criteria section is pre-populated with Country from test data "with defined name"
    When User deletes Third-Party name current value "AUTO_TEST_THIRD_PARTY"
    And User fills third-party creation form with third-party's test data "with mandatory fields update"
    And User expands the add third-party screening criteria accordion if it is collapsed
    Then Search Term Value on Screening Criteria section is pre-populated with third-party's Name from test data "with mandatory fields update"
    And Country of Registration Value on Screening Criteria section is pre-populated with Country from test data "with mandatory fields update"
    When User submits Third-party creation form
    Then Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Search Term" is
      | AUTO_TEST_THIRD_PARTY_update |
    And Search criteria value of "Country of Registration" is
      | Norway |

  @C37780711
  Scenario: C37780711: third-Party - Verify third Party is created with empty country of registration
    When User fills third-party creation form with third-party's test data "with defined name"
    And User expands the add third-party screening criteria accordion if it is collapsed
    Then Search Term Value on Screening Criteria section is pre-populated with third-party's Name from test data "with mandatory fields"
    And Country of Registration Value on Screening Criteria section is pre-populated with Country from test data "with mandatory fields"
    When User clicks Same as address country checkbox of Country of Registration
    And User submits Third-party creation form
    Then Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Search Term" is
      | AUTO_TEST_THIRD_PARTY |
    And Search criteria value of "Country of Registration" is
      |  |

  @C37619791
  Scenario: C37619791: third-Party - Verify Country of Registration is pre-populated dropdown list, retrieved from WC country
    When User fills third-party creation form with third-party's test data "with country Syria"
    And User expands the add third-party screening criteria accordion if it is collapsed
    Then Search Term Value on Screening Criteria section is pre-populated with third-party's Name from test data "with country Syria"
    When User submits Third-party creation form
    Then Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Search Term" is
      | AUTO_TEST_THIRD_PARTY |
    And Search criteria value of "Country of Registration" is
      | Syrian Arab Republic |

  @C37780935
  Scenario: C37780935: third-Party - Verify Country of Registration is empty when SI country does not match with WC country
    When User fills third-party creation form with third-party's test data "with random ID name and Netherlands Antilles country"
    And User submits Third-party creation form
    Then Screening results table is loaded
    And Screening section Change Search Criteria button is displayed
    When User clicks Change Search Criteria screening button
    Then Search criteria value of "Country of Registration" is
      |  |

  @C37452739
  Scenario: C37452739: Add Third-party - Verify Ongoing screening default = unchecked
    When User fills third-party creation form with third-party's test data "with random ID name"
    And User expands the add third-party screening criteria accordion if it is collapsed
    Then Ongoing Screening "World-Check" is unchecked
    When User submits Third-party creation form
    Then Screening results table is loaded
    And Screening section Ongoing Screening slider is displayed
    When User clicks OGS slider to ON

  @C37626353
  Scenario: C37626353: Add Third-party - Verify Notification recipients enable only "User" radio button (pre-selected)
    When User fills third-party creation form with third-party's test data "with mandatory fields"
    And User expands the add third-party screening criteria accordion if it is collapsed
    Then Ongoing Screening "World-Check" is unchecked
    And User clicks on Ongoing Screening "World-Check"
    Then Ongoing Screening "World-Check" is checked
    And Notification Recipients "User" is checked
    And User "ADMIN" was assigned to Notification Recipients
    When User submits Third-party creation form
    Then Screening results table is loaded
    And Screening section Ongoing Screening slider is displayed
    When User clicks OGS slider to OFF
    And User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with user role "ADMIN" recipient

  @C37814537
  Scenario: C37814537: Add Third-Party - Verify display tabs according to the selected check type(s)
    When User fills third-party creation form with third-party's test data "with defined name"
    And User expands the add third-party screening criteria accordion if it is collapsed
    Then Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    When User submits Third-party creation form
    Then Screening results table is loaded
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
    And Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
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