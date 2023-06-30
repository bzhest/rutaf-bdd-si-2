@api_rest_assured @references
Feature: References - Get Department List

  As a developer,
  I want to retrieve Department via API.
  So that I will use it as a reference for Bulk process.

  @C37786812
  Scenario: C37786812: Public API - Retrieve Department as reference
    When User sends "no parameters" Get request for References Department endpoint
    Then Response "no parameters" status code is 200
    And References Department endpoint "no parameters" response contains expected "Success References" data