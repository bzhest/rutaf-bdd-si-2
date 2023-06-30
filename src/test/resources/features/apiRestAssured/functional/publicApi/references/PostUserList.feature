@api_rest_assured @references
Feature: References - Post User List

  As a developer,
  I want to retrieve User list as Superior via API.
  So that I will use it as a reference for Bulk process.

  @C37787486
  Scenario: C37787486: Public API - Retrieve User List as reference
    When User sends "Success Empty Filters" Post request for References User List endpoint
    Then Response "Success Empty Filters" status code is 200
    And References User List endpoint "Success Empty Filters" response contains expected data
    When User sends "Success First Name Filter" Post request for References User List endpoint
    Then Response "Success First Name Filter" status code is 200
    And References User List endpoint "Success First Name Filter" response contains filtered data by field value
    When User sends "Success Last Name Filter" Post request for References User List endpoint
    Then Response "Success Last Name Filter" status code is 200
    And References User List endpoint "Success Last Name Filter" response contains filtered data by field value
    When User sends "Success Division Filter" Post request for References User List endpoint
    Then Response "Success Division Filter" status code is 200
    And References User List endpoint "Success Division Filter" response contains filtered Division data by field value