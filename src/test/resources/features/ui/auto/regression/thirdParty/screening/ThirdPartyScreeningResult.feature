@ui @sanity @wc1 @screening_result @suppliers @multilanguage
Feature: Third-party Screening Result

  As a SI user,
  I want an ability to add a comment when changing resolution type.
  So that the comment will be stored and send back to WC1.

  Background:
    Given User logs into RDDC as "Admin"
    When User sets up language via API

  @C37072665
  Scenario Outline: C37072665: Third-party [2 cases] - Screening Result - Mark multiple records as Positive - With Comment
    When User creates third-party "with random ID name" via API and open it
    And User changes Search Criteria "thirdPartyInformation.screening.searchTerm" with value "China"
    And User selects screening record for "supplier" on position 1
    And User selects screening record for "supplier" on position 2
    And User selects screening record for "supplier" on position 3
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | thirdPartyInformation.screening.positive   |
      | thirdPartyInformation.screening.possible   |
      | thirdPartyInformation.screening.false      |
      | thirdPartyInformation.screening.unresolved |
    And Cancel resolution button is displayed
    When User clicks "thirdPartyInformation.screening.positive" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Full Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 2 appears in the main screening table with "POSITIVE" resolution
    And Screening record under number 3 appears in the main screening table with "POSITIVE" resolution
    Examples:
      | turnOption |
      | on         |
      | off        |

  @C37072670
  Scenario Outline: C37072670 : Third-party [2 cases] - Screening Result - Select Record - Mark as False - With Comment
    When User creates third-party "with random ID name" via API and open it
    And User changes Search Criteria "thirdPartyInformation.screening.searchTerm" with value "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED"
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "FALSE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | ThirdPartyInformation.screening.columnResolution |
      | thirdPartyInformation.screening.comment          |
      | thirdPartyInformation.screening.tagAsRedFlag     |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    When User turns <turnOption> 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "FALSE" resolution
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    Examples:
      | turnOption |
      | on         |
      | off        |

  @C37072701
  Scenario: C37072701: WC- Screening Result - Change the Third-party name and Verify the result in SI and WC1
    When User creates third-party "USG"
    Then Sorted search "World-Check" results for "supplier" appear in main screening table for current page
    And WC1 case contains "USG" "supplier" name
    When User clicks General and Other Information section "Edit" button
    And User updates General Information section with values
      | Name |
      | DHL  |
    And User clicks General and Other Information section "Save" button
    Then Sorted search "World-Check" results for "supplier" appear in main screening table for current page
    And WC1 case contains "DHL" "supplier" name