@api_rest_assured @references
Feature: References - Get Workflow Groups List

  As a user,
  I want an ability to retrieve Workflow Group via Public API.
  So that I can use the information to add/update third-party's workflow group via Public API.

  @C37572227
  Scenario: C37572227: Public API - Verify Get Workflow Group
    When User sends "no parameters" Get request for References Workflow Group endpoint
    Then Response "no parameters" status code is 200
    And References Workflow Group endpoint "no parameters" response contains expected "Success References" data
    When User sends "invalid parameters" Get request for References Workflow Group endpoint with parameters
      | invalid | false |
    Then Response "invalid parameters" status code is 200
    And References Workflow Group endpoint "invalid parameters" response contains expected "no parameters" data

  @C39066315
  @ui
  Scenario: C39066315: Public API - /references/workflowgroups endpoint - Exclude Deleted records
    Given User logs into RDDC as "Admin"
    And User creates "Active" workflow group with random name via API
    When User sends "no parameters" Get request for References Workflow Group endpoint
    Then Response "no parameters" status code is 200
    And References Workflow Group endpoint "no parameters" response contains created group
    When User navigates to 'Workflow Management' block 'Groups' section
    And User clicks the Delete icon for created workflow group
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    When User sends "no parameters" Get request for References Workflow Group endpoint
    Then Response "no parameters" status code is 200
    And References Workflow Group endpoint "no parameters" response does not contain deleted group
