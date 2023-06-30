@ui @full_regression @arabica

Feature: Associated Individual - PEP Status

  As an RDDC user who has a permission of screening
  I want to see PEP Status as 'Active' when hover PEP icon in screening table and also the each record, I would like to see tool tip with an attached file next to PEP Status as well
  So that it can see the PEP status clearly from the PEP icon and there is a tool tip which will help me to understand more about the PEP status.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"

  @C50633160
  Scenario: C50633160: Associated Individual - Verify To display PEP Status as 'Unknown' under an associated individual's main screening
    When User creates Associated Party "David DANIELI"
    Then Screening results table is loaded
    When User hovers WC Screening "David DANIELI" Type "PEP" icon
    Then Tooltip text is displayed
      | Politically Exposed Person\nStatus Unknown |

  @C50633161
  Scenario: C50633161: Associated Individual - Verify the field 'PEP Status' under 'Key Data' tab is shown as 'Unknown'
    When User creates Associated Party "David DANIELI"
    Then Screening results table is loaded
    When User clicks on 1 number screening record
    Then "PEP STATUS" is displayed status as "Unknown" under Kay Data Tab

  @C50633163
  Scenario: C50633163: Associated Individual - Verify the field 'PEP Status' under 'Key Data' tab  is shown as 'Unknown' after click from Risk Remediation under Risk Management
    When User creates Associated Party "Individual" "David DANIELI" via API and open it
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
      | SOURCE                | SEARCH TERM   | TAG AS RED FLAG RECORD              | REFERENCE ID                        | RED FLAG DATE |
      | Associated Individual | David DANIELI | Third-party AP Individual Reference | Third-party AP Individual Reference | TODAY+        |
    When User clicks on World-Check Risk Remediation record "Third-party AP Individual Reference"
    Then Third-party Information tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And Risk Remediation breadcrumb is displayed
    And "PEP STATUS" is displayed status as "Unknown" under Kay Data Tab

  @C50072401
  Scenario: C50072401: Associated Individual - Verify To display PEP Status as 'Active' under an associated individual's main screening
    When User creates Associated Party "Donald Trump"
    Then Screening results table is loaded
    When User hovers WC Screening "Donald III TRUMP" Type "PEP" icon
    Then Tooltip text is displayed
      | Politically Exposed Person\nStatus Active |

  @C50073611
  Scenario: C50073611: Associated Individual - Verify the field 'PEP Status' under 'Key Data' tab is shown as 'Active'
    When User creates Associated Party "Donald Trump"
    Then Screening results table is loaded
    When User clicks on 3 number screening record
    Then "PEP STATUS" is displayed status as "Active" under Kay Data Tab

  @C50074051
  Scenario: C50074051: Associated Individual -  Verify the field 'PEP Status' under 'Key Data' tab  is shown as 'Active' after click from Risk Remediation under Risk Management
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
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "World-Check Screening" tab
    Then Risk Remediation World Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | REFERENCE ID           |
      | RED FLAG DATE          |
    And World-Check Risk Remediation table is displayed with next details
      | SOURCE                | SEARCH TERM  | TAG AS RED FLAG RECORD              | REFERENCE ID                        | RED FLAG DATE |
      | Associated Individual | Donald Trump | Third-party AP Individual Reference | Third-party AP Individual Reference | TODAY+        |
    When User clicks on World-Check Risk Remediation record "Third-party AP Individual Reference"
    Then Third-party Information tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And Risk Remediation breadcrumb is displayed
    And "PEP STATUS" is displayed status as "Active" under Kay Data Tab

  @C50074084
  Scenario: C50074084: Associated Individual - Verify To display PEP Status as 'Inactive' under an associated individual's main screening
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User hovers WC Screening "Barack OBAMA" Type "PEP" icon
    Then Tooltip text is displayed
      | Politically Exposed Person\nStatus Inactive |

  @C50074092
  Scenario: C50074092: Associated Individual - Verify the field 'PEP Status' under 'Key Data' tab is shown as 'Inactive'
    When User creates Associated Party "Individual" "Barac Obama" via API and open it
    Then Screening results table is loaded
    When User clicks resolve "World-Check" screening record for "supplier" on position 2 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 2 context
    And User remembers Third-party AP Individual Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening results table is loaded
    When User clicks on 1 number screening record
    Then Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And "PEP STATUS" displays the same value as value from API

  @C50858572
  Scenario: C50858572: Associated Individual - Verify the field 'PEP Status' under 'Key Data' tab is shown as 'Inactive'
    When User creates Associated Party "Individual" "David DANIELI" via API and open it
    Then Screening results table is loaded
    When User clicks resolve "World-Check" screening record for "supplier" on position 10 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 10 context
    And User remembers Third-party AP Individual Reference context selection
    Then Add Comment modal is displayed
    When User fills in comment "Automation Third-party Contacts comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening results table is loaded
    When User clicks on 1 number screening record
    Then Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And "PEP STATUS" displays the same value as value from API

  @C50074201
  Scenario: C50074201: Associated Individual - Verify the field 'PEP Status' under 'Key Data' tab  is shown as 'Inactive' after click from Risk Remediation under Risk Management
    When User creates Associated Party "Individual" "Barac Obama" via API and open it
    Then Screening results table is loaded
    When User clicks resolve "World-Check" screening record for "supplier" on position 2 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 2 context
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
    Then Third-party Information tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And Risk Remediation breadcrumb is displayed
    And "PEP STATUS" displays the same value as value from API

  @C50861677
  Scenario: C50861677: Associated Individual - Verify the field 'PEP Status' under 'Key Data' tab  is shown as 'Inactive' after click from Risk Remediation under Risk Management
    When User creates Associated Party "Individual" "David DANIELI" via API and open it
    Then Screening results table is loaded
    When User clicks resolve "World-Check" screening record for "supplier" on position 10 on main screening list as "POSSIBLE" resolution
    And User clears Third-party Contacts screening record on position 10 context
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
      | SOURCE                | SEARCH TERM   | TAG AS RED FLAG RECORD              | REFERENCE ID                        | RED FLAG DATE |
      | Associated Individual | David DANIELI | Third-party AP Individual Reference | Third-party AP Individual Reference | TODAY+        |
    When User clicks on World-Check Risk Remediation record "Third-party AP Individual Reference"
    Then Third-party Information tab is loaded
    And Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/" endpoint
    And Risk Remediation breadcrumb is displayed
    And "PEP STATUS" displays the same value as value from API