@ui @core_regression @arabica

Feature: Associated Individual Other Names - Screening section - User with/without permission

  As a System Admin,
  I want to limit the access in the Screening section for the user without permission.
  So that I can manage user permission.

  @C39520366
  Scenario: C39520366: Associated Individual other names -  Verify that OGS toggle is hidden for user without Ongoing Screening role permission
    Given User logs into RDDC as "user media check permission off"
    When User creates third-party "with random ID name"
    And User creates Associated Party "with mandatory fields"
    And User creates Other name "contact other name" for Associated Party
    Then Other Name dialog is loaded
    And Other Names OGS Toggle label is hidden
    And Other Names OGS Toggle is hidden

  @C39520363
  Scenario: C39520363: Associated Individual other names -  Verify Risk level/Reason is Tie with permission Resolution type
    Given User logs into RDDC as "user media check permission off"
    When User creates third-party "with random ID name"
    And User creates Associated Party "with mandatory fields"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then Screening result profile details is displayed
    And Screening profile's Resolution is displayed
    And 'Tag as red flag' is turned off
    And Resolution type contains following tooltip text when hover on it
      | Resolution Type : Positive\nYou do not have permission to perform this action. |
      | Resolution Type : Possible\nYou do not have permission to perform this action. |
      | Resolution Type : False\nYou do not have permission to perform this action.    |