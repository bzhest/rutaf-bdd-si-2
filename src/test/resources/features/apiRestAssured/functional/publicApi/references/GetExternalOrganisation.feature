@api_rest_assured @references
Feature: References - Get External Organizations List

  As a developer,
  I want to retrieve External Organization via API.
  So that I will use it as a reference for Bulk process

  @C37786811
  Scenario: C37786811: Public API - Retrieve External Organization as reference
    When User sends "no parameters" Get request for References External Organisation endpoint
    Then Response "no parameters" status code is 200
    And References External Organisation endpoint "no parameters" response contains expected "Success References" data