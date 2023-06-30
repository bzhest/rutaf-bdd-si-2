@ui @suppliers
Feature: Third-party Overview - Searching for third-party

  As a RDDC User
  I want I want to have a way to efficiently search for Third-parties
  So that I can save time from traversing the long list of Third-parties

  Background:
    Given User logs into RDDC as "Admin"

  @C35652325
  @core_regression @thirdPartySearch
  Scenario: C35652325: Search Supplier - verify that user can perform basic search for Third-party on the Third-party tab
    When User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    And Show Drop-Down current option should be "All"
    And Current URL contains "/thirdparty" endpoint
    When User searches third-party with name "SUPPLIER_"
    Then Third-party with name "Supplier_External_User" is displayed in Third-party overview table
    And Current URL contains "/thirdparty" endpoint

  @C35652398
  @full_regression
  @thirdPartySearch
  @onlySingleThread
  Scenario: C35652398: Search Third-party - verify that user can use filtering options on the Third-party tab
    When User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    And Show Drop-Down list is displayed with values
      | All            |
      | My Third-party |
    When User selects "My Third-party" show option
    Then Third-party overview table is displayed with assigned to the user
    And Current URL contains "/thirdparty" endpoint
    When User selects "My Third-party" show option
    And User searches third-party with name "Supplier_For_Edit"
    Then Third-party with name "SUPPLIER_FOR_EDIT_EXTERNAL_USER" is displayed in Third-party overview table
    And Current URL contains "/thirdparty" endpoint
