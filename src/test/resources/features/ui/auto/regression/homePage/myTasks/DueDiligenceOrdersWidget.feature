@ui @full_regression @react @dashboard
Feature: Home Page - Due Diligence Orders Widget

  As an Admin or Internal User that has access right
  I Want To display all active Due Diligence Orders in the Dashboard
  So That Client User can easily identify the number of Ongoing Due Diligence Orders request

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Home page

  @C46712118
  Scenario: C46712118: "Due Diligence Orders" widget is displayed in the "My task" dashboard
    Then Dashboard "Due Diligence Orders" widget is enabled
    When User clicks 'Due Diligence Orders' widget
    Then Due Diligence Orders count is as expected for logged in user

  @C46712124
  @core_regression
  Scenario: C46712124: Table with orders is displayed after "Due Diligence Orders" widget is clicked
    When User clicks 'Due Diligence Orders' widget
    Then Dashboard table name is "DUE DILIGENCE ORDERS"
    And Dashboard Due Diligence Orders table is displayed with column names
      | ORDER ID | SCOPE | ORDER DATE | ORDER STATUS | DUE DATE | REQUESTER NAME | APPROVER NAME |

  @C46712135
  Scenario: C46712135: Pagination is displayed under "Due Diligence Orders" table when user have > 10 orders
    When User clicks 'Due Diligence Orders' widget
    Then Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |

  @C42841728
  Scenario: C42841728: Table with orders closes after clicking the "DUE DILIGENCE ORDERS" widget
    When User clicks 'Due Diligence Orders' widget
    Then Dashboard table is displayed
    And Dashboard Due Diligence Orders widget is in clicked color
    And Dashboard widget chevron is displayed
    When User clicks 'Due Diligence Orders' widget
    Then Dashboard table is not displayed
    When User hovers over User Menu
    Then Dashboard Due Diligence Orders widget is not in clicked color
    And Dashboard widget chevron is not displayed
