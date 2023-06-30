@ui @core_regression @arabica

Feature: Associated Individual  - Media check screening results

  As a RDDC user
  I want a new tab of media check screening
  So that I can see screening results of the media check records from WC1 in SI

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"

  @C37492937
  Scenario: C37492937: Associated Individual - Verify User should be redirected to the recently view article in the main screening page after navigating back from article detail page
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects "25" option from Rows Per Page dropdown list
    Then Media Check Result Table should contain 25 records
    When User clicks on Media Check screening record on position 13
    Then Screening result profile details is displayed
    When User clicks on third-party back button
    Then Screening results table is loaded
    And "MEDIA CHECK" tab is displayed
    And Rows per page dropdown value should be "25"

  @C42712510
  Scenario: C42712510: Associated Individual - Verify the user should see X Items Selected articles when user navigate back from screening detail page
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    Then Media Check displays 3 items selected
    When User clicks on 3 items selected link
    Then Media Check items selected link Change to "Back to the full list" is displayed
    When User clicks on Media Check screening record on position 2
    Then Screening result profile details is displayed
    When User clicks on third-party back button
    Then Screening results table is loaded
    And Media Check items selected link Change to "Back to the full list" is displayed
    And Media check screening record on position 1 is checked
    And Media check screening record on position 2 is checked
    And Media check screening record on position 3 is checked