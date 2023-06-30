@ui @postcondition
Feature: Auto-tests Postcondition execution

  @defaultLanguageSetup
  Scenario: Set up default language
    Given User logs into RDDC as "Admin"
    When User sets up default language via API