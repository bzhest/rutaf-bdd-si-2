@ui @functional @dashboard
Feature: Home Page - My Tasks - Third-party for Renewal Widget

  As an RDDC User
  I want a quick view of all the third-party assigned for me for renewal
  So that I can review the list without going through each Third-party Record

  @C43420954
  Scenario: C43420954: Third-party for Renewal widget is not clickable when it's counter value is 0
    Given User logs into RDDC as "Empty Metrics User"
    When User hovers over "Third-party for Renewal" widget
    Then My Tasks "Third-party for Renewal" widget is in disabled color
    And Dashboard widget chevron is not displayed
    And Dashboard "Third-party for Renewal" widget is disabled

  @C43420955 @C43420956
  Scenario: C43420955, C43420956: Grey highlight appears when hovering over "Third-party for Renewal" widget with counter value >= 1
  Chevron is displayed when hovering over "Third-party for Renewal" widget with counter value >= 1
    Given User logs into RDDC as "Admin"
    When User navigates to Workflow Management Renewal Settings page
    Then Renewal Settings page is displayed
    When User clicks "Responsible Party" default assignee radio button
    And User clicks Renewal Settings Save button
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Approve Onboarding Activity"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks "NEW COMPONENT" tab
    And User clicks on "Approve Onboarding" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    Then Workflow "toBeReplaced" is updated with type "Renewal"
    When User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User navigates to Home page
    Then Home page is loaded
    When User navigates to Home page
    And User hovers over "Third-party for Renewal" widget
    Then My Tasks "Third-party for Renewal" widget is in disabled color
    And Dashboard widget chevron is displayed

  @C43420957 @C43420958
  Scenario: C43420957, C43420958: Third-party for Renewal widget changes color to blue when clicked
  Chevron appears after "Third-party for Renewal" widget is clicked
    Given User logs into RDDC as "Admin"
    When User clicks 'Third-party for Renewal' widget
    And User hovers over "Assigned Activities" widget
    Then Dashboard Third-party for Renewal widget is in clicked color
    And Dashboard widget chevron is displayed

  @C43420960
  Scenario: C43420960: Table "Third-party for Renewal" is sort by "Renewal Date" column in ascending order by default
    Given User logs into RDDC as "Admin"
    When User clicks 'Third-party for Renewal' widget
    Then "Third-party for Renewal" table displays records sorted by "Renewal Date" in "ACS" order

  @C43420961
  Scenario: C43420961: User is able to sort "Third-party for Renewal" table by clicking column headers
    Given User logs into RDDC as "Admin"
    When User clicks 'Third-party for Renewal' widget
    And Users clicks "Third-party Name" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Third-party Name" in "DESC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Status" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Status" in "ASC" order
    When Users clicks "Status" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Status" in "DESC" order
    When Users clicks "Status" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Status" in "ASC" order
    When Users clicks "Responsible Party" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Responsible Party" in "ASC" order
    When Users clicks "Responsible Party" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Responsible Party" in "DESC" order
    When Users clicks "Responsible Party" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Responsible Party" in "ASC" order
    When Users clicks "Renewal Assignee" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Renewal Assignee" in "ASC" order
    When Users clicks "Renewal Assignee" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Renewal Assignee" in "DESC" order
    When Users clicks "Renewal Assignee" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Renewal Assignee" in "ASC" order
    When Users clicks "Renewal Date" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Renewal Date" in "ASC" order
    When Users clicks "Renewal Date" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Renewal Date" in "DESC" order
    When Users clicks "Renewal Date" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Renewal Date" in "ASC" order

  @C43420963
  Scenario: C43420963: Only one widget can be active at a time
    Given User logs into RDDC as "Admin"
    When User clicks 'Third-party for Renewal' widget
    And User clicks 'Due Diligence Orders' widget
    Then Dashboard Due Diligence Orders widget is in clicked color
    And Dashboard "Due Diligence Orders" widget chevron is displayed
    And Dashboard Third-party for Renewal widget is not in clicked color
    And Dashboard "Third-party for Renewal" widget chevron is not displayed

  @C32904543
  Scenario: C32904543: My Tasks - View new widget "Third Party for Renewal"
    Given User logs into RDDC as "Admin"
    When User clicks 'Third-party for Renewal' widget
    Then Dashboard Third-party for Renewal table is displayed with column names
      | THIRD-PARTY NAME | STATUS | RESPONSIBLE PARTY | RENEWAL ASSIGNEE | RENEWAL DATE |

  @C32904544 @C35548250
  @RMS-31428
    #Bug '@RMS-31428' is fixed but will be deployed only to v2.3.20.0
  Scenario: C32904544, C35548250: My Tasks - Third Party for Renewal -Verify that user should be redirected to Third Party Information page after clicking Third Party
  My Tasks - Third Party for renewal - Verify only Third Party "For Renewal" status should display on this widget
    Given User logs into RDDC as "Admin"
    When User navigates to Workflow Management Renewal Settings page
    Then Renewal Settings page is displayed
    When User clicks "Responsible Party" default assignee radio button
    And User clicks Renewal Settings Save button
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Approve Onboarding Activity"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks "NEW COMPONENT" tab
    And User clicks on "Approve Onboarding" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    Then Workflow "toBeReplaced" is updated with type "Renewal"
    When User refreshes page
    Then Third-party's element "Renew" should be shown
    When User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User navigates to Home page
    Then Home page is loaded
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

  @C42870855
  Scenario: C42870855: [React Migration Phase 2] Internal Users Portal - My Tasks: Third-party for Renewal widget - Apply sorting to all pages
    Given User logs into RDDC as "Admin"
    When User clicks 'Third-party for Renewal' widget
    And Users clicks "Third-party Name" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Third-party Name" in "ASC" order
    When User clicks last page icon
    Then "Third-party for Renewal" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Status" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Status" in "ASC" order
    When User clicks last page icon
    Then "Third-party for Renewal" table displays records sorted by "Status" in "ASC" order
    When Users clicks "Responsible Party" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Responsible Party" in "ASC" order
    When User clicks last page icon
    Then "Third-party for Renewal" table displays records sorted by "Responsible Party" in "ASC" order
    When Users clicks "Renewal Assignee" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Renewal Assignee" in "ASC" order
    When User clicks last page icon
    Then "Third-party for Renewal" table displays records sorted by "Renewal Assignee" in "ASC" order
    When Users clicks "Renewal Date" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Renewal Date" in "ASC" order
    When User clicks last page icon
    Then "Third-party for Renewal" table displays records sorted by "Renewal Date" in "ASC" order
