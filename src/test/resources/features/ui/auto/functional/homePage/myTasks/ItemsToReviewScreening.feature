@ui @functional @dashboard
Feature: Home Page - My Tasks - Items To Review Widget - Screening

  As an RDDC User
  I want a quick view of all the World-check  Screening activities assigned to me for review
  So that I can review the list without going through each Third-party Record

  @C43358353
  Scenario: C43358353: User is able to sort "SCREENING" table by "Third-party Name" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And Users clicks "Third-party Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Third-party Name" in "ASC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Third-party Name" in "DESC" order
    When Users clicks "Third-party Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Third-party Name" in "ASC" order

  @C43358808
  Scenario: C43358808: User is able to sort "SCREENING" table by "Activity Name" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And Users clicks "Activity Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Activity Name" in "ASC" order
    When Users clicks "Activity Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Activity Name" in "DESC" order
    When Users clicks "Activity Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Activity Name" in "ASC" order

  @C43358809
  Scenario: C43358809: User is able to sort "SCREENING" table by "Type" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And Users clicks "Type" dashboard table column header
    Then "Items To Review" table displays records sorted by "Type" in "ASC" order
    When Users clicks "Type" dashboard table column header
    Then "Items To Review" table displays records sorted by "Type" in "DESC" order
    When Users clicks "Type" dashboard table column header
    Then "Items To Review" table displays records sorted by "Type" in "ASC" order

  @C43358810
  Scenario: C43358810: User is able to sort "SCREENING" table by "Record Name" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And Users clicks "Record Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Record Name" in "ASC" order
    When Users clicks "Record Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Record Name" in "DESC" order
    When Users clicks "Record Name" dashboard table column header
    Then "Items To Review" table displays records sorted by "Record Name" in "ASC" order

  @C43358811
  Scenario: C43358811: User is able to sort "SCREENING" table by "Reviewer" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And Users clicks "Reviewer" dashboard table column header
    Then "Items To Review" table displays records sorted by "Reviewer" in "ASC" order
    When Users clicks "Reviewer" dashboard table column header
    Then "Items To Review" table displays records sorted by "Reviewer" in "DESC" order
    When Users clicks "Reviewer" dashboard table column header
    Then "Items To Review" table displays records sorted by "Reviewer" in "ASC" order

  @C43358812
  Scenario: C43358812: User is able to sort "SCREENING" table by "Due Date" column
    Given User logs into RDDC as "Admin"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And Users clicks "Due Date" dashboard table column header
    Then "Items To Review" table displays records sorted by "Due Date" in "ASC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Items To Review" table displays records sorted by "Due Date" in "DESC" order
    When Users clicks "Due Date" dashboard table column header
    Then "Items To Review" table displays records sorted by "Due Date" in "ASC" order

  @C33173639
  Scenario: C33173639: My Tasks - Items to Review - Screening - Verify that World Check Screening activity is displayed when activity was assigned to individual Record Reviewer (internal user)
    Given User logs into RDDC as "Assignee"
    When User creates third-party "belizeWithApprover" via API and open it
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" reviewer due to today date
    And User waits for progress bar to disappear from page
    And User saves current record name as "thirdPartyRecordName"
    And User clicks on the 'Screening Results' screening profile button
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    When User clicks on 2 number Other name screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" reviewer due to today date
    And User waits for progress bar to disappear from page
    And User saves current record name as "thirdPartyOtherNameRecordName"
    And User clicks on the 'Screening Results' screening profile button
    And User clicks Close Other Name Results button
    And User creates Associated Party "Individual" "John SMITH" via API and open it
    And User clicks on 3 number screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" reviewer due to today date
    And User waits for progress bar to disappear from page
    And User saves current record name as "associatedPartyRecordName"
    And User clicks on the 'Screening Results' screening profile button
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on 4 number Other name screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" reviewer due to today date
    And User waits for progress bar to disappear from page
    And User saves current record name as "associatedPartyOtherNameRecordName"
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    Then Items to Review table contains activities
      | THIRD-PARTY NAME | ACTIVITY NAME            | TYPE             | RECORD NAME                        | REVIEWER                      | DUE DATE |
      | toBeReplaced     | OneSatisfiedApprovalRule | THIRD-PARTY      | thirdPartyRecordName               | Assignee_AT_FN Assignee_AT_LN | TODAY+0  |
      | toBeReplaced     | OneSatisfiedApprovalRule | THIRD-PARTY      | thirdPartyOtherNameRecordName      | Assignee_AT_FN Assignee_AT_LN | TODAY+0  |
      | toBeReplaced     | OneSatisfiedApprovalRule | ASSOCIATED PARTY | associatedPartyRecordName          | Assignee_AT_FN Assignee_AT_LN | TODAY+0  |
      | toBeReplaced     | OneSatisfiedApprovalRule | ASSOCIATED PARTY | associatedPartyOtherNameRecordName | Assignee_AT_FN Assignee_AT_LN | TODAY+0  |
    When Users clicks first My Tasks table page
    And Users clicks "Due Date" dashboard table column header
    And User selects "Max" items per page
    And User clicks on assigned activity for created Third-party with name reference "thirdPartyRecordName"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/profile\/(.+)?resultId=(\w+)" endpoint regex
    When User clicks on the 'Review' screening profile button
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And User selects "Max" items per page
    And Users clicks "Due Date" dashboard table column header
    And User clicks on assigned activity for created Third-party with name reference "thirdPartyOtherNameRecordName"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/profile\/(.+)?resultId=(\w+)&isFromDialog=true&otherName=(\w+)" endpoint regex
    When User clicks on the 'Review' screening profile button
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And User selects "Max" items per page
    And Users clicks "Due Date" dashboard table column header
    And User clicks on assigned activity for created Third-party with name reference "associatedPartyRecordName"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/associated-parties\/(\w+)\/profile\/(\w+)\?resultId=(\w+)&source=associated-parties" endpoint regex
    When User clicks on the 'Review' screening profile button
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And User selects "Max" items per page
    And Users clicks "Due Date" dashboard table column header
    And User clicks on assigned activity for created Third-party with name reference "associatedPartyOtherNameRecordName"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/associated-parties\/(\w+)\/profile\/(\w+)\?resultId=(\w+)&source=associated-parties&isFromDialog=true&otherName=(\w+)" endpoint regex
    When User clicks on the 'Review' screening profile button
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    Then Items to Review table doesn't contain activities
      | THIRD-PARTY NAME | ACTIVITY NAME            | TYPE             | RECORD NAME                        | REVIEWER                      | DUE DATE |
      | toBeReplaced     | OneSatisfiedApprovalRule | ASSOCIATED PARTY | associatedPartyOtherNameRecordName | Assignee_AT_FN Assignee_AT_LN | TODAY+0  |
      | toBeReplaced     | OneSatisfiedApprovalRule | THIRD-PARTY      | thirdPartyRecordName               | Assignee_AT_FN Assignee_AT_LN | TODAY+0  |
      | toBeReplaced     | OneSatisfiedApprovalRule | ASSOCIATED PARTY | associatedPartyRecordName          | Assignee_AT_FN Assignee_AT_LN | TODAY+0  |
      | toBeReplaced     | OneSatisfiedApprovalRule | THIRD-PARTY      | thirdPartyOtherNameRecordName      | Assignee_AT_FN Assignee_AT_LN | TODAY+0  |

  @C33173648
  Scenario: C33173648: My Tasks - Items to Review - Screening - Verify all members of the user group should see the World Check Screening activity when record was assigned to User Group (RMS-455)
    Given User logs into RDDC as "Assignee"
    When User creates third-party "with random ID name" via API and open it
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks on 1 number screening record
    And User adds screening record "User Group" "Group With Multi Users" Ad Hoc reviewer due to today date
    And User waits for progress bar to disappear from page
    And User saves current record name as "thirdPartyRecordName"
    And User clicks on the 'Screening Results' screening profile button
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    When User clicks on 2 number Other name screening record
    And User adds screening record "User Group" "Group With Multi Users" reviewer due to today date
    And User waits for progress bar to disappear from page
    And User saves current record name as "thirdPartyOtherNameRecordName"
    And User clicks on the 'Screening Results' screening profile button
    And User clicks Close Other Name Results button
    And User creates Associated Party "Individual" "John SMITH" via API and open it
    And User clicks on 3 number screening record
    And User adds screening record "User Group" "Group With Multi Users" reviewer due to today date
    And User waits for progress bar to disappear from page
    And User saves current record name as "associatedPartyRecordName"
    And User clicks on the 'Screening Results' screening profile button
    And User creates Other name "John" for Associated Party
    Then Other Name dialog is loaded
    When User clicks on 4 number Other name screening record
    And User adds screening record "User Group" "Group With Multi Users" reviewer due to today date
    And User waits for progress bar to disappear from page
    And User saves current record name as "associatedPartyOtherNameRecordName"
    And User logs into RDDC as "Assignee"
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    Then Items to Review table contains activities
      | THIRD-PARTY NAME | ACTIVITY NAME         | TYPE             | RECORD NAME                        | REVIEWER               | DUE DATE |
      | toBeReplaced     | World Check Screening | THIRD-PARTY      | thirdPartyRecordName               | Group With Multi Users | TODAY+0  |
      | toBeReplaced     | World Check Screening | THIRD-PARTY      | thirdPartyOtherNameRecordName      | Group With Multi Users | TODAY+0  |
      | toBeReplaced     | World Check Screening | ASSOCIATED PARTY | associatedPartyRecordName          | Group With Multi Users | TODAY+0  |
      | toBeReplaced     | World Check Screening | ASSOCIATED PARTY | associatedPartyOtherNameRecordName | Group With Multi Users | TODAY+0  |
    When Users clicks first My Tasks table page
    And Users clicks "Due Date" dashboard table column header
    And User selects "Max" items per page
    And User clicks on assigned activity for created Third-party with name reference "thirdPartyRecordName"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/profile\/(.+)?resultId=(\w+)" endpoint regex
    When User clicks on the 'Review' screening profile button
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And User selects "Max" items per page
    And Users clicks "Due Date" dashboard table column header
    And User clicks on assigned activity for created Third-party with name reference "thirdPartyOtherNameRecordName"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/profile\/(.+)?resultId=(\w+)&isFromDialog=true&otherName=(\w+)" endpoint regex
    When User clicks on the 'Review' screening profile button
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And User selects "Max" items per page
    And Users clicks "Due Date" dashboard table column header
    And User clicks on assigned activity for created Third-party with name reference "associatedPartyRecordName"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/associated-parties\/(\w+)\/profile\/(\w+)\?resultId=(\w+)&source=associated-parties" endpoint regex
    When User clicks on the 'Review' screening profile button
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And User selects "Max" items per page
    And Users clicks "Due Date" dashboard table column header
    And User clicks on assigned activity for created Third-party with name reference "associatedPartyOtherNameRecordName"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/associated-parties\/(\w+)\/profile\/(\w+)\?resultId=(\w+)&source=associated-parties&isFromDialog=true&otherName=(\w+)" endpoint regex
    When User clicks on the 'Review' screening profile button
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    Then Items to Review table doesn't contain activities
      | THIRD-PARTY NAME | ACTIVITY NAME         | TYPE             | RECORD NAME                        | REVIEWER               | DUE DATE |
      | toBeReplaced     | World Check Screening | THIRD-PARTY      | thirdPartyRecordName               | Group With Multi Users | TODAY+0  |
      | toBeReplaced     | World Check Screening | ASSOCIATED PARTY | associatedPartyOtherNameRecordName | Group With Multi Users | TODAY+0  |
      | toBeReplaced     | World Check Screening | THIRD-PARTY      | thirdPartyOtherNameRecordName      | Group With Multi Users | TODAY+0  |
      | toBeReplaced     | World Check Screening | ASSOCIATED PARTY | associatedPartyRecordName          | Group With Multi Users | TODAY+0  |
    When User logs into RDDC as "Approver"
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    Then Items to Review table doesn't contain activities
      | THIRD-PARTY NAME | ACTIVITY NAME         | TYPE             | RECORD NAME                        | REVIEWER               | DUE DATE |
      | toBeReplaced     | World Check Screening | THIRD-PARTY      | thirdPartyRecordName               | Group With Multi Users | TODAY+0  |
      | toBeReplaced     | World Check Screening | THIRD-PARTY      | thirdPartyOtherNameRecordName      | Group With Multi Users | TODAY+0  |
      | toBeReplaced     | World Check Screening | ASSOCIATED PARTY | associatedPartyRecordName          | Group With Multi Users | TODAY+0  |
      | toBeReplaced     | World Check Screening | ASSOCIATED PARTY | associatedPartyOtherNameRecordName | Group With Multi Users | TODAY+0  |

  @C33222632
  Scenario: C33222632: My Tasks - Items to Review - Screening - Verify that World Check Screening Activity should be visible on 'Items to Review' dashboard when review task is reassigned to a new reviewer (RMS-462)
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks on 1 number screening record
    And User saves current record name as "thirdPartyRecordName"
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" Ad Hoc reviewer due to today date
    And User edits screening record reviewer to "Assignee_AT_FN Assignee_AT_LN"
    And User logs into RDDC as "Assignee"
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    Then Items to Review table contains activities
      | THIRD-PARTY NAME | ACTIVITY NAME         | TYPE        | RECORD NAME          | REVIEWER                      | DUE DATE |
      | toBeReplaced     | World Check Screening | THIRD-PARTY | thirdPartyRecordName | Assignee_AT_FN Assignee_AT_LN | TODAY+0  |
    When Users clicks first My Tasks table page
    And Users clicks "Due Date" dashboard table column header
    And User clicks on assigned activity for created Third-party with name reference "thirdPartyRecordName"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/profile\/(.+)?resultId=(\w+)" endpoint regex
    When User clicks on the 'Review' screening profile button
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    Then Items to Review table doesn't contain activities
      | THIRD-PARTY NAME | ACTIVITY NAME         | TYPE        | RECORD NAME          | REVIEWER                      | DUE DATE |
      | toBeReplaced     | World Check Screening | THIRD-PARTY | thirdPartyRecordName | Assignee_AT_FN Assignee_AT_LN | TODAY+0  |

  @C33942003
  Scenario: C33942003: My Tasks - Items to Review - Screening - Verify Sorting and Pagination (RMS-1376)
    Given User logs into RDDC as "Assignee"
    When User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    Then Pagination elements are hidden if table contains less than 10 rows
    And Skip further steps if pagination hidden or disabled
    When User clicks "Screening Results To Review" "last" pagination element
    Then Results "Screening Results To Review" for current page is displayed
    When User clicks "Screening Results To Review" "first" pagination element
    Then Results "Screening Results To Review" for current page is displayed
    When User clicks "Screening Results To Review" "next" pagination element
    Then Results "Screening Results To Review" for current page is displayed
    When User clicks "Screening Results To Review" "previous" pagination element
    Then Results "Screening Results To Review" for current page is displayed
    When User selects "25" items per page
    Then Table displayed with up to "25" rows
    When User selects "10" items per page
    Then Table displayed with up to "10" rows
    When User selects "50" items per page
    Then Table displayed with up to "50" rows