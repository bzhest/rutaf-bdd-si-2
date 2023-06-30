@ui @cacao @functional @risk_remediation @media_check
Feature: Risk Management tab - Verify Media Check Screening Tab

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "APPLE INVESTMENT COMPANY" via API and open it
    Then Screening results table is loaded
    When User clicks Change Search Criteria screening button
    And User clicks on Check Type "Media Check"
    And User clicks Search On Search criteria button

  @C43561305
  @RMS-32306
  Scenario: C43561305: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data present
#  Third-party
    When User clicks on "MEDIA CHECK" tab
    And User selects Third-party Media Check screening record on position 1
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
#  Third-party Other Names
    When User clicks on "WORLD-CHECK" tab
    And User fills in Name field value "APPLE INVESTMENT COMPANY"
    And User selects Name type "Doing Business As"
    And User clicks on "Add button"
    And User clicks on Screen Other Name Button for "APPLE INVESTMENT COMPANY" name
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
#  Third-party Associated Party Individual
    When User creates Associated Party "Individual" "Barac Obama" via API and open it
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then Screening results table is loaded
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects risk level as "LOW"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    #  Third-party Associated Party Individual Other Names
    When User clicks on "WORLD-CHECK" tab
    And User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Associated Party Individual Other Names screening record on position 2
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    #  Third-party Associated Party Organization
    When User creates Associated Party "Organizational" "Dell" via API and open it
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then Screening results table is loaded
    When User selects Associated Party Organisation Media Check screening record on position 1
    And User selects risk level as "LOW"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    #  Third-party Associated Party Organization Other Names
    When User clicks on "WORLD-CHECK" tab
    And User creates Other name "Apple" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
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
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Remediation Media Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | RED FLAG DATE          |
    And Media check Risk Remediation table is displayed with next details
      | SOURCE                              | SEARCH TERM              | TAG AS RED FLAG RECORD                                 | RED FLAG DATE |
      | Third-Party                         | APPLE INVESTMENT COMPANY | thirdPartyMediaCheckRecord                             | TODAY+        |
      | Third-party Other Names             | APPLE INVESTMENT COMPANY | thirdPartyOtherNameMediaCheckRecord                    | TODAY+        |
      | Associated Individual               | Barac Obama              | associatedPartyIndividualMediaCheckRecord              | TODAY+        |
      | Associated Individual Other Names   | Barac Obama              | associatedPartyIndividualOtherNameMediaCheckRecord     | TODAY+        |
      #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation             | Dell                     | associatedPartyOrganizationalMediaCheckRecord          | TODAY+        |
      | Associated Organization             | Dell                     | associatedPartyOrganizationalMediaCheckRecord          | TODAY+        |
      #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation Other Names | Apple inc.               | associatedPartyOrganizationalOtherNameMediaCheckRecord | TODAY+        |
      | Associated Organization Other Names | Apple inc.               | associatedPartyOrganizationalOtherNameMediaCheckRecord | TODAY+        |
    When User clicks Risk Remediation Media check "Source" column
    Then Media check Risk Remediation Source column is sorted in next order
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
    When User clicks Risk Remediation Media check "Source" column
    Then Media check Risk Remediation Source column is sorted in next order
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
    When User clicks Risk Remediation Media check "Search Term" column
    Then Media check Risk Remediation table is sorted by "Search Term" in "ASC" order
    When User clicks Risk Remediation Media check "Search Term" column
    Then Media check Risk Remediation table is sorted by "Search Term" in "DESC" order
    When User clicks Risk Remediation Media check "Tag as Red Flag Record" column
    Then Media check Risk Remediation table is sorted by "Tag as Red Flag Record" in "ASC" order
    When User clicks Risk Remediation Media check "Tag as Red Flag Record" column
    Then Media check Risk Remediation table is sorted by "Tag as Red Flag Record" in "DESC" order
    When User clicks Risk Remediation Media check "Red Flag Date" column
    Then Media check Risk Remediation table is sorted by "Red Flag Date" in "ASC" order
    When User clicks Risk Remediation Media check "Red Flag Date" column
    Then Media check Risk Remediation table is sorted by "Red Flag Date" in "DESC" order

  @C43561305
  Scenario: C43561305: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data present - Pagination
    When User clicks on "MEDIA CHECK" tab
    And User selects "50" items per page
    And User clicks on select all checkBox of media check page
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Pagination option "10" is selected
    And Pagination buttons should be visible
      | first page | previous page | next page | last page |
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |

  @C43565806
  Scenario: C43565806: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - View Record Details page
