@ui @smoke @suppliers
Feature: Third-party Information - Edit Third-party

  As a Supplier Integrity User
  I want I want to be able to create new Suppliers
  So that I can process the Suppliers that need to be Onboarded for the Organisation

  @C43652580
  Scenario: C43652580: Third Party Information - Edit Third Party Information
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"
    And User waits for progress bar to disappear from page
    When User clicks General and Other Information section "Edit" button
    And User updates General Information section with values
      | Name                         |
      | AUTO_TEST_EDITED_THIRD_PARTY |
    And User clicks General and Other Information section "Save" button
    Then Third-party Information tab is loaded
    And General Information section details are displayed with populated data
    When User clicks General and Other Information section "Edit" button
    And User updates Third-party Segmentation section with values
      | Spend Category          |
      | Regularly sourcing from |
    And User clicks General and Other Information section "Save" button
    Then Third-party Segmentation section details are displayed with populated data
    When User clicks General and Other Information section "Edit" button
    And User updates Bank Details on position 1 with values
      | Bank Name      |
      | Edit Bank Name |
    And User clicks General and Other Information section "Save" button
    Then Bank Details section details are displayed with populated data on position 1
    When User clicks General and Other Information section "Edit" button
    And User updates Address section with values
      | Address Line      | Region       | Country |
      | Edit Address Line | toBeReplaced |         |
    And User clicks General and Other Information section "Save" button
    Then Address section details are displayed with populated data
    When User clicks General and Other Information section "Edit" button
    And User updates Contact section with values
      | Phone Number |
      | 000000000000 |
    And User clicks General and Other Information section "Save" button
    Then Contact section details are displayed with populated data
    And User can expand "Description" section
    When User clicks General and Other Information section "Edit" button
    And User updates Description section with text "Some text"
    And User clicks General and Other Information section "Save" button
    Then Description section details are displayed with populated data
    When User navigates to Third-party page
    Then User searches third-party with name "AUTO_TEST_EDITED_THIRD_PARTY"
    And Third-party with name "AUTO_TEST_EDITED_THIRD_PARTY" is displayed in Third-party overview table