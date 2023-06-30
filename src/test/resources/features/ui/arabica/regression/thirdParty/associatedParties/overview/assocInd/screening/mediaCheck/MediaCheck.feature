@ui @full_regression @core_regression @arabica

Feature: Associated Individual - Add Media Check tab

  As a RDDC user
  I want new screening section from media check tab
  So that I can see screening result

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"

  @C39145689
  Scenario: C39145689: Associated Individual - Verify Notify button in Media Check tab
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    And User clicks Auto-screen button to ON
    And Contact's Ongoing Screening "World-Check" is unchecked
    And User creates Associated Party "with mandatory fields"
    Then Associated Party page is loaded
    And Screening results table is loaded
    When User clicks Media Check tab on Screening section
    Then Notify button is invisible in Media Check tab

  @C38146459
  Scenario: C38146459: Third-Party - Associated Individual - Media Check tab - Similar Articles - Verify the Similar Articles and See More was displayed when API return the Duplicates Key isn't null.
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    When User selects "25" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    And Media Check Result Table should contain 25 records
    And Screening results table is loaded
    When The system calls the Media Check Associated IND API without Other Name and 25 records for "Barac" "Obama" to find a Duplicate Key is "not null"
    Then The similar articles and see more label are visible for "associated individual"

  @C38146460
  Scenario: C38146460: Third-Party - Associated Individual - Media Check tab - Similar Articles - Verify the Similar Articles and See More wasn't displayed when API return the Duplicates Key is null.
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    When User selects "25" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    And Media Check Result Table should contain 25 records
    And Screening results table is loaded
    When The system calls the Media Check Associated IND API without Other Name and 25 records for "Barac" "Obama" to find a Duplicate Key is "null"
    Then The similar articles and see more label are invisible for "associated individual"

  @C38146462
  Scenario: C38146462: Third-Party - Associated Individual - Media Check tab - Similar Articles - Verify the similar articles list and the see less label must be displayed when clicking on the see more label.
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    When User selects "25" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    And Media Check Result Table should contain 25 records
    And Screening results table is loaded
    When The system calls the Media Check Associated IND API without Other Name and 25 records for "Barac" "Obama" to find a Duplicate Key is "not null"
    And  User clicks the see more label
    Then The source name and similar article date are displayed
    When User clicks the see less label
    Then The similar articles and see more label are visible for "associated individual"