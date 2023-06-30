@ui @robusta @full_regression @questionnaires
Feature: Third-party Information - Workflow Activity - Activity Visibility - Questionnaire Assigned Activity - Question Type

  As an Assignee of Questionnaire Activity
  I Want to be able to answer a questionnaire assigned to me
  So That I can answer the Questionnaire that has been assign to me


  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Questionnaire Management page
    And User clicks Add Questionnaire button
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"


  @C32987561
  Scenario: C32987561: Questionnaire Activity - UNRESPONDED - Date - Verify that user should be able to select future/past date or input date according to acceptable format
    When User adds question with type "Date" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User fills in Date on tab 0 value "06/13/2030"
    Then Question Date on tab 0 value is "06/13/2030"
    When User fills in Date on tab 0 value "06/13/2002"
    Then Question Date on tab 0 value is "06/13/2002"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C32987903
  Scenario: C32987903: Questionnaire Activity - UNRESPONDED - Multiple Choice - Verify that user should be able to select one value only
    When User adds question with type "Multiple Choice" to active tab
    And User clicks Configuration icon
    And User configures question with data "Question with 3 Choices"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User answers Question Multiple Choice on tab 0 with value "Check 1"
    Then Question Multiple Choice on tab 0 with value "Check 1" is checked
    When User answers Question Multiple Choice on tab 0 with value "Check 2"
    Then Question Multiple Choice on tab 0 with value "Check 2" is checked
    And Question Multiple Choice on tab 0 with value "Check 1" is unchecked
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C32987910
  Scenario: C32987910: Questionnaire Activity - UNRESPONDED - SingleSelect - Verify that user should be able to select one value only
    When User adds question with type "SingleSelect" to active tab
    And User clicks Configuration icon
    And User configures question with data "SingleSelect question configuration with 5 choices without attachment"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User answers Question Single Select on tab 0 with value "1"
    Then Question Single Select answer on tab 0 contains value "1"
    When User answers Question Single Select on tab 0 with value "2"
    Then Question Single Select answer on tab 0 contains value "2"
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C32987980
  Scenario: C32987980: Questionnaire Activity - UNRESPONDED - Checkbox- Verify that user should be able to select one or multiple value
    When User adds question with type "Checkbox" to active tab
    And User clicks Configuration icon
    And User configures question with data "Checkbox question configuration"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User checks Question Checkbox on tab 0 with value "1"
    And User checks Question Checkbox on tab 0 with value "2"
    And User checks Question Checkbox on tab 0 with value "3"
    And User checks Question Checkbox on tab 0 with value "4"
    Then Question Checkbox on tab 0 with value "1" is checked
    And Question Checkbox on tab 0 with value "2" is checked
    And Question Checkbox on tab 0 with value "3" is checked
    And Question Checkbox on tab 0 with value "4" is checked
    When User unchecks Question Checkbox on tab 0 with value "1"
    And User unchecks Question Checkbox on tab 0 with value "2"
    And User unchecks Question Checkbox on tab 0 with value "3"
    And User unchecks Question Checkbox on tab 0 with value "4"
    Then Question Checkbox on tab 0 with value "1" is unchecked
    And Question Checkbox on tab 0 with value "2" is unchecked
    And Question Checkbox on tab 0 with value "3" is unchecked
    And Question Checkbox on tab 0 with value "4" is unchecked
    When User checks Question Checkbox on tab 0 with value "2"
    Then Question Checkbox on tab 0 with value "2" is checked
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C32988016
  Scenario: C32988016: Questionnaire Activity - UNRESPONDED - Text - Verify that user should be able to input maximum of 5000 alphanumeric characters
    When User adds question with type "Text" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    Then Questionnaire answer form Text question input max length is "5000" symbols
    When User answers Question "Text" on tab 0 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C39439663
  Scenario: C39439663: Questionnaire Activity - UNRESPONDED - MultiSelect - Verify that user should be able to select one or multiple value
    When User adds question with type "MultiSelect" to active tab
    And User clicks Configuration icon
    And User configures question with data "MultiSelect question configuration without attachment"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User answers Question Multi Select on tab 0 with values
      | 1 |
      | 2 |
    Then Question Multi Select answer on tab 0 contains values
      | 1 |
      | 2 |
    When User searches and selects Question Multi Select on tab 0 with values
      | 3 |
    Then Question Multi Select answer on tab 0 contains values
      | 1 |
      | 2 |
      | 3 |
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C39439673
  Scenario: C39439673: Questionnaire Activity - UNRESPONDED - Boolean - Verify that user should be able to select one value only
    When User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User answers Question Boolean on tab 0 with value "Yes"
    Then Question Boolean on tab 0 with value "Yes" is checked
    When User answers Question Boolean on tab 0 with value "No"
    Then Question Boolean on tab 0 with value "No" is checked
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C39439676
  Scenario: C39439676: Questionnaire Activity - UNRESPONDED - Number - Verify that user should be able to input numeric value
    When User adds question with type "Number" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    Then Questionnaire answer form Number question input max length is "25" symbols
    When User answers Question "Number" on tab 0 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C39439722
  Scenario: C39439722: Questionnaire Activity - UNRESPONDED - Currency - Verify that user should be able to input numeric value and select currency
    When User adds question with type "Currency" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    When User answers Question "Currency" on tab 0 with "defined" values
    And User fills in Currency Amount on tab 0 value "text"
    Then Question Currency Amount on tab 0 value is ""
    When User fills in Currency Amount on tab 0 value "1"
    Then Question Currency Amount on tab 0 value is "1"
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C39450408
  Scenario: C39450408: Questionnaire Activity - Ad Hoc - UNRESPONDED - Text - Verify that user should be able to input maximum of 5000 alphanumeric characters
    When User adds question with type "Text" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with random ID name" via API and open it
    And User clicks on "Questionnaire" tab on Third-party page
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    Then Questionnaire answer form Text question input max length is "5000" symbols
    When User answers Question "Text" on tab 0 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C39450409
  Scenario: C39450409: Questionnaire Activity - Ad Hoc - UNRESPONDED - Checkbox- Verify that user should be able to select one or multiple value
    When User adds question with type "Checkbox" to active tab
    And User clicks Configuration icon
    And User configures question with data "Checkbox question configuration"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with random ID name" via API and open it
    And User clicks on "Questionnaire" tab on Third-party page
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User checks Question Checkbox on tab 0 with value "1"
    And User checks Question Checkbox on tab 0 with value "2"
    And User checks Question Checkbox on tab 0 with value "3"
    And User checks Question Checkbox on tab 0 with value "4"
    Then Question Checkbox on tab 0 with value "1" is checked
    And Question Checkbox on tab 0 with value "2" is checked
    And Question Checkbox on tab 0 with value "3" is checked
    And Question Checkbox on tab 0 with value "4" is checked
    When User unchecks Question Checkbox on tab 0 with value "1"
    And User unchecks Question Checkbox on tab 0 with value "2"
    And User unchecks Question Checkbox on tab 0 with value "3"
    And User unchecks Question Checkbox on tab 0 with value "4"
    Then Question Checkbox on tab 0 with value "1" is unchecked
    And Question Checkbox on tab 0 with value "2" is unchecked
    And Question Checkbox on tab 0 with value "3" is unchecked
    And Question Checkbox on tab 0 with value "4" is unchecked
    When User checks Question Checkbox on tab 0 with value "2"
    Then Question Checkbox on tab 0 with value "2" is checked
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C39450410
  Scenario: C39450410: Questionnaire Activity - Ad Hoc - UNRESPONDED - SingleSelect - Verify that user should be able to select one value only
    When User adds question with type "SingleSelect" to active tab
    And User clicks Configuration icon
    And User configures question with data "SingleSelect question configuration with 5 choices without attachment"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with random ID name" via API and open it
    And User clicks on "Questionnaire" tab on Third-party page
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User answers Question Single Select on tab 0 with value "1"
    Then Question Single Select answer on tab 0 contains value "1"
    When User answers Question Single Select on tab 0 with value "2"
    Then Question Single Select answer on tab 0 contains value "2"
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C39450411
  Scenario: C39450411: Questionnaire Activity - Ad Hoc - UNRESPONDED - MultiSelect - Verify that user should be able to select one or multiple value
    When User adds question with type "MultiSelect" to active tab
    And User clicks Configuration icon
    And User configures question with data "MultiSelect question configuration without attachment"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with random ID name" via API and open it
    And User clicks on "Questionnaire" tab on Third-party page
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User answers Question Multi Select on tab 0 with values
      | 1 |
      | 2 |
    Then Question Multi Select answer on tab 0 contains values
      | 1 |
      | 2 |
    When User searches and selects Question Multi Select on tab 0 with values
      | 3 |
    Then Question Multi Select answer on tab 0 contains values
      | 1 |
      | 2 |
      | 3 |
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C39450412
  Scenario: C39450412: Questionnaire Activity - Ad Hoc - UNRESPONDED - Multiple Choice - Verify that user should be able to select one value only
    When User adds question with type "Multiple Choice" to active tab
    And User clicks Configuration icon
    And User configures question with data "Question with 3 Choices"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with random ID name" via API and open it
    And User clicks on "Questionnaire" tab on Third-party page
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User answers Question Multiple Choice on tab 0 with value "Check 1"
    Then Question Multiple Choice on tab 0 with value "Check 1" is checked
    When User answers Question Multiple Choice on tab 0 with value "Check 2"
    Then Question Multiple Choice on tab 0 with value "Check 2" is checked
    And Question Multiple Choice on tab 0 with value "Check 1" is unchecked
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C39450413
  Scenario: C39450413: Questionnaire Activity - Ad Hoc - UNRESPONDED - Boolean - Verify that user should be able to select one value only
    When User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with random ID name" via API and open it
    And User clicks on "Questionnaire" tab on Third-party page
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User answers Question Boolean on tab 0 with value "Yes"
    Then Question Boolean on tab 0 with value "Yes" is checked
    When User answers Question Boolean on tab 0 with value "No"
    Then Question Boolean on tab 0 with value "No" is checked
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C39450414
  Scenario: C39450414: Questionnaire Activity - Ad Hoc - UNRESPONDED - Date - Verify that user should be able to select future/past date or input date according to acceptable format
    When User adds question with type "Date" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with random ID name" via API and open it
    And User clicks on "Questionnaire" tab on Third-party page
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User fills in Date on tab 0 value "06/13/2030"
    Then Question Date on tab 0 value is "06/13/2030"
    When User fills in Date on tab 0 value "06/13/2002"
    Then Question Date on tab 0 value is "06/13/2002"
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C39450415
  Scenario: C39450415: Questionnaire Activity - Ad Hoc - UNRESPONDED - Number - Verify that user should be able to input numeric value
    When User adds question with type "Number" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with random ID name" via API and open it
    And User clicks on "Questionnaire" tab on Third-party page
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    Then Questionnaire answer form Number question input max length is "25" symbols
    When User answers Question "Number" on tab 0 with "defined" values
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"

  @C39450416
  Scenario: C39450416: Questionnaire Activity - Ad Hoc - UNRESPONDED - Currency - Verify that user should be able to input numeric value and select currency
    When User adds question with type "Currency" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with random ID name" via API and open it
    And User clicks on "Questionnaire" tab on Third-party page
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    When User clicks on "Internal Questionnaire for" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    When User answers Question "Currency" on tab 0 with "defined" values
    And User fills in Currency Amount on tab 0 value "text"
    Then Question Currency Amount on tab 0 value is ""
    When User fills in Currency Amount on tab 0 value "1"
    Then Question Currency Amount on tab 0 value is "1"
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "toBeReplaced" status should be "Submitted"
