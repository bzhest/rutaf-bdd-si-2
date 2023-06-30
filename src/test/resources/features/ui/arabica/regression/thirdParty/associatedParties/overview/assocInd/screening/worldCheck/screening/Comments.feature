@ui @full_regression @core_regression @arabica

Feature: Associated Individual Screening Results/Record Details Page - Comment Section

  As a user,
  I want to add a comment in WC1 Record Details page
  So that I can manage the screening records.

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "APPLE INVESTMENT COMPANY"

  @C39240311
  Scenario: C39240311: Associated Individual - Add Comment - Verify comment section
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    When User clicks Close accordion icon of Comments section on Screening Profile page
    Then Screening profile page comment section text input area is not displayed
    When User clicks Open accordion icon of Comments section on Screening Profile page
    Then Screening profile page comment section text input area is displayed

  @C39241381
  Scenario: C39241381: Associated Individual - Add Comment - Verify all components in the comment section
    When User creates Associated Party "Vladimir PUTIN"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    When User fills in screening profile comment "Add Text"
    And User clicks screening profile Comment button
    Then Comment profile section contains expected text "Add Text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date

  @C48817415
  Scenario: C48817415: Associated Individual - Add Comment - Verify the comment when there is detail more than 3 lines (Around 600 characters)
    When User creates Associated Party "Vladimir PUTIN"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    When User random 1500 characters and fills in random comment characters on Comment profile section
    And User clicks screening profile Comment button
    Then Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date
    And Comment profile section displays 'See more' label on comment position 1
    When User clicks 'See more' button on comment position 1
    Then Comment profile section displays 'See less' label on comment position 1
    When User clicks 'See less' button on comment position 1
    Then Comment profile section displays 'See more' label on comment position 1

  @C39241950
  Scenario: C39241950: Associated Individual - Add Comment - Verify the comment when there are more than 3 comments.
    When User creates Associated Party "Vladimir PUTIN"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    When User fills in screening profile comment "Add Comment 1"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 2"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 3"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 4"
    And User clicks screening profile Comment button
    Then Comment profile section displays 'Show More' button
    And Comment profile section displays 'Show All Comments' button
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 1
    And Comment profile section displays comment as "Add Comment 4" on position 1
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 2
    And Comment profile section displays comment as "Add Comment 3" on position 2
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 3
    And Comment profile section displays comment as "Add Comment 2" on position 3
    When User clicks 'Show More' button
    Then Comment profile section displays 'Hide comments' button
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 1
    And Comment profile section displays comment as "Add Comment 4" on position 1
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 2
    And Comment profile section displays comment as "Add Comment 3" on position 2
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 3
    And Comment profile section displays comment as "Add Comment 2" on position 3
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 4
    And Comment profile section displays comment as "Add Comment 1" on position 4
    When User clicks 'Hide Comments' button
    Then Comment profile section displays 'Show More' button
    And Comment profile section displays 'Show All Comments' button
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 1
    And Comment profile section displays comment as "Add Comment 4" on position 1
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 2
    And Comment profile section displays comment as "Add Comment 3" on position 2
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 3
    And Comment profile section displays comment as "Add Comment 2" on position 3
    When User clicks 'Show All comments' button
    Then Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 1
    And Comment profile section displays comment as "Add Comment 4" on position 1
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 2
    And Comment profile section displays comment as "Add Comment 3" on position 2
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 3
    And Comment profile section displays comment as "Add Comment 2" on position 3
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 4
    And Comment profile section displays comment as "Add Comment 1" on position 4
    And Comment profile section displays 'Hide comments' button

  @C39241948
  Scenario: C39241948: Associated Individual - Add Comment - Verify the system can display the maximum comment = 20 comments. (include the comment from the system)
    When User creates Associated Party "Vladimir PUTIN"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    When User fills in screening profile comment "Add Comment 1"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 2"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 3"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 4"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 5"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 6"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 7"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 8"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 9"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 10"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 11"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 12"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 13"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 14"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 15"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 16"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 17"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 18"
    And User clicks screening profile Comment button
    And User fills in screening profile comment "Add Comment 19"
    And User clicks screening profile Comment button
    And User clicks resolve screening profile under number 1 record as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Add Comment 20 from Mark Resolution"
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Toast message "Success! Resolution type has been updated to positive." is displayed
    And Screening result profile details is displayed
    And Risk Level value on Screening profile page is "MEDIUM"
    And Reason value on Screening profile page is "FULL MATCH"
    And Comment profile section displays 'Show More' button
    And Comment profile section displays 'Show All Comments' button
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 1
    And Comment profile section displays comment as "Add Comment 20 from Mark Resolution" on position 1
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 2
    And Comment profile section displays comment as "Add Comment 19" on position 2
    And Comment profile section displays author as "Admin_AT_FN Admin_AT_LN" on position 3
    And Comment profile section displays comment as "Add Comment 18" on position 3
    And Screening profile page comment section text input area is not displayed
    When User clicks Close accordion icon of Comments section on Screening Profile page
    Then Screening profile page comment section text input area is not displayed

  @C39241952
  Scenario: C39241952: Associated Individual - Add Comment - Verify the Cancel button
    When User creates Associated Party "Vladimir PUTIN"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Screening profile page comment section button "Comment" is disabled
    And Screening profile page comment section button "Cancel" is enabled
    When User fills in screening profile comment "Add Comment for cancel"
    Then Screening profile page comment section button "Comment" is enabled
    And Screening profile page comment section button "Cancel" is enabled
    When User clicks screening profile Cancel button
    Then Screening profile page comment section button "Comment" is disabled
    And Screening profile page comment section button "Cancel" is enabled
    And Screening profile page comment text area contains ""

  @C39242805
  Scenario: C39242805: Associated Individual - Add Comment - Verify the system is able to fill in maximum characters  = 5000 characters
    When User creates Associated Party "Vladimir PUTIN"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Comment profile section comment length message "Characters : 0/5000" is displayed
    When User random 5000 characters and fills in random comment characters on Comment profile section
    Then Comment profile section comment length message "Characters : 5000/5000" is displayed
    When User clicks screening profile Comment button
    Then Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date
    And Comment profile section displays 'See more' label on comment position 1
    And Comment profile section displays random comment on position 1

  @C39241957
  Scenario: C39241957: Associated Individual - Edit Comment -  Verify the edit feature when logging in with an account who the owner of a comment
    When User creates Associated Party "Vladimir PUTIN"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    When User on Screening profile page adds 3 comments "Screening profile comment text N"
    Then Created comments on screening profile page are displayed and sorted by upload date
    When User on Screening Profile page edits comment "Screening profile comment text N3" with text "Edited #3 text"
    And User clicks screening profile comment button "Save"
    Then Edited comment on Screening Profile page is displayed
    And Edited comment on Screening Profile page is marked with 'Edited' label
    And Edited comment on Screening Profile is on initial position in comments list

  @C39241964
  Scenario: C39241964: Associated Individual - Delete Comment -  Verify the delete feature when logging in with an account who the owner of a comment
    When User creates Associated Party "Vladimir PUTIN"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    When User fills in screening profile comment "Test Text"
    And User clicks screening profile Comment button
    Then Created comments on screening profile page are displayed and sorted by upload date
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

  @C39241958
  Scenario: C39241958: Associated Individual - Edit Comment - The system isn't able to edit the comment when logging in with a user that isn't an owner of the comment and the role isn't  System Administrator (Another user)
    When User creates Associated Party "Vladimir PUTIN"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    When User fills in screening profile comment "Text text"
    And User clicks screening profile Comment button
    Then Created comments on screening profile page are displayed and sorted by upload date
    When User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User opens Contacts for previously created Third-party
    And User clicks on Associated Party with name "Vladimir"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Screening profile Comment "Text text" edit button is not displayed

  @C39241970
  Scenario: C39241970: Associated Individual - Delete Comment - The system isn't able to edit the comment when logging in with a user that isn't an owner of the comment and the role isn't  System Administrator (Another user)
    When User creates Associated Party "Vladimir PUTIN"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    When User fills in screening profile comment "Text text"
    And User clicks screening profile Comment button
    Then Created comments on screening profile page are displayed and sorted by upload date
    When User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User opens Contacts for previously created Third-party
    And User clicks on Associated Party with name "Vladimir"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Screening profile Comment "Text text" delete button is not displayed