#  Third-party
    When User clicks on "MEDIA CHECK" tab
    And User selects Third-party Media Check screening record on position 1
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
#  Third-party Other Names
    When User clicks on "WORLD-CHECK" tab
    And User fills in Name field value "APPLE INVESTMENT COMPANY"
    And User selects Name type "Doing Business As"
    And User clicks on "Add button"
    And User clicks on Screen Other Name Button for "APPLE INVESTMENT COMPANY" name
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
#  Third-party Associated Party Individual
    When User creates Associated Party "Individual" "Barac Obama" via API and open it
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then Screening results table is loaded
    When User selects Associated Party Individual Media Check screening record on position 1
    And User selects risk level as "LOW"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    #  Third-party Associated Party Individual Other Names
    When User clicks on "WORLD-CHECK" tab
    And User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Associated Party Individual Other Names screening record on position 2
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    #  Third-party Associated Party Organization
    When User creates Associated Party "Organizational" "Dell" via API and open it
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then Screening results table is loaded
    When User selects Associated Party Organisation Media Check screening record on position 1
    And User selects risk level as "LOW"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    #  Third-party Associated Party Organization Other Names
    When User clicks on "WORLD-CHECK" tab
    And User creates Other name "Samsung" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
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
    And User clicks Risk Remediation "Media Check Screening" tab
    And User clicks on Media Check Risk Remediation record "thirdPartyMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    And Media check alert toast message is not displayed with text
      | Request Error |
    When User waits for progress bar to disappear from page
    Then Media Check Media Resolution Risk Level "HIGH" is highlighted
    And Media Check Media Resolution Tag as Red Flag is toggled
    When User retrieves Media Check article id for record "thirdPartyMediaCheckRecord"
    Then Current URL contains "/thirdparty/thirdPartyId/profile/media-check/articleId" endpoint
    And Media Check record profile is displayed with next details
      | Name         | Article ID   | Country of Registration | Last Screening Date | Data Provider | Created By    | Last Updated By |
      | toBeReplaced | toBeReplaced | China                   | TODAY               | Media Check   | System Notice | System Notice   |
    And Risk Remediation breadcrumb is displayed
    When User clicks Media Check Risk Remediation back button
    Then Risk Remediation "Media Check Screening" tab is displayed
    When User clicks on Media Check Risk Remediation record "thirdPartyMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User clicks Risk Remediation breadcrumb
    Then Risk Remediation "Media Check Screening" tab is displayed
    When User clicks on Media Check Risk Remediation record "thirdPartyOtherNameMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User retrieves Media Check article id for record "thirdPartyOtherNameMediaCheckRecord"
    Then Current URL contains "/thirdparty/thirdPartyId/profile/media-check/articleId/" endpoint
    And Risk Remediation breadcrumb is displayed
    When User clicks Media Check Risk Remediation back button
    Then Risk Remediation "Media Check Screening" tab is displayed
    When User clicks on Media Check Risk Remediation record "associatedPartyIndividualMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User clicks Risk Remediation breadcrumb
    Then Risk Remediation "Media Check Screening" tab is displayed
    When User clicks on Media Check Risk Remediation record "associatedPartyIndividualMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User retrieves Media Check article id for record "associatedPartyIndividualMediaCheckRecord"
    Then Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/media-check/articleId?type=individual" endpoint
    And Risk Remediation breadcrumb is displayed
    When User clicks Media Check Risk Remediation back button
    Then Risk Remediation "Media Check Screening" tab is displayed
    When User clicks on Media Check Risk Remediation record "associatedPartyOrganizationalMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User clicks Risk Remediation breadcrumb
    Then Risk Remediation "Media Check Screening" tab is displayed
    When User clicks on Media Check Risk Remediation record "associatedPartyOrganizationalMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User retrieves Media Check article id for record "associatedPartyOrganizationalMediaCheckRecord"
    Then Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdOrganizational/profile/media-check/articleId?type=organization" endpoint
    And Risk Remediation breadcrumb is displayed
    When User clicks Media Check Risk Remediation back button
    Then Risk Remediation "Media Check Screening" tab is displayed
    When User clicks on Media Check Risk Remediation record "associatedPartyIndividualOtherNameMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User retrieves Media Check article id for record "associatedPartyIndividualOtherNameMediaCheckRecord"
    Then Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdIndividual/profile/media-check/articleId/Barac%20Obama?type=individual" endpoint
    And Risk Remediation breadcrumb is displayed
    When User clicks Media Check Risk Remediation back button
    Then Risk Remediation "Media Check Screening" tab is displayed
    When User clicks on Media Check Risk Remediation record "associatedPartyOrganizationalOtherNameMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User retrieves Media Check article id for record "associatedPartyOrganizationalOtherNameMediaCheckRecord"
    Then Current URL contains "/thirdparty/thirdPartyId/associated-parties/associatedPartyIdOrganizational/profile/media-check/articleId/Samsung?type=organization" endpoint

  @C44067751 @C44067756
  Scenario: C44067751, C44067756: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data present - Different Search Criterias (Third Party)
