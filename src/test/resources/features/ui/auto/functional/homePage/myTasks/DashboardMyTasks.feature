@ui @functional @dashboard @dashboardMyTasks
Feature: Home/Dashboard - Activity Metrics

  As a Reviewer of Questionnaire
  I Want To display the 'Assign Questionnaire' Activity in my dashboard whenever a related questionnaire is assigned to me for review
  So That I can easily access and identify activities that are assigned to me

  Background:
    Given User logs into RDDC as "Admin"

  @C35520339
  Scenario Outline: C35520339: Dashboard - [6 cases] - Verify Pagination Functionalities
    When User selects My Tasks tab
    Then My Tasks tabs is displayed with the following widget
      | ASSIGNED ACTIVITIES         |
      | ITEMS TO APPROVE            |
      | ITEMS TO REVIEW             |
      | THIRD-PARTY FOR RENEWAL     |
      | DUE DILIGENCE ORDERS        |
      | PENDING ORDERS FOR APPROVAL |
    When User clicks '<widgetName>' widget
    And Pagination elements are hidden if table contains less than 10 rows
    When User selects "25" items per page
    Then Table displayed with up to "25" rows
    When User selects "10" items per page
    Then Table displayed with up to "10" rows
    When User selects "50" items per page
    Then Table displayed with up to "50" rows

    Examples:
      | widgetName                  |
      | Assigned Activities         |
      | Items To Approve            |
      | Items To Review             |
      | Third-party for Renewal     |
      | Due Diligence Orders        |
      | Pending Orders For Approval |

  @C35524058 @C41806129 @C41817708 @C41830841 @C41873723 @C41873828 @C41874001
  Scenario Outline: C35524058,C41806129,C41817708,C41830841,C41873723,C41873828,C41874001: My Tasks - [6 cases] - Verify The Colum Headers should be clickable to sort the list in Ascending or Descending order
    When User selects My Tasks tab
    And User clicks '<widgetName>' widget
    Then Dashboard <widgetName> table is displayed with column names
      | THIRD-PARTY NAME | ACTIVITY NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |
    When Users clicks "Status" dashboard table column header
    Then "<widgetName>" table displays records sorted by "Status" in "ASC" order
    When Users clicks "Status" dashboard table column header
    Then "<widgetName>" table displays records sorted by "Status" in "DESC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "<widgetName>" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "<widgetName>" table displays records sorted by "Third-party Name" in "DESC" order
    When Users clicks "Activity Name" dashboard table column header
    Then "<widgetName>" table displays records sorted by "Activity Name" in "ASC" order
    When Users clicks "Activity Name" dashboard table column header
    Then "<widgetName>" table displays records sorted by "Activity Name" in "DESC" order
    When Users clicks "Description" dashboard table column header
    Then "<widgetName>" table displays records sorted by "Description" in "ASC" order
    When Users clicks "Description" dashboard table column header
    Then "<widgetName>" table displays records sorted by "Description" in "DESC" order
    When Users clicks "Due Date" dashboard table column header
    Then "<widgetName>" table displays records sorted by "Due Date" in "ASC" order
    When Users clicks "Due Date" dashboard table column header
    Then "<widgetName>" table displays records sorted by "Due Date" in "DESC" order
    When Users clicks "Assigned To" dashboard table column header
    Then "<widgetName>" table displays records sorted by "Assigned To" in "ASC" order
    When Users clicks "Assigned To" dashboard table column header
    Then "<widgetName>" table displays records sorted by "Assigned To" in "DESC" order

    Examples:
      | widgetName          |
      | Assigned Activities |
      | Items To Approve    |
      | Items To Review     |

  @C35524058
  Scenario: C35524058: My Tasks - Verify The Colum Headers should be clickable to sort the list in Ascending or Descending order - Third-party for Renewal
    When User selects My Tasks tab
    And User clicks 'Third-party for Renewal' widget
    Then Dashboard Third-party for Renewal table is displayed with column names
      | THIRD-PARTY NAME | STATUS | RESPONSIBLE PARTY | RENEWAL ASSIGNEE | RENEWAL DATE |
    When Users clicks "Status" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Status" in "ASC" order
    When Users clicks "Status" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Status" in "DESC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Third-party Name" in "DESC" order
    When Users clicks "Responsible Party" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Responsible Party" in "ASC" order
    When Users clicks "Responsible Party" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Responsible Party" in "DESC" order
    When Users clicks "Renewal Assignee" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Renewal Assignee" in "ASC" order
    When Users clicks "Renewal Assignee" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Renewal Assignee" in "DESC" order
    When Users clicks "Renewal Date" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Renewal Date" in "ASC" order
    When Users clicks "Renewal Date" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Renewal Date" in "DESC" order

  @C35524058
  Scenario: C35524058: My Tasks - Verify The Colum Headers should be clickable to sort the list in Ascending or Descending order - Due Diligence Orders
    When User selects My Tasks tab
    And User clicks 'Due Diligence Orders' widget
    Then Dashboard Due Diligence Orders table is displayed with column names
      | ORDER ID | SCOPE | ORDER DATE | ORDER STATUS | DUE DATE | REQUESTER NAME | APPROVER NAME |
    When Users clicks "Order ID" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order ID" in "ASC" order
    When Users clicks "Order ID" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order ID" in "DESC" order
    When Users clicks "Scope" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Scope" in "ASC" order
    When Users clicks "Scope" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Scope" in "DESC" order
    When Users clicks "Order Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Date" in "ASC" order
    When Users clicks "Order Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Date" in "DESC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Status" in "ASC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Order Status" in "DESC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Due Date" in "ASC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Due Date" in "DESC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Requester Name" in "ASC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Requester Name" in "DESC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Approver Name" in "ASC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Due Diligence Orders" table displays records sorted by "Approver Name" in "DESC" order

  @C35524058
  Scenario: C35524058: My Tasks - Verify The Colum Headers should be clickable to sort the list in Ascending or Descending order - Pending Orders for Approval
    When User selects My Tasks tab
    And User clicks 'Pending Orders For Approval' widget
    Then Dashboard Pending Orders For Approval table is displayed with column names
      | ORDER ID | SCOPE | ORDER DATE | ORDER STATUS | REQUESTER NAME | APPROVER NAME |
    When Users clicks "Order ID" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order ID" in "ASC" order
    When Users clicks "Order ID" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order ID" in "DESC" order
    When Users clicks "Scope" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Scope" in "ASC" order
    When Users clicks "Scope" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Scope" in "DESC" order
    When Users clicks "Order Date" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order Date" in "ASC" order
    When Users clicks "Order Date" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order Date" in "DESC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order Status" in "ASC" order
    When Users clicks "Order Status" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Order Status" in "DESC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Requester Name" in "ASC" order
    When Users clicks "Requester Name" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Requester Name" in "DESC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Approver Name" in "ASC" order
    When Users clicks "Approver Name" dashboard table column header
    Then "Pending Orders For Approval" table displays records sorted by "Approver Name" in "DESC" order

  @C35548268
  Scenario: C35548268: My Tasks - Verify when user clicks widget again the Activity list should disappear
    When User selects My Tasks tab
    And User clicks 'Assigned Activities' widget
    Then Dashboard table is displayed
    When User clicks 'Assigned Activities' widget
    Then Dashboard table is not displayed
    When User clicks 'Items To Approve' widget
    Then Dashboard table is displayed
    When User clicks 'Items To Approve' widget
    Then Dashboard table is not displayed
    When User clicks 'Items To Review' widget
    Then Dashboard table is displayed
    When User clicks 'Items To Review' widget
    Then Dashboard table is not displayed
    When User clicks 'Third-party for Renewal' widget
    Then Dashboard table is displayed
    When User clicks 'Third-party for Renewal' widget
    Then Dashboard table is not displayed
    When User clicks 'Due Diligence Orders' widget
    Then Dashboard table is displayed
    When User clicks 'Due Diligence Orders' widget
    Then Dashboard table is not displayed
    When User clicks 'Pending Orders For Approval' widget
    Then Dashboard table is displayed
    When User clicks 'Pending Orders For Approval' widget
    Then Dashboard table is not displayed