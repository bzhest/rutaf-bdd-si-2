@api_rest_assured @references
Feature: References - Get Divisions List

  As a user,
  I want an ability to retrieve Division via Public API.
  So that I can use the information to add/update third-party's Division via Public API.

  @C37572228
  Scenario: C37572228: Public API - Verify Get Divisions
    When User sends "no parameters" Get request for References Divisions endpoint
    Then Response "no parameters" status code is 200
    And References Divisions endpoint "no parameters" response contains expected "Success References" data
    When User sends "invalid parameters" Get request for References Divisions endpoint with parameters
      | invalid | false |
    Then Response "invalid parameters" status code is 200
    And References Divisions endpoint "invalid parameters" response contains expected "no parameters" data
