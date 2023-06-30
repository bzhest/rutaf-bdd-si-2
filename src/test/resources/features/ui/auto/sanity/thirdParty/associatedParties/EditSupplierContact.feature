@ui @sanity @contacts @multilanguage
Feature: Edit Supplier Contact

  As a  user,
  I want a feature where I can alter the detail values of a supplier,
  So that I can correct invalid data, add supporting details, complete the suppliers profile information

  @C32988230
  Scenario: C32988230: Third-party - Associated Parties - Update Existing Associated Individual
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "with matched results"
    When User clicks Associated Party's thirdPartyInformation.generalInformation section "Edit" button
    And User updates Associated Party's General Information section with values
      | Title      | First Name      | Last Name      | Middle Name      |
      | Edit Title | Edit First Name | Edit Last Name | Edit Middle Name |
    And User clicks Associated Party's thirdPartyInformation.generalInformation section "Save" button
    Then Alert Icon is displayed with text
      | <messages.success>                            |
      | General Information <messages.hasBeenUpdated> |
    And Associated Party's General Information section details are displayed with populated data
    When User clicks Associated Party's thirdPartyInformation.address section "Edit" button
    And User updates Associated Party's Address section on position 1 with values
      | Address Line      | City      | Zip/Postal Code      | State/Province      | Region       | Country |
      | Edit Address Line | Edit City | Edit Zip/Postal Code | Edit State/Province | toBeReplaced |         |
    And User clicks Associated Party's thirdPartyInformation.address section "Save" button
    Then Alert Icon is displayed with text
      | <messages.success>                |
      | Address <messages.hasBeenUpdated> |
    And Associated Party's Address section details are displayed with populated data
    When User clicks Associated Party's addThirdParty.contactSection section "Edit" button
    And User updates Associated Party's Contact section with values
      | Phone Number | Fax      | Website              | Email Address    |
      | 000000000000 | Edit Fax | www.text-compare.com | test@example.com |
    And User clicks Associated Party's addThirdParty.contactSection section "Save" button
    Then Alert Icon is displayed with text
      | <messages.success>                |
      | Contact <messages.hasBeenUpdated> |
    And Associated Party's Contact section details are displayed with populated data
    When User clicks Associated Party's ddoActivity.description section "Edit" button
    And User fills in Associated Party's Description text "AUTO_TEST_Description"
    And User clicks Associated Party's ddoActivity.description section "Save" button
    Then Alert Icon is displayed with text
      | <messages.success>                     |
      | Description <messages.hasBeenUpdated>  |
    And Associated Party's Description section is populated with text "AUTO_TEST_Description"
    When User clicks Associated Party Overview contact button
    And User clicks on Associated Party with name "Edit First Name"
    Then Associated Party's General Information section details are displayed with populated data
    And Associated Party's Address section details are displayed with populated data
    And Associated Party's Contact section details are displayed with populated data
    And Associated Party's Description section is populated with text "AUTO_TEST_Description"
