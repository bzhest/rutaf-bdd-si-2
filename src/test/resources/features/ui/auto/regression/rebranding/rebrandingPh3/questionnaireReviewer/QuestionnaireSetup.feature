@ui @rebranding
Feature: Rebranding - Questionnaire Reviewer

  As a product owner,
  I want to update Reviewer to the new admin user in Questionnaire Reviewer
  So that admin user in Questionnaire Reviewer will assign to the new admin user.

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Questionnaire Management page
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button


  @C37452742
    @core_regression
  Scenario Outline: C37452742: Questionnaire Setup - verify that user can create Internal/External Questionnaire
    Then Add Questionnaire setup page displayed
    When User fills "<questionnaireData>" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    Then "Reviewers" Tab is displayed
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User" as Main Reviewer
    And User fills current user name as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    And User should be able to add up to 1 questions with multiply types for active tab
    When User clicks Configuration icon
    And User fills "<questionnaireData>" question details
    And User clicks Questionnaire Setup button "Next"
    And User clicks "Question" questionnaire tab
    Then "Question" Tab is displayed
    When User clicks Configuration icon
    Then Question fields contains provided data
    When User clicks Questionnaire Setup button "Next"
    Then "Scoring" Tab is displayed
    And Scoring tab contains message "No Scoring Scheme is Available"
    When User fills "<questionnaireData>" required questionnaire scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Questionnaire Scores are displayed on scoring table with provided details
    When User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table
    Examples:
      | questionnaireData            |
      | with completed data          |
      | with completed Internal data |

  @C37452743
  @core_regression
  Scenario: C37452743: Questionnaire Setup - verify that user can edit existing Questionnaire setup
    When User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    When User fills "with completed data" required questionnaire setup information
    Then Questionnaire Setup button "Save as draft" is displayed
    When User clicks Questionnaire Setup button "Next"
    Then "Reviewers" Tab is displayed
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User" as Main Reviewer
    And User fills current user name as Main Reviewer
    Then Questionnaire Setup button "Save as draft" is displayed
    When User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    And User should be able to add up to 1 questions with multiply types for active tab
    When User clicks Configuration icon
    And User fills "with completed data" question details
    Then Questionnaire Setup button "Save as draft" is displayed
    When User clicks Questionnaire Setup button "Next"
    Then "Scoring" Tab is displayed
    And Scoring tab contains message "No Scoring Scheme is Available"
    When User fills "with completed data" required questionnaire scoring information
    And User clicks Questionnaire Setup button "Done"
    Then Questionnaire Scores are displayed on scoring table with provided details
    And Questionnaire Setup button "Save as draft" is displayed
    When User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clears Questionnaire Name
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    When User fills "with completed data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks delete question button for question on position 1
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    When User should be able to add up to 1 questions with multiply types for active tab
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User Group" as Main Reviewer
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon for Questionnaire page is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    When User selects "User" as Main Reviewer
    And User fills current user name as Main Reviewer
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table

  @C37447483
  @core_regression
  Scenario: C37447483: Questionnaire Setup - Reviewer Settings - verify that user can set Questionnaire reviewer based on rule - Third-party Country
    When User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Country" Rule Type drop-down contains expected values
    When User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User selects "Thailand" as rule type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "Albania,Thailand" is displayed for Reviewer Level 1 and rule 1
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User clicks Questionnaire Reviewers "Reviewers" tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania,Thailand" is displayed for Reviewer Level 1 and rule 1

  @C37447484
  @full_regression
  Scenario: C37447484: Questionnaire Setup - Reviewer Settings - verify that user can set Questionnaire reviewer based on rule - Third-party Region
    When User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Region" Rule Type drop-down contains expected values
    When User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User selects "Eastern Europe" as rule type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "Asia,Eastern Europe" is displayed for Reviewer Level 1 and rule 1
    When User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    When User fills user "Admin_AT_FN Admin_AT_LN" as Questionnaire Reviewer
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

  @C37447485
  @full_regression
  Scenario: C37447485: Questionnaire Setup - Reviewer Settings - verify that user can set Questionnaire reviewer based on rule - Third-party Commodity Type
    When User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Commodity Type" Rule Type drop-down contains expected values
    When User selects "3PL Services" as rule type Reviewer Level 1 for rule 1
    And User selects "Cleaning" as rule type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "3PL Services,Cleaning" is displayed for Reviewer Level 1 and rule 1
    When User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table

  @C37447486
  @full_regression
  Scenario: C37447486: Questionnaire Setup - Reviewer Settings - verify that user can set Questionnaire reviewer based on rule - Third-party Workflow Group
    When User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Workflow Group" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Workflow Group" Rule Type drop-down contains expected values
    When User selects "Auto Workflow Group Individual with Approver" as rule type Reviewer Level 1 for rule 1
    And User selects "Auto_Workflow_Group_Dashboard" as rule type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "Auto Workflow Group Individual with Approver,Auto_Workflow_Group_Dashboard" is displayed for Reviewer Level 1 and rule 1
    When User selects "User Group" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active user groups
    When User fills user "AUTO_GROUP" as Questionnaire Reviewer
    Then Reviewer "AUTO_GROUP" is selected
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rules "Third-party Workflow Group" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Auto Workflow Group Individual with Approver,Auto_Workflow_Group_Dashboard" is displayed for Reviewer Level 1 and rule 1

  @C37447487
  @full_regression
  Scenario: C37447487: Questionnaire Setup - Reviewer Settings - verify that user can set Questionnaire reviewer based on rule - Questionnaire Score
    When User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Configuration icon
    And User fills in choice score on position 1 value "3"
    And User clicks Questionnaire Setup button "Next"
    And User fills "with scoring 0 to 1" required questionnaire scoring information
    And User clicks Questionnaire Setup button "Done"
    And User fills "with scoring 2 to 3" required questionnaire scoring information
    And User clicks Questionnaire Setup button "Done"
    And User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Questionnaire Score" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Questionnaire Score" Rule Type drop-down contains expected values
    When User selects "Scoring Test Name 0" as rule type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "Scoring Test Name 0" is displayed for Reviewer Level 1 and rule 1
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User clicks Questionnaire Reviewers "Reviewers" tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rules "Questionnaire Score" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Scoring Test Name 0" is displayed for Reviewer Level 1 and rule 1
