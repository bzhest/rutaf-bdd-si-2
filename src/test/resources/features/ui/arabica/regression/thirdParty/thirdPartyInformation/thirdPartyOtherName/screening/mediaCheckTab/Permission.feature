@ui @core_regression @arabica

Feature: Third-party Other Names - Screening section - User with/without permission

  As a product owner,
  I want separated permission to make change on risk level
  So that some users without permission cannot mess with the articles' risk level

  @C39795151
  Scenario: C39795151: third-Party other names - Media Check - Screening permission: Enable Screening = "Yes" and Manage Resolution Type = "Yes"
    Given User logs into RDDC as "user media check permission on"
    And User creates third-party "with random ID name"
    When User fills in Name field value "APPLE INVESTMENT COMPANY"
    And User selects Name type "Doing Business As"
    Then Other Name Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    When User clicks on "Add button"
    And User clicks on Screen Other Name Button for "APPLE INVESTMENT COMPANY" name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    And Mark all as reviewed button is displayed
    And Media Resolution is displayed
    When User clicks on Media Check screening record on position 1
    Then Media Resolution on Screening Result is displayed

  @C39795152
  Scenario: C39795152: third-Party other names - Media Check - Screening permission: Enable Screening = "Yes" and Manage Resolution Type = "No"
    Given User logs into RDDC as "user media check permission off"
    And User creates third-party "with random ID name"
    When User fills in Name field value "APPLE INVESTMENT COMPANY"
    And User selects Name type "Doing Business As"
    Then Other Name Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    When User clicks on "Add button"
    And User clicks on Screen Other Name Button for "APPLE INVESTMENT COMPANY" name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    And Mark all as reviewed button is not displayed
    And Media Resolution is not displayed
    When User clicks on Media Check screening record on position 1
    Then Media Resolution on Screening Result is not displayed

  @C39795153
  Scenario: C39795153: third-Party other names - Media Check - Screening permission: Enable Screening = "No" and Manage Resolution Type = "Yes"/"No"
    Given User logs into RDDC as "user screening permission off"
    And User creates third-party "with random ID name"
    When User fills in Name field value "APPLE INVESTMENT COMPANY"
    And User selects Name type "Doing Business As"
    Then Other Name Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    When User clicks on "Add button"
    Then Screen Other Name Button is not displayed