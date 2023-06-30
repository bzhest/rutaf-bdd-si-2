@ui @functional @arabica

Feature: Associated Individual Other Names - Screening section - User with/without permission

  As a product owner,
  I want separated permission to make change on risk level
  So that some users without permission cannot mess with the articles' risk level

  @C39795190
  Scenario: C39795190: Associated Individual other names - Media Check - Screening permission: Enable Screening = "Yes" and Manage Resolution Type = "Yes"
    Given User logs into RDDC as "user media check permission on"
    And User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    Then Associated Party page is loaded
    When User fills in Name field value "John SMITH"
    And User selects Name type "Also Known As"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    And Mark all as reviewed button is displayed
    And Media Resolution is displayed
    When User clicks on media check Other Names screening record on position 1
    Then Media Resolution on Screening Result is displayed

  @C39795191
  Scenario: C39795191: Associated Individual other names - Media Check - Screening permission: Enable Screening = "Yes" and Manage Resolution Type = "No"
    Given User logs into RDDC as "user media check permission off"
    And User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    Then Associated Party page is loaded
    When User fills in Name field value "John SMITH"
    And User selects Name type "Also Known As"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    And Mark all as reviewed button is not displayed
    And Media Resolution is not displayed
    When User clicks on media check Other Names screening record on position 1
    Then Media Resolution on Screening Result is not displayed

  @C39795192
  Scenario: C39795192: Associated Individual other names - Media Check - Screening permission: Enable Screening = "No" and Manage Resolution Type = "Yes"
    Given User logs into RDDC as "user screening permission off"
    And User creates third-party "APPLE INVESTMENT COMPANY"
    And User creates Associated Party "John SMITH"
    Then Associated Party page is loaded
    When User fills in Name field value "John SMITH"
    And User selects Name type "Also Known As"
    And User clicks on "Other Names Add|Save button"
    Then Screen Other Name Button is not displayed