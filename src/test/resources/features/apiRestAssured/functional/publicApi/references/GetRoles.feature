@api_rest_assured @references
Feature: References - Get Roles List

  As a developer,
  I want to retrieve Role via API.
  So that I will use it as a reference for Bulk process.

  @C37786814
  Scenario: C37786814: Public API - Retrieve Role as reference
    When User sends "no parameters" Get request for References Roles endpoint
    Then Response "no parameters" status code is 200
    And References Roles endpoint "no parameters" response contains expected "Success References" data
    When User sends "invalid parameters" Get request for References Roles endpoint with parameters
      | invalid | false |
    Then Response "invalid parameters" status code is 200
    And References Roles endpoint "invalid parameters" response contains expected "no parameters" data