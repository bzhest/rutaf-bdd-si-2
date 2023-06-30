@ui @full_regression @core_regression @arabica

Feature: Third-party Other Names - Media check screening detail

  As a RDDC user
  I want a new tab of media check screening
  So that I can see screening results of the media check records from WC1 in SI

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "Bank of China"

  @C38429319
  Scenario: C38429319: third-Party other names - Verify row per page is correct
    When User creates Other name "Bank of China"
    And User opens screening results for "Bank of China" Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    And User should see Rows per page label
    And Media Check Other Names Rows per page dropdown value should be "10"
    And Media Check Other Names Result Table should contain 10 records
    And Media Check Other Names Rows per page Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    When User selects "25" option from Rows Per Page dropdown list on Other Names
    Then Media Check Other Names Result Table should contain 25 records
    And Media Check Other Names Rows per page dropdown value should be "25"
    When User selects "50" option from Rows Per Page dropdown list on Other Names
    Then Media Check Other Names Result Table should contain 50 records
    And Media Check Other Names Rows per page dropdown value should be "50"

  @C37502775
  Scenario: C37502775: third-Party other names - Media Check tab - No External URL Article - Verify components are correct Verify components are correct
    When User creates Other name "TOT"
    And User opens screening results for "TOT" Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    And Media check Other Name "TOT" showing articles must be as same as API value
    And User should see "TOT" in Media Check Other Name Screening Result Table
    And Other Name Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And Media check Other Name "TOT" first record with no external articles displays phases as blue color
    And Media check Other Name "TOT" first record with no external articles displays topics as black color
    And Media check Other Name "TOT" first record with no external articles displays name as same as API value
    And Media check Other Name "TOT" first record with no external articles displays date in format: "dd-MMM-YYYY"

  @C37502776
  Scenario: C37502776: third-Party other names - Media Check tab - External URL Article - Verify components are correct Verify components are correct
    When User creates Other name "Apple"
    And User opens screening results for "Apple inc." Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    And Media check Other Name "Apple inc." showing articles must be as same as API value
    And User should see "Apple inc." in Media Check Other Name Screening Result Table
    And Other Name Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And Media check Other Name "Apple inc." first record with external articles displays phases as blue color
    And Media check Other Name "Apple inc." first record with external articles displays topics as black color
    And Media check Other Name "Apple inc." first record with external articles displays name as same as API value
    And Media check Other Name "Apple inc." first record with external articles displays date in format: "dd-MMM-YYYY"

  @C37830921
  Scenario: C37830921: third-Party other names - Media Check tab - Verify User can change search term in media check tab and article in search result should show corresponding to the search term
    When User creates Other name "TOT"
    And User opens screening results for "TOT" Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    And User should see "TOT" in Media Check Other Name Screening Result Table
    And Other Name Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    When User clicks Close Other Name Results button
    Then Screening results table is loaded
    When User clicks on Edit Other Name Button for "TOT" name
    Then Screening results table is loaded
    When User fills in Name field value "Bank of China"
    And User clicks on "Other Names Add|Save button"
    Then Screening results table is loaded
    When User opens screening results for "Bank of China" Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    And User should see "Bank of China" in Media Check Other Name Screening Result Table

  @C39294057
  Scenario: C39294057: third-Party other names - Media Check tab - Verify User should see empty last screening date when user changes the search criteria from a search term that contains result to search term that contains no result
    When User creates Other name "TOT"
    And User opens screening results for "TOT" Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    And User should see "TOT" in Media Check Other Name Screening Result Table
    And Other Name Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    When User clicks Close Other Name Results button
    Then Screening results table is loaded
    When User clicks on Edit Other Name Button for "TOT" name
    Then Screening results table is loaded
    When User fills in Name field value "DHFJKFLEJRFLJER"
    And User clicks on "Other Names Add|Save button"
    Then Screening results table is loaded
    When User opens screening results for "DHFJKFLEJRFLJER" Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    And User should see "DHFJKFLEJRFLJER" in Media Check Other Name Screening Result Table
    And Other Name Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"

  @C38429318
  Scenario: C38429318: third-Party other names - Media Check tab - Verify pagination is correct
    When User creates Other name "Apple"
    And User opens screening results for "Apple inc." Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    And User should see "Apple inc." in Media Check Other Name Screening Result Table
    And Other Name Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And Media Check First Page button is "disabled"
    And Media Check Previous Page button is "disabled"
    And Media Check Next Page button is "enabled"
    And Media Check Last Page button is "enabled"
    When User clicks last page
    Then Other Name dialog is loaded
    And Media Check First Page button is "enabled"
    And Media Check Previous Page button is "enabled"
    And Media Check Next Page button is "disabled"
    And Media Check Last Page button is "disabled"
    When User clicks previous page
    Then Other Name dialog is loaded
    And Media Check First Page button is "enabled"
    And Media Check Previous Page button is "enabled"
    And Media Check Next Page button is "enabled"
    And Media Check Last Page button is "enabled"
    When User clicks first page
    Then Other Name dialog is loaded
    And Media Check First Page button is "disabled"
    And Media Check Previous Page button is "disabled"
    And Media Check Next Page button is "enabled"
    And Media Check Last Page button is "enabled"
    When User clicks next page
    Then Other Name dialog is loaded
    And Media Check First Page button is "enabled"
    And Media Check Previous Page button is "enabled"
    And Media Check Next Page button is "enabled"
    And Media Check Last Page button is "enabled"

  @C37502781
  Scenario: C37502781: third-Party other names - Media Check tab - Verify User should see default range of article publication is 2 years back from current screening date
    When User creates Other name "Apple"
    And User opens screening results for "Apple inc." Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    And User should see "Apple inc." in Media Check Other Name Screening Result Table
    When User gets Media check Other Name "Apple inc." for "last" page references value from API
    And User clicks last page
    Then Other Name dialog is loaded
    And Media check Other Name "Apple inc." last articles on last page displays title as same as value from API

  @C38146248
  Scenario: C38146248: Third-Party - Other Name - Media Check tab - Similar Articles - Verify the Similar Articles and See More was displayed when API return the Duplicates Key isn't null.
    When User creates Other name "Apple Test"
    And User opens screening results for "Apple" Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User selects "25" option from Rows Per Page dropdown list on Other Names
    And Other Name dialog is loaded
    Then Media Check Other Names Result Table should contain 25 records
    When The system calls the Media Check API with Other Name is "Apple" and 25 records to find a Duplicate Key is "not null"
    Then The similar articles and see more label are visible for "Third-party"

  @C38146323
  Scenario: C38146323: Third-Party - Other Name - Media Check tab - Similar Articles - Verify the Similar Articles and See More wasn't displayed when API return the Duplicates Key is null.
    When User creates Other name "Apple Test"
    And User opens screening results for "Apple" Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User selects "25" option from Rows Per Page dropdown list on Other Names
    And Other Name dialog is loaded
    Then Media Check Other Names Result Table should contain 25 records
    When The system calls the Media Check API with Other Name is "Apple" and 25 records to find a Duplicate Key is "null"
    Then The similar articles and see more label are invisible for "Third-party"

  @C38146452
  Scenario: C38146452: Third-Party - Other Name - Media Check tab - Similar Articles - Verify the similar articles list and the see less label must be displayed when clicking on the see more label.
    When User creates Other name "Apple Test"
    And User opens screening results for "Apple" Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User selects "25" option from Rows Per Page dropdown list on Other Names
    And Other Name dialog is loaded
    Then Media Check Other Names Result Table should contain 25 records
    When The system calls the Media Check API with Other Name is "Apple" and 25 records to find a Duplicate Key is "not null"
    And User clicks the see more label
    Then The source name and similar article date are displayed
    When User clicks the see less label
    Then The similar articles and see more label are visible for "Third-party"