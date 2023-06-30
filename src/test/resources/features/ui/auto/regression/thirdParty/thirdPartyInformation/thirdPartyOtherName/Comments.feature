@ui @full_regression @core_regression @react @third_party_other_names @arabica
Feature: Third-party Other Names -Screening - World-Check tab - Select record

  As a user,
  I want to add a comment in WC1 Record Details page
  So that I can manage the screening records.

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    When User creates third-party "with questionnaire workflow" via API and open it
    Then "Other Names Section" for other name is displayed
    When User fills in Name field value "Apple"
    And User selects Name type "Doing Business As"

  @C39465426
  Scenario: C39465426: Third-party Other Names - Screening - Record Details page - Verify that Comment section should have the correct fields and details
    When User clicks on "Other Names Add|Save button"
    And User opens screening results for "Apple" Other name
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Apple" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User fills in screening profile comment "Test Text"
    And User clicks screening profile Comment button
    And User clicks on the 'Screening Results' screening profile button
    And User clicks on 1 number Other name screening record
    Then Comment profile section contains expected text "Test Text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date

  @C39465437
  Scenario: C39465437: Third-party Other Names - Screening - Record Details page - Verify that Comments section should have maximum of 20 comments
    When User clicks on "Other Names Add|Save button"
    And User opens screening results for "Apple" Other name
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Apple" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User on Screening profile page adds 19 comment "Screening profile comment text N"
    Then Only 3 last comments are displayed by default on Screening Profile page
    When User clicks screening profile comment button "Show all comments"
    Then Created comments on screening profile page are displayed and sorted by upload date
    When User fills in screening profile comment "Screening profile comment text N20"
    And User clicks screening profile Comment button
    Then Created comments on screening profile page are displayed and sorted by upload date
    And Screening profile page comment section button "Comment" is not displayed
    And Screening profile page comment section button "Cancel" is not displayed
    And Screening profile page comment section text input area is not displayed

  @C39465436
  Scenario: C39465436: Third-party Other Names - Screening - Record Details page - Cancel/Add Comment
    When User clicks on "Other Names Add|Save button"
    And User opens screening results for "Apple" Other name
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Apple" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening profile page comment section button "Comment" is disabled
    And Screening profile page comment section button "Cancel" is enabled
    And Screening profile page comment section text input area is displayed
    When User fills in screening profile comment "Text text"
    Then Screening profile page comment text area contains "Text text"
    And Screening profile page comment section button "Comment" is enabled
    And Other Name Screening comment length message "Characters : 9/5000" is displayed
    When User clicks screening profile comment button "Cancel"
    Then Screening profile page comment text area contains ""
    And Comment profile section is not displayed
    When User fills in screening profile comment "Text text"
    And User clicks screening profile Comment button
    Then Created comments on screening profile page are displayed and sorted by upload date

  @C39465441
  Scenario: C39465441: Third-party Other Names - Screening - Record Details page - Edit and Save Comment (Another user)
    When User clicks on "Other Names Add|Save button"
    And User opens screening results for "Apple" Other name
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Apple" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User fills in screening profile comment "Text text"
    And User clicks screening profile Comment button
    Then Created comments on screening profile page are displayed and sorted by upload date
    When User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User opens screening results for "Apple" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening profile Comment "Text text" edit button is not displayed

  @C39465441
  Scenario: C39465441: Third-party Other Names - Screening - Record Details page - Edit and Save Comment (Same user)
    When User clicks on "Other Names Add|Save button"
    And User opens screening results for "Apple" Other name
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Apple" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Other Name Screening comment length message "Characters : 0/5000" is displayed
    When User on Screening profile page adds 3 comments "Screening profile comment text N"
    Then Created comments on screening profile page are displayed and sorted by upload date
    When User on Screening Profile page edits comment "Screening profile comment text N3" with 5000 alphanumeric and special characters
    And User clicks screening profile comment button "Save"
    When User on Screening Profile page edits comment "Screening profile comment text N2" with text "Screening profile comment text N3 Edited"
    And User clicks screening profile comment button "Save"
    Then Edited comment on Screening Profile page is displayed
    And Edited comment on Screening Profile page is marked with 'Edited' label
    And Edited comment on Screening Profile is on initial position in comments list

  @C39465444
  Scenario: C39465444: Third-party Other Names - Screening - Record Details page - Verify that user can delete its own comment (Another user)
    When User clicks on "Other Names Add|Save button"
    And User opens screening results for "Apple" Other name
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Apple" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User fills in screening profile comment "Text text"
    And User clicks screening profile Comment button
    Then Created comments on screening profile page are displayed and sorted by upload date
    When User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User opens screening results for "Apple" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening profile Comment "Text text" delete button is not displayed

  @C39465444
  Scenario: C39465444: Third-party Other Names - Screening - Record Details page - Verify that user can delete its own comment (Same user)
    When User clicks on "Other Names Add|Save button"
    And User opens screening results for "Apple" Other name
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Apple" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User fills in screening profile comment "Test Text"
    And User clicks screening profile Comment button
    And User clicks on the 'Screening Results' screening profile button
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Created comments on screening profile page are displayed and sorted by upload date
    And Screening profile Comment "Test Text" delete button is displayed
    When User on Screening Profile page deletes comment "Test Text"
    Then Message is displayed on confirmation window
      | DELETE COMMENT                                                              |
      | Are you sure you want to delete this Comment? This change cannot be undone. |
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Created comments on screening profile page are displayed and sorted by upload date
    When User on Screening Profile page deletes comment "Test Text"
    And User clicks Delete button on confirmation window
    Then Screening profile comment is deleted from list

  @C39465427
  Scenario: C39465427: Third-party Other Names - Screening - Record Details page - Verify that Comments section have maximum of 5000 characters (Alpha Numeric and Special Characters)
    When User clicks on "Other Names Add|Save button"
    And User opens screening results for "Apple" Other name
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Apple" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Other Name Screening comment length message "Characters : 0/5000" is displayed
    When User on Screening profile page adds 3 comments "Screening profile comment text N"
    Then Created comments on screening profile page are displayed and sorted by upload date
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date
    When User on Screening Profile page adds comment with 5000 alphanumeric and special characters
    Then The 5000-character comment on Screening Profile page is displayed
    When User on Screening Profile page adds comment with 5001 alphanumeric and special characters
    Then The 5000-character comment on Screening Profile page is displayed
    When User clicks screening profile Comment button
    Then Screening profile page comment section button "Comment" is disabled