#  Third-party
    And User clicks on "MEDIA CHECK" tab
    And User selects Third-party Media Check screening record on position 1
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User changes Search Criteria "Search Term" with value "Dell"
    And User selects Third-party Media Check screening record on position 1
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Remediation Media Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | RED FLAG DATE          |
    And Media check Risk Remediation table is displayed with next details
      | SOURCE      | SEARCH TERM | TAG AS RED FLAG RECORD     | RED FLAG DATE |
      | Third-Party | Dell        | thirdPartyMediaCheckRecord | TODAY+        |
    When User clicks on Media Check Risk Remediation record "thirdPartyMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    When User turns off 'Tag as red flag' of Media Check Media Resolution Profile
    And User clicks "SAVE" Media Check Attach modal button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty


  @C44067751 @C44067756
  Scenario: C44067751, C44067756: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data present - Different Search Criterias (Third Party Other Name)
    #  Third-party Other Names
    When User clicks on "WORLD-CHECK" tab
    And User fills in Name field value "APPLE INVESTMENT COMPANY"
    And User selects Name type "Doing Business As"
    And User clicks on "Add button"
    And User clicks on Screen Other Name Button for "APPLE INVESTMENT COMPANY" name
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
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "APPLE INVESTMENT COMPANY" name
    And User fills in Name field value "MacDonalds"
    And User selects Name type "Doing Business As"
    And User clicks on "Other Names Add|Save button"
    And User clicks on Screen Other Name Button for "MacDonalds" name
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
    And User clicks Close Other Name Results button
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Remediation Media Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | RED FLAG DATE          |
    And Media check Risk Remediation table is displayed with next details
      | SOURCE                  | SEARCH TERM | TAG AS RED FLAG RECORD              | RED FLAG DATE |
      | Third-party Other Names | MacDonalds  | thirdPartyOtherNameMediaCheckRecord | TODAY+        |
    When User clicks on Media Check Risk Remediation record "thirdPartyOtherNameMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    When User turns off 'Tag as red flag' of Media Check Media Resolution Profile
    And User clicks "SAVE" Media Check Attach modal button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44067751 @C44067756
  Scenario: C44067751, C44067756: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data present - Different Search Criterias (Third-party Associated Party Individual)
