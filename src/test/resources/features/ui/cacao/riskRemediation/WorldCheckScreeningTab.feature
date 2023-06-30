@ui @cacao @functional @risk_remediation @wc1
Feature:  Risk Management tab - Verify World-Check Screening Tab

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it

  @C41354067 @C43784481
  @RMS-32306
  Scenario: C41354067, C43784481: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data present + View Record Details page
#  Third-party
    When User changes Search Criteria "Search Term" with value "CLOUD TECHNOLOGY Solution"
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    And User clears Third-party screening record on position 1 context
    And User remembers Third-party Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
#  Third-party Other Names
    When User creates Other name "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH"
    And User opens screening results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" Other name
    And User clicks resolve Other Name screening record for "supplier" under number 1 as "POSITIVE"
    And User remembers Third-party Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
#  Third-party Associated Party Individual
    And User creates Associated Party "Individual" "Barac Obama" via API and open it
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 1 context
    And User remembers Third-party AP Individual Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
#  Third-party Associated Party Individual Other Names
    When User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 1 as "POSITIVE"
    And User remembers Third-party AP Individual Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
#   Third-party Associated Party Organization
    And User creates Associated Party "Organisation" "Dell" via API and open it
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 1 context
    And User remembers Third-party AP Organisation Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
#   Third-party Associated Party Organization Other Names
    When User creates Other name "Apple" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 1 as "POSITIVE"
    And User remembers Third-party AP Organisation Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    Then Risk Remediation World Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | REFERENCE ID           |
      | RED FLAG DATE          |
    And World-Check Risk Remediation table is displayed with next details
      | SOURCE                              | SEARCH TERM                                       | TAG AS RED FLAG RECORD                            | REFERENCE ID                                      | RED FLAG DATE |
      | Third-Party                         | CLOUD TECHNOLOGY Solution                         | Third-party Reference                             | Third-party Reference                             | TODAY+        |
      | Third-party Other Names             | CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH | Third-party Other Names Reference                 | Third-party Other Names Reference                 | TODAY+        |
      | Associated Individual               | Barac Obama                                       | Third-party AP Individual Reference               | Third-party AP Individual Reference               | TODAY+        |
      | Associated Individual Other Names   | Barac Obama                                       | Third-party AP Individual Other Names Reference   | Third-party AP Individual Other Names Reference   | TODAY+        |
            #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation             | Dell                                              | Third-party AP Organisation Reference             | Third-party AP Organisation Reference             | TODAY+        |
      | Associated Organization             | Dell                                              | Third-party AP Organisation Reference             | Third-party AP Organisation Reference             | TODAY+        |
            #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation Other Names | Apple inc.                                        | Third-party AP Organisation Other Names Reference | Third-party AP Organisation Other Names Reference | TODAY+        |
      | Associated Organization Other Names | Apple inc.                                        | Third-party AP Organisation Other Names Reference | Third-party AP Organisation Other Names Reference | TODAY+        |
    When User clicks Risk Remediation World-Check "Source" column
    Then World-Check Risk Remediation Source column is sorted in next order
      | Third-Party                         |
      | Associated Individual               |
            #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation             |
      | Associated Organization             |
      | Third-party Other Names             |
      | Associated Individual Other Names   |
            #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation Other Names |
      | Associated Organization Other Names |
    When User clicks Risk Remediation World-Check "Source" column
    Then World-Check Risk Remediation Source column is sorted in next order
          #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation Other Names |
      | Associated Organization Other Names |
      | Associated Individual Other Names   |
      | Third-party Other Names             |
            #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation             |
      | Associated Organization             |
      | Associated Individual               |
      | Third-Party                         |
    When User clicks Risk Remediation World-Check "Search Term" column
    Then World check Risk Remediation table is sorted by "Search Term" in "ASC" order
    When User clicks Risk Remediation World-Check "Search Term" column
    Then World check Risk Remediation table is sorted by "Search Term" in "DESC" order
    When User clicks Risk Remediation World-Check "Tag as Red Flag Record" column
    Then World check Risk Remediation table is sorted by "Tag as Red Flag Record" in "ASC" order
    When User clicks Risk Remediation World-Check "Tag as Red Flag Record" column
    Then World check Risk Remediation table is sorted by "Tag as Red Flag Record" in "DESC" order
    When User clicks Risk Remediation World-Check "Reference ID" column
    Then World check Risk Remediation table is sorted by "Reference ID" in "ASC" order
    When User clicks Risk Remediation World-Check "Reference ID" column
    Then World check Risk Remediation table is sorted by "Reference ID" in "DESC" order
    When User clicks Risk Remediation World-Check "Red Flag Date" column
    Then World check Risk Remediation table is sorted by "Red Flag Date" in "ASC" order
    When User clicks Risk Remediation World-Check "Red Flag Date" column
    Then World check Risk Remediation table is sorted by "Red Flag Date" in "DESC" order
    And Pagination option "10" is selected
    And Pagination buttons should be visible
      | first page | previous page | next page | last page |
    When User clicks Risk Remediation World-Check "Source" column
    And User clicks on World-Check Risk Remediation record "Third-party Reference"
    Then Third-party Information tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/profile/e_tr_wco_referenceId?resultId=rezultId" endpoint
    And Risk Remediation breadcrumb is displayed
    When User clicks Risk Remediation breadcrumb
    And User clicks on World-Check Risk Remediation record "Third-party Other Names Reference"
    Then Third-party Information tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/" endpoint
    And Risk Remediation breadcrumb is displayed
    When User clicks Risk Remediation breadcrumb
    And User clicks on World-Check Risk Remediation record "Third-party AP Individual Reference"
    Then Associated Parties tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And Risk Remediation breadcrumb is displayed
    When User clicks Risk Remediation breadcrumb
    And User clicks on World-Check Risk Remediation record "Third-party AP Organisation Reference"
    Then Associated Parties tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdOrganizational/profile/" endpoint
    And Risk Remediation breadcrumb is displayed
    When User clicks Risk Remediation breadcrumb
    And User clicks Risk Remediation World-Check "Source" column
    When User clicks Risk Remediation World-Check "Source" column
    And User clicks on World-Check Risk Remediation record "Third-party AP Individual Other Names Reference"
    Then Associated Parties tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And Risk Remediation breadcrumb is displayed
    When User clicks Risk Remediation breadcrumb
    And User clicks on World-Check Risk Remediation record "Third-party AP Organisation Other Names Reference"
    Then Associated Parties tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdOrganizational/profile/" endpoint
    And Risk Remediation breadcrumb is displayed
    When User clicks Risk Remediation breadcrumb
    Then Risk Remediation "Media Check Screening" tab is displayed
    When User clicks on World-Check Risk Remediation record "Third-party Reference"
    And User clicks "Risk Remediation" breadcrumb Back icon
    Then Risk Remediation "Media Check Screening" tab is displayed

  @C43999966
  Scenario: C43999966: [Risk Remediation] - Risk Management tab - Verify Risk Remediation Section - No Available Data
    When User clicks on Risk Management tab
    Then Risk Management sections are displayed
      | Workflow         |
      | Ad Hoc Activity  |
      | Risk Remediation |
    And Risk Management "Risk Remediation" section is expanded
    And Risk Management Risk Remediation section has tabs
      | WORLD-CHECK SCREENING |
      | MEDIA CHECK SCREENING |
      | QUESTIONNAIRE         |
      | CUSTOM FIELDS         |
    And Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44066073
  Scenario: C44066073: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data present - Different Search Criterias
