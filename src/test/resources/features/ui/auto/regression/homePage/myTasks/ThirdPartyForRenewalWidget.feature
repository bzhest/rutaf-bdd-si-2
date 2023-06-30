@ui @full_regression @react @dashboard
Feature: Home Page - Third-party for Renewal Widget

  As an RDDC User
  I want a quick view of all the third-party assigned for me for renewal
  So that I can review the list without going through each Third-party Record

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Home page

  @C46712164
  Scenario: C46712164: "Third-party for Renewal" widget is displayed in the "My task" dashboard
    Then Dashboard "Third-party for Renewal" widget is enabled
    When User clicks 'Third-party for Renewal' widget
    Then Third-party for Renewal widget's counter displays expected count

  @C46712170
  @core_regression
  Scenario: C46712170: Table with items to approve is displayed after "Third-party for Renewal" widget is clicked
    When User clicks 'Third-party for Renewal' widget
    Then Dashboard table name is "THIRD-PARTY FOR RENEWAL"
    And Dashboard Third-party for Renewal table is displayed with column names
      | THIRD-PARTY NAME | STATUS | RESPONSIBLE PARTY | RENEWAL ASSIGNEE | RENEWAL DATE |

  @C46712175
  Scenario: C46712175: Pagination is displayed under "Third-party for Renewal" table when user have > 10 orders
    When User clicks 'Third-party for Renewal' widget
    Then Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |

  @C43420962
  Scenario: C43420962: Table "Third-party for Renewal" closes after clicking the widget
    When User clicks 'Third-party for Renewal' widget
    Then Dashboard table is displayed
    And Dashboard Third-party for Renewal widget is in clicked color
    And Dashboard widget chevron is displayed
    When User clicks 'Third-party for Renewal' widget
    Then Dashboard table is not displayed
    When User hovers over User Menu
    Then Dashboard Third-party for Renewal widget is not in clicked color
    And Dashboard widget chevron is not displayed
