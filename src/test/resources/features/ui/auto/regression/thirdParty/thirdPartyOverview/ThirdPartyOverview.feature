@ui @full_regression @suppliers
Feature: Third-party Overview - Viewing Third-parties list

  As a RDDC User
  I want to have a way to check Third-party Overview page
  So that I can be sure of Third-party Overview page correctness


  @C35633454
  @thirdPartySearch
  Scenario: C35633454: Third-party overview - Check that Third-party Overview page has correct content and view
    Given User logs into RDDC as "Admin"
    When User clicks "Third-party" third-party button
    Then Third-party Overview tab is loaded
    And Third-party Overview header "Third-party overview" should be displayed
    And Advanced Search link should be displayed
    And Search text field is displayed
    And Add Third-party button should be displayed
    And Third-party Overview table should be displayed
    And Items per page drop-down should be displayed
    And Show Drop-Down current option should be "All"
    And Current URL contains "/thirdparty" endpoint
    When User searches third-party with name "SUPPLIER_"
    Then Third-party with name "Supplier_External_User" is displayed in Third-party overview table
    And Current URL contains "/thirdparty" endpoint

  @C35630051 @C37557509
  @thirdPartySearch
  @onlySingleThread
  Scenario: C35630051, C37557509: Third-party overview - Check that table with Third-party List has correct structure
    Given User logs into RDDC as "Admin"
    When User navigates to Third-party page
    Then Third-party Table columns are displayed
      | Name                              |
      | Industry Type                     |
      | Country                           |
      | Status                            |
      | Risk Tier                         |
      | Date Created                      |
      | Last Update                       |
      | Screening Status (WC & Custom WL) |
    Then Third-party Overview table displays 10 third-parties sorted by "Date Created" in "DESC" order
    When Users clicks "Name" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Name" in "ASC" order
    When Users clicks "Name" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Name" in "DESC" order
    When Users clicks "Industry Type" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Industry Type" in "ASC" order
    When Users clicks "Industry Type" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Industry Type" in "DESC" order
    When Users clicks "Country" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Country" in "ASC" order
    When Users clicks "Country" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Country" in "DESC" order
    When Users clicks "Status" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Status" in "ASC" order
    When Users clicks "Status" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Status" in "DESC" order
    When Users clicks "Risk Tier" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Risk Tier" in "ASC" order
    When Users clicks "Risk Tier" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Risk Tier" in "DESC" order
    When Users clicks "Date Created" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Date Created" in "ASC" order
    When Users clicks "Date Created" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Date Created" in "DESC" order
    When Users clicks "Last Update" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Last Update" in "ASC" order
    When Users clicks "Last Update" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Last Update" in "DESC" order
    When Users clicks "Screening Status" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Screening Status (WC & Custom WL)" in "ASC" order
    When Users clicks "Screening Status" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Screening Status (WC & Custom WL)" in "DESC" order
    And The Edit button is displayed and enabled for each third-party
    And The Delete button is displayed and enabled for each third-party which could be deleted

  @C35631155
  Scenario: C35631155: Third-party overview - Check that table with Third-party List has correct structure
    Given User logs into RDDC as "Admin"
    When User creates third-party "with Operations division"
    And User navigates to Third-party page
    Then Created third-party is displayed in Third-party overview table
    When User creates third-party "with MyDivision division and Admin double responsible party"
    And User navigates to Third-party page
    Then Created third-party is displayed in Third-party overview table
    When User logs into RDDC as "admin double"
    And User navigates to Third-party page
    Then Created third-party is displayed in Third-party overview table
    And Third-party "with Operations division" does not appear in the Third-party Overview table

  @C37559164
  Scenario: C37559164: Third Party Overview - Verify suppliers list is displayed according to Division or Responsible Party (filter "Show")
    Given User logs into RDDC as "Assignee"
    When User creates third-party "with MyDivision division and Admin double responsible party"
    And User navigates to Third-party page
    Then Show Drop-Down current option should be "All"
    And Show Drop-Down list is displayed with values
      | All            |
      | My Third-party |
    And Third-party "with MyDivision division and Admin double responsible party" does not appear in the Third-party Overview table
    When User selects "My Third-party" show option
    Then Third-party "with MyDivision division and Admin double responsible party" does not appear in the Third-party Overview table
    When User selects "All" show option
    Then Third-party "with MyDivision division and Admin double responsible party" does not appear in the Third-party Overview table
    When User creates third-party "with Operations division and Admin Responsible party"
    And User navigates to Third-party page
    Then Created third-party is displayed in Third-party overview table
    When User selects "My Third-party" show option
    Then Third-party "with Operations division and Admin Responsible party" does not appear in the Third-party Overview table
    When User selects "All" show option
    Then Created third-party is displayed in Third-party overview table
    When User creates third-party "with random ID name"
    And User navigates to Third-party page
    Then Created third-party is displayed in Third-party overview table
    When User selects "My Third-party" show option
    Then Created third-party is displayed in Third-party overview table
    When User selects "All" show option
    Then Created third-party is displayed in Third-party overview table

  @C37559293
  Scenario: C37559293: Third Party Overview - Verify Add Thirt Party button according to user permissions
    Given User logs into RDDC as "Admin"
    When User navigates to Third-party page
    Then Add Third-party button should be displayed
    When User clicks Log Out button
    And User logs into RDDC as "Restricted"
    And User navigates to Third-party page
    Then Add Third-party button should be invisible

  @C37580698
  @onlySingleThread
  Scenario: C37580698: Third Party Overview - Verify Third Party pagination
    Given User logs into RDDC as "Admin"
    When User navigates to Third-party page
    Then Pagination option "10" is selected if pagination is displayed
    And Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |
    And Pagination buttons should be visible
      | first | previous | next | last |
    When User searches third-party with name "Auto"
    Then Pagination option "10" is selected
    And Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |
    When User searches third-party with name "Supplier_Internal_User"
    Then Pagination option "10" is selected
    And Pagination elements are disabled if table contains less than 10 rows
    When User searches third-party with name "Auto"
    And User selects "25" items per page
    Then Pagination option "25" is selected
    When User selects "50" items per page
    Then Table displayed with up to "50" rows
    When User selects "10" items per page
    Then Table displayed with up to "10" rows
    When User searches third-party with name ""
    And User clicks "Third-parties" "last" pagination element
    Then Results "Third-parties" for current page is displayed
    When User clicks "Third-parties" "first" pagination element
    Then Results "Third-parties" for current page is displayed
    When User clicks "Third-parties" "next" pagination element
    Then Results "Third-parties" for current page is displayed
    When User clicks "Third-parties" "previous" pagination element
    Then Results "Third-parties" for current page is displayed
