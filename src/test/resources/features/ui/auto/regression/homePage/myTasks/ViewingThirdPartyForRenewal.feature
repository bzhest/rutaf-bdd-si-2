@ui @core_regression @dashboard
Feature: Dashboard - Viewing Third-party for Renewal

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Workflow Management Renewal Settings page
    Then Renewal Settings page is displayed
    And User clicks "Responsible Party" default assignee radio button
    And User clicks Renewal Settings Save button
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Approve Onboarding Activity"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    When User clicks "NEW COMPONENT" tab
    And User clicks on "Approve Onboarding" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "toBeReplaced" is updated with type "Renewal"
    When User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User navigates to Home page
    Then Home page is loaded

  @C36209485
  Scenario: C36209485: Supplier - Dashboard - View Supplier for Renewal Widget
    When User clicks 'Third-party for Renewal' widget
    And User selects "Max" items per page
    Then Third-party for Renewal widget's counter displays expected count
    And Dashboard Third-party for Renewal table is displayed with column names
      | THIRD-PARTY NAME | STATUS | RESPONSIBLE PARTY | RENEWAL ASSIGNEE | RENEWAL DATE |
    And Third-party for Renewal table contains third-party
      | THIRD-PARTY NAME | STATUS      | RESPONSIBLE PARTY       | RENEWAL ASSIGNEE        | RENEWAL DATE |
      | toBeReplaced     | FOR RENEWAL | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | TODAY+0      |
    When Users clicks first My Tasks table page
    And Users clicks "Status" dashboard table column header
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
    When User clicks 'Third-party for Renewal' widget
    Then Dashboard table is not displayed

  @C36210720
  Scenario: C36210720: Home - My Tasks - Viewing Third-party for Renewal - Change Third-party Status from For Renewal
    When User clicks 'Third-party for Renewal' widget
    And User selects "Max" items per page
    Then Third-party for Renewal table contains third-party
      | THIRD-PARTY NAME | STATUS      | RESPONSIBLE PARTY       | RENEWAL ASSIGNEE        | RENEWAL DATE |
      | toBeReplaced     | FOR RENEWAL | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | TODAY+0      |
    When User clicks on record "Admin_AT_FN Admin_AT_LN" for created third-party
    Then Third-party Information tab is loaded
    And Current URL contains "/thirdparty/" endpoint
    When User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    When User navigates to Home page
    Then Home page is loaded
    When User clicks 'Third-party for Renewal' widget
    Then Third-party for Renewal widget's counter displays expected count
    And Third-party for Renewal table doesn't contain third-party
      | THIRD-PARTY NAME | STATUS      | RESPONSIBLE PARTY       | RENEWAL ASSIGNEE        | RENEWAL DATE |
      | toBeReplaced     | FOR RENEWAL | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | TODAY+0      |
