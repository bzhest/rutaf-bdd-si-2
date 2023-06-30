@ui @functional @review_process
Feature: Set Up - Review Process - Overview

  As an Internal User with appropriate access rights
  I want to have the ability to overview the review processes
  So that I can overview already created review processes


  @C32926233 @C45138576
  Scenario: C32926233, C45138576: Set - Up : Review Process - Overview - Verify that user should see "Review Process" from side bar menu and see Review Process overview page
  (Set Up/Review Process) - Header "REVIEW PROCESS" is displayed on the top of the page
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    Then Setup navigation option "Review Process" is displayed
    When User clicks Setup navigation option "Review Process"
    Then Review Process overview page is displayed

  @C32926285 @C45138578 @C45138581
  Scenario: C32926285, C45138578, C45138581: Set - Up : Review Process - Overview - Verify that user should see Page filter (10,25,50,All) and Pagination if record exceeds to 10
  (Set Up/Review Process) - [Add Review Process] button is displayed on the page
  (Set Up/Review Process) - Pagination is displayed below the table with the list of Review Process setups
    Given User logs into RDDC as "Admin"
    When User creates 11 Review Processes with "Review Process with Activity owner" via API
    And User navigates to Review Process page
    Then Pagination buttons should be visible
      | first page | previous page | next page | last page |
    And Items per page drop-down should be displayed
    And Review Process 'Add Review Process' button is displayed

  @C32926305
  Scenario: C32926305: Set - Up : Review Process - Overview - Verify that user should be able to Add,Edit,Delete Review process from overview page
    Given User logs into RDDC as "Admin"
    When User navigates to Review Process page
    And User clicks 'Add Review Process' button
    Then ADD REVIEW PROCESS Review Process page is displayed
    When User clicks 'Add Review Process' "Cancel" button
    Then Review Process overview page is displayed
    When User clicks "Edit" for first Review Process
    Then Edit Review Process page is displayed
    When User clicks 'Add Review Process' "Cancel" button
    Then Review Process overview page is displayed
    When User clicks "Delete" for first Review Process
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Review Process? This change cannot be undone. |

  @C32926309, @C45138579 @C45138582 @C45138583 @C45138584 @C45138585 @C45138586
  @onlySingleThread
  Scenario: C32926309, C45138579, C45138582, C45138583, C45138584, C45138585, C45138586: Set - Up : Review Process - Overview - Verify that user should see show Filter: All, Recently Added, Active, Inactive
  (Set Up/Review Process) - Filter feature is displayed on the page
  (Set Up/Review Process) - "All" option is default for the filter on the "Review Process" page
  (Set Up/Review Process) - Review Process setups only with "Active" status are displayed when "Active" option is enabled in filter
  (Set Up/Review Process) - Review Process setups only with "Inactive" status are displayed when "Inactive" option is enabled in filter
  (Set Up/Review Process) - All Review Process setups are displayed when "All" option is enabled in filter
  (Set Up/Review Process) - "No match found" is displayed when no results returned by filter
    Given User logs into RDDC as "Admin"
    When User navigates to Review Process page
    And Show Drop-Down current option should be "All"
    And All Review Processes are displayed or empty table
    And Show Drop-Down list is displayed with values
      | All      |
      | Active   |
      | Inactive |
    When User selects "Active" show option
    Then Active Review Processes are displayed or empty table
    When User selects "Inactive" show option
    Then Inactive Review Processes are displayed or empty table

  @C32926315
  @onlySingleThread
  Scenario: C32926315: Set - Up : Review Process - Verify user should see " No Review Process Available" message and Add Review Process button for no available review process
    Given User logs into RDDC as "Admin"
    And User deletes all Review Processes via API
    When User navigates to Review Process page
    Then Review Processes empty table message "NO AVAILABLE DATA" is displayed
    And Review Process 'Add Review Process' button is displayed

  @C32926329
  Scenario: C32926329: Set - Up : Review Process - Verify that user should be able to Delete Review Process
    Given User logs into RDDC as "Admin"
    When User navigates to Review Process page
    And User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User clicks "Delete" for created Review Process
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Review Process? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then User should see created Review Process by name
    When User clicks "Delete" for created Review Process
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Review Process has been deleted. |
    And User should not see created Review Process by "reviewProcessName" name reference

  @C32926336 @C45138577
  Scenario: C32926336, C45138577: Set - Up : Review Process - Overview - Verify that user should see column: Review Process Name, Description and Status in overview page
  (Set Up/Review Process) - Table with the list of review process setups is displayed on the page
    Given User logs into RDDC as "Admin"
    When User navigates to Review Process page
    Then Review Process table is displayed with columns
      | REVIEW PROCESS NAME | DESCRIPTION | STATUS |
    And Review Process table control buttons are displayed for each record

  @C45138580
  Scenario: C45138580: (Set Up/Review Process) - Table with the list of Review Process setups can be sorted by clicking the column headers
    Given User logs into RDDC as "Admin"
    When User creates 11 Review Processes with "Review Process with Activity owner" via API
    And User navigates to Review Process page
    And Users clicks "Review Process Name" column header
    Then Review Process table displays groups sorted by "Review Process Name" in "ASC" order
    When Users clicks "Review Process Name" column header
    Then Review Process table displays groups sorted by "Review Process Name" in "DESC" order
    When Users clicks "Review Process Name" column header
    Then Review Process table displays groups sorted by "Review Process Name" in "ASC" order
    When Users clicks "Description" column header
    Then Review Process table displays groups sorted by "Description" in "ASC" order
    When Users clicks "Description" column header
    Then Review Process table displays groups sorted by "Description" in "DESC" order
    When Users clicks "Description" column header
    Then Review Process table displays groups sorted by "Description" in "ASC" order
    When Users clicks "Status" column header
    Then Review Process table displays groups sorted by "Status" in "ASC" order
    When Users clicks "Status" column header
    Then Review Process table displays groups sorted by "Status" in "DESC" order
    When Users clicks "Status" column header
    Then Review Process table displays groups sorted by "Status" in "ASC" order
