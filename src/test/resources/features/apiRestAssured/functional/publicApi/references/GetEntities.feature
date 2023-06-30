@api_rest_assured @references
Feature: References - Get Entity List

  As a developer,
  I want to retrieve Entity via API.
  So that I will use it as a reference for Bulk process.

  @C37786813
  Scenario: C37786813: Public API - Retrieve Entity as reference
    When User sends "no parameters" Get request for References Entities endpoint
    Then Response "no parameters" status code is 200
    And References Entities endpoint "no parameters" response contains expected "Success References" data