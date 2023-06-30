@ui @full_regression @react @dashboard
Feature: Home Page - Assigned Activities Widget

  As an RDDC User
  I want a quick view of all the activities assigned to me
  So that I can review the list without going through each Third-party Record

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Home page

  @C46712194
  Scenario: C46712194: "ASSIGNED ACTIVITIES" widget is displayed in the "My task" dashboard
    Then Dashboard "Assigned Activities" widget is enabled
    When User clicks 'Assigned Activities' widget
    Then Dashboard Assigned Activities widget counter displayed with expected count

  @C46712200
  @core_regression
  Scenario: C46712200: Table with assigned activities list is displayed after "ASSIGNED ACTIVITIES" widget is clicked
    When User clicks 'Assigned Activities' widget
    Then Dashboard table name is "ASSIGNED ACTIVITIES"
    And Dashboard Assigned Activities table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |

  @C42686761
  Scenario: C42686761: Table with assigned activities closes after clicking the "ASSIGNED ACTIVITIES" widget
    When User clicks 'Assigned Activities' widget
    Then Dashboard table is displayed
    And Dashboard Assigned Activities widget is in clicked color
    And Dashboard widget chevron is displayed
    When User clicks 'Assigned Activities' widget
    Then Dashboard table is not displayed
    When User hovers over User Menu
    Then Dashboard Assigned Activities widget is not in clicked color
    And Dashboard widget chevron is not displayed
