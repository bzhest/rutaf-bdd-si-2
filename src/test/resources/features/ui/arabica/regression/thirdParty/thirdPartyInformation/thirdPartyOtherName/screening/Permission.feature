@ui @core_regression @arabica

Feature: Third-party Other Names - Screening section - User with/without permission

  As a System Admin,
  I want to limit the access in the Screening section for the user without permission.
  So that I can manage user permission.

  @C36624225 @C39515050
  Scenario: C36624225, C39515050: third-Party other names -  Verify that OGS toggle is hidden for user without Ongoing Screening role permission
    Given User logs into RDDC as "user media check permission off"
    When User creates third-party "with random ID name"
    And User creates Other name "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH"
    And User opens screening results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" Other name
    Then Other Name dialog is loaded
    And Other Names OGS Toggle label is hidden
    And Other Names OGS Toggle is hidden

  @C39515051
  Scenario: C39515051: Third-party Other Names - Screening icon - Verify This button is tied with screening permission
    Given User logs into RDDC as "user screening permission off"
    When User creates third-party "APPLE INVESTMENT COMPANY"
    Then Screening Section is not displayed
    When User creates Other name "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH"
    Then Icon screening results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" Other name is disappeared

  @C39515007
  Scenario: C39515007: third-Party Other Names -  Verify Risk level/Reason is Tie with permission Resolution type
    Given User logs into RDDC as "user media check permission off"
    When User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Other name "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH"
    And User opens screening results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then Screening result profile details is displayed
    And Screening profile's Resolution is displayed
    And 'Tag as red flag' is turned off
    And Resolution type contains following tooltip text when hover on it
      | Resolution Type : Positive\nYou do not have permission to perform this action. |
      | Resolution Type : Possible\nYou do not have permission to perform this action. |
      | Resolution Type : False\nYou do not have permission to perform this action.    |