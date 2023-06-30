@ui @full_regression @core_regression @react @ad_hoc_activity_attachment
Feature: Activity Information Page - Ad-Hoc Activity - Attachment

  As a RDDC User
  I want to add the attachment to Adhoc Activity
  so that I will be able to add and view all attachment related to the activity

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User waits for progress bar to disappear from page
    Then Ad-Hoc Activity Information is saved
    And Activity information Attachment block is expanded
    And Activity information Attachment block elements are displayed

  @C38970172
  Scenario: C38970172: Activity Information Page - Attachment - Verify that user can upload an attachment if it has Related Files add role permission (part 1)
    When User adds Ad Hoc Activity attachment
      | logo.jpg            | Attachment jpg file  |
      | logo.jpeg           | Attachment jpeg file |
      | meme-cat.gif        | Attachment gif file  |
      | newDocFile.docx     | Attachment docx file |
      | oldDocFile.doc      | Attachment doc file  |
      | PPTfile.ppt         | Attachment ppt file  |
      | PPTxfile.pptx       | Attachment pptx file |
      | PPSfile.pps         | Attachment pps file  |
      | PPSXfile.ppsx       | Attachment ppsx file |
      | sample-msg-file.msg | Attachment msg file  |
      | test.png            | Attachment png file  |
      | simple text.txt     | Attachment txt file  |
      | testPDFimage.pdf    | Attachment pdf file  |
      | xlsFile.xls         | Attachment xls file  |
      | Google.html         | Attachment html file |
      | Google.htm          | Attachment htm file  |
      | zipFile.zip         | Attachment zip file  |
      | rarFile.rar         | Attachment rar file  |
      | 7zFile.7z           | Attachment 7z file   |
    Then Activity information page Attachment table row appears
      | File Name           | Description          | Upload Date |
      | logo.jpg            | Attachment jpg file  | TODAY       |
      | logo.jpeg           | Attachment jpeg file | TODAY       |
      | meme-cat.gif        | Attachment gif file  | TODAY       |
      | newDocFile.docx     | Attachment docx file | TODAY       |
      | oldDocFile.doc      | Attachment doc file  | TODAY       |
      | PPTfile.ppt         | Attachment ppt file  | TODAY       |
      | PPTxfile.pptx       | Attachment pptx file | TODAY       |
      | PPSfile.pps         | Attachment pps file  | TODAY       |
      | PPSXfile.ppsx       | Attachment ppsx file | TODAY       |
      | sample-msg-file.msg | Attachment msg file  | TODAY       |
      | test.png            | Attachment png file  | TODAY       |
      | simple text.txt     | Attachment txt file  | TODAY       |
      | testPDFimage.pdf    | Attachment pdf file  | TODAY       |
      | xlsFile.xls         | Attachment xls file  | TODAY       |
      | Google.html         | Attachment html file | TODAY       |
      | Google.htm          | Attachment htm file  | TODAY       |
      | zipFile.zip         | Attachment zip file  | TODAY       |
      | rarFile.rar         | Attachment rar file  | TODAY       |
      | 7zFile.7z           | Attachment 7z file   | TODAY       |

  @C38970172
  Scenario: C38970172: Activity Information Page - Attachment - Verify that user can upload an attachment if it has Related Files add role permission (part 2)
    When User adds Ad Hoc Activity attachment
      | xlsxFile.xlsx | Attachment xlsx file |
      | xlsmFile.xlsm | Attachment xlsm file |
      | csvFile.csv   | Attachment csv file  |
      | dotFile.dot   | Attachment dot file  |
      | dotxFile.dotx | Attachment dotx file |
      | odtFile.odt   | Attachment odt file  |
    Then Activity information page Attachment table row appears
      | File Name     | Description          | Upload Date |
      | xlsxFile.xlsx | Attachment xlsx file | TODAY       |
      | xlsmFile.xlsm | Attachment xlsm file | TODAY       |
      | csvFile.csv   | Attachment csv file  | TODAY       |
      | dotFile.dot   | Attachment dot file  | TODAY       |
      | dotxFile.dotx | Attachment dotx file | TODAY       |
      | odtFile.odt   | Attachment odt file  | TODAY       |

  @C38970173
  Scenario: C38970173: Activity Information Page - Attachment - Verify that user can download attachment if it has Related Files download role permission - User with download permissions
    When User adds Ad Hoc Activity attachment
      | xlsxFile.xlsx | Attachment xlsx file |
    Then Activity information page Attachment table row appears
      | File Name     | Description          | Upload Date |
      | xlsxFile.xlsx | Attachment xlsx file | TODAY       |
    When User clicks on Activity information Attachment "xlsxFile.xlsx" download button
    Then File is successfully downloaded

  @C38970173
  Scenario: C38970173: Activity Information Page - Attachment - Verify that user can download attachment if it has Related Files download role permission - User without download/delete permissions
    When User adds Ad Hoc Activity attachment
      | xlsxFile.xlsx | Attachment xlsx file |
    And User logs into RDDC as "Restricted"
    And User opens previously created Ad-Hoc Acvtivity
    Then Activity information Attachment block is expanded
    And Activity information Attachment block elements are not displayed
    And Activity information page Attachment table row appears without download and delete icons
      | File Name     | Description          | Upload Date |
      | xlsxFile.xlsx | Attachment xlsx file | TODAY       |

  @C38970174
  Scenario: C38970174: Activity Information Page - Attachment - Verify that user can delete attachment if it has Related Files delete role permission
    When User adds Ad Hoc Activity attachment
      | xlsxFile.xlsx | Attachment xlsx file |
    Then Activity information page Attachment table row appears
      | File Name     | Description          | Upload Date |
      | xlsxFile.xlsx | Attachment xlsx file | TODAY       |
    When User clicks on Activity information Attachment "xlsxFile.xlsx" delete button
    And User clicks Delete button on confirmation window
    Then Activity Information Attachments table is empty with 'No Available Data' title