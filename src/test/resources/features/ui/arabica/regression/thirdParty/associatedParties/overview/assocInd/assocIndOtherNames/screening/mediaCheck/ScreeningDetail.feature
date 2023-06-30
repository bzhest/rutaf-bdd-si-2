@ui @core_regression @arabica

Feature: Associated Individual Other Names - Media check screening detail

  As a RDDC user
  I want a new tab of media check screening
  So that I can see screening results of the media check records from WC1 in SI

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"

  @C38429329
  Scenario: C38429329: Associated Individual Other Names - Verify row per page is correct
    When User creates Associated Party "Barac Obama"
    And User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then User should see "Barac Obama" in Media Check Screening Result Table
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