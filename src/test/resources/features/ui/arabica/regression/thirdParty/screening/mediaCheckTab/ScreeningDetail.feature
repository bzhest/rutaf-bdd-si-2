@ui @full_regression @core_regression @arabica

Feature: Third-party - Media check screening detail

  As a RDDC user
  I want a new tab of media check screening
  So that I can see screening results of the media check records from WC1 in SI

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Third-party page

  @C37483273
  Scenario: C37483273: third-Party - Media Check tab - No External URL Article - Verify components are correct Verify components are correct
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    And Media check showing articles must be as same as API value
    And User should see "Apple" in Media Check Screening Result Table
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And Media check first record with no external articles displays phases as blue color
    And Media check first record with no external articles displays topics as black color
    And Media check first record with no external articles displays name as same as API value
    And Media check first record with no external articles displays date in format: "dd-MMM-YYYY"

  @C37483840
  Scenario: C37483840: third-Party - Media Check tab - External URL Article - Verify components are correct Verify components are correct
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    And Media check showing articles must be as same as API value
    And User should see "Apple" in Media Check Screening Result Table
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And Media check first record with external articles displays phases as blue color
    And Media check first record with external articles displays topics as black color
    And Media check first record with external articles displays name as same as API value
    And Media check first record with external articles displays date in format: "dd-MMM-YYYY"

  @C37830909
  Scenario: C37830909: third-Party - Media Check tab - Verify User can change search term in media check tab and article in search result should show corresponding to the search term
    When User creates third-party "Bank of China"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    And User should see "Bank of China" in Media Check Screening Result Table
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    When User changes Search Criteria "Search Term" with value "Apple"
    Then Screening results table is loaded
    And User should see "Apple" in Media Check Screening Result Table

  @C39402717
  Scenario: C39402717: third-Party - Media Check tab - Verify User should see last screening date when user changes the search criteria from a search term that contains result to search term that contains no result
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    And User should see "Apple" in Media Check Screening Result Table
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    When User changes Search Criteria "Search Term" with value "DHFJKFLEJRFLJER"
    Then Screening results table is loaded
    And No Available Data on "MEDIA CHECK" tab is displayed
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"

  @C38429249
  Scenario: C38429249: third-Party - Media Check tab - Verify pagination is correct
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    And User should see "Apple" in Media Check Screening Result Table
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And Media Check First Page button is "disabled"
    And Media Check Previous Page button is "disabled"
    And Media Check Next Page button is "enabled"
    And Media Check Last Page button is "enabled"
    When User clicks last page
    Then Screening results table is loaded
    And Media Check First Page button is "enabled"
    And Media Check Previous Page button is "enabled"
    And Media Check Next Page button is "disabled"
    And Media Check Last Page button is "disabled"
    When User clicks previous page
    Then Screening results table is loaded
    And Media Check First Page button is "enabled"
    And Media Check Previous Page button is "enabled"
    And Media Check Next Page button is "enabled"
    And Media Check Last Page button is "enabled"
    When User clicks first page
    Then Screening results table is loaded
    And Media Check First Page button is "disabled"
    And Media Check Previous Page button is "disabled"
    And Media Check Next Page button is "enabled"
    And Media Check Last Page button is "enabled"
    When User clicks next page
    Then Screening results table is loaded
    And Media Check First Page button is "enabled"
    And Media Check Previous Page button is "enabled"
    And Media Check Next Page button is "enabled"
    And Media Check Last Page button is "enabled"

  @C37483489
  Scenario: C37483489: third-Party - Media Check tab - Verify User should see default range of article publication is 2 years back from current screening date
    When User creates third-party "Bank"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    And User should see "Bank" in Media Check Screening Result Table
    And User gets Media check "last" page references value from API
    When User clicks last page
    Then Screening results table is loaded
    And Media check last articles on last page displays title as same as value from API