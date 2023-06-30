@ui @sanity @wc1 @screening_result @suppliers @multilanguage
Feature: Third-party Screening Result - Notify

  As a SI user
  I want populate 'NOTIFY' recipient.
  So that they can receive OGS notifications.

  @C37072698
  Scenario: C37072698: WC - Supplier - Screening Result - Notify - Verify that user should be able to select one or multiple recipient
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User creates third-party "with random ID name" via API and open it
    Then Screening results table is loaded
    When User clicks Screening Bell icon
    And User clicks ADD RECIPIENT modal Recipient drop-down "Open" button
    Then ADD RECIPIENT modal Recipient drop-down contains all Active Internal Users in the System except "Admin" responsible party
    When User clicks 'Cancel' ADD RECIPIENT button
    And User adds notification in Add Recipient modal "Assignee_AT_FN"
    Then Alert Icon is displayed with text
      | <messages.success>                                           |
      | <thirdPartyInformation.screening.notificationUpdatedMessage> |
    When User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with "Assignee_AT_FN Assignee_AT_LN" recipient
    When User clicks 'Cancel' ADD RECIPIENT button
    Then Add recipient modal is disappeared