#  Third-party Associated Party Individual
    When User creates Associated Party "Individual" "Barac Obama" via API and open it
    And User clicks on "MEDIA CHECK" tab
    And User selects Associated Party Individual Media Check screening record on position 1
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User changes Search Criteria "Search Term" with value "Apple"
    And User clicks on "MEDIA CHECK" tab
    And User selects Associated Party Individual Media Check screening record on position 1
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Remediation Media Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | RED FLAG DATE          |
    And Media check Risk Remediation table is displayed with next details
      | SOURCE                | SEARCH TERM | TAG AS RED FLAG RECORD                    | RED FLAG DATE |
      | Associated Individual | Apple       | associatedPartyIndividualMediaCheckRecord | TODAY+        |
    When User clicks on Media Check Risk Remediation record "associatedPartyIndividualMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    When User turns off 'Tag as red flag' of Media Check Media Resolution Profile
    And User clicks "SAVE" Media Check Attach modal button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44067751 @C44067756
  Scenario: C44067751, C44067756: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data present - Different Search Criterias (Third-party Associated Party Individual Other Names)
    When User creates Associated Party "Individual" "Barac Obama" via API and open it
    #  Third-party Associated Party Individual Other Names
    And User clicks on "WORLD-CHECK" tab
    And User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Associated Party Individual Other Names screening record on position 2
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Barac Obama" name
    And User fills in Name field value "Joe Biden"
    And User selects Name type "Also Known As"
    And User clicks on "Other Names Add|Save button"
    And User clicks Close Other Name Results button
    And User clicks on Screen Other Name Button for "Joe Biden" name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Associated Party Individual Other Names screening record on position 1
    And User selects risk level as "MEDIUM"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Remediation Media Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | RED FLAG DATE          |
    And Media check Risk Remediation table is displayed with next details
      | SOURCE                            | SEARCH TERM | TAG AS RED FLAG RECORD                             | RED FLAG DATE |
      | Associated Individual Other Names | Joe Biden   | associatedPartyIndividualOtherNameMediaCheckRecord | TODAY+        |
    When User clicks on Media Check Risk Remediation record "associatedPartyIndividualOtherNameMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    When User turns off 'Tag as red flag' of Media Check Media Resolution Profile
    And User clicks "SAVE" Media Check Attach modal button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44067751 @C44067756
  @RMS-32306
  Scenario: C44067751, C44067756: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data present - Different Search Criterias (Third-party Associated Party Organisation)
      #   Third-party Associated Party Organization
    When User creates Associated Party "Organisation" "Dell" via API and open it
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then Screening results table is loaded
    When User selects Associated Party Organisation Media Check screening record on position 1
    And User selects risk level as "LOW"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User changes Search Criteria "Search Term" with value "MacDonalds"
    And User clicks on "MEDIA CHECK" tab
    And User selects Associated Party Organisation Media Check screening record on position 1
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Remediation Media Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | RED FLAG DATE          |
    And Media check Risk Remediation table is displayed with next details
      | SOURCE                  | SEARCH TERM | TAG AS RED FLAG RECORD                        | RED FLAG DATE |
#TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation | MacDonalds  | associatedPartyOrganizationalMediaCheckRecord | TODAY+        |
      | Associated Organization | MacDonalds  | associatedPartyOrganizationalMediaCheckRecord | TODAY+        |
    When User clicks on Media Check Risk Remediation record "associatedPartyOrganizationalMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    When User turns off 'Tag as red flag' of Media Check Media Resolution Profile
    And User clicks "SAVE" Media Check Attach modal button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44067751 @C44067756
  @RMS-32306
  Scenario: C44067751, C44067756: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data present - Different Search Criterias (Third-party Associated Party Organisation Other Names)
    When User creates Associated Party "Organisation" "Dell" via API and open it
    #  Third-party Associated Party Organization Other Names
    And User clicks on "WORLD-CHECK" tab
    And User creates Other name "Apple" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Associated Party Organisation Other Names screening record on position 2
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Apple inc." name
    And User fills in Name field value "Samsung"
    And User selects Name type "Doing Business As"
    And User clicks on "Other Names Add|Save button"
    And User clicks Close Other Name Results button
    And User clicks on Screen Other Name Button for "Samsung" name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Associated Party Organisation Other Names screening record on position 2
    And User selects risk level as "MEDIUM"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Remediation Media Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | RED FLAG DATE          |
    And Media check Risk Remediation table is displayed with next details
      | SOURCE                              | SEARCH TERM | TAG AS RED FLAG RECORD                                 | RED FLAG DATE |
#TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation Other Names | Samsung     | associatedPartyOrganizationalOtherNameMediaCheckRecord | TODAY+        |
      | Associated Organization Other Names | Samsung     | associatedPartyOrganizationalOtherNameMediaCheckRecord | TODAY+        |
    When User clicks on Media Check Risk Remediation record "associatedPartyOrganizationalOtherNameMediaCheckRecord"
    Then Media Resolution on Screening Result is displayed
    When User selects risk level on MediaCheck Profile as "HIGH"
    And User fills in comment "test add comment"
    And  User clicks attach button on MediaCheck Profile
    Then Media Check attach modal is displayed
    When User turns off 'Tag as red flag' of Media Check Media Resolution Profile
    And User clicks "SAVE" Media Check Attach modal button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C45110335
  @RMS-32306
  Scenario: C45110335: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data absent - Deleted Contact/Other Names
    #  Third-party
    When User clicks on "MEDIA CHECK" tab
    And User selects Third-party Media Check screening record on position 1
    And User remembers Third-party Reference Media Check context selection
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
#  Third-party Other Names
    When User clicks on "WORLD-CHECK" tab
    And User fills in Name field value "APPLE INVESTMENT COMPANY"
    And User selects Name type "Doing Business As"
    And User clicks on "Add button"
    And User clicks on Screen Other Name Button for "APPLE INVESTMENT COMPANY" name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Third-party Other Names screening record on position 2
    And User remembers Third-party Other Names Reference Media Check context selection
    And User selects risk level as "MEDIUM"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    #  Third-party Associated Party Individual 1
    And User creates Associated Party "Individual" "Barac Obama" via API and open it
    And User clicks on "MEDIA CHECK" tab
    And User selects Associated Party Individual Media Check screening record on position 1
    And User remembers Third-party Associated Party Individual Reference1 Media Check context selection
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    #  Third-party Associated Party Individual 2
    When User creates Associated Party "Individual" "John SMITH" via API and open it
    And User clicks on "MEDIA CHECK" tab
    And User selects Associated Party Individual Media Check screening record on position 1
    And User remembers Third-party Associated Party Individual Reference2 Media Check context selection
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    #  Third-party Associated Party Individual 2 Other Names
    When User creates Other name "Barac Obama" for Associated Party
    And User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Associated Party Individual Other Names screening record on position 2
    And User remembers Third-party Associated Party Individual Other Names Reference2 Media Check context selection
    And User selects risk level as "MEDIUM"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    #   Third-party Associated Party Organization
    And User creates Associated Party "Organisation" "Dell" via API and open it
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then Screening results table is loaded
    When User selects Associated Party Organisation Media Check screening record on position 1
    And User remembers Third-party Associated Party Organisation Reference Media Check context selection
    And User selects risk level as "LOW"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    #   Third-party Associated Party Organization Other Names
    When User clicks on "WORLD-CHECK" tab
    And User creates Other name "Apple" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Associated Party Organisation Other Names screening record on position 2
    And User remembers Third-party Associated Party Organisation Other Names Reference Media Check context selection
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Remediation Media Check table is displayed with columns
      | SOURCE                 |
      | SEARCH TERM            |
      | TAG AS RED FLAG RECORD |
      | RED FLAG DATE          |
    And Media check Risk Remediation table is displayed with next details
      | SOURCE                              | SEARCH TERM              | TAG AS RED FLAG RECORD                                          | RED FLAG DATE |
      | Third-Party                         | APPLE INVESTMENT COMPANY | Third-party Reference                                           | TODAY+        |
      | Third-party Other Names             | APPLE INVESTMENT COMPANY | Third-party Other Names Reference                               | TODAY+        |
      | Associated Individual               | Barac Obama              | Third-party Associated Party Individual Reference1              | TODAY+        |
      | Associated Individual               | John SMITH               | Third-party Associated Party Individual Reference2              | TODAY+        |
      | Associated Individual Other Names   | Barac Obama              | Third-party Associated Party Individual Other Names Reference2  | TODAY+        |
            #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation             | Dell                     | Third-party Associated Party Organisation Reference             | TODAY+        |
      | Associated Organization             | Dell                     | Third-party Associated Party Organisation Reference             | TODAY+        |
            #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation Other Names | Apple inc.               | Third-party Associated Party Organisation Other Names Reference | TODAY+        |
      | Associated Organization Other Names | Apple inc.               | Third-party Associated Party Organisation Other Names Reference | TODAY+        |
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks delete button for Associated Party "John SMITH"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    When User clicks on Risk Management tab
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on Associated Party with name "Dell"
    And User clicks on Delete Other Name Button for "Apple inc." name
    And User clicks "Proceed" on Delete Other Name modal window
    Then The Other name is deleted from table
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Media check Risk Remediation table is displayed with next details
      | SOURCE                  | SEARCH TERM              | TAG AS RED FLAG RECORD                              | RED FLAG DATE |
      | Third-Party             | APPLE INVESTMENT COMPANY | Third-party Reference                               | TODAY+        |
      | Third-party Other Names | APPLE INVESTMENT COMPANY | Third-party Other Names Reference                   | TODAY+        |
      | Associated Individual   | Barac Obama              | Third-party Associated Party Individual Reference1  | TODAY+        |
            #TODO - uncomment and remove line below when RMS-32306 will be fixed