#  Third-party
    When User changes Search Criteria "Search Term" with value "CLOUD TECHNOLOGY Solution"
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    And User clears Third-party screening record on position 1 context
    And User remembers Third-party Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User changes Search Criteria "Search Term" with value "Dell"
    And User clicks resolve "World-Check" screening record for "supplier" on position 2 on main screening list as "POSITIVE" resolution
    And User clears Third-party screening record on position 2 context
    And User remembers Third-party Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
#  Third-party Associated Party Individual
    When User creates Associated Party "Individual" "Barac Obama" via API and open it
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 1 context
    And User remembers Third-party AP Individual Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Associated Party's General Information section "Edit" button
    And User updates Associated Party's General Information section with values
      | First Name | Last Name |
      | Jane       | Miller    |
    And User clicks Associated Party's General Information section "Save" button
    Then Screening results table is loaded
    When User clicks resolve "World-Check" screening record for "supplier" on position 3 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 3 context
    And User remembers Third-party AP Individual Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
#   Third-party Associated Party Organization
    When User creates Associated Party "Organisation" "Dell" via API and open it
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 1 context
    And User remembers Third-party AP Organisation Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Associated Party's General Information section "Edit" button
    And User updates General Information section with values
      | Name  |
      | Apple |
    And User clicks Associated Party's General Information section "Save" button
    And User clicks Duplicate Check Confirm button
    Then Screening results table is loaded
    When User clicks Associated Party's Address section "Edit" button
    And User updates Associated Party's Address section on position 1 with values
      | Country   |
      | Australia |
    And User clicks Associated Party's Address section "Save" button
    And User clicks Duplicate Check Confirm button
    Then Screening results table is loaded
    When User clicks resolve "World-Check" screening record for "supplier" on position 2 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 2 context
    And User remembers Third-party AP Organisation Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    Then Risk Remediation World Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | REFERENCE ID           |
      | RED FLAG DATE          |

  @C48973239 @C41454646
  Scenario: C48973239, C41454646: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data absent - Different Search Criterias (Third Party)
    When User changes Search Criteria "Search Term" with value "CLOUD TECHNOLOGY Solution"
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "FALSE" resolution
    And User clears Third-party screening record on position 1 context
    And User remembers Third-party Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party comment"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks on 1 number screening record
    And User turns On 'Tag as red flag' on Screening Profile page
    Then Toast message "Success! Tag as red flag has been updated." is displayed
    When User clicks "Screening Results" breadcrumb Back icon
    And User clicks Change Search Criteria screening button
    And User changes Search Term to "Dell"
    And User clicks on Check Type "Media Check"
    And User clicks Search On Search criteria button
    And User clicks on "MEDIA CHECK" tab
    And User selects Third-party Media Check screening record on position 1
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Risk Management tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C48973239 @C41454646
  Scenario: C48973239, C41454646: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data absent - Different Search Criterias (Third-party Other Name)
    When User creates Other name "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH"
    And User opens screening results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" Other name
    And User clicks resolve Other Name screening record for "supplier" under number 1 as "FALSE"
    And User remembers Third-party Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" name
    And User fills in Name field value "Dell"
    And User selects Name type "Doing Business As"
    And User clicks on "Other Names Add|Save button"
    And User clicks on Screen Other Name Button for "Dell" name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Third-party Other Names screening record on position 2
    And User selects risk level as "MEDIUM"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks on Risk Management tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C48973239 @C41454646
  Scenario: C48973239, C41454646: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data absent - Different Search Criterias (Associated Party Individual)
    When User creates Associated Party "Individual" "Barac Obama" via API and open it
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "FALSE" resolution
    And User clears Third-party Contacts screening record on position 1 context
    And User remembers Third-party AP Individual Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks on 1 number screening record
    And User turns On 'Tag as red flag' on Screening Profile page
    Then Toast message "Success! Tag as red flag has been updated." is displayed
    When User clicks "Screening Results" breadcrumb Back icon
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then Screening results table is loaded
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects risk level as "LOW"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Risk Management tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C48973239 @C41454646
  Scenario: C48973239, C41454646: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data absent - Different Search Criterias (Associated Party Organisation)
    When User creates Associated Party "Organisation" "Dell" via API and open it
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "FALSE" resolution
    And User clears Third-party Contacts screening record on position 1 context
    And User remembers Third-party AP Organisation Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks on 1 number screening record
    And User turns On 'Tag as red flag' on Screening Profile page
    Then Toast message "Success! Tag as red flag has been updated." is displayed
    When User clicks "Screening Results" breadcrumb Back icon
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks on "MEDIA CHECK" tab
    Then Screening results table is loaded
    When User selects Associated Party Organisation Media Check screening record on position 1
    And User selects risk level as "LOW"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Risk Management tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C48973239 @C41454646
  Scenario: C48973239, C41454646: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data absent - Different Search Criterias (Associated Party Individual Other Names)
    When User creates Associated Party "Individual" "Barac Obama" via API and open it
    And User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 1 as "FALSE"
    And User remembers Third-party AP Individual Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Barac Obama" name
    And User fills in Name field value "Biden"
    And User selects Name type "Also Known As"
    And User clicks on "Other Names Add|Save button"
    And User clicks Close Other Name Results button
    And User clicks on Screen Other Name Button for "Biden" name
    And User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Associated Party Individual Other Names screening record on position 2
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks on Risk Management tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C48973239 @C41454646
  Scenario: C48973239, C41454646: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data absent - Different Search Criterias (Associated Party Organisation Other Names)
    When User creates Associated Party "Organisation" "Dell" via API and open it
    And User creates Other name "Apple" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 1 as "FALSE"
    And User remembers Third-party AP Organisation Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Apple inc." name
    And User fills in Name field value "Samsung"
    And User selects Name type "Doing Business As"
    And User clicks on "Other Names Add|Save button"
    And User clicks Close Other Name Results button
    And User clicks on Screen Other Name Button for "Samsung" name
    And User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Associated Party Organisation Other Names screening record on position 2
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    And User clicks on Risk Management tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44067040
  Scenario: C44067040: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data present - Changed reg flag updated in the table (Third Party)
    When User changes Search Criteria "Search Term" with value "CLOUD TECHNOLOGY Solution"
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    And User clears Third-party screening record on position 1 context
    And User remembers Third-party Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    Then Risk Remediation World Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | REFERENCE ID           |
      | RED FLAG DATE          |
    And World-Check Risk Remediation table is displayed with next details
      | SOURCE      | SEARCH TERM               | TAG AS RED FLAG RECORD | REFERENCE ID          | RED FLAG DATE |
      | Third-Party | CLOUD TECHNOLOGY Solution | Third-party Reference  | Third-party Reference | TODAY+        |
    When User clicks on World-Check Risk Remediation record "Third-party Reference"
    And User turns Off 'Tag as red flag' on Screening Profile page
    And User clicks on Risk Management tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44067040
  Scenario: C44067040: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data present - Changed reg flag updated in the table (Third Party Other Name)
    When User creates Other name "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH"
    And User opens screening results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" Other name
    And User clicks resolve Other Name screening record for "supplier" under number 1 as "POSITIVE"
    And User remembers Third-party Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    Then Risk Remediation World Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | REFERENCE ID           |
      | RED FLAG DATE          |
    And World-Check Risk Remediation table is displayed with next details
      | SOURCE                  | SEARCH TERM                                       | TAG AS RED FLAG RECORD            | REFERENCE ID                      | RED FLAG DATE |
      | Third-party Other Names | CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH | Third-party Other Names Reference | Third-party Other Names Reference | TODAY+        |
    When User clicks on World-Check Risk Remediation record "Third-party Other Names Reference"
    And User turns Off 'Tag as red flag' on Screening Profile page
    And User clicks on Risk Management tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44067040
  Scenario: C44067040: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data present - Changed reg flag updated in the table (Associated Party Individual)
    When User creates Associated Party "Individual" "Barac Obama" via API and open it
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 1 context
    And User remembers Third-party AP Individual Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    Then Risk Remediation World Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | REFERENCE ID           |
      | RED FLAG DATE          |
    And World-Check Risk Remediation table is displayed with next details
      | SOURCE                | SEARCH TERM | TAG AS RED FLAG RECORD              | REFERENCE ID                        | RED FLAG DATE |
      | Associated Individual | Barac Obama | Third-party AP Individual Reference | Third-party AP Individual Reference | TODAY+        |
    When User clicks on World-Check Risk Remediation record "Third-party AP Individual Reference"
    And User turns Off 'Tag as red flag' on Screening Profile page
    And User clicks on Risk Management tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44067040
  Scenario: C44067040: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data present - Changed reg flag updated in the table (Associated Party Individual Other Name)
    When User creates Associated Party "Individual" "Barac Obama" via API and open it
    And User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 1 as "POSITIVE"
    And User remembers Third-party AP Individual Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    Then Risk Remediation World Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | REFERENCE ID           |
      | RED FLAG DATE          |
    And World-Check Risk Remediation table is displayed with next details
      | SOURCE                            | SEARCH TERM | TAG AS RED FLAG RECORD                          | REFERENCE ID                                    | RED FLAG DATE |
      | Associated Individual Other Names | Barac Obama | Third-party AP Individual Other Names Reference | Third-party AP Individual Other Names Reference | TODAY+        |
    When User clicks on World-Check Risk Remediation record "Third-party AP Individual Other Names Reference"
    And User turns Off 'Tag as red flag' on Screening Profile page
    And User clicks on Risk Management tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44067040
  @RMS-32306
  Scenario: C44067040: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data present - Changed reg flag updated in the table (Associated Party Organisation)
    When User creates Associated Party "Organisation" "Dell" via API and open it
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 1 context
    And User remembers Third-party AP Organisation Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    Then Risk Remediation World Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | REFERENCE ID           |
      | RED FLAG DATE          |
    And World-Check Risk Remediation table is displayed with next details
      | SOURCE                  | SEARCH TERM | TAG AS RED FLAG RECORD                | REFERENCE ID                          | RED FLAG DATE |
      #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation | Dell        | Third-party AP Organisation Reference | Third-party AP Organisation Reference | TODAY+        |
      | Associated Organization | Dell        | Third-party AP Organisation Reference | Third-party AP Organisation Reference | TODAY+        |
    When User clicks on World-Check Risk Remediation record "Third-party AP Organisation Reference"
    And User turns Off 'Tag as red flag' on Screening Profile page
    And User clicks on Risk Management tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44067040
  @RMS-32306
  Scenario: C44067040: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data present - Changed reg flag updated in the table (Associated Party Organisation Other Name)
    When User creates Associated Party "Organisation" "Dell" via API and open it
    And User creates Other name "Apple" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 1 as "POSITIVE"
    And User remembers Third-party AP Organisation Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    Then Risk Remediation World Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | REFERENCE ID           |
      | RED FLAG DATE          |
    And World-Check Risk Remediation table is displayed with next details
      | SOURCE                              | SEARCH TERM | TAG AS RED FLAG RECORD                            | REFERENCE ID                                      | RED FLAG DATE |
            #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation Other Names | Apple inc.  | Third-party AP Organisation Other Names Reference | Third-party AP Organisation Other Names Reference | TODAY+        |
      | Associated Organization Other Names | Apple inc.  | Third-party AP Organisation Other Names Reference | Third-party AP Organisation Other Names Reference | TODAY+        |
    When User clicks on World-Check Risk Remediation record "Third-party AP Organisation Other Names Reference"
    And User turns Off 'Tag as red flag' on Screening Profile page
    And User clicks on Risk Management tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C45110726
  @RMS-32306
  Scenario: C45110726: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - Data absent - Deleted Associated Party/Other Names
    #  Third-party
    When User changes Search Criteria "Search Term" with value "CLOUD TECHNOLOGY Solution"
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    And User clears Third-party screening record on position 1 context
    And User remembers Third-party Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
