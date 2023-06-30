@ui @core_regression @arabica

Feature: Third-party - Screening section - User with/without permission

  As a System Admin,
  I want to limit the access in the Screening section for the user without permission.
  So that I can manage user permission.

  @C39516057
  Scenario: C39516057: third-Party -  Verify OGS button should be hidden when does not have 'Ongoing Screening' permission
    Given User logs into RDDC as "user media check permission off"
    When User creates third-party "APPLE INVESTMENT COMPANY"
    Then Screening results table is loaded
    And OGS Toggle label as "World-Check & Custom WatchList Ongoing Screening" is hidden
    And OGS Toggle is hidden
    And Screening Bell icon is hidden

  @C39520319
  Scenario: C39520319: third-Party -  Verify Risk level/Reason is Tie with permission Resolution type
    Given User logs into RDDC as "user media check permission off"
    When User creates third-party "APPLE INVESTMENT COMPANY"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Screening profile's Resolution is displayed
    And 'Tag as red flag' is turned off
    And Resolution type contains following tooltip text when hover on it
      | Resolution Type : Positive\nYou do not have permission to perform this action. |
      | Resolution Type : Possible\nYou do not have permission to perform this action. |
      | Resolution Type : False\nYou do not have permission to perform this action.    |