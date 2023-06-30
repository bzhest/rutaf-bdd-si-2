@ui @full_regression @core_regression @arabica

Feature: Associated Individual - Media Check - Media Resolution / Filtering

  As an RDDC User,
  I want a button for items selected
  So that I can filter to see only the articles that I select

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "Bank of China" via API and open it

  @C42712128
  Scenario: C42712128: Associated Individual - Verify the user should be redirected to the recently view article on the main screening page when user selected Risk Level = High and MEDIUM and LOW
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects "25" option from Rows Per Page dropdown list
    Then Media Check Result Table should contain 25 records
    When User clicks on select all checkBox of media check page
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks next page
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    And User selects risk level as "MEDIUM"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks next page
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    And User selects risk level as "LOW"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "High" "25" is displayed
    When User clicks on Risk Level Filter "High" "25"
    Then Media Check Result Table should contain 25 records
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 13
    Then Screening result profile details is displayed
    When User clicks on third-party back button
    Then Screening results table is loaded
    And Media Check Risk Level Filter "High" is selected
    And Media Check Result Table should contain 25 records
    And Media Check Risk Level Filter "Medium" "25" is displayed
    When User clicks on Risk Level Filter "Medium" "25"
    Then Media Check Result Table should contain 25 records
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 13
    Then Screening result profile details is displayed
    When User clicks on third-party back button
    Then Screening results table is loaded
    And Media Check Risk Level Filter "Medium" is selected
    And Media Check Result Table should contain 25 records
    And Media Check Risk Level Filter "Low" "25" is displayed
    When User clicks on Risk Level Filter "Low" "25"
    Then Media Check Result Table should contain 25 records
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 13
    Then Screening result profile details is displayed
    When User clicks on third-party back button
    Then Screening results table is loaded
    And Media Check Risk Level Filter "Low" is selected
    And Media Check Result Table should contain 25 records

  @C42712128
  Scenario: C42712128: Associated Individual - Verify the user should be redirected to the recently view article on the main screening page when user selected Risk Level = NO_RISK and UNKNOWN
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects "25" option from Rows Per Page dropdown list
    Then Media Check Result Table should contain 25 records
    When User clicks on select all checkBox of media check page
    And User selects risk level as "NO_RISK"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And User clicks next page
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    And Media Check Risk Level Filter "No Risk" "25" is displayed
    When User clicks on Risk Level Filter "No Risk" "25"
    Then Media Check Result Table should contain 25 records
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 13
    Then Screening result profile details is displayed
    When User clicks on third-party back button
    Then Screening results table is loaded
    And Media Check Risk Level Filter "No Risk" is selected
    And Media Check Result Table should contain 25 records
    And Media Check Risk Level Filter "Unknown" "25" is displayed
    When User clicks on Risk Level Filter "Unknown" "25"
    Then Media Check Result Table should contain 25 records
    And Screening results table is loaded
    When User clicks on Media Check screening record on position 13
    Then Screening result profile details is displayed
    When User clicks on third-party back button
    Then Screening results table is loaded
    And Media Check Risk Level Filter "Unknown" is selected
    And Media Check Result Table should contain 25 records

  @C42712511
  Scenario: C42712511: Associated Individual - Verify the user should see X Items Selected articles when user navigate back from screening detail page when user selects Risk Level = HIGH
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks next page
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    And User selects risk level as "MEDIUM"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks next page
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    And User selects risk level as "LOW"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "High" "10" is displayed
    When User clicks on Risk Level Filter "High" "10"
    And Screening results table is loaded
    Then Media Check Result Table should contain 10 records
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    Then Media Check displays 3 items selected
    # TODO uncomment step when RMS-20931 will be fixed
