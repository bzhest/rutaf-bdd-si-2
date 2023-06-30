@ui @full_regression @react @workflow_history_risk_management
Feature: Risk Management - Workflow History

  @C39014725
  @core_regression
  Scenario: C39014725: [React migration] Risk Management - Workflow History Overview
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                | STATUS     | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Automation Workflow | Onboarding | 3.2                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |

  @C39014726
  Scenario: C39014726: [React migration] Risk Management - Workflow History Overview - No Available Data for workflow
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    Then Third-party's status should be shown - "NEW"
    When User clicks on Risk Management tab
    Then Risk Management "Workflow" table shows "NO AVAILABLE DATA" message

  @C39057718
  @core_regression
  Scenario: C39057718: [React migration] Risk Management - Workflow History - Onboarding Trigger
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name           | Automation Workflow Questionnaire             |
      | Status                  | Onboarding                                    |
      | Workflow Type           | Onboarding                                    |
      | Description             | Automation Workflow Questionnaire Description |
      | Initiated By            | Admin_AT_FN Admin_AT_LN                       |
      | Overall Risk Score      | 2.4                                           |
      | Onboarding Start Date   | TODAY+0                                       |
      | Onboarded Decision Date |                                               |

  @C39057719
  @core_regression
  Scenario: C39057719: [React migration] Risk Management - Workflow History - Stopped Onboarding
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Stop Onboarding" third-party button
    Then Message is displayed on confirmation window
      | Are you sure you want to stop the Onboarding Process? This cannot be undone and you will have to restart the Onboarding Process again. |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "NEW"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Stopped Onboarding" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name           | Automation Workflow Questionnaire             |
      | Status                  | Stopped Onboarding                            |
      | Workflow Type           | Onboarding                                    |
      | Description             | Automation Workflow Questionnaire Description |
      | Initiated By            | Admin_AT_FN Admin_AT_LN                       |
      | Overall Risk Score      | 2.4                                           |
      | Onboarding Start Date   | TODAY+0                                       |
      | Onboarding Stopped Date | TODAY+0                                       |

  @C39057721
  @core_regression
  Scenario: C39057721: [React migration] Risk Management - Workflow History - Declined Onboarding
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Decline Onboarding" third-party button
    Then Message is displayed on confirmation window
      | Are you sure you want to decline the Onboarding Process? This cannot be undone and you will have to restart the Onboarding Process again. |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "ONBOARDING DENIED"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Declined Onboarding" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name          | Automation Workflow Questionnaire             |
      | Status                 | Declined Onboarding                           |
      | Workflow Type          | Onboarding                                    |
      | Description            | Automation Workflow Questionnaire Description |
      | Initiated By           | Admin_AT_FN Admin_AT_LN                       |
      | Overall Risk Score     | 2.4                                           |
      | Onboarding Start Date  | TODAY+0                                       |
      | Onboarding Denied Date | TODAY+0                                       |

  @C39057786
  @core_regression
  Scenario: C39057786: [React migration] Risk Management - Workflow History - Onboarded
    Given User logs into RDDC as "Admin"
    When User creates third-party "with renewal workflow Norway" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Custom Component" tab
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Auto Workflow Renewal Workflow Low Risk Onboarding" and status "Onboarded" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name           | Auto Workflow Renewal Workflow Low Risk Onboarding              |
      | Status                  | Onboarded                                                       |
      | Workflow Type           | Onboarding                                                      |
      | Description             | Onboarding Workflow for automation test with For Renewal status |
      | Initiated By            | Admin_AT_FN Admin_AT_LN                                         |
      | Overall Risk Score      | 2.4                                                             |
      | Onboarding Start Date   | TODAY+0                                                         |
      | Onboarded Decision Date | TODAY+0                                                         |

  @C39057851
  @core_regression
  Scenario: C39057851: [React migration] Risk Management - Workflow History - Renewing
    Given User logs into RDDC as "Admin"
    When User creates third-party "with renewal workflow Norway" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Custom Component" tab
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    When User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And User refreshes page
    Then Third-party's element "Renew" should be shown
    When User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Auto Workflow Renewal Workflow Low Risk" and status "Renewing" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name           | Auto Workflow Renewal Workflow Low Risk                      |
      | Status                  | Renewing                                                     |
      | Workflow Type           | Renewal                                                      |
      | Description             | Renewal Workflow for automation test with For Renewal status |
      | Initiated By            | Admin_AT_FN Admin_AT_LN                                      |
      | Overall Risk Score      | 2.4                                                          |
      | Renewal Start Date      | TODAY+0                                                      |
      | Onboarded Decision Date |                                                              |

  @C39057852
  @core_regression
  Scenario: C39057852: [React migration] Risk Management - Workflow History - Stopped Renewal
    Given User logs into RDDC as "Admin"
    When User creates third-party "with renewal workflow Norway" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Custom Component" tab
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    When User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And User refreshes page
    Then Third-party's element "Renew" should be shown
    When User clicks "Renew" for third-party
    And User clicks "Stop Renewal" for third-party
    Then Message is displayed on confirmation window
      | Are you sure you want to stop the Renewal Process?                           |
      | This cannot be undone and you will have to restart the Renewal Process again |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "FOR RENEWAL"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Auto Workflow Renewal Workflow Low Risk" and status "Stopped Renewal" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name        | Auto Workflow Renewal Workflow Low Risk                      |
      | Status               | Stopped Renewal                                              |
      | Workflow Type        | Renewal                                                      |
      | Description          | Renewal Workflow for automation test with For Renewal status |
      | Initiated By         | Admin_AT_FN Admin_AT_LN                                      |
      | Overall Risk Score   | 2.4                                                          |
      | Renewal Start Date   | TODAY+0                                                      |
      | Renewal Stopped Date | TODAY+0                                                      |

  @C39057856
  @core_regression
  Scenario: C39057856: [React migration] Risk Management - Workflow History - Renewal Denied
    Given User logs into RDDC as "Admin"
    When User creates third-party "with renewal workflow Norway" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Custom Component" tab
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    When User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    And User refreshes page
    Then Third-party's element "Renew" should be shown
    When User clicks "Renew" for third-party
    And User clicks "Decline Renewal" for third-party
    Then Message is displayed on confirmation window
      | Are you sure you want to decline the Renewal Process?                           |
      | This cannot be undone and you will have to restart the Onboarding Process again |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "RENEWAL DENIED"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Auto Workflow Renewal Workflow Low Risk" and status "Renewal Denied" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name       | Auto Workflow Renewal Workflow Low Risk                      |
      | Status              | Renewal Denied                                               |
      | Workflow Type       | Renewal                                                      |
      | Description         | Renewal Workflow for automation test with For Renewal status |
      | Initiated By        | Admin_AT_FN Admin_AT_LN                                      |
      | Overall Risk Score  | 2.4                                                          |
      | Renewal Start Date  | TODAY+0                                                      |
      | Renewal Denied Date | TODAY+0                                                      |

  @C39057919
  @core_regression
  Scenario: C39057919: [React migration] Risk Management - Workflow History - Display Approvers in Activity Details
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineIndividualWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Reject" button
    And User clicks Proceed button on confirmation window
    Then Confirmation window is disappeared
    When Approver clicks "Re-assign for Approval" button
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Reassign" button
    And User assigns approver "Assignee_AT_FN Assignee_AT_LN"
    And Approver "Assignee_AT_FN Assignee_AT_LN" clicks "Approve" button
    And User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Individual with Approver" and status "Onboarding" on Risk Management tab
    Then Workflow History activity groups titles should be displayed
      | GROUP # | ACTIVITY NAME |
    And Workflow History activity groups values should be displayed
      | 0 | OrderDueDiligenceReport |
    And Workflow History Activity values should be displayed
      | Activity Type | Order Due Diligence Report |
      | Description   | description                |
      | Status        | Not Started                |
      | Assignee      | Admin_AT_FN Admin_AT_LN    |
      | Risk Area     |                            |
      | Start Date    | TODAY+0                    |
      | Due Date      | TODAY+1                    |
      | Last Update   | TODAY+0                    |
    And Workflow History Activity Approver "Admin_AT_FN Admin_AT_LN" Rejected 'Check' icon is displayed
    And Workflow History Activity Approver Rejected 'Check' icon is red
    And Workflow History Activity Approver "Admin_AT_FN Admin_AT_LN" Reassigned 'Check' icon is displayed
    And Workflow History Activity Approver Reassigned 'Check' icon is grey
    And Workflow History Activity Approver "Assignee_AT_FN Assignee_AT_LN" Pending 'Check' icon is displayed
    And Workflow History Activity Approver Pending 'Check' icon is grey
    And Workflow History Activity Approver "Assignee_AT_FN Assignee_AT_LN" Approved 'Check' icon is displayed
    And Workflow History Activity Approver Approved 'Check' icon is green

  @C39057920
  @RMS-16176
  Scenario: C39057920: [React migration] Risk Management - Workflow History - Display Reviewers in Activity Details
    Given User logs into RDDC as "Admin"
    When User creates third-party "with Auto_Workflow_Group_Dashboard workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Order Due Diligence Report" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks Edit button for Activity
    And User clicks Decline Order button
    And User clicks Proceed button on confirmation window
    And User clicks on "Order Due Diligence Report" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks "New Component" component tab
    And User clicks on "Order Due Diligence Report" activity
    And User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Proceed button on confirmation window
    Then Confirmation window is disappeared
    When User clicks "Re-assign for Review" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks "Reassign" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User selects "Assignee_AT_FN Assignee_AT_LN" reviewer user
    And User clicks "Review" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    And User clicks on Risk Management tab
    And User clicks workflow with name "Automation_Workflow_Dashboard" and status "Onboarding" on Risk Management tab
    Then Workflow History activity groups titles should be displayed
      | GROUP # | ACTIVITY NAME |
    And Workflow History activity groups values should be displayed
      | 0 | OrderDueDiligenceReport |
    And Workflow History Activity values should be displayed
      | Activity Type | Order Due Diligence Report |
      | Description   | Test Automation activity   |
      | Status        | Completed                  |
      | Assignee      | Admin_AT_FN Admin_AT_LN    |
      | Risk Area     |                            |
      | Start Date    | TODAY+0                    |
      | Due Date      | TODAY+1                    |
      | Last Update   | TODAY+0                    |
    And Workflow History Activity Reviewer "Admin_AT_FN Admin_AT_LN" Rejected 'Check' icon is displayed
    And Workflow History Activity Reviewer Rejected 'Check' icon is red
    And Workflow History Activity Reviewer "Admin_AT_FN Admin_AT_LN" Reassigned 'Check' icon is displayed
    And Workflow History Activity Reviewer Reassigned 'Check' icon is grey
    And Workflow History Activity Reviewer "Assignee_AT_FN Assignee_AT_LN" Pending 'Check' icon is displayed
    And Workflow History Activity Reviewer Pending 'Check' icon is grey
