@ui @full_regression @core_regression @arabica

Feature: Associated Individual Other Names - Media Check Profile/Screening Detail - Media Resolution / Filtering

  As a RDDC user
  I want a media resolution box
  So that I can review the being-read article by attaching a risk level with/without comment

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "Bank of China"
    And User creates Associated Party "with mandatory fields"

  @C39925948
  Scenario: C39925948: Associated Individual Other Names - Media Check Tab -  Screening Detail - Media Resolution box -  Verify  Display toast message when the user is trying to select more than 200 articles [200 articles have been attached with a risk level]
    When User creates Other name "Joe Biden" for Associated Party
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Joe Biden" "contact" appear in other names screening table for current page
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User selects "50" option from Rows Per Page dropdown list on Other Names
    Then Media Check Other Names Result Table should contain 50 records
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 50 items selected
    When User clicks next page
    And User clicks on select all checkBox of media check page
    Then Media Check displays 100 items selected
    When User clicks next page
    And User clicks on select all checkBox of media check page
    Then Media Check displays 150 items selected
    When User clicks next page
    And User clicks on select all checkBox of media check page
    Then Media Check displays 200 items selected
    When User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Unknown", Comment:" - "
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks next page
    Then Other Name dialog is loaded
    When User clicks on media check Other Names screening record on position 1
    Then Other name screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    When User selects risk level on MediaCheck Profile as "MEDIUM"
    And User fills in comment "attach more than 200 articles" on media check other names
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Medium", Comment:"attach more than 200 articles"
    When User clicks "SAVE" Media Check Attach modal button
    Then Toast message "Error! You cannot attach more than 200 articles to a case. Please check the number of articles selected and try again." is displayed

  @C40112518
  Scenario: C40112518: Associated Individual Other Names - Media Check Tab -  Screening Detail - Media Resolution box - Verify  Display risk levels  as unselected all when there's no risk level was selected
    When User creates Other name "Joe Biden" for Associated Party
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Joe Biden" "contact" appear in other names screening table for current page
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User clicks on media check Other Names screening record on position 1
    Then Other name screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile attach button is "disabled"
    And Media Check Profile risk level is not selected
      | HIGH    |
      | MEDIUM  |
      | LOW     |
      | NO_RISK |
      | UNKNOWN |
    And Media Check Resolution Profile comment text box has value
      |  |
    And Media Check Media Resolution Tag as Red Flag is not toggled

  @C40112519
  Scenario: C40112519: Associated Individual Other Names - Media Check Tab -  Screening Detail - Media Resolution box - Comment box - Verify  the comment will not disabled   if risk level is selected
    When User creates Other name "Joe Biden" for Associated Party
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Joe Biden" "contact" appear in other names screening table for current page
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User clicks on media check Other Names screening record on position 1
    Then Other name screening result profile details is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment" on media check other names
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"test add comment"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Other name screening result profile details is displayed
    And Media Check Profile risk level is selected
      | HIGH |
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 1
    And Media Check Profile comment section is displayed comment as "test add comment" on position 1

  @C40112520
  Scenario: C40112520: Associated Individual Other Names - Media Check Tab -  Screening Detail - Media Resolution box - Comment box - Verify  the comment will not disabled   if risk level has been marked
    When User creates Other name "Joe Biden" for Associated Party
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Joe Biden" "contact" appear in other names screening table for current page
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User clicks on media check Other Names screening record on position 1
    Then Screening results table is loaded
    And Other name screening result profile details is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment" on media check other names
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"test add comment"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Other name screening result profile details is displayed
    And Media Check Profile risk level is selected
      | HIGH |
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 1
    And Media Check Profile comment section is displayed comment as "test add comment" on position 1
    And Media Check Profile attach button is "disabled"
    And User fills in comment "update add comment" on media check other names
    When  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"update add comment"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Other name screening result profile details is displayed
    And Media Check Profile risk level is selected
      | HIGH |
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 1
    And Media Check Profile comment section is displayed comment as "update add comment" on position 1
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 2
    And Media Check Profile comment section is displayed comment as "test add comment" on position 2

  @C40112522
  Scenario: C40112522: Associated Individual Other Names - Media Check Tab -  Screening Detail - Media Resolution box - Verify "Attach" button (default: disabled)
    When User creates Other name "Joe Biden" for Associated Party
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Joe Biden" "contact" appear in other names screening table for current page
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User clicks on media check Other Names screening record on position 1
    Then Screening results table is loaded
    And Other name screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment" on media check other names
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"test add comment"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Other name screening result profile details is displayed
    And Media Check Profile risk level is selected
      | HIGH |
    And Media Check Profile attach button is "disabled"

  @C40112523
  Scenario: C40112523: Associated Individual Other Names - Media Check Tab -  Screening Detail - Media Resolution box - Verify "Attach" button is active when the user selects one of the risk level In case that No risk level has been attached
    When User creates Other name "Joe Biden" for Associated Party
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Joe Biden" "contact" appear in other names screening table for current page
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User clicks on media check Other Names screening record on position 1
    Then Other name screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    Then Media Check Profile attach button is "enabled"

  @C40112524
  Scenario: C40112524: Associated Individual Other Names - Media Check Tab -  Screening Detail - Media Resolution box - Verify "Attach" button is active when the user selects one of the risk level In case risk level has been attached
    When User creates Other name "Joe Biden" for Associated Party
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Joe Biden" "contact" appear in other names screening table for current page
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User clicks on media check Other Names screening record on position 1
    Then Screening results table is loaded
    And Other name screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment" on media check other names
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"test add comment"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Other name screening result profile details is displayed
    And Media Check Profile risk level is selected
      | HIGH |
    And User fills in comment "update add comment" on media check other names
    And Media Check Profile attach button is "enabled"
    And  User deletes Comment Media Resolution on media check other names
    When User selects risk level on MediaCheck Profile as "LOW"
    Then Media Check Resolution Profile comment text box has value
      |  |
    And Media Check Profile attach button is "enabled"

  @C40112526
  Scenario: C40112526: Associated Individual Other Names - Media Check Tab -  Screening Detail - Media Resolution box - Verify Comment box can be empty when being attached to a risk level
    When User creates Other name "Joe Biden" for Associated Party
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Joe Biden" "contact" appear in other names screening table for current page
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User clicks on media check Other Names screening record on position 1
    Then Other name screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment" on media check other names
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"test add comment"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Other name screening result profile details is displayed
    And Media Check Profile risk level is selected
      | HIGH |
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 1
    And Media Check Profile comment section is displayed comment as "test add comment" on position 1
    When User selects risk level on MediaCheck Profile as "LOW"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Low", Comment:" - "
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Other name screening result profile details is displayed
    And Media Check Profile risk level is selected
      | LOW |
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 1
    And Media Check Profile comment section is displayed comment as "test add comment" on position 1

  @C40112533
  Scenario: C40112533: Associated Individual Other Names  - Media Check Tab -  Screening Detail - Media Resolution box - Comment box -Verify Comment limit 2000 characters following WC1
    When User creates Other name "Joe Biden" for Associated Party
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Joe Biden" "contact" appear in other names screening table for current page
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User clicks on media check Other Names screening record on position 1
    Then Screening results table is loaded
    And Other name screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User random 2000 characters
    And User fills in random comment characters on media check other names
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Other name screening result profile details is displayed
    And Media Check Profile risk level is selected
      | HIGH |
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 1
    And Media Check Profile comment section is displayed random comment on position 1

  @C40112539
  Scenario: C40112539: Associated Individual Other Names - Media Check Tab -  Screening Detail - Media Resolution box -  Verify Tag as red flag (read-only toggle) and display tooltip
    When User creates Other name "Joe Biden" for Associated Party
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Joe Biden" "contact" appear in other names screening table for current page
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User clicks on media check Other Names screening record on position 1
    Then Screening results table is loaded
    And Other name screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Media Resolution Tag as Red Flag is not toggled
    When User clicks Tag as red flag tooltip icon on MediaCheck Profile
    Then Media Check Profile Tag as red flag ToolTip contains value as "option will be available in the confirmation screen after you selected the risk level and filled in the comment section"

  @C40112540
  Scenario: C40112540: Associated Individual Other Names - Media Check Tab -  Screening Detail - Media Resolution box -  Verify The "Tag As Red Flag" option will be available in the confirmation screen after you selected the risk level and filled in the comment section.
    When User creates Other name "Joe Biden" for Associated Party
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Joe Biden" "contact" appear in other names screening table for current page
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User clicks on media check Other Names screening record on position 1
    Then Other name screening result profile details is displayed
    And Media Check Media Resolution Tag as Red Flag is not toggled
    When User selects risk level on MediaCheck Profile as "MEDIUM"
    And User fills in comment "test tag as rad flag on" on media check other names
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Medium", Comment:"test tag as rad flag on"
    And User turns on 'Tag as red flag' of Media Check Media Resolution Profile
    When User clicks "SAVE" Media Check Attach modal button
    Then Other name screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile risk level is selected
      | MEDIUM |
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 1
    And Media Check Profile comment section is displayed comment as "test tag as rad flag on" on position 1
    And Media Check Media Resolution Tag as Red Flag is toggled
    And User fills in comment "test tag as rad flag off" on media check other names
    When  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Medium", Comment:"test tag as rad flag off"
    And User turns off 'Tag as red flag' of Media Check Media Resolution Profile
    When User clicks "SAVE" Media Check Attach modal button
    Then Other name screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 1
    And Media Check Profile comment section is displayed comment as "test tag as rad flag off" on position 1
    And Media Check Profile risk level is selected
      | MEDIUM |
    And Media Check Media Resolution Tag as Red Flag is not toggled

  @C40160818
  Scenario: C40160818: Associated Individual Other Names - Media Check Tab -  Screening Detail - Media Resolution box -   Verify  Risk level can replaced  when the user tries to attach article with old risk level
    When User creates Other name "Joe Biden" for Associated Party
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "Joe Biden" "contact" appear in other names screening table for current page
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User selects Media Check Associated Party Individual Other Names screening record on position 1
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Unknown", Comment:" - "
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    And Contacts media check Other Names screening record on position 1 displays Unknown icon
    When User hovers Media Check Other Names Risk Level icon on Screening record 1
    Then Media Check Other Name Risk Level ToolTip "No Risk reason indicated" is displayed
    When User clicks on media check Other Names screening record on position 1
    Then Other name screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    When User selects risk level on MediaCheck Profile as "MEDIUM"
    And User fills in comment "test change risk level" on media check other names
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Medium", Comment:"test change risk level"
    And User turns on 'Tag as red flag' of Media Check Media Resolution Profile
    When User clicks "SAVE" Media Check Attach modal button
    Then Other name screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile risk level is selected
      | MEDIUM |
    When User clicks on third-party other name back button
    And Contacts media check Other Names screening record on position 1 displays Medium icon
    And User hovers Media Check Other Names Risk Level icon on Screening record 1
    Then Media Check Other Name Risk Level ToolTip "test change risk level" is displayed