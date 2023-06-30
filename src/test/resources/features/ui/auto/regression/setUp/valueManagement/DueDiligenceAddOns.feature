@ui @full_regression @value_management @due_diligence_add_ons
Feature: Value Management - Due Diligence Add-Ons

  As a RDDC Administrator
  I want see the Due Diligence Add-Ons Configured in the system
  So that I can review the Due Diligence Add-Ons when needed

  Background:
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page
    And User clicks "Due Diligence Add-Ons" value

  @C36214810
  Scenario: C36214810: [Value Management Setup] Due Diligence Report Add-On Overview
    Then Value Management "Due Diligence Add-Ons" overview page is displayed
    And Value Management table displayed with columns
      | VALUE        |
      | DATE CREATED |
      | LAST UPDATED |
    And "ADD DUE DILIGENCE ADD-ON" Value Management Button is displayed
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

  @C36214887
  @RMS-25534
  Scenario: C36214887: [Value Management Setup] DDR Add-On - Add New Active DDR Add-On
    When User clicks Add New button for Value
    And User fills in Value name "toBeReplaced"
    And User clicks Value management active checkbox
    And User clicks "Save" Value Management button
    And User clicks Add New button for Value
    Then Add Value Management modal is displayed
    And Add Add-Ons modal contains all expected elements
    When User fills in Value name ""
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Cannot save. Please Complete Required Fields |
    And Error message "This field is required" in red color is displayed near Value name input
#    TODO uncomment when RMS-25534 will be fixed(see bug comments)
#    When User fills in Value name "toBeReplaced"
#    And User clicks Value management active checkbox
#    And User clicks "Save" Value Management button
#    Then Toast message is displayed with text
#      | Cannot Save               |
#      | Add-on Name already exist |
#    And Error message "toBeReplaced already exist." in red color is displayed near Value name input
    When User fills in Value name "toBeReplaced_1"
    And User clicks Value management active checkbox
    And User clicks "Save" Value Management button
    Then Value Management "Due Diligence Add-Ons" overview page is displayed
    And Value Management table contains values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_1 | MM/dd/YYYY   | MM/dd/YYYY   |
    When User clicks Add New button for Value
    And User fills in Value name "toBeReplaced_2"
    And User clicks Value management active checkbox
    And User clicks "Cancel" Value Management button
    Then Value Management "Due Diligence Add-Ons" overview page is displayed
    And Value Management table does not contain values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_2 | MM/dd/YYYY   | MM/dd/YYYY   |

  @C36215151
  @RMS-25534
  Scenario: C36215151: [Value Management Setup] DDR Add-On - Edit DDR Add-On
    When User clicks Add New button for Value
    And User fills in Value name "toBeReplaced"
    And User clicks Value management active checkbox
    And User clicks "Save" Value Management button
    And User clicks Add New button for Value
    And User fills in Value name "toBeReplaced_1"
    And User clicks Value management active checkbox
    And User clicks "Save" Value Management button
    And User clicks Edit button for "toBeReplaced_1" Value Row
    And User fills in Value name ""
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Cannot save. Please Complete Required Fields |
    Then Error message "This field is required" in red color is displayed near Value name input
#    TODO uncomment when RMS-25534 will be fixed(see bug comments)
#    When User fills in Value name "toBeReplaced"
#    And User clicks "Save" Value Management button
#    Then Toast message is displayed with text
#      | Cannot Save               |
#      | Add-on Name already exist |
#    And Error message "toBeReplaced already exist." in red color is displayed near Value name input
    When User fills in Value name "toBeReplaced_2"
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Success! Due Diligence Add-On has been updated |
    Then Value Management "Due Diligence Add-Ons" overview page is displayed
    And Value Management table contains values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_2 | MM/dd/YYYY   | MM/dd/YYYY   |
    When User clicks Edit button for "toBeReplaced_2" Value Row
    And User fills in Value name "toBeReplaced_3"
    And User clicks "Cancel" Value Management button
    Then Value Management "Due Diligence Add-Ons" overview page is displayed
    And Value Management table does not contain values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_3 | MM/dd/YYYY   | MM/dd/YYYY   |

  @C36215191
  Scenario: C36215191: [Value Management Setup] DDR Add-On - Deactivate DDR Add-On
    When User clicks Add New button for Value
    And User fills in Value name "toBeReplaced"
    And User clicks Value management active checkbox
    And User clicks "Save" Value Management button
    And User clicks Edit button for "toBeReplaced" Value Row
    And User clicks Value management active checkbox
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Success! Due Diligence Add-On has been updated |
    Then Value Management table contains values
      | VALUE        | DATE CREATED | LAST UPDATED |
      | toBeReplaced | MM/dd/YYYY   | MM/dd/YYYY   |

  @C36215619
  @onlySingleThread
  Scenario: C36215619: [Value Management Setup] DDR Add-On - Verify that only Active DDR Add-Ons is displayed on the Due Diligence Reports ordering page
    When User creates third-party "with random ID name" via API and open it
    And User clicks Create Order button
    Then Create Due Diligence Order page is opened
    And Create Order page Additional Add-Ons section should be shown with expected values

  @C36215683
  Scenario: C36215683: [Value Management Setup] DDR Add-On - Delete DDR Add-Ons
    When User clicks Add New button for Value
    And User fills in Value name "toBeReplaced_1"
    And User clicks Value management active checkbox
    And User clicks "Save" Value Management button
    And User clicks Delete button for "toBeReplaced_1" Value Row
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this due diligence add-on? This change cannot be undone |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Value with name "toBeReplaced_1" is displayed
    When User clicks Delete button for "toBeReplaced_1" Value Row
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Due Diligence Add-ons has been deleted |
    And Value with name "toBeReplaced_1" is invisible

  @C36216084
  @onlySingleThread
  Scenario: C36216084: [Value Management Setup] DDR Add-On - DDR Add-On Overview pagination
    When User creates 26 Add-Ons values with name "toBeReplaced_" and on Active checkbox
    Then Pagination option "10" is selected
    And Table displayed with up to 10 "Due Diligence Add-Ons" for first page
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    And Pagination buttons should be visible
      | first | previous | next | last |
    When User selects "10" items per page
    And User clicks Value Management "Value" column
    Then Table displayed with up to 10 "Due Diligence Add-Ons" for first page
    And Value Management table is sorted by "Value" field in "ASC" order
    When User selects "50" items per page
    And User clicks Value Management "Date Created" column
    Then Table displayed with up to 50 "Due Diligence Add-Ons" for first page
    And Value Management table is sorted by "Date Created" field in "ASC" order
    When User selects "25" items per page
    And User clicks Value Management "Last Updated" column
    Then Table displayed with up to 25 "Due Diligence Add-Ons" for first page
    And Value Management table is sorted by "Last Updated" field in "ASC" order
