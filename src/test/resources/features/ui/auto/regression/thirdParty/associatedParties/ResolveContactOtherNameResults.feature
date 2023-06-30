@ui @full_regression @react @wc1 @other_names
Feature: Contact Other Names - Resolve/Unresolved Screening Results

  As a SI user,
  I want an ability to change the resolution type.
  So that I can manage the results.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"

  @C33661628
  Scenario: C33661628: SI-WC1-Contact- Other Names - Change POSITIVE Other name record's resolution
    When User creates Associated Party "John SMITH"
    And User creates Other name "James" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    When User clicks resolve Other Name screening record for 'contact' under number 3 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Low" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks resolve Other Name screening record for 'contact' under number 2 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks resolve Other Name screening record for 'contact' under number 1 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 2 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 3 appears in the main screening table with "POSITIVE" resolution
    When User clicks resolve Other Name screening record under number 1 on main screening list as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Screening record under number 1 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 2 on main screening list as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Screening record under number 2 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 3 on main screening list as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Screening record under number 3 appears in the main screening table with "POSSIBLE" resolution
    When User opens screening results for "James" Other name
    And User clicks Other Name screening results 'last page' button
    Then Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    When User clicks Other Name screening results 'first page' button
    Then Other name screening record under number 3 does not appear in the other name screening table
    When User clicks on 4 number Other name screening record
    And Other name screening result profile details is displayed
    And User clicks resolve screening profile under number 4 record as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    When User clicks on 5 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 5 record as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    When User clicks on 6 number Other name screening record
    And Other name screening result profile details is displayed
    And User clicks resolve screening profile under number 6 record as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    Then Screening record under number 4 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 5 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 6 appears in the main screening table with "POSITIVE" resolution
    When User clicks resolve Other Name screening record under number 4 on main screening list as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Screening record under number 4 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 5 on main screening list as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And Screening record under number 5 does not appear in the main screening table
    And User clicks resolve Other Name screening record under number 6 on main screening list as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Screening record under number 6 appears in the main screening table with "POSSIBLE" resolution
    When User opens screening results for "James" Other name
    And User clicks Other Name screening results 'last page' button
    Then Other name screening record under number 4 appears in the other name screening table with "FALSE" resolution
    And Other name screening record under number 5 appears in the other name screening table with 'UNSPECIFIED' resolution
    And Other name screening record under number 6 does not appear in the other name screening table

  @C33661631
  Scenario: C33661631: SI-WC1-Contact- Other Names - Change POSSIBLE Other name record's resolution
    When User creates Associated Party "John SMITH"
    And User creates Other name "James" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    When User clicks resolve Other Name screening record for 'contact' under number 3 as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks resolve Other Name screening record for 'contact' under number 2 as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks resolve Other Name screening record for 'contact' under number 1 as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 2 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 3 appears in the main screening table with "POSSIBLE" resolution
    When User clicks resolve Other Name screening record under number 1 on main screening list as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Screening record under number 1 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 2 on main screening list as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Screening record under number 2 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 3 on main screening list as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Screening record under number 3 appears in the main screening table with "POSITIVE" resolution
    When User opens screening results for "James" Other name
    And User clicks Other Name screening results 'last page' button
    Then Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    And Other name screening record under number 2 appears in the other name screening table with 'UNSPECIFIED' resolution
    When User clicks Other Name screening results 'first page' button
    Then Other name screening record under number 3 does not appear in the other name screening table
    When User clicks on 4 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 4 record as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    When User clicks on 5 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 5 record as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    When User clicks on 6 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 6 record as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    Then Screening record under number 4 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 5 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 6 appears in the main screening table with "POSSIBLE" resolution
    When User clicks resolve Other Name screening record under number 4 on main screening list as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Screening record under number 4 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 5 on main screening list as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Screening record under number 5 does not appear in the main screening table
    When User clicks resolve Other Name screening record under number 6 on main screening list as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Screening record under number 6 appears in the main screening table with "POSITIVE" resolution
    When User opens screening results for "James" Other name
    And User clicks Other Name screening results 'last page' button
    Then Other name screening record under number 4 appears in the other name screening table with "FALSE" resolution
    And Other name screening record under number 5 appears in the other name screening table with 'UNSPECIFIED' resolution
    When User clicks Other Name screening results 'first page' button
    Then Other name screening record under number 6 does not appear in the other name screening table

  @C33715325
  Scenario: C33715325: SI-WC1-Contact- Other Names - Change FALSE Other name record's resolution
    When User creates Associated Party "John SMITH"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks resolve Other Name screening record for 'contact' under number 1 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks resolve Other Name screening record for 'contact' under number 2 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks resolve Other Name screening record for 'contact' under number 3 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks Close Other Name Results button
    Then Screening record under number 1 does not appear in the main screening table
    And Screening record under number 2 does not appear in the main screening table
    And Screening record under number 3 does not appear in the main screening table
    When User opens screening results for "John" Other name
    And User clicks Other Name screening results 'last page' button
    And User clicks resolve Other Name screening record for 'contact' under number 3 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "Unknown" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks resolve Other Name screening record for 'contact' under number 2 as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks resolve Other Name screening record for 'contact' under number 1 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Other name screening record under number 3 appears in the other name screening table with 'UNRESOLVED' resolution
    And Other name screening record under number 2 does not appear in the other name screening table
    And Other name screening record under number 1 does not appear in the other name screening table
    When User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 2 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 3 does not appear in the main screening table

  @C33715316
  Scenario: C33715316: SI-WC1-Contact- Other Names - Moved POSITIVE records to the main screening page
    When User creates Associated Party "John SMITH"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks resolve Other Name screening record for 'contact' under number 2 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Other name screening record under number 2 does not appear in the other name screening table
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    Then Screening record under number 2 appears in the main screening table with "POSITIVE" resolution
    And Sorted search "World-Check" results for "contact" appear in main screening table for current page with "John" other name positive or possible resolved results

  @C33715322
  Scenario: C33715322: SI-WC1-Contact- Other Names - Move POSITIVE records to the main screening page-Contact WITHOUT screening
    When User creates Associated Party "with not matched results"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks resolve Other Name screening record for 'contact' under number 7 as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Other name screening record under number 7 does not appear in the other name screening table
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    Then Screening record under number 7 appears in the main screening table with "POSITIVE" resolution
    And Sorted search "World-Check" results for "contact" appear in main screening table for current page with "John" other name positive or possible resolved results

  @C33715318
  Scenario: C33715318: SI-WC1-Contact- Other Names - Move POSSIBLE records to the main screening page
    When User creates Associated Party "John SMITH"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks resolve Other Name screening record for 'contact' under number 3 as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Other name screening record under number 3 does not appear in the other name screening table
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    Then Screening record under number 3 appears in the main screening table with "POSSIBLE" resolution
    And Sorted search "World-Check" results for "contact" appear in main screening table for current page with "John" other name positive or possible resolved results

  @C33715317
  Scenario: C33715317: SI-WC1-Contact- Other Names - Move POSITIVE records to the main screening page from DETAILS page
    When User creates Associated Party "John SMITH"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks on 4 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 4 record as "POSITIVE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    And Other name screening record under number 4 does not appear in the other name screening table
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    Then Screening record under number 4 appears in the main screening table with "POSITIVE" resolution
    And Sorted search "World-Check" results for "contact" appear in main screening table for current page with "John" other name positive or possible resolved results

  @C33715319
  Scenario: C33715319: SI-WC1-Contact- Other Names - Move POSSIBLE records to the main screening page from DETAILS page
    When User creates Associated Party "John SMITH"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 1 record as "POSSIBLE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    And Other name screening record under number 1 does not appear in the other name screening table
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    And Sorted search "World-Check" results for "contact" appear in main screening table for current page with "John" other name positive or possible resolved results

  @C33715320
  Scenario: C33715320: SI-WC1-Contact- Other Names - Do not move FALSE records to the main screening page
    When User creates Associated Party "John SMITH"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks resolve Other Name screening record for 'contact' under number 3 as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    When User clicks Other Name screening results 'last page' button
    Then Other name screening record under number 3 appears in the other name screening table with "FALSE" resolution
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    Then Screening record under number 3 does not appear in the main screening table
    And Sorted search "World-Check" results for "contact" appear in main screening table for current page with "John" other name positive or possible resolved results

  @C33715321
  Scenario: C33715321: SI-WC1-Contact- Other Names - Do not move FALSE records to the main screening page from DETAILS page
    When User creates Associated Party "John SMITH"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 1 record as "FALSE"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    And User clicks on the "Back To Screening Results Button" screening profile
    Then Other Name dialog is loaded
    When User clicks Other Name screening results 'last page' button
    And Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    Then Screening record under number 1 does not appear in the main screening table
    And Sorted search "World-Check" results for "contact" appear in main screening table for current page with "John" other name positive or possible resolved results

  @C33707075
  Scenario: C33707075: SI-WC1-Contact- Other Names - Move batch of POSITIVE records to the main screening page
    When User creates Associated Party "John SMITH"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User selects all Other name screening records for "contact" and resolve as "Positive"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    Then Sorted search "World-Check" results for "contact" appear in main screening table for current page with "John" other name positive or possible resolved results

  @C33707076
  Scenario: C33707076: SI-WC1-Contact- Other Names - Move batch of POSSIBLE records to the main screening page
    When User creates Associated Party "John SMITH"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User selects all Other name screening records for "contact" and resolve as "Possible"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And Sorted search "World-Check" results for "contact" appear in main screening table for current page with "John" other name positive or possible resolved results

  @C33707077
  Scenario: C33707077: SI-WC1-Contact- Other Names - Do not move batch of FALSE records to the main screening page
    When User creates Associated Party "John SMITH"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User selects all Other name screening records for "contact" and resolve as "False"
    Then Add Comment modal is displayed
    When User fills in comment "Comment text"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And Sorted search "World-Check" results for "contact" appear in main screening table for current page with "John" other name positive or possible resolved results

  @C33707078
  Scenario: C33707078: SI-WC1-Contact- Other Names - Do not move batch of UNRESOLVED records to the main screening page
    When User creates Associated Party "John SMITH"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User selects all Other name screening records for "contact" and resolve as "Unresolved"
    And User clicks "Save" Add Comment modal button
    And User waits for progress bar to disappear from page
    Then Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And Sorted search "World-Check" results for "contact" appear in main screening table for current page with "John" other name positive or possible resolved results

  @C33707079
  Scenario: C33707079: SI-WC1-Contact- Other Names - CANCEL batch movement to the main screening page
    When User creates Associated Party "John SMITH"
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    And Screening Table for Other name displays up to 10 items per page
    And Sorted search "World-Check" results for "John" "contact" appear in other names screening table for current page
    When User clicks on "Select All" Other name screening element
    Then All Other name screening records on current page are selected
    When User clicks on "Resolve As" Other name screening element
    And User clicks on "Cancel" Other name screening element
    Then All Other name screening records on current page are not selected
