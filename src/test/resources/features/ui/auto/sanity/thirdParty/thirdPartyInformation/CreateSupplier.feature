@ui @sanity @suppliers @multilanguage
Feature: Create New Third-party

  As an admin user,
  I want a feature that will let me create and save third-party information,
  so that I can retrieve and use its profile for later process inside workflow.

  Background:
    Given User logs into RDDC as "Admin"
    When User sets up language via API

  @C32988219
  @RMS-28297
  Scenario: C32988219: Third-party Overview - Add Third-party with Complete Details
    When User navigates to Third-party page
    And User clicks Add Third-party button
    Then Add Third-party Search criteria sections Search Term is displayed
    And Add Third-party Search criteria Country field is displayed with Same as address country checkbox checked
    And Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    And Add Third-party Search criteria Ongoing Screening World-check checkbox is unchecked
    And Add Third-party Search criteria Notification Recipients field displayed with "Admin_AT_FN Admin_AT_LN"
    And Add Third-party Search criteria Notification Recipients User checkbox is checked
    #   TODO update method implementation when RMS-28297 will be fixed
    When User fills third-party creation form with third-party's test data "with Complete Details"
    And User submits Third-party creation form
    Then User verifies third-party is created
    And "Informational" 'i' icon button is displayed beside add "Address" section
    And User clicks 'i' icon button
    And Address Country alert toast message is displayed
    And Third-party Information details are displayed with populated data

  @C32988221
  Scenario: C32988221: Third-party Information - Verify Country Checklist Alert
    When User creates Country Checklist "Test Automation Country Checklist" via API
    And User creates third-party "with country in Country Checklist"
    Then "Informational" 'i' icon button is displayed beside add "Address" section
    When User clicks 'i' icon button
    Then Address Country alert toast message is displayed
    And Address Country alert toast message is not displayed

  @C32988223
  Scenario: C32988223: Third-party Information - Verify WC Screening Results
    When User creates third-party "with attached file"
    Then Screening results table is loaded
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And Screening section Change Search Criteria button is displayed
    And Screening section Export to Excel button is displayed
    And Screening section Bell icon is displayed
    And Screening section Ongoing Screening slider is displayed
    And Screening section table displays expected columns
      | thirdPartyInformation.screening.columnName                  |
      | thirdPartyInformation.screening.columnCountryOfRegistration |
      | thirdPartyInformation.screening.columnType                  |
      | thirdPartyInformation.screening.columnMatchStrength         |
      | thirdPartyInformation.screening.columnDataProvider          |
      | thirdPartyInformation.screening.columnReferenceId           |
      | thirdPartyInformation.screening.columnResolution            |
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    Then Add Comment modal is displayed

  @C32988224
  Scenario: C32988224: Third-party Information - Add Related Files
    When User creates third-party "with random ID name"
    And User adds Third-party attachment
      | File Name           | Description             |
      | logo.jpg            | Test File Description   |
      | logo.jpeg           | Test File Description1  |
      | test.png            | Test File Description2  |
      | meme-cat.gif        | Test File Description3  |
      | csvFile.csv         | Test File Description4  |
      | testPDFimage.pdf    | Test File Description5  |
      | oldDocFile.doc      | Test File Description6  |
      | newDocFile.docx     | Test File Description7  |
      | dotxFile.dotx       | Test File Description8  |
      | PPTfile.ppt         | Test File Description9  |
      | PPTxfile.pptx       | Test File Description10 |
      | PPSfile.pps         | Test File Description11 |
      | PPSXfile.ppsx       | Test File Description12 |
      | sample-msg-file.msg | Test File Description13 |
      | odtFile.odt         | Test File Description14 |
      | xlsFile.xls         | Test File Description15 |
      | xlsxFile.xlsx       | Test File Description16 |
      | xlsmFile.xlsm       | Test File Description17 |
      | zipFile.zip         | Test File Description18 |
    Then Related Files table displays file details
      | File Name           | Description             | Upload Date |
      | logo.jpg            | Test File Description   | MM/dd/YYYY  |
      | logo.jpeg           | Test File Description1  | MM/dd/YYYY  |
      | test.png            | Test File Description2  | MM/dd/YYYY  |
      | meme-cat.gif        | Test File Description3  | MM/dd/YYYY  |
      | csvFile.csv         | Test File Description4  | MM/dd/YYYY  |
      | testPDFimage.pdf    | Test File Description5  | MM/dd/YYYY  |
      | oldDocFile.doc      | Test File Description6  | MM/dd/YYYY  |
      | newDocFile.docx     | Test File Description7  | MM/dd/YYYY  |
      | dotxFile.dotx       | Test File Description8  | MM/dd/YYYY  |
      | PPTfile.ppt         | Test File Description9  | MM/dd/YYYY  |
      | PPTxfile.pptx       | Test File Description10 | MM/dd/YYYY  |
      | PPSfile.pps         | Test File Description11 | MM/dd/YYYY  |
      | PPSXfile.ppsx       | Test File Description12 | MM/dd/YYYY  |
      | sample-msg-file.msg | Test File Description13 | MM/dd/YYYY  |
      | odtFile.odt         | Test File Description14 | MM/dd/YYYY  |
      | xlsFile.xls         | Test File Description15 | MM/dd/YYYY  |
      | xlsxFile.xlsx       | Test File Description16 | MM/dd/YYYY  |
      | xlsmFile.xlsm       | Test File Description17 | MM/dd/YYYY  |
      | zipFile.zip         | Test File Description18 | MM/dd/YYYY  |
    And Related Files table displays column names
      | thirdPartyInformation.relatedFiles.fileName    |
      | thirdPartyInformation.relatedFiles.description |
      | thirdPartyInformation.relatedFiles.uploadDate  |
    And Download icon is displayed for file with name "logo.jpg"
    And Delete icon is displayed for file with name "logo.jpg"
    When User expands "Related Files" section
    Then "Browse" "button" in Related Files section is displayed
    And "Description" "input" in Related Files section is displayed
    And "Upload" "button" in Related Files section is displayed
    And "Cancel" "button" in Related Files section is displayed