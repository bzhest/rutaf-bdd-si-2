@ui @functional @wc1 @screening_result @suppliers
Feature: Third-party - Screening - World Check Tab - Manage Resolution

  As a SI user,
  I want an ability to add a comment when changing resolution type.
  So that the comment will be stored and send back to WC1.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"

  @C33162047
  Scenario: C33162047: Supplier - Screening Result - Mark record as Positive-without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSITIVE        |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    When User turns on 'Tag as red flag'
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                      |
      | Resolution type has been updated to positive. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Comment profile section is not displayed

  @C33162238
  Scenario: C33162238: Supplier - Screening Result - Mark record as Possible-Without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSSIBLE        |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    When User turns on 'Tag as red flag'
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                      |
      | Resolution type has been updated to possible. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Comment profile section is not displayed

  @C33162242
  Scenario: C33162242: Supplier - Screening Result - Mark record as False-Without Comment
    Given User changes Search Criteria "Search Term" with value "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED"
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "FALSE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | FALSE           |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    When User turns on 'Tag as red flag'
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                   |
      | Resolution type has been updated to false. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "FALSE" resolution
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Comment profile section is not displayed

  @C33150645
  Scenario: C33150645: Supplier - Screening Result - Mark record as Positive - With Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed"
    When User turns on 'Tag as red flag'
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                      |
      | Resolution type has been updated to positive. |
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed"

  @C33162237
  Scenario: C33162237: Supplier - Screening Result - Mark record as Possible-With Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed"
    When User turns on 'Tag as red flag'
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                      |
      | Resolution type has been updated to possible. |
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed"

  @C33162241
  Scenario: C33162241: Supplier - Screening Result - Mark record as False - With Comment
    Given User changes Search Criteria "Search Term" with value "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED"
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "FALSE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed"
    When User turns on 'Tag as red flag'
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                   |
      | Resolution type has been updated to false. |
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "FALSE" resolution
    When User clicks on 1 number screening record
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed"

  @C33162048
  Scenario: C33162048: Supplier - Screening Result - Mark record as Positive - Cancel Save with Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    And User turns off 'Tag as red flag'
    When User clicks "Cancel" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution is not changed for "World-Check" "supplier" screening results

  @C33162239
  Scenario: C33162239: Supplier - Screening Result - Mark record as Possible - Cancel Add Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSSIBLE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tin."
    And User turns off 'Tag as red flag'
    When User clicks "Cancel" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution is not changed for "World-Check" "supplier" screening results

  @C33422530
  Scenario: C33422530: Supplier - Screening Results - Change Search Criteria With Flagged Multiple Resolution Type
    Given User changes Search Criteria "Search Term" with value "CHINA CONSTRUCTION BANK (ASIA) CORPORATION LIMITED"
    And User marks "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE"
    And Screening record under number 1 appears in the main screening table with "POSITIVE" resolution
    And User marks "World-Check" screening record for "supplier" on position 2 on main screening list as "POSSIBLE"
    And Screening record under number 2 appears in the main screening table with "POSSIBLE" resolution
    And User marks "World-Check" screening record for "supplier" on position 3 on main screening list as "FALSE"
    And Screening record under number 3 appears in the main screening table with "FALSE" resolution
    When User changes Search Criteria "Search Term" with value "PETROCHEMICAL INDUSTRIES DEVELOPMENT MANAGEMENT COMPANY"
    Then Alert Icon is displayed with text
      | Success!                      |
      | Third-party has been updated. |
    And Sorted search "World-Check" results for "supplier" appear in main screening table for current page

  @C33162279 @C33162280
  Scenario Outline: C33162279, C33162280: Supplier - Screening Result - Mark all records as Positive - With/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    When User selects all screening results
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOption>" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Resolution type "<resolutionOption>" is selected for each record in the main screening table
    Examples:
      | turnOption | resolutionOption | alertText | comment                                                                                                              |
      | on         | POSITIVE         | positive  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | off        | POSITIVE         | positive  |                                                                                                                      |

  @C33162283 @C33162284
  Scenario Outline: C33162283, C33162284: Supplier - Screening Result - Mark all records as Possible - With/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    When User selects all screening results
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOption>" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Resolution type "<resolutionOption>" is selected for each record in the main screening table
    Examples:
      | turnOption | resolutionOption | alertText | comment                                                                                                              |
      | on         | POSSIBLE         | possible  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | on         | POSSIBLE         | possible  |                                                                                                                      |

  @C33162283 @C33162284
  Scenario Outline: C33162283, C33162284: Supplier - Screening Result - Mark all records as False - With/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    When User selects all screening results
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOption>" resolution type menu option
    Then Add Comment modal is displayed
    When User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Resolution type "<resolutionOption>" is selected for each record in the main screening table
    Examples:
      | turnOption | resolutionOption | alertText | comment                                                                                                              |
      | on         | POSSIBLE         | possible  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | on         | POSSIBLE         | possible  |                                                                                                                      |
      | on         | FALSE            | false     | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | on         | FALSE            | false     |                                                                                                                      |

  @C33162243 @C33162244
  Scenario Outline: C33162243, C33162244: Supplier - Screening Result - Update Positive record to Possible-With/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "POSITIVE" with empty comment
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "<toResolutionOption>" resolution
    And User fills random Risk Level and Reason
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<toResolutionOption>" resolution
    Examples:
      | turnOption | toResolutionOption | alertText | comment                                                                                                              |
      | on         | POSSIBLE           | possible  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | off        | POSSIBLE           | possible  |                                                                                                                      |

  @C33162245 @C33162246
  Scenario Outline: C33162245, C33162246: Supplier - Screening Result - Update Positive record to False-With/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "POSITIVE" with empty comment
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "<toResolutionOption>" resolution
    And User fills random Risk Level and Reason
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<toResolutionOption>" resolution
    Examples:
      | turnOption | toResolutionOption | alertText | comment                                                                                                              |
      | on         | FALSE              | false     | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | off        | FALSE              | false     |                                                                                                                      |

  @C33162247 @C33162252 @C33162257
  Scenario Outline: C33162247, C33162252, C33162257: Supplier - Screening Result - Deselect Positive, Possible, False records
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    When User resolves selected records as "<resolutionOption>" with "<comment>" comment
    And Screening results table is loaded
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "<resolutionOption>" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | UNSPECIFIED     |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    When User turns on 'Tag as red flag'
    And User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                         |
      | Resolution type has been removed |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "UNRESOLVED" resolution
    Examples:
      | resolutionOption | comment                      |
      | POSITIVE         | All Resolution Type Positive |
      | POSSIBLE         | All Resolution Type POSSIBLE |
      | FALSE            | All Resolution Type FALSE    |

  @C33162258 @C33162259
  Scenario Outline: C33162258, C33162259: Supplier - Screening Result - Mark multiple records as Positive - With/without Comment
    Given User changes Search Criteria "Search Term" with value "IMPACT TECHNOLOGY GROUP"
    When User selects screening record for "supplier" on position 1
    And User selects screening record for "supplier" on position 2
    And User selects screening record for "supplier" on position 3
    When User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOption>" resolution type menu option
    Then Add Comment modal is displayed
    And User fills random Risk Level and Reason
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    When User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOption>" resolution
    And Screening record under number 2 appears in the main screening table with "<resolutionOption>" resolution
    And Screening record under number 3 appears in the main screening table with "<resolutionOption>" resolution
    Examples:
      | turnOption | resolutionOption | alertText | comment                                                                                                              |
      | on         | POSITIVE         | positive  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | off        | POSITIVE         | positive  |                                                                                                                      |

  @C33162260 @C33162261
  Scenario Outline: C33162260, C33162261: Supplier - Screening Result - Mark multiple records as Possible - with/without Comment
    Given User changes Search Criteria "Search Term" with value "IMPACT TECHNOLOGY GROUP"
    When User selects screening record for "supplier" on position 1
    And User selects screening record for "supplier" on position 2
    And User selects screening record for "supplier" on position 3
    When User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOption>" resolution type menu option
    Then Add Comment modal is displayed
    And User fills random Risk Level and Reason
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    When User clicks "Save" Add Comment modal button
#    Then Alert Icon is displayed with text
#      | Success!                                         |
#      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOption>" resolution
    And Screening record under number 2 appears in the main screening table with "<resolutionOption>" resolution
    And Screening record under number 3 appears in the main screening table with "<resolutionOption>" resolution
    Examples:
      | turnOption | resolutionOption | alertText | comment                                                                                                              |
      | off        | POSSIBLE         | possible  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | on         | POSSIBLE         | possible  |                                                                                                                      |

  @C33162262 @C33162263
  Scenario Outline: C33162262, C33162263: Supplier - Screening Result - Mark multiple records as False - with/without Comment
    Given User changes Search Criteria "Search Term" with value "IMPACT TECHNOLOGY GROUP"
    When User selects screening record for "supplier" on position 1
    And User selects screening record for "supplier" on position 2
    And User selects screening record for "supplier" on position 3
    When User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOption>" resolution type menu option
    Then Add Comment modal is displayed
    And User fills random Risk Level and Reason
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    When User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOption>" resolution
    And Screening record under number 2 appears in the main screening table with "<resolutionOption>" resolution
    And Screening record under number 3 appears in the main screening table with "<resolutionOption>" resolution
    Examples:
      | turnOption | resolutionOption | alertText | comment                                                                                                              |
      | on         | FALSE            | false     | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | off        | FALSE            | false     |                                                                                                                      |

  @C33162248 @C33162249
  Scenario Outline: C33162248, C33162249: Supplier - Screening Result - Update Possible record to Positive-With/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "<resolutionOptionTo>" resolution
    And User fills random Risk Level and Reason
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOptionTo>" resolution
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | off        | POSSIBLE             | POSITIVE           | positive  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | on         | POSSIBLE             | POSITIVE           | positive  |                                                                                                                      |

  @C33162250 @C33162251
  Scenario Outline: C33162250, C33162251: Supplier - Screening Result - Update Possible record to False-With/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "<resolutionOptionTo>" resolution
    And User fills random Risk Level and Reason
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOptionTo>" resolution
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | on         | POSSIBLE             | FALSE              | false     | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | off        | POSSIBLE             | FALSE              | false     |                                                                                                                      |

  @C33162253 @C33162254
  Scenario Outline: C33162253, C33162254: Supplier - Screening Result - Update False record to Positive-With/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "<resolutionOptionTo>" resolution
    And User fills random Risk Level and Reason
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOptionTo>" resolution
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | on         | FALSE                | POSITIVE           | positive  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | off        | FALSE                | POSITIVE           | positive  |                                                                                                                      |

  @C33162255 @C33162256
  Scenario Outline: C33162255, C33162256: Supplier - Screening Result - Update False record to Possible - with/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "<resolutionOptionTo>" resolution
    And User fills random Risk Level and Reason
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOptionTo>" resolution
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | off        | FALSE                | POSSIBLE           | possible  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | on         | FALSE                | POSSIBLE           | possible  |                                                                                                                      |

  @C33162264 @C33162265
  Scenario Outline: C33162264, C33162265: Supplier - Screening Result - Update multiple Positive records to Possible - with/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    When User selects screening record for "supplier" on position 1
    And User selects screening record for "supplier" on position 2
    And User selects screening record for "supplier" on position 3
    When User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOptionTo>" resolution type menu option
    Then Add Comment modal is displayed
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User fills random Risk Level and Reason
    When User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOptionTo>" resolution
    And Screening record under number 2 appears in the main screening table with "<resolutionOptionTo>" resolution
    And Screening record under number 3 appears in the main screening table with "<resolutionOptionTo>" resolution
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | on         | POSITIVE             | POSSIBLE           | possible  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | off        | POSITIVE             | POSSIBLE           | possible  |                                                                                                                      |

  @C33162266 @C33162267
  Scenario Outline: C33162266, C33162267: Supplier - Screening Result - Update multiple Positive records to False - with/without Comment
    Given User changes Search Criteria "Search Term" with value "IMPACT TECHNOLOGY GROUP"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    When User selects screening record for "supplier" on position 1
    And User selects screening record for "supplier" on position 2
    And User selects screening record for "supplier" on position 3
    When User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOptionTo>" resolution type menu option
    Then Add Comment modal is displayed
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User fills random Risk Level and Reason
    When User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOptionTo>" resolution
    And Screening record under number 2 appears in the main screening table with "<resolutionOptionTo>" resolution
    And Screening record under number 3 appears in the main screening table with "<resolutionOptionTo>" resolution
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | off        | POSITIVE             | FALSE              | false     | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | on         | POSITIVE             | FALSE              | false     |                                                                                                                      |

  @C33162269 @C33162270
  Scenario Outline: C33162269, C33162270: Supplier - Screening Result - Update multiple Possible records to Positive - With/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    When User selects screening record for "supplier" on position 1
    And User selects screening record for "supplier" on position 2
    And User selects screening record for "supplier" on position 3
    When User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOptionTo>" resolution type menu option
    Then Add Comment modal is displayed
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User fills random Risk Level and Reason
    When User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOptionTo>" resolution
    And Screening record under number 2 appears in the main screening table with "<resolutionOptionTo>" resolution
    And Screening record under number 3 appears in the main screening table with "<resolutionOptionTo>" resolution
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | on         | POSSIBLE             | POSITIVE           | positive  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | off        | POSSIBLE             | POSITIVE           | positive  |                                                                                                                      |

  @C33162271 @C33162272
  Scenario Outline: C33162271, C33162272: Supplier - Screening Result - Update multiple Possible records to False - With/without Comment
    Given User changes Search Criteria "Search Term" with value "IMPACT TECHNOLOGY GROUP"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    When User selects screening record for "supplier" on position 1
    And User selects screening record for "supplier" on position 2
    And User selects screening record for "supplier" on position 3
    When User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOptionTo>" resolution type menu option
    Then Add Comment modal is displayed
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User fills random Risk Level and Reason
    When User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOptionTo>" resolution
    And Screening record under number 2 appears in the main screening table with "<resolutionOptionTo>" resolution
    And Screening record under number 3 appears in the main screening table with "<resolutionOptionTo>" resolution
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | off        | POSSIBLE             | FALSE              | false     | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | on         | POSSIBLE             | FALSE              | false     |                                                                                                                      |

  @C33162274 @C33162275
  Scenario Outline: C33162274, C33162275: Supplier - Screening Result - Update multiple False records to Positive - With/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    When User selects screening record for "supplier" on position 1
    And User selects screening record for "supplier" on position 2
    And User selects screening record for "supplier" on position 3
    When User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOptionTo>" resolution type menu option
    Then Add Comment modal is displayed
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User fills random Risk Level and Reason
    When User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOptionTo>" resolution
    And Screening record under number 2 appears in the main screening table with "<resolutionOptionTo>" resolution
    And Screening record under number 3 appears in the main screening table with "<resolutionOptionTo>" resolution
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | on         | FALSE                | POSITIVE           | positive  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | off        | FALSE                | POSITIVE           | positive  |                                                                                                                      |

  @C33162276 @C33162277
  Scenario Outline: C33162276, C33162277: Supplier - Screening Result - Update multiple False records to Possible - With/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    When User selects screening record for "supplier" on position 1
    And User selects screening record for "supplier" on position 2
    And User selects screening record for "supplier" on position 3
    When User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOptionTo>" resolution type menu option
    Then Add Comment modal is displayed
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User fills random Risk Level and Reason
    When User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOptionTo>" resolution
    And Screening record under number 2 appears in the main screening table with "<resolutionOptionTo>" resolution
    And Screening record under number 3 appears in the main screening table with "<resolutionOptionTo>" resolution
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | off        | FALSE                | POSSIBLE           | possible  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | on         | FALSE                | POSSIBLE           | possible  |                                                                                                                      |

  @C33162268 @C33162273 @C33162278
  Scenario Outline: C33162268, C33162273, C33162278: Supplier - Screening Result - Update multiple Positive, Possible, False records to Unresolved
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOption>" with "All Resolution Type" comment
    And Screening results table is loaded
    When User selects screening record for "supplier" on position 1
    And User selects screening record for "supplier" on position 2
    And User selects screening record for "supplier" on position 3
    When User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "UNRESOLVED" resolution type menu option
    Then Add Comment modal is displayed
    When User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                         |
      | Resolution type has been removed |
    And Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "UNRESOLVED" resolution
    And Screening record under number 2 appears in the main screening table with "UNRESOLVED" resolution
    And Screening record under number 3 appears in the main screening table with "UNRESOLVED" resolution
    Examples:
      | resolutionOption |
      | POSITIVE         |
      | POSSIBLE         |
      | FALSE            |

  @C33162285 @C33162286
  Scenario Outline: C33162285, C33162286: Supplier - Screening Result - Update all Positive records to Possible - with/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    And User selects all screening results
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOptionTo>" resolution type menu option
    And User fills random Risk Level and Reason
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    When User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Resolution type "<resolutionOptionTo>" is selected for each record in the main screening table
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | on         | POSITIVE             | POSSIBLE           | possible  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | off        | POSITIVE             | POSSIBLE           | possible  |                                                                                                                      |

  @C33162287 @C33162288
  Scenario Outline: C33162287, C33162288: Supplier - Screening Result - Update all Positive records to False - with/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    And User selects all screening results
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOptionTo>" resolution type menu option
    And User fills random Risk Level and Reason
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    When User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Resolution type "<resolutionOptionTo>" is selected for each record in the main screening table
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | off        | POSITIVE             | POSSIBLE           | possible  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | on         | POSITIVE             | POSSIBLE           | possible  |                                                                                                                      |

  @C33162290 @C33162291
  Scenario Outline: C33162290, C33162291: Supplier - Screening Result - Update all Possible records to Positive - with/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    And User selects all screening results
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOptionTo>" resolution type menu option
    And User fills random Risk Level and Reason
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    When User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Resolution type "<resolutionOptionTo>" is selected for each record in the main screening table
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | on         | POSSIBLE             | POSITIVE           | positive  | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | off        | POSSIBLE             | POSITIVE           | positive  |                                                                                                                      |

  @C33162292 @C33162293
  Scenario Outline: C33162292, C33162293: Supplier - Screening Result - Update all Possible records to False - with/without Comment
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOptionFrom>" with "All Resolution Type" comment
    And Screening results table is loaded
    And User selects all screening results
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "<resolutionOptionTo>" resolution type menu option
    And User fills random Risk Level and Reason
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    When User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    And Resolution type "<resolutionOptionTo>" is selected for each record in the main screening table
    Examples:
      | turnOption | resolutionOptionFrom | resolutionOptionTo | alertText | comment                                                                                                              |
      | off        | POSSIBLE             | FALSE              | false     | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed |
      | on         | POSSIBLE             | FALSE              | false     |                                                                                                                      |

  @C33162289 @C33162294
  Scenario Outline: C33162289, C33162294: Supplier - Screening Result - Update all Positive and Possible records to Unresolved
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    And User selects all screening results
    And User clicks Resolve As screening button
    And User resolves selected records as "<resolutionOption>" with "All Resolution Type" comment
    And Screening results table is loaded
    And User selects all screening results
    And User clicks Resolve As screening button
    Then Resolution menu is displayed with options
      | Positive   |
      | Possible   |
      | False      |
      | Unresolved |
    And Cancel resolution button is displayed
    When User clicks "UNRESOLVED" resolution type menu option
    Then Add Comment modal is displayed
    When User fills random Risk Level and Reason
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                         |
      | Resolution type has been removed |
    And Add Comment modal is disappeared
    Then Resolution type "UNRESOLVED" is selected for each record in the main screening table
    Examples:
      | resolutionOption |
      | POSITIVE         |
      | POSSIBLE         |

  @C33150644
  Scenario: C33150644: Supplier - Screening Result - Mark record as Positive - Verify Comment Modal
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "POSITIVE" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSITIVE        |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    When User clicks "Cancel" Add Comment modal button
    Then Add Comment modal is disappeared
    And Resolution is not changed for "World-Check" "supplier" screening results

  @C33162236 @C33162240
  Scenario Outline: C33162236, C33162240: Supplier - Screening Result - Mark record as Positive and Possible - Save Comment with more than 900 characters
    Given User changes Search Criteria "Search Term" with value "TECHNOLOGY"
    When User clicks resolve "World-Check" screening record for "supplier" on position 1 on main screening list as "<resolutionOption>" resolution
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills random Risk Level and Reason
    And User fills in comment "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consequat feugiat dui, vel ultricies augue pretium sed. Mauris enim diam, sagittis et odio vel, feugiat pulvinar lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia sed odio in pharetra. Donec gravida, mauris quis pellentesque auctor, turpis sapien fringilla urna, porta bibendum quam nisl sed lorem. Nullam non placerat quam. Sed non luctus sapien. Pellentesque aliquet sem ut lacus imperdiet tincidunt. In dapibus, lacus convallis consequat aliquet, magna lacus lobortis ex, vel molestie purus metus ac arcu. Donec semper nunc non sollicitudin bibendum. Nullam mattis turpis est, ut fermentum elit posuere ut. Quisque bibendum nulla sollicitudin, ultricies eros et, efficitur diam. Sed blandit massa eros, vel luctus risus volutpat et. Vivamus quis luctus nisi. Morbi vehicula tinsss."
    When User turns off 'Tag as red flag'
    And User clicks "Save" Add Comment modal button
    Then Alert Icon is displayed with text
      | Success!                                         |
      | Resolution type has been updated to <alertText>. |
    Then Add Comment modal is disappeared
    And Screening record under number 1 appears in the main screening table with "<resolutionOption>" resolution
    Examples:
      | resolutionOption | alertText |
      | POSITIVE         | positive  |
      | POSSIBLE         | possible  |