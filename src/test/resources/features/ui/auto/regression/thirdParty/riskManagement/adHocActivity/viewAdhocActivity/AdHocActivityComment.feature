@ui @full_regression @core_regression @react @ad_hoc_activity_comment @alamid
Feature: Activity Information page - Comment section

  As a RDDC User
  I want to add the comment to Adhoc Activity
  so that I will be able to all comment related to the activity

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User waits for progress bar to disappear from page
    Then Ad-Hoc Activity Information is saved
    And Activity information page comment section is expanded

  @C38987872
  Scenario: C38987872: Activity Information page - Comment section should have the correct fields and details
    When User on Activity information page adds comment "Test Comment"
    Then Created comment on Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    Then Risk Management page is displayed
    When User clicks Third-Party Risk Management "ADD ACTIVITY" button
    Then User clicks Ad Hoc Activity "Cancel" button
    And Risk Management page is displayed

  @C38987882
  Scenario: C38987882: Activity Information page - Cancel/Add Comment
    Then Activity information page comment section text area is displayed
    And Activity information page comment section button "Comment" is disabled
    And Activity information page comment section button "Cancel" is displayed
    When User on Activity information page fills in comment text "Test Comment"
    Then Activity information page comment text area contains "Test Comment"
    And Activity information page comment section button "Comment" is enabled
    When User clicks Activity Information comment section button "Cancel"
    Then Activity information page comment text area contains ""
    When User on Activity information page fills in comment text "Test Comment"
    Then Activity information page comment text area contains "Test Comment"
    And Activity information page comment section button "Comment" is enabled
    When User clicks Activity Information comment section button "Comment"
    Then Created comment on Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    Then Risk Management page is displayed
    When User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User on Activity information page fills in comment text "Another Comment"
    Then Activity information page comment section button "Comment" is enabled
    When User clicks Activity Information comment section button "Comment"
    Then Created comments on Activity Information page are displayed and sorted by upload date

  @C38987883
  Scenario: C38987883: Activity Information page - Verify that Comments section should have maximum of 20 comments
    When User on Activity information page adds 19 comment "Activity comment text N"
    And User opens previously created Ad-Hoc Acvtivity
    Then Only 3 last comments are displayed by default
    When User clicks Activity Information comment button "Show all comments"
    Then Created comments on Activity Information page are displayed and sorted by upload date
    When User on Activity information page fills in comment text "Activity comment text N20"
    And User clicks Activity Information comment section button "Comment"
    Then Created comments on Activity Information page are displayed and sorted by upload date
    And Activity information page comment section button "Comment" is not displayed
    And Activity information page comment section button "Comment" is not displayed
    And Activity information page comment section text area is not displayed

  @C38987887
  Scenario: C38987887: Activity Information page - Edit and Save Comment
    Then Activity Information Page comment character limit message "Characters : 0/5000" is displayed
    When User on Activity information page adds 3 comment "Activity comment text N"
    And User opens previously created Ad-Hoc Acvtivity
    Then Activity information Comment "Activity comment text N1" edit button is displayed
    And Activity information Comment "Activity comment text N2" edit button is displayed
    And Activity information Comment "Activity comment text N3" edit button is displayed
    When User on Activity information page edits comment "Activity comment text N3" with 5001 alphanumeric and special characters
    And User clicks Activity Information comment button "Save"
    Then Alert Icon is displayed with text
      | Success! Comment has been updated. |
    When User refreshes page
    Then The 5000-character comment on Activity Information page is displayed

  @C38987890
  Scenario: C38987890: Activity Information page - Verify that user can delete its own comment
    When User on Activity information page adds 3 comment "Activity comment text N"
    And User opens previously created Ad-Hoc Acvtivity
    Then Activity information Comment "Activity comment text N1" delete button is displayed
    And Activity information Comment "Activity comment text N2" delete button is displayed
    And Activity information Comment "Activity comment text N3" delete button is displayed
    When User on Activity information page deletes comment "Activity comment text N3"
    Then Message is displayed on confirmation window
      | DELETE COMMENT                                                              |
      | Are you sure you want to delete this Comment? This change cannot be undone. |
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    When User on Activity information page deletes comment "Activity comment text N3"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Created comment on Activity Information page is not displayed

  @C38987965
  Scenario: C38987965: Add Ad hoc Activity - Verify that Comments section have maximum of 5000 characters (Alpha Numeric and Special Characters)
    Then Activity Information Page comment character limit message "Characters : 0/5000" is displayed
    When User on Activity Information page adds comment with 5001 alphanumeric and special characters
    Then Alert Icon is displayed with text
      | Success! Comment has been added. |
    When User refreshes page
    Then The 5000-character comment on Activity Information page is displayed