#      | Associated Organisation | Dell                     | Third-party Associated Party Organisation Reference | TODAY+        |
      | Associated Organization | Dell                     | Third-party Associated Party Organisation Reference | TODAY+        |

  @RMS-29238
  @C43570094
  Scenario: C43570094: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - No screening permissions
     #  Third-party
    When User clicks on "MEDIA CHECK" tab
    And User selects Third-party Media Check screening record on position 1
    And User remembers Third-party Reference Media Check context selection
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
#  Third-party Other Names
    When User clicks on "WORLD-CHECK" tab
    And User fills in Name field value "APPLE INVESTMENT COMPANY"
    And User selects Name type "Doing Business As"
    And User clicks on "Add button"
    And User clicks on Screen Other Name Button for "APPLE INVESTMENT COMPANY" name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Third-party Other Names screening record on position 2
    And User remembers Third-party Other Names Reference Media Check context selection
    And User selects risk level as "MEDIUM"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    #  Third-party Associated Party Individual
    And User creates Associated Party "Individual" "John SMITH" via API and open it
    And User clicks on "MEDIA CHECK" tab
    And User selects Associated Party Individual Media Check screening record on position 1
    And User remembers Third-party Associated Party Individual Reference Media Check context selection
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    #  Third-party Associated Party Individual Other Names
    When User creates Other name "Barac Obama" for Associated Party
    And User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Associated Party Individual Other Names screening record on position 2
    And User remembers Third-party Associated Party Individual Other Names Reference Media Check context selection
    And User selects risk level as "MEDIUM"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    #   Third-party Associated Party Organization
    And User creates Associated Party "Organisation" "Dell" via API and open it
    Then Screening results table is loaded
    When User clicks on "MEDIA CHECK" tab
    Then Screening results table is loaded
    When User selects Associated Party Organisation Media Check screening record on position 1
    And User remembers Third-party Associated Party Organisation Reference Media Check context selection
    And User selects risk level as "LOW"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    #   Third-party Associated Party Organization Other Names
    When User clicks on "WORLD-CHECK" tab
    And User creates Other name "Apple" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Associated Party Organisation Other Names screening record on position 2
    And User remembers Third-party Associated Party Organisation Other Names Reference Media Check context selection
    And User selects risk level as "UNKNOWN"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks Media Check 'Tag as Red Flag' toggle
    And User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    And User clicks on Media Check Risk Remediation record "Third-party Reference"
    Then Third-party Information tab is loaded
    When User saves Media-Check Risk Remediation record "Third-party Reference_URL" URL in context
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    And User clicks on Media Check Risk Remediation record "Third-party Other Names Reference"
    Then Third-party Information tab is loaded
    When User saves Media-Check Risk Remediation record "Third-party Other Names Reference_URL" URL in context
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    And User clicks on Media Check Risk Remediation record "Third-party Other Names Reference"
    Then Third-party Information tab is loaded
    When User saves Media-Check Risk Remediation record "Third-party Other Names Reference_URL" URL in context
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    And User clicks on Media Check Risk Remediation record "Third-party Associated Party Individual Reference"
    Then Third-party Information tab is loaded
    When User saves Media-Check Risk Remediation record "Third-party Associated Party Individual Reference_URL" URL in context
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    And User clicks on Media Check Risk Remediation record "Third-party Associated Party Individual Other Names Reference"
    Then Third-party Information tab is loaded
    When User saves Media-Check Risk Remediation record "Third-party Associated Party Individual Other Names Reference_URL" URL in context
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    And User clicks on Media Check Risk Remediation record "Third-party Associated Party Organisation Reference"
    Then Third-party Information tab is loaded
    When User saves Media-Check Risk Remediation record "Third-party Associated Party Organisation Reference_URL" URL in context
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    And User clicks on Media Check Risk Remediation record "Third-party Associated Party Organisation Other Names Reference"
    Then Third-party Information tab is loaded
    When User saves Media-Check Risk Remediation record "Third-party Associated Party Organisation Other Names Reference_URL" URL in context
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
#    When User opens World-Check Screening records link "Third-party Associated Party Individual Reference_URL"
#    Then Current URL contains "/forbidden" endpoint
#    When User opens World-Check Screening records link "Third-party Associated Party Individual Other Names Reference_URL"
#    Then Current URL contains "/forbidden" endpoint
#    When User opens World-Check Screening records link "Third-party Associated Party Organization Reference_URL"
#    Then Current URL contains "/forbidden" endpoint
#    When User opens World-Check Screening records link "Third-party Associated Party Organization Other Names Reference_URL"
#    Then Current URL contains "/forbidden" endpoint
