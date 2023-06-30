@ui @smoke @suppliers
Feature: Third-party Contact - Edit Contact

  As a Supplier Integrity User managing Supplier records
  I want I want to be able to edit the information of a Supplier Contact
  So that I can make changes to the Supplier Contact details when necessary

  @C43652460
  Scenario: C43652460: Third-party - Associated Parties - Update Existing Associated Individual
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "with matched results"
    When User clicks Associated Party's General Information section "Edit" button
    And User updates Associated Party's General Information section with values
      | First Name      | Last Name      |
      | Edit First Name | Edit Last Name |
    And User clicks Associated Party's General Information section "Save" button
    Then Associated Party's General Information section details are displayed with populated data
    When User clicks Associated Party's Address section "Edit" button
    And User updates Associated Party's Address section on position 1 with values
      | Address Line      |
      | Edit Address Line |
    And User clicks Associated Party's Address section "Save" button
    Then Associated Party's Address section details are displayed with populated data
    When User clicks Associated Party's Contact section "Edit" button
    And User updates Associated Party's Contact section with values
      | Email Address    |
      | test@example.com |
    And User clicks Associated Party's Contact section "Save" button
    Then Associated Party's Contact section details are displayed with populated data
    When User clicks Associated Party's Description section "Edit" button
    And User fills in Associated Party's Description text "AUTO_TEST_Description"
    And User clicks Associated Party's Description section "Save" button
    Then Associated Party's Description section is populated with text "AUTO_TEST_Description"