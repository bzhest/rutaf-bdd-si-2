@ui @full_regression @core_regression @arabica

Feature: Third-party - Media Check Profile/Screening Detail - Media Resolution / Filtering

  As a RDDC user
  I want a media resolution box
  So that I can review the being-read article by attaching a risk level with/without comment

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "Bank of China"

  @C39745450
  Scenario: C39745450: third-Party - Media Check Tab -  Screening Detail - Media Resolution box - Verify  Display risk levels  as unselected all when there's no risk level was selected
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 1
    Then Screening result profile details is displayed
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

  @C39745456
  Scenario: C39745456: third-Party - Media Check Tab -  Screening Detail - Media Resolution box - Comment box - Verify  the comment will not disabled   if risk level is selected
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 1
    Then Media Resolution on Screening Result is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"test add comment"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening result profile details is displayed
    And Media Check Profile risk level is selected
      | HIGH |
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 1
    And Media Check Profile comment section is displayed comment as "test add comment" on position 1

  @C40093599
  Scenario: C40093599: third-Party - Media Check Tab -  Screening Detail - Media Resolution box - Comment box - Verify  the comment will not disabled   if risk level has been marked
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 1
    Then Media Resolution on Screening Result is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"test add comment"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening result profile details is displayed
    And Media Check Profile risk level is selected
      | HIGH |
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 1
    And Media Check Profile comment section is displayed comment as "test add comment" on position 1
    And Media Check Profile attach button is "disabled"
    And User fills in comment "update add comment"
    When  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"update add comment"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening result profile details is displayed
    And Media Check Profile risk level is selected
      | HIGH |
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 1
    And Media Check Profile comment section is displayed comment as "update add comment" on position 1
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 2
    And Media Check Profile comment section is displayed comment as "test add comment" on position 2

  @C40101075
  Scenario: C40101075: third-Party - Media Check Tab -  Screening Detail - Media Resolution box - Verify "Attach" button is active when the user selects one of the risk level In case that No risk level has been attached
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 1
    Then Screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    Then Media Check Profile attach button is "enabled"

  @C39745267
  Scenario: C39745267: third-Party - Media Check Tab -  Screening Detail - Media Resolution box - Verify "Attach" button (default: disabled)
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 1
    Then Screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"test add comment"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening result profile details is displayed
    And Media Check Profile risk level is selected
      | HIGH |
    And Media Check Profile attach button is "disabled"

  @C40101076
  Scenario: C40101076: third-Party - Media Check Tab -  Screening Detail - Media Resolution box - Verify "Attach" button is active when the user selects one of the risk level In case risk level has been attached
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 1
    Then Screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"test add comment"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening result profile details is displayed
    And Media Check Profile risk level is selected
      | HIGH |
    And User fills in comment "update add comment"
    And Media Check Profile attach button is "enabled"
    And  User deletes Comment Media Resolution
    When User selects risk level on MediaCheck Profile as "LOW"
    Then Media Check Resolution Profile comment text box has value
      |  |
    And Media Check Profile attach button is "enabled"

  @C39745612
  Scenario: C39745612: third-Party - Media Check Tab -  Screening Detail - Media Resolution box - Verify Comment box can be empty when being attached to a risk level
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 1
    Then Screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"test add comment"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening result profile details is displayed
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
    Then Screening result profile details is displayed
    And Media Check Profile risk level is selected
      | LOW |
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 1
    And Media Check Profile comment section is displayed comment as "test add comment" on position 1

  @C40094278
  Scenario: C40094278: third-Party - Media Check Tab -  Screening Detail - Media Resolution box - Comment box -Verify Comment limit 2000 characters following WC1
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 1
    Then Screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile attach button is "disabled"
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User random 2000 characters
    And User fills in random comment characters
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening result profile details is displayed
    And Media Check Profile risk level is selected
      | HIGH |
    And Media Check Profile comment section is displayed username as "Admin_AT_FN Admin_AT_LN" on position 1
    And Media Check Profile comment section is displayed random comment on position 1

  @C40106203
  Scenario: C40106203: third-Party - Media Check Tab -  Screening Detail - Media Resolution box -  Verify Tag as red flag (read-only toggle) and display tooltip
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 1
    Then Screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Media Resolution Tag as Red Flag is not toggled
    When User clicks Tag as red flag tooltip icon on MediaCheck Profile
    Then Media Check Profile Tag as red flag ToolTip contains value as "option will be available in the confirmation screen after you selected the risk level and filled in the comment section"

  @C40106204
  Scenario: C40106204: third-Party - Media Check Tab -  Screening Detail - Media Resolution box -  Verify The "Tag As Red Flag" option will be available in the confirmation screen after you selected the risk level and filled in the comment section.
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 1
    Then Screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Media Resolution Tag as Red Flag is not toggled
    When User selects risk level on MediaCheck Profile as "MEDIUM"
    And User fills in comment "test tag as rad flag on"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Medium", Comment:"test tag as rad flag on"
    And User turns on 'Tag as red flag' of Media Check Media Resolution Profile
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening result profile details is displayed
    And Media Check Profile risk level is selected
      | MEDIUM |
    And Media Check Media Resolution Tag as Red Flag is toggled
    And User fills in comment "test tag as rad flag off"
    When  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Medium", Comment:"test tag as rad flag off"
    And User turns off 'Tag as red flag' of Media Check Media Resolution Profile
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening result profile details is displayed
    And Media Check Profile risk level is selected
      | MEDIUM |
    And Media Check Media Resolution Tag as Red Flag is not toggled

  @C40160724
  Scenario: C40160724: third-Party - Media Check Tab -  Screening Detail - Media Resolution box -   Verify  Risk level can replaced  when the user tries to attach article with old risk level
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects Third-party Media Check screening record on position 1
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Unknown", Comment:" - "
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Third-party Media Check screening record on position 1 displays Unknown icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 1
    When User clicks on Media Check screening record on position 1
    Then Screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    And Media Check Profile risk level is selected
      | UNKNOWN |
    When User selects risk level on MediaCheck Profile as "MEDIUM"
    And User fills in comment "test change risk level"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Medium", Comment:"test change risk level"
    And User turns on 'Tag as red flag' of Media Check Media Resolution Profile
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening result profile details is displayed
    And Media Check Profile risk level is selected
      | MEDIUM |
    When User clicks on third-party back button
    Then Third-party Media Check screening record on position 1 displays Medium icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "test change risk level" is displayed on record 1

  @C47329897
  Scenario: C47329897: third-Party - Media Check Tab -  Screening Detail - Media Resolution box -  Verify  Display toast message when the user is trying to select more than 200 articles [200 articles have been attached with a risk level]
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects "50" option from Rows Per Page dropdown list
    Then Media Check Result Table should contain 50 records
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
    Then Screening results table is loaded
    When User clicks next page
    Then Screening results table is loaded
    When User clicks on Media Check screening record on position 1
    Then Screening result profile details is displayed
    And Media Resolution on Screening Result is displayed
    When User selects risk level on MediaCheck Profile as "MEDIUM"
    And User fills in comment "attach more than 200 articles"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Medium", Comment:"attach more than 200 articles"
    When User clicks "SAVE" Media Check Attach modal button
    Then Toast message "Error! You cannot attach more than 200 articles to a case. Please check the number of articles selected and try again." is displayed