#    TODO uncomment when RMS-16176 will be fixed
#    And Workflow History Activity Reviewer "Assignee_AT_FN Assignee_AT_LN" Approved 'Check' icon is displayed
#    And Workflow History Activity Reviewer Approved 'Check' icon is green

  @C39065221
  @core_regression
  Scenario: C39065221: [React migration] Risk Management - Workflow History - Export to PDF
    Given User logs into RDDC as "Admin"
    And User creates third-party "with questionnaire workflow" via API and open it
    When User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User uploads "logo.jpg" Attachment on Workflow History page
    And User clicks "UPLOAD" button for Workflow History Activity Attachment
    And User fills in comment field "Test Comment" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    And User refreshes page
    And User clicks "Assign Questionnaire" Activity details on Workflow History page
    And User clicks Export to PDF link
    Then ".pdf" File with name "RDDCentre_WorkflowHistory_" and date format "MMddYYYY" downloaded

  @C39071930
  @core_regression
  Scenario: C39071930: [React Migration] Risk Management - Workflow History: Activity Attachment
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow" and status "Onboarding" on Risk Management tab
    Then Workflow History Activity Attachment Upload field and Browse button are displayed
    And Workflow History Activity Attachment Description field is displayed
    And Workflow History Activity Attachment buttons are displayed
      | CANCEL |
      | UPLOAD |
    And Workflow History Activity Attachment UPLOAD button is disabled
    When User adds Workflow History attachment description "not applicable"
    Then Workflow History Attachment description characters limit text is displayed
      | You have reached the maximum characters limit |
    When User adds Workflow History attachment description "applicable"
    Then Workflow History Attachment description characters limit text is not displayed
      | You have reached the maximum characters limit |
    When User uploads "more25mb.jpg" Attachment on Workflow History page
    Then Message "The file reached maximum file size of 25 MB" appears under uploads Workflow History file input
    When User adds Workflow History attachments
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
    And Workflow History Activity Attachment table is displayed with details
      | File Name        | Description          | Upload Date |
      | oldDocFile.doc   | Attachment doc file  | TODAY+      |
      | newDocFile.docx  | Attachment docx file | TODAY+      |
      | PPTfile.ppt      | Attachment ppt file  | TODAY+      |
      | PPTxfile.pptx    | Attachment pptx file | TODAY+      |
      | xlsFile.xls      | Attachment xls file  | TODAY+      |
      | xlsxFile.xlsx    | Attachment xlsx file | TODAY+      |
      | logo.jpg         | Attachment jpg file  | TODAY+      |
      | logo.jpeg        | Attachment jpeg file | TODAY+      |
      | test.png         | Attachment png file  | TODAY+      |
      | meme-cat.gif     | Attachment gif file  | TODAY+      |
      | csvFile.csv      | Attachment csv file  | TODAY+      |
      | testPDFimage.pdf | Attachment pdf file  | TODAY+      |
      | dotxFile.dotx    | Attachment dotx file | TODAY+      |
      | PPSfile.pps      | Attachment pps file  | TODAY+      |
      | PPSXfile.ppsx    | Attachment ppsx file | TODAY+      |
      | zipFile.zip      | Attachment zip file  | TODAY+      |
      | rarFile.rar      | Attachment rar file  | TODAY+      |
      | 7zFile.7z        | Attachment 7z file   | TODAY+      |
      | simple text.txt  | Attachment txt file  | TODAY+      |
      | Google.html      | Attachment html file | TODAY+      |
    And Workflow History Activity Attachment table is displayed with headers
      | FILE NAME | DESCRIPTION | UPLOAD DATE |
    And Workflow History Activity Attachment Upload field and Browse button are not displayed
    And Workflow History Activity Attachment buttons are available for all files
      | Download |
      | Delete   |
    When User clicks delete button for Workflow History attachment with name "Google.html"
    Then Message is displayed on confirmation window
      | DELETE ATTACHMENT                                                              |
      | Are you sure you want to delete this Attachment? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Workflow History Activity Attachment table is displayed with details
      | File Name   | Description          | Upload Date |
      | Google.html | Attachment html file | TODAY+      |
    When User clicks delete button for Workflow History attachment with name "Google.html"
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Attachment has been deleted. |
    And Confirmation window is disappeared
    When User clicks delete button for Workflow History attachment with name "simple text.txt"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    When User clicks delete button for Workflow History attachment with name "PPSXfile.ppsx"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    When User clicks delete button for Workflow History attachment with name "zipFile.zip"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    When User clicks delete button for Workflow History attachment with name "rarFile.rar"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    When User clicks delete button for Workflow History attachment with name "7zFile.7z"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Workflow History Activity Attachment table is not displayed with details
      | File Name       | Description          | Upload Date |
      | PPSXfile.ppsx   | Attachment ppsx file | TODAY+      |
      | zipFile.zip     | Attachment zip file  | TODAY+      |
      | rarFile.rar     | Attachment rar file  | TODAY+      |
      | 7zFile.7z       | Attachment 7z file   | TODAY+      |
      | simple text.txt | Attachment txt file  | TODAY+      |
      | Google.html     | Attachment html file | TODAY+      |
    When User adds Workflow History attachments
      | sample-msg-file.msg | Attachment msg file  |
      | odtFile.odt         | Attachment odt file  |
      | xlsmFile.xlsm       | Attachment xlsm file |
      | Google.htm          | Attachment htm file  |
    Then Workflow History Activity Attachment table is displayed with details
      | File Name           | Description          | Upload Date |
      | oldDocFile.doc      | Attachment doc file  | TODAY+      |
      | newDocFile.docx     | Attachment docx file | TODAY+      |
      | PPTfile.ppt         | Attachment ppt file  | TODAY+      |
      | PPTxfile.pptx       | Attachment pptx file | TODAY+      |
      | xlsFile.xls         | Attachment xls file  | TODAY+      |
      | xlsxFile.xlsx       | Attachment xlsx file | TODAY+      |
      | logo.jpg            | Attachment jpg file  | TODAY+      |
      | logo.jpeg           | Attachment jpeg file | TODAY+      |
      | test.png            | Attachment png file  | TODAY+      |
      | meme-cat.gif        | Attachment gif file  | TODAY+      |
      | csvFile.csv         | Attachment csv file  | TODAY+      |
      | testPDFimage.pdf    | Attachment pdf file  | TODAY+      |
      | dotxFile.dotx       | Attachment dotx file | TODAY+      |
      | PPSfile.pps         | Attachment pps file  | TODAY+      |
      | sample-msg-file.msg | Attachment msg file  | TODAY+      |
      | odtFile.odt         | Attachment odt file  | TODAY+      |
      | xlsmFile.xlsm       | Attachment xlsm file | TODAY+      |
      | Google.htm          | Attachment htm file  | TODAY+      |
    When User clicks Workflow History attachment table column "File Name"
    Then Workflow History attachment table displays records sorted by "File Name" in "DESC" order
    When User clicks Workflow History attachment table column "File Name"
    Then Workflow History attachment table displays records sorted by "File Name" in "ASC" order
    When User clicks Workflow History attachment table column "Description"
    Then Workflow History attachment table displays records sorted by "Description" in "DESC" order
    When User clicks Workflow History attachment table column "Description"
    Then Workflow History attachment table displays records sorted by "Description" in "ASC" order
    When User clicks Workflow History attachment table column "Upload Date"
    Then Workflow History attachment table displays records sorted by "Upload Date" in "DESC" order
    When User clicks Workflow History attachment table column "Upload Date"
    Then Workflow History attachment table displays records sorted by "Upload Date" in "ASC" order
    When User clicks on Workflow History Attachment "oldDocFile.doc" download button
    Then File is successfully downloaded
    When User clicks on Third-party Information tab
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information page Attachment table row appears
      | File Name           | Description          | Upload Date |
      | oldDocFile.doc      | Attachment doc file  | TODAY+      |
      | newDocFile.docx     | Attachment docx file | TODAY+      |
      | PPTfile.ppt         | Attachment ppt file  | TODAY+      |
      | PPTxfile.pptx       | Attachment pptx file | TODAY+      |
      | xlsFile.xls         | Attachment xls file  | TODAY+      |
      | xlsxFile.xlsx       | Attachment xlsx file | TODAY+      |
      | logo.jpg            | Attachment jpg file  | TODAY+      |
      | logo.jpeg           | Attachment jpeg file | TODAY+      |
      | test.png            | Attachment png file  | TODAY+      |
      | meme-cat.gif        | Attachment gif file  | TODAY+      |
      | csvFile.csv         | Attachment csv file  | TODAY+      |
      | testPDFimage.pdf    | Attachment pdf file  | TODAY+      |
      | dotxFile.dotx       | Attachment dotx file | TODAY+      |
      | PPSfile.pps         | Attachment pps file  | TODAY+      |
      | sample-msg-file.msg | Attachment msg file  | TODAY+      |
      | odtFile.odt         | Attachment odt file  | TODAY+      |
      | xlsmFile.xlsm       | Attachment xlsm file | TODAY+      |
      | Google.htm          | Attachment htm file  | TODAY+      |

  @C39080299
  @core_regression
  Scenario: C39080299: [React Migration] Risk Management - Workflow History: Activity Comment
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow" and status "Onboarding" on Risk Management tab
    And User fills in comment field "Auto Activity Comment test" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    Then Workflow History Activity Comment "Auto Activity Comment test" is added
    When User clicks "Edit" Workflow History Activity Comment "Auto Activity Comment test" button
    Then Workflow History page edit comment text area contains "Auto Activity Comment test"
    And Workflow History Activity Comment buttons are displayed
      | Cancel  |
      | Comment |
    And Workflow History edit comment length message "Characters : 26/5000" is displayed
    When User fills in edit comment field "Edit Auto Activity Comment test" for Workflow History Activity
    And User clicks "Cancel" edit button for Workflow History Activity Comment
    Then Workflow History Activity Comment "Auto Activity Comment test" is added
    And Workflow History page edit comment text area is not displayed
    When User clicks "Edit" Workflow History Activity Comment "Auto Activity Comment test" button
    And User fills in edit comment field "Edit Auto Activity Comment test" for Workflow History Activity
    And User clicks "Save" edit button for Workflow History Activity Comment
    Then Alert Icon is displayed with text
      | Success! Comment has been updated. |
    And Workflow History Activity Comment "Edit Auto Activity Comment test" is added
    And Workflow History page edit comment text area is not displayed
    And Workflow History comment "Edited" message is displayed next to creation date
    When User clicks "Delete" Workflow History Activity Comment "Edit Auto Activity Comment test" button
    Then Message is displayed on confirmation window
      | DELETE COMMENT                                                              |
      | Are you sure you want to delete this Comment? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Workflow History Activity Comment "Edit Auto Activity Comment test" is added
    When User clicks "Delete" Workflow History Activity Comment "Edit Auto Activity Comment test" button
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Comment has been deleted. |
    And Confirmation window is disappeared
    And Workflow History Activity Comment "Edit Auto Activity Comment test" is not displayed

  @C39086625
  @core_regression
  Scenario: C39086625: [React Migration] Risk Management - Workflow History: Activity Comment - Edit/Delete
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow" and status "Onboarding" on Risk Management tab
    Then Workflow History comment section is expanded
    And Workflow History Activity Comment buttons are displayed
      | Cancel  |
      | Comment |
    And Workflow History Activity Comment button "Comment" is disabled
    When User fills in comment field "Auto Activity Comment test" for Workflow History Activity
    Then Workflow History Activity Comment button "Comment" is enabled
    When User clicks "Cancel" button for Workflow History Activity Comment
    Then Workflow History page add comment text area contains ""
    When User fills in comment field "Test Comment Text #1" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    Then Alert Icon is displayed with text
      | Success! Comment has been added. |
    Then Workflow History Activity Comment "Test Comment Text #1" is added
    When User fills in comment field "Test Comment Text #2" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    Then Workflow History Activity Comment "Test Comment Text #2" is added
    When User fills in comment field "Test Comment Text #3" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    Then Workflow History Activity Comment "Test Comment Text #3" is added
    When User fills in comment field "Test Comment Text #4" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    Then Workflow History Activity Comment "Test Comment Text #4" is added
    When User fills in comment field "Test Comment Text #5" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    Then Workflow History Activity Comment "Test Comment Text #5" is added
    When User fills in comment field "Test Comment Text #6" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    Then Workflow History Activity Comment "Test Comment Text #6" is added
    And Workflow History Activity Comments displayed
      | Test Comment Text #6 |
      | Test Comment Text #5 |
      | Test Comment Text #4 |
    When User fills in comment field "500KmGef@#$%r5lQppOQTCfKW9hSn4ufzuG8fFw7BhoM5f5TrvGoxtoDCYGs9L0FrpWmOXy0a6rpyammy8I36yr4gqm7mWGl64CTFKanNLhOtWpipzyQMtbniR20JiTZ5wVeAdtfhzS9OBXDGvw8XAgIyjssLr95t04HTsqMSkdTfvisjA8hYNONPRh2sdhgJq0Yrn8nu5zqHiFjEwO9f0QGoq1MlEmS9ZXyvzv0rRBe1j9cedpJIZvJpQwxr7HRPf32Ik4jkMGK2Ypvm47RRZp6cyOz9vxWM5hgYApkd6CeAum3Qn7y4zdbTedBNaHLughMB03ufsnvolt4boRXA6kVeRhySFrFYBkLC5OgDw4oJmXUxVGiMlob6Ec4yF7gNRnYmR4fnkjLRFHstbFCFqagT9MNolHtez8U4VfxoStk9swh5OWVnGoBeKfp1IUkdIwZY6ClxRWM4FWyBHbN5k6OhJf551WwiHGdhtOQmaw1NjDeEKW2" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    Then Workflow History Activity Comment "[See more]" button is displayed for comment "500KmGef@#$%r5lQppOQTCfKW9hSn4ufzuG8fFw7BhoM5f5TrvGoxtoDCYGs9L0FrpWmOXy0a6rpyammy8I36yr4gqm7mWGl64CTFKanNLhOtWpipzyQMtbniR20JiTZ5wVeAdtfhzS9OBXDGvw8XAgIyjssLr95t04HTsqMSkdTfvisjA8hYNONPRh2sdhgJq0Yrn8nu5zqHiFjEwO9f0QGoq1MlEmS9ZXyvzv0rRBe1j9cedpJIZvJpQwxr7HRPf32Ik4jkMGK2Ypvm47RRZp6cyOz9vxWM5hgYApkd6CeAum3Qn7y4zdbTedBNaHLughMB03ufsnvolt4boRXA6kVeRhySFrFYBkLC5OgDw4oJmXUxVGiMlob6Ec4yF7gNRnYmR4fnkjLRFHstbFCFqagT9MNolHtez8U4VfxoStk9swh5OWVnGoBeKfp1IUkdIwZY6ClxRWM4FWyBHbN5k6OhJf551WwiHGdhtOQmaw1NjDeEKW2"
    When User clicks Workflow History Activity Comment "[See more]" button for comment "500KmGef@#$%r5lQppOQTCfKW9hSn4ufzuG8fFw7BhoM5f5TrvGoxtoDCYGs9L0FrpWmOXy0a6rpyammy8I36yr4gqm7mWGl64CTFKanNLhOtWpipzyQMtbniR20JiTZ5wVeAdtfhzS9OBXDGvw8XAgIyjssLr95t04HTsqMSkdTfvisjA8hYNONPRh2sdhgJq0Yrn8nu5zqHiFjEwO9f0QGoq1MlEmS9ZXyvzv0rRBe1j9cedpJIZvJpQwxr7HRPf32Ik4jkMGK2Ypvm47RRZp6cyOz9vxWM5hgYApkd6CeAum3Qn7y4zdbTedBNaHLughMB03ufsnvolt4boRXA6kVeRhySFrFYBkLC5OgDw4oJmXUxVGiMlob6Ec4yF7gNRnYmR4fnkjLRFHstbFCFqagT9MNolHtez8U4VfxoStk9swh5OWVnGoBeKfp1IUkdIwZY6ClxRWM4FWyBHbN5k6OhJf551WwiHGdhtOQmaw1NjDeEKW2"
    Then Workflow History Activity Comment "[See more]" button is not displayed for comment "500KmGef@#$%r5lQppOQTCfKW9hSn4ufzuG8fFw7BhoM5f5TrvGoxtoDCYGs9L0FrpWmOXy0a6rpyammy8I36yr4gqm7mWGl64CTFKanNLhOtWpipzyQMtbniR20JiTZ5wVeAdtfhzS9OBXDGvw8XAgIyjssLr95t04HTsqMSkdTfvisjA8hYNONPRh2sdhgJq0Yrn8nu5zqHiFjEwO9f0QGoq1MlEmS9ZXyvzv0rRBe1j9cedpJIZvJpQwxr7HRPf32Ik4jkMGK2Ypvm47RRZp6cyOz9vxWM5hgYApkd6CeAum3Qn7y4zdbTedBNaHLughMB03ufsnvolt4boRXA6kVeRhySFrFYBkLC5OgDw4oJmXUxVGiMlob6Ec4yF7gNRnYmR4fnkjLRFHstbFCFqagT9MNolHtez8U4VfxoStk9swh5OWVnGoBeKfp1IUkdIwZY6ClxRWM4FWyBHbN5k6OhJf551WwiHGdhtOQmaw1NjDeEKW2"
    And Workflow History Activity Comment "[See less]" button is displayed for comment "500KmGef@#$%r5lQppOQTCfKW9hSn4ufzuG8fFw7BhoM5f5TrvGoxtoDCYGs9L0FrpWmOXy0a6rpyammy8I36yr4gqm7mWGl64CTFKanNLhOtWpipzyQMtbniR20JiTZ5wVeAdtfhzS9OBXDGvw8XAgIyjssLr95t04HTsqMSkdTfvisjA8hYNONPRh2sdhgJq0Yrn8nu5zqHiFjEwO9f0QGoq1MlEmS9ZXyvzv0rRBe1j9cedpJIZvJpQwxr7HRPf32Ik4jkMGK2Ypvm47RRZp6cyOz9vxWM5hgYApkd6CeAum3Qn7y4zdbTedBNaHLughMB03ufsnvolt4boRXA6kVeRhySFrFYBkLC5OgDw4oJmXUxVGiMlob6Ec4yF7gNRnYmR4fnkjLRFHstbFCFqagT9MNolHtez8U4VfxoStk9swh5OWVnGoBeKfp1IUkdIwZY6ClxRWM4FWyBHbN5k6OhJf551WwiHGdhtOQmaw1NjDeEKW2"
    When User clicks Workflow History Activity Comment "[See less]" button for comment "500KmGef@#$%r5lQppOQTCfKW9hSn4ufzuG8fFw7BhoM5f5TrvGoxtoDCYGs9L0FrpWmOXy0a6rpyammy8I36yr4gqm7mWGl64CTFKanNLhOtWpipzyQMtbniR20JiTZ5wVeAdtfhzS9OBXDGvw8XAgIyjssLr95t04HTsqMSkdTfvisjA8hYNONPRh2sdhgJq0Yrn8nu5zqHiFjEwO9f0QGoq1MlEmS9ZXyvzv0rRBe1j9cedpJIZvJpQwxr7HRPf32Ik4jkMGK2Ypvm47RRZp6cyOz9vxWM5hgYApkd6CeAum3Qn7y4zdbTedBNaHLughMB03ufsnvolt4boRXA6kVeRhySFrFYBkLC5OgDw4oJmXUxVGiMlob6Ec4yF7gNRnYmR4fnkjLRFHstbFCFqagT9MNolHtez8U4VfxoStk9swh5OWVnGoBeKfp1IUkdIwZY6ClxRWM4FWyBHbN5k6OhJf551WwiHGdhtOQmaw1NjDeEKW2"
    Then Workflow History Activity Comment "[See less]" button is not displayed for comment "500KmGef@#$%r5lQppOQTCfKW9hSn4ufzuG8fFw7BhoM5f5TrvGoxtoDCYGs9L0FrpWmOXy0a6rpyammy8I36yr4gqm7mWGl64CTFKanNLhOtWpipzyQMtbniR20JiTZ5wVeAdtfhzS9OBXDGvw8XAgIyjssLr95t04HTsqMSkdTfvisjA8hYNONPRh2sdhgJq0Yrn8nu5zqHiFjEwO9f0QGoq1MlEmS9ZXyvzv0rRBe1j9cedpJIZvJpQwxr7HRPf32Ik4jkMGK2Ypvm47RRZp6cyOz9vxWM5hgYApkd6CeAum3Qn7y4zdbTedBNaHLughMB03ufsnvolt4boRXA6kVeRhySFrFYBkLC5OgDw4oJmXUxVGiMlob6Ec4yF7gNRnYmR4fnkjLRFHstbFCFqagT9MNolHtez8U4VfxoStk9swh5OWVnGoBeKfp1IUkdIwZY6ClxRWM4FWyBHbN5k6OhJf551WwiHGdhtOQmaw1NjDeEKW2"
    And Workflow History Activity Comment "[See more]" button is displayed for comment "500KmGef@#$%r5lQppOQTCfKW9hSn4ufzuG8fFw7BhoM5f5TrvGoxtoDCYGs9L0FrpWmOXy0a6rpyammy8I36yr4gqm7mWGl64CTFKanNLhOtWpipzyQMtbniR20JiTZ5wVeAdtfhzS9OBXDGvw8XAgIyjssLr95t04HTsqMSkdTfvisjA8hYNONPRh2sdhgJq0Yrn8nu5zqHiFjEwO9f0QGoq1MlEmS9ZXyvzv0rRBe1j9cedpJIZvJpQwxr7HRPf32Ik4jkMGK2Ypvm47RRZp6cyOz9vxWM5hgYApkd6CeAum3Qn7y4zdbTedBNaHLughMB03ufsnvolt4boRXA6kVeRhySFrFYBkLC5OgDw4oJmXUxVGiMlob6Ec4yF7gNRnYmR4fnkjLRFHstbFCFqagT9MNolHtez8U4VfxoStk9swh5OWVnGoBeKfp1IUkdIwZY6ClxRWM4FWyBHbN5k6OhJf551WwiHGdhtOQmaw1NjDeEKW2"
    And Workflow History Activity Comments displayed
      | 500KmGef@#$%r5lQppOQTCfKW9hSn4ufzuG8fFw7BhoM5f5TrvGoxtoDCYGs9L0FrpWmOXy0a6rpyammy8I36yr4gqm7mWGl64CTFKanNLhOtWpipzyQMtbniR20JiTZ5wVeAdtfhzS9OBXDGvw8XAgIyjssLr95t04HTsqMSkdTfvisjA8hYNONPRh2sdhgJq0Yrn8nu5zqHiFjEwO9f0QGoq1MlEmS9ZXyvzv0rRBe1j9cedpJIZvJpQwxr7HRPf32Ik4jkMGK2Ypvm47RRZp6cyOz9vxWM5hgYApkd6CeAum3Qn7y4zdbTedBNaHLughMB03ufsnvolt4boRXA6kVeRhySFrFYBkLC5OgDw4oJmXUxVGiMlob6Ec4yF7gNRnYmR4fnkjLRFHstbFCFqagT9MNolHtez8U4VfxoStk9swh5OWVnGoBeKfp1IUkdIwZY6ClxRWM4FWyBHbN5k6OhJf551WwiHGdhtOQmaw1NjDeEKW2 |
      | Test Comment Text #6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Test Comment Text #5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
    When User clicks Workflow History Activity comment section button "Show More"
    Then Workflow History Activity Comments displayed
      | 500KmGef@#$%r5lQppOQTCfKW9hSn4ufzuG8fFw7BhoM5f5TrvGoxtoDCYGs9L0FrpWmOXy0a6rpyammy8I36yr4gqm7mWGl64CTFKanNLhOtWpipzyQMtbniR20JiTZ5wVeAdtfhzS9OBXDGvw8XAgIyjssLr95t04HTsqMSkdTfvisjA8hYNONPRh2sdhgJq0Yrn8nu5zqHiFjEwO9f0QGoq1MlEmS9ZXyvzv0rRBe1j9cedpJIZvJpQwxr7HRPf32Ik4jkMGK2Ypvm47RRZp6cyOz9vxWM5hgYApkd6CeAum3Qn7y4zdbTedBNaHLughMB03ufsnvolt4boRXA6kVeRhySFrFYBkLC5OgDw4oJmXUxVGiMlob6Ec4yF7gNRnYmR4fnkjLRFHstbFCFqagT9MNolHtez8U4VfxoStk9swh5OWVnGoBeKfp1IUkdIwZY6ClxRWM4FWyBHbN5k6OhJf551WwiHGdhtOQmaw1NjDeEKW2 |
      | Test Comment Text #6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Test Comment Text #5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Test Comment Text #4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Test Comment Text #3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Test Comment Text #2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
    When User clicks Workflow History Activity comment section button "Show More"
    Then Workflow History Activity comment section button "Show More" is not displayed
    Then Workflow History Activity comment section button "Hide comments" is displayed
    When User clicks Workflow History Activity comment section button "Hide comments"
    And User clicks Workflow History Activity comment section button "Show all comments"
    Then Workflow History Activity Comments displayed
      | 500KmGef@#$%r5lQppOQTCfKW9hSn4ufzuG8fFw7BhoM5f5TrvGoxtoDCYGs9L0FrpWmOXy0a6rpyammy8I36yr4gqm7mWGl64CTFKanNLhOtWpipzyQMtbniR20JiTZ5wVeAdtfhzS9OBXDGvw8XAgIyjssLr95t04HTsqMSkdTfvisjA8hYNONPRh2sdhgJq0Yrn8nu5zqHiFjEwO9f0QGoq1MlEmS9ZXyvzv0rRBe1j9cedpJIZvJpQwxr7HRPf32Ik4jkMGK2Ypvm47RRZp6cyOz9vxWM5hgYApkd6CeAum3Qn7y4zdbTedBNaHLughMB03ufsnvolt4boRXA6kVeRhySFrFYBkLC5OgDw4oJmXUxVGiMlob6Ec4yF7gNRnYmR4fnkjLRFHstbFCFqagT9MNolHtez8U4VfxoStk9swh5OWVnGoBeKfp1IUkdIwZY6ClxRWM4FWyBHbN5k6OhJf551WwiHGdhtOQmaw1NjDeEKW2 |
      | Test Comment Text #6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Test Comment Text #5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Test Comment Text #4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Test Comment Text #3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Test Comment Text #2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Test Comment Text #1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
    And Workflow History Activity comment section button "Show More" is not displayed
    And Workflow History Activity comment section button "Show all comments" is not displayed
    And Workflow History Activity comment section button "Hide comments" is displayed

  @C39511040
  Scenario: C39511040: [React migration] Risk Management- View Workflow History- Assign Questionnaire - Display questionnaires
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    Then Workflow History Questionnaire details is displayed
      | Questionnaire Name               | Status      | Reviewer                | Overall Assessment | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Unresponded | Admin_AT_FN Admin_AT_LN |                    |       |
    And Workflow History Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" action button "View" is displayed
    When User clicks Workflow History Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" action button "View"
    Then Questionnaire details page is displayed
    When User clicks Cancel questionnaire form button
    Then Workflow History window is displayed

  @C39511041
  Scenario: C39511041: [React migration] Risk Management- View Workflow History- Questionnaire assigned - Display questionnaires
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    And User clicks "Internal Questionnaire for" Activity details on Workflow History page
    Then Workflow History Questionnaire details is displayed
      | Questionnaire Name               | Status      |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Unresponded |
    And Workflow History Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" action button "View" is displayed
    When User clicks Workflow History Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" action button "View"
    Then Questionnaire details page is displayed
    When User clicks Questionnaire Overall Assessment button "Cancel"
    Then Workflow History window is displayed

  @C39511042
  @core_regression
  @onlySingleThread
  Scenario: C39511042: [React Migration] Risk Management - Workflow History: Activity Attachment Roles Permissions
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User sets up role "AUTO TEST ROLE WITH DOWNLOAD AND ADD FILES PERMISSION" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name           | Automation Workflow Questionnaire             |
      | Status                  | Onboarding                                    |
      | Workflow Type           | Onboarding                                    |
      | Description             | Automation Workflow Questionnaire Description |
      | Initiated By            | Admin_AT_FN Admin_AT_LN                       |
      | Overall Risk Score      | 2.4                                           |
      | Onboarding Start Date   | TODAY+0                                       |
      | Onboarded Decision Date |                                               |
    And Workflow History activity groups titles should be displayed
      | GROUP # | ACTIVITY NAME |
    And Workflow History activity groups values should be displayed
      | 0 | Assign Questionnaire |
    And Workflow History Activity Attachment Upload field and Browse button are displayed
    And Workflow History Activity Attachment Description field is displayed
    And Workflow History Activity Attachment buttons are displayed
      | CANCEL |
      | UPLOAD |
    When User adds Workflow History attachments
      | oldDocFile.doc | Attachment doc file |
    Then Workflow History Activity Attachment table is displayed with details
      | File Name      | Description         | Upload Date |
      | oldDocFile.doc | Attachment doc file | TODAY+      |
    And Workflow History Activity Attachment buttons are available for all files
      | Download |
    And Workflow History Activity Attachment buttons are not available for all files
      | Delete |
    When User sets up role "AUTO TEST ROLE WITH ADD AND DELETE FILES PERMISSION" for user with firstname "User_Change_Role_AT_FN" via API
    And User refreshes page
    Then Workflow History Activity Attachment Upload field and Browse button are displayed
    And Workflow History Activity Attachment Description field is displayed
    And Workflow History Activity Attachment buttons are displayed
      | CANCEL |
      | UPLOAD |
    And Workflow History Activity Attachment buttons are available for all files
      | Delete |
    And Workflow History Activity Attachment buttons are not available for all files
      | Download |
    When User sets up role "AUTO TEST ROLE WITH ADD FILES PERMISSION" for user with firstname "User_Change_Role_AT_FN" via API
    And User refreshes page
    Then Workflow History Activity Attachment Upload field and Browse button are displayed
    And Workflow History Activity Attachment Description field is displayed
    And Workflow History Activity Attachment buttons are displayed
      | CANCEL |
      | UPLOAD |
    And Workflow History Activity Attachment buttons are not available for all files
      | Delete   |
      | Download |
    When User sets up role "AUTO TEST ROLE WITH DOWNLOAD FILES PERMISSION" for user with firstname "User_Change_Role_AT_FN" via API
    And User refreshes page
    Then Workflow History Activity Attachment Upload field and Browse button are not displayed
    And Workflow History Activity Attachment Description field is not displayed
    And Workflow History Activity Attachment buttons are not displayed
      | CANCEL |
      | UPLOAD |
    And Workflow History Activity Attachment buttons are available for all files
      | Download |
    And Workflow History Activity Attachment buttons are not available for all files
      | Delete |
    When User sets up role "AUTO TEST ROLE WITH DELETE FILES AND EDIT COMMENT PERMISSION" for user with firstname "User_Change_Role_AT_FN" via API
    And User refreshes page
    Then Workflow History Activity Attachment Upload field and Browse button are not displayed
    And Workflow History Activity Attachment Description field is not displayed
    And Workflow History Activity Attachment buttons are not displayed
      | CANCEL |
      | UPLOAD |
    And Workflow History Activity Attachment buttons are available for all files
      | Delete |
    And Workflow History Activity Attachment buttons are not available for all files
      | Download |

  @C39511043
  @core_regression
  Scenario: C39511043: [React Migration] Risk Management - Workflow History: Activity Attachment Roles Permissions - System Administrator
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name           | Automation Workflow Questionnaire             |
      | Status                  | Onboarding                                    |
      | Workflow Type           | Onboarding                                    |
      | Description             | Automation Workflow Questionnaire Description |
      | Initiated By            | Admin_AT_FN Admin_AT_LN                       |
      | Overall Risk Score      | 2.4                                           |
      | Onboarding Start Date   | TODAY+0                                       |
      | Onboarded Decision Date |                                               |
    And Workflow History activity groups titles should be displayed
      | GROUP # | ACTIVITY NAME |
    And Workflow History activity groups values should be displayed
      | 0 | Assign Questionnaire |
    And Workflow History Activity Attachment Upload field and Browse button are displayed
    And Workflow History Activity Attachment Description field is displayed
    And Workflow History Activity Attachment buttons are displayed
      | CANCEL |
      | UPLOAD |
    When User adds Workflow History attachments
      | oldDocFile.doc | Attachment doc file |
    Then Workflow History Activity Attachment table is displayed with details
      | File Name      | Description         | Upload Date |
      | oldDocFile.doc | Attachment doc file | TODAY+      |
    And Workflow History Activity Attachment buttons are available for all files
      | Download |
      | Delete   |

  @C39511044
  @core_regression
  @onlySingleThread
  Scenario: C39511044: [React Migration] Risk Management - Workflow History: Activity Comment Roles Permissions
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User sets up role "AUTO TEST ROLE WITH DELETE FILES AND EDIT COMMENT PERMISSION" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name           | Automation Workflow Questionnaire             |
      | Status                  | Onboarding                                    |
      | Workflow Type           | Onboarding                                    |
      | Description             | Automation Workflow Questionnaire Description |
      | Initiated By            | Admin_AT_FN Admin_AT_LN                       |
      | Overall Risk Score      | 2.4                                           |
      | Onboarding Start Date   | TODAY+0                                       |
      | Onboarded Decision Date |                                               |
    And Workflow History activity groups titles should be displayed
      | GROUP # | ACTIVITY NAME |
    And Workflow History activity groups values should be displayed
      | 0 | Assign Questionnaire |
    And Workflow History Activity Comment field is displayed
    And Workflow History Activity Comment buttons are displayed
      | Cancel  |
      | Comment |
    When User fills in comment field "Auto Activity Comment test" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    Then Workflow History Activity "Auto Activity Comment test" Comment action "Edit" is displayed
    And Workflow History Activity "Auto Activity Comment test" Comment action "Delete" is displayed
    When User sets up role "AUTO TEST ROLE WITH DOWNLOAD FILES PERMISSION" for user with firstname "User_Change_Role_AT_FN" via API
    And User refreshes page
    Then Workflow History Activity Comment field is not displayed
    And Workflow History Activity Comment buttons are not displayed
      | Cancel  |
      | Comment |

  @C39525742
  Scenario: C39525742: [Browser Back Button] Risk Management tab - Workflow History page
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    Then Risk Management Workflow History Activity has correct URL
    When User clicks back browser button
    Then Risk Management page is displayed

  @C39527989
  Scenario: C39527989: [Browser Back Button] Risk Management tab - Workflow History page - From homepage
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User navigates to Home page
    And User navigates to last created Workflow History
    Then Workflow History headers values should be displayed
      | Workflow Name           | Automation Workflow Questionnaire             |
      | Status                  | Onboarding                                    |
      | Workflow Type           | Onboarding                                    |
      | Description             | Automation Workflow Questionnaire Description |
      | Initiated By            | Admin_AT_FN Admin_AT_LN                       |
      | Overall Risk Score      | 2.4                                           |
      | Onboarding Start Date   | TODAY+0                                       |
      | Onboarded Decision Date |                                               |
    When User clicks back browser button
    Then Home page is loaded

  @C42897110
  @core_regression
  @onlySingleThread
  Scenario: C42897110: [Enhancement] Workflow Attachment - Workflow status: Onboarding
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                | STATUS     | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Automation Workflow | Onboarding | 3.2                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Automation Workflow" and status "Onboarding" on Risk Management tab
    Then Workflow History Activity Attachment Upload field and Browse button are displayed
    And Workflow History Activity Attachment Description field is displayed
    And Workflow History Activity Attachment buttons are displayed
      | CANCEL |
      | UPLOAD |
    And Workflow History Activity Attachment UPLOAD button is disabled
    When User adds Workflow History attachments
      | oldDocFile.doc | Attachment doc file |
      | PPTfile.ppt    | Attachment ppt file |
    Then Workflow History Activity Attachment table is displayed with details
      | File Name      | Description         | Upload Date |
      | oldDocFile.doc | Attachment doc file | TODAY+      |
      | PPTfile.ppt    | Attachment ppt file | TODAY+      |
    And Workflow History Activity Attachment buttons are available for all files
      | Download |
      | Delete   |
    When User clicks on Workflow History Attachment "oldDocFile.doc" download button
    Then File is successfully downloaded
    When User clicks delete button for Workflow History attachment with name "oldDocFile.doc"
    Then Message is displayed on confirmation window
      | DELETE ATTACHMENT                                                              |
      | Are you sure you want to delete this Attachment? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Attachment has been deleted. |
    And Confirmation window is disappeared
    And Workflow History Activity Attachment table is not displayed with details
      | File Name      | Description         | Upload Date |
      | oldDocFile.doc | Attachment doc file | TODAY+      |

  @C42897151
  @core_regression
  @onlySingleThread
  Scenario: C42897151: [Enhancement] Workflow Attachment - Workflow status: Onboarded
    Given User logs into RDDC as "Admin"
    When User creates third-party "with renewal workflow Norway" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Custom Component" tab
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                                               | STATUS    | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Auto Workflow Renewal Workflow Low Risk Onboarding | Onboarded | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Auto Workflow Renewal Workflow Low Risk Onboarding" and status "Onboarded" on Risk Management tab
    Then Workflow History Activity Attachment Upload field and Browse button are displayed
    And Workflow History Activity Attachment Description field is displayed
    And Workflow History Activity Attachment buttons are displayed
      | CANCEL |
      | UPLOAD |
    And Workflow History Activity Attachment UPLOAD button is disabled
    When User adds Workflow History attachments
      | xlsxFile.xlsx | Attachment xlsx file |
      | logo.jpg      | Attachment jpg file  |
    Then Workflow History Activity Attachment table is displayed with details
      | File Name     | Description          | Upload Date |
      | xlsxFile.xlsx | Attachment xlsx file | TODAY+      |
      | logo.jpg      | Attachment jpg file  | TODAY+      |
    And Workflow History Activity Attachment buttons are available for all files
      | Download |
      | Delete   |
    When User clicks on Workflow History Attachment "xlsxFile.xlsx" download button
    Then File is successfully downloaded
    When User clicks delete button for Workflow History attachment with name "xlsxFile.xlsx"
    Then Message is displayed on confirmation window
      | DELETE ATTACHMENT                                                              |
      | Are you sure you want to delete this Attachment? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Attachment has been deleted. |
    And Confirmation window is disappeared
    And Workflow History Activity Attachment table is not displayed with details
      | File Name     | Description          | Upload Date |
      | xlsxFile.xlsx | Attachment xlsx file | TODAY+      |

  @C42899216
  @core_regression
  @onlySingleThread
  Scenario: C42899216: [Enhancement] Workflow Attachment - Workflow status: Declined onboarding
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Decline Onboarding" third-party button
    And User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "ONBOARDING DENIED"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                              | STATUS              | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Automation Workflow Questionnaire | Declined Onboarding | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Automation Workflow Questionnaire" and status "Declined Onboarding" on Risk Management tab
    Then Workflow History Activity Attachment Upload field and Browse button are displayed
    And Workflow History Activity Attachment Description field is displayed
    And Workflow History Activity Attachment buttons are displayed
      | CANCEL |
      | UPLOAD |
    And Workflow History Activity Attachment UPLOAD button is disabled
    When User adds Workflow History attachments
      | meme-cat.gif     | Attachment gif file |
      | testPDFimage.pdf | Attachment pdf file |
    Then Workflow History Activity Attachment table is displayed with details
      | File Name        | Description         | Upload Date |
      | meme-cat.gif     | Attachment gif file | TODAY+      |
      | testPDFimage.pdf | Attachment pdf file | TODAY+      |
    And Workflow History Activity Attachment buttons are available for all files
      | Download |
      | Delete   |
    When User clicks on Workflow History Attachment "meme-cat.gif" download button
    Then File is successfully downloaded
    When User clicks delete button for Workflow History attachment with name "meme-cat.gif"
    Then Message is displayed on confirmation window
      | DELETE ATTACHMENT                                                              |
      | Are you sure you want to delete this Attachment? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Attachment has been deleted. |
    And Confirmation window is disappeared
    And Workflow History Activity Attachment table is not displayed with details
      | File Name    | Description         | Upload Date |
      | meme-cat.gif | Attachment txt file | TODAY+      |

  @C42899217
  @core_regression
  @onlySingleThread
  Scenario: C42899217: [Enhancement] Workflow Attachment - Workflow status: Stopped Onboarding
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Stop Onboarding" third-party button
    Then Message is displayed on confirmation window
      | Are you sure you want to stop the Onboarding Process? This cannot be undone and you will have to restart the Onboarding Process again. |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "NEW"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                              | STATUS             | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Automation Workflow Questionnaire | Stopped Onboarding | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Automation Workflow Questionnaire" and status "Stopped Onboarding" on Risk Management tab
    Then Workflow History Activity Attachment Upload field and Browse button are displayed
    And Workflow History Activity Attachment Description field is displayed
    And Workflow History Activity Attachment buttons are displayed
      | CANCEL |
      | UPLOAD |
    And Workflow History Activity Attachment UPLOAD button is disabled
    When User adds Workflow History attachments
      | simple text.txt  | Attachment txt file |
      | testPDFimage.pdf | Attachment pdf file |
    Then Workflow History Activity Attachment table is displayed with details
      | File Name        | Description         | Upload Date |
      | simple text.txt  | Attachment txt file | TODAY+      |
      | testPDFimage.pdf | Attachment pdf file | TODAY+      |
    And Workflow History Activity Attachment buttons are available for all files
      | Download |
      | Delete   |
    When User clicks on Workflow History Attachment "simple text.txt" download button
    Then File is successfully downloaded
    When User clicks delete button for Workflow History attachment with name "simple text.txt"
    Then Message is displayed on confirmation window
      | DELETE ATTACHMENT                                                              |
      | Are you sure you want to delete this Attachment? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Attachment has been deleted. |
    And Confirmation window is disappeared
    And Workflow History Activity Attachment table is not displayed with details
      | File Name       | Description         | Upload Date |
      | simple text.txt | Attachment txt file | TODAY+      |

  @C42899218
  @core_regression
  Scenario: C42899218: [Enhancement] Workflow Attachment - Workflow status: Stopped Renewal
    Given User logs into RDDC as "Admin"
    When User creates third-party "with renewal workflow Norway" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Custom Component" tab
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    When User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And User refreshes page
    Then Third-party's element "Renew" should be shown
    When User clicks "Renew" for third-party
    And User clicks "Stop Renewal" for third-party
    Then Message is displayed on confirmation window
      | Are you sure you want to stop the Renewal Process?                           |
      | This cannot be undone and you will have to restart the Renewal Process again |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "FOR RENEWAL"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                                    | STATUS          | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Auto Workflow Renewal Workflow Low Risk | Stopped Renewal | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Auto Workflow Renewal Workflow Low Risk" and status "Stopped Renewal" on Risk Management tab
    Then Workflow History Activity Attachment Upload field and Browse button are displayed
    And Workflow History Activity Attachment Description field is displayed
    And Workflow History Activity Attachment buttons are displayed
      | CANCEL |
      | UPLOAD |
    And Workflow History Activity Attachment UPLOAD button is disabled
    When User adds Workflow History attachments
      | PPSfile.pps | Attachment pps file |
    Then Workflow History Activity Attachment table is displayed with details
      | File Name   | Description         | Upload Date |
      | PPSfile.pps | Attachment pps file | TODAY+      |
    When User adds Workflow History attachments
      | dotFile.dot | Attachment dot file |
    Then Workflow History Activity Attachment table is displayed with details
      | File Name   | Description         | Upload Date |
      | dotFile.dot | Attachment dot file | TODAY+      |
    And Workflow History Activity Attachment buttons are available for all files
      | Download |
      | Delete   |
    When User clicks on Workflow History Attachment "PPSfile.pps" download button
    Then File is successfully downloaded
    When User clicks delete button for Workflow History attachment with name "PPSfile.pps"
    Then Message is displayed on confirmation window
      | DELETE ATTACHMENT                                                              |
      | Are you sure you want to delete this Attachment? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    And User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Attachment has been deleted. |
    And Confirmation window is disappeared
    And Workflow History Activity Attachment table is not displayed with details
      | File Name   | Description         | Upload Date |
      | PPSfile.pps | Attachment pps file | TODAY+      |

  @C42899219
  @core_regression
  Scenario: C42899219: [Enhancement] Workflow Attachment - Workflow status: Renewal Denied
    Given User logs into RDDC as "Admin"
    When User creates third-party "with renewal workflow Norway" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Custom Component" tab
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    When User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    And User refreshes page
    Then Third-party's element "Renew" should be shown
    When User clicks "Renew" for third-party
    And User clicks "Decline Renewal" for third-party
    Then Message is displayed on confirmation window
      | Are you sure you want to decline the Renewal Process?                           |
      | This cannot be undone and you will have to restart the Onboarding Process again |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "RENEWAL DENIED"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                                    | STATUS         | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Auto Workflow Renewal Workflow Low Risk | Renewal Denied | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Auto Workflow Renewal Workflow Low Risk" and status "Renewal Denied" on Risk Management tab
    Then Workflow History Activity Attachment Upload field and Browse button are displayed
    And Workflow History Activity Attachment Description field is displayed
    And Workflow History Activity Attachment buttons are displayed
      | CANCEL |
      | UPLOAD |
    And Workflow History Activity Attachment UPLOAD button is disabled
    When User adds Workflow History attachments
      | dotFile.dot | Attachment dot file |
      | odtFile.odt | Attachment odt file |
    Then Workflow History Activity Attachment table is displayed with details
      | File Name   | Description         | Upload Date |
      | dotFile.dot | Attachment dot file | TODAY+      |
      | odtFile.odt | Attachment odt file | TODAY+      |
    And Workflow History Activity Attachment buttons are available for all files
      | Download |
      | Delete   |
    When User clicks on Workflow History Attachment "dotFile.dot" download button
    Then File is successfully downloaded
    When User clicks delete button for Workflow History attachment with name "dotFile.dot"
    Then Message is displayed on confirmation window
      | DELETE ATTACHMENT                                                              |
      | Are you sure you want to delete this Attachment? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Attachment has been deleted. |
    And Confirmation window is disappeared
    And Workflow History Activity Attachment table is not displayed with details
      | File Name   | Description         | Upload Date |
      | dotFile.dot | Attachment dot file | TODAY+      |

  @C42899220
  @core_regression
  Scenario: C42899220: [Enhancement] Workflow Attachment - Workflow status: Renewing
    Given User logs into RDDC as "Admin"
    When User creates third-party "with renewal workflow Norway" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Custom Component" tab
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    When User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And User refreshes page
    Then Third-party's element "Renew" should be shown
    When User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                                    | STATUS   | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Auto Workflow Renewal Workflow Low Risk | Renewing | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Auto Workflow Renewal Workflow Low Risk" and status "Renewing" on Risk Management tab
    Then Workflow History Activity Attachment Upload field and Browse button are displayed
    And Workflow History Activity Attachment Description field is displayed
    And Workflow History Activity Attachment buttons are displayed
      | CANCEL |
      | UPLOAD |
    And Workflow History Activity Attachment UPLOAD button is disabled
    When User adds Workflow History attachments
      | rarFile.rar | Attachment rar file |
      | 7zFile.7z   | Attachment 7z file  |
    Then Alert Icon is displayed with text
      | Success! Attachment has been saved. |
    And Workflow History Activity Attachment table is displayed with details
      | File Name   | Description         | Upload Date |
      | rarFile.rar | Attachment rar file | TODAY+      |
      | 7zFile.7z   | Attachment 7z file  | TODAY+      |
    And Workflow History Activity Attachment buttons are available for all files
      | Download |
      | Delete   |
    When User clicks on Workflow History Attachment "rarFile.rar" download button
    Then File is successfully downloaded
    When User clicks delete button for Workflow History attachment with name "rarFile.rar"
    Then Message is displayed on confirmation window
      | DELETE ATTACHMENT                                                              |
      | Are you sure you want to delete this Attachment? This change cannot be undone. |
    And Confirmation button Delete should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Delete button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Attachment has been deleted. |
    And Confirmation window is disappeared
    And Workflow History Activity Attachment table is not displayed with details
      | File Name   | Description         | Upload Date |
      | rarFile.rar | Attachment rar file | TODAY+      |
