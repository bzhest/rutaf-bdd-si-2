@ui @full_regression @react @activity_attachment @onlySingleThread
Feature: Activity Information Page - Attachment

  As a RDDC User
  I want to add the attachment to activity information
  so that I will be able to all attachment related to the activity

  @C38384567
  Scenario Outline: C38384567: Activity Information Page - Attachment - Pre-attached file in the activity workflow setup should be displayed in the Activity Information page
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "<Activity>"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    Then Activity information Attachment block elements are displayed
    And Activity information page Attachment table row appears
      | File Name | Description | Upload Date |
      | logo.jpg  |             | TODAY       |
    Examples:
      | Activity                                      |
      | Assign Questionnaire Activity with attachment |
      | ODDR Activity with attachment                 |

  @C38384910
  @core_regression
  Scenario: C38384910: Activity Information Page - Attachment - Files should be displayed in table form with File name, Description and Upload Date columns - file pre-attached to activity
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Assign Questionnaire Activity with attachment"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    Then Activity information Attachment block elements are displayed
    And Activity information page Attachment table row appears
      | File Name | Description | Upload Date |
      | logo.jpg  |             | TODAY       |
    When User adds Ad Hoc Activity attachment
      | имяФайла.jpg | Activity description   |
      | racoon1.jpg  | Activity description 2 |
    Then Activity information page Attachment table row appears
      | File Name    | Description            | Upload Date |
      | logo.jpg     |                        | TODAY       |
      | имяФайла.jpg | Activity description   | TODAY       |
      | racoon1.jpg  | Activity description 2 | TODAY       |
    When Users clicks "File Name" column header on Activity attachment table
    Then Activity Information page Attachment table sorted by "File Name" in "DESC" order
    When Users clicks "File Name" column header on Activity attachment table
    Then Activity Information page Attachment table sorted by "File Name" in "ASC" order
    When Users clicks "Description" column header on Activity attachment table
    Then Activity Information page Attachment table sorted by "Description" in "DESC" order
    When Users clicks "Description" column header on Activity attachment table
    Then Activity Information page Attachment table sorted by "Description" in "ASC" order
    When Users clicks "Upload Date" column header on Activity attachment table
    Then Activity Information page Attachment table sorted by "Upload Date" in "DESC" order
    When Users clicks "Upload Date" column header on Activity attachment table
    Then Activity Information page Attachment table sorted by "Upload Date" in "ASC" order

  @C38384910
  @core_regression
  Scenario: C38384910: Activity Information Page - Attachment - Files should be displayed in table form with File name, Description and Upload Date columns - file not pre-attached to activity
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    Then Activity information Attachment block elements are displayed
    And Activity Information Attachments table is empty with 'No Available Data' title

  @C38384923
  Scenario: C38384923: Activity Information Page - Attachment - Attachment section should be expanded by default
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Assign Questionnaire Activity with attachment"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    Then Activity information Attachment block elements are displayed
    And Activity information Attachment block is expanded
    When User clicks Activity information Attachment block collapse icon
    Then Activity information Attachment block is collapsed
    When User clicks Activity information Attachment block expand icon
    Then Activity information Attachment block is expanded

  @C38395451
  @core_regression
  Scenario: C38395451: Activity Information Page - Attachment - User can upload an attachment if it has Related Files add role permission
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    Then Activity information Attachment block elements are displayed
    And Activity information Attachment block upload button is disabled
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
    Then Alert Icon is displayed with text
      | Success! Attachment has been saved. |
    And Activity information Attachment block upload button is disabled
    And Activity information page Attachment table row appears
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
    When User refreshes page
    Then User clicks Notification Bell
    And "Attachment Processing has been completed" notification displayed with text
      | xlsFile.xls - Completed without errors |

  @C38395451
  @core_regression
  Scenario: C38395451: Activity Information Page - Attachment - User can upload an attachment if it has Related Files add role permission - Verify Remained file formats
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    Then Activity information Attachment block elements are displayed
    And Activity information Attachment block upload button is disabled
    When User adds Ad Hoc Activity attachment
      | Google.html   | Attachment html file |
      | Google.htm    | Attachment htm file  |
      | zipFile.zip   | Attachment zip file  |
      | rarFile.rar   | Attachment rar file  |
      | 7zFile.7z     | Attachment 7z file   |
      | xlsxFile.xlsx | Attachment xlsx file |
      | xlsmFile.xlsm | Attachment xlsm file |
      | csvFile.csv   | Attachment csv file  |
      | dotFile.dot   | Attachment dot file  |
      | dotxFile.dotx | Attachment dotx file |
      | odtFile.odt   | Attachment odt file  |
    Then Activity information page Attachment table row appears
      | File Name     | Description          | Upload Date |
      | Google.html   | Attachment html file | TODAY       |
      | Google.htm    | Attachment htm file  | TODAY       |
      | zipFile.zip   | Attachment zip file  | TODAY       |
      | rarFile.rar   | Attachment rar file  | TODAY       |
      | 7zFile.7z     | Attachment 7z file   | TODAY       |
      | xlsxFile.xlsx | Attachment xlsx file | TODAY       |
      | xlsmFile.xlsm | Attachment xlsm file | TODAY       |
      | csvFile.csv   | Attachment csv file  | TODAY       |
      | dotFile.dot   | Attachment dot file  | TODAY       |
      | dotxFile.dotx | Attachment dotx file | TODAY       |
      | odtFile.odt   | Attachment odt file  | TODAY       |

  @C38395452
  @core_regression
  Scenario: C38395452: Activity Information Page - Attachment - User can download attachement if it has Related Files download role permission - User with download permissions
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Assign Questionnaire Activity with attachment"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    Then Activity information Attachment block elements are displayed
    And Activity information page Attachment table row appears
      | File Name | Description | Upload Date |
      | logo.jpg  |             | TODAY       |
    When User clicks on Activity information Attachment "logo.jpg" download button
    Then File is successfully downloaded

  @C38395452
  @core_regression
  Scenario: C38395452: Activity Information Page - Attachment - User can download attachement if it has Related Files download role permission - User without download/delete permissions
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Assign Questionnaire Activity with attachment"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User logs into RDDC as "Restricted"
    And User opens previously created Third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    Then Activity information page Attachment table row appears without download and delete icons
      | File Name | Description | Upload Date |
      | logo.jpg  |             | TODAY       |

  @C38395453
  @core_regression
  Scenario: C38395453: Activity Information Page - Attachment - User can delete attachement if it has Related Files delete role permission
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Assign Questionnaire Activity with attachment"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    Then Activity information Attachment block elements are displayed
    And Activity information page Attachment table row appears
      | File Name | Description | Upload Date |
      | logo.jpg  |             | TODAY       |
    When User clicks on Activity information Attachment "logo.jpg" delete button
    And User clicks Delete button on confirmation window
    Then Activity Information Attachments table is empty with 'No Available Data' title

  @C38395454
  Scenario: C38395454: Activity Information Page - Attachment - Upload File - Verify Description field only accepts 264 characters
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    Then Activity information Attachment block elements are displayed
    And Activity information Attachment block upload button is disabled
    When User uploads Activity attachment file "logo.jpg"
    And User adds Activity attachment description "not applicable"
    Then Activity Attachment description characters limit text is displayed
      | You have reached the maximum characters limit |
    When User adds Activity attachment description "applicable"
    Then Activity Attachment description characters limit text is not displayed
      | You have reached the maximum characters limit |
    When User clicks Activity attachment upload button
    Then Activity information page Attachment table row appears
      | File Name | Description       | Upload Date |
      | logo.jpg  | editedDescription | TODAY       |

  @C38395455
  Scenario: C38395455: Activity Information Page - Attachment - Upload File - File should not be saved if user click cancel
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    Then Activity information Attachment block elements are displayed
    And Activity information Attachment block upload button is disabled
    When User uploads Activity attachment file "logo.jpg"
    And User clicks Activity attachment cancel button
    Then Activity Information Attachments table is empty with 'No Available Data' title

  @C38395456
  Scenario: C38395456: Activity Information Page - Attachment - Upload File - Error message should be displayed if the maximum file size attempted to upload is 25mb
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    And User uploads Activity attachment file "more25mb.jpg"
    Then Message "The file reached maximum file size of 25 MB" appears under uploads file input
    And Activity information Attachment block upload button is disabled

  @C38395457
  Scenario: C38395457: Activity Information Page - Attachment - Upload File - Error message "The file type is not supported." should be displayed if user attempted to upload an unsupported file format
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    And User uploads file on Activity page
      | file_example_WAV_1MG.wav |
    Then Message "The file type is not supported." appears under uploads file input
    And Activity information Attachment block upload button is disabled

  @C38395458 @C38395459
  @core_regression
  Scenario: C38395458, C38395459: Activity Information Page - Attachment - Upload File - User should only be able to add up to 20 attachments, once reached only table will be displayed
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group and description Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    Then Activity information Attachment block elements are displayed
    And Activity information Attachment block upload button is disabled
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
      | 7zFile.7z           | Attachment 7z file   |
      | xlsxFile.xlsx       | Attachment xlsx file |
      | xlsmFile.xlsm       | Attachment xlsm file |
    Then Activity information Attachment block elements are not displayed
    And Activity information page Attachment table row appears
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
      | 7zFile.7z           | Attachment 7z file   | TODAY       |
      | xlsxFile.xlsx       | Attachment xlsx file | TODAY       |
      | xlsmFile.xlsm       | Attachment xlsm file | TODAY       |
    When User clicks on Activity information Attachment "logo.jpg" delete button
    And User clicks Delete button on confirmation window
    Then Activity information Attachment block elements are displayed
    And Activity information page Attachment table row appears
      | File Name           | Description          | Upload Date |
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
      | 7zFile.7z           | Attachment 7z file   | TODAY       |
      | xlsxFile.xlsx       | Attachment xlsx file | TODAY       |
      | xlsmFile.xlsm       | Attachment xlsm file | TODAY       |