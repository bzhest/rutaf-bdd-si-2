@ui @suppliers @full_regression
Feature: Ad Hoc Activities

  As a Compliance Group User
  I want to be able to create Ad Hoc activities for a Third-Party
  So that I can log additional activities that are not covered in the Onboarding process

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it

  @C43475675
  Scenario Outline: C43475675: Third-party - Ad Hoc Activity - No Edit Permission - Edit other users Ad Hoc Activity with Draft and NOT Draft status from Ad Hoc Activity List
    When User adds Ad Hoc activity with Activity Type "<activityType>", assignee "admin", status "<status>" via API
    And User clicks on Risk Management tab
    Then Added Ad Hoc Activity is displayed in Ad Hoc Activity table with status "<status>"
    And Risk Management Ad Hoc activity "adHocActivityName" icon Edit is displayed
    When User logs into RDDC as "restricted"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    Then Added Ad Hoc Activity is displayed in Ad Hoc Activity table with status "<status>"
    And Risk Management Ad Hoc activity "adHocActivityName" icon Edit is hidden

    Examples:
      | activityType          | status      |
      | Approve Onboarding    | Draft       |
      | Decline Onboarding    | Not Started |
      | Assessment            | In Progress |
      | World Check Screening | Defferal    |
      | Approve Onboarding    | Waiting     |
      | Decline Onboarding    | Done        |

  @C43482930
  Scenario: C43482930: Third-party - Ad Hoc Activity - Edit other users Ad Hoc Activity with NOT Draft status from Ad Hoc Activity List
    When User adds Ad Hoc activity with Activity Type "Approve Onboarding", assignee "admin", status "In Progress" via API
    And User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    Then Added Ad Hoc Activity is displayed in Ad Hoc Activity table with status "In Progress"
    When User clicks on Edit button for Ad Hoc Activity with name "adHocActivityName" in Ad Hoc Activity table
    Then Ad Hoc Activity Information modal fields should be in correct state
      | Activity Type | disabled |
      | Activity Name | disabled |
      | Description   | disabled |
      | Risk Area     | disabled |
      | Start Date    | disabled |
      | Due Date      | disabled |
      | Status        | enabled  |
      | Assignee      | enabled  |
    And Risk Management "Cancel" button is displayed
    And Risk Management "Save" button is displayed
    And Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Waiting     |
      | Done        |
    When User clears Activity Information fields
      | Assignee |
    And User clicks Ad Hoc Activity "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                         |
      | Please complete the required fields |
    And Error message 'This field is required' is displayed for the next fields
      | Assignee |
    When User fills in "Status" drop-down with "Done"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Cancel' activity button
    Then Ad Hoc Activity Information modal is displayed with details
      | Assignee                | Status      |
      | Admin_AT_FN Admin_AT_LN | In Progress |
    When User clicks Ad Hoc Activity "Back" button
    And User waits for progress bar to disappear from page
    And User clicks on Edit button for Ad Hoc Activity with name "adHocActivityName" in Ad Hoc Activity table
    And User fills in "Status" drop-down with "Done"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Save' activity button
    Then Added Ad Hoc Activity is displayed in Ad Hoc Activity table with status "Completed"
    When User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Ad Hoc Activity Information modal is displayed with details
      | Assignee                      | Status    |
      | Assignee_AT_FN Assignee_AT_LN | Completed |
    And User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
      | FIELD ORIGINAL VALUE NEW VALUE |
      | Status In Progress Done        |

  @C43496444
  Scenario: C43496444: Third-party - Ad Hoc Activity - Edit Permission Only - Edit own Ad Hoc Activity with NOT Draft status from Ad Hoc Activity List
    When User adds Ad Hoc activity with Activity Type "Approve Onboarding", assignee "restricted with edit permissions", status "Draft" via API
    And User logs into RDDC as "restricted with edit permissions"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on Edit button for Ad Hoc Activity with name "adHocActivityName" in Ad Hoc Activity table
    And User fills in "Status" drop-down with "Not Started"
    And User clicks 'Save' activity button
    And User waits for progress bar to disappear from page
    And User clicks on Edit button for Ad Hoc Activity with name "adHocActivityName" in Ad Hoc Activity table
    And User waits for progress bar to disappear from page
    Then Ad Hoc Activity Information modal fields should be in correct state
      | Activity Type | disabled |
      | Activity Name | disabled |
      | Description   | disabled |
      | Risk Area     | disabled |
      | Start Date    | disabled |
      | Due Date      | disabled |
      | Status        | enabled  |
      | Assignee      | enabled  |
    And Risk Management "Cancel" button is displayed
    And Risk Management "Save" button is displayed
    And Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Waiting     |
      | Done        |
    When User clears Activity Information fields
      | Assignee |
    And User clicks Ad Hoc Activity "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                         |
      | Please complete the required fields |
    And Error message 'This field is required' is displayed for the next fields
      | Assignee |
    When User fills in "Status" drop-down with "Done"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Cancel' activity button
    Then Ad Hoc Activity Information modal is displayed with details
      | Assignee                          | Status      |
      | Autouser_Edit_FN Autouser_Edit_LN | Not Started |
    When User clicks Edit button for Activity
    And User fills in "Status" drop-down with "Done"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Save' activity button
    Then Added Ad Hoc Activity is displayed in Ad Hoc Activity table with status "Completed"
    When User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Ad Hoc Activity Information modal is displayed with details
      | Assignee                      | Status    |
      | Assignee_AT_FN Assignee_AT_LN | Completed |

  @C43499979
  Scenario: C43499979: Third-party - Ad Hoc Activity - No Edit Permission - Edit own Ad Hoc Activity with Draft and NOT Draft status from Ad Hoc Activity List
    When User adds Ad Hoc activity with Activity Type "Approve Onboarding", assignee "restricted", status "In Progress" via API
    And User logs into RDDC as "restricted"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    Then Added Ad Hoc Activity is displayed in Ad Hoc Activity table with status "In Progress"
    And Risk Management Ad Hoc activity "adHocActivityName" icon Edit is hidden
    When User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Activity Information Edit button is hidden

  @C40658999
  Scenario: C40658999: Third-party - Ad Hoc Activity - Edit Ad Hoc Activity with NOT Draft status from Ad Hoc Activity List
    And User adds Ad Hoc activity with Activity Type "Approve Onboarding", assignee "admin", status "In Progress" via API
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    Then Added Ad Hoc Activity is displayed in Ad Hoc Activity table with status "In Progress"
    When User clicks on Edit button for Ad Hoc Activity with name "adHocActivityName" in Ad Hoc Activity table
    Then Ad Hoc Activity Information modal fields should be in correct state
      | Activity Type | disabled |
      | Activity Name | disabled |
      | Description   | disabled |
      | Risk Area     | disabled |
      | Start Date    | disabled |
      | Due Date      | disabled |
      | Status        | enabled  |
      | Assignee      | enabled  |
    And Risk Management "Cancel" button is displayed
    And Risk Management "Save" button is displayed
    And Activity Status drop-down contains the next options
      | Not Started |
      | In Progress |
      | Deferral    |
      | Waiting     |
      | Done        |
    When User clears Activity Information fields
      | Assignee |
    And User clicks Ad Hoc Activity "Save" button
    Then Alert Icon is displayed with text
      | Cannot Save                         |
      | Please complete the required fields |
    And Error message 'This field is required' is displayed for the next fields
      | Assignee |
    When User fills in "Status" drop-down with "Done"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks 'Cancel' activity button
    Then Ad Hoc Activity Information modal is displayed with details
      | Assignee                | Status      |
      | Admin_AT_FN Admin_AT_LN | In Progress |
    When User clicks Ad Hoc Activity "Back" button
    And User waits for progress bar to disappear from page
    And User clicks on Edit button for Ad Hoc Activity with name "adHocActivityName" in Ad Hoc Activity table
    And User fills in "Status" drop-down with "Done"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    When User clicks 'Save' activity button
    Then Added Ad Hoc Activity is displayed in Ad Hoc Activity table with status "Completed"
    When User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Ad Hoc Activity Information modal is displayed with details
      | Assignee                      | Status    |
      | Assignee_AT_FN Assignee_AT_LN | Completed |
    And User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
      | FIELD ORIGINAL VALUE NEW VALUE |
      | Status In Progress Done        |