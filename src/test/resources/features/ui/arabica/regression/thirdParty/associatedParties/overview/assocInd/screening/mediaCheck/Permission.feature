@ui @core_regression @arabica

Feature: Associated Individual - Screening section - User with/without permission

  As a product owner,
  I want separated permission to make change on risk level
  So that some users without permission cannot mess with the articles' risk level

  @C39795155
  Scenario: C39795155: Associated Individual - Media Check - Screening permission: Enable Screening = "Yes" and Manage Resolution Type = "Yes"
    Given User logs into RDDC as "user media check permission on"
    And User creates third-party "with random ID name"
    And User creates Associated Party "John SMITH"
    Then Associated Party page is loaded
    And Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    And Mark all as reviewed button is displayed
    And Media Resolution is displayed
    When User clicks on Media Check screening record on position 1
    Then Media Resolution on Screening Result is displayed

  @C39795156
  Scenario: C39795156: Associated Individual - Media Check - Screening permission: Enable Screening = "Yes" and Manage Resolution Type = "No"
    Given User logs into RDDC as "user media check permission off"
    And User creates third-party "with random ID name"
    And User creates Associated Party "John SMITH"
    Then Associated Party page is loaded
    And Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    And Mark all as reviewed button is not displayed
    And Media Resolution is not displayed
    When User clicks on Media Check screening record on position 1
    Then Media Resolution on Screening Result is not displayed

  @C39795188
  Scenario: C39795188: Associated Individual - Media Check - Screening permission: Enable Screening = "No" and Manage Resolution Type = "Yes"
    Given User logs into RDDC as "user screening permission off"
    And User creates third-party "with random ID name"
    And User clicks on "Associated Parties" tab on Third-party page
    When User clicks on ADD ASSOCIATED PARTY button
    And User enters Associated Party first name with value "Test_First_Name"
    And User enters Associated Party last name with value "Test_Last_Name"
    And User clicks on Save Associated Party button
    Then Associated Party page is loaded
    And Screening Section is not displayed