@ui @sanity @wc1 @screening_result @other_names @multilanguage
Feature: Third-party Other Name Screening Results

  As a SI user,
  I want an ability to change the resolution type.
  So that I can manage the results.

  Background:
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User creates third-party "with random ID name" via API and open it
    And User creates Other name "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH"
    And User opens screening results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" Other name
    Then Sorted search "World-Check" results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" "supplier" appear in other names screening table for current page

  @C37072672
  Scenario Outline: C37072672: Third-party Other Name [2 cases] - Screening Result - Mark record as Possible-With Comment
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "POSSIBLE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | ThirdPartyInformation.screening.columnResolution |
      | POSSIBLE                                         |
      | thirdPartyInformation.screening.comment          |
      | thirdPartyInformation.screening.tagAsRedFlag     |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    When User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 1 does not appear in the other name screening table
    When User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    Examples:
      | comment                         | turnOption |
      | Mark record as Possible comment | on         |
      | Mark record as Possible comment | off        |

  @C37072673
  Scenario Outline: C37072673: Third-party Other Name [2 cases] - Screening Result - Mark record as False -With Comment
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "FALSE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | ThirdPartyInformation.screening.columnResolution |
      | FALSE                                            |
      | thirdPartyInformation.screening.comment          |
      | thirdPartyInformation.screening.tagAsRedFlag     |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    When User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    When User clicks Close Other Name Results button
    Then Screening record under number 1 does not appear in the main screening table
    Examples:
      | comment                      | turnOption |
      | Mark record as FALSE comment | on         |
      |                              | off        |

  @C37072675
  Scenario Outline: C37072675: Third-party Other Name [2 cases] - Screening Result - Mark multiple records as Possible
    When User selects Other Name screening record for "supplier" on position 1
    And User selects Other Name screening record for "supplier" on position 2
    And User selects Other Name screening record for "supplier" on position 3
    And User clicks on "Resolve As" Other name screening element
    Then Resolution menu is displayed with options
      | thirdPartyInformation.screening.positive   |
      | thirdPartyInformation.screening.possible   |
      | thirdPartyInformation.screening.false      |
      | thirdPartyInformation.screening.unresolved |
    And Cancel resolution button is displayed
    When User clicks "thirdPartyInformation.screening.possible" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Other name screening record under number 1 does not appear in the other name screening table
    And Other name screening record under number 2 does not appear in the other name screening table
    And Other name screening record under number 3 does not appear in the other name screening table
    When User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 2 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 3 appears in the main screening table with "POSSIBLE" resolution
    Examples:
      | comment                                   | turnOption |
      | Mark multiply records as POSSIBLE comment | on         |
      | There is some comment                     | off        |

  @C37072678
  Scenario Outline: C37072678: Third-party Other Name [2 cases] - Screening Result - Mark all records (in current page) as Possible
    When User clicks on "Select All" Other name screening element
    And User clicks on "Resolve As" Other name screening element
    Then Resolution menu is displayed with options
      | thirdPartyInformation.screening.positive   |
      | thirdPartyInformation.screening.possible   |
      | thirdPartyInformation.screening.false      |
      | thirdPartyInformation.screening.unresolved |
    And Cancel resolution button is displayed
    When User clicks "thirdPartyInformation.screening.possible" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks Close Other Name Results button
    Then Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" other name positive or possible resolved results
    Examples:
      | comment                              | turnOption |
      | Mark all records as POSSIBLE comment | on         |
      |                                      | off        |

  @C37072679
  Scenario Outline: C37072679: Third-party Other Name [2 cases] - Screening Result - Mark all records (in current page) as False
    When User clicks on "Select All" Other name screening element
    And User clicks on "Resolve As" Other name screening element
    Then Resolution menu is displayed with options
      | thirdPartyInformation.screening.positive   |
      | thirdPartyInformation.screening.possible   |
      | thirdPartyInformation.screening.false      |
      | thirdPartyInformation.screening.unresolved |
    And Cancel resolution button is displayed
    When User clicks "thirdPartyInformation.screening.false" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Sorted search "World-Check" results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    Then Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" other name positive or possible resolved results
    Examples:
      | comment                           | turnOption |
      | Mark all records as FALSE comment | on         |
      |                                   | off        |