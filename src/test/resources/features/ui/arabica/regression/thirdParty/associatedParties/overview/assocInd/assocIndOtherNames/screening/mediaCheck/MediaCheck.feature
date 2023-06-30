@ui @full_regression @core_regression @arabica

Feature: Associated Individual Other Names - Media check screening detail

  As a RDDC user
  I want a new tab of media check screening
  So that I can see screening results of the media check records from WC1 in SI

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"

  @C38146465
  Scenario: C38146465: Third-Party - Associated Individual - Other Name - Media Check tab - Similar Articles - Verify the Similar Articles and See More was displayed when API return the Duplicates Key isn't null.
    When User creates Associated Party "John SMITH"
    And User creates Other name "SMITH" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then User should see "SMITH" in Media Check Screening Result Table
    When User selects "25" option from Rows Per Page dropdown list on Other Names
    Then Media Check Other Names Result Table should contain 25 records
    When The system calls the Media Check Associated IND API with Other Name and 25 records for "John" "SMITH" to find a Duplicate Key is "not null"
    Then The similar articles and see more label are visible for "associated individual"

  @C38146468
  Scenario: C38146468: Third-Party - Associated Individual - Other Name - Media Check tab - Similar Articles - Verify the Similar Articles and See More wasn't displayed when API return the Duplicates Key is null.
    When User creates Associated Party "John SMITH"
    And User creates Other name "SMITH" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then User should see "SMITH" in Media Check Screening Result Table
    When User selects "25" option from Rows Per Page dropdown list on Other Names
    Then Media Check Other Names Result Table should contain 25 records
    When The system calls the Media Check Associated IND API with Other Name and 25 records for "John" "SMITH" to find a Duplicate Key is "null"
    Then The similar articles and see more label are invisible for "associated individual"

  @C38146473
  Scenario: C38146473: Third-Party - Associated Individual - Other Name - Media Check tab - Similar Articles - Verify the similar articles list and the see less label must be displayed when clicking on the see more label.
    When User creates Associated Party "John SMITH"
    And User creates Other name "SMITH" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then User should see "SMITH" in Media Check Screening Result Table
    When User selects "25" option from Rows Per Page dropdown list on Other Names
    Then Media Check Other Names Result Table should contain 25 records
    And Other Name dialog is loaded
    When The system calls the Media Check Associated IND API with Other Name and 25 records for "John" "SMITH" to find a Duplicate Key is "not null"
    And  User clicks the see more label
    Then The source name and similar article date are displayed
    When User clicks the see less label
    Then The similar articles and see more label are visible for "associated individual"