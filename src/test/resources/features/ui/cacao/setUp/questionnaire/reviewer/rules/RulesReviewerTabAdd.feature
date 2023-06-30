@ui @cacao @functional @questionnaires @questionnaireReviewers
Feature: Questionnaire Management - Rules Reviewers Tab - Add

  As an RDDC internal user with relevant permissions
  I want to set up Reviewer rules
  So that I can manage the users, who have rights to review questionnaires


  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab

  @C46309698
  Scenario: C46309698: Add Questionnaire - Reviewers Tab: Rules - Main Reviewer is Responsible Party
    Then Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / ADD QUESTIONNAIRE" is displayed
    And Questionnaire Rules sections are displayed
      | Main Reviewer |
      | Rules         |
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    And Questionnaire Rules Main Reviewer radio buttons are displayed
      | User              |
      | User Group        |
      | Responsible Party |
    And Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer input is disabled
    And Questionnaire Reviewers Rules displays the next Reviewer Levels
      | Level 1 Reviewer |
    And Reviewer Rules "" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 1 and rule 1
    And Questionnaire Rules Reviewer drop-down is disabled
    When User selects "Third-party Region" Reviewer Rules for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User selects Number of Reviewer Levels "2"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    And User selects "Third-party Country" Reviewer Rules Reviewer Level 2 for rule 1
    And User selects "Albania" as rule type Reviewer Level 2 for rule 1
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rules "Third-party Region" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Reviewer Rules "Third-party Country" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 2 and rule 1
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rules "Third-party Region" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 1 and rule 1
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Reviewer Rules "Third-party Country" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 2 and rule 1

  @C46310068
  Scenario: C46310068: Add Questionnaire - Reviewers Tab: Rules - Main Reviewer is a User
    When User selects "User" as Main Reviewer
    Then Main Reviewer field is displayed as required
    And Questionnaire Rules Main Reviewer drop-down contains active users
    When User fills current user name as Main Reviewer
    Then Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"
    When User deletes Questionnaire Rules Main Reviewer
    And User selects "User" as Main Reviewer
    Then Questionnaire Rules Main Reviewer value is ""
    And Questionnaire Rules Main Reviewer input is highlighted
    And Error message "This field is required" is displayed near Questionnaire Rules Main Reviewer input
    When User searches Questionnaire Rules Main Reviewer by "MediaCheck" keyword
    Then Questionnaire Rules Main Reviewer drop-down contains values
      | MediaCheck PermissionOn\nuser.media.check.permission.on.username   |
      | MediaCheck PermissionOff\nuser.media.check.permission.off.username |
    When User searches Questionnaire Rules Main Reviewer by "PermissionOff" keyword
    Then Questionnaire Rules Main Reviewer drop-down contains values
      | Screening PermissionOff\nuser.screening.permission.off.username    |
      | MediaCheck PermissionOff\nuser.media.check.permission.off.username |
    When User searches Questionnaire Rules Main Reviewer by "Assignee_AT_FN Assignee_AT_LN" keyword
    Then Questionnaire Rules Main Reviewer drop-down contains values
      | Assignee_AT_FN Assignee_AT_LN\nassignee.username |
    When User searches Questionnaire Rules Main Reviewer by "admin.username" keyword
    Then Questionnaire Rules Main Reviewer drop-down contains values
      | Admin_AT_FN Admin_AT_LN\nadmin.username |
    When User fills current user name as Main Reviewer
    Then Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"
    When User selects "User Group" as Main Reviewer
    Then Questionnaire Rules Main Reviewer value is ""
    When User selects "User" as Main Reviewer
    And User fills current user name as Main Reviewer
    And User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User" as Main Reviewer
    And User fills current user name as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"

  @C46318749
  Scenario: C46318749: Add Questionnaire - Reviewers Tab: Rules - Main Reviewer is a User Group
    When User selects "User Group" as Main Reviewer
    Then Main Reviewer field is displayed as required
    And Questionnaire Rules Main Reviewer drop-down contains active user groups
    When User fills "Assignee Group" value as Main Reviewer
    And User deletes Questionnaire Rules Main Reviewer
    And User selects "User Group" as Main Reviewer
    Then Questionnaire Rules Main Reviewer value is ""
    And Questionnaire Rules Main Reviewer input is highlighted
    And Error message "This field is required" is displayed near Questionnaire Rules Main Reviewer input
    When User searches Questionnaire Rules Main Reviewer by "Assignee" keyword
    Then Questionnaire Rules Main Reviewer drop-down contains values
      | Assignee Group |
    When User fills "AUTO_GROUP" value as Main Reviewer
    Then Questionnaire Rules Main Reviewer value is "AUTO_GROUP"
    When User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User Group" as Main Reviewer
    And User fills "AUTO_GROUP" value as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules Main Reviewer value is "AUTO_GROUP"
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules Main Reviewer value is "AUTO_GROUP"
