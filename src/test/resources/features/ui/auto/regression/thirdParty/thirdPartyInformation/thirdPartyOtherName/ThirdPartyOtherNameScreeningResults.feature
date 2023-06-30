@ui @full_regression @wcScreening
Feature: Third-party Other Name Screening Results

  As a SI user,
  I want an ability to change the resolution type.
  So that I can manage the results.

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User creates Other name "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH"
    And User opens screening results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" Other name
    Then Sorted search "World-Check" results for "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" "supplier" appear in other names screening table for current page

  @C37072671
  Scenario: C37072671: Third-party Other Name - Screening Result - Mark record as Positive-With Comment
    When User clicks resolve Other Name screening record for "supplier" under number 1 as "POSITIVE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSITIVE        |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    When User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 1 does not appear in the other name screening table
    When User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution

  @C37072674
  Scenario Outline: C37072674: Third-party Other Name [2 cases] - Screening Result - Mark multiple records as Positive - With Comment
    When User selects Other Name screening record for "supplier" on position 1
    And User selects Other Name screening record for "supplier" on position 2
    And User selects Other Name screening record for "supplier" on position 3
    And User clicks on "Resolve As" Other name screening element
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "Positive" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User selects "High" Risk Level
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

  @C37072676
  Scenario Outline: C37072676: Third-party Other Name [2 cases] - Screening Result - Mark multiple records as False
    When User selects Other Name screening record for "supplier" on position 1
    And User selects Other Name screening record for "supplier" on position 2
    And User selects Other Name screening record for "supplier" on position 3
    And User clicks on "Resolve As" Other name screening element
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "False" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    And Other name screening record under number 2 appears in the other name screening table with "FALSE" resolution
    And Other name screening record under number 3 appears in the other name screening table with "FALSE" resolution
    When User clicks Close Other Name Results button
    Then Screening record under number 1 does not appear in the main screening table
    And Screening record under number 2 does not appear in the main screening table
    And Screening record under number 3 does not appear in the main screening table
    Examples:
      | comment                                | turnOption |
      | Mark multiply records as FALSE comment | on         |
      | Mark multiply records as FALSE comment | off        |

  @C37072677
  Scenario Outline: C37072677: Third-party Other Name [2 cases] - Screening Result - Mark all records (in current page) as Positive
    When User clicks on "Select All" Other name screening element
    And User clicks on "Resolve As" Other name screening element
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "Positive" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    And User clicks Close Other Name Results button
    Then Sorted search "World-Check" results for "supplier" appear in main screening table for current page with "CHINA CONSTRUCTION BANK CORPORATION DALIAN BRANCH" other name positive or possible resolved results
    Examples:
      | comment                              | turnOption |
      | Mark all records as POSITIVE comment | on         |
      | Mark all records as POSITIVE comment | off        |

  @C37072680
  Scenario: C37072680: Third-party Other Name - Screening Result - Select Record - Mark as Positive
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 1 record as "POSITIVE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSITIVE        |
      | Comment         |
      | Tag As Red Flag |
    And Profile Add Comment modal "Cancel" button is displayed
    And Profile Add Comment modal "Add Reviewer" button is displayed
    And Profile Add Comment modal "Save" button is displayed
    When User fills in comment "Mark record from profile as POSITIVE comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Comment profile section contains expected text "Mark record from profile as POSITIVE comment"
    When User clicks on the "Back To Screening Results Button" screening profile
    And User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution

  @C37072681
  Scenario: C37072681: Third-party Other Name - Screening Result - Select Record - Mark as Possible
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 1 record as "POSSIBLE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSSIBLE        |
      | Comment         |
      | Tag As Red Flag |
    And Profile Add Comment modal "Cancel" button is displayed
    And Profile Add Comment modal "Add Reviewer" button is displayed
    And Profile Add Comment modal "Save" button is displayed
    When User fills in comment "Mark record from profile as POSSIBLE comment"
    And User turns on 'Tag as red flag'
    And User selects "Low" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Comment profile section contains expected text "Mark record from profile as POSSIBLE comment"
    When User clicks on the "Back To Screening Results Button" screening profile
    And User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution

  @C37072683
  Scenario: C37072683: Third-party Other Name [2 cases] - Screening Result - Select Record - Mark as False - With comment
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 1 record as "FALSE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | FALSE           |
      | Comment         |
      | Tag As Red Flag |
    And Profile Add Comment modal "Cancel" button is displayed
    And Profile Add Comment modal "Add Reviewer" button is displayed
    And Profile Add Comment modal "Save" button is displayed
    And User fills in comment "Mark record from profile as FALSE comment"
    When User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Comment profile section contains expected text "Mark record from profile as FALSE comment"
    When User clicks on the "Back To Screening Results Button" screening profile
    And User clicks Close Other Name Results button
    Then Screening record under number 1 does not appear in the main screening table

  @C37072683
  Scenario: C37072683: Third-party Other Name [2 cases] - Screening Result - Select Record - Mark as False - Without comment
    When User clicks on 1 number Other name screening record
    And Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 1 record as "FALSE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | FALSE           |
      | Comment         |
      | Tag As Red Flag |
    And Profile Add Comment modal "Cancel" button is displayed
    And Profile Add Comment modal "Add Reviewer" button is displayed
    And Profile Add Comment modal "Save" button is displayed
    When User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Comment profile section is not displayed
    When User clicks on the "Back To Screening Results Button" screening profile
    And User clicks Close Other Name Results button
    Then Screening record under number 1 does not appear in the main screening table
