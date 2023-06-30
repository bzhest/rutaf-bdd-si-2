@ui @full_regression @core_regression @arabica

Feature: Associated Individual Other Names Screening Results

  As a user
  I want all type of WC system to display in the Connections/Relationships tab.
  So that I can see the information in RDDC.

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"
    And User creates Associated Party "with mandatory fields"

  @C39520362
  Scenario: C39520362: Associated Individual Other Names - screening results - Verify Risk level/Reason - Verify display Risk Level and Reason in the WC1 View Record Page
    When User creates Other name "Vladimir PUTIN" for Associated Party
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

  @C39520364
  Scenario: C39520364: Associated Individual Other Names - screening results - Verify Rearrange the positions of Reviewer Details
    When User creates Other name "Barac Obama" for Associated Party
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
    Then 'Tag as red flag' is turned on
    And Risk Level value on Screening profile page is "MEDIUM"
    And Reason value on Screening profile page is "FULL MATCH"
    When User adds screening record "User" "Admin_AT_FN Admin_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review button is enabled

  @C48725912
  Scenario: C48725912: Associated Individual Other Names - screening results - Verify Can turn on/off tag as red flag button in WC1 Record Details page
    When User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then Screening result profile details is displayed
    And Screening profile's Resolution is displayed
    And 'Tag as red flag' is turned off
    When User turns On 'Tag as red flag' on Screening Profile page
    Then Toast message "Success! Tag as red flag has been updated." is displayed
    And 'Tag as red flag' is turned on
    And Screening profile's Resolution is displayed
    When User turns Off 'Tag as red flag' on Screening Profile page
    Then Toast message "Success! Tag as red flag has been updated." is displayed
    And 'Tag as red flag' is turned off

  @C48725916
  Scenario: C48725916: Associated Individual Other Names - screening results - Verify Can  select and unselected resolution type in WC1 Record Details page
    When User creates Other name "Barac Obama" for Associated Party
    Then Screening results table is loaded
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
    When User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    Then Toast message "Success! Resolution type has been removed." is displayed
    And Screening result profile details is displayed
    And Risk Level value on Screening profile page is "UNKNOWN"
    And Reason value on Screening profile page is "UNKNOWN"

  @C48725924
  Scenario: C48725924:  Associated Individual Other Names - screening results - Verify 'Legal Notice' in the footer
    When User creates Other name "Vladimir PUTIN" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then Screening result profile details is displayed
    And "Legal Notice" profile details is displayed
    When User clicks screening profile Legal Notice link
    Then New window should be opened