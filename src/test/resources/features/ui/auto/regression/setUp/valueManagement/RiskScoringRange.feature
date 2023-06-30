@ui @full_regression @value_management @risk_scoring_range
Feature: Value Management - Risk Scoring Range

  As a RDDC Administrator
  I want see the Risk Scoring Range Configured in the system
  So that I can review the Risk Scoring Range when needed

  Background:
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User opens Value Management page
    And User clicks "Risk Scoring Range" value

  @C36154419
  @tenant2-qa-regression
  Scenario: C36154419: [Value Management Setup] Risk Scoring Range - Risk Scoring Range Overview
    Then Value Management "Risk Scoring Range" overview page is displayed
    And Value Management table displayed with columns
      | VALUE         |
      | SCORING RANGE |
      | DATE CREATED  |
      | LAST UPDATED  |
    And "ADD RISK SCORING RANGE" Value Management Button is displayed
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

  @C36154541
  @tenant2-qa-regression
  Scenario: C36154541: [Value Management Setup] Risk Scoring Range - Check that Edit/Add New Risk Scoring Range modal has correct content and view
    When User clicks Add New button for Value
    Then Add Risk Scoring Range modal contains all expected elements
    When User fills in Value name "toBeReplaced_1"
    And User fills in Risk Scoring Range using API
    And User clicks "Save" Value Management button
    And User clicks Edit button for "toBeReplaced_1" Value Row
    Then Edit Risk Scoring Range modal contains all expected elements

  @C36154613
  @RMS-25534
  @onlySingleThread @tenant2-qa-regression
  Scenario: C36154613: [Value Management Setup] Risk Scoring Range - Add New Risk Scoring Range
    When User clicks Add New button for Value
    And User fills in Value name "toBeReplaced_1"
    And User fills in Risk Scoring Range using API
    And User clicks "Save" Value Management button
    And User clicks Add New button for Value
    Then Add Value Management modal is displayed
    When User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Cannot Save. Please Complete Required Fields |
    And Error message "This field is required" in red color is displayed near Value name input
#    TODO uncomment when RMS-25534 will be fixed(see bug comments)
#    When User fills in Value name "toBeReplaced_1"
#    And User fills in Risk Scoring Range using API
#    And User clicks "Save" Value Management button
#    Then Toast message is displayed with text
#      | Cannot Save. Name already exist |
#    And Error message "Name already exist" in red color is displayed near Value name input
    When User fills in Value name "toBeReplaced_2"
    And User fills in Risk Scoring Ranges from "0" to "5"
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Cannot save. Scoring range already exist and should not overlap with existing record. |
    When User fills in Risk Scoring Range using API
    And User clicks "Save" Value Management button
    And User refreshes page
    Then Value Management "Risk Scoring Range" overview page is displayed
    And Value Management table contains values
      | VALUE          | SCORING RANGE | DATE CREATED | LAST UPDATED |
      | toBeReplaced_2 | From to To    | MM/dd/YYYY   | MM/dd/YYYY   |
    When User clicks Add New button for Value
    And User fills in Value name "toBeReplaced_3"
    And User fills in Risk Scoring Range using API
    And User clicks "Cancel" Value Management button
    And User refreshes page
    Then Value Management "Risk Scoring Range" overview page is displayed
    And Value Management table does not contain values
      | VALUE          | SCORING RANGE | DATE CREATED | LAST UPDATED |
      | toBeReplaced_3 | From to To    | MM/dd/YYYY   | MM/dd/YYYY   |
    When User clicks Add New button for Value
    And User fills in Value name "toBeReplaced_3"
    And User fills in Risk Scoring Ranges from "5.1" to "5.2"
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Cannot save. Value should be between 0 to 5.0 |
    And Value field validation message "Please input valid data" is displayed

  @C36154682
  @RMS-25534
  @onlySingleThread @tenant2-qa-regression
  Scenario: C36154682: [Value Management Setup] Risk Scoring Range - Edit Risk Scoring Range
    When User clicks Add New button for Value
    And User fills in Value name "toBeReplaced_1"
    And User fills in Risk Scoring Range using API
    And User clicks "Save" Value Management button
    And User clicks Edit button for "toBeReplaced_1" Value Row
    And User fills in Value name ""
    And User fills in Risk Scoring Ranges from "" to ""
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Cannot Save. Please Complete Required Fields |
    And Error message "This field is required" in red color is displayed near Value name input
#    TODO uncomment when RMS-25534 will be fixed(see bug comments)
#    When User fills in Value name "toBeReplaced_2"
#    And User clicks "Save" Value Management button
#    Then Toast message is displayed with text
#      | Cannot Save. Name already exist |
#    And Error message "Name already exist" in red color is displayed near Value name input
    When User fills in Value name "toBeReplaced_3"
    And User fills in Risk Scoring Ranges from "0" to "5"
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Cannot save. Scoring range already exist and should not overlap with existing record. |
    When User fills in Risk Scoring Range using API
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Success!                            |
      | Risk Scoring Range has been updated |
    And User refreshes page
    And Value Management table contains values
      | VALUE          | SCORING RANGE | DATE CREATED | LAST UPDATED |
      | toBeReplaced_3 | From to To    | MM/dd/YYYY   | MM/dd/YYYY   |
    When User clicks Edit button for "toBeReplaced_3" Value Row
    And User fills in Value name "toBeReplaced_4"
    And User fills in Risk Scoring Range using API
    And User clicks "Cancel" Value Management button
    Then Value Management "Risk Scoring Range" overview page is displayed
    And Value Management table does not contain values
      | VALUE          | SCORING RANGE | DATE CREATED | LAST UPDATED |
      | toBeReplaced_4 | From to To    | MM/dd/YYYY   | MM/dd/YYYY   |
    When User clicks Edit button for "toBeReplaced_3" Value Row
    And User fills in Risk Scoring Ranges from "5.1" to "5.2"
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Cannot save. Value should be between 0 to 5.0 |
    And Value field validation message "Please input valid data" is displayed

  @C36154839
  @onlySingleThread @tenant2-qa-regression
  Scenario: C36154839: [Value Management Setup] Risk Scoring Range - Delete Risk Scoring Range
    When User clicks Add New button for Value
    And User fills in Value name "toBeReplaced_1"
    And User fills in Risk Scoring Range using API
    And User clicks "Save" Value Management button
    And User clicks Delete button for "toBeReplaced_1" Value Row
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this risk scoring range? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Value with name "toBeReplaced_1" is displayed
    When User clicks Delete button for "toBeReplaced_1" Value Row
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Risk Scoring Range has been deleted |
    And Value with name "toBeReplaced_1" is invisible

  @C36155825
  @onlySingleThread @tenant2-qa-regression
  Scenario: C36155825: [Value Management Setup] Risk Scoring Range - Risk Scoring Range Overview pagination
    Then Value Management message "NO AVAILABLE DATA" is displayed if table is empty
    And Pagination elements are disabled if table contains less than 10 rows
    When User creates 5 Risk Scoring Range values with name "toBeReplaced_"
    Then Pagination option "10" is selected
    And Table displayed with up to 10 "Risk Scoring Range" for first page
    And Pagination buttons should be visible
      | first | previous | next | last |
    When User selects "10" items per page
    And User clicks Value Management "Value" column
    Then Table displayed with up to 10 "Risk Scoring Range" for first page
    And Value Management table is sorted by "Value" field in "ASC" order