@ui @robusta @automation_logic
Feature: View Questionnaires with Automation Logic

As RDDC User
I want to be able to view pre-selected the relevant Questionnaire type in View Activity
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

  @C47361051 @core_regression
  Scenario: C47361051: Workflow Activity - Assign Questionnaire - Automation Logic - View Assign Questionnaire activity - View Internal Questionnaire Type
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Assign Questionnaire"
    And User populates Activity Description with "Assign Questionnaire"
    And User selects "Internal" Questionnaire Type
    Then "Internal" questionnaire type radio button should be selected
    And "External" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "Internal" Relevant Questionnaire dropdown button should be enabled
    When User selects "User" Assignee type
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
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "View" icon for Activity "Assign Questionnaire"
    Then "Internal" questionnaire type radio button should be selected
    And Relevant Internal Questionnaire field should be empty

   @C47361053 @core_regression
   Scenario: C47361053: Workflow Activity - Assign Questionnaire - Automation Logic - View Assign Questionnaire activity - View External Questionnaire Type
     When User selects Activity Type as "Assign Questionnaire"
     And User populates Activity Name with "Assign Questionnaire"
     And User populates Activity Description with "Assign Questionnaire"
     And User selects "External" Questionnaire Type
     Then "External" questionnaire type radio button should be selected
     And "Internal" questionnaire type radio button should be unselected
     And "All" questionnaire type radio button should be unselected
     And "External" Relevant Questionnaire dropdown button should be enabled
     When User selects "User" Assignee type
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
     When User opens newly created Workflow
     And User clicks workflow button "Next"
     And User clicks "View" icon for Activity "Assign Questionnaire"
     Then "External" questionnaire type radio button should be selected
     And Relevant External Questionnaire field should be empty

  @C47361054 @core_regression
  Scenario: C47361054: Workflow Activity - Assign Questionnaire - Automation Logic - View Assign Questionnaire activity - View All Questionnaire Type
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Assign Questionnaire"
    And User populates Activity Description with "Assign Questionnaire"
    And User selects "All" Questionnaire Type
    Then "All" questionnaire type radio button should be selected
    And "Internal" questionnaire type radio button should be unselected
    And "External" questionnaire type radio button should be unselected
    When User selects "User" Assignee type
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
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "View" icon for Activity "Assign Questionnaire"
    Then "All" questionnaire type radio button should be selected
    And Relevant All Questionnaire field should be empty