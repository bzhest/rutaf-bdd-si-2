@ui @full_regression @dashboard @dashboardSupplierMetrics
Feature: Activity Metrics - Access

  Background:
    Given User logs into RDDC as "Admin"

  @C36277922
  Scenario: C36277922: [Dashboard enh.] Dashboard Access/Role Setup - Verify that the Dashboard is only visible if the Role of the viewing account has Dashboard set to “YES”
    Then Dashboard of Internal Users is displayed with the following tabs
      | MY TASKS            |
      | THIRD-PARTY METRICS |
      | ACTIVITY METRICS    |
    When User logs into RDDC as "Restricted"
    Then Dashboard of Internal Users is displayed with the following tabs
      | MY TASKS |

  @C36269160
  Scenario: C36269160: [Dashboard enh.] Dashboard Access/Role Setup - Verify under "Reports and Dashboard" the added Dashboard permission and default settings
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When User clicks 'Add New Role' button
    Then Role Management field "Dashboard" toggle button is switched "Off"
    When User clicks Back button on Role form
    And User searches role by "AUTO TEST ROLE WITH RESTRICTIONS" keyword
    And User clicks 'Edit' button on searched role "AUTO TEST ROLE WITH RESTRICTIONS"
    Then Role Management field "Dashboard" toggle button is switched "Off"