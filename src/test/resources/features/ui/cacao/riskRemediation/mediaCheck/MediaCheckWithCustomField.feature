@ui @cacao @functional @risk_remediation @media_check
Feature: Risk Management tab - Verify Media Check Screening Tab

  Background:
    Given User logs into RDDC as "Admin"
    When User creates Custom Field "active with description and 10 options red flag true and SingleSelect type" via API
    And User remembers created Custom field 1 in context
    And User creates Custom Field "active Multi Select type" via API
    And User remembers created Custom field 2 in context
    And User creates third-party "APPLE INVESTMENT COMPANY" via API and open it
    And User expands "Other Information" section
    And User clicks General and Other Information section "Edit" button
    And User expands "Other Information" section
    And User selects "customFieldNameNumber1" custom field value "1"
    And User selects "customFieldNameNumber2" custom field value "2"
    And User clicks General and Other Information section "Save" button
    Then Save button is disappeared
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    And User clicks on Check Type "Media Check"
    And User clicks Search On Search criteria button

  @C43563925
  @onlySingleThread
  Scenario: C43563925: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data absent (Third Party)
    #  Third-party
    When User clicks on "MEDIA CHECK" tab
    And User selects Third-party Media Check screening record on position 1
    And User remembers Third-party Reference Media Check context selection
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C43563925
  @onlySingleThread
  Scenario: C43563925: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data absent (Third Party Other Names)
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
    When User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C43563925
  @onlySingleThread
  Scenario: C43563925: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data absent (Third-party Associated Party Individual)
    #  Third-party Associated Party Individual
    When User creates Associated Party "Individual" "Barac Obama" via API and open it
    And User clicks on "MEDIA CHECK" tab
    And User selects Associated Party Individual Media Check screening record on position 1
    And User remembers Third-party Associated Party Individual Reference1 Media Check context selection
    And User selects risk level as "HIGH"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Screening results table is loaded
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C43563925
  @onlySingleThread
  Scenario: C43563925: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data absent (Third-party Associated Party Individual Other Names)
    #  Third-party Associated Party Individual Other Names
    When User creates Associated Party "Individual" "John SMITH" via API and open it
    And User creates Other name "Barac Obama" for Associated Party
    And User clicks on "MEDIA CHECK" other name screening tab
    Then "MEDIA CHECK" other name tab is selected
    When User selects Media Check Associated Party Individual Other Names screening record on position 2
    And User remembers Third-party Associated Party Individual Other Names Reference2 Media Check context selection
    And User selects risk level as "MEDIUM"
    And User clicks attach button
    Then Media Check attach modal is displayed
    When User clicks "SAVE" Media Check Attach modal button
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C43563925
  @onlySingleThread
  Scenario: C43563925: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data absent (Third-party Associated Party Organisation)
     #   Third-party Associated Party Organization
    When User creates Associated Party "Organisation" "Dell" via API and open it
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
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Media Check Screening" tab
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C43563925
  @onlySingleThread
  Scenario: C43563925: [Risk Remediation] - Risk Management tab - Verify Media Check Screening Tab - Data absent (Third-party Associated Party Organisation Other Names)
    # Third-party Associated Party Organization Other Names
    When User creates Associated Party "Organisation" "Dell" via API and open it
    And User clicks on "WORLD-CHECK" tab
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
    Then Risk Management Risk Remediation section message "NO AVAILABLE DATA" is displayed if table is empty

  @C44070679
  @onlySingleThread
  Scenario: C44070679: [Risk Remediation] - Risk Management tab - Verify Custom Fields Tab - Data present - New Custom Fields are added in Set Up
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Custom Fields" tab
    Then Risk Remediation Custom Fields table is displayed with columns
      | CUSTOM FIELD |
      | VALUE        |
    And Risk Remediation Custom Fields table is displayed with next details
      | CUSTOM FIELD           | VALUE |
      | customFieldNameNumber1 | 1     |
      | customFieldNameNumber2 | 2     |
    When User clicks on Third-party Information tab
    And User clicks General and Other Information section "Edit" button
    And User expands "Other Information" section
    And User adds "3" value to "customFieldNameNumber2" custom field
    And User clicks General and Other Information section "Save" button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Custom Fields" tab
    Then Risk Remediation Custom Fields table is displayed with columns
      | CUSTOM FIELD |
      | VALUE        |
    And Risk Remediation Custom Fields table is displayed with next details
      | CUSTOM FIELD           | VALUE |
      | customFieldNameNumber1 | 1     |
      | customFieldNameNumber2 | 2, 3  |

  @C44070681
  @onlySingleThread
  Scenario: C44070681: [Risk Remediation] - Risk Management tab - Verify Custom Fields Tab - Data present - Changed reg flag are updated in the table
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Custom Fields" tab
    Then Risk Remediation Custom Fields table is displayed with columns
      | CUSTOM FIELD |
      | VALUE        |
    And Risk Remediation Custom Fields table is displayed with next details
      | CUSTOM FIELD           | VALUE |
      | customFieldNameNumber1 | 1     |
      | customFieldNameNumber2 | 2     |
    When User clicks on Third-party Information tab
    And User clicks General and Other Information section "Edit" button
    And User expands "Other Information" section
    And User adds "3" value to "customFieldNameNumber2" custom field
    And User clicks General and Other Information section "Save" button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Custom Fields" tab
    Then Risk Remediation Custom Fields table is displayed with columns
      | CUSTOM FIELD |
      | VALUE        |
    And Risk Remediation Custom Fields table is displayed with next details
      | CUSTOM FIELD           | VALUE |
      | customFieldNameNumber1 | 1     |
      | customFieldNameNumber2 | 2, 3  |
    When User navigates to Custom Fields page
    And User clicks Edit button for Custom Field "customFieldNameNumber2"
    And User untoggles Custom Field Red Flag option for Choice #3
    And User clicks Save button for Custom Field
    And User clicks Proceed button on confirmation window
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Custom Fields" tab
    Then Risk Remediation Custom Fields table is displayed with columns
      | CUSTOM FIELD |
      | VALUE        |
    And Risk Remediation Custom Fields table is displayed with next details
      | CUSTOM FIELD           | VALUE |
      | customFieldNameNumber1 | 1     |
      | customFieldNameNumber2 | 2     |

  @C45110488
  @onlySingleThread
  Scenario: C45110488: [Risk Remediation] - Risk Management tab - Verify Custom Fields Tab - Deleted Custom field
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Custom Fields" tab
    Then Risk Remediation Custom Fields table is displayed with columns
      | CUSTOM FIELD |
      | VALUE        |
    And Risk Remediation Custom Fields table is displayed with next details
      | CUSTOM FIELD           | VALUE |
      | customFieldNameNumber1 | 1     |
      | customFieldNameNumber2 | 2     |
    When User clicks on Third-party Information tab
    And User clicks General and Other Information section "Edit" button
    And User expands "Other Information" section
    And User adds "3" value to "customFieldNameNumber2" custom field
    And User clicks General and Other Information section "Save" button
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Custom Fields" tab
    Then Risk Remediation Custom Fields table is displayed with columns
      | CUSTOM FIELD |
      | VALUE        |
    And Risk Remediation Custom Fields table is displayed with next details
      | CUSTOM FIELD           | VALUE |
      | customFieldNameNumber1 | 1     |
      | customFieldNameNumber2 | 2, 3  |
    When User navigates to Custom Fields page
    And User clicks Delete button for Custom Field "customFieldNameNumber2"
    And User clicks Delete button on confirmation window
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Custom Fields" tab
    Then Risk Remediation Custom Fields table is displayed with columns
      | CUSTOM FIELD |
      | VALUE        |
    And Risk Remediation Custom Fields table is displayed with next details
      | CUSTOM FIELD           | VALUE |
      | customFieldNameNumber1 | 1     |

  @C45110488
  @onlySingleThread
  Scenario: C45110488: [Risk Remediation] - Risk Management tab - Verify Custom Fields Tab - Inactive Custom Field with marked Red Flags is not display in the tab
    When User clicks on Risk Management tab
    And User clicks Risk Remediation "Custom Fields" tab
    Then Risk Remediation Custom Fields table is displayed with columns
      | CUSTOM FIELD |
      | VALUE        |
    And Risk Remediation Custom Fields table is displayed with next details
      | CUSTOM FIELD           | VALUE |
      | customFieldNameNumber1 | 1     |
      | customFieldNameNumber2 | 2     |
    When User navigates to Custom Fields page
    And User clicks Edit button for Custom Field "customFieldNameNumber2"
    And User switches Active Custom Field checkbox Off
    And User clicks Save button for Custom Field
    And User clicks Proceed button on confirmation window
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks Risk Remediation "Custom Fields" tab
    Then Risk Remediation Custom Fields table is displayed with columns
      | CUSTOM FIELD |
      | VALUE        |
    And Risk Remediation Custom Fields table is displayed with next details
      | CUSTOM FIELD           | VALUE |
      | customFieldNameNumber1 | 1     |