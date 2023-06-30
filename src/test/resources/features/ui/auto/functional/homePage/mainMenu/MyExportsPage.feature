@ui @functional @myExports
Feature: Home Page - Main Menu - My Exports Page

  As an Internal RDDC user,
  I want to see 'My Exports' page
  So that I can view status of exported files and download files I've done


  @C45276627
  Scenario: C45276627: Reports - My Exports page - Table - Data present
    Given User logs into RDDC as "Admin"
    And User navigates to Reports page
    And User selects Report Tab "Activity Report"
    And User clicks Report Export button
    And User clicks export csv file
    When User clicks My Exports option
    Then My Exports table contains columns
      | NAME | START DATE | COMPLETION DATE | DELETION DATE | STATUS | SUMMARY | EXPORT LINK |
    And My Export date columns contains format "MM/dd/uuuu HH:mm"
      | START DATE      |
      | COMPLETION DATE |
      | DELETION DATE   |
    And My Export Status column contains values
      | In Progress |
      | Completed   |
      | Failed      |
    And My Export Summary column contains expected value for status
      | Completed |
      | Failed    |

  @C45274734
  Scenario: C45274734: Reports - My Exports page - Table - No data
    Given User logs into RDDC as "Empty Metrics User"
    When User clicks My Exports option
    Then My Export page contains message "NO AVAILABLE DATA"

  @C45275837
  Scenario: C45275837: Reports - My Exports page - Sorting
    Given User logs into RDDC as "Admin"
    And User navigates to Reports page
    And User selects Report Tab "Activity Report"
    And User clicks Report Export button
    And User clicks export csv file
    And User waits for progress bar to disappear from page
    And User selects Report Tab "THIRD-PARTY REPORT"
    And User clicks Report Export button
    And User clicks export csv file
    When User clicks My Exports option
    Then "My Export" table records sorted by "COMPLETION DATE" column in "DESC" order
    When User clicks My Export table "Name" column
    Then "My Export" table records sorted by "NAME" column in "ASC" order
    When User clicks My Export table "Name" column
    Then "My Export" table records sorted by "NAME" column in "DESC" order
    When User clicks My Export table "Start Date" column
    Then "My Export" table records sorted by "START DATE" column in "ASC" order
    When User clicks My Export table "Start Date" column
    Then "My Export" table records sorted by "START DATE" column in "DESC" order
    When User clicks My Export table "Completion Date" column
    Then "My Export" table records sorted by "COMPLETION DATE" column in "ASC" order
    When User clicks My Export table "Completion Date" column
    Then "My Export" table records sorted by "COMPLETION DATE" column in "DESC" order
    When User clicks My Export table "Deletion Date" column
    Then "My Export" table records sorted by "DELETION DATE" column in "ASC" order
    When User clicks My Export table "Deletion Date" column
    Then "My Export" table records sorted by "DELETION DATE" column in "DESC" order
    When User clicks My Export table "Status" column
    Then "My Export" table records sorted by "STATUS" column in "ASC" order
    When User clicks My Export table "Status" column
    Then "My Export" table records sorted by "STATUS" column in "DESC" order

  @C45276634
  @onlySingleThread
  Scenario: C45276634: Reports - My Exports page - Pagination
    Given User logs into RDDC as "Admin"
    When User clicks My Exports option
    Then Pagination elements are disabled if table contains less than 10 rows
    And Skip further steps if pagination hidden or disabled
    When User clicks "My Exports" "last" pagination element
    Then Results "My Exports" for current page is displayed
    When User clicks "My Exports" "first" pagination element
    Then Results "My Exports" for current page is displayed
    When User clicks "My Exports" "next" pagination element
    Then Results "My Exports" for current page is displayed
    When User clicks "My Exports" "previous" pagination element
    Then Results "My Exports" for current page is displayed
    When User selects "25" items per page or max value
    Then Table displayed with up to "25" rows
    When User selects "10" items per page or max value
    Then Table displayed with up to "10" rows
    When User selects "50" items per page or max value
    Then Table displayed with up to "50" rows

  @C45276628
  Scenario: C45276628: Reports - My Exports page - Download file
    Given User logs into RDDC as "Admin"
    And User navigates to Reports page
    And User selects Report Tab "THIRD-PARTY REPORT"
    And User selects My Third-party show option
    And User clicks export csv file
    When User clicks My Exports option
    Then My Exports table contains file with name "RDDCentre_ThirdParty_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"
    When User clicks file with name "RDDCentre_ThirdParty_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"
    Then ".csv" File with name "RDDCentre_ThirdParty_Report_" and date format "MM_dd_YYYY_HH_mm" downloaded

  @C45276629
  Scenario: C45276629: Reports - My Exports page - Absent for external user
    Given User logs into RDDC as "External"
    Then User menu items are displayed
      | Preferences |
      | Help        |
      | Log Out     |
    When User navigates to My Exports page
    Then Current URL contains "/forbidden" endpoint
    And The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    And Back button is displayed

  @C45309022
  Scenario: C45309022: Reports - My Exports page - Menu My Exports
    Given User logs into RDDC as "Admin"
    When User clicks My Exports option
    Then Current URL contains "/ui/my-exports" endpoint
