@ui @full_regression @wcScreening
Feature: Third-party Screening Result

  As a SI user,
  I want an ability to add a comment when changing resolution type.
  So that the comment will be stored and send back to WC1.

  Background:
    Given User logs into RDDC as "Admin"

  @C37072663
  Scenario: C37072663: Third-party - Screening Result - Mark record as Positive - Verify Resolution Type Modal
    When User creates third-party "with random ID name" via API and open it
    And User changes Search Criteria "Search Term" with value "CLOUD TECHNOLOGY Solution"
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSITIVE        |
      | Risk Level      |
      | Reason          |
      | Comment         |
      | Tag As Red Flag |
      | CANCEL          |
      | SAVE            |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    When User clicks "Cancel" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution is not changed for "World-Check" "supplier" screening results

  @C37072664
  Scenario: C37072664: Third-party - Screening Result - Mark record as Positive - Save Comment with more than 900 characters
    When User creates third-party "with random ID name" via API and open it
    And User changes Search Criteria "Search Term" with value "CLOUD TECHNOLOGY Solution"
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSITIVE        |
      | Risk Level      |
      | Reason          |
      | Comment         |
      | Tag As Red Flag |
      | CANCEL          |
      | SAVE            |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    When User turns on 'Tag as red flag'
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSITIVE" resolution

  @C37072666
  Scenario Outline: C37072666: Third-party [2 cases] - Screening Result - Mark multiple records as Possible - with Comment
    When User creates third-party "with random ID name" via API and open it
    And User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects screening record for "supplier" on position 1
    And User selects screening record for "supplier" on position 2
    And User selects screening record for "supplier" on position 3
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "Possible" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 2 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 3 appears in the main screening table with "POSSIBLE" resolution
    Examples:
      | turnOption |
      | on         |
      | off        |

  @C37072667
  Scenario Outline: C37072667: Third-party [2 cases] - Screening Result - Mark multiple records as False - with Comment
    When User creates third-party "with random ID name" via API and open it
    And User changes Search Criteria "Search Term" with value "Roshen"
    And User selects screening record for "supplier" on position 1
    And User selects screening record for "supplier" on position 2
    And User selects screening record for "supplier" on position 3
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "False" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "FALSE" resolution
    And Screening record under number 2 appears in the main screening table with "FALSE" resolution
    And Screening record under number 3 appears in the main screening table with "FALSE" resolution
    Examples:
      | turnOption |
      | on         |
      | off        |

  @C37072668
  Scenario Outline: C37072668: Third-party - Screening Result - Select Record - Mark as Positive - With Comment
    When User creates third-party "with random ID name" via API and open it
    And User changes Search Criteria "Search Term" with value "CLOUD TECHNOLOGY Solution"
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSITIVE        |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    When User turns <turnOption> 'Tag as red flag'
    And User selects "Low" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    Examples:
      | turnOption |
      | on         |
      | off        |

  @C37072669
  Scenario Outline: C37072669 : Third-party [2 cases] - Screening Result - Select Record - Mark as Possible - With Comment
    When User creates third-party "with random ID name" via API and open it
    And User changes Search Criteria "Search Term" with value "CLOUD TECHNOLOGY Solution"
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSSIBLE        |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    When User turns <turnOption> 'Tag as red flag'
    And User selects "Low" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    Examples:
      | turnOption |
      | on         |
      | off        |