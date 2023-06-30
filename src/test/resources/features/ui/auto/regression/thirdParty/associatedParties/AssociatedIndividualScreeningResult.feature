@ui @full_regression @wcScreening
Feature: Associated Individual Screening Result

  As a SI user,
  I want an ability to add a comment when changing resolution type.
  So that the comment will be stored and send back to WC1.

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Individual" "Barac Obama" via API and open it
    And Screening results table is loaded

  @C37072684
  Scenario: C37072684: Third-party Associated Individual - Screening Result - Mark record as Positive - Verify Resolution Type Modal
    When User clicks resolve "World-Check" screening record for "contact" on position 1 on main screening list as "POSITIVE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSITIVE        |
      | Risk Level      |
      | Reason          |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    When User clicks "Cancel" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution is not changed for "World-Check" "contact" screening results

  @C37072685
  Scenario: C37072685: Third-party Associated Individual - Screening Result - Mark record as Possible - Save Comment with more than 900 characters
    When User clicks resolve "World-Check" screening record for "contact" on position 1 on main screening list as "POSSIBLE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSSIBLE        |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tinsss."
    When User turns off 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Partial Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution

  @C37072687
  Scenario Outline: C37072687: Third-party Associated Individual [2 cases] - Screening Result - Select Record - Mark as Positive - With Comment
    When User clicks resolve "World-Check" screening record for "contact" on position 1 on main screening list as "POSITIVE" resolution
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
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    When User clicks on 1 number screening record
    Then Contact Screening result profile details is displayed
    And Comment profile section contains expected text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    Examples:
      | turnOption |
      | on         |
      | off        |

  @C37072689
  Scenario Outline: C37072689: Third-party Associated Individual [2 cases] - Screening Result - Select Record - Mark as False - With Comment
    When User selects screening record for "contact" on position 1
    And User selects screening record for "contact" on position 2
    And User selects screening record for "contact" on position 3
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "False" resolution type menu option
    Then Add Comment modal is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    When User clicks last page icon
    Then Screening record under number 1 appears in the main screening table with "FALSE" resolution
    And Screening record under number 2 appears in the main screening table with "FALSE" resolution
    And Screening record under number 3 appears in the main screening table with "FALSE" resolution
    Examples:
      | turnOption |
      | on         |
      | off        |
