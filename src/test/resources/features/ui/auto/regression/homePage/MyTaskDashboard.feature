@ui @full_regression @react @dashboard
Feature: Home Page - My Task Dashboard

  As a user,
  I want to see a Dashboard in React.
  So that it will comply with Refinitiv policy.

  Background:
    Given User logs into RDDC as "Admin"

  @C46712115
  Scenario: C46712115: THIRD-PARTY METRICS tab routing is correct
    When User selects Third-party Metrics Tab
    Then Current URL contains endpoint "/ui/home/thirdparty-metrics"

  @C46712116
  Scenario: C46712116: ACTIVITY METRICS tab routing is correct
    When User selects Activity Metrics Tab
    Then Current URL contains endpoint "/ui/home/activity-metrics"

  @C46712117
  Scenario: C46712117: MY TASKS tab routing is correct
    When User selects Third-party Metrics Tab
    And User selects My Tasks tab
    Then Current URL contains endpoint "/ui/home/"
    And My Tasks tabs is displayed with the following widget
      | ASSIGNED ACTIVITIES         |
      | ITEMS TO APPROVE            |
      | ITEMS TO REVIEW             |
      | THIRD-PARTY FOR RENEWAL     |
      | DUE DILIGENCE ORDERS        |
      | PENDING ORDERS FOR APPROVAL |
