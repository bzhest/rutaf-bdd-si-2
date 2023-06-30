@ui @full_regression @value_management @activity_type
Feature: Value Management - Activity Type

  As a RDDC Administrator
  I want see the Activity Type Configured in the system
  So that I can review the Activity Type when needed

  Background:
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User opens Value Management page
    And User clicks "Activity Type" value

  @C36155932
  @onlySingleThread
  Scenario: C36155932: [Value Management Setup] Activity Type - Activity Type Overview
    Then Value Management "Activity Type" overview page is displayed
    And Value Management table displayed with columns
      | VALUE        |
      | DATE CREATED |
      | LAST UPDATED |
    And "ADD ACTIVITY TYPE" Value Management Button is displayed
    When User selects "Max" items per page
    And Value Management table is sorted by "Date Created" field in "DESC" order
    When User clicks Value Management "Date Created" column
    Then Value table contains all default values
      | Approve Onboarding                   |
      | Decline Onboarding                   |
      | Assign Questionnaire                 |
      | Order Due Diligence Report           |
      | World Check Ongoing Screening Update |
      | World Check Screening                |
      | BitSight Search                      |
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
    When User clicks Value Management "Date Created" column
    Then For each Value Management record edit button should be displayed except values
      |  |
    And For each Value Management record delete button should be displayed except values
      | Approve Onboarding                   |
      | Decline Onboarding                   |
      | Assign Questionnaire                 |
      | Order Due Diligence Report           |
      | World Check Ongoing Screening Update |
      | World Check Screening                |
      | BitSight Search                      |
    When User clicks value "Activity Type" breadcrumb
    Then Value Management overview page is displayed

  @C36155946
  Scenario: C36155946: [Value Management Setup] Activity Type - Edit/Add New Activity Type - Check that Add New Activity Type modal has correct content and view
    When User clicks Add New button for Value
    Then Add Activity Type modal contains all expected elements
    When User clicks Add button for Value
    Then Value Management Add icon is disabled
    And Value Management Assessment field contains close icon for 1 field
    When User fills in Assessment field on position 1 value "Assessment_1"
    Then Value Management Add icon is enabled
    When User clicks Assessment field on position 1 close icon
    Then Value management Assessment field is invisible
    When User adds 20 Assessment fields with name "Assessment_"
    Then Value Management Add icon is disabled

  @C36156015
  Scenario: C36156015: [Value Management Setup] Activity Type - Add New Activity Type - Check that new Activity Type can be created with Assessments
    When User clicks Add New button for Value
    Then Add Value Management modal is displayed
    When User fills in Value name "toBeReplaced_1"
    And User clicks Add button for Value
    And User fills in Assessment field on position 1 value "Assessment_1"
    And User clicks "Save" Value Management button
    Then Value Management "Activity Type" overview page is displayed
    And Value Management table contains values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_1 | MM/dd/YYYY   | MM/dd/YYYY   |

  @C36155975
  @RMS-25534
  Scenario: C36155975: [Value Management Setup] Activity Type - Add New Activity Type - Check that new Activity Type can be created without Assessments
    When User clicks Add New button for Value
    Then Add Value Management modal is displayed
    When User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Cannot save. Please Complete Required Fields |
    And Error message "This field is required" in red color is displayed near Value name input
#    TODO uncomment when RMS-25534 will be fixed(see bug comments)
#    When User fills in Value name "Approve Onboarding"
#    And User clicks "Save" Value Management button
#    Then Alert Icon is displayed with text
#      | Error!                                                |
#      | Unable to add same 'Approve Onboarding' activity type |
#    And Error message "Approve Onboarding already exist." in red color is displayed near Value name input
    When User fills in Value name "toBeReplaced_1"
    And User clicks "Save" Value Management button
    Then Value Management "Activity Type" overview page is displayed
    And Value Management table contains values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_1 | MM/dd/YYYY   | MM/dd/YYYY   |
    When User clicks Add New button for Value
    And User fills in Value name "toBeReplaced_2"
    And User clicks "Cancel" Value Management button
    Then Value Management "Activity Type" overview page is displayed
    And Value Management table does not contain values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_2 | MM/dd/YYYY   | MM/dd/YYYY   |

  @C36156045
  @RMS-25534
  Scenario: C36156045: [Value Management Setup] Activity Type - Edit Activity Type
    When User clicks Add New button for Value
    And User fills in Value name "toBeReplaced_1"
    And User clicks "Save" Value Management button
    And User clicks Edit button for "toBeReplaced_1" Value Row
    And User fills in Value name ""
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Cannot save. Please Complete Required Fields |
    And Error message "This field is required" in red color is displayed near Value name input
#    TODO uncomment when RMS-25534 will be fixed(see bug comments)
#    When User fills in Value name "Approve Onboarding"
#    And User clicks "Save" Value Management button
#    Then Alert Icon is displayed with text
#      | Error!                                                |
#      | Unable to add same 'Approve Onboarding' activity type |
#    And Error message "Approve Onboarding already exist." in red color is displayed near Value name input
    When User fills in Value name "toBeReplaced_2"
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Success! Activity Type has been updated |
    And Value Management "Activity Type" overview page is displayed
    When User selects "10" items per page
    Then Value Management table contains values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_2 | MM/dd/YYYY   | MM/dd/YYYY   |
    When User clicks Edit button for "toBeReplaced_2" Value Row
    And User fills in Value name "toBeReplaced_3"
    And User clicks "Cancel" Value Management button
    Then Value Management "Activity Type" overview page is displayed
    When User selects "10" items per page
    Then Value Management table does not contain values
      | VALUE          | DATE CREATED | LAST UPDATED |
      | toBeReplaced_3 | MM/dd/YYYY   | MM/dd/YYYY   |

  @C36183321
  Scenario: C36183321: [Value Management Setup] Activity Type - Delete Activity Type
    When User clicks Add New button for Value
    And User fills in Value name "toBeReplaced_1"
    And User clicks "Save" Value Management button
    And User clicks Delete button for "toBeReplaced_1" Value Row
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this activity type? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Value with name "toBeReplaced_1" is displayed
    When User clicks Delete button for "toBeReplaced_1" Value Row
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Activity Type has been deleted |
    When User selects "10" items per page
    Then Value with name "toBeReplaced_1" is invisible
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Onboarding Workflow"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    Then Activity Type drop-down does not contain values
      | toBeReplaced_1 |

  @C36183560
  @onlySingleThread
  Scenario: C36183560: [Value Management Setup] Activity Type - Activity Type Overview pagination
    Then Pagination option "10" is selected
    And Table displayed with up to 10 "Activity Type" for first page
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    And Pagination buttons should be visible
      | first | previous | next | last |
    When User selects "10" items per page
    And User clicks Value Management "Value" column
    Then Table displayed with up to 10 "Activity Type" for first page
    And Value Management table is sorted by "Value" field in "ASC" order
    When User selects "50" items per page
    And User clicks Value Management "Date Created" column
    Then Table displayed with up to 50 "Activity Type" for first page
    And Value Management table is sorted by "Date Created" field in "ASC" order
    When User selects "25" items per page
    And User clicks Value Management "Last Updated" column
    Then Table displayed with up to 25 "Activity Type" for first page
    And Value Management table is sorted by "Last Updated" field in "ASC" order
