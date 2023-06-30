@ui @robusta @rebranding
Feature: Rebranding - External User Portal

  As a product owner
  I want to replace "Supplier name" to  "Third-party name" in dashboard's activities table of External site
  So that it is aligned with Refinitiv branding for marketing purposes.


  @C37471959
  Scenario: C37471959: External User Portal - check the tabs of the Dashboard
    Given User logs into RDDC as "External"
    Then External User Home tabs is displayed with the following widget
      | OVERDUE ACTIVITIES |
      | DUE WITHIN 5 DAYS  |
      | DUE IN 5+ DAYS     |
    And "Overdue" widget expected activity counter is displayed
    And "Due within 5 days" widget expected activity counter is displayed
    And "Due in 5+ days" widget expected activity counter is displayed
    When User click on "Overdue" widget for External user
    Then My Activities table is displayed
    And My Activities "Overdue" widget column headers are displayed
      | THIRD-PARTY NAME | NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |
    When User click on "Due within 5 days" widget for External user
    Then My Activities table is displayed
    And My Activities "Due within 5 days" widget column headers are displayed
      | THIRD-PARTY NAME | NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |
    When User click on "Due in 5+ days" widget for External user
    Then My Activities table is displayed
    And My Activities "Due in 5+ days" widget column headers are displayed
      | THIRD-PARTY NAME | NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |
