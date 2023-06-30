@ui @core_regression @questionnaire @arabica

Feature: EnhancedTextEntryPlus Questionnaire

  As an RDDC user who has a permission to create associated parties from EnhancedTextEntryPlus Questionnaire.
  I want to apply the auto-screening default configuration to all associated parties created from EnhancedTextEntryPlus Questionnaire.
  So that I can customize auto-screen applied to all associated parties from EnhancedTextEntryPlus Questionnaire.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API

  @C48210852
  @onlySingleThread
  Scenario: C48210852: External -  Verify An associated party will be with auto-screen and ongoing screening
    When User creates third-party "Bank of China"
    And User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new associated party" is turned "Off"
    When User clicks on Enable screening when adding new associated party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new associated party" is turned "On"
    And Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "Off"
    When User clicks on Enable World-Check and Custom Watchlist Ongoing Screening toggle
    And User clicks save button
    Then Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "On"
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "External_Questionnaire_User"
    And User clicks edit user button for user with First Name "External_Questionnaire_User"
    Then Edit User page is displayed
    When User selects "Bank of China" user Third-party
    And User checks 'Active' Edit User checkbox
    Then User clicks 'Submit' button on User Page
    When User navigates to Questionnaire Management page
    And User searches questionnaire "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    And User clicks edit questionnaire with name "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    Then Add Questionnaire setup page displayed
    When User selects "Active" questionnaire status
    And User selects in Question Assignee Type "External"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Mapping icon
    And User toggles "Auto screen against World Check"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Success!                       |
      | Questionnaire has been updated |
    When User navigates to Third-party page
    And User opens previously created Third-party
    And User clicks on Questionnaire tab
    Then Questionnaire tab is loaded
    When User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_Questionnaire_User" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User logs into RDDC as "External User for Questionnaire"
    And User click on "Due within 5 days" widget for External user
    And User clicks first activity for third-party "thirdPartyName"
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS" in Questionnaire Details table
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "enhancedText" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS" status should be "Submitted"
    When User logs into RDDC as "Admin"
    And User opens previously created Third-party
    And User clicks Notification Bell
    And User clicks "Questionnaire to Review" "External Questionnaire for thirdPartyName" notification
    Then Activity Information page is displayed
    When User clicks review questionnaires
    Then Questionnaire details page is displayed
    When User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    When User clicks on "Associated Parties" tab on Third-party page
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name      | Last Name      | Country | Status   |
      | false         |       | Auto First Name | Auto Last Name |         | Inactive |
    When User clicks on Associated Party with name "Auto First Name"
    Then Screening results table is loaded
    And No Available Data on "WORLD-CHECK" tab is displayed
    And OGS slider is turned ON
    When User navigates to Questionnaire Management page
    And User searches questionnaire "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    And User clicks edit questionnaire with name "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    Then Add Questionnaire setup page displayed
    When User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Mapping icon
    And User toggles "Auto screen against World Check"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Success!                       |
      | Questionnaire has been updated |

  @C48212986
  @onlySingleThread
  Scenario: C48212986: External -  Verify An associated party will be without auto-screen and ongoing screening due to the configuration at questionnaire setting is OFF
    When User creates third-party "Bank of China"
    And User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new associated party" is turned "Off"
    When User clicks on Enable screening when adding new associated party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new associated party" is turned "On"
    And Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "Off"
    When User clicks on Enable World-Check and Custom Watchlist Ongoing Screening toggle
    And User clicks save button
    Then Screening Settings "Enable World-Check and Custom Watchlist Ongoing Screening" is turned "On"
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "External_Questionnaire_User"
    And User clicks edit user button for user with First Name "External_Questionnaire_User"
    Then Edit User page is displayed
    When User selects "Bank of China" user Third-party
    And User checks 'Active' Edit User checkbox
    Then User clicks 'Submit' button on User Page
    When User navigates to Questionnaire Management page
    And User searches questionnaire "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    And User clicks edit questionnaire with name "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    Then Add Questionnaire setup page displayed
    When User selects "Active" questionnaire status
    And User selects in Question Assignee Type "External"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Mapping icon
    And User toggles "Auto screen against World Check"
    And User toggles "Auto screen against World Check"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Success!                       |
      | Questionnaire has been updated |
    When User navigates to Third-party page
    And User opens previously created Third-party
    And User clicks on Questionnaire tab
    Then Questionnaire tab is loaded
    When User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_Questionnaire_User" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User logs into RDDC as "External User for Questionnaire"
    And User click on "Due within 5 days" widget for External user
    And User clicks first activity for third-party "thirdPartyName"
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS" in Questionnaire Details table
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "enhancedText" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS" status should be "Submitted"
    When User logs into RDDC as "Admin"
    And User opens previously created Third-party
    And User clicks Notification Bell
    And User clicks "Questionnaire to Review" "External Questionnaire for thirdPartyName" notification
    Then Activity Information page is displayed
    When User clicks review questionnaires
    Then Questionnaire details page is displayed
    When User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    When User clicks on "Associated Parties" tab on Third-party page
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name      | Last Name      | Country | Status   |
      | false         |       | Auto First Name | Auto Last Name |         | Inactive |
    When User clicks on Associated Party with name "Auto First Name"
    Then Screening results table is loaded
    And No Available Data on "WORLD-CHECK" tab is displayed
    And OGS Toggle is disable
    And Enable screening button is displayed
    When User navigates to Questionnaire Management page
    And User searches questionnaire "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    And User clicks edit questionnaire with name "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    Then Add Questionnaire setup page displayed
    When User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Success!                       |
      | Questionnaire has been updated |

  @C48212985
  @onlySingleThread
  Scenario: C48212985: External -  Verify An associated party will be with auto-screen* and ongoing screening will be based on whether the default ongoing screening configuration is turned ON or OFF
    When User creates third-party "Bank of China"
    And User navigates 'Set Up' block 'Screening Management' section
    Then Screening Management page is displayed
    And Screening Settings "Enable screening when adding new third-party" is turned "On"
    When User clicks on Enable screening when adding new third-party toggle
    And User clicks save button
    Then Screening Settings "Enable screening when adding new third-party" is turned "Off"
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "External_Questionnaire_User"
    And User clicks edit user button for user with First Name "External_Questionnaire_User"
    Then Edit User page is displayed
    When User selects "Bank of China" user Third-party
    And User checks 'Active' Edit User checkbox
    Then User clicks 'Submit' button on User Page
    When User navigates to Questionnaire Management page
    And User searches questionnaire "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    And User clicks edit questionnaire with name "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    Then Add Questionnaire setup page displayed
    When User selects "Active" questionnaire status
    And User selects in Question Assignee Type "External"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Mapping icon
    And User toggles "Auto screen against World Check"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Success!                       |
      | Questionnaire has been updated |
    When User navigates to Third-party page
    And User opens previously created Third-party
    And User clicks on Questionnaire tab
    Then Questionnaire tab is loaded
    When User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_Questionnaire_User" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User logs into RDDC as "External User for Questionnaire"
    And User click on "Due within 5 days" widget for External user
    And User clicks first activity for third-party "thirdPartyName"
    And User clicks "Answer" button for Activity "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS" in Questionnaire Details table
    And User answers Question "EnhancedTextEntryPlus" on tab 0 with "enhancedText" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS" status should be "Submitted"
    When User logs into RDDC as "Admin"
    And User opens previously created Third-party
    And User clicks Notification Bell
    And User clicks "Questionnaire to Review" "External Questionnaire for thirdPartyName" notification
    Then Activity Information page is displayed
    When User clicks review questionnaires
    Then Questionnaire details page is displayed
    When User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    And User clicks on "Associated Parties" tab on Third-party page
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name      | Last Name      | Country | Status   |
      | false         |       | Auto First Name | Auto Last Name |         | Inactive |
    When User clicks on Associated Party with name "Auto First Name"
    Then Screening results table is loaded
    And No Available Data on "WORLD-CHECK" tab is displayed
    And OGS slider is turned OFF
    When User navigates to Questionnaire Management page
    And User searches questionnaire "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    And User clicks edit questionnaire with name "AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS"
    Then Add Questionnaire setup page displayed
    When User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Mapping icon
    And User toggles "Auto screen against World Check"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Success!                       |
      | Questionnaire has been updated |