#  Third-party Other Names
    When User creates Other name "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH"
    And User opens screening results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" Other name
    And User clicks resolve Other Name screening record for "supplier" under number 1 as "POSITIVE"
    And User remembers Third-party Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    #  Third-party Associated Party Individual 1
    And User creates Associated Party "Individual" "Barac Obama" via API and open it
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 1 context
    And User remembers Third-party AP Individual Reference1 context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    #  Third-party Associated Party Individual 2
    When User creates Associated Party "Individual" "John SMITH" via API and open it
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 1 context
    And User remembers Third-party AP Individual Reference2 context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    #  Third-party Associated Party Individual 2 Other Names
    When User creates Other name "Joe Biden" for Associated Party
    And User clicks resolve Other Name screening record for "contact" under number 1 as "POSITIVE"
    And User remembers Third-party AP Individual Other Names Reference2 context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    #   Third-party Associated Party Organization
    And User creates Associated Party "Organisation" "Dell" via API and open it
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 1 context
    And User remembers Third-party AP Organisation Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    #   Third-party Associated Party Organization Other Names
    When User creates Other name "Apple" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 1 as "POSITIVE"
    And User remembers Third-party AP Organisation Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    Then Risk Remediation World Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | REFERENCE ID           |
      | RED FLAG DATE          |
    And World-Check Risk Remediation table is displayed with next details
      | SOURCE                              | SEARCH TERM                                       | TAG AS RED FLAG RECORD                            | REFERENCE ID                                      | RED FLAG DATE |
      | Third-Party                         | CLOUD TECHNOLOGY Solution                         | Third-party Reference                             | Third-party Reference                             | TODAY+        |
      | Third-party Other Names             | CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH | Third-party Other Names Reference                 | Third-party Other Names Reference                 | TODAY+        |
      | Associated Individual               | Barac Obama                                       | Third-party AP Individual Reference1              | Third-party AP Individual Reference1              | TODAY+        |
      | Associated Individual               | John SMITH                                        | Third-party AP Individual Reference2              | Third-party AP Individual Reference2              | TODAY+        |
      | Associated Individual Other Names   | Joe Biden                                         | Third-party AP Individual Other Names Reference2  | Third-party AP Individual Other Names Reference2  | TODAY+        |
            #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation             | Dell                                              | Third-party AP Organisation Reference             | Third-party AP Organisation Reference             | TODAY+        |
      | Associated Organization             | Dell                                              | Third-party AP Organisation Reference             | Third-party AP Organisation Reference             | TODAY+        |
            #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation Other Names | Apple inc.                                        | Third-party AP Organisation Other Names Reference | Third-party AP Organisation Other Names Reference | TODAY+        |
      | Associated Organization Other Names | Apple inc.                                        | Third-party AP Organisation Other Names Reference | Third-party AP Organisation Other Names Reference | TODAY+        |
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks delete button for Associated Party "Barac"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    When User clicks on Risk Management tab
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on Associated Party with name "Dell"
    And User clicks on Delete Other Name Button for "Apple inc." name
    And User clicks "Proceed" on Delete Other Name modal window
    Then The Other name is deleted from table
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    Then World-Check Risk Remediation table is displayed with next details
      | SOURCE                            | SEARCH TERM                                       | TAG AS RED FLAG RECORD                           | REFERENCE ID                                     | RED FLAG DATE |
      | Third-Party                       | CLOUD TECHNOLOGY Solution                         | Third-party Reference                            | Third-party Reference                            | TODAY+        |
      | Third-party Other Names           | CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH | Third-party Other Names Reference                | Third-party Other Names Reference                | TODAY+        |
      | Associated Individual             | John SMITH                                        | Third-party AP Individual Reference2             | Third-party AP Individual Reference2             | TODAY+        |
      | Associated Individual Other Names | Joe Biden                                         | Third-party AP Individual Other Names Reference2 | Third-party AP Individual Other Names Reference2 | TODAY+        |
            #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation           | Dell                                              | Third-party AP Organisation Reference            | Third-party AP Organisation Reference            | TODAY+        |
      | Associated Organization           | Dell                                              | Third-party AP Organisation Reference            | Third-party AP Organisation Reference            | TODAY+        |

  @RMS-29238
  @C43784482
  Scenario: C43784482: [Risk Remediation] - Risk Management tab - Verify World-Check Screening Tab - No screening permissions