#    When User clicks on 3 items selected link
#    Then Media Check items selected link Change to "Back to the full list" is displayed
#    When User clicks on Media Check screening record on position 2
#    Then Screening result profile details is displayed
#    When User clicks on third-party back button
#    Then Screening results table is loaded
#    And Media Check items selected link Change to "Back to the full list" is displayed
#    And Media check screening record on position 1 is checked
#    And Media check screening record on position 2 is checked
#    And Media check screening record on position 3 is checked
    Then Media Check Risk Level Filter "Medium" "10" is displayed
    When User clicks on Risk Level Filter "Medium" "10"
    And Screening results table is loaded
    Then Media Check Result Table should contain 10 records
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    Then Media Check displays 3 items selected
    # TODO uncomment step when RMS-20931 will be fixed
#    When User clicks on 3 items selected link
#    Then Media Check items selected link Change to "Back to the full list" is displayed
#    When User clicks on Media Check screening record on position 2
#    Then Screening result profile details is displayed
#    When User clicks on third-party back button
#    Then Screening results table is loaded
#    And Media Check items selected link Change to "Back to the full list" is displayed
#    And Media check screening record on position 1 is checked
#    And Media check screening record on position 2 is checked
#    And Media check screening record on position 3 is checked
    Then Media Check Risk Level Filter "Low" "10" is displayed
    When User clicks on Risk Level Filter "Low" "10"
    And Screening results table is loaded
    Then Media Check Result Table should contain 10 records
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    Then Media Check displays 3 items selected
    # TODO uncomment step when RMS-20931 will be fixed
#    When User clicks on 3 items selected link
#    Then Media Check items selected link Change to "Back to the full list" is displayed
#    When User clicks on Media Check screening record on position 2
#    Then Screening result profile details is displayed
#    When User clicks on third-party back button
#    Then Screening results table is loaded
#    And Media Check items selected link Change to "Back to the full list" is displayed
#    And Media check screening record on position 1 is checked
#    And Media check screening record on position 2 is checked
#    And Media check screening record on position 3 is checked

  @C42712511
  Scenario: C42712511: Associated Individual - Verify the user should see X Items Selected articles when user navigate back from screening detail page when user selects Risk Level = NO_RISK and UNKNOWN
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    And User selects risk level as "NO_RISK"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks next page
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Filter icon in Media Check tab
    Then Media Check Risk Level Filter "No Risk" "10" is displayed
    When User clicks on Risk Level Filter "No Risk" "10"
    And Screening results table is loaded
    Then Media Check Result Table should contain 10 records
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    Then Media Check displays 3 items selected
    # TODO uncomment step when RMS-20931 will be fixed
#    When User clicks on 3 items selected link
#    Then Media Check items selected link Change to "Back to the full list" is displayed
#    When User clicks on Media Check screening record on position 2
#    Then Screening result profile details is displayed
#    When User clicks on third-party back button
#    Then Screening results table is loaded
#    And Media Check items selected link Change to "Back to the full list" is displayed
#    And Media check screening record on position 1 is checked
#    And Media check screening record on position 2 is checked
#    And Media check screening record on position 3 is checked
    Then Media Check Risk Level Filter "Unknown" "10" is displayed
    When User clicks on Risk Level Filter "Unknown" "10"
    And Screening results table is loaded
    Then Media Check Result Table should contain 10 records
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    Then Media Check displays 3 items selected
    # TODO uncomment step when RMS-20931 will be fixed
