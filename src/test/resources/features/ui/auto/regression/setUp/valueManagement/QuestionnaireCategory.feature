@ui @full_regression @value_management @questionnaire_category
Feature: Value Management - Questionnaire Category

  As a RDDC Administrator
  I want see the Questionnaire Category Configured in the system
  So that I can review the Questionnaire Category when needed

  Background:
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Questionnaire Category" value

  @C36145499
  Scenario: C36145499: [Value Management Setup] Questionnaire Category - Questionnaire Category Overview
    Then Value Management "Questionnaire Category" overview page is displayed
    And Value Management table displayed with columns
      | VALUE        |
      | DATE CREATED |
      | LAST UPDATED |
    And "ADD QUESTIONNAIRE CATEGORY" Value Management Button is displayed
    And For each Value Management record edit button should be displayed
    And For each Value Management record delete button should be displayed
    Then Value Management table is sorted by "Date Created" field in "DESC" order
    When User clicks Value Management "Value" column
    Then Value Management table is sorted by "Value" field in "ASC" order
    When User clicks Value Management "Value" column
    Then Value Management table is sorted by "Value" field in "DESC" order
    When User clicks Value Management "Date Created" column
    Then Value Management table is sorted by "Date Created" field in "ASC" order
    When User clicks Value Management "Date Created" column
    Then Value Management table is sorted by "Date Created" field in "DESC" order
    When User clicks Value Management "Last Updated" column
    Then Value Management table is sorted by "Last Updated" field in "ASC" order
    When User clicks Value Management "Last Updated" column
    Then Value Management table is sorted by "Last Updated" field in "DESC" order
    And Current URL contains "/ui/admin/value-management/" endpoint

  @C36145855
  Scenario: C36145855: [Value Management Setup] Questionnaire Category - Add New Questionnaire Category
    When User clicks Add New button for Value
    Then Add Value modal contains all expected elements
    When User populates Value Names text area with Names
      | toBeReplaced_1 |
      | toBeReplaced_2 |
    Then Value Management "Save" button is enabled
    When User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Success! Questionnaire Category has been added |
    Then Value Management "Questionnaire Category" overview page is displayed
    When User selects "10" items per page
    Then Value Management table contains values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_1 | MM/dd/YYYY   | MM/dd/YYYY   |
      | toBeReplaced_2 | MM/dd/YYYY   | MM/dd/YYYY   |
    When User clicks Add New button for Value
    And User populates Value Names text area with Names
      | toBeReplaced_3 |
      | toBeReplaced_4 |
    And User clicks "Cancel" Value Management button
    Then Value Management "Questionnaire Category" overview page is displayed
    And Value Management table does not contain values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_3 | MM/dd/YYYY   | MM/dd/YYYY   |
      | toBeReplaced_4 | MM/dd/YYYY   | MM/dd/YYYY   |
    When User navigates to Questionnaire Management page
    And User clicks Add Questionnaire button
    Then Questionnaire Category drop-down contains values
      | toBeReplaced_1 |
      | toBeReplaced_2 |
    And Questionnaire Category drop-down does not contain values
      | toBeReplaced_3 |
      | toBeReplaced_4 |

  @C36146322
  @RMS-25534
  Scenario: C36146322: [Value Management Setup] Questionnaire Category - Edit Questionnaire Category
    When User clicks Add New button for Value
    And User populates Value Names text area with Names
      | toBeReplaced_1 |
      | toBeReplaced_2 |
    And User clicks "Save" Value Management button
    And User clicks Edit button for "toBeReplaced_1" Value Row
    Then Edit Value modal contains all expected elements
    When User fills in Value name ""
    Then Error message "This field is required" in red color is displayed near Value name input
#    TODO uncomment when RMS-25534 will be fixed(see bug comments)
#    When User fills in Value name "toBeReplaced_2"
#    And User clicks "Save" Value Management button
#    Then Toast message is displayed with text
#      | Cannot save. Name already exist |
#    And Error message "Name already exist" in red color is displayed near Value name input
    When User fills in Value name "toBeReplaced_3"
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Success!                                |
      | Questionnaire Category has been updated |
    And Value Management "Questionnaire Category" overview page is displayed
    Then Value Management table does not contain values
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
    When User navigates to Questionnaire Management page
    And User clicks Add Questionnaire button
    Then Questionnaire Category drop-down contains values
      | toBeReplaced_2 |
      | toBeReplaced_3 |
    And Questionnaire Category drop-down does not contain values
      | toBeReplaced_1 |
      | toBeReplaced_4 |

  @C36151524
  Scenario: C36151524: [Value Management Setup] Questionnaire Category - Delete Questionnaire Category
    When User clicks Add New button for Value
    And User populates Value Names text area with Names
      | toBeReplaced_1 |
    And User clicks "Save" Value Management button
    And User clicks Delete button for "toBeReplaced_1" Value Row
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this questionnaire category? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Value with name "toBeReplaced_1" is displayed
    When User clicks Delete button for "toBeReplaced_1" Value Row
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Questionnaire Category has been deleted |
    And Value with name "toBeReplaced_1" is invisible
    When User navigates to Questionnaire Management page
    And User clicks Add Questionnaire button
    Then Questionnaire Category drop-down does not contain values
      | toBeReplaced_1 |

  @C36154312
  @onlySingleThread
  Scenario: C36154312: [Value Management Setup] Questionnaire Category - Questionnaire Category Overview pagination
    Then Pagination elements are disabled if table contains less than 10 rows
    And Value Management message "NO AVAILABLE DATA" is displayed if table is empty
    When User clicks Add New button for Value
    And User populates Value Names text area with Names
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
    And Table displayed with up to 10 "Questionnaire Category" for first page
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    And Pagination buttons should be visible
      | first | previous | next | last |
    When User selects "10" items per page
    And User clicks Value Management "Value" column
    Then Table displayed with up to 10 "Questionnaire Category" for first page
    And Value Management table is sorted by "Value" field in "ASC" order
    When User selects "50" items per page
    And User clicks Value Management "Date Created" column
    Then Table displayed with up to 50 "Questionnaire Category" for first page
    And Value Management table is sorted by "Date Created" field in "ASC" order
    When User selects "25" items per page
    And User clicks Value Management "Last Updated" column
    Then Table displayed with up to 25 "Questionnaire Category" for first page
    And Value Management table is sorted by "Last Updated" field in "ASC" order
