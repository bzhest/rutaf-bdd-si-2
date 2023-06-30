@ui @core_regression @arabica

Feature: Third-party - Screening section - User with/without permission

  As a product owner,
  I want separated permission to make change on risk level
  So that some users without permission cannot mess with the articles' risk level

  @C39795116
  Scenario: C39795116: third-Party - Media Check - Screening permission: Enable Screening = "Yes" and Manage Resolution Type = "Yes"
    Given User logs into RDDC as "user media check permission on"
    And User creates third-party "APPLE INVESTMENT COMPANY"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    And Mark all as reviewed button is displayed
    And Media Resolution is displayed
    When User clicks on Media Check screening record on position 1
    Then Media Resolution on Screening Result is displayed

  @C39795117
  Scenario: C39795117: third-Party - Media Check - Screening permission: Enable Screening = "Yes" and Manage Resolution Type = "No"
    Given User logs into RDDC as "user media check permission off"
    And User creates third-party "APPLE INVESTMENT COMPANY"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    And Mark all as reviewed button is not displayed
    And Media Resolution is not displayed
    When User clicks on Media Check screening record on position 1
    Then Media Resolution on Screening Result is not displayed

  @C39795118
  Scenario: C39795118: third-Party - Media Check - Screening permission: Enable Screening = "No" and Manage Resolution Type = "Yes"
    Given User logs into RDDC as "user screening permission off"
    When User creates third-party "APPLE INVESTMENT COMPANY"
    Then Screening Section is not displayed