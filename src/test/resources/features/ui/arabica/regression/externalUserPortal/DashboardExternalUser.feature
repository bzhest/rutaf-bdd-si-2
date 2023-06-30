@ui @full_regression @external_user_profile
Feature: External User Portal - check tabs of the Dashboard

  As a RDDC External User
  I want a quick view of all the activities assigned to me
  So that I can review the list and prioritize them accordingly

  @C35882609 @C40581859
  Scenario: C35882609, C40581859: External User Portal - check tabs of the Dashboard
    Given User logs into RDDC as "Admin"
    When User navigates to Third-party page
    And User searches third-party with name "Supplier_External_User"
    And User clicks third-party with name "Supplier_External_User"
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User fills in due date - today +1 day
    And User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Ad Hoc Activity with name "External Questionnaire for Supplier_External_User DO NOT DELETE" is created
    When User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_AT_FN External_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User fills in due date - today +2 day
    And User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Ad Hoc Activity with name "External Questionnaire for Supplier_External_User DO NOT DELETE" is created
    When User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User fills in due date - today +6 day
    And User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Ad Hoc Activity with name "External Questionnaire for Supplier_External_User DO NOT DELETE" is created
    When User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User fills in due date - today +7 day
    And User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Ad Hoc Activity with name "External Questionnaire for Supplier_External_User DO NOT DELETE" is created
    When User logs into RDDC as "External"
    Then External User Home tabs is displayed with the following widget
      | OVERDUE ACTIVITIES |
      | DUE WITHIN 5 DAYS  |
      | DUE IN 5+ DAYS     |
    And "Overdue" widget expected activity counter is displayed
    And "Due within 5 days" widget expected activity counter is displayed
    And "Due in 5+ days" widget expected activity counter is displayed
    When User click on "Overdue" widget for External user
    Then My Activities table is displayed
    And My Activities "Overdue" widget column headers are displayed
      | THIRD-PARTY NAME | NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |
    And Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |
    When User clicks on My Activities "Third-party Name" column
    Then My Activities table is sorted by "THIRD-PARTY NAME" column in "ASC" order
    When User clicks on My Activities "Third-party Name" column
    Then My Activities table is sorted by "THIRD-PARTY NAME" column in "DESC" order
    When User clicks on My Activities "Name" column
    Then My Activities table is sorted by "NAME" column in "ASC" order
    When User clicks on My Activities "Name" column
    Then My Activities table is sorted by "NAME" column in "DESC" order
    When User clicks on My Activities "Description" column
    Then My Activities table is sorted by "DESCRIPTION" column in "ASC" order
    When User clicks on My Activities "Description" column
    Then My Activities table is sorted by "DESCRIPTION" column in "DESC" order
    When User clicks on My Activities "Due Date" column
    Then My Activities table is sorted by "DUE DATE" column in "ASC" order
    When User clicks on My Activities "Due Date" column
    Then My Activities table is sorted by "DUE DATE" column in "DESC" order
    When User clicks on My Activities "Assigned To" column
    Then My Activities table is sorted by "ASSIGNED TO" column in "ASC" order
    When User clicks on My Activities "Assigned To" column
    Then My Activities table is sorted by "ASSIGNED TO" column in "DESC" order
    When User clicks on My Activities "Status" column
    Then My Activities table is sorted by "STATUS" column in "ASC" order
    When User clicks on My Activities "Status" column
    Then My Activities table is sorted by "STATUS" column in "DESC" order
    When User click on "Due within 5 days" widget for External user
    Then My Activities table is displayed
    And My Activities "Due within 5 days" widget column headers are displayed
      | THIRD-PARTY NAME | NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |
    When User clicks on My Activities "Third-party Name" column
    Then My Activities table is sorted by "THIRD-PARTY NAME" column in "ASC" order
    When User clicks on My Activities "Third-party Name" column
    Then My Activities table is sorted by "THIRD-PARTY NAME" column in "DESC" order
    When User clicks on My Activities "Name" column
    Then My Activities table is sorted by "NAME" column in "ASC" order
    When User clicks on My Activities "Name" column
    Then My Activities table is sorted by "NAME" column in "DESC" order
    When User clicks on My Activities "Description" column
    Then My Activities table is sorted by "DESCRIPTION" column in "ASC" order
    When User clicks on My Activities "Description" column
    Then My Activities table is sorted by "DESCRIPTION" column in "DESC" order
    When User clicks on My Activities "Due Date" column
    Then My Activities table is sorted by "DUE DATE" column in "ASC" order
    When User clicks on My Activities "Due Date" column
    Then My Activities table is sorted by "DUE DATE" column in "DESC" order
    When User clicks on My Activities "Assigned To" column
    Then My Activities table is sorted by "ASSIGNED TO" column in "ASC" order
    When User clicks on My Activities "Assigned To" column
    Then My Activities table is sorted by "ASSIGNED TO" column in "DESC" order
    When User clicks on My Activities "Status" column
    Then My Activities table is sorted by "STATUS" column in "ASC" order
    When User clicks on My Activities "Status" column
    Then My Activities table is sorted by "STATUS" column in "DESC" order
    When User click on "Due in 5+ days" widget for External user
    Then My Activities table is displayed
    And My Activities "Due in 5+ days" widget column headers are displayed
      | THIRD-PARTY NAME | NAME | DESCRIPTION | DUE DATE | ASSIGNED TO | STATUS |
    When User clicks on My Activities "Third-party Name" column
    Then My Activities table is sorted by "THIRD-PARTY NAME" column in "ASC" order
    When User clicks on My Activities "Third-party Name" column
    Then My Activities table is sorted by "THIRD-PARTY NAME" column in "DESC" order
    When User clicks on My Activities "Name" column
    Then My Activities table is sorted by "NAME" column in "ASC" order
    When User clicks on My Activities "Name" column
    Then My Activities table is sorted by "NAME" column in "DESC" order
    When User clicks on My Activities "Description" column
    Then My Activities table is sorted by "DESCRIPTION" column in "ASC" order
    When User clicks on My Activities "Description" column
    Then My Activities table is sorted by "DESCRIPTION" column in "DESC" order
    When User clicks on My Activities "Due Date" column
    Then My Activities table is sorted by "DUE DATE" column in "ASC" order
    When User clicks on My Activities "Due Date" column
    Then My Activities table is sorted by "DUE DATE" column in "DESC" order
    When User clicks on My Activities "Assigned To" column
    Then My Activities table is sorted by "ASSIGNED TO" column in "ASC" order
    When User clicks on My Activities "Assigned To" column
    Then My Activities table is sorted by "ASSIGNED TO" column in "DESC" order
    When User clicks on My Activities "Status" column
    Then My Activities table is sorted by "STATUS" column in "ASC" order
    When User clicks on My Activities "Status" column
    Then My Activities table is sorted by "STATUS" column in "DESC" order
    When User click on "Overdue" widget for External user
    And User click on the first row in My Activities table
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type          | Activity Name                                                   | Description                                                      | Assignee                      | Status      | Assessment |
      | Questionnaire Assigned | External Questionnaire for Supplier_External_User DO NOT DELETE | Click on the link below to view and/or answer the questionnaire. | External_AT_FN External_AT_LN | Not Started |            |
    When User clicks Back button to return from Activity modal
    And User click on "Due within 5 days" widget for External user
    And User click on the first row in My Activities table
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type          | Activity Name                                                   | Description                                                      | Assignee                      | Status      | Assessment |
      | Questionnaire Assigned | External Questionnaire for Supplier_External_User DO NOT DELETE | Click on the link below to view and/or answer the questionnaire. | External_AT_FN External_AT_LN | Not Started |            |
    When User clicks Back button to return from Activity modal
    And User click on "Due in 5+ days" widget for External user
    And User click on the first row in My Activities table
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type          | Activity Name                                                   | Description                                                      | Assignee                      | Status      | Assessment |
      | Questionnaire Assigned | External Questionnaire for Supplier_External_User DO NOT DELETE | Click on the link below to view and/or answer the questionnaire. | External_AT_FN External_AT_LN | Not Started |            |