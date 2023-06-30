@ui @sanity @wc1 @screening_result @other_names @multilanguage
Feature: Contact Other Name Screening Results

  As a SI user,
  I want an ability to change the resolution type.
  So that I can manage the results.

  Background:
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Individual" "with mandatory fields" via API and open it
    And User creates Other name "Barac Obama" for Associated Party
    Then Sorted search "World-Check" results for "Barac Obama" "contact" appear in other names screening table for current page

  @C37072690
  Scenario: C37072690: Associated Individual Other Name - Screening Result - Mark record as Positive - Save Comment with more than 900 characters
    When User clicks resolve Other Name screening record for "contact" under number 1 as "POSITIVE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | ThirdPartyInformation.screening.columnResolution |
      | POSITIVE                                         |
      | thirdPartyInformation.screening.comment          |
      | thirdPartyInformation.screening.tagAsRedFlag     |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin tin."
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 1 does not appear in the other name screening table
    When User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution

  @C37072691
  Scenario Outline: C37072691: Associated Individual Other Name [2 cases] - Screening Result - Mark record as Possible-With Comment
    When User clicks resolve Other Name screening record for "contact" under number 2 as "POSSIBLE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | ThirdPartyInformation.screening.columnResolution |
      | POSSIBLE                                         |
      | thirdPartyInformation.screening.comment          |
      | thirdPartyInformation.screening.tagAsRedFlag     |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 2 does not appear in the other name screening table
    When User clicks Close Other Name Results button
    Then Screening record under number 2 appears in the main screening table with "POSSIBLE" resolution
    Examples:
      | comment                         | turnOption |
      | Mark record as Possible comment | on         |
      | Mark record as Possible comment | off        |

  @C37072693
  Scenario Outline: C37072693: Associated Individual Other Name [2 cases] - Screening Result - Mark multiple records as Positive - with Comment
    When User selects Other Name screening record for "contact" on position 1
    And User selects Other Name screening record for "contact" on position 2
    And User selects Other Name screening record for "contact" on position 3
    And User clicks on "Resolve As" Other name screening element
    Then Resolution menu is displayed with options
      | thirdPartyInformation.screening.positive   |
      | thirdPartyInformation.screening.possible   |
      | thirdPartyInformation.screening.false      |
      | thirdPartyInformation.screening.unresolved |
    And Cancel resolution button is displayed
    When User clicks "thirdPartyInformation.screening.positive" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Other name screening record under number 1 does not appear in the other name screening table
    And Other name screening record under number 2 does not appear in the other name screening table
    And Other name screening record under number 3 does not appear in the other name screening table
    When User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 2 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 3 appears in the main screening table with "POSITIVE" resolution
    Examples:
      | comment                                   | turnOption |
      | Mark multiply records as POSITIVE comment | on         |
      | Mark multiply records as POSITIVE comment | off        |

  @C37072694
  Scenario Outline: C37072694: Associated Individual Other Name  [2 cases] - Screening Result - Mark all records (in current page) as Positive
    When User clicks on "Select All" Other name screening element
    And User clicks on "Resolve As" Other name screening element
    Then Resolution menu is displayed with options
      | thirdPartyInformation.screening.positive   |
      | thirdPartyInformation.screening.possible   |
      | thirdPartyInformation.screening.false      |
      | thirdPartyInformation.screening.unresolved |
    And Cancel resolution button is displayed
    When User clicks "thirdPartyInformation.screening.positive" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Low" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks Close Other Name Results button
    Then Sorted search "World-Check" results for "contact" appear in main screening table for current page with "Barac Obama" other name positive or possible resolved results
    Examples:
      | comment                              | turnOption |
      | Mark all records as POSITIVE comment | on         |
      | Mark all records as POSITIVE comment | off        |

  @C37072697
  Scenario: C37072697: Contact Other Name - Screening Result - Select Record - Mark as False - Without Comment
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 1 record as "FALSE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | ThirdPartyInformation.screening.columnResolution |
      | FALSE                                            |
      | thirdPartyInformation.screening.comment          |
      | thirdPartyInformation.screening.tagAsRedFlag     |
    And Profile Add Comment modal "Cancel" button is displayed
    And Profile Add Comment modal "Add Reviewer" button is displayed
    And Profile Add Comment modal "Save" button is displayed
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Comment profile section is not displayed
    When User clicks on the "Back To Screening Results Button" screening profile
    And User clicks Close Other Name Results button
    Then Screening record under number 1 does not appear in the main screening table
