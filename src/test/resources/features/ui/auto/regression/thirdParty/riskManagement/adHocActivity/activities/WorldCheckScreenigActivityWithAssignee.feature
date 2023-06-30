@ui @full_regression @core_regression @react @workflow_check_screening_activity_risk_management
Feature: Risk Management - Ad Hoc - Workflow Check Screening Activity With Assignee

  @C33197976
  Scenario: C33197976: [Assignee] Risk Management - Ad Hoc Activity - View auto created World Check Screening Ad Hoc Activity
    Given User logs into RDDC as "Admin"
    When User creates third-party "Bank of China" via API and open it
    And User clicks on 1 number screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type         | Activity Name         | Description                                                                   | Start Date | Due Date | Assignee                | Status  |
      | World Check Screening | World Check Screening | This activity was automatically initiated through adhoc screening delegation. | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
    And Activity Information Review Task table contains the following task
      | Name        | Reference Id | Reviewer                      | Review Status | Due Date | Type        | Button Name |
      | recordName1 | recordId1    | Assignee_AT_FN Assignee_AT_LN | For Review    | TODAY+0  | THIRD-PARTY | REVIEW      |
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed

  @C33433618
  Scenario: C33433618: [Assignee] World Check Screening Ad hoc Activity - View record - Verify that user can Add New Reviewer for Reviewed record
    Given User logs into RDDC as "Admin"
    When User creates third-party "APPLE INVESTMENT COMPANY" via API and open it
    And User clicks on 1 number screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Review Status is "For Review"
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    And User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    When User clicks on the 'Review' screening profile button
    Then Screening profile's Review Status is "Reviewed"
    When User logs into RDDC as "Admin"
    And User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    And User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    When User adds screening record "User" "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" reviewer due to today date
    Then Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"
