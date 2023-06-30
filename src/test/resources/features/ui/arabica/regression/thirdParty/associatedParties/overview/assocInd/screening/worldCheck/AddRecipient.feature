@ui @full_regression @core_regression @arabica

Feature: Associated Individual - Screening section - Recipient on notify button

  As an RDDC user
  I want populate 'NOTIFY' recipient.
  So that they can receive OGS notifications.

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    And User clicks Auto-screen button to ON

  @C39514970
  Scenario: C39514970 - Associated Individual Page - Screening Section - Verify Recipient on Notify button can't be empty
    When User "ADMIN" was assigned to Notification Recipients
    And User creates Associated Party "with mandatory fields"
    And Screening results table is loaded
    And User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with "Admin_AT_FN Admin_AT_LN" recipient
    When User removes notification in Add Recipient modal "Admin_AT_FN Admin_AT_LN"
    Then Add recipient ADD button should be disabled
    When User clicks 'Cancel' ADD RECIPIENT button
    Then Add recipient modal is disappeared
    When User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with "Admin_AT_FN Admin_AT_LN" recipient

  @C39514971
  Scenario: C39514971 - Associated Individual Page - Screening Section - Verify Recipient on Notify button is display same user as Notification Recipients on Screening Criteria section when creating contact
    When User "ADMIN" was assigned to Notification Recipients
    And User enters Notification Recipients on Screening Criteria Section with value "Assignee_AT_FN Assignee_AT_LN"
    And User creates Associated Party "with mandatory fields"
    And Screening results table is loaded
    And User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with "Assignee_AT_FN Assignee_AT_LN" recipient

  @C39514972
  Scenario: C39514972 - Associated Individual Page - Screening Section - Verify Recipient on Notify button can add new recipients
    When User creates Associated Party "with mandatory fields"
    And Screening results table is loaded
    And User adds notification in Add Recipient modal "Assignee_AT_FN"
    Then Alert Icon is displayed with text
      | Success!                                 |
      | Notification Recipient has been updated. |
    When User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with "Assignee_AT_FN Assignee_AT_LN" recipient

  @C39514973
  Scenario: C39514973 - Associated Individual Page - Screening Section - Verify Recipient on Notify button can delete recipients but should have at least 1 user
    When User creates Associated Party "with mandatory fields"
    And Screening results table is loaded
    And User adds notification in Add Recipient modal "Assignee_AT_FN"
    Then Alert Icon is displayed with text
      | Success!                                 |
      | Notification Recipient has been updated. |
    When User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with "Assignee_AT_FN Assignee_AT_LN" recipient
    When User removes notification in Add Recipient modal "Assignee_AT_FN Assignee_AT_LN"
    Then ADD RECIPIENT modal is not displayed with "Assignee_AT_FN Assignee_AT_LN" recipient
    When User clicks 'Add' ADD RECIPIENT button
    Then Alert Icon is displayed with text
      | Success!                                 |
      | Notification Recipient has been updated. |
    When User clicks Screening Bell icon
    Then ADD RECIPIENT modal is not displayed with "Assignee_AT_FN Assignee_AT_LN" recipient

  @C39514974
  Scenario: C39514974 - Associated Individual Page - Screening Section - Media check - Verify Notify button in media check tab
    When User creates Associated Party "with mandatory fields"
    And Screening results table is loaded
    And User clicks Media Check tab on Screening section
    Then Notify button is invisible in Media Check tab

