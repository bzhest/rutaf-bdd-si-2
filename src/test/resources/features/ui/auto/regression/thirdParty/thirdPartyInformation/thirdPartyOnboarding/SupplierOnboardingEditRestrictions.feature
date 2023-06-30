@ui @full_regression @supplier_onboarding
Feature: Supplier Onboarding - Edit Restrictions

  As a Supplier Integrity User Onboarding a Supplier
  I want to restrict changes in key details about the Supplier while the Supplier is undergoing Onboarding
  So that the integrity of the Supplier information remains the same throughout the Onboarding process

  @C35929537
  Scenario: C35929537 [Suppler Onboarding] Edit Supplier restrictions in "Onboarding" status
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineIndividual"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User clicks 'Edit' button on created third-party
    Then Third-party's element "Start Onboarding" should be shown
    When User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And General and Other Information section is not allowed for editing, as edit icon is disabled
    When User logs into RDDC as "Restricted"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And General and Other Information section is not allowed for editing, as edit icon is disabled