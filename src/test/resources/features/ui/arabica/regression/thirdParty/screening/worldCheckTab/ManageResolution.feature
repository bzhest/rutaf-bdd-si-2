@ui @full_regression @wcScreening @arabica
Feature: Third-party Screening Result

  As a RDDC user,
  I want an ability to add a comment when changing resolution type.
  So that the comment will be stored and send back to WC1.

  Background:
    Given User logs into RDDC as "Admin"

  @C38383076
  Scenario Outline: C38383076: Third-party - Screening Result - Mark record as False - Save Comment with more than 900 characters
    When User creates third-party "with random ID name"
    And User changes Search Criteria "Search Term" with value "CLOUD TECHNOLOGY Solution"
    And User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "<resolutionOption>" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    When User fills random Risk Level and Reason
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tinsss."
    And User turns off 'Tag as red flag'
    And User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOption>" resolution
    Examples:
      | resolutionOption |
      | FALSE            |