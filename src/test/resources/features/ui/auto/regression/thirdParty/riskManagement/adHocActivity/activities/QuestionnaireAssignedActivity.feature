@ui @full_regression @react @questionnaire_assigned_activity_risk_management
Feature: Risk Management - Ad Hoc - Questionnaire Assigned Activity

  @C39468071
  @core_regression
  Scenario: C39468071: Ad hoc - Questionnaire Assigned Activity - UNRESPONDED - Verify questionnaire details
    Given User logs into RDDC as "Admin"
    When User creates third-party "PetroChina" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    And Risk Management Ad Hoc table contains the next details
      | NAME                                  | STATUS      | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Internal Questionnaire for PetroChina | Not Started | 4.2                | Admin_AT_FN Admin_AT_LN | TODAY+0    |             |
    When User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for PetroChina"
    Then Activity Information page is displayed
    And Ad Hoc Activity Information modal is displayed with details
      | Activity Type          | Activity Name                         | Description                                                      | Start Date | Due Date | Assignee                | Status      |
      | Questionnaire Assigned | Internal Questionnaire for PetroChina | Click on the link below to view and/or answer the questionnaire. | TODAY+0    | TODAY+0  | Admin_AT_FN Admin_AT_LN | Not Started |
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status      |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Unresponded |
    When User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then Questionnaire details page is displayed

  @C39468072
  @core_regression
  Scenario: C39468072: Ad hoc - Questionnaire Assigned Activity - SAVE AS DRAFT - Verify questionnaire details
    Given User logs into RDDC as "Admin"
    When User creates third-party "USG" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for USG"
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Save As Draft" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status        |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Save as Draft |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "Answer" is displayed

  @C39468073 @C39468080
  @core_regression
  Scenario: C39468073, C39468080: Ad hoc - Questionnaire Assigned Activity - SUBMITTED - Verify questionnaire details and Verify activity status when questionnaire status is Submitted/Revision Submitted
    Given User logs into RDDC as "Admin"
    When User creates third-party "USG" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for USG"
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "View" is displayed
    And Ad Hoc Activity Information modal is displayed with details
      | Status |
      | Done   |

  @C39468074
  @core_regression
  Scenario: C39468074: Ad hoc - Questionnaire Assigned Activity - IN REVIEW - Verify questionnaire details
    Given User logs into RDDC as "Admin"
    When User creates third-party "USG" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    Then "Assign Overall Reviewer" field is editable on Assign Questionnaire window
    When User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for USG"
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Save"
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for USG"
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | In Review |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "View" is displayed

  @C39468075
  @core_regression
  Scenario: C39468075: Ad hoc - Questionnaire Assigned Activity - REQUIRES REVISION - Verify questionnaire details
    Given User logs into RDDC as "Admin"
    When User creates third-party "USG" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for USG"
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for USG"
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Requires Revision |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "Answer" is displayed

  @C39468076
  @core_regression
  Scenario: C39468076: Ad hoc - Questionnaire Assigned Activity - REVISION IN DRAFT - Verify questionnaire details
    Given User logs into RDDC as "Admin"
    When User creates third-party "USG" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for USG"
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for USG"
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Save as Draft" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status            |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Revision in Draft |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "Answer" is displayed

  @C39468077
  @core_regression
  Scenario: C39468077: Ad hoc - Questionnaire Assigned Activity - REVISION SUBMITTED- Verify questionnaire details
    Given User logs into RDDC as "Admin"
    When User creates third-party "USG" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    Then "Assign Overall Reviewer" field is editable on Assign Questionnaire window
    When User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for USG"
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Revision questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Add comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for USG"
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User selects "Yes" questionnaire answer option
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status             |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Revision Submitted |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "View" is displayed

  @C39468078
  @core_regression
  Scenario: C39468078: Ad hoc - Questionnaire Assigned Activity - COMPLETED - Verify questionnaire details
    Given User logs into RDDC as "Admin"
    When User creates third-party "USG" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for USG"
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for USG"
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Comment questionnaire button
    And User fills in Reply Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks Questionnaire Overall Assessment button "Approve"
    And User clicks Questionnaire Overall Assessment button "Confirm"
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for USG"
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Completed |
    And For Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table Actions button "View" is displayed

  @C39468079
  @core_regression
  Scenario: C39468079: Ad hoc - Questionnaire Assigned Activity - Activity Information - Verify activity details
    Given User logs into RDDC as "Admin"
    When User creates third-party "PetroChina" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Risk Management page is displayed
    And Risk Management Ad Hoc table contains the next details
      | NAME                                  | STATUS      | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Internal Questionnaire for PetroChina | Not Started | 4.2                | Admin_AT_FN Admin_AT_LN | TODAY+0    |             |
    When User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for PetroChina"
    Then Activity Information page is displayed
    And Activity information Attachment block is expanded
    And Activity information page comment section is expanded
    And Ad Hoc Activity Information modal is displayed with details
      | Activity Type          | Activity Name                         | Description                                                      | Start Date | Due Date | Assignee                | Status      |
      | Questionnaire Assigned | Internal Questionnaire for PetroChina | Click on the link below to view and/or answer the questionnaire. | TODAY+0    | TODAY+0  | Admin_AT_FN Admin_AT_LN | Not Started |
    When User clicks Edit button for Activity
    Then Activity Information "Activity Type" field should be disabled
    And Activity Information "Activity Name" field should be disabled
    And Activity Information "Description" field should be disabled
    And Activity Information "Due Date" field should be disabled
    And Activity Information "Initiated By" field should be disabled
    And Activity Information "Last Update" field should be disabled
    And Activity Information "Satus" field should be enabled
    And Activity Information Assignee can be edited
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status      |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Unresponded |
    When  User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then Questionnaire details page is displayed

  @C39468081
  @core_regression
  Scenario: C39468081: Ad hoc - Questionnaire Assigned Activity - Verify answer link is working
    Given User logs into RDDC as "Admin"
    When User creates third-party "PetroChina" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for PetroChina"
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then Questionnaire details page is displayed
    And Questionnaire Overall Assessment button "Cancel" is enabled
    And Questionnaire Overall Assessment button "Save As Draft" is enabled
    And Questionnaire Overall Assessment button "Submit" is enabled
    When User selects "Yes" questionnaire answer option
    Then Questionnaire Overall Assessment button "Cancel" is enabled
    And Questionnaire Overall Assessment button "Save As Draft" is enabled
    And Questionnaire Overall Assessment button "Submit" is enabled
    When User clicks on "Save As Draft" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status        |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Save as Draft |
    When User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Cancel" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status        |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Save as Draft |
    When User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Cancel" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status        |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Save as Draft |
    When User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then Questionnaire Overall Assessment button "Cancel" is enabled
    And Questionnaire Overall Assessment button "Save As Draft" is enabled
    And Questionnaire Overall Assessment button "Submit" is enabled
    When User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Activity Information page is displayed
    And Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |

  @C39468898
  @core_regression
  Scenario: C39468898: Ad hoc - Questionnaire Assigned Activity - Attachment - Verify that user can upload an attachment
    Given User logs into RDDC as "Admin"
    When User creates third-party "PetroChina" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for PetroChina"
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

  @C39468899
  @core_regression
  Scenario: C39468899: Ad hoc - Questionnaire Assigned Activity - Cancel/Add Comment
    Given User logs into RDDC as "Admin"
    When User creates third-party "PetroChina" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for PetroChina"
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

  @C39468902
  Scenario: C39468902: Ad hoc - Questionnaire Assigned Activity - Attachment - Verify that user can download attachment if it has Related Files download role permission
    Given User logs into RDDC as "Admin"
    When User creates third-party "PetroChina" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for PetroChina"
    Then Activity information Attachment block elements are displayed
    And Activity information Attachment block is expanded
    When User clicks Activity information Attachment block collapse icon
    Then Activity information Attachment block is collapsed
    When User clicks Activity information Attachment block expand icon
    Then Activity information Attachment block is expanded
    When User adds Ad Hoc Activity attachment
      | oldDocFile.doc | Attachment doc file |
    Then Activity information page Attachment table row appears
      | File Name      | Description         | Upload Date |
      | oldDocFile.doc | Attachment doc file | TODAY       |
    When User clicks on Activity information Attachment "oldDocFile.doc" download button
    Then File is successfully downloaded
    When User logs into RDDC as "Restricted"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for PetroChina"
    Then Activity information Attachment block is expanded
    And Activity information page Attachment table row appears without download and delete icons
      | File Name      | Description         | Upload Date |
      | oldDocFile.doc | Attachment doc file | TODAY       |

  @C39468903
  Scenario: C39468903: Ad hoc - Questionnaire Assigned Activity - Attachment - Verify that user can delete attachment if it has Related Files delete role permission
    Given User logs into RDDC as "Admin"
    When User creates third-party "PetroChina" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for PetroChina"
    Then Activity information Attachment block elements are displayed
    And Activity information Attachment block is expanded
    When User clicks Activity information Attachment block collapse icon
    Then Activity information Attachment block is collapsed
    When User clicks Activity information Attachment block expand icon
    Then Activity information Attachment block is expanded
    When User adds Ad Hoc Activity attachment
      | oldDocFile.doc | Attachment doc file |
    Then Activity information page Attachment table row appears
      | File Name      | Description         | Upload Date |
      | oldDocFile.doc | Attachment doc file | TODAY       |
    When User clicks on Activity information Attachment "oldDocFile.doc" delete button
    Then Message is displayed on confirmation window
      | DELETE ATTACHMENT                                                              |
      | Are you sure you want to delete this Attachment? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Activity information page Attachment table row appears
      | File Name      | Description         | Upload Date |
      | oldDocFile.doc | Attachment doc file | TODAY       |
    When User clicks on Activity information Attachment "oldDocFile.doc" delete button
    And User clicks Delete button on confirmation window
    Then Activity Information Attachments table is empty with 'No Available Data' title
    When User adds Ad Hoc Activity attachment
      | oldDocFile.doc | Attachment doc file |
    Then Activity information page Attachment table row appears
      | File Name      | Description         | Upload Date |
      | oldDocFile.doc | Attachment doc file | TODAY       |
    When User logs into RDDC as "Restricted"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for PetroChina"
    Then Activity information Attachment block is expanded
    And Activity information page Attachment table row appears without download and delete icons
      | File Name      | Description         | Upload Date |
      | oldDocFile.doc | Attachment doc file | TODAY       |

  @C39468904
  @core_regression
  Scenario: C39468904: Ad hoc - Questionnaire Assigned Activity - Verify that user can delete its own comment
    Given User logs into RDDC as "Admin"
    When User creates third-party "PetroChina" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for PetroChina"
    And User on Activity information page adds comment "Activity comment text N1"
    When User on Activity information page deletes comment "Activity comment text N1"
    Then Message is displayed on confirmation window
      | DELETE COMMENT                                                              |
      | Are you sure you want to delete this Comment? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Created comment on Activity Information page is displayed
    When User on Activity information page deletes comment "Activity comment text N1"
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Comment has been deleted. |
    And Confirmation window is disappeared
    And Created comment on Activity Information page is not displayed
