@ui @full_regression @core_regression @arabica

Feature: Third-party - Media check risk level filter

  As an RDDC user
  I want filter panel for media check screening
  So that I can see specific results

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Third-party page

  @C39524496
  Scenario: C39524496: Media Resolution - High - user must see No Match Found in High filter if articles are not marked as High and user must not see Mark All As Review button
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "High" "0" is displayed
    When User clicks on Risk Level Filter "High" "0"
    Then Screening results table is loaded
    And MEDIA CHECK tab screening result contains No Match Found
    And Mark all as reviewed button is not displayed

  @C39512843
  Scenario: C39512843: Media Resolution - High - user must see only articles that has its Risk Level marked as High
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects "50" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    And Media Check Result Table should contain 50 records
    When User clicks on select all checkBox of media check page
    And User gets Third-party media check screening first and last record
    Then Media Check displays 50 items selected
    When User selects risk level as "HIGH"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "High" "50" is displayed
    When User clicks on Risk Level Filter "High" "50"
    Then Screening results table is loaded
    And Media Check Result Table should contain 50 records
    And First and last article name should matched with the previous selected first and last article name
    And Media check showing articles must be "50"
    And All media check articles must be marked as "High"

  @C39525070
  Scenario: C39525070: Media Resolution - High - Verify media resolution section is correct
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "HIGH"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "High" "10" is displayed
    When User clicks on Risk Level Filter "High" "10"
    Then Screening results table is loaded
    And Risk Level label is displayed
    And Risk Level options are displayed
    And Risk Level options are not selected by default
    And Comment label is displayed
    And Media check pagination is not visible
    When User random 2003 characters
    And User fills in random comment characters
    Then Media Check attach button is disable
    When User selects Third-party Media Check screening record on position 1
    Then Media Check attach button is disable
    When User selects risk level as "MEDIUM"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "CANCEL" Media Check Attach modal button
    Then Screening results table is loaded
    When User deletes Comment Media Resolution
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "CANCEL" Media Check Attach modal button
    Then Screening results table is loaded
    When User selects Third-party Media Check screening record on position 1
    Then Media Check attach button is disable

  @C39525071
  Scenario: C39525071: Media Resolution - High - Verify Select All check box is working correctly
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "HIGH"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "High" "10" is displayed
    When User clicks on Risk Level Filter "High" "10"
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    And Clear All button is displayed
    When User clicks on select all checkBox of media check page
    Then Media Check does not displays 10 items selected
    And Clear All button is disappeared

  @C39525075
  Scenario: C39525075: Media Resolution - High - Verify "X items selected" link label filters only the selected articles
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "HIGH"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "High" "10" is displayed
    When User clicks on Risk Level Filter "High" "10"
    Then Screening results table is loaded
    When User selects Third-party Media Check screening record on position 1
    And User selects Third-party Media Check screening record on position 2
    And User selects Third-party Media Check screening record on position 3
    Then Media Check displays 3 items selected
    And Clear All button is displayed
    When User clicks on 3 items selected link
    Then Media Check items selected link Change to "Back to the full list" is displayed
    And Clear All button is displayed
    And Media Check Result Table should contain 3 records
    When User clicks Back to the full list Link
    Then Media Check displays 3 items selected
    And Clear All button is displayed

  @C39525073
  Scenario: C39525073: Media Resolution - High - Verify Clear All link label is working correctly
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "HIGH"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "High" "10" is displayed
    When User clicks on Risk Level Filter "High" "10"
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    And Clear All button is displayed
    When User clicks clear all button
    Then Media Check does not displays 10 items selected
    And Clear All button is disappeared

  @C40066528
  Scenario: C40066528: Media Resolution - Medium - user must see No Match Found in Medium filter if articles are not marked as Medium and user must not see Mark All As Review button
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Medium" "0" is displayed
    When User clicks on Risk Level Filter "Medium" "0"
    Then Screening results table is loaded
    And MEDIA CHECK tab screening result contains No Match Found
    And Mark all as reviewed button is not displayed

  @C40066530
  Scenario: C40066530: Media Resolution - Medium - user must see only articles that has its Risk Level marked as Medium
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects "50" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    And Media Check Result Table should contain 50 records
    When User clicks on select all checkBox of media check page
    And User gets Third-party media check screening first and last record
    Then Media Check displays 50 items selected
    When User selects risk level as "MEDIUM"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Medium" "50" is displayed
    When User clicks on Risk Level Filter "Medium" "50"
    Then Screening results table is loaded
    And Media Check Result Table should contain 50 records
    And First and last article name should matched with the previous selected first and last article name
    And Media check showing articles must be "50"
    And All media check articles must be marked as "Medium"

  @C40066531
  Scenario: C40066531: Media Resolution - Medium - Verify media resolution section is correct
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "MEDIUM"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Medium" "10" is displayed
    When User clicks on Risk Level Filter "Medium" "10"
    Then Screening results table is loaded
    And Risk Level label is displayed
    And Risk Level options are displayed
    And Risk Level options are not selected by default
    And Comment label is displayed
    And Media check pagination is not visible
    When User random 2003 characters
    And User fills in random comment characters
    Then Media Check attach button is disable
    When User selects Third-party Media Check screening record on position 1
    Then Media Check attach button is disable
    When User selects risk level as "LOW"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "CANCEL" Media Check Attach modal button
    Then Screening results table is loaded
    When User deletes Comment Media Resolution
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "CANCEL" Media Check Attach modal button
    Then Screening results table is loaded
    When User selects Third-party Media Check screening record on position 1
    Then Media Check attach button is disable

  @C40066532
  Scenario: C40066532: Media Resolution - Medium - Verify Select All check box is working correctly
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "MEDIUM"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Medium" "10" is displayed
    When User clicks on Risk Level Filter "Medium" "10"
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    And Clear All button is displayed
    When User clicks on select all checkBox of media check page
    Then Media Check does not displays 10 items selected
    And Clear All button is disappeared

  @C40066533
  Scenario: C40066533: Media Resolution - Medium - Verify Clear All link label is working correctly
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "MEDIUM"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Medium" "10" is displayed
    When User clicks on Risk Level Filter "Medium" "10"
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    And Clear All button is displayed
    When User clicks clear all button
    Then Media Check does not displays 10 items selected
    And Clear All button is disappeared

  @C40066534
  Scenario: C40066534: Media Resolution - Medium - Verify "X items selected" link label filters only the selected articles
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "MEDIUM"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Medium" "10" is displayed
    When User clicks on Risk Level Filter "Medium" "10"
    Then Screening results table is loaded
    When User selects Third-party Media Check screening record on position 1
    And User selects Third-party Media Check screening record on position 2
    And User selects Third-party Media Check screening record on position 3
    Then Media Check displays 3 items selected
    And Clear All button is displayed
    When User clicks on 3 items selected link
    Then Media Check items selected link Change to "Back to the full list" is displayed
    And Clear All button is displayed
    And Media Check Result Table should contain 3 records
    When User clicks Back to the full list Link
    Then Media Check displays 3 items selected
    And Clear All button is displayed

  @C40091495
  Scenario: C40091495: Media Resolution - Low - user must see No Match Found in Low filter if articles are not marked as Low and user must not see Mark All As Review button
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Low" "0" is displayed
    When User clicks on Risk Level Filter "Low" "0"
    Then Screening results table is loaded
    And MEDIA CHECK tab screening result contains No Match Found
    And Mark all as reviewed button is not displayed

  @C40091497
  Scenario: C40091497: Media Resolution - Low - user must see only articles that has its Risk Level marked as Low
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects "50" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    And Media Check Result Table should contain 50 records
    When User clicks on select all checkBox of media check page
    And User gets Third-party media check screening first and last record
    Then Media Check displays 50 items selected
    When User selects risk level as "LOW"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Low" "50" is displayed
    When User clicks on Risk Level Filter "Low" "50"
    Then Screening results table is loaded
    And Media Check Result Table should contain 50 records
    And First and last article name should matched with the previous selected first and last article name
    And Media check showing articles must be "50"
    And All media check articles must be marked as "Low"

  @C40091498
  Scenario: C40091498: Media Resolution - Low - Verify media resolution section is correct
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "LOW"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Low" "10" is displayed
    When User clicks on Risk Level Filter "Low" "10"
    Then Screening results table is loaded
    And Risk Level label is displayed
    And Risk Level options are displayed
    And Risk Level options are not selected by default
    And Comment label is displayed
    And Media check pagination is not visible
    When User random 2003 characters
    And User fills in random comment characters
    Then Media Check attach button is disable
    When User selects Third-party Media Check screening record on position 1
    Then Media Check attach button is disable
    When User selects risk level as "NO_RISK"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "CANCEL" Media Check Attach modal button
    Then Screening results table is loaded
    When User deletes Comment Media Resolution
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "CANCEL" Media Check Attach modal button
    Then Screening results table is loaded
    When User selects Third-party Media Check screening record on position 1
    Then Media Check attach button is disable

  @C40091499
  Scenario: C40091499: Media Resolution - Low - Verify Select All check box is working correctly
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "LOW"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Low" "10" is displayed
    When User clicks on Risk Level Filter "Low" "10"
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    And Clear All button is displayed
    When User clicks on select all checkBox of media check page
    Then Media Check does not displays 10 items selected
    And Clear All button is disappeared

  @C40091500
  Scenario: C40091500: Media Resolution - Low - Verify Clear All link label is working correctly
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "LOW"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Low" "10" is displayed
    When User clicks on Risk Level Filter "Low" "10"
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    And Clear All button is displayed
    When User clicks clear all button
    Then Media Check does not displays 10 items selected
    And Clear All button is disappeared

  @C40091501
  Scenario: C40091501: Media Resolution - Low - Verify "X items selected" link label filters only the selected articles
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "LOW"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Low" "10" is displayed
    When User clicks on Risk Level Filter "Low" "10"
    Then Screening results table is loaded
    When User selects Third-party Media Check screening record on position 1
    And User selects Third-party Media Check screening record on position 2
    And User selects Third-party Media Check screening record on position 3
    Then Media Check displays 3 items selected
    And Clear All button is displayed
    When User clicks on 3 items selected link
    Then Media Check items selected link Change to "Back to the full list" is displayed
    And Clear All button is displayed
    And Media Check Result Table should contain 3 records
    When User clicks Back to the full list Link
    Then Media Check displays 3 items selected
    And Clear All button is displayed

  @C40091505
  Scenario: C40091505: Media Resolution - No Risk - user must see No Match Found in No Risk filter if articles are not marked as No Risk and user must not see Mark All As Review button
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "No Risk" "0" is displayed
    When User clicks on Risk Level Filter "No Risk" "0"
    Then Screening results table is loaded
    And MEDIA CHECK tab screening result contains No Match Found
    And Mark all as reviewed button is not displayed

  @C40091507
  Scenario: C40091507: Media Resolution - No Risk - user must see only articles that has its Risk Level marked as No Risk
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects "50" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    And Media Check Result Table should contain 50 records
    When User clicks on select all checkBox of media check page
    And User gets Third-party media check screening first and last record
    Then Media Check displays 50 items selected
    When User selects risk level as "NO_RISK"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "No Risk" "50" is displayed
    When User clicks on Risk Level Filter "No Risk" "50"
    Then Screening results table is loaded
    And Media Check Result Table should contain 50 records
    And First and last article name should matched with the previous selected first and last article name
    And Media check showing articles must be "50"
    And All media check articles must be marked as "No Risk"

  @C40091508
  Scenario: C40091508: Media Resolution - No Risk - Verify media resolution section is correct
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "NO_RISK"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "No Risk" "10" is displayed
    When User clicks on Risk Level Filter "No Risk" "10"
    Then Screening results table is loaded
    And Risk Level label is displayed
    And Risk Level options are displayed
    And Risk Level options are not selected by default
    And Comment label is displayed
    And Media check pagination is not visible
    When User random 2003 characters
    And User fills in random comment characters
    Then Media Check attach button is disable
    When User selects Third-party Media Check screening record on position 1
    Then Media Check attach button is disable
    When User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "CANCEL" Media Check Attach modal button
    Then Screening results table is loaded
    When User deletes Comment Media Resolution
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "CANCEL" Media Check Attach modal button
    Then Screening results table is loaded
    When User selects Third-party Media Check screening record on position 1
    Then Media Check attach button is disable

  @C40091509
  Scenario: C40091509: Media Resolution - No Risk - Verify Select All check box is working correctly
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "NO_RISK"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "No Risk" "10" is displayed
    When User clicks on Risk Level Filter "No Risk" "10"
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    And Clear All button is displayed
    When User clicks on select all checkBox of media check page
    Then Media Check does not displays 10 items selected
    And Clear All button is disappeared

  @C40091510
  Scenario: C40091510: Media Resolution - No Risk - Verify Clear All link label is working correctly
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "NO_RISK"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "No Risk" "10" is displayed
    When User clicks on Risk Level Filter "No Risk" "10"
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    And Clear All button is displayed
    When User clicks clear all button
    Then Media Check does not displays 10 items selected
    And Clear All button is disappeared

  @C40091511
  Scenario: C40091511: Media Resolution - No Risk - Verify "X items selected" link label filters only the selected articles
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "NO_RISK"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "No Risk" "10" is displayed
    When User clicks on Risk Level Filter "No Risk" "10"
    Then Screening results table is loaded
    When User selects Third-party Media Check screening record on position 1
    And User selects Third-party Media Check screening record on position 2
    And User selects Third-party Media Check screening record on position 3
    Then Media Check displays 3 items selected
    And Clear All button is displayed
    When User clicks on 3 items selected link
    Then Media Check items selected link Change to "Back to the full list" is displayed
    And Clear All button is displayed
    And Media Check Result Table should contain 3 records
    When User clicks Back to the full list Link
    Then Media Check displays 3 items selected
    And Clear All button is displayed

  @C40091934
  Scenario: C40091934: Media Resolution - Unknown - user must see No Match Found in Unknown filter if articles are not marked as Unknown and user must not see Mark All As Review button
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Unknown" "0" is displayed
    When User clicks on Risk Level Filter "Unknown" "0"
    Then Screening results table is loaded
    And MEDIA CHECK tab screening result contains No Match Found
    And Mark all as reviewed button is not displayed

  @C40091936
  Scenario: C40091936: Media Resolution - Unknown - user must see only articles that has its Risk Level marked as Unknown
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects "50" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    And Media Check Result Table should contain 50 records
    When User clicks on select all checkBox of media check page
    And User gets Third-party media check screening first and last record
    Then Media Check displays 50 items selected
    When User selects risk level as "UNKNOWN"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Unknown" "50" is displayed
    When User clicks on Risk Level Filter "Unknown" "50"
    Then Screening results table is loaded
    And Media Check Result Table should contain 50 records
    And First and last article name should matched with the previous selected first and last article name
    And Media check showing articles must be "50"
    And All media check articles must be marked as "Unknown"

  @C40091937
  Scenario: C40091937: Media Resolution - Unknown - Verify media resolution section is correct
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "UNKNOWN"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Unknown" "10" is displayed
    When User clicks on Risk Level Filter "Unknown" "10"
    Then Screening results table is loaded
    And Risk Level label is displayed
    And Risk Level options are displayed
    And Risk Level options are not selected by default
    And Comment label is displayed
    And Media check pagination is not visible
    When User random 2003 characters
    And User fills in random comment characters
    Then Media Check attach button is disable
    When User selects Third-party Media Check screening record on position 1
    Then Media Check attach button is disable
    When User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "CANCEL" Media Check Attach modal button
    Then Screening results table is loaded
    When User deletes Comment Media Resolution
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "CANCEL" Media Check Attach modal button
    Then Screening results table is loaded
    When User selects Third-party Media Check screening record on position 1
    Then Media Check attach button is disable

  @C40091938
  Scenario: C40091938: Media Resolution - Unknown - Verify Select All check box is working correctly
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "UNKNOWN"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Unknown" "10" is displayed
    When User clicks on Risk Level Filter "Unknown" "10"
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    And Clear All button is displayed
    When User clicks on select all checkBox of media check page
    Then Media Check does not displays 10 items selected
    And Clear All button is disappeared

  @C40091939
  Scenario: C40091939: Media Resolution - Unknown - Verify Clear All link label is working correctly
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "UNKNOWN"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Unknown" "10" is displayed
    When User clicks on Risk Level Filter "Unknown" "10"
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    And Clear All button is displayed
    When User clicks clear all button
    Then Media Check does not displays 10 items selected
    And Clear All button is disappeared

  @C40091940
  Scenario: C40091940: Media Resolution - Unknown - Verify "X items selected" link label filters only the selected articles
    When User creates third-party "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "UNKNOWN"
    And User clicks attach button
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "Unknown" "10" is displayed
    When User clicks on Risk Level Filter "Unknown" "10"
    Then Screening results table is loaded
    When User selects Third-party Media Check screening record on position 1
    And User selects Third-party Media Check screening record on position 2
    And User selects Third-party Media Check screening record on position 3
    Then Media Check displays 3 items selected
    And Clear All button is displayed
    When User clicks on 3 items selected link
    Then Media Check items selected link Change to "Back to the full list" is displayed
    And Clear All button is displayed
    And Media Check Result Table should contain 3 records
    When User clicks Back to the full list Link
    Then Media Check displays 3 items selected
    And Clear All button is displayed