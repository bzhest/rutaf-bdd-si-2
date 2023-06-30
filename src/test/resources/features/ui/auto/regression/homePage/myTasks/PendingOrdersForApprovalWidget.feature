@ui @full_regression @react @dashboard
Feature: Home Page - Pending Orders for Approval

  As an Admin or Internal User that has access right
  I want to display all active Due Diligence Order Request that requires my approval in the Dashboard
  So that Approver can easily see in the dashboard

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Home page

  @C46712179
  Scenario: C46712179: "Pending Orders for Approval" widget is displayed in the "My task" dashboard
    Then Dashboard "Pending Orders for Approval" widget is enabled
    When User clicks 'Pending Orders For Approval' widget
    Then Counter for Pending Orders For Approval is displayed

  @C46712185
  @core_regression
  Scenario: C46712185: Table with items to approve is displayed after "Pending Orders for Approval" widget is clicked
    When User clicks 'Pending Orders For Approval' widget
    Then Dashboard table name is "PENDING ORDERS FOR APPROVAL"
    And Dashboard Pending Orders For Approval table is displayed with column names
      | ORDER ID | SCOPE | ORDER DATE | ORDER STATUS | REQUESTER NAME | APPROVER NAME |

  @C46712190
  Scenario: C46712190: Pagination is displayed under "Pending Orders for Approval" table when user have > 10 orders
    When User clicks 'Pending Orders For Approval' widget
    Then Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |

  @C43428550
  Scenario: C43428550: Table "Pending Orders for Approval" closes after clicking the widget
    When User clicks 'Pending Orders For Approval' widget
    Then Dashboard table is displayed
    And Dashboard Pending Orders for Approval widget is in clicked color
    And Dashboard widget chevron is displayed
    When User clicks 'Pending Orders For Approval' widget
    Then Dashboard table is not displayed
    When User hovers over User Menu
    Then Dashboard Pending Orders for Approval widget is not in clicked color
    And Dashboard widget chevron is not displayed