#   Third Party
    When User changes Search Criteria "Search Term" with value "CLOUD TECHNOLOGY Solution"
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    And User clears Third-party screening record on position 1 context
    And User remembers Third-party Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    #  Third-party Other Names
    When User creates Other name "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH"
    And User opens screening results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" Other name
    And User clicks resolve Other Name screening record for "supplier" under number 1 as "POSITIVE"
    And User remembers Third-party Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
#  Third-party Associated Party Individual
    And User creates Associated Party "Individual" "Barac Obama" via API and open it
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 1 context
    And User remembers Third-party AP Individual Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
#  Third-party Associated Party Individual Other Names
    When User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 1 as "POSITIVE"
    And User remembers Third-party AP Individual Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
#   Third-party Associated Party Organization
    And User creates Associated Party "Organisation" "Dell" via API and open it
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 1 context
    And User remembers Third-party AP Organisation Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
#   Third-party Associated Party Organization Other Names
    When User creates Other name "Apple" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 1 as "POSITIVE"
    And User remembers Third-party AP Organisation Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    And User clicks on World-Check Risk Remediation record "Third-party Reference"
    Then Third-party Information tab is loaded
    When User saves World-Check Risk Remediation record "Third-party Reference_URL" URL in context
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    And User clicks on World-Check Risk Remediation record "Third-party Other Names Reference"
    Then Third-party Information tab is loaded
    When User saves World-Check Risk Remediation record "Third-party Other Names Reference_URL" URL in context
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    And User clicks on World-Check Risk Remediation record "Third-party AP Individual Reference"
    Then Third-party Information tab is loaded
    When User saves World-Check Risk Remediation record "Third-party AP Individual Reference_URL" URL in context
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    And User clicks on World-Check Risk Remediation record "Third-party AP Individual Other Names Reference"
    Then Third-party Information tab is loaded
    When User saves World-Check Risk Remediation record "Third-party AP Individual Other Names Reference_URL" URL in context
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    And User clicks on World-Check Risk Remediation record "Third-party AP Organisation Reference"
    Then Third-party Information tab is loaded
    When User saves World-Check Risk Remediation record "Third-party AP Organisation Reference_URL" URL in context
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    And User clicks on World-Check Risk Remediation record "Third-party AP Organisation Other Names Reference"
    Then Third-party Information tab is loaded
    When User saves World-Check Risk Remediation record "Third-party AP Organisation Other Names Reference_URL" URL in context
    And User sets up role "AUTO TEST ROLE WITH DISABLED SCREENING" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User opens previously created Third-party
    And User clicks on "Risk Management" tab on Third-party page
    Then Risk Management sections are displayed
      | Workflow         |
      | Ad Hoc Activity  |
      | Risk Remediation |
    And Risk Management Risk Remediation section has tabs
      | QUESTIONNAIRE |
      | CUSTOM FIELDS |
    #     TODO - the next is failed due to the bug @RMS-29238
#    When User opens World-Check Screening records link "Third-party Reference_URL"
#    Then Current URL contains "/forbidden" endpoint
#    When User opens World-Check Screening records link "Third-party Other Names Reference_URL"
#    Then Current URL contains "/forbidden" endpoint
#    When User opens World-Check Screening records link "Third-party AP Individual Reference_URL"
#    Then Current URL contains "/forbidden" endpoint
#    When User opens World-Check Screening records link "Third-party AP Individual Other Names Reference_URL"
#    Then Current URL contains "/forbidden" endpoint
#    When User opens World-Check Screening records link "Third-party AP Organization Reference_URL"
#    Then Current URL contains "/forbidden" endpoint
#    When User opens World-Check Screening records link "Third-party AP Organization Other Names Reference_URL"
#    Then Current URL contains "/forbidden" endpoint
