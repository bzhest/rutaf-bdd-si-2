@ui @full_regression @core_regression @arabica

Feature: Associated Individual - manage Risk Level of WC1 record

  As a user,
  I want an ability to select Risk Level when changing resolution type.
  So that I can manage Risk Level of WC1 record.

  Background:
    Given User logs into RDDC as "Admin"

  @C35983668 @C35983669 @C35983681 @C35983682
  Scenario: C35983668, C35983669, C35983681, C35983682: Associated Individual - Screening - Manage Resolution Type - Verify Risk Level and Reason is a mandatory field and the default value is blank
    When User creates third-party "with random ID name"
    And User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks resolve "World-Check" screening record for "contact" on position 1 on main screening list as "POSSIBLE" resolution
    Then Add Comment modal is displayed
    And "Risk Level" is a mandatory field
    And "Reason" is a mandatory field
    And "Risk Level" value should be empty
    And "Reason" value should be empty
    When User clicks "Save" Add Comment modal button
    Then "Risk Level" dropdown should show "This field is required" message
    And "Reason" dropdown should show "This field is required" message