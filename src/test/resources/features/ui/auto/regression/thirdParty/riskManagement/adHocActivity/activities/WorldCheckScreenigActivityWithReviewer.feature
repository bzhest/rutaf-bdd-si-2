@ui @full_regression @core_regression @react @workflow_check_screening_activity_risk_management
Feature: Risk Management - Ad Hoc - Workflow Check Screening Activity With Reviewer

  @C33197977
  Scenario: C33197977: [Reviewer] Risk Management - Ad Hoc Activity - View auto created World Check Screening Ad Hoc Activity - Assigned to User
    Given User logs into RDDC as "Admin"
    When User creates third-party "Bank of China" via API and open it
    And User clicks on 1 number screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status  |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                      | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Assignee_AT_FN Assignee_AT_LN | For Review    | TODAY+0  | THIRD-PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    And Screening profile's Review button is enabled

  @C33433613
  @email
  Scenario: C33433613: [Reviewer] World Check Screening Ad hoc Activity - Review record - Reassign record to another internal user
    Given User logs into RDDC as "Admin"
    When User creates third-party "Bank" via API and open it
    And User clicks on 1 number screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status  |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                      | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Assignee_AT_FN Assignee_AT_LN | For Review    | TODAY+0  | THIRD-PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    When User selects screening record reviewer "Admin_AT_FN Admin_AT_LN" from drop-down
    Then Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    When User clicks Screening profile's reviewer Clear button
    Then Screening profile's Reviewer is ""
    When User selects screening record reviewer "Admin_AT_FN Admin_AT_LN" from drop-down
    And User clicks screening record reviewer Save button
    Then Text of screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    And Email notification "Screening Delegation" with following values is received by "Admin" user
      | <WC1_Record_Name> | 1 |
    When User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status  |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Admin_AT_FN Admin_AT_LN | For Review    | TODAY+0  | THIRD-PARTY | VIEW        |

  @C33931129
  Scenario: C33931129: [Reviewer] World Check Screening Ad hoc Activity - Review third-party record - Click Review
    Given User logs into RDDC as "Admin"
    When User creates third-party "APPLE INVESTMENT COMPANY" via API and open it
    And User clicks on 1 number screening record
    And User fills in screening profile comment "Test Text"
    And User clicks screening profile Comment button
    Then Comment profile section contains expected text "Test Text"
    When User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status  |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                      | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Assignee_AT_FN Assignee_AT_LN | For Review    | TODAY+0  | THIRD-PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Test Text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Review button is enabled
    When User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"

  @C33931130
  Scenario: C33931130: [Reviewer-User Group]World Check Screening Ad hoc activity - Review third-party record - Click Review
    Given User logs into RDDC as "Admin"
    When User creates third-party "PETROCHINA HONG KONG LTD"
    And User clicks on 1 number screening record
    And User fills in screening profile comment "Test Text"
    And User clicks screening profile Comment button
    Then Comment profile section contains expected text "Test Text"
    When User adds screening record "User Group" "Assignee Group" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status  |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer       | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Assignee Group | For Review    | TODAY+0  | THIRD-PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Test Text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Review button is enabled
    When User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"

  @C39400406
  Scenario: C39400406: [Reviewer] World Check Screening Ad hoc Activity - Review third-party other name record - Click Review
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User creates Other name "Bank"
    And User opens screening results for "Bank" Other name
    Then Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User fills in screening profile comment "Test Text"
    And User clicks screening profile Comment button
    Then Comment profile section contains expected text "Test Text"
    When User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status  |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                      | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Assignee_AT_FN Assignee_AT_LN | For Review    | TODAY+0  | THIRD-PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Test Text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Review button is enabled
    When User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"

  @C39400407
  Scenario: C39400407: [Reviewer-User Group]World Check Screening Ad hoc activity - Review third-party other name record - Click Review
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name"
    And User creates Other name "Bank"
    And User opens screening results for "Bank" Other name
    Then Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User fills in screening profile comment "Test Text"
    And User clicks screening profile Comment button
    Then Comment profile section contains expected text "Test Text"
    When User adds screening record "User Group" "Assignee Group" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status  |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer       | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Assignee Group | For Review    | TODAY+0  | THIRD-PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Test Text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Review button is enabled
    When User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"

  @C33931131
  Scenario: C33931131: [Reviewer] World Check Screening Ad hoc Activity - Review Third-party Contact record - Click Review
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "John SMITH"
    And User clicks on 1 number screening record
    And User fills in screening profile comment "Test Text"
    And User clicks screening profile Comment button
    Then Comment profile section contains expected text "Test Text"
    When User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status  |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                      | Review Status | Due Date | Type             | Button Name |
      | recordName1 | recordId1    | Assignee_AT_FN Assignee_AT_LN | For Review    | TODAY+0  | ASSOCIATED PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Test Text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Review button is enabled
    When User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"

  @C33931132
  Scenario: C33931132: [Reviewer-User Group] World Check Screening Ad hoc Activity - Review Third-party Contact record - Click Review
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name"
    And User creates Associated Party "John SMITH"
    And User clicks on 1 number screening record
    And User fills in screening profile comment "Test Text"
    And User clicks screening profile Comment button
    Then Comment profile section contains expected text "Test Text"
    When User adds screening record "User Group" "Assignee Group" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status  |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer       | Review Status | Due Date | Type             | Button Name |
      | recordName1 | recordId1    | Assignee Group | For Review    | TODAY+0  | ASSOCIATED PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Test Text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Review button is enabled
    When User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"

  @C39400408
  Scenario: C39400408: [Reviewer] World Check Screening Ad hoc Activity - Review Third-party Contact other name record - Click Review
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "John SMITH"
    And User creates Other name "Barac Obama" for Associated Party
    Then Sorted search "World-Check" results for "Barac Obama" "contact" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User fills in screening profile comment "Test Text"
    And User clicks screening profile Comment button
    Then Comment profile section contains expected text "Test Text"
    When User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status  |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                      | Review Status | Due Date | Type             | Button Name |
      | recordName1 | recordId1    | Assignee_AT_FN Assignee_AT_LN | For Review    | TODAY+0  | ASSOCIATED PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Test Text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Review button is enabled
    When User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"

  @C39400409
  Scenario: C39400409: [Reviewer-User Group] World Check Screening Ad hoc Activity - Review Third-party Contact other name record - Click Review
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name"
    And User creates Associated Party "John SMITH"
    And User creates Other name "Barac Obama" for Associated Party
    Then Sorted search "World-Check" results for "Barac Obama" "contact" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User fills in screening profile comment "Test Text"
    And User clicks screening profile Comment button
    Then Comment profile section contains expected text "Test Text"
    When User adds screening record "User Group" "Assignee Group" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status  |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer       | Review Status | Due Date | Type             | Button Name |
      | recordName1 | recordId1    | Assignee Group | For Review    | TODAY+0  | ASSOCIATED PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    And Comment profile section contains expected text "Test Text"
    And Comment profile section contains expected author "Admin_AT_FN Admin_AT_LN"
    And Comment profile section contains expected date
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Review button is enabled
    When User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"
