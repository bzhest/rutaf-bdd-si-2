@ui @full_regression @core_regression @react @third_party_other_names
Feature: Third-party Other Names -Screening - World-Check tab - Select record

  As a user,
  I want to see screening details page.
  So that I can manage the screening records.

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    When User creates third-party "with questionnaire workflow" via API and open it
    Then "Other Names Section" for other name is displayed
    When User fills in Name field value "John"
    And User selects Name type "Doing Business As"

  @C39460250
  Scenario: C39460250: Third-party Other Names - Screening - World-Check tab - Select record - Verify WC record details page
    When User edits "Country of Registration" field with value "United Kingdom"
    And User clicks on "Other Names Add|Save button"
    And User opens screening results for "John" Other name
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "John" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening "supplier" profile header contains correspond data
    And Screening profiles Resolution Type contains correspond data
    And Other name screening result contains 'Refinitiv World-Check' logo
    And Resolution type contains following tooltip text when hover on it
      | Positive |
      | Possible |
      | False    |
    And Other Names Screening results tabs are present
      | Key data | Aliases | Further information | Keywords | Connections/Relationships | Sources |

  @C39460278
  Scenario: C39460278: Third-party Other Names - Screening - World-Check tab - Select record - Export to PDF
    When User clicks on "Other Names Add|Save button"
    And User opens screening results for "John" Other name
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "John" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks on the "Export To PDF" screening profile
    Then ".pdf" File with name "RDDCentre_<recordName1>_Profile_Page_" and date format "ddMMYYYY" downloaded
    And Other Names Screening profile details are present in PDF file "downloadedFileName"

  @C39462606
  Scenario: C39462606: Third-party Other Names - Screening - World-Check tab - Select record - Mark record as Positive
    When User clicks on "Other Names Add|Save button"
    And User opens screening results for "John" Other name
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "John" "supplier" appear in other names screening table for current page
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    When User clicks on 1 number screening record
    Then 'Tag as red flag' is turned on
    And Screening profiles Resolution Type contains correspond data
    And Risk Level value on Screening profile page is "MEDIUM"
    And Reason value on Screening profile page is "FULL MATCH"
    And Comment profile section contains expected text "Comment text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date

  @C39462679
  Scenario: C39462679: Third-party Other Names - Screening - World-Check tab - Select record - Remove Resolution Type
    When User clicks on "Other Names Add|Save button"
    And User opens screening results for "John" Other name
    Then Other Name dialog is loaded
    And Sorted search "World-Check" results for "John" "supplier" appear in other names screening table for current page
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks last page icon
    Then Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    When User clicks on 1 number Other name screening record
    And User selects "false" resolution in screening detail page
    Then Add Comment modal is displayed
    When User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                         |
      | Resolution type has been removed |
    And Screening profiles Resolution Type is "UNSPECIFIED"