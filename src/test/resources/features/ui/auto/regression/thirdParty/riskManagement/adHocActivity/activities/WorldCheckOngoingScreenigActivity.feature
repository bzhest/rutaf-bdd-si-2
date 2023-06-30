@ui @full_regression @core_regression @react @workflow_check_ongoing_screening_activity_risk_management
Feature: Risk Management - Ad Hoc - Workflow Check Ongoing Screening Activity

  @C39374787
  Scenario: C39374787: World-Check Ongoing Screening Update Ad hoc Activity - Attachment - Verify that user can upload an attachment
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "World Check Ongoing Screening Update"
    And User fills in "Activity Name" field with "World Check Ongoing Screening Update Name"
    And User fills in "Description" field with "World Check Ongoing Screening Update Description"
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
      | oldDocFile.doc      | Attachment doc file  |
      | newDocFile.docx     | Attachment docx file |
      | PPTfile.ppt         | Attachment ppt file  |
      | PPTxfile.pptx       | Attachment pptx file |
      | xlsFile.xls         | Attachment xls file  |
      | xlsmFile.xlsm       | Attachment xlsm file |
      | logo.jpg            | Attachment jpg file  |
      | logo.jpeg           | Attachment jpeg file |
      | test.png            | Attachment png file  |
      | meme-cat.gif        | Attachment gif file  |
      | csvFile.csv         | Attachment csv file  |
      | testPDFimage.pdf    | Attachment pdf file  |
      | dotxFile.dotx       | Attachment dotx file |
      | PPSfile.pps         | Attachment pps file  |
      | PPSXfile.ppsx       | Attachment ppsx file |
      | zipFile.zip         | Attachment zip file  |
      | rarFile.rar         | Attachment rar file  |
      | Google.htm          | Attachment htm file  |
      | odtFile.odt         | Attachment odt file  |
      | sample-msg-file.msg | Attachment msg file  |
    Then Alert Icon is displayed with text
      | Success! Attachment has been saved. |
    And Activity information page Attachment table row appears
      | File Name           | Description          | Upload Date |
      | oldDocFile.doc      | Attachment doc file  | TODAY       |
      | newDocFile.docx     | Attachment docx file | TODAY       |
      | PPTfile.ppt         | Attachment ppt file  | TODAY       |
      | PPTxfile.pptx       | Attachment pptx file | TODAY       |
      | xlsFile.xls         | Attachment xls file  | TODAY       |
      | xlsmFile.xlsm       | Attachment xlsm file | TODAY       |
      | logo.jpg            | Attachment jpg file  | TODAY       |
      | logo.jpeg           | Attachment jpeg file | TODAY       |
      | test.png            | Attachment png file  | TODAY       |
      | meme-cat.gif        | Attachment gif file  | TODAY       |
      | csvFile.csv         | Attachment csv file  | TODAY       |
      | testPDFimage.pdf    | Attachment pdf file  | TODAY       |
      | dotxFile.dotx       | Attachment dotx file | TODAY       |
      | PPSfile.pps         | Attachment pps file  | TODAY       |
      | PPSXfile.ppsx       | Attachment ppsx file | TODAY       |
      | zipFile.zip         | Attachment zip file  | TODAY       |
      | rarFile.rar         | Attachment rar file  | TODAY       |
      | Google.htm          | Attachment htm file  | TODAY       |
      | odtFile.odt         | Attachment odt file  | TODAY       |
      | sample-msg-file.msg | Attachment msg file  | TODAY       |

  @C39374788
  Scenario:  C39374788: World-Check Ongoing Screening Update Ad hoc Activity - Cancel/Add Comment
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "World Check Ongoing Screening Update"
    And User fills in "Activity Name" field with "World Check Ongoing Screening Update Name"
    And User fills in "Description" field with "World Check Ongoing Screening Update Description"
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
