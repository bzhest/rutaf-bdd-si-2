@ui @full_regression @core_regression @arabica

Feature: Third-party - Media check screening detail

  As a RDDC user
  I want a new tab of media check screening
  So that I can see screening results of the media check records from WC1 in SI

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Third-party page

  @C38429310
  Scenario: C38429310: third-Party - Verify row per page is correct
    When User creates third-party "Bank of China"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And User should see "Bank of China" in Media Check Screening Result Table
    And User should see Rows per page label
    And Rows per page dropdown value should be "10"
    And Media Check Result Table should contain 10 records
    And Screening results table is loaded
    And Rows per page Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    When User selects "25" option from Rows Per Page dropdown list
    Then Media Check Result Table should contain 25 records
    And Rows per page dropdown value should be "25"
    When User selects "50" option from Rows Per Page dropdown list
    Then Media Check Result Table should contain 50 records
    And Rows per page dropdown value should be "50"

  @C37483420
  Scenario: C37483420: User should see No Match Found in media check table when the search criteria contains no result
    When User creates third-party "with mandatory fields"
    And Screening results table is loaded
    And User clicks Media Check tab on Screening section
    Then MEDIA CHECK tab screening result contains No Match Found

  @C37483880
  Scenario: C37483880: User cannot turn off smart filter toggle button
    When User creates third-party "USG"
    And Screening results table is loaded
    And User clicks Media Check tab on Screening section
    And User clicks on Filter icon in Media Check tab
    And User clicks on smart filter toggle button
    Then Smart filter toggle button should be on

  @C37483732
  Scenario: C37483732: User cannot switch to Media Check tab when loading screening is on going
    When User creates third-party "USG"
    And Screening results table is loaded
    And User clicks CUSTOM WATCHLIST tab at Screening section without waiting for loading to disappear
    Then MEDIA CHECK tab is disabled

  @C38419236
  Scenario: C38419236: User should not see empty last screening date when user changes the search criteria to be a search term that contains no result
    When User creates third-party "with mandatory fields"
    And Screening results table is loaded
    And User clicks Media Check tab on Screening section
    And User clicks Change Search Criteria screening button
    And User edits Search Term with value "AUTO_TEST_THIRD_PARTY_EDIT"
    Then Screening results table is loaded
    And User should see "AUTO_TEST_THIRD_PARTY_EDIT" in Media Check Screening Result Table
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"

  @C38419230
  Scenario: C38419230: User should see the updated last screening date when user changes the search criteria in media check tab
    When User creates third-party "with mandatory fields"
    And Screening results table is loaded
    And User clicks Media Check tab on Screening section
    And User clicks Change Search Criteria screening button
    And User edits Search Term with value "Apple"
    And Screening results table is loaded
    Then User should see "Apple" in Media Check Screening Result Table
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"

  @C39145491
  Scenario: C39145491: Third-party - Verify Notify button in Media Check tab
    When User creates third-party "USG"
    And Screening results table is loaded
    And User clicks Media Check tab on Screening section
    Then Notify button is invisible in Media Check tab

  @C38134224
  Scenario: C38134224: Third-Party - Media Check tab - Similar Articles - Verify the Similar Articles and See More was displayed when API return the Duplicates Key isn't null.
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    When User selects "25" option from Rows Per Page dropdown list
    And Screening results table is loaded
    Then Media Check Result Table should contain 25 records
    And Screening results table is loaded
    When The system calls the Media Check API without Other Name is "NULL" and 25 records to find a Duplicate Key is "not null"
    Then The similar articles and see more label are visible for "Third-party"

  @C38136664
  Scenario: C38136664: Third-Party - Media Check tab - Similar Articles - Verify the Similar Articles and See More wasn't displayed when API return the Duplicates Key is null.
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    When User selects "25" option from Rows Per Page dropdown list
    And Screening results table is loaded
    Then Media Check Result Table should contain 25 records
    And Screening results table is loaded
    When The system calls the Media Check API without Other Name is "NULL" and 25 records to find a Duplicate Key is "null"
    Then The similar articles and see more label are invisible for "Third-party"

  @C38136675
  Scenario: C38136675: Third-Party - Media Check tab - Similar Articles - Verify the similar articles list and the see less label must be displayed when clicking on the see more label.
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects "25" option from Rows Per Page dropdown list
    Then Media Check Result Table should contain 25 records
    And Screening results table is loaded
    When The system calls the Media Check API without Other Name is "NULL" and 25 records to find a Duplicate Key is "not null"
    And User clicks the see more label
    Then The source name and similar article date are displayed
    When User clicks the see less label
    Then The similar articles and see more label are visible for "Third-party"