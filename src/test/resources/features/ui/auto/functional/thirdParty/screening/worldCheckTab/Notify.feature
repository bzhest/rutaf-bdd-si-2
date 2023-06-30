@ui @functional @wc1 @screening_result @suppliers
Feature: Third-party - Screening - World Check Tab - Notify

  As a SI user
  I want populate 'NOTIFY' recipient.
  So that they can receive OGS notifications.

  @C32907034
  Scenario: C32907034: WC - Supplier - Screening Result - Notify - Verify that user should be able to select one or multiple recipient
    Given User logs into RDDC as "Admin"
    When User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"
    Then Screening results table is loaded
    When User adds notification in Add Recipient modal "Assignee_AT_FN"
    Then Alert Icon is displayed with text
      | Success!                                 |
      | Notification Recipient has been updated. |
    When User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with "Assignee_AT_FN Assignee_AT_LN" recipient
    When User clicks 'Cancel' ADD RECIPIENT button
    Then Add recipient modal is disappeared