#    When User clicks on 3 items selected link
#    Then Media Check items selected link Change to "Back to the full list" is displayed
#    When User clicks on Media Check screening record on position 2
#    Then Screening result profile details is displayed
#    When User clicks on third-party back button
#    Then Screening results table is loaded
#    And Media Check items selected link Change to "Back to the full list" is displayed
#    And Media check screening record on position 1 is checked
#    And Media check screening record on position 2 is checked
#    And Media check screening record on position 3 is checked

  @C40119591
  Scenario: C40119591: Associated Individual - Media Resolution - Pending Review - Verify media resolution section is correct
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tinsss."
    Then Media Check attach button is disable
    When User selects Associated Party Individual Media Check screening record on position 1
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
    When User selects Associated Party Individual Media Check screening record on position 1
    Then Media Check attach button is disable

  @C40119592
  Scenario: C40119592: Associated Individual - Media Resolution - Pending Review -  Verify Select All check box is working correctly
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    And Clear All button is displayed
    When User clicks on select all checkBox of media check page
    Then Media Check does not displays 10 items selected
    And Clear All button is disappeared
    When User selects "25" option from Rows Per Page dropdown list
    Then Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 25 items selected
    And Clear All button is displayed
    When User clicks clear all button
    Then Clear All button is disappeared
    And  Media Check does not displays 25 items selected

  @C40119593
  Scenario: C40119593: Associated Individual - Media Resolution - Pending Review -  Verify records can be selected across the page
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    And Clear All button is displayed
    When User clicks next page
    Then Screening results table is loaded
    And Media Check displays 10 items selected
    And Clear All button is displayed
    And  Media Check Result 10 Records is not checked
    When User clicks on select all checkBox of media check page
    Then Media Check displays 20 items selected
    And Clear All button is displayed
    And Media Check Result 10 Records is checked
    When User clicks previous page
    Then Media Check displays 20 items selected
    And Clear All button is displayed
    And Media Check Result 10 Records is checked

  @C40119596
  Scenario: C40119596: Associated Individual - Media Resolution - Pending Review - Verify "X items selected" link label filters only the selected articles
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    And User clicks next page
    And User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    Then Media Check displays 6 items selected
    And Clear All button is displayed
    When User clicks on 6 items selected link
    Then Media Check items selected link Change to "Back to the full list" is displayed
    And Clear All button is displayed
    And Media Check Result Table should contain 6 records
    When User clicks Back to the full list Link
    Then Media Check displays 6 items selected
    And Clear All button is displayed

  @C40119595
  Scenario: C40119595: Associated Individual - Media Resolution - Pending Review - Verify Clear All link label clear all the records that are across the page
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    And Clear All button is displayed
    When User clicks next page
    Then Screening results table is loaded
    And  Media Check Result 10 Records is not checked
    And Media Check displays 10 items selected
    And Clear All button is displayed
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    Then Media Check displays 13 items selected
    And Clear All button is displayed
    When User clicks clear all button
    Then Clear All button is disappeared
    And  Media Check Result 10 Records is not checked
    Then Media Check does not displays 13 items selected
    When User clicks previous page
    And  Media Check Result 10 Records is not checked

  @C40119597
  Scenario: C40119597: Associated Individual - Media Resolution - Pending Review - Verify Attach pop up modal
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects risk level as "HIGH"
    And User fills in comment "Fills in comment"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"Fills in comment"
    And Media Resolution Tag as red flag is turn off
    When User clicks "CANCEL" Media Check Attach modal button
    Then Screening results table is loaded
    When User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    And User selects risk level as "MEDIUM"
    And User deletes Comment Media Resolution
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Medium", Comment:" - "
    And Media Resolution Tag as red flag is turn off

  @C40119598
  Scenario: C40119598: Associated Individual - Media Resolution - Pending Review - Verify  user can assign Risk Level and Comment when user turns on "X items selected" filter
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    Then Media Check displays 3 items selected
    When User clicks next page
    And User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    Then Media Check displays 6 items selected
    When User selects risk level as "HIGH"
    And User fills in comment "Test assigning resolution with comment for article with X items selected filter"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"Test assigning resolution with comment for article with X items selected filter"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Contacts Media Check screening record on position 1 displays High icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for article with X items selected filter" is displayed on record 1
    And Contacts Media Check screening record on position 2 displays High icon
    When User hovers Media Check Risk Level icon on Screening record 2
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for article with X items selected filter" is displayed on record 2
    And Contacts Media Check screening record on position 3 displays High icon
    When User hovers Media Check Risk Level icon on Screening record 3
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for article with X items selected filter" is displayed on record 3
    When User clicks previous page
    Then Screening results table is loaded
    And Contacts Media Check screening record on position 1 displays High icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for article with X items selected filter" is displayed on record 1
    And Contacts Media Check screening record on position 2 displays High icon
    When User hovers Media Check Risk Level icon on Screening record 2
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for article with X items selected filter" is displayed on record 2
    And Contacts Media Check screening record on position 3 displays High icon
    When User hovers Media Check Risk Level icon on Screening record 3
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for article with X items selected filter" is displayed on record 3

  @C40119599
  Scenario: C40119599: Associated Individual - Media Resolution - Pending Review - Single Record - Same Page - user can mark article with High risk (with comment)
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects risk level as "HIGH"
    And User fills in comment "Test assigning resolution with comment for article with X items selected filter"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:"Test assigning resolution with comment for article with X items selected filter"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Contacts Media Check screening record on position 1 displays High icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for article with X items selected filter" is displayed on record 1

  @C4011960
  Scenario: C40119600: Associated Individual - Media Resolution - Pending Review - Batch Record- Same Page - Verify user can mark article with Medium risk (without comment)
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    And User selects risk level as "MEDIUM"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Medium", Comment:" - "
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Contacts Media Check screening record on position 1 displays Medium icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 1
    And Contacts Media Check screening record on position 2 displays Medium icon
    When User hovers Media Check Risk Level icon on Screening record 2
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 2
    And Contacts Media Check screening record on position 3 displays Medium icon
    When User hovers Media Check Risk Level icon on Screening record 3
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 3

  @C40119601
  Scenario: C40119601: Associated Individual - Media Resolution - Pending Review - Batch Record - Different Page - Verify user can mark article with Low risk (with comment)
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    Then Media Check displays 3 items selected
    When User clicks next page
    And User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects Associated Party Individual Media Check screening record on position 3
    Then Media Check displays 6 items selected
    When User selects risk level as "LOW"
    And User fills in comment "Test assigning resolution with comment for batch different page record"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Low", Comment:"Test assigning resolution with comment for batch different page record"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Contacts Media Check screening record on position 1 displays Low icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for batch different page record" is displayed on record 1
    And Contacts Media Check screening record on position 2 displays Low icon
    When User hovers Media Check Risk Level icon on Screening record 2
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for batch different page record" is displayed on record 2
    And Contacts Media Check screening record on position 3 displays Low icon
    When User hovers Media Check Risk Level icon on Screening record 3
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for batch different page record" is displayed on record 3
    When User clicks previous page
    Then Screening results table is loaded
    And Contacts Media Check screening record on position 1 displays Low icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for batch different page record" is displayed on record 1
    And Contacts Media Check screening record on position 2 displays Low icon
    When User hovers Media Check Risk Level icon on Screening record 2
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for batch different page record" is displayed on record 2
    And Contacts Media Check screening record on position 3 displays Low icon
    When User hovers Media Check Risk Level icon on Screening record 3
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for batch different page record" is displayed on record 3

  @C40119602
  Scenario: C40119602: Associated Individual - Media Resolution - Pending Review - Select All Record - Same Page - user can mark article with No Risk (with comment)
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User selects risk level as "NO_RISK"
    And User fills in comment "Test assigning resolution with comment for Select all same page record"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"No Risk", Comment:"Test assigning resolution with comment for Select all same page record"
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Contacts Media Check screening record on position 1 displays No Risk icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for Select all same page record" is displayed on record 1
    And Contacts Media Check screening record on position 3 displays No Risk icon
    When User hovers Media Check Risk Level icon on Screening record 3
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for Select all same page record" is displayed on record 3
    And Contacts Media Check screening record on position 5 displays No Risk icon
    When User hovers Media Check Risk Level icon on Screening record 5
    Then Media Check Risk Level ToolTip "Test assigning resolution with comment for Select all same page record" is displayed on record 5

  @C40119603
  Scenario: C40119603: Associated Individual - Media Resolution - Pending Review - Select All Record - Different Page - user can mark article with Unknown (without comment)
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 10 items selected
    When User clicks next page
    And User clicks on select all checkBox of media check page
    Then Media Check displays 20 items selected
    When User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Unknown", Comment:" - "
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Contacts Media Check screening record on position 1 displays Unknown icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 1
    And Contacts Media Check screening record on position 3 displays Unknown icon
    When User hovers Media Check Risk Level icon on Screening record 3
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 3
    And Contacts Media Check screening record on position 5 displays Unknown icon
    When User hovers Media Check Risk Level icon on Screening record 5
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 5
    When User clicks previous page
    And Screening results table is loaded
    And Contacts Media Check screening record on position 1 displays Unknown icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 1
    And Contacts Media Check screening record on position 3 displays Unknown icon
    When User hovers Media Check Risk Level icon on Screening record 3
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 3
    And Contacts Media Check screening record on position 5 displays Unknown icon
    When User hovers Media Check Risk Level icon on Screening record 5
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 5

  @C40160822
  Scenario: C40160822: Associated Individual - Media Check Tab - Screening - Attached Risk Level - Verify  Add toast message and forbid when the user tries to attach article with old risk level
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
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
    And Contacts Media Check screening record on position 1 displays Unknown icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 1
    When User selects Third-party Media Check screening record on position 1
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:" - "
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Toast message "Error! This article has already been attached" is displayed

  @C40160832
  Scenario: C40160832: Associated Individual - Media Check Tab - Screening - Attached Risk Level - Verify  risk level is attach to article which has no risk level  when the user tries to attach  1  article with old risk level  and 1 article with no risk level
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Unknown", Comment:" - "
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Contacts Media Check screening record on position 1 displays Unknown icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 1
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects Associated Party Individual Media Check screening record on position 2
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"High", Comment:" - "
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And Contacts Media Check screening record on position 1 displays Unknown icon
    When User hovers Media Check Risk Level icon on Screening record 1
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 1
    And Contacts Media Check screening record on position 2 displays High icon
    When User hovers Media Check Risk Level icon on Screening record 2
    Then Media Check Risk Level ToolTip "No Risk reason indicated" is displayed on record 2

  @C40166645
  Scenario: C40166645: Associated Individual - Media Check Tab - Media Resolution box - Attached Risk Level - Verify  Display toast message when the user is trying to select more than 200 articles [200 articles have been attached with a risk level]
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
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
    When User selects Associated Party Individual Media Check screening record on position 1
    Then Media Check displays 1 items selected
    And Clear All button is displayed
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    And Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Unknown", Comment:" - "
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Toast message "Error! You cannot attach more than 200 articles to a case. Please check the number of articles selected and try again." is displayed
    And Clear All button is disappeared
    And Media Check attach button is disable

  @C40166644
  Scenario: C40166644: Associated Individual - Media Check Tab - Media Resolution box - Attached Risk Level - Verify  Display toast message when the user is trying to select more than 200 articles [200 articles have not been attached with a risk level]
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
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
    When User clicks next page
    And User selects Associated Party Individual Media Check screening record on position 1
    Then Toast message "Error! You have exceeded the number of selected headlines. Please reduce selection to 200 headlines." is displayed
    And Media Check displays 201 items selected

  @C39925939
  Scenario: C39925939: Associated Individual - Media Check Tab - Media Resolution box - Attached Risk Level - Verify  Display toast message when the user is trying to select more than 200 articles[ some articles have been attached with a risk level and some not]
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then "MEDIA CHECK" tab is displayed
    And Screening results table is loaded
    When User selects "50" option from Rows Per Page dropdown list
    Then Media Check Result Table should contain 50 records
    And Screening results table is loaded
    When User clicks on select all checkBox of media check page
    Then Media Check displays 50 items selected
    When User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    And Media Check attach modal is displayed data as Risk level:"Unknown", Comment:" - "
    And Media Resolution Tag as red flag is turn off
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    And User clicks on select all checkBox of media check page
    And Media Check displays 50 items selected
    When User clicks next page
    And User clicks on select all checkBox of media check page
    Then Media Check displays 100 items selected
    When User clicks next page
    And User clicks on select all checkBox of media check page
    Then Media Check displays 150 items selected
    When User clicks next page
    And User clicks on select all checkBox of media check page
    Then Media Check displays 200 items selected
    When User clicks next page
    And User selects Associated Party Individual Media Check screening record on position 1
    Then Toast message "Error! You have exceeded the number of selected headlines. Please reduce selection to 200 headlines." is displayed
    And Media Check displays 201 items selected