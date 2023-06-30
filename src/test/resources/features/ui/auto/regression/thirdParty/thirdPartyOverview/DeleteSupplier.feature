@ui @core_regression @suppliers
Feature: Third-party Overview - Delete Third-party

  As a RDDC User
  I want I want to be able to delete Third-party records
  So that I can delete the Third-party that no longer need to be processed in the system

  @C35621668 @C38027282
  Scenario: C35621668, C38027282: Delete Third-party - Confirm Deletion - Verify that Third-party can be deleted
  Delete Third-party : Confirm Deletion: Verify that Third-party can be deleted
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "with matched results"
    And User navigates to Third-party page
    And User deletes third-party saved in context
    Then Third-party "with random ID name" does not appear in the Third-party Overview table
    And Created third-party does not exist
    And Created contact does not exist
    And Current URL contains "/thirdparty" endpoint
    When User creates valid email
    And User creates third-party "with random ID name" via API and open it
    And User navigates to Third-party page
    And User clicks 'Delete' button on created third-party
    And User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Created third-party is displayed in Third-party overview table
    When User clicks on created third-party
    And User creates Associated Party "with valid email"
    And User checks 'Enabled as User' checkbox on contact screen
    And User navigates to Third-party page
    And User deletes third-party saved in context
    Then Third-party "with random ID name" does not appear in the Third-party Overview table
    And Created third-party does not exist
    And Created contact does not exist
    And Current URL contains "/thirdparty" endpoint
    And The case "Third-party" is deleted from WC1
    And The case "Contact" is deleted from WC1

  @C37558005
  Scenario: C37558005: Third Party Overview - Verify Delete option according to user permissions
    Given User logs into RDDC as "Restricted"
    When User navigates to Third-party page
    Then The Delete button is not displayed for each third-party
    When User clicks Log Out button
    And User logs into RDDC as "Admin"
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "with matched results"
    And User navigates to Third-party page
    Then The Delete button is displayed and enabled for each third-party which could be deleted
    When User clicks 'Delete' button on created third-party
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Third-party? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    When User clicks 'Delete' button on created third-party
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Third-party? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Created third-party does not exist
    And Created contact does not exist
