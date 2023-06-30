@ui @full_regression @value_management @question_category
Feature: Value Management - Question Category

  As a RDDC Administrator
  I want see the Question Category Configured in the system
  So that I can review the Question Category when needed

  Background:
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Question Category" value

  @C36184240
  Scenario: C36184240: [Value Management Setup] Question Category - Question Category Overview
    Then Value Management "Question Category" overview page is displayed
    And Value Management table displayed with columns
      | VALUE        |
      | DATE CREATED |
      | LAST UPDATED |
    And "ADD QUESTION CATEGORY" Value Management Button is displayed
    And For each Value Management record edit button should be displayed
    And For each Value Management record delete button should be displayed
    And Value Management table is sorted by "Date Created" field in "DESC" order
    When User clicks Value Management "Value" column
    Then Value Management table is sorted by "Value" field in "ACS" order
    When User clicks Value Management "Value" column
    Then Value Management table is sorted by "Value" field in "DESC" order
    When User clicks Value Management "Date Created" column
    Then Value Management table is sorted by "Date Created" field in "ACS" order
    When User clicks Value Management "Date Created" column
    Then Value Management table is sorted by "Date Created" field in "DESC" order
    When User clicks Value Management "Last Updated" column
    Then Value Management table is sorted by "Last Updated" field in "ASC" order
    When User clicks Value Management "Last Updated" column
    Then Value Management table is sorted by "Last Updated" field in "DESC" order
    And Current URL contains "/ui/admin/value-management/" endpoint

  @C36187801
  Scenario: C36187801: [Value Management Setup] Question Category - Add New Question Category
    When User clicks Add New button for Value
    Then Add Value modal contains all expected elements
    When User populates Value Names text area with Names
      | toBeReplaced_1 |
      | toBeReplaced_2 |
    Then Value Management "Save" button is enabled
    When User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Success! Question Category has been added |
    And Value Management "Question Category" overview page is displayed
    And Value Management table contains values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_1 | MM/dd/YYYY   | MM/dd/YYYY   |
      | toBeReplaced_2 | MM/dd/YYYY   | MM/dd/YYYY   |
    When User clicks Add New button for Value
    And User populates Value Names text area with Names
      | toBeReplaced_3 |
      | toBeReplaced_4 |
    And User clicks "Cancel" Value Management button
    Then Value Management "Question Category" overview page is displayed
    And Value Management table does not contain values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_3 | MM/dd/YYYY   | MM/dd/YYYY   |
      | toBeReplaced_4 | MM/dd/YYYY   | MM/dd/YYYY   |

  @C36187817
  @RMS-25534
  Scenario: C36187817: [Value Management Setup] Question Category - Edit Question Category
    When User clicks Add New button for Value
    And User populates Value Names text area with Names
      | toBeReplaced_1 |
      | toBeReplaced_2 |
    And User clicks "Save" Value Management button
    And User clicks Edit button for "toBeReplaced_1" Value Row
    Then Edit Value modal contains all expected elements
    When User fills in Value name ""
    Then Value Management "Save" button is disabled
    And Error message "This field is required" in red color is displayed near Value name input
#    TODO uncomment when RMS-25534 will be fixed(see bug comments)
#    When User fills in Value name "toBeReplaced_2"
#    And User clicks "Save" Value Management button
#    Then Toast message is displayed with text
#      | Cannot save. Name already exist |
#    And Error message "Name already exist" in red color is displayed near Value name input
    When User fills in Value name "toBeReplaced_3"
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Success! Question Category has been updated |
    And Value Management "Question Category" overview page is displayed
    And Value Management table does not contain values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_1 | MM/dd/YYYY   | MM/dd/YYYY   |
    And Value Management table contains values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_3 | MM/dd/YYYY   | MM/dd/YYYY   |
    When User clicks Edit button for "toBeReplaced_3" Value Row
    And User fills in Value name "toBeReplaced_4"
    And User clicks "Cancel" Value Management button
    Then Value Management table does not contain values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_4 | MM/dd/YYYY   | MM/dd/YYYY   |
    And Value Management table contains values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_3 | MM/dd/YYYY   | MM/dd/YYYY   |

  @C36188697
  Scenario: C36188697: [Value Management Setup] Question Category - Delete Question Category
    When User clicks Add New button for Value
    And User populates Value Names text area with Names
      | toBeReplaced_1 |
    And User clicks "Save" Value Management button
    And User clicks Delete button for "toBeReplaced_1" Value Row
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this question category? |
      | This change cannot be undone.                           |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Value with name "toBeReplaced_1" is displayed
    When User clicks Delete button for "toBeReplaced_1" Value Row
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Question Category has been deleted |
    And Value with name "toBeReplaced_1" is invisible

  @C36188770
  @onlySingleThread
  Scenario: C36188770: [Value Management Setup] Question Category - Question Category Overview pagination
    Then Value Management message "NO AVAILABLE DATA" is displayed if table is empty
    And Pagination elements are disabled if table contains less than 10 rows
    When User clicks Add New button for Value
    Then Add Value modal contains all expected elements
    When User populates Value Names text area with Names
      | toBeReplaced_1  |
      | toBeReplaced_2  |
      | toBeReplaced_3  |
      | toBeReplaced_4  |
      | toBeReplaced_5  |
      | toBeReplaced_6  |
      | toBeReplaced_7  |
      | toBeReplaced_8  |
      | toBeReplaced_9  |
      | toBeReplaced_10 |
      | toBeReplaced_11 |
      | toBeReplaced_12 |
      | toBeReplaced_13 |
      | toBeReplaced_14 |
      | toBeReplaced_15 |
      | toBeReplaced_16 |
      | toBeReplaced_17 |
      | toBeReplaced_18 |
      | toBeReplaced_19 |
      | toBeReplaced_20 |
      | toBeReplaced_21 |
      | toBeReplaced_22 |
      | toBeReplaced_23 |
      | toBeReplaced_24 |
      | toBeReplaced_25 |
      | toBeReplaced_26 |
    And User clicks "Save" Value Management button
    Then Pagination option "10" is selected
    And Table displayed with up to 10 "Question Category" for first page
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    And Pagination buttons should be visible
      | first | previous | next | last |
    When User selects "10" items per page
    And User clicks Value Management "Value" column
    Then Table displayed with up to 10 "Question Category" for first page
    And Value Management table is sorted by "Value" field in "ASC" order
    When User selects "50" items per page
    And User clicks Value Management "Date Created" column
    Then Table displayed with up to 50 "Question Category" for first page
    And Value Management table is sorted by "Date Created" field in "ASC" order
    When User selects "25" items per page
    And User clicks Value Management "Last Updated" column
    Then Table displayed with up to 25 "Question Category" for first page
    And Value Management table is sorted by "Last Updated" field in "ASC" order
