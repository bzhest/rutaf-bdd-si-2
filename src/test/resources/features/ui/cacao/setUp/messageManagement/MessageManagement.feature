@ui @cacao @messageManagement
Feature: Message Management - Legal Notice

  As a Tenant Manager,
  I want to have access to Message Management
  So that I can create terms and conditions or other legal messages for RDDC users

  Background:
    Given User logs into RDDC as "Super Admin"
    When User navigates to 'Message Management' page
    Then Page title is 'MESSAGE MANAGEMENT' on Message Management page


  @C33579905 @C49006368
  @core_regression
  Scenario: C33579905, C49006368: [Message Management] Message Management menu will display under Tenant Manager role
    And "Add New Message" button is present on 'Message Management' page
    And "Audit Report" button is present on 'Message Management' page
    And 'Message Management' table is displayed with following columns
      | MESSAGE NAME   |
      | VERSION        |
      | STATUS         |
      | PUBLISH TO     |
      | EFFECTIVE DATE |
    And 'Message Management' table results are displayed with 'Clone' and 'Edit' action buttons

  @C33579906
  @core_regression
  Scenario: C33579906: Message Management menu will NOT display under other roles except Tenant Manager role (RMS-359)
    When User saves random Message id to context
    And User logs into RDDC as "Admin"
    And User clicks Set Up option
    Then Setup navigation option "Message Management" is not displayed
    When User navigates to 'Message Management' page
    Then Current URL contains "/forbidden" endpoint
    When User navigates to 'Add Message' page
    Then Current URL contains "/forbidden" endpoint
    When User navigates to 'View Message' page of existing Message
    Then Current URL contains "/forbidden" endpoint
    When User navigates to 'Edit Message' page of existing Message
    Then Current URL contains "/forbidden" endpoint

  @C33579907
  @functional
  Scenario: C33579907: Message Management: verify the Message Management main page
    And 'Clone' button with tooltip is displayed for records in status 'Any Status'
    And 'Edit' button with tooltip is displayed for records in status 'Draft'
    And 'Edit' button with tooltip is hidden for records in status 'Published'
    When User clicks Message Management table "Message Name" column's header
    Then Message Management table sorted by "Message Name" in "ASC" order
    When User clicks Message Management table "Message Name" column's header
    Then Message Management table sorted by "Message Name" in "DESC" order
    When User clicks Message Management table "Version" column's header
    Then Message Management table sorted by "Version" in "ASC" order
    When User clicks Message Management table "Version" column's header
    Then Message Management table sorted by "Version" in "DESC" order
    When User clicks Message Management table "Publish To" column's header
    Then Message Management table sorted by "Publish To" in "ASC" order
    When User clicks Message Management table "Publish To" column's header
    Then Message Management table sorted by "Publish To" in "DESC" order
    When User clicks Message Management table "Effective Date" column's header
    Then Message Management table sorted by "Effective Date" in "ASC" order
    When User clicks Message Management table "Effective Date" column's header
    Then Message Management table sorted by "Effective Date" in "DESC" order
    When User clicks 'Add New Message' Message Management button
    Then Page title is 'ADD' on Message Management page
    When User clicks 'Back' button on Message Management page
    And User opens first record on Message Management page
    Then Page title is 'messageName' on Message Management page
    When User clicks 'Back' button on Message Management page
    And User clicks 'Audit Report' Message Management button
    And User fills in Audit date range from "TODAY-5" to "TODAY+0"
    And User clicks Proceed button on confirmation window
    And User clicks My Exports option
    Then My Exports table contains file with name "RDDCentre_LegalNoticeAudit_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"
    When User clicks file with name "RDDCentre_LegalNoticeAudit_Report_%s.csv" and date format "MM_dd_YYYY_HH_mm"
    Then ".csv" File with name "RDDCentre_LegalNoticeAudit_Report_%s" and date format "MM_dd_YYYY HH_mm" downloaded

  @C33579908
  @functional
  Scenario: C33579908: Message Management - Verify default sorting for  "Message Management"  main page
    When User clicks 'Add New Message' Message Management button
    Then Page title is 'ADD' on Message Management page
    When User fills in "with mandatory details" Message management data
    And User clicks 'Save as draft' Message Management button
    And User waits for progress bar to disappear from page
    Then Page title is 'MESSAGE MANAGEMENT' on Message Management page
    And Record is displayed first on Message Management table
    When User clicks 'Add New Message' Message Management button
    And User fills in "with mandatory details" Message management data
    And User clicks 'Publish' Message Management button
    And User clicks Yes button on confirmation window
    And User waits for progress bar to disappear from page
    Then Page title is 'MESSAGE MANAGEMENT' on Message Management page
    And Record is displayed first on Message Management table
    When User clicks 'Clone' button on first record in Message Management table
    Then User clicks 'Clone' Message Management button
    And User waits for progress bar to disappear from page
    Then Cloned Record is displayed first on Message Management table

  @C33579909
  @functional
  Scenario: C33579909: Message Management - Verify long Message Names should be truncated with a tool tip to show complete name
    When User clicks 'Add New Message' Message Management button
    Then Page title is 'ADD' on Message Management page
    When User fills in "with mandatory details long name" Message management data
    And User clicks 'Save as draft' Message Management button
    And User waits for progress bar to disappear from page
    Then Page title is 'MESSAGE MANAGEMENT' on Message Management page
    When User waits for progress bar to disappear from page
    Then Full name is displayed when hover over first Message Name in table

  @C33579912
  @core_regression
  Scenario: C33579912: [Message Management] - Clone existing Published Message
    When User clicks 'Clone' button on any existing Published message with version 1
    Then Message name is "messageManagementData" on Clone Message window
    And New Message name is "Clone - " "messageManagementData" on Clone Message window
    And New Message name field is marked as required
    When Fill in New Message name field with number of random characters - 200
    Then New Message name characters limit is shown - "Characters: 200/200"
    And "Cancel" button is shown on Clone Message window
    And "Clone" button is shown on Clone Message window
    When Fill in New Message name field - "messageName"
    And User clicks 'Clone' Message Management button
    Then Alert Icon is displayed with text
      | Success! Notice Message has been cloned. |
    And Edited Cloned Record is displayed first on Message Management table

  @C33579913
  @functional
  Scenario: C33579913: [Message Management] - Clone existing Message with duplicate Message Name
    When User clicks 'Clone' button on any existing Published message with version 1
    And Fill in New Message name with already existing one
    And User clicks 'Clone' Message Management button
    Then Alert Icon is displayed with text
      | Cannot Save! Notice Name already exists. |
    And New Message name field is highlighted with error
      | Notice name already exists |

  @C49026234
  @functional
  Scenario: C49026234: [Message Management] - Clone existing Message with empty Message Name
    When User clicks 'Clone' button on any existing Published message with version 1
    And Fill in New Message name field - ""
    And User clicks 'Clone' Message Management button
    Then Alert Icon is displayed with text
      | Cannot Save! Please complete the required field(s). |
    And New Message name field is highlighted with error
      | This field is required |

  @C33579914
  @functional
  Scenario: C33579914: [Message Management] - Cancel Clone existing Published Message
    When User clicks 'Clone' button on any existing Published message with version 1
    And User clicks 'Cancel' Message Management button
    Then Cloned Record is not displayed on Message Management table

  @C33579915
  @functional
  Scenario: C33579915: [Message Management] - Clone an existing cloned message
    When User clicks 'Clone' button on any already Cloned message
    Then Message name is "messageManagementData" on Clone Message window
    And New Message name is "Clone - " "messageManagementData" on Clone Message window
    And Fill in New Message name field - "messageName"
    When User clicks 'Clone' Message Management button
    Then Alert Icon is displayed with text
      | Success! Notice Message has been cloned. |
    And Edited Cloned Record is displayed first on Message Management table

  @C33579916 @C33579917
  @functional
  Scenario: C33579916, C33579917: [Message Management] - Clone existing Version 2 Message
    When User clicks 'Clone' button on any existing Published message with version 2
    And Fill in New Message name field - "messageName"
    And User clicks 'Clone' Message Management button
    Then Alert Icon is displayed with text
      | Success! Notice Message has been cloned. |
    And Edited Cloned Record is displayed first on Message Management table

  @C33579918
  @functional
  Scenario: C33579918: [Message Management] - Cancel Clone existing Draft Message
    When User clicks 'Clone' button on any existing Draft message with version 1
    And User clicks 'Cancel' Message Management button
    Then Cloned Record is not displayed on Message Management table

  @C33579921
  @core_regression
  Scenario: C33579921: Edit Message from Message Management screen ? Verify User can edit and save as Draft/Publish Message with version 2 (RMS-381)
    When User clicks 'Edit' button on any existing Draft message with version 2
    Then Message management page breadcrumb "MESSAGE MANAGEMENT / messageName / EDIT" is displayed
    And Fields are editable on Message Management page
      | Version        |
      | Message Name   |
      | Message Header |
      | Publish To     |
      | Effective Date |
      | Every          |
      | Unit           |
      | Effective Date |
      | Content        |
    And Message page field "Version" input value is "Version 2"
    And "Cancel" button is shown on Clone Message window
    And "Publish" button is shown on Clone Message window
    And "Save as draft" button is shown on Clone Message window
    When User fills in Message page field 'Version' with value "Version 1"
    And User waits for progress bar to disappear from page
    Then Message management page breadcrumb "MESSAGE MANAGEMENT / messageName" is displayed
    And 'Edit' icon is not displayed on Message page
    And Fields are not editable on Message Management page
      | Message Name   |
      | Message Header |
      | Publish To     |
      | Effective Date |
      | Every          |
      | Unit           |
      | Effective Date |
    Then Message page field "Version" input value is "Version 1"
    And "Back" button is shown on Clone Message window
    And "Cancel" button is not shown on Clone Message window
    And "Publish" button is not shown on Clone Message window
    And "Save as draft" button is not shown on Clone Message window
    When User fills in Message page field 'Version' with value "Version 2"
    Then 'Edit' icon is displayed on Message page
    And Message management page breadcrumb "MESSAGE MANAGEMENT / messageName" is displayed
    When User clicks 'Back' Message Management button
    Then Page title is 'MESSAGE MANAGEMENT' on Message Management page
    When User clicks on message from context on Message Management Overview page
    And User clicks on 'Edit' icon on Message page
    Then Message management page breadcrumb "MESSAGE MANAGEMENT / messageName / EDIT" is displayed
    And Fields are editable on Message Management page
      | Version        |
      | Message Name   |
      | Message Header |
      | Publish To     |
      | Effective Date |
      | Every          |
      | Unit           |
      | Effective Date |
      | Content        |
    And "Cancel" button is shown on Clone Message window
    And "Publish" button is shown on Clone Message window
    And "Save as draft" button is shown on Clone Message window
    And Message page field "Version" input value is "Version 2"
    When User fills in Message header - "toBeUpdated"
    And User clicks 'Save as draft' Message Management button
    Then Alert Icon is displayed with text
      | Success                       |
      | Notice Message has been saved |
    And Page title is 'MESSAGE MANAGEMENT' on Message Management page
    When User clicks on message from context on Message Management Overview page
    Then Message page contains expected updated data
    And Message page contains expected content text

  @C49027138
  @core_regression
  Scenario: C49027138: Add New Message - Save as Draft Terms and Conditions - all fields are filled up
    When User clicks 'Add New Message' Message Management button
    Then Page title is 'ADD' on Message Management page
    And Message Name should contain maximum 200 characters
    And Message Header should contain maximum 200 characters
    And 'Publish To' dropdown list should contain
      | All Internal Users            |
      | Unacknowledged Internal Users |
    And Acknowledgement Frequency dropdown list should contain
      | Year  |
      | Month |
    And Content should contain maximum of 20000 characters
    When User fills in "with mandatory details" Message management data
    And User clicks 'Save as draft' Message Management button
    Then Alert Icon is displayed with text
      | Success                       |
      | Notice Message has been saved |
    And Page title is 'MESSAGE MANAGEMENT' on Message Management page
    And Record is displayed first on Message Management table with status - "Draft"
    And 'Edit' button is displayed for first record on table
    And 'Clone' button is displayed for first record on table
    When User clicks on message from context on Message Management Overview page
    Then Message page contains expected updated data
    And Message page contains expected content text

  @C33580055
  @core_regression
  Scenario: C33580055: Add New Message: Publish Terms and Conditions - all fields are filled up
    When User clicks 'Add New Message' Message Management button
    Then Page title is 'ADD' on Message Management page
    And Message Name should contain maximum 200 characters
    And Message Header should contain maximum 200 characters
    And 'Publish To' dropdown list should contain
      | All Internal Users            |
      | Unacknowledged Internal Users |
    And Acknowledgement Frequency dropdown list should contain
      | Year  |
      | Month |
    And Content should contain maximum of 20000 characters
    When User fills in "with mandatory details" Message management data
    And User clicks 'Publish' Message Management button
    And Confirmation window button with text "Yes" is displayed
    And Confirmation window button with text "No" is displayed
    And User clicks No button on confirmation window
    Then Page title is 'ADD' on Message Management page
    When User clicks 'Publish' Message Management button
    And User clicks Yes button on confirmation window
    Then Alert Icon is displayed with text
      | Success                           |
      | Notice Message has been published |
    And Page title is 'MESSAGE MANAGEMENT' on Message Management page
    And Record is displayed first on Message Management table with status - "Published"
    And 'Edit' button is hidden for first record on table
    And 'Clone' button is displayed for first record on table
    When User clicks on message from context on Message Management Overview page
    Then Message page contains expected updated data
    And Message page contains expected content text

  @C33580071
  @core_regression
  Scenario: C33580071: [Message Management] - View Message - Saved as Draft - One Version
    When User opens any existing Draft message with version 1
    Then Current URL contains "/ui/admin/message-management/messageId" endpoint
    And 'Edit' icon is displayed on Message page
    And Fields are not editable on Message Management page
      | Message Name   |
      | Message Header |
      | Publish To     |
      | Effective Date |
      | Every          |
      | Unit           |
      | Effective Date |
    And Message page field "Version" input value is "Version 1"
    And "Back" button is shown on Clone Message window
    And "Cancel" button is not shown on Clone Message window
    And "Publish" button is not shown on Clone Message window
    And "Save as draft" button is not shown on Clone Message window
    And Message page contains expected data
    And Message page contains expected content text
    When User clicks on 'Edit' icon on Message page
    Then Fields are editable on Message Management page
      | Version        |
      | Message Name   |
      | Message Header |
      | Publish To     |
      | Effective Date |
      | Every          |
      | Unit           |
      | Effective Date |
      | Content        |
    When User clicks 'Cancel' Message Management button
    Then Page title is 'MESSAGE MANAGEMENT' on Message Management page
    When User opens any existing Draft message with version 1
    And User clicks 'Back' Message Management button
    Then Page title is 'MESSAGE MANAGEMENT' on Message Management page

  @C48993395
  @core_regression
  Scenario: C48993395: [Message Management] - View Message - Published - Previous Version
    When User opens any existing Published message with version 2
    And User waits for progress bar to disappear from page
    Then Message page field "Version" input value is "Version 2"
    And Version dropdown list should contain
      | Version 1 |
    And "Create New Version" button is shown on Clone Message window
    When User fills in Message page field 'Version' with value "Version 1"
    And User waits for progress bar to disappear from page
    Then 'Edit' icon is not displayed on Message page
    And Fields are not editable on Message Management page
      | Message Name   |
      | Message Header |
      | Publish To     |
      | Effective Date |
      | Every          |
      | Unit           |
      | Effective Date |
    Then Message page field "Version" input value is "Version 1"
    And "Back" button is shown on Clone Message window
    And "Cancel" button is not shown on Clone Message window
    And "Publish" button is not shown on Clone Message window
    And "Save as draft" button is not shown on Clone Message window
    And "Create New Version" button is not shown on Clone Message window
    When User clicks 'Back' Message Management button
    Then Page title is 'MESSAGE MANAGEMENT' on Message Management page

  @C33580076
  @core_regression
  Scenario: C33580076: [Message Management] - View Message - Published - Latest Version
    When User opens any existing Published message with version 2
    And User waits for progress bar to disappear from page
    Then Message page field "Version" input value is "Version 2"
    And "Create New Version" button is shown on Clone Message window
    When User clicks 'Create New Version' Message Management button
    Then Message is displayed on confirmation window
      | This will create a new version of this message |
      | Do you want to continue?                       |
    When User clicks No button on confirmation window
    And Confirmation window is disappeared
    And Message page contains expected data
    And Message page contains expected content text
    When User clicks 'Create New Version' Message Management button
    And User clicks Yes button on confirmation window
    And User waits for progress bar to disappear from page
    Then Message page field "Version" input value is "Version 3"
    When Update message in context to version 3
    Then Message Name input is disabled
    And Fields are editable on Message Management page
      | Version        |
      | Message Header |
      | Publish To     |
      | Effective Date |
      | Every          |
      | Unit           |
      | Effective Date |
      | Content        |
    And Message edit page contains expected data
    And Message page contains expected content text