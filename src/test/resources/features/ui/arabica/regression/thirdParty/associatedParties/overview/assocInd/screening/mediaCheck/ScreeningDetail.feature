@ui @full_regression @core_regression @arabica

Feature: Associated Individual - Media check screening detail

  As a RDDC user
  I want a new tab of media check screening
  So that I can see screening results of the media check records from WC1 in SI

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"

  @C38429325
  Scenario: C38429325: Associated Individual - Verify row per page is correct
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And User should see "Barac Obama" in Media Check Screening Result Table
    And User should see Rows per page label
    And Rows per page dropdown value should be "10"
    And Media Check Result Table should contain 10 records
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