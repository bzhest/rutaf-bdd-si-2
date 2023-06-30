@ui @full_regression @core_regression @adhoc_activity @react

Feature: Add Screening Criteria to add/edit Contacts

  As a SI user
  I want to verify access to Adhoc activity depending on user Roles
  So that User with different accesses should see correspondent view

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineIndividual"

  @C38647971
  Scenario: C38647971: Third-party - Ad Hoc Activity - View third-party without ad hoc activity
    When User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User sets up role "AUTO TEST ROLE WITH RESTRICTIONS" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User opens previously created Third-party
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management page is displayed
    And Risk Management "Ad Hoc Activity" table shows 'NO AVAILABLE DATA' message
    And Risk Management "ADD ACTIVITY" button is displayed

  @onlySingleThread
  @C38647974
  Scenario: C38647974: Third-party - Ad Hoc Activity - View Ad hoc Activity Section
    When User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User clicks on created third-party
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management page is displayed
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "Request for Due Diligence Activity"
    And User fills in "Activity Name" field with "Request for Due Diligence Activity Name"
    And User fills in "Description" field with "Request for Due Diligence Activity Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Draft"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Done button in Activity Reviewers section
    And User clicks Ad Hoc Activity "Back" button
    And User clicks on Edit button for Ad Hoc Activity with name "Request for Due Diligence Activity Name" in Ad Hoc Activity table
    And User fills in "Activity Type" drop-down with "World Check Screening"
    And User fills in "Status" drop-down with "Not Started"
    Then Reviewers Table is not displayed
    When User clicks Ad Hoc Activity "Save" button
    Then Risk Management Ad Hoc table is displayed with the next details
      | NAME                                    | STATUS      | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Request for Due Diligence Activity Name | Not Started | 3.2                | Admin_AT_FN Admin_AT_LN | TODAY+0    | TODAY+0     |
    When User sets up role "AUTO_NO_ONBOARDING_RENEWAL" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User opens previously created Third-party
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management page is displayed
    And Risk Management "ADD ACTIVITY" button is displayed
    And Risk Management Ad Hoc table is displayed with the next details
      | NAME                                    | STATUS      | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Request for Due Diligence Activity Name | Not Started | 3.2                | Admin_AT_FN Admin_AT_LN | TODAY+0    | TODAY+0     |

  @onlySingleThread
  @C38911718
  Scenario: C38911718: Third-party - Ad Hoc Activity - Verify Add Activity validations
    When User sets up role "AUTO_NO_ONBOARDING_RENEWAL" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User opens previously created Third-party
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management page is displayed
    And Risk Management "Ad Hoc Activity" table shows 'NO AVAILABLE DATA' message
    And Risk Management "ADD ACTIVITY" button is displayed
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
    When User fills in "Activity Type" drop-down with "Request for Due Diligence Activity"
    And User fills in "Activity Name" field with "Request for Due Diligence Activity Name"
    And User fills in "Description" field with "Request for Due Diligence Activity Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Cancel" button
    Then Risk Management "Ad Hoc Activity" table shows 'NO AVAILABLE DATA' message

  @onlySingleThread
  @C38647972
  Scenario: C38647972: Third-party - Ad Hoc Activities - Add Ad Hoc Activity with Not Started Status
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management page is displayed
    And Risk Management "Ad Hoc Activity" table shows 'NO AVAILABLE DATA' message
    And Risk Management "ADD ACTIVITY" button is displayed
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
    When User fills in "Activity Type" drop-down with "Request for Due Diligence Activity"
    And User fills in "Activity Name" field with "Request for Due Diligence Activity Name"
    And User fills in "Description" field with "Request for Due Diligence Activity Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks Ad Hoc Activity "Back" button
    Then Risk Management Ad Hoc table is displayed with the next details
      | NAME                                    | STATUS      | OVERALL RISK SCORE | INITIATED BY            | START DATE |
      | Request for Due Diligence Activity Name | Not Started | 3.2                | Admin_AT_FN Admin_AT_LN | TODAY+0    |
    And Risk Management Ad Hoc activity with name "Request for Due Diligence Activity Name" has icon Edit
    And Risk Management Ad Hoc activity with name "Request for Due Diligence Activity Name" has icon Delete
    When User logs into RDDC as "Assignee"
    And User navigates to Home page
    And User clicks Notification Bell
    Then The list with notifications is shown
    And The list with notifications contains notifications for the past 7 days
    And "Activity has been Assigned" notification displayed with text
      | toBeReplaced |

  @onlySingleThread
  @C39400325
  Scenario: C39400325: Third-party - Ad Hoc Activity - View Ad hoc Activity Section
    When User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User opens previously created Third-party
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management page is displayed
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "Request for Due Diligence Activity"
    And User fills in "Activity Name" field with "Request for Due Diligence Activity Name"
    And User fills in "Description" field with "Request for Due Diligence Activity Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    Then Ad-Hoc Activity Information is saved
    When User sets up role "AUTO_NO_ONBOARDING_RENEWAL" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User opens previously created Third-party
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management page is displayed
    When User clicks on the newly created Ad Hoc Activity with name "Request for Due Diligence Activity Name"
    Then Risk Management Ad Hoc Activity has correct URL

  @onlySingleThread
  @C38647975
  Scenario: C38647975: Third-party - Ad Hoc Activity - Edit Ad Hoc Activities with Draft status from Ad Hoc Activity List
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User opens previously created Third-party
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management page is displayed
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "Request for Due Diligence Activity"
    And User fills in "Activity Name" field with "Request for Due Diligence Activity Name"
    And User fills in "Description" field with "Request for Due Diligence Activity Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Draft"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    Then Ad-Hoc Activity Information is saved
    When User clicks Ad Hoc Activity "Back" button
    Then Risk Management page is displayed
    When User clicks on Edit button for Ad Hoc Activity with name "Request for Due Diligence Activity Name" in Ad Hoc Activity table
    And Activity Information button 'Save' is displayed
    And Activity Information button 'Cancel' is displayed
    Then Ad Hoc Activity Information fields should have correct state
      | Activity Type | enabled  |
      | Due Date      | enabled  |
      | Start Date    | disabled |
      | Assignee      | enabled  |
      | Activity Name | enabled  |
      | Status        | enabled  |
      | Risk Area     | enabled  |
      | Description   | enabled  |
    And User fills in "Status" drop-down with "Not Started"
    When User clicks Ad Hoc Activity "Save" button
    Then Risk Management Ad Hoc table is displayed with the next details
      | NAME                                    | STATUS      | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Request for Due Diligence Activity Name | Not Started | 3.2                | Admin_AT_FN Admin_AT_LN | TODAY+0    | TODAY+0     |

  @onlySingleThread
  @C38647979
  Scenario: C38647979: Third-party - Ad Hoc Activities - Delete Ad Hoc Activity with Draft Status
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management page is displayed
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "Request for Due Diligence Activity"
    And User fills in "Activity Name" field with "Request for Due Diligence Activity Name"
    And User fills in "Description" field with "Request for Due Diligence Activity Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Draft"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    Then Ad-Hoc Activity Information is saved
    When User clicks Ad Hoc Activity "Back" button
    Then Risk Management page is displayed
    When User clicks on Delete button for Ad Hoc Activity with name "Request for Due Diligence Activity Name" in Ad Hoc Activity table
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Activity? |
    And Confirmation button Cancel should be displayed
    And Confirmation button Delete should be displayed
    When User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Risk Management "Ad Hoc Activity" table shows 'NO AVAILABLE DATA' message

  @C39690976
  Scenario: C39690976: Third-party - Add Ad Hoc Activity with Reviewer
    When User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User clicks on created third-party
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management page is displayed
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "Request for Due Diligence Activity"
    And User fills in "Activity Name" field with "Request for Due Diligence Activity Name"
    And User fills in "Description" field with "Request for Due Diligence Activity Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Draft"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    Then Activity Information "Reviewer" field should be enabled
    And 'Reviewer' dropdown contains all Internal Active users
    When User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Done button in Activity Reviewers section
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |
    And Activity Information "Reviewer" field should be disabled

  @C38647980 @C38647981
  Scenario: C38647980, C38647981: Third-party - Ad Hoc Activity - Assign Reviewer, Reassign Reviewer
    When User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User clicks on created third-party
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management page is displayed
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "Request for Due Diligence Activity"
    And User fills in "Activity Name" field with "Request for Due Diligence Activity Name"
    And User fills in "Description" field with "Request for Due Diligence Activity Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Draft"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    Then Activity Information "Reviewer" field should be enabled
    And 'Reviewer' dropdown contains all Internal Active users
    When User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Done button in Activity Reviewers section
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks Edit icon on Review for "Admin_AT_FN Admin_AT_LN" user
    And User clears value for dropdown 'Reviewer'
    And User clicks Done button in Activity Reviewers section
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And "Reviewer" dropdown displayed on Activity Information page on Risk Management tab
    When User clicks Cancel button in Activity Reviewers section
    Then "Reviewer" dropdown not displayed on Activity Information page on Risk Management tab
    When User clicks Edit icon on Review for "Admin_AT_FN Admin_AT_LN" user
    And User fills in "Reviewer" drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Done button in Activity Reviewers section
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To                   | Last Update | Action                 | Status  |
      | Assignee_AT_FN Assignee_AT_LN |             | Review,Reject,Reassign | Pending |

  @C38647982
  Scenario: C38647982: Third-party - Ad Hoc Activity with Draft Status - Delete Reviewer
    When User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User clicks on created third-party
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management page is displayed
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "Request for Due Diligence Activity"
    And User fills in "Activity Name" field with "Request for Due Diligence Activity Name"
    And User fills in "Description" field with "Request for Due Diligence Activity Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Draft"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    Then Activity Information "Reviewer" field should be enabled
    And 'Reviewer' dropdown contains all Internal Active users
    When User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Done button in Activity Reviewers section
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To             | Last Update | Action                 | Status  |
      | Admin_AT_FN Admin_AT_LN |             | Review,Reject,Reassign | Pending |
    When User clicks Delete icon on Review for "Admin_AT_FN Admin_AT_LN" user
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Reviewer? This change cannot be undone. |
    And Confirmation button Cancel should be displayed
    And Confirmation button Delete should be displayed
    When User clicks Cancel button on confirmation window
    And User clicks Delete icon on Review for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Delete button on confirmation window
    Then Activity Information Reviewers table should contain the following reviewers
      | Assigned To | Last Update | Action | Status |
      |             |             |        |        |