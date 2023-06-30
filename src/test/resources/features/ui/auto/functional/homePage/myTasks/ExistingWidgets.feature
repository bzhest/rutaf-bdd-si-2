@ui @functional @dashboard @uiDashboard
Feature: Home/Dashboard - My Tasks

  As a user
  I would like to verify Dashboard test scripts

  Background:
    Given User logs into RDDC as "Admin"

  @C32904530 @C32904538
  Scenario: C32904530, C32904538 : Admin/Internal- Dashboard Items to Approve: Verify that user should see Activity Status: Not Started
    When User clicks 'Items To Approve' widget
    Then Dashboard Items To Approve table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |
    And Status column has "Not Started" status values

  @C32904540
  Scenario: C32904540 : Admin/Internal- Dashboard Items to Approve: From home page selecting Activity
    When User clicks 'Items To Approve' widget
    Then Dashboard Items To Approve table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |
    When User clicks first activity for third-party "Admin"
    And User clicks Back button to return from Activity modal
    Then Third-party Information tab is loaded

  @C32904525
  Scenario: C32904525 : Home - View notifications in Bell icon
    When User clicks Notification Bell
    Then The list with notifications is shown
