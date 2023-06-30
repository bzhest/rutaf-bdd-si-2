@ui @full_regression @core_regression @arabica

Feature:  Record Details Page - manage Risk Level of WC1 record

  As a user,
  I want an ability to select Risk Level when changing resolution type.
  So that I can manage Risk Level of WC1 record.

  Background:
    Given User logs into RDDC as "Admin"

  @C39520422 @C39520423 @C39520426 @C39520427
  Scenario: C39520422, C39520423, C39520426, C39520427: Screening - Manage Resolution Type - Screening Result - Verify Risk level and Reason is a mandatory field and the default value is blank
    When User creates third-party "with random ID name"
    And User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    And User selects "positive" resolution in screening detail page
    Then Add Comment modal is displayed
    And "Risk Level" is a mandatory field
    And "Reason" is a mandatory field
    And "Risk Level" value should be empty
    And "Reason" value should be empty
    When User clicks "Save" Add Comment modal button
    Then "Risk Level" dropdown should show "This field is required" message
    And "Reason" dropdown should show "This field is required" message