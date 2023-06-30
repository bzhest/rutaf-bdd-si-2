@ui @cacao @functional @questionnaires @questionnaireReviewers
Feature: Questionnaire Management - Rules Reviewers Tab - View

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User selects Number of Reviewer Levels "3"

  @C46413562
  Scenario: C46413562: View Questionnaire: Reviewer Tab - Rules: Main Reviewer - Responsible Party, Level 1 Reviewer with data, Level 2 Reviewer and more without data
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    Then Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / toBeReplaced" is displayed
    And Questionnaire setup "Reviewers" tab is selected
    And Questionnaire setup "Settings" tab is selected
    And Questionnaire setup "Information" tab is active
    And Questionnaire setup "Question" tab is active
    And Questionnaire setup "Scoring" tab is active
    And Questionnaire setup "Rules" tab is active
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is ""
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    Then Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / toBeReplaced" is displayed
    And Questionnaire setup "Reviewers" tab is selected
    And Questionnaire setup "Settings" tab is selected
    And Questionnaire setup "Information" tab is active
    And Questionnaire setup "Question" tab is active
    And Questionnaire setup "Scoring" tab is active
    And Questionnaire setup "Rules" tab is active
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is ""
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    Then Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / toBeReplaced" is displayed
    And Questionnaire setup "Reviewers" tab is selected
    And Questionnaire setup "Settings" tab is selected
    And Questionnaire setup "Information" tab is active
    And Questionnaire setup "Question" tab is active
    And Questionnaire setup "Scoring" tab is active
    And Questionnaire setup "Rules" tab is active
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is ""
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed

  @C46435093
  Scenario: C46435093: View Questionnaire: Reviewer Tab - Rules: Main Reviewer - Responsible Party, Level 1 Reviewer and more *without data*
    When User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is ""
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is ""
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is ""
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed

  @C46435098
  Scenario: C46435098: View Questionnaire: Reviewer Tab - Rules: Main Reviewer - Responsible Party, Level 1 Reviewer and more *with data*
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 2 for rule 1
    And User selects "Asia" as rule type Reviewer Level 2 for rule 1
    And User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    And User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 3 for rule 1
    And User selects "3PL Services" as rule type Reviewer Level 3 for rule 1
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is ""
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 2 and rule 1
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is ""
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 2 and rule 1
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is ""
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 2 and rule 1
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed

  @C46438049
  Scenario: C46438049: View Questionnaire: Reviewer Tab - Rules: Main Reviewer - User, Level 1 Reviewer and more *with data*
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User" as Main Reviewer
    And User fills "Admin_AT_FN Admin_AT_LN" value as Main Reviewer
    And User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User selects "User" as Reviewer
    And User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 2 for rule 1
    And User selects "Asia" as rule type Reviewer Level 2 for rule 1
    And User selects "User" as Reviewer
    And User fills user "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" as Questionnaire Reviewer
    And User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    And User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 3 for rule 1
    And User selects "3PL Services" as rule type Reviewer Level 3 for rule 1
    And User selects "User" as Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire Rules "User" is selected as Reviewer
    And Reviewer "Assignee_AT_FN Assignee_AT_LN" is selected
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "User" is selected as Reviewer
    And Reviewer "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" is selected
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "User" is selected as Reviewer
    And Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 2 and rule 1
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire Rules "User" is selected as Reviewer
    And Reviewer "Assignee_AT_FN Assignee_AT_LN" is selected
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "User" is selected as Reviewer
    And Reviewer "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" is selected
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "User" is selected as Reviewer
    And Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 2 and rule 1
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire Rules "User" is selected as Reviewer
    And Reviewer "Assignee_AT_FN Assignee_AT_LN" is selected
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "User" is selected as Reviewer
    And Reviewer "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" is selected
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "User" is selected as Reviewer
    And Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 2 and rule 1
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed

  @C46438398
  Scenario: C46438398: View Questionnaire: Reviewer Tab - Rules: Main Reviewer - User, Level 1 Reviewer and more *without data*
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User" as Main Reviewer
    And User fills "Admin_AT_FN Admin_AT_LN" value as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed

  @C46438401
  Scenario: C46438401: View Questionnaire: Reviewer Tab - Rules: Main Reviewer - User, Level 1 Reviewer with data, Level 2 Reviewer and more without data
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User" as Main Reviewer
    And User fills "Admin_AT_FN Admin_AT_LN" value as Main Reviewer
    And User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User selects "User" as Reviewer
    And User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"
    And Questionnaire Rules "User" is selected as Reviewer
    And Reviewer "Assignee_AT_FN Assignee_AT_LN" is selected
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in view mode
    And Questionnaire Rules "User" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"
    And Questionnaire Rules "User" is selected as Reviewer
    And Reviewer "Assignee_AT_FN Assignee_AT_LN" is selected
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in view mode
    And Questionnaire Rules "User" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"
    And Questionnaire Rules "User" is selected as Reviewer
    And Reviewer "Assignee_AT_FN Assignee_AT_LN" is selected
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed

  @C46438406
  Scenario: C46438406: View Questionnaire: Reviewer Tab - Rules: Main Reviewer - User Group, Level 1 Reviewer and more *with data*
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User Group" as Main Reviewer
    And User fills "AUTO_GROUP" value as Main Reviewer
    And User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User selects "User Group" as Reviewer
    And User fills user "Assignee Group" as Questionnaire Reviewer
    And User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 2 for rule 1
    And User selects "Asia" as rule type Reviewer Level 2 for rule 1
    And User selects "User Group" as Reviewer
    And User fills user "AUTO_GROUP" as Questionnaire Reviewer
    And User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    And User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 3 for rule 1
    And User selects "3PL Services" as rule type Reviewer Level 3 for rule 1
    And User selects "User Group" as Reviewer
    And User fills user "Group With Multi Users" as Questionnaire Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User Group" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "AUTO_GROUP"
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire Rules "User Group" is selected as Reviewer
    And Reviewer "Assignee Group" is selected
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "User Group" is selected as Reviewer
    And Reviewer "AUTO_GROUP" is selected
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "User Group" is selected as Reviewer
    And Reviewer "Group With Multi Users" is selected
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 2 and rule 1
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User Group" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "AUTO_GROUP"
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire Rules "User Group" is selected as Reviewer
    And Reviewer "Assignee Group" is selected
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "User Group" is selected as Reviewer
    And Reviewer "AUTO_GROUP" is selected
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "User Group" is selected as Reviewer
    And Reviewer "Group With Multi Users" is selected
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 2 and rule 1
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User Group" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "AUTO_GROUP"
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire Rules "User Group" is selected as Reviewer
    And Reviewer "Assignee Group" is selected
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "User Group" is selected as Reviewer
    And Reviewer "AUTO_GROUP" is selected
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "User Group" is selected as Reviewer
    And Reviewer "Group With Multi Users" is selected
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 2 and rule 1
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed

  @C46438407
  Scenario: C46438407: View Questionnaire: Reviewer Tab - Rules: Main Reviewer - User Group, Level 1 Reviewer and more *without data*
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User Group" as Main Reviewer
    And User fills "AUTO_GROUP" value as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User Group" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "AUTO_GROUP"
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User Group" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "AUTO_GROUP"
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User Group" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "AUTO_GROUP"
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed

  @C46438421
  Scenario: C46438421: View Questionnaire: Reviewer Tab - Rules: Main Reviewer - User Group, Level 1 Reviewer with data, Level 2 Reviewer and more without data
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User Group" as Main Reviewer
    And User fills "Assignee Group" value as Main Reviewer
    And User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User selects "User Group" as Reviewer
    And User fills user "AUTO_GROUP" as Questionnaire Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User Group" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "Assignee Group"
    And Questionnaire Rules "User Group" is selected as Reviewer
    And Reviewer "AUTO_GROUP" is selected
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in view mode
    And Questionnaire Rules "User Group" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "Assignee Group"
    And Questionnaire Rules "User Group" is selected as Reviewer
    And Reviewer "AUTO_GROUP" is selected
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in view mode
    And Questionnaire Rules "User Group" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is "Assignee Group"
    And Questionnaire Rules "User Group" is selected as Reviewer
    And Reviewer "AUTO_GROUP" is selected
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire expanded Rule message is displayed "NO RULES AVAILABLE"
    When User clicks Questionnaire Setup button "Back"
    Then Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    And Questionnaire setup "Reviewers" tab is active
    And Questionnaire tab displayed in view mode
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
