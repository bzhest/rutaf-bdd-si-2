@ui @suppliers
Feature: Ad Hoc Activities

  As a Compliance Group User
  I want to be able to create Ad Hoc activities for a Third-Party
  So that I can log additional activities that are not covered in the Onboarding process

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab

  @C35927381
  @core_regression
  Scenario: C35927381: Supplier - Ad Hoc Activities - Add Ad Hoc Activities
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    Then Ad Hoc Activity "ADD ACTIVITY" modal is displayed
    And Risk Management "Cancel" button is displayed
    And Risk Management "Save" button is displayed
    And Next Add Activity modal text input field(s) is(are) required
      | Activity Name |
      | Description   |
    And Next Add Activity modal drop-down(s) is(are) required
      | Activity Type |
      | Due Date      |
      | Status        |
      | Assignee      |
    When User clicks Third-Party Risk Management "Save" button
    Then Error message 'This field is required' is displayed for the next fields
      | Activity Type |
      | Activity Name |
      | Description   |
      | Due Date      |
      | Status        |
      | Assignee      |
    When User fills in "Status" drop-down with "Not Started"
    And User fills in "Activity Type" drop-down with "Assessment"
    And User fills in "Activity Name" field with "toBeReplaced"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Third-Party Risk Management "Back" button
    Then Ad Hoc Activity "ADD ACTIVITY" modal is not displayed
    And Risk Management "Ad Hoc Activity" table shows 'NO AVAILABLE DATA' message
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "Approve Onboarding"
    And User fills in "Activity Name" field with "toBeReplaced"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User clicks Third-Party Risk Management "Back" button
    Then Added Ad Hoc Activity is displayed in Ad Hoc Activity table
    And Email notification "Refinitiv Due Diligence Centre - Activity: %s has been assigned to you" is received by "Assignee" user

  @C35975604
  @core_regression
  Scenario: C35975604: Supplier - Ad Hoc Activities - Assigning Reviewer
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "Approve Onboarding"
    And User fills in "Activity Name" field with "toBeReplaced"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Draft"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User clicks Third-Party Risk Management "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Ad Hoc Activity "ACTIVITY INFORMATION" modal is displayed
    When User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Add" button
    Then Ad Hoc Activity "ACTIVITY INFORMATION" modal is displayed
    And Assigned Reviewer "Admin_AT_FN Admin_AT_LN" is displayed in Reviewers table

  @C35916593
  @full_regression
  Scenario: C35916593: Supplier - Ad Hoc Activities - Check Suppliers without records
    Then Risk Management "ADD ACTIVITY" button is displayed
    And Risk Management "Ad Hoc Activity" table shows 'NO AVAILABLE DATA' message

  @C35927845
  @full_regression
  Scenario: C35927845: Supplier - Ad Hoc Activities - Add Draft Ad Hoc Activities
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    Then Ad Hoc Activity "ADD ACTIVITY" modal is displayed
    And Risk Management "Cancel" button is displayed
    And Risk Management "Save" button is displayed
    And Next Add Activity modal text input field(s) is(are) required
      | Activity Name |
      | Description   |
    And Next Add Activity modal drop-down(s) is(are) required
      | Activity Type |
      | Due Date      |
      | Status        |
      | Assignee      |
    When User clicks Third-Party Risk Management "Save" button
    Then Error message 'This field is required' is displayed for the next fields
      | Activity Type |
      | Activity Name |
      | Description   |
      | Due Date      |
      | Status        |
      | Assignee      |
    When User fills in "Activity Type" drop-down with "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1"
    And User fills in "Activity Name" field with "toBeReplaced"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User fills in "Status" drop-down with "Draft"
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User clicks Third-Party Risk Management "Back" button
    Then Risk Management "Ad Hoc Activity" table shows 'NO AVAILABLE DATA' message
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    Then  Ad Hoc Activity "ADD ACTIVITY" modal is displayed
    When User fills in "Activity Type" drop-down with "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1"
    And User fills in "Activity Name" field with "toBeReplaced"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User fills in "Status" drop-down with "Draft"
    And User clicks Third-Party Risk Management "Save" button
    And User clicks Third-Party Risk Management "Back" button
    Then Added Ad Hoc Activity is displayed in Ad Hoc Activity table
    And Email notification "Refinitiv Due Diligence Centre - Activity: %s has been assigned to you" is not received by "Assignee" user

  @C35936707
  @full_regression
  Scenario: C35936707: Supplier - Ad Hoc Activities - View the details of an Ad Hoc Activities
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    Then Ad Hoc Activity "ADD ACTIVITY" modal is displayed
    When User fills in "Activity Type" drop-down with "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1"
    And User fills in "Activity Name" field with "toBeReplaced"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User fills in "Status" drop-down with "Draft"
    And User clicks Ad Hoc Activity "Save" button
    And User on Activity information page adds comment "Activity comment text N1"
    And User adds Ad Hoc Activity attachment
      | logo.jpg    | Activity description   |
      | racoon1.jpg | Activity description 2 |
    Then Alert Icon is displayed with text
      | Success!                   |
      | Attachment has been saved. |
    When User clicks Ad Hoc Activity "Back" button
    Then Added Ad Hoc Activity is displayed in Ad Hoc Activity table
    And Ad Hoc Activities table contains the following columns
      | NAME               |
      | STATUS             |
      | OVERALL RISK SCORE |
      | INITIATED BY       |
      | START DATE         |
      | LAST UPDATE        |
    And Ad Hoc Activity table sorted by "Start Date" field in "DESC" order
    When User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                        | Activity Name | Description           | Due Date | Status | Assignee                      |
      | AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1 | toBeReplaced  | Auto test Description | TODAY+0  | Draft  | Assignee_AT_FN Assignee_AT_LN |
    And Activity information page Attachment table displays column names
      | FILE NAME   |
      | DESCRIPTION |
      | UPLOAD DATE |
    And Activity information page Attachment table row appears
      | File Name   | Description            | Upload Date |
      | logo.jpg    | Activity description   | TODAY       |
      | racoon1.jpg | Activity description 2 | TODAY       |
    And Activity Information page Attachment table sorted by "Upload Date" in "DESC" order
    And Created comment on Activity Information page is displayed

  @C35942444
  @full_regression
  Scenario: C35942444: Supplier - Ad Hoc Activities - Edit Ad Hoc Activities with Draft status from Ad Hoc Activity List
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    Then Ad Hoc Activity "ADD ACTIVITY" modal is displayed
    When User fills in "Activity Type" drop-down with "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User fills in "Status" drop-down with "Draft"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Ad Hoc Activity "ACTIVITY INFORMATION" modal is displayed
    And User clicks Edit button for Activity
    And Risk Management "Cancel" button is displayed
    And Ad Hoc Activity Information modal fields should be in correct state
      | Activity Type | enabled  |
      | Activity Name | enabled  |
      | Description   | enabled  |
      | Risk Area     | enabled  |
      | Start Date    | disabled |
      | Due Date      | enabled  |
      | Status        | enabled  |
      | Assignee      | enabled  |
    When User clears Activity Information fields
      | Assignee      |
      | Activity Name |
      | Description   |
      | Activity Type |
    And User clicks Ad Hoc Activity "Save" button
    And Error message 'This field is required' is displayed for the next fields
      | Activity Type |
      | Activity Name |
      | Description   |
      | Assignee      |
    When User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    When User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "Auto edited test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User fills in "Status" drop-down with "Draft"
    And User clicks Third-Party Risk Management "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                        | Activity Name           | Description           | Due Date | Status | Assignee                      |
      | AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1 | AUTO_TEST_ACTIVITY_NAME | Auto test Description | TODAY+0  | Draft  | Assignee_AT_FN Assignee_AT_LN |
    When User clicks Edit button for Activity
    Then Risk Management "Cancel" button is displayed
    And Risk Management "Save" button is displayed
    And Ad Hoc Activity "ACTIVITY INFORMATION" modal is displayed
    When User clears Activity Information fields
      | Activity Name |
      | Description   |
      | Activity Type |
    And User clears value for dropdown "Assignee"
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Description" field with "Auto edited test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User fills in "Status" drop-down with "Draft"
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name                  | Description                  | Risk Area | Start Date | Due Date | Status | Assignee                | Last Update |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Auto edited test Description |           |            | TODAY+0  | Draft  | Admin_AT_FN Admin_AT_LN | TODAY+0     |

  @C35942585
  @full_regression
  Scenario: C35942585: Supplier - Ad Hoc Activities - Edit Ad Hoc Activities with Draft status from Activity Information modal
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    Then Ad Hoc Activity "ADD ACTIVITY" modal is displayed
    When User fills in "Activity Type" drop-down with "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User fills in "Status" drop-down with "Draft"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    Then Risk Management "Cancel" button is displayed
    And Risk Management "Save" button is displayed
    And Ad Hoc Activity Information modal fields should be in correct state
      | Activity Type | enabled  |
      | Activity Name | enabled  |
      | Description   | enabled  |
      | Risk Area     | enabled  |
      | Start Date    | disabled |
      | Due Date      | enabled  |
      | Status        | enabled  |
      | Assignee      | enabled  |
    When User clears Activity Information fields
      | Assignee      |
      | Activity Name |
      | Description   |
      | Activity Type |
    And User clicks Third-Party Risk Management "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save.                         |
      | Please complete the required fields. |
    And Error message 'This field is required' is displayed for the next fields
      | Activity Type |
      | Activity Name |
      | Description   |
      | Assignee      |
    When User fills in "Activity Type" drop-down with "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1"
    When User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    When User fills in "Activity Name" field with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Description" field with "Auto edited test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User fills in "Status" drop-down with "Draft"
    And User clicks Third-Party Risk Management "Cancel" button
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                        | Activity Name           | Description           | Due Date | Status | Assignee                      |
      | AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1 | AUTO_TEST_ACTIVITY_NAME | Auto test Description | TODAY+0  | Draft  | Assignee_AT_FN Assignee_AT_LN |
    When User clicks Edit button for Activity
    And User clears Activity Information fields
      | Activity Name |
      | Description   |
      | Activity Type |
      | Status        |
    And User clears value for dropdown "Assignee"
    When User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Description" field with "Auto edited test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User fills in "Status" drop-down with "Draft"
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User clicks on the newly created Ad Hoc Activity with name "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name                  | Description                  | Due Date | Status | Assignee                | Initiated By            | Last Update |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | Auto edited test Description | TODAY+0  | Draft  | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | TODAY+0     |

  @C35953940
  @full_regression
  Scenario: C35953940: Supplier - Ad Hoc Activities - Edit Ad Hoc Activities with NOT Draft status from Activity Information modal
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    Then Ad Hoc Activity "ADD ACTIVITY" modal is displayed
    When User fills in "Activity Type" drop-down with "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User fills in "Status" drop-down with "Not Started"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    Then Risk Management "Cancel" button is displayed
    And Risk Management "Save" button is displayed
    And Ad Hoc Activity Information modal fields should be in correct state
      | Status   | enabled |
      | Assignee | enabled |
    And Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Waiting     |
      | Done        |
    When User clears value for dropdown "Assignee"
    And User clicks Third-Party Risk Management "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                          |
      | Please complete the required fields. |
    And Error message 'This field is required' is displayed for the next fields
      | Assignee |
    When User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User fills in "Status" drop-down with "Done"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                        | Activity Name           | Description           | Risk Area | Start Date | Due Date | Status    | Assignee                | Last Update |
      | AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1 | AUTO_TEST_ACTIVITY_NAME | Auto test Description |           | TODAY+0    | TODAY+0  | Completed | Admin_AT_FN Admin_AT_LN |             |

  @C35975600
  @full_regression
  Scenario: C35975600: Supplier - Ad Hoc Activities - Delete Ad Hoc Activities
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    Then Ad Hoc Activity "ADD ACTIVITY" modal is displayed
    When User fills in "Activity Type" drop-down with "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User fills in "Status" drop-down with "Draft"
    And User clicks Third-Party Risk Management "Save" button
    And User clicks Ad Hoc Activity "Back" button
    When User clicks on Delete button for Ad Hoc Activity with name "AUTO_TEST_ACTIVITY_NAME" in Ad Hoc Activity table
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Activity? |
    And Confirmation button Cancel should be displayed
    And Confirmation button Delete should be displayed
    When User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Risk Management "Ad Hoc Activity" table shows 'NO AVAILABLE DATA' message

  @C35975617
  @full_regression
  Scenario: C35975617: Supplier - Ad Hoc Activities - Edit Reviewer
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    Then Ad Hoc Activity "ADD ACTIVITY" modal is displayed
    When User fills in "Activity Type" drop-down with "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User fills in "Status" drop-down with "Draft"
    And User clicks Ad Hoc Activity Save button
    When User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Add" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    Then Risk Management "Cancel" button is displayed
    And Risk Management "Save" button is displayed
    When User clicks Reviewers edit button for user "Admin_AT_FN Admin_AT_LN"
    And User clears Activity Information fields
      | Reviewer |
    When User clicks Reviewers edit mode Done button
    And Error message 'This field is required' is displayed for the next fields
      | Reviewer |
    When User fills in "Reviewer" drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Third-Party Risk Management "Cancel" button
    Then Ad Hoc Activity "Edit Reviewer" modal is not displayed
    And Ad Hoc Activity "ACTIVITY INFORMATION" modal is displayed
    And Assigned Reviewer "Admin_AT_FN Admin_AT_LN" is displayed in Reviewers table
    When User clicks Reviewers edit button for user "Admin_AT_FN Admin_AT_LN"
    And User fills in "Reviewer" drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Reviewers edit mode Done button
    Then Assigned Reviewer "Assignee_AT_FN Assignee_AT_LN" is displayed in Reviewers table

  @C35975762
  @full_regression
  Scenario: C35975762: Supplier - Ad Hoc Activities - Delete Reviewer
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    Then Ad Hoc Activity "ADD ACTIVITY" modal is displayed
    When User fills in "Activity Type" drop-down with "AUTO_TEST_ASSESSMENT_ACTIVITY_TYPE_1"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User fills in "Status" drop-down with "Draft"
    And User clicks Ad Hoc Activity Save button
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Add" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Reviewers delete button for user "Admin_AT_FN Admin_AT_LN"
    And User clicks Delete button on confirmation window
    Then Reviewers Table is not displayed

  @C35980697
  @full_regression
  Scenario: C35980697: Supplier - Ad Hoc Activities - Review Activity Review
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_REVIEW_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity Save button
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Add" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks Ad Hoc Activity "Save" button
    And User navigates to Home page
    And User clicks Notification Bell
    Then "Activity to Review" notification displayed with text
      | AUTO_TEST_REVIEW_ACTIVITY_NAME |
    When User clicks "Activity to Review" "AUTO_TEST_REVIEW_ACTIVITY_NAME" notification
    Then Activity Information modal is displayed with details
      | Activity Type                  | Activity Name                  | Description           | Due Date | Start Date | Assignee                | Status |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_REVIEW_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | TODAY+0    | Admin_AT_FN Admin_AT_LN | Done   |
    When User clicks "Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name                  | Description           | Start Date | Due Date | Assignee                | Status    | Initiated By            | Last Update |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_REVIEW_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0    | TODAY+0  | Admin_AT_FN Admin_AT_LN | Completed | Admin_AT_FN Admin_AT_LN | TODAY+0     |
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action | Status   |
      | Admin_AT_FN Admin_AT_LN |              |        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Reviewed |

  @C35983373
  @full_regression
  Scenario: C35983373: Supplier - Ad Hoc Activities - Reject Activity Review
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_REJECT_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity Save button
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Add" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks Ad Hoc Activity "Save" button
    And User navigates to Home page
    And User clicks Notification Bell
    Then "Activity to Review" notification displayed with text
      | AUTO_TEST_REJECT_ACTIVITY_NAME |
    When User clicks "Activity to Review" "AUTO_TEST_REJECT_ACTIVITY_NAME" notification
    Then Activity Information modal is displayed with details
      | Activity Type                  | Activity Name                  | Description           | Due Date | Assignee                | Status |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_REJECT_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   |
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Message is displayed on confirmation window
      | Are you sure you want to Reject? This cannot be undone |
    And Confirmation button with name Cancel should be displayed
    And Confirmation button with name Proceed should be displayed
    When User clicks Proceed button on confirmation window
    Then Activity Information modal is displayed with details
      | Activity Type                  | Activity Name                  | Description           | Start Date | Due Date | Assignee                | Status | Initiated By            | Last Update |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_REJECT_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0    | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   | Admin_AT_FN Admin_AT_LN | TODAY+0     |
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action               | Status   |
      | Admin_AT_FN Admin_AT_LN |              |                      | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced | Re-assign for Review | Rejected |

  @C35983672
  @full_regression
  Scenario: C35983672: Supplier - Ad Hoc Activities - Reject Activity-Reassign Review
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_REJECT_REASSIGN_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity Save button
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Add" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks Ad Hoc Activity "Save" button
    And User navigates to Home page
    And User clicks Notification Bell
    Then "Activity to Review" notification displayed with text
      | AUTO_TEST_REJECT_REASSIGN_ACTIVITY_NAME |
    When User clicks "Activity to Review" "AUTO_TEST_REJECT_REASSIGN_ACTIVITY_NAME" notification
    And User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Reject button on confirmation window
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name                           | Description           | Start Date | Due Date | Assignee                | Status | Initiated By            | Last Update |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_REJECT_REASSIGN_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0    | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   | Admin_AT_FN Admin_AT_LN | TODAY+0     |
    When User clicks "Re-assign for Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name                           | Description           | Start Date | Due Date | Assignee                | Status | Initiated By            | Last Update |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_REJECT_REASSIGN_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0    | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   | Admin_AT_FN Admin_AT_LN | TODAY+0     |
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action                 | Status   |
      | Admin_AT_FN Admin_AT_LN |              |                        | Pending  |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |                        | Rejected |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced | Review,Reject,Reassign | Pending  |

  @C35983701
  @full_regression
  Scenario: C35983701: Supplier - Ad Hoc Activities - Reassign Activity Review
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_REASSIGN_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity Save button
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Add" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks Ad Hoc Activity "Save" button
    And User navigates to Home page
    And User clicks Notification Bell
    Then "Activity to Review" notification displayed with text
      | AUTO_TEST_REASSIGN_ACTIVITY_NAME |
    When User clicks "Activity to Review" "AUTO_TEST_REASSIGN_ACTIVITY_NAME" notification
    Then Activity Information modal is displayed with details
      | Activity Type                  | Activity Name                    | Description           | Due Date | Assignee                | Status |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_REASSIGN_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   |
    When User clicks "Reassign" review action button for "Admin_AT_FN Admin_AT_LN" user
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type                  | Activity Name                    | Description           | Start Date | Due Date | Assignee                | Status | Initiated By            | Last Update |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_REASSIGN_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0    | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   | Admin_AT_FN Admin_AT_LN | TODAY+0     |
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action | Status                 |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |        | Pending                |
      |                         |              |        | Pending for Assignment |
    And Activity Information Assigned To drop-down contains only active internal users
    When User selects "Admin_AT_FN Admin_AT_LN" reviewer user
    Then Activity Information modal is displayed with details
      | Activity Type                  | Activity Name                    | Description           | Start Date | Due Date | Assignee                | Status | Initiated By            | Last Update |
      | AUTO_TEST_SIMPLE_ACTIVITY_TYPE | AUTO_TEST_REASSIGN_ACTIVITY_NAME | AUTO_TEST_DESCRIPTION | TODAY+0    | TODAY+0  | Admin_AT_FN Admin_AT_LN | Done   | Admin_AT_FN Admin_AT_LN | TODAY+0     |
    And Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update  | Action                 | Status     |
      | Admin_AT_FN Admin_AT_LN | toBeReplaced |                        | Reassigned |
      | Admin_AT_FN Admin_AT_LN |              | Review,Reject,Reassign | Pending    |
