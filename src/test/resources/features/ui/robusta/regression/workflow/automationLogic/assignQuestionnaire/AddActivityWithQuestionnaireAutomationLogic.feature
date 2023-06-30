@ui @robusta @automation_logic
Feature: Add/Edit Questionnaires with Automation Logic

As RDDC User
I want to be able to pre-select the Questionnaires Type in the Add Activity
So that I can guide the assignment of relevant questionnaires in the Onboarding/Renewal process for my Third parties

  Background:
    Given User logs into RDDC as "Admin"
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User creates new Workflow "Onboarding Workflow" with Activity "Simple Custom Activity"
    And User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks +Add Activity button
    Then Activity "Add Activity" tab is displayed

  @C47360352 @core_regression
  Scenario: C47360352: Workflow Activity - Assign Questionnaire - Automation Logic - Add Assign Questionnaire activity - Select Internal Questionnaire Type
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Assign Questionnaire"
    And User selects "Internal" Questionnaire Type
    Then "Internal" questionnaire type radio button should be selected
    And "External" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "Internal" Relevant Questionnaire dropdown button should be enabled
    When User populates Activity Description with "Assign Questionnaire"
    And User selects "User" Assignee type
    Then Assignee's drop-down contains only active users
    When User selects Workflow Assignee(s) as "Admin_AT_FN Admin_AT_LN"
    And User clears all Activity form required fields with User Assignee type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Cannot Save                           |
      | Please complete the required field(s) |
    And Workflow Activity field should be highlighted in red
      | Activity Type | Activity Name | Description | Due In |
    And Error message "This field is required" is displayed on Workflow Add Activity page for fields
      | Activity Type | Activity Name | Description | Due In |
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Assign Questionnaire"
    And User selects "Internal" Questionnaire Type
    Then "Internal" questionnaire type radio button should be selected
    And "External" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "Internal" Relevant Questionnaire dropdown button should be enabled
    When User populates Activity Description with "Assign Questionnaire"
    And User selects "User" Assignee type
    Then Assignee's drop-down contains only active users
    When User selects Workflow Assignee(s) as "Admin_AT_FN Admin_AT_LN"
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been added. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow should be created

  @C47360353 @core_regression
  Scenario: C47360353: Workflow Activity - Assign Questionnaire - Automation Logic - Add Assign Questionnaire activity - Select External Questionnaire Type
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Assign Questionnaire"
    And User selects "External" Questionnaire Type
    Then "External" questionnaire type radio button should be selected
    And "Internal" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "External" Relevant Questionnaire dropdown button should be enabled
    When User populates Activity Description with "Assign Questionnaire"
    And User selects "User" Assignee type
    Then Assignee's drop-down contains only active users
    When User selects Workflow Assignee(s) as "Admin_AT_FN Admin_AT_LN"
    And User clears all Activity form required fields with User Assignee type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Cannot Save                           |
      | Please complete the required field(s) |
    And Workflow Activity field should be highlighted in red
      | Activity Type | Activity Name | Description | Due In |
    And Error message "This field is required" is displayed on Workflow Add Activity page for fields
      | Activity Type | Activity Name | Description | Due In |
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Assign Questionnaire"
    And User selects "External" Questionnaire Type
    Then "External" questionnaire type radio button should be selected
    And "Internal" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "External" Relevant Questionnaire dropdown button should be enabled
    When User populates Activity Description with "Assign Questionnaire"
    And User selects "User" Assignee type
    Then Assignee's drop-down contains only active users
    When User selects Workflow Assignee(s) as "Admin_AT_FN Admin_AT_LN"
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been added. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow should be created

  @C47360354 @core_regression
  Scenario: C47360354: Workflow Activity - Assign Questionnaire - Automation Logic - Add Assign Questionnaire activity - Select All Questionnaire Type
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Assign Questionnaire"
    And User selects "All" Questionnaire Type
    Then "All" questionnaire type radio button should be selected
    And "Internal" questionnaire type radio button should be unselected
    And "External" questionnaire type radio button should be unselected
    When User populates Activity Description with "Assign Questionnaire"
    And User selects "User" Assignee type
    Then Assignee's drop-down contains only active users
    When User selects Workflow Assignee(s) as "Admin_AT_FN Admin_AT_LN"
    And User clears all Activity form required fields with User Assignee type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Cannot Save                           |
      | Please complete the required field(s) |
    And Workflow Activity field should be highlighted in red
      | Activity Type | Activity Name | Description | Due In |
    And Error message "This field is required" is displayed on Workflow Add Activity page for fields
      | Activity Type | Activity Name | Description | Due In |
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Assign Questionnaire"
    And User selects "All" Questionnaire Type
    Then "All" questionnaire type radio button should be selected
    And "Internal" questionnaire type radio button should be unselected
    And "External" questionnaire type radio button should be unselected
    When User populates Activity Description with "Assign Questionnaire"
    And User selects "User" Assignee type
    Then Assignee's drop-down contains only active users
    When User selects Workflow Assignee(s) as "Admin_AT_FN Admin_AT_LN"
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been added. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow should be created

  @C47360355
  Scenario: C47360355 Workflow Activity - Assign Questionnaire - Automation Logic - Add/Cancel Assign Questionnaire activity
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Assign Questionnaire"
    And User selects "All" Questionnaire Type
    Then "All" questionnaire type radio button should be selected
    And "Internal" questionnaire type radio button should be unselected
    And "External" questionnaire type radio button should be unselected
    When User populates Activity Description with "Assign Questionnaire"
    And User selects "User" Assignee type
    Then Assignee's drop-down contains only active users
    And User selects Workflow Assignee(s) as "Admin_AT_FN Admin_AT_LN"
    When User clicks workflow button "Cancel"
    Then Add Wizard page is displayed