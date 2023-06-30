@ui @full_regression @arabica

Feature: Associated Individual Other Names - PEP Status

  As an RDDC user who has a permission of screening
  I want to see PEP Status as 'Active' when hover PEP icon in screening table and also the each record, I would like to see tool tip with an attached file next to PEP Status as well
  So that it can see the PEP status clearly from the PEP icon and there is a tool tip which will help me to understand more about the PEP status.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"

  @C50074085
  Scenario: C50074085: Associated Individual Other Names - Verify To display PEP Status as 'Active' under an associated individual's other names screening
    When User creates Associated Party "Donald Trump"
    Then Screening results table is loaded
    When User creates Other name "Donald Trump for Associated Individual" for Associated Party
    Then Other Name dialog is loaded
    When User hovers WC Screening Other Name "Donald III TRUMP" Type "PEP" icon
    Then Tooltip text is displayed
      | Politically Exposed Person\nStatus Active |

  @C50074086
  Scenario: C50074086: Associated Individual Other Names - Verify the field 'PEP Status' under 'Key Data' tab  is shown as 'Active'
    When User creates Associated Party "Donald Trump"
    Then Screening results table is loaded
    When User creates Other name "Donald Trump for Associated Individual" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on 3 number Other name screening record
    Then "PEP STATUS" is displayed status as "Active" under Kay Data Tab

  @C50074087
  Scenario: C50074087: Associated Individual Other Names  - Verify the field 'PEP Status' under 'Key Data' tab  is shown as 'Active' after click from Risk Remediation under Risk Management
    When User creates Associated Party "Individual" "Donald Trump" via API and open it
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
    When User creates Other name "Donald Trump for Associated Individual" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 3 as "POSITIVE"
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
      | SOURCE                            | SEARCH TERM  | TAG AS RED FLAG RECORD                          | REFERENCE ID                                    | RED FLAG DATE |
      | Associated Individual             | Donald Trump | Third-party AP Individual Reference             | Third-party AP Individual Reference             | TODAY+        |
      | Associated Individual Other Names | Donald Trump | Third-party AP Individual Other Names Reference | Third-party AP Individual Other Names Reference | TODAY+        |
    When User clicks on World-Check Risk Remediation record "Third-party AP Individual Other Names Reference"
    Then Associated Parties tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And Risk Remediation breadcrumb is displayed
    And "PEP STATUS" is displayed status as "Active" under Kay Data Tab

  @C50750088
  Scenario: C50750088: Associated Individual Other Names - Verify To display PEP Status as 'Unknown' under an associated individual's other names screening
    When User creates Associated Party "David DANIELI"
    Then Screening results table is loaded
    When User creates Other name "David DANIELI" for Associated Party
    Then Other Name dialog is loaded
    When User hovers WC Screening Other Name "David DANIELI" Type "PEP" icon
    Then Tooltip text is displayed
      | Politically Exposed Person\nStatus Unknown |

  @C50750089
  Scenario: C50750089: Associated Individual Other Names - Verify the field, 'PEP Status' is shown as 'Unknown' instead of '-'
    When User creates Associated Party "David DANIELI"
    Then Screening results table is loaded
    When User creates Other name "David DANIELI" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    Then "PEP STATUS" is displayed status as "Unknown" under Kay Data Tab

  @C50750090
  Scenario: C50750090: Associated Individual Other Names  - Verify the field 'PEP Status' under 'Key Data' tab  is shown as 'Active' after click from Risk Remediation under Risk Management
    When User creates Associated Party "Individual" "Donald Trump" via API and open it
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
    When User creates Other name "David DANIELI" for Associated Party
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
      | SOURCE                            | SEARCH TERM   | TAG AS RED FLAG RECORD                          | REFERENCE ID                                    | RED FLAG DATE |
      | Associated Individual             | Donald Trump  | Third-party AP Individual Reference             | Third-party AP Individual Reference             | TODAY+        |
      | Associated Individual Other Names | David DANIELI | Third-party AP Individual Other Names Reference | Third-party AP Individual Other Names Reference | TODAY+        |
    When User clicks on World-Check Risk Remediation record "Third-party AP Individual Other Names Reference"
    Then Associated Parties tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And Risk Remediation breadcrumb is displayed
    And "PEP STATUS" is displayed status as "Unknown" under Kay Data Tab

  @C50074212
  Scenario: C50074212: Associated Individual Other Names - Verify To display PEP Status as 'Inactive' under an associated individual's main screening
    When User creates Associated Party "David DANIELI"
    Then Screening results table is loaded
    When User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    When User hovers WC Screening Other Name "Barack OBAMA" Type "PEP" icon
    Then Tooltip text is displayed
      | Politically Exposed Person\nStatus Inactive |

  @C50074213
  Scenario: C50074213: Associated Individual Other Names - Verify the field 'PEP Status' under 'Key Data' tab is shown as 'Inactive'
    When User creates Associated Party "Individual" "Donald Trump" via API and open it
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
    When User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 2 as "POSITIVE"
    And User remembers Third-party AP Individual Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And "PEP STATUS" displays the same value as value from API

  @C50862669
  Scenario: C50862669: Associated Individual Other Names - Verify the field 'PEP Status' under 'Key Data' tab is shown as 'Inactive'
    When User creates Associated Party "Individual" "Donald Trump" via API and open it
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
    When User creates Other name "David DANIELI" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 10 as "POSITIVE"
    And User remembers Third-party AP Individual Other Names Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts Other Names comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks Close Other Name Results button
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And "PEP STATUS" displays the same value as value from API

  @C50074214
  Scenario: C50074214: Associated Individual Other Names - Verify the field 'PEP Status' under 'Key Data' tab  is shown as 'Inactive' after click from Risk Remediation under Risk Management
    When User creates Associated Party "Individual" "Donald Trump" via API and open it
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
    When User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 2 as "POSITIVE"
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
      | SOURCE                            | SEARCH TERM  | TAG AS RED FLAG RECORD                          | REFERENCE ID                                    | RED FLAG DATE |
      | Associated Individual             | Donald Trump | Third-party AP Individual Reference             | Third-party AP Individual Reference             | TODAY+        |
      | Associated Individual Other Names | Barac Obama  | Third-party AP Individual Other Names Reference | Third-party AP Individual Other Names Reference | TODAY+        |
    When User clicks on World-Check Risk Remediation record "Third-party AP Individual Other Names Reference"
    Then Associated Parties tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And Risk Remediation breadcrumb is displayed
    And "PEP STATUS" displays the same value as value from API

  @C50862671
  Scenario: C50862671: Associated Individual Other Names - Verify the field 'PEP Status' under 'Key Data' tab  is shown as 'Inactive' after click from Risk Remediation under Risk Management
    When User creates Associated Party "Individual" "Donald Trump" via API and open it
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
    When User creates Other name "David DANIELI" for Associated Party
    Then Other Name dialog is loaded
    When User clicks resolve Other Name screening record for "contact" under number 10 as "POSITIVE"
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
      | SOURCE                            | SEARCH TERM   | TAG AS RED FLAG RECORD                          | REFERENCE ID                                    | RED FLAG DATE |
      | Associated Individual             | Donald Trump  | Third-party AP Individual Reference             | Third-party AP Individual Reference             | TODAY+        |
      | Associated Individual Other Names | David DANIELI | Third-party AP Individual Other Names Reference | Third-party AP Individual Other Names Reference | TODAY+        |
    When User clicks on World-Check Risk Remediation record "Third-party AP Individual Other Names Reference"
    Then Associated Parties tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And Risk Remediation breadcrumb is displayed
    And "PEP STATUS" displays the same value as value from API