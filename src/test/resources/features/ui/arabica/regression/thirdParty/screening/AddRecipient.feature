@ui @full_regression @core_regression @arabica

Feature: Third-party - Screening section - Recipient on notify button

  As a RDDC user
  I want populate 'NOTIFY' recipient.
  So that they can receive OGS notifications.

  Background:
    Given User logs into RDDC as "Admin"
    When User opens third-party creation form

  @C39514906
  Scenario: C39514906: - Screening Section - Verify Recipient on Notify button can't be empty
    When User fills third-party creation form with third-party's test data "with mandatory fields"
    And User expands the add third-party screening criteria accordion if it is collapsed
    Then Notification Recipients "User" is checked
    When User "ADMIN" was assigned to Notification Recipients
    And User submits Third-party creation form
    And Screening results table is loaded
    And User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with "Admin_AT_FN Admin_AT_LN" recipient
    When User removes notification in Add Recipient modal "Admin_AT_FN Admin_AT_LN"
    Then Add recipient ADD button should be disabled
    When User clicks 'Cancel' ADD RECIPIENT button
    Then Add recipient modal is disappeared
    When User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with "Admin_AT_FN Admin_AT_LN" recipient

  @C39514907
  Scenario: C39514907 - Screening Section - Verify Recipient on Notify button is display same user as Notification Recipients on Screening Criteria section when creating third-party
    When User fills third-party creation form with third-party's test data "with mandatory fields"
    And User expands the add third-party screening criteria accordion if it is collapsed
    Then Notification Recipients "User" is checked
    When User "ADMIN" was assigned to Notification Recipients
    And User changes Notification Recipients assignee to "Assignee_AT_FN Assignee_AT_LN"
    And User submits Third-party creation form
    And Screening results table is loaded
    And User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with "Assignee_AT_FN Assignee_AT_LN" recipient

  @C39514908
  Scenario: C39514908 - Screening Section - Verify Recipient on Notify button can add new recipients
    When User fills third-party creation form with third-party's test data "with mandatory fields"
    And User submits Third-party creation form
    Then Screening results table is loaded
    When User adds notification in Add Recipient modal "Assignee_AT_FN"
    Then Alert Icon is displayed with text
      | Success!                                 |
      | Notification Recipient has been updated. |
    When User clicks Screening Bell icon
    Then ADD RECIPIENT modal is displayed with "Assignee_AT_FN Assignee_AT_LN" recipient

  @C39514909
  Scenario: C39514909 - Screening Section - Verify Recipient on Notify button can delete recipients but should have at least 1 user
    When User fills third-party creation form with third-party's test data "with mandatory fields"
    And User submits Third-party creation form
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

  @C39514910
  Scenario: C39514910 - Screening Section - Media check Tab - Verify Notify button in media check tab
    When User fills third-party creation form with third-party's test data "with mandatory fields"
    And User submits Third-party creation form
    And Screening results table is loaded
    And User clicks Media Check tab on Screening section
    Then Notify button is invisible in Media Check tab