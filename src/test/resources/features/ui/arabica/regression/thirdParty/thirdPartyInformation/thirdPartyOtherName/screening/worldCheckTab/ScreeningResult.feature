@ui @full_regression @core_regression @arabica

Feature: Third-party Other Names Screening Results

  As a user
  I want all type of WC system to display in the Connections/Relationships tab.
  So that I can see the information in RDDC.

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"

  @C39515006
  Scenario: C39515006: third-Party Other Names - screening results - Verify Risk level/Reason - Verify display Risk Level and Reason in the WC1 View Record Page
    When User creates Other name "3M"
    And User opens screening results for "3M" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then Screening result profile details is displayed
    And Screening profile's Resolution is displayed
    And 'Tag as red flag' is turned off
    And Resolution type contains following tooltip text when hover on it
      | Positive |
      | Possible |
      | False    |
    When User clicks resolve screening profile under number 1 record as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Toast message "Success! Resolution type has been updated to positive." is displayed
    And Screening result profile details is displayed
    And 'Tag as red flag' is turned on
    And Risk Level value on Screening profile page is "MEDIUM"
    And Reason value on Screening profile page is "FULL MATCH"
    And Comment profile section contains expected text "Comment text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"

  @C39515008
  Scenario: C39515008: third-Party Other Names - screening results - Verify Rearrange the positions of Reviewer Details
    When User creates Other name "3M"
    And User opens screening results for "3M" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then Screening result profile details is displayed
    And Screening profile's Resolution is displayed
    When User clicks resolve screening profile under number 1 record as "POSITIVE"
    Then Add Comment modal is displayed
    When User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And 'Tag as red flag' is turned on
    And Risk Level value on Screening profile page is "MEDIUM"
    And Reason value on Screening profile page is "FULL MATCH"
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review button is enabled

  @C48651751
  Scenario: C48651751: third-Party Other Names - screening results - Verify Can turn on/off tag as red flag button in WC1 Record Details page
    When User creates Other name "3M"
    And User opens screening results for "3M" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then Screening result profile details is displayed
    And Screening profile's Resolution is displayed
    And 'Tag as red flag' is turned off
    When User turns On 'Tag as red flag' on Screening Profile page
    Then Toast message "Success! Tag as red flag has been updated." is displayed
    And 'Tag as red flag' is turned on
    When User turns Off 'Tag as red flag' on Screening Profile page
    Then Toast message "Success! Tag as red flag has been updated." is displayed
    And 'Tag as red flag' is turned off

  @C48651769
  Scenario: C48651769: third-Party Other Names - screening results - Verify Can  select and unselected resolution type in WC1 Record Details page
    When User creates Other name "3M"
    And User opens screening results for "3M" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then Screening result profile details is displayed
    And Screening profile's Resolution is displayed
    And 'Tag as red flag' is turned off
    And Resolution type contains following tooltip text when hover on it
      | Positive |
      | Possible |
      | False    |
    When User clicks resolve screening profile under number 1 record as "POSITIVE"
    Then Add Comment modal is displayed
    When User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Toast message "Success! Resolution type has been updated to positive." is displayed
    And Screening result profile details is displayed
    And Risk Level value on Screening profile page is "MEDIUM"
    And Reason value on Screening profile page is "FULL MATCH"
    When User clicks resolve screening profile under number 1 record as "POSITIVE"
    Then Add Comment modal is displayed
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    Then Toast message "Success! Resolution type has been removed." is displayed
    And Screening result profile details is displayed
    And Risk Level value on Screening profile page is "UNKNOWN"
    And Reason value on Screening profile page is "UNKNOWN"

  @C48651772
  Scenario: C48651772: third-Party Other Names - screening results - Verify 'Legal Notice' in the footer
    When User creates Other name "3M"
    And User opens screening results for "3M" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then Screening result profile details is displayed
    And "Legal Notice" profile details is displayed
    When User clicks screening profile Legal Notice link
    Then New window should be opened