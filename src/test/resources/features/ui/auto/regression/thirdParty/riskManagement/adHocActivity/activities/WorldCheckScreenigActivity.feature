@ui @full_regression @core_regression @react @workflow_check_screening_activity_risk_management
Feature: Risk Management - Ad Hoc - Workflow Check Screening Activity

  @C33175320
  Scenario: C33175320: Risk Management - Ad Hoc Activity - Add World Check Screening Activity - Not Started
    Given User logs into RDDC as "Admin"
    When User creates third-party "PetroChina" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "World Check Screening"
    And User fills in "Activity Name" field with "World Check Screening Name"
    And User fills in "Description" field with "World Check Screening Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    Then Reviewers Table is not displayed
    When User clicks Ad Hoc Activity "Save" button
    And User clicks Ad Hoc Activity "Back" button
    Then Ad Hoc Activities table contains the following columns
      | NAME               |
      | STATUS             |
      | OVERALL RISK SCORE |
      | INITIATED BY       |
      | START DATE         |
      | LAST UPDATE        |
    And Risk Management Ad Hoc table is displayed with the next details
      | NAME                       | STATUS      | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | World Check Screening Name | Not Started | 4.2                | Admin_AT_FN Admin_AT_LN | TODAY+0    |             |
    And Risk Management Ad Hoc table "Edit" button displayed for each row
    And Risk Management Ad Hoc table "Delete" button displayed for each row

  @C33175322
  Scenario: C33175322: Risk Management - Ad Hoc Activity - Edit World Check Screening Activity - Draft to Not Started
    Given User logs into RDDC as "Admin"
    When User creates third-party "USG" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "World Check Screening"
    And User fills in "Activity Name" field with "World Check Screening Name"
    And User fills in "Description" field with "World Check Screening Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Draft"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks "Edit" button for Risk Management Ad Hoc activity row with name "World Check Screening Name"
    And User fills in "Activity Name" field with "New World Check Screening Name"
    And User fills in "Description" field with "New World Check Screening Description"
    And User selects "TODAY+1" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    Then Risk Management Ad Hoc table is displayed with the next details
      | NAME                           | STATUS      | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | New World Check Screening Name | Not Started | 2.9                | Admin_AT_FN Admin_AT_LN | TODAY+0    | TODAY+0     |
    And Risk Management Ad Hoc table "Edit" button displayed for each row
    And Risk Management Ad Hoc table "Delete" button displayed for each row

  @C33175324
  Scenario: C33175324: Risk Management - Ad Hoc Activity - Update Existing Ad Hoc Activity (Draft) to World Check Screening Activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "PETROCHINA HONG KONG LTD" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "Request for Due Diligence Activity"
    And User fills in "Activity Name" field with "Request for Due Diligence Activity Name"
    And User fills in "Description" field with "Request for Due Diligence Activity Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Draft"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Done button in Activity Reviewers section
    And User clicks Ad Hoc Activity "Back" button
    And User clicks "Edit" button for Risk Management Ad Hoc activity row with name "Request for Due Diligence Activity Name"
    And User fills in "Activity Type" drop-down with "World Check Screening"
    And User fills in "Status" drop-down with "Not Started"
    Then Reviewers Table is not displayed
    When User clicks Ad Hoc Activity "Save" button
    Then Risk Management Ad Hoc table is displayed with the next details
      | NAME                                    | STATUS      | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Request for Due Diligence Activity Name | Not Started | 3.0                | Admin_AT_FN Admin_AT_LN | TODAY+0    | TODAY+0     |

  @C39382247
  Scenario: C39382247: World Check Screening Ad hoc Activity - Attachment - Verify that user can upload an attachment
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "World Check Screening"
    And User fills in "Activity Name" field with "World Check Screening Name"
    And User fills in "Description" field with "World Check Screening Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    Then Activity information Attachment block elements are displayed
    And Activity information Attachment block is expanded
    When User clicks Activity information Attachment block collapse icon
    Then Activity information Attachment block is collapsed
    When User clicks Activity information Attachment block expand icon
    Then Activity information Attachment block is expanded
    When User adds Ad Hoc Activity attachment
      | oldDocFile.doc   | Attachment doc file  |
      | newDocFile.docx  | Attachment docx file |
      | PPTfile.ppt      | Attachment ppt file  |
      | PPTxfile.pptx    | Attachment pptx file |
      | xlsFile.xls      | Attachment xls file  |
      | xlsxFile.xlsx    | Attachment xlsx file |
      | logo.jpg         | Attachment jpg file  |
      | logo.jpeg        | Attachment jpeg file |
      | test.png         | Attachment png file  |
      | meme-cat.gif     | Attachment gif file  |
      | csvFile.csv      | Attachment csv file  |
      | testPDFimage.pdf | Attachment pdf file  |
      | dotxFile.dotx    | Attachment dotx file |
      | PPSfile.pps      | Attachment pps file  |
      | PPSXfile.ppsx    | Attachment ppsx file |
      | zipFile.zip      | Attachment zip file  |
      | rarFile.rar      | Attachment rar file  |
      | 7zFile.7z        | Attachment 7z file   |
      | simple text.txt  | Attachment txt file  |
      | Google.html      | Attachment html file |
    Then Alert Icon is displayed with text
      | Success! Attachment has been saved. |
    And Activity information page Attachment table row appears
      | File Name        | Description          | Upload Date |
      | oldDocFile.doc   | Attachment doc file  | TODAY       |
      | newDocFile.docx  | Attachment docx file | TODAY       |
      | PPTfile.ppt      | Attachment ppt file  | TODAY       |
      | PPTxfile.pptx    | Attachment pptx file | TODAY       |
      | xlsFile.xls      | Attachment xls file  | TODAY       |
      | xlsxFile.xlsx    | Attachment xlsx file | TODAY       |
      | logo.jpg         | Attachment jpg file  | TODAY       |
      | logo.jpeg        | Attachment jpeg file | TODAY       |
      | test.png         | Attachment png file  | TODAY       |
      | meme-cat.gif     | Attachment gif file  | TODAY       |
      | csvFile.csv      | Attachment csv file  | TODAY       |
      | testPDFimage.pdf | Attachment pdf file  | TODAY       |
      | dotxFile.dotx    | Attachment dotx file | TODAY       |
      | PPSfile.pps      | Attachment pps file  | TODAY       |
      | PPSXfile.ppsx    | Attachment ppsx file | TODAY       |
      | zipFile.zip      | Attachment zip file  | TODAY       |
      | rarFile.rar      | Attachment rar file  | TODAY       |
      | 7zFile.7z        | Attachment 7z file   | TODAY       |
      | simple text.txt  | Attachment txt file  | TODAY       |
      | Google.html      | Attachment html file | TODAY       |

  @C39382248
  Scenario: C39382248: World Check Screening Ad hoc Activity - Cancel/Add Comment
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "World Check Screening"
    And User fills in "Activity Name" field with "World Check Screening Name"
    And User fills in "Description" field with "World Check Screening Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    Then Activity information page comment section is expanded
    When User clicks Activity Information comments section arrow
    Then Activity information page comment section is collapsed
    When User clicks Activity Information comments section arrow
    Then Activity information page comment section is expanded
    And Activity information page comment section button "Comment" is displayed
    And Activity information page comment section button "Comment" is disabled
    And Activity information page comment section button "Cancel" is displayed
    When User on Activity information page fills in comment text "Activity comment text N1"
    Then Activity information page comment section button "Comment" is enabled
    When User clicks Activity Information comment section button "Cancel"
    Then Comment "Activity comment text N1" on Activity information page should not be shown
    And Activity information page comment text area contains ""
    When User on Activity information page adds comment "Activity comment text N2"
    Then Alert Icon is displayed with text
      | Success! Comment has been added. |
    And Created comment on Activity Information page is displayed

  @C39382249
  Scenario: C39382249: World Check Screening Ad hoc Activity - Edit - Verify that Status and Assignee fields are disabled if there are records that are still For Review
    Given User logs into RDDC as "Admin"
    When User creates third-party "Bank" via API and open it
    And User clicks on 1 number screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status  |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    When User clicks Edit button for Activity
    Then Activity Information Status field should be disabled

  @C39382251
  Scenario: C39382251: World Check Screening Ad hoc Activity - Edit - Verify that Status and Assignee fields can be changed if all records are Reviewed
    Given User logs into RDDC as "Admin"
    When User creates third-party "Bank of China" via API and open it
    And User clicks on 1 number screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"
    When User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status      |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | In Progress |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                      | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Assignee_AT_FN Assignee_AT_LN | Reviewed      | TODAY+0  | THIRD-PARTY | VIEW        |
    When User clicks Edit button for Activity
    Then Activity Information Status field should be enabled
    And Activity Information Assignee can be edited
    When User selects activity status "Done"
    And User selects activity assignee "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                      | Status    |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Assignee_AT_FN Assignee_AT_LN | Completed |

  @C39400239
  Scenario: C39400239: World Check Screening Ad hoc Activity - Edit - Verify that No Fields can be edited when Status is Completed
    Given User logs into RDDC as "Admin"
    When User creates third-party "APPLE INVESTMENT COMPANY" via API and open it
    And User clicks on 1 number screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"
    When User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status    |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Completed |
    When User clicks Edit button for Activity
    Then Activity Information Status field should be disabled
    And Activity Information Assignee can not be edited

  @C39399275
  Scenario: C39399275: World Check Screening Activity - View Activity Information page
    Given User logs into RDDC as "Admin"
    When User creates third-party "USG" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "World Check Screening"
    And User fills in "Activity Name" field with "World Check Screening Name"
    And User fills in "Description" field with "World Check Screening Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Draft"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks "Edit" button for Risk Management Ad Hoc activity row with name "World Check Screening Name"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name              | Description                       | Due Date | Assignee                      | Status |
      | World Check Screening | World Check Screening Name | World Check Screening Description | TODAY+0  | Assignee_AT_FN Assignee_AT_LN | Draft  |
    And Next Edit Activity modal text input field(s) is(are) required
      | Activity Name |
      | Description   |
      | Assignee      |
      | Due Date      |
    And Activity Information "Activity Type" field should be enabled
    And Activity Information "Activity Name" field should be enabled
    And Activity Information "Description" field should be enabled
    And Activity Information "Risk Area" field should be enabled
    And Activity Information "Start Date" field should be disabled
    And Activity Information "Initiated By" field should be disabled
    And Activity Information "Last Update" field should be disabled
    When User fills in "Status" drop-down with "Not Started"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks "Edit" button for Risk Management Ad Hoc activity row with name "World Check Screening Name"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name              | Description                       | Start Date | Due Date | Assignee                      | Status      |
      | World Check Screening | World Check Screening Name | World Check Screening Description | TODAY+0    | TODAY+0  | Assignee_AT_FN Assignee_AT_LN | Not Started |
    And Activity Information "Activity Type" field should be disabled
    And Activity Information "Activity Name" field should be disabled
    And Activity Information "Description" field should be disabled
    And Activity Information "Risk Area" field should be disabled
    And Activity Information "Start Date" field should be disabled
    And Activity Information "Initiated By" field should be disabled
    And Activity Information "Last Update" field should be disabled
    And Activity information Attachment block is expanded
    And Activity information page Review Task section is expanded
    And Activity information page comment section is expanded
