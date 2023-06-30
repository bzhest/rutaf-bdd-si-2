@ui @cacao @functional @questionnaires @questionnaireReviewers
Feature: Questionnaire Management - Rules Reviewers Tab - Rules Reviewer selection - Add

  As an Admin or Internal User that has access right
  I Want to allow user to setup rules to trigger Questionnaire reviewer based on rules
  So That Client have the flexibility to set up different reviewer depending on their process and according to supplier information


  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"


  @C46330714
  Scenario: C46330714: Rules Reviewer selection - verify that user can set Questionnaire reviewer based on rule - Third-party Country
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    And Questionnaire Reviewers Rules displays the next Reviewer Levels
      | Level 1 Reviewer |
      | Level 2 Reviewer |
      | Level 3 Reviewer |
      | Level 4 Reviewer |
      | Level 5 Reviewer |
    And Questionnaire Reviewer Rules "Level 1 Reviewer" is expanded
    And Questionnaire Reviewer Rules "Level 2 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 3 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 4 Reviewer" is collapsed
    And Questionnaire Reviewer Rules "Level 5 Reviewer" is collapsed
    And Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 1 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Country" Rule Type drop-down contains expected values
    When User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User selects "Thailand" as rule type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "Albania,Thailand" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 2 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 2 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Country" Rule Type drop-down contains expected values
    When User selects "Armenia" as rule type Reviewer Level 2 for rule 1
    And User selects "Thailand" as rule type Reviewer Level 2 for rule 1
    Then Reviewer Rule type "Armenia,Thailand" is displayed for Reviewer Level 2 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 3 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 3 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Country" Rule Type drop-down contains expected values
    When User selects "Albania" as rule type Reviewer Level 3 for rule 1
    And User selects "Thailand" as rule type Reviewer Level 3 for rule 1
    Then Reviewer Rule type "Albania,Thailand" is displayed for Reviewer Level 3 and rule 1
    When User selects "User Group" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active user groups
    When User fills user "AUTO_GROUP" as Questionnaire Reviewer
    And User fills user "Assignee Group" as Questionnaire Reviewer
    Then Reviewer "Assignee Group" is selected
    When User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 4 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 4 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Country" Rule Type drop-down contains expected values
    When User selects "Albania" as rule type Reviewer Level 4 for rule 1
    And User selects "Aruba" as rule type Reviewer Level 4 for rule 1
    Then Reviewer Rule type "Albania,Aruba" is displayed for Reviewer Level 4 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 5 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 5 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Country" Rule Type drop-down contains expected values
    When User selects "Albania" as rule type Reviewer Level 5 for rule 1
    And User selects "Thailand" as rule type Reviewer Level 5 for rule 1
    Then Reviewer Rule type "Albania,Thailand" is displayed for Reviewer Level 5 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User clicks Questionnaire Reviewers "Reviewers" tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania,Thailand" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Reviewer Rules "Third-party Country" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Armenia,Thailand" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Reviewer Rules "Third-party Country" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "Albania,Thailand" is displayed for Reviewer Level 3 and rule 1
    When User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    Then Reviewer Rules "Third-party Country" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rule type "Albania,Aruba" is displayed for Reviewer Level 4 and rule 1
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    Then Reviewer Rules "Third-party Country" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "Albania,Thailand" is displayed for Reviewer Level 5 and rule 1

  @C46330715
  Scenario: C46330715: Rules Reviewer selection - verify that user can set Questionnaire reviewer based on rule - Third-party Region
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Region" Rule Type drop-down contains expected values
    When User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User selects "Eastern Europe" as rule type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "Asia,Eastern Europe" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 2 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Region" Reviewer Rules Reviewer Level 2 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Region" Rule Type drop-down contains expected values
    When User selects "Americas" as rule type Reviewer Level 2 for rule 1
    And User selects "Eastern Europe" as rule type Reviewer Level 2 for rule 1
    Then Reviewer Rule type "Americas,Eastern Europe" is displayed for Reviewer Level 2 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 3 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Region" Reviewer Rules Reviewer Level 3 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Region" Rule Type drop-down contains expected values
    When User selects "Asia" as rule type Reviewer Level 3 for rule 1
    And User selects "Eastern Europe" as rule type Reviewer Level 3 for rule 1
    Then Reviewer Rule type "Asia,Eastern Europe" is displayed for Reviewer Level 3 and rule 1
    When User selects "User Group" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active user groups
    When User fills user "AUTO_GROUP" as Questionnaire Reviewer
    And User fills user "Assignee Group" as Questionnaire Reviewer
    Then Reviewer "Assignee Group" is selected
    When User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 4 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Region" Reviewer Rules Reviewer Level 4 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Region" Rule Type drop-down contains expected values
    When User selects "Asia" as rule type Reviewer Level 4 for rule 1
    And User selects "Oceania" as rule type Reviewer Level 4 for rule 1
    Then Reviewer Rule type "Asia,Oceania" is displayed for Reviewer Level 4 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 5 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Region" Reviewer Rules Reviewer Level 5 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Region" Rule Type drop-down contains expected values
    When User selects "Asia" as rule type Reviewer Level 5 for rule 1
    And User selects "Eastern Europe" as rule type Reviewer Level 5 for rule 1
    Then Reviewer Rule type "Asia,Eastern Europe" is displayed for Reviewer Level 5 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rules "Third-party Region" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Asia,Eastern Europe" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Reviewer Rules "Third-party Region" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Americas,Eastern Europe" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Reviewer Rules "Third-party Region" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "Asia,Eastern Europe" is displayed for Reviewer Level 3 and rule 1
    When User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    Then Reviewer Rules "Third-party Region" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rule type "Asia,Oceania" is displayed for Reviewer Level 4 and rule 1
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    Then Reviewer Rules "Third-party Region" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "Asia,Eastern Europe" is displayed for Reviewer Level 5 and rule 1

  @C46330716
  Scenario: C46330716: Rules Reviewer selection - verify that user can set Questionnaire reviewer based on rule - Third-party Commodity Type
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Commodity Type" Rule Type drop-down contains expected values
    When User selects "3PL Services" as rule type Reviewer Level 1 for rule 1
    And User selects "Cleaning" as rule type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "3PL Services,Cleaning" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 2 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 2 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Commodity Type" Rule Type drop-down contains expected values
    When User selects "Clinical Trials" as rule type Reviewer Level 2 for rule 1
    And User selects "Cleaning" as rule type Reviewer Level 2 for rule 1
    Then Reviewer Rule type "Clinical Trials,Cleaning" is displayed for Reviewer Level 2 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 3 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 3 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Commodity Type" Rule Type drop-down contains expected values
    When User selects "3PL Services" as rule type Reviewer Level 3 for rule 1
    And User selects "Cleaning" as rule type Reviewer Level 3 for rule 1
    Then Reviewer Rule type "3PL Services,Cleaning" is displayed for Reviewer Level 3 and rule 1
    When User selects "User Group" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active user groups
    When User fills user "AUTO_GROUP" as Questionnaire Reviewer
    And User fills user "Assignee Group" as Questionnaire Reviewer
    Then Reviewer "Assignee Group" is selected
    When User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 4 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 4 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Commodity Type" Rule Type drop-down contains expected values
    When User selects "3PL Services" as rule type Reviewer Level 4 for rule 1
    And User selects "Clinical Services" as rule type Reviewer Level 4 for rule 1
    Then Reviewer Rule type "3PL Services,Clinical Services" is displayed for Reviewer Level 4 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 5 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 5 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Commodity Type" Rule Type drop-down contains expected values
    When User selects "3PL Services" as rule type Reviewer Level 5 for rule 1
    And User selects "Cleaning" as rule type Reviewer Level 5 for rule 1
    Then Reviewer Rule type "3PL Services,Cleaning" is displayed for Reviewer Level 5 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table

  @C46330717
  Scenario: C46330717: Rules Reviewer selection - verify that user can set Questionnaire reviewer based on rule - Questionnaire Score
    When User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User fills in choice score on position 1 value "3"
    And User clicks Questionnaire Setup button "Next"
    And User fills "with scoring 0 to 1" required questionnaire scoring information
    And User clicks Questionnaire Setup button "Done"
    And User fills "with scoring 2 to 3" required questionnaire scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks "Reviewers" questionnaire tab
    And User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Questionnaire Score" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Questionnaire Score" Rule Type drop-down contains expected values
    When User selects "Scoring Test Name 0" as rule type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "Scoring Test Name 0" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 2 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Questionnaire Score" Reviewer Rules Reviewer Level 2 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Questionnaire Score" Rule Type drop-down contains expected values
    When User selects "Scoring Test Name 1" as rule type Reviewer Level 2 for rule 1
    Then Reviewer Rule type "Scoring Test Name 1" is displayed for Reviewer Level 2 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 3 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Questionnaire Score" Reviewer Rules Reviewer Level 3 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Questionnaire Score" Rule Type drop-down contains expected values
    When User selects "Scoring Test Name 0" as rule type Reviewer Level 3 for rule 1
    And User selects "Scoring Test Name 1" as rule type Reviewer Level 3 for rule 1
    Then Reviewer Rule type "Scoring Test Name 0,Scoring Test Name 1" is displayed for Reviewer Level 3 and rule 1
    When User selects "User Group" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active user groups
    When User fills user "AUTO_GROUP" as Questionnaire Reviewer
    And User fills user "Assignee Group" as Questionnaire Reviewer
    Then Reviewer "Assignee Group" is selected
    When User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 4 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Questionnaire Score" Reviewer Rules Reviewer Level 4 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Questionnaire Score" Rule Type drop-down contains expected values
    When User selects "Scoring Test Name 0" as rule type Reviewer Level 4 for rule 1
    Then Reviewer Rule type "Scoring Test Name 0" is displayed for Reviewer Level 4 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 5 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Questionnaire Score" Reviewer Rules Reviewer Level 5 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Questionnaire Score" Rule Type drop-down contains expected values
    When User selects "Scoring Test Name 0" as rule type Reviewer Level 5 for rule 1
    And User selects "Scoring Test Name 1" as rule type Reviewer Level 5 for rule 1
    Then Reviewer Rule type "Scoring Test Name 0,Scoring Test Name 1" is displayed for Reviewer Level 5 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User clicks Questionnaire Reviewers "Reviewers" tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rules "Questionnaire Score" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Scoring Test Name 0" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Reviewer Rules "Questionnaire Score" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Scoring Test Name 1" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Reviewer Rules "Questionnaire Score" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "Scoring Test Name 0,Scoring Test Name 1" is displayed for Reviewer Level 3 and rule 1
    When User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    Then Reviewer Rules "Questionnaire Score" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rule type "Scoring Test Name 0" is displayed for Reviewer Level 4 and rule 1
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    Then Reviewer Rules "Questionnaire Score" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "Scoring Test Name 0,Scoring Test Name 1" is displayed for Reviewer Level 5 and rule 1

  @C46330721
  Scenario: C46330721: Rules Reviewer selection - verify that user can set Questionnaire reviewer based on rule - Third-party Workflow Group
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Workflow Group" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Workflow Group" Rule Type drop-down contains expected values
    When User selects "Auto Workflow Group Individual with Approver" as rule type Reviewer Level 1 for rule 1
    And User selects "Auto_Workflow_Group_Dashboard" as rule type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "Auto Workflow Group Individual with Approver,Auto_Workflow_Group_Dashboard" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 2 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Workflow Group" Reviewer Rules Reviewer Level 2 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Workflow Group" Rule Type drop-down contains expected values
    When User selects "Auto Workflow Group Organisation with Approver" as rule type Reviewer Level 2 for rule 1
    And User selects "Auto_Workflow_Group_Dashboard" as rule type Reviewer Level 2 for rule 1
    Then Reviewer Rule type "Auto Workflow Group Organisation with Approver,Auto_Workflow_Group_Dashboard" is displayed for Reviewer Level 2 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 3 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Workflow Group" Reviewer Rules Reviewer Level 3 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Workflow Group" Rule Type drop-down contains expected values
    When User selects "Auto Workflow Group Individual with Approver" as rule type Reviewer Level 3 for rule 1
    And User selects "Auto_Workflow_Group_Dashboard" as rule type Reviewer Level 3 for rule 1
    Then Reviewer Rule type "Auto Workflow Group Individual with Approver,Auto_Workflow_Group_Dashboard" is displayed for Reviewer Level 3 and rule 1
    When User selects "User Group" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active user groups
    When User fills user "AUTO_GROUP" as Questionnaire Reviewer
    And User fills user "Assignee Group" as Questionnaire Reviewer
    Then Reviewer "Assignee Group" is selected
    When User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 4 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Workflow Group" Reviewer Rules Reviewer Level 4 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Workflow Group" Rule Type drop-down contains expected values
    When User selects "Auto Workflow Group Individual with Approver" as rule type Reviewer Level 4 for rule 1
    And User selects "Auto Questionnaire" as rule type Reviewer Level 4 for rule 1
    Then Reviewer Rule type "Auto Workflow Group Individual with Approver,Auto Questionnaire" is displayed for Reviewer Level 4 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 5 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Workflow Group" Reviewer Rules Reviewer Level 5 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Workflow Group" Rule Type drop-down contains expected values
    When User selects "Auto Workflow Group Individual with Approver" as rule type Reviewer Level 5 for rule 1
    And User selects "Auto_Workflow_Group_Dashboard" as rule type Reviewer Level 5 for rule 1
    Then Reviewer Rule type "Auto Workflow Group Individual with Approver,Auto_Workflow_Group_Dashboard" is displayed for Reviewer Level 5 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rules "Third-party Workflow Group" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Auto Workflow Group Individual with Approver,Auto_Workflow_Group_Dashboard" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Reviewer Rules "Third-party Workflow Group" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Auto Workflow Group Organisation with Approver,Auto_Workflow_Group_Dashboard" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Reviewer Rules "Third-party Workflow Group" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "Auto Workflow Group Individual with Approver,Auto_Workflow_Group_Dashboard" is displayed for Reviewer Level 3 and rule 1
    When User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    Then Reviewer Rules "Third-party Workflow Group" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rule type "Auto Workflow Group Individual with Approver,Auto Questionnaire" is displayed for Reviewer Level 4 and rule 1
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    Then Reviewer Rules "Third-party Workflow Group" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "Auto Workflow Group Individual with Approver,Auto_Workflow_Group_Dashboard" is displayed for Reviewer Level 5 and rule 1

  @C46348976
  Scenario: C46348976: Rules Reviewer selection - verify that user can set Questionnaire reviewer based on rule - Risk Tier
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Risk Tier" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Risk Tier" Rule Type drop-down contains expected values
    When User selects "Low" as rule type Reviewer Level 1 for rule 1
    And User selects "Medium" as rule type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "Low,Medium" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 2 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Risk Tier" Reviewer Rules Reviewer Level 2 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Risk Tier" Rule Type drop-down contains expected values
    When User selects "High" as rule type Reviewer Level 2 for rule 1
    And User selects "Medium" as rule type Reviewer Level 2 for rule 1
    Then Reviewer Rule type "High,Medium" is displayed for Reviewer Level 2 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 3 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Risk Tier" Reviewer Rules Reviewer Level 3 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Risk Tier" Rule Type drop-down contains expected values
    When User selects "Low" as rule type Reviewer Level 3 for rule 1
    And User selects "Medium" as rule type Reviewer Level 3 for rule 1
    Then Reviewer Rule type "Low,Medium" is displayed for Reviewer Level 3 and rule 1
    When User selects "User Group" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active user groups
    When User fills user "AUTO_GROUP" as Questionnaire Reviewer
    And User fills user "Assignee Group" as Questionnaire Reviewer
    Then Reviewer "Assignee Group" is selected
    When User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 4 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Risk Tier" Reviewer Rules Reviewer Level 4 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Risk Tier" Rule Type drop-down contains expected values
    When User selects "Low" as rule type Reviewer Level 4 for rule 1
    And User selects "High" as rule type Reviewer Level 4 for rule 1
    Then Reviewer Rule type "Low,High" is displayed for Reviewer Level 4 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 5 and rule 1
    And Questionnaire Rules Rule Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Risk Tier" Reviewer Rules Reviewer Level 5 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Risk Tier" Rule Type drop-down contains expected values
    When User selects "Low" as rule type Reviewer Level 5 for rule 1
    And User selects "Medium" as rule type Reviewer Level 5 for rule 1
    Then Reviewer Rule type "Low,Medium" is displayed for Reviewer Level 5 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills user "Assignee_AT_FN Assignee_AT_LN" as Questionnaire Reviewer
    And User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table

  @C46349054
  Scenario: C46349054: Rules Reviewer selection - verify that user can set Questionnaire reviewer based on rule - Third-party Manager
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Manager" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is disabled
    And Reviewer Rules 'Add Rules' button is enabled
    And Questionnaire Rules Rule Reviewer radio buttons are disabled
      | User              |
      | User Group        |
      | Responsible Party |
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Manager" Reviewer Rules Reviewer Level 2 for rule 1
    Then Questionnaire Rule Type is disabled
    And Reviewer Rules 'Add Rules' button is enabled
    And Questionnaire Rules Rule Reviewer radio buttons are disabled
      | User              |
      | User Group        |
      | Responsible Party |
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Manager" Reviewer Rules Reviewer Level 3 for rule 1
    Then Questionnaire Rule Type is disabled
    And Reviewer Rules 'Add Rules' button is enabled
    And Questionnaire Rules Rule Reviewer radio buttons are disabled
      | User              |
      | User Group        |
      | Responsible Party |
    When User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Manager" Reviewer Rules Reviewer Level 4 for rule 1
    Then Questionnaire Rule Type is disabled
    And Reviewer Rules 'Add Rules' button is enabled
    And Questionnaire Rules Rule Reviewer radio buttons are disabled
      | User              |
      | User Group        |
      | Responsible Party |
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rules 'Add Rules' button is disabled
    When User selects "Third-party Manager" Reviewer Rules Reviewer Level 5 for rule 1
    Then Questionnaire Rule Type is disabled
    And Reviewer Rules 'Add Rules' button is enabled
    And Questionnaire Rules Rule Reviewer radio buttons are disabled
      | User              |
      | User Group        |
      | Responsible Party |
    When User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Manager" Reviewer Rules Reviewer Level 1 for rule 1
    And User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    And User selects "Third-party Manager" Reviewer Rules Reviewer Level 2 for rule 1
    And User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    And User selects "Third-party Manager" Reviewer Rules Reviewer Level 3 for rule 1
    And User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    And User selects "Third-party Manager" Reviewer Rules Reviewer Level 4 for rule 1
    And User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    And User selects "Third-party Manager" Reviewer Rules Reviewer Level 5 for rule 1
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User clicks Questionnaire Reviewers "Reviewers" tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rules "Third-party Manager" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Reviewer Rules "Third-party Manager" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Reviewer Rules "Third-party Manager" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 3 and rule 1
    When User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    Then Reviewer Rules "Third-party Manager" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 4 and rule 1
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    Then Reviewer Rules "Third-party Manager" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 5 and rule 1
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rules "Third-party Manager" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Reviewer Rules "Third-party Manager" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Reviewer Rules "Third-party Manager" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 3 and rule 1
    When User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    Then Reviewer Rules "Third-party Manager" is displayed for Reviewer Level 4 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 4 and rule 1
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    Then Reviewer Rules "Third-party Manager" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 5 and rule 1

  @C46368890
  Scenario: C46368890: Rules Reviewer selection - verify that user can add 30 rules in Reviewers Tab: Rules
    When User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    Then Questionnaire Reviewer Rules contains 1 numerated rules
    And Reviewer Rules 'Add Rules' button is enabled
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User clicks Questionnaire Reviewer Add Rule button
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Questionnaire Rules Reviewer drop-down is disabled
    And Reviewer Rules 'Add Rules' button is disabled
    And Delete button is displayed for each Reviewer Questionnaire rule
    And Questionnaire Reviewer Rules contains 2 numerated rules
    When User selects "Third-party Region" Reviewer Rules Reviewer Level 1 for rule 2
    Then Questionnaire Rules Rule Reviewer radio buttons are enabled
      | User              |
      | User Group        |
      | Responsible Party |
    When User selects "Asia" as rule type Reviewer Level 1 for rule 2
    Then Reviewer Rules 'Add Rules' button is enabled
    When User drags and drops Reviewer Rules rule 2 in Reviewer Level 1
    Then Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 2
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 2
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 1 and rule 1
    When User adds up to 28 random Reviewer Rules for expanded Level
    Then Questionnaire Reviewer Rules contains 30 numerated rules
    And Delete button is displayed for each Reviewer Questionnaire rule
    When User clicks Questionnaire Reviewer Add Rule button
    Then Alert Icon is displayed with text
      | Cannot Add! Exceed the limit of the number of rules |
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    And User selects "Third-party Country" Reviewer Rules Reviewer Level 5 for rule 1
    And User selects "Albania" as rule type Reviewer Level 5 for rule 1
    Then Questionnaire Reviewer Rules contains 1 numerated rules
    And Reviewer Rules 'Add Rules' button is enabled
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 5 and rule 1
    When User clicks Questionnaire Reviewer Add Rule button
    Then Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Questionnaire Rules Reviewer drop-down is disabled
    And Reviewer Rules 'Add Rules' button is disabled
    And Delete button is displayed for each Reviewer Questionnaire rule
    And Questionnaire Reviewer Rules contains 2 numerated rules
    When User selects "Third-party Region" Reviewer Rules Reviewer Level 5 for rule 2
    Then Questionnaire Rules Rule Reviewer radio buttons are enabled
      | User              |
      | User Group        |
      | Responsible Party |
    When User selects "Asia" as rule type Reviewer Level 5 for rule 2
    Then Reviewer Rules 'Add Rules' button is enabled
    When User drags and drops Reviewer Rules rule 2 in Reviewer Level 5
    Then Reviewer Rules "Third-party Country" is displayed for Reviewer Level 5 and rule 2
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 5 and rule 2
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 5 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 5 and rule 1
    When User adds up to 28 random Reviewer Rules for expanded Level
    Then Questionnaire Reviewer Rules contains 30 numerated rules
    And Delete button is displayed for each Reviewer Questionnaire rule
    When User clicks Questionnaire Reviewer Add Rule button
    Then Alert Icon is displayed with text
      | Cannot Add! Exceed the limit of the number of rules |
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User clicks Questionnaire Reviewers "Reviewers" tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Reviewer Rules contains 30 numerated rules
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Reviewer Rules contains 30 numerated rules
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Reviewer Rules contains 30 numerated rules
    When User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Questionnaire Reviewer Rules contains 30 numerated rules

  @C46406521
  Scenario: C46406521: Rules Reviewer selection - verify the fields behavior while clicking "X" in Rules section in Reviewers Tab: Rules
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User selects "User" as Reviewer
    And User fills current user name as Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User deletes Reviewer Rules Rule value for Level 1 for rule 1
    Then Reviewer Rules "" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 1 and rule 1
    And Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer "" is selected
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User selects "User Group" as Reviewer
    And User selects "AUTO_GROUP" Reviewer Rules reviewer
    Then Reviewer "AUTO_GROUP" is selected
    When User deletes Reviewer Rules Rule value for Level 1 for rule 1
    Then Reviewer Rules "" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 1 and rule 1
    And Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer "" is selected
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User selects "User Group" as Reviewer
    And User selects "AUTO_GROUP" Reviewer Rules reviewer
    And User deletes Reviewer Rule Type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "" is displayed for Reviewer Level 1 and rule 1
    And Questionnaire Rules "Third-party Country" input is highlighted
    And Error message "This field is required" is displayed near Questionnaire Rules rule "Third-party Country" input
    When User selects "User" as Reviewer
    And User fills current user name as Reviewer
    And User deletes Questionnaire Rules Reviewer
    Then Reviewer "" is selected
    And Questionnaire Rules "Reviewer" input is highlighted
    And Error message "This field is required" is displayed near Questionnaire Rules rule "Reviewer" input
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table
