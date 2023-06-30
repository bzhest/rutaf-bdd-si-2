@ui @full_regression @react @dashboard
Feature: Home Page - Items to Approve Widget

  As an RDDC User
  I want a quick view of all the activities assigned to me for Approval
  So that I can review the list without going through each Third-party Record

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Home page

  @C46712149
  Scenario: C46712149: Items to Approve widget is displayed in the "My task" dashboard
    Then Dashboard "Items To Approve" widget is enabled
    When User clicks 'Items To Approve' widget
    Then Counter for Items to Approve is displayed

  @C46712155
  @core_regression
  Scenario: C46712155: Table with items to approve is displayed after "Items to Approve" widget is clicked
    When User clicks 'Items To Approve' widget
    Then Dashboard table name is "ITEMS TO APPROVE"
    And Dashboard Items To Approve table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |

  @C46712160
  Scenario: C46712160: Pagination is displayed under "Items to Approve" table when user have > 10 orders
    When User clicks 'Items To Approve' widget
    Then Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |

  @C43400887
  Scenario: C43400887: Table "Items to Approve" closes after clicking the widget
    When User clicks 'Items To Approve' widget
    Then Dashboard table is displayed
    And Dashboard Items To Approve widget is in clicked color
    And Dashboard widget chevron is displayed
    When User clicks 'Items To Approve' widget
    Then Dashboard table is not displayed
    When User hovers over User Menu
    Then Dashboard Items To Approve widget is not in clicked color
    And Dashboard widget chevron is not displayed