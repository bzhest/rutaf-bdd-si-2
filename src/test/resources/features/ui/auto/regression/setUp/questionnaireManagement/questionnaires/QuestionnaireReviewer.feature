@ui @full_regression @questionnaires
Feature: Questionnaire Setup - Reviewer Settings

  As an Admin or Internal User that has access right
  I Want to allow user to setup rules to trigger Questionnaire reviewer based on rules
  So That Client have the flexibility to set up different reviewer depending on their process and according to supplier information


  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Questionnaire Management page
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"

  @C35992358
  @core_regression
  @onlySingleThread
  Scenario: C35992358: Questionnaire Setup - Reviewer Settings - Set Questionnaire reviewer based on rule - Supplier Country
    When User adds up to 2 questions with multiply types for active tab
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "Responsible Party" option is selected
    And Add Rule drop-down field is displayed
    And Rule Type field is displayed
    And Reviewer Rule options is displayed
      | User              |
      | User Group        |
      | Responsible Party |
    When User selects "Third-party Country" Reviewer Rules for rule 1
    And User selects "Albania" rule type for rule 1
    And User selects "Norway" rule type for rule 1
    And User clicks "User Group" Reviewer Rule option
    Then Reviewer drop-down contains 50 active user groups with default "Refine your keywords to show relevant results" option
    When User selects "AUTO_GROUP" Reviewer Rules reviewer
    Then Reviewer "AUTO_GROUP" is selected
    When User clicks "Responsible Party" Reviewer Rule option
    Then Questionnaire Rules Reviewer drop-down is disabled
    When User clicks "User" Reviewer Rule option
    Then Questionnaire Rules Reviewer drop-down contains active users
    When User selects "Assignee_AT_FN Assignee_AT_LN" Reviewer Rules reviewer
    Then Reviewer "Assignee_AT_FN Assignee_AT_LN" is selected
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "User" option is selected
    When User clicks "User" Reviewer Rule option
    And User selects "Admin_AT_FN Admin_AT_LN" Reviewer Rules reviewer
    And User clicks Questionnaire Setup button "Cancel"
    And User clicks edit added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "User" option is selected

  @C35993585
  Scenario: C35993585: Questionnaire Setup - Reviewer Settings - verify that user can set Questionnaire reviewer based on rule - Supplier Region
    When User adds up to 2 questions with multiply types for active tab
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "Responsible Party" option is selected
    And Add Rule drop-down field is displayed
    And Rule Type field is displayed
    And Reviewer Rule options is displayed
      | User              |
      | User Group        |
      | Responsible Party |
    When User selects "Third-party Region" Reviewer Rules for rule 1
    Then Name of Rule Type drop-down is "Third-party Region"
    When User selects 2 values as rule type for rule 1
    Then "Third-party Region" Rule Type drop-down contains selected values
    And User clicks "User Group" Reviewer Rule option
    Then Reviewer drop-down contains 50 active user groups with default "Refine your keywords to show relevant results" option
    When User selects "AUTO_GROUP" Reviewer Rules reviewer
    Then Reviewer "AUTO_GROUP" is selected
    When User clicks "Responsible Party" Reviewer Rule option
    Then Questionnaire Rules Reviewer drop-down is disabled
    When User clicks "User" Reviewer Rule option
    Then Questionnaire Rules Reviewer drop-down contains active users
    When User selects "Assignee_AT_FN Assignee_AT_LN" Reviewer Rules reviewer
    Then Reviewer "Assignee_AT_FN Assignee_AT_LN" is selected
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "User" option is selected
    When User clicks "User" Reviewer Rule option
    And User selects "Admin_AT_FN Admin_AT_LN" Reviewer Rules reviewer
    And User clicks Questionnaire Setup button "Cancel"
    And User clicks edit added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "User" option is selected

  @C35993617
  Scenario: C35993617: Questionnaire Setup - Reviewer Settings - verify that user can set Questionnaire reviewer based on rule - Supplier Commodity Type
    When User adds up to 2 questions with multiply types for active tab
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "Responsible Party" option is selected
    And Add Rule drop-down field is displayed
    And Rule Type field is displayed
    And Reviewer Rule options is displayed
      | User              |
      | User Group        |
      | Responsible Party |
    When User selects "Third-party Commodity Type" Reviewer Rules for rule 1
    Then Name of Rule Type drop-down is "Third-party Commodity Type"
    When User selects 2 values as rule type for rule 1
    Then "Third-party Commodity Type" Rule Type drop-down contains selected values
    And User clicks "User Group" Reviewer Rule option
    Then Reviewer drop-down contains 50 active user groups with default "Refine your keywords to show relevant results" option
    When User selects "AUTO_GROUP" Reviewer Rules reviewer
    Then Reviewer "AUTO_GROUP" is selected
    When User clicks "Responsible Party" Reviewer Rule option
    Then Questionnaire Rules Reviewer drop-down is disabled
    When User clicks "User" Reviewer Rule option
    Then Questionnaire Rules Reviewer drop-down contains active users
    When User selects "Assignee_AT_FN Assignee_AT_LN" Reviewer Rules reviewer
    Then Reviewer "Assignee_AT_FN Assignee_AT_LN" is selected
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "User" option is selected
    When User clicks "User" Reviewer Rule option
    And User selects "Admin_AT_FN Admin_AT_LN" Reviewer Rules reviewer
    And User clicks Questionnaire Setup button "Cancel"
    And User clicks edit added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "User" option is selected

  @C35994029
  Scenario: C35994029: Questionnaire Setup - Reviewer Settings - verify that user can set Questionnaire reviewer based on rule - Supplier Workflow Group
    When User adds up to 2 questions with multiply types for active tab
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "Responsible Party" option is selected
    And Add Rule drop-down field is displayed
    And Rule Type field is displayed
    And Reviewer Rule options is displayed
      | User              |
      | User Group        |
      | Responsible Party |
    When User selects "Third-party Workflow Group" Reviewer Rules for rule 1
    Then Name of Rule Type drop-down is "Third-party Workflow Group"
    When User selects 2 values as rule type for rule 1
    Then "Third-party Workflow Group" Rule Type drop-down contains selected values
    And User clicks "User Group" Reviewer Rule option
    Then Reviewer drop-down contains 50 active user groups with default "Refine your keywords to show relevant results" option
    When User selects "AUTO_GROUP" Reviewer Rules reviewer
    Then Reviewer "AUTO_GROUP" is selected
    When User clicks "Responsible Party" Reviewer Rule option
    Then Questionnaire Rules Reviewer drop-down is disabled
    When User clicks "User" Reviewer Rule option
    Then Questionnaire Rules Reviewer drop-down contains active users
    When User selects "Assignee_AT_FN Assignee_AT_LN" Reviewer Rules reviewer
    Then Reviewer "Assignee_AT_FN Assignee_AT_LN" is selected
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "User" option is selected
    When User clicks "User" Reviewer Rule option
    And User selects "Admin_AT_FN Admin_AT_LN" Reviewer Rules reviewer
    And User clicks Questionnaire Setup button "Cancel"
    And User clicks edit added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "User" option is selected

  @C35996087
  Scenario: C35996087: Questionnaire Setup - Reviewer Settings - Set Questionnaire reviewer based on rule - Questionnaire Score
    When User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User fills in choice score on position 1 value "3"
    And User clicks Questionnaire Setup button "Next"
    When User fills "with scoring 0 to 1" required questionnaire scoring information
    And User clicks Questionnaire Setup button "Done"
    And User fills "with scoring 2 to 3" required questionnaire scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "Responsible Party" option is selected
    And Add Rule drop-down field is displayed
    And Rule Type field is displayed
    And Reviewer Rule options is displayed
      | User              |
      | User Group        |
      | Responsible Party |
    When User selects "Questionnaire Score" Reviewer Rules for rule 1
    Then Name of Rule Type drop-down is "Questionnaire Score"
    When User selects 2 values as rule type for rule 1
    Then "Questionnaire Score" Rule Type drop-down contains selected values
    And User clicks "User Group" Reviewer Rule option
    Then Reviewer drop-down contains 50 active user groups with default "Refine your keywords to show relevant results" option
    When User selects "AUTO_GROUP" Reviewer Rules reviewer
    Then Reviewer "AUTO_GROUP" is selected
    When User clicks "Responsible Party" Reviewer Rule option
    Then Questionnaire Rules Reviewer drop-down is disabled
    When User clicks "User" Reviewer Rule option
    Then Questionnaire Rules Reviewer drop-down contains active users
    When User selects "Assignee_AT_FN Assignee_AT_LN" Reviewer Rules reviewer
    Then Reviewer "Assignee_AT_FN Assignee_AT_LN" is selected
    And  User clicks "Scoring" questionnaire tab
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "User" option is selected
    And User clicks "User" Reviewer Rule option
    And User selects "Admin_AT_FN Admin_AT_LN" Reviewer Rules reviewer
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks edit added questionnaire
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "User" option is selected

  @C35997300
  Scenario: C35997300: Questionnaire Setup - Reviewer Settings - User can add/remove multiple reviewer rule/-s - add multiple Rules
    When User adds up to 1 questions with multiply types for active tab
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rule "Responsible Party" option is selected
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Region" Reviewer Rules for rule 1
    And User selects 1 values as rule type for rule 1
    Then Reviewer Rules 'Add Rules' button is enabled
    When User adds up to 20 random Reviewer Rules for expanded Level
    And User clicks Delete icon for Reviewer rule 21
    Then Reviewer Rule with number 21 is not displayed
    And Delete button is displayed for Main Reviewer Questionnaire rule
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table
