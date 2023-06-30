@ui @sanity @wc1 @screening_result @contacts @multilanguage
Feature: Contact Screening Result

  As a SI user,
  I want an ability to add a comment when changing resolution type.
  So that the comment will be stored and send back to WC1.

  Background:
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Individual" "Barac Obama" via API and open it
    And Screening results table is loaded

  @C37072686
  Scenario Outline: C37072686: Third-party Contact [2 cases] - Screening Result - Mark multiple records as Positive - With Comment
    When User selects screening record for "contact" on position 1
    And User selects screening record for "contact" on position 2
    And User selects screening record for "contact" on position 3
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | thirdPartyInformation.screening.positive   |
      | thirdPartyInformation.screening.possible   |
      | thirdPartyInformation.screening.false      |
      | thirdPartyInformation.screening.unresolved |
    And Cancel resolution button is displayed
    When User clicks "thirdPartyInformation.screening.positive" resolution type menu option
    Then Add Comment modal is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    And User turns <turnOption> 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 2 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 3 appears in the main screening table with "POSITIVE" resolution
    Examples:
      | turnOption |
      | on         |
      | off        |

  @C37072688
  Scenario Outline: C37072688: Third-party Contact [2 cases] - Screening Result - Select Record - Mark as Possible - With Comment
    When User selects screening record for "contact" on position 1
    And User selects screening record for "contact" on position 2
    And User selects screening record for "contact" on position 3
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | thirdPartyInformation.screening.positive   |
      | thirdPartyInformation.screening.possible   |
      | thirdPartyInformation.screening.false      |
      | thirdPartyInformation.screening.unresolved |
    And Cancel resolution button is displayed
    When User clicks "thirdPartyInformation.screening.possible" resolution type menu option
    Then Add Comment modal is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 2 appears in the main screening table with "POSSIBLE" resolution
    And Screening record under number 3 appears in the main screening table with "POSSIBLE" resolution
    Examples:
      | turnOption |
      | on         |
      | off        |