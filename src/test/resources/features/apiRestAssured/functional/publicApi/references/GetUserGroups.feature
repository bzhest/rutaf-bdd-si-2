@api_rest_assured @references
Feature: References - Get User Groups List

  As a developer,
  I want to retrieve Group via API.
  So that I will use it as a reference for Bulk process.

  @C37786876
  Scenario: C37786876: Public API - Retrieve User Group as reference
    When User sends "no parameters" Get request for References User Group endpoint
    Then Response "no parameters" status code is 200
    And References User Group endpoint "no parameters" response contains expected "Success References" data