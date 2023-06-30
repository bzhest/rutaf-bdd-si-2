@ui @full_regression @core_regression @arabica

Feature: Third-party Screening Results/Record Details Page

  As a user
  I want all type of WC system to display in the Connections/Relationships tab.
  So that I can see the information in RDDC.

  @C39520318
  Scenario: C39520318: third-Party - screening results - Verify Risk level/Reason - Verify display Risk Level and Reason in the WC1 View Record Page
    Given User logs into RDDC as "Admin"
    And User creates third-party "Apple"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
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

  @C39520320
  Scenario: C39520320: third-Party - screening results - Verify Rearrange the positions of Reviewer Details
    Given User logs into RDDC as "Admin"
    And User creates third-party "Apple"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
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

  @C39520324
  Scenario: C39520324: third-Party - screening results - Verify Can turn on/off tag as red flag button in WC1 Record Details page
    Given User logs into RDDC as "Admin"
    And User creates third-party "Apple"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Screening profile's Resolution is displayed
    And 'Tag as red flag' is turned off
    When User turns On 'Tag as red flag' on Screening Profile page
    Then Toast message "Success! Tag as red flag has been updated." is displayed
    And 'Tag as red flag' is turned on
    When User turns Off 'Tag as red flag' on Screening Profile page
    Then Toast message "Success! Tag as red flag has been updated." is displayed
    And 'Tag as red flag' is turned off

  @C39520325
  Scenario: C39520325: third-Party - screening results - Verify Can  select and unselected resolution type in WC1 Record Details page
    Given User logs into RDDC as "Admin"
    And User creates third-party "Apple"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Screening profile's Resolution is displayed
    And 'Tag as red flag' is turned off
    And Resolution type contains following tooltip text when hover on it
      | Positive |
      | Possible |
      | False    |
    When User clicks resolve screening profile under number 1 record as "POSITIVE"
    Then Add Comment modal is displayed
    And User selects "Medium" Risk Level
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

  @C39520327
  Scenario: C39520327: third-Party - screening results - Verify 'Legal Notice' in the footer
    Given User logs into RDDC as "Admin"
    And User creates third-party "Apple"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And "Legal Notice" profile details is displayed
    When User clicks screening profile Legal Notice link
    Then New window should be opened