@ui @cacao @functional @questionnaires @questionnaireReviewers
Feature: Questionnaire Management - Rules Reviewers Tab - Edit

  AS an RDDC user with permission to manage questionnaires
  I WANT TO be able to manage edit saved questionnaires
  SO THAT I can update the information to actual

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"

  @C46326157
  Scenario: C46326157: [Questionnaire] - Edit - Reviewer Tab:Rules - Saved as Draft - Edit from different pages - Main page
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in edit mode
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 1 and rule 1
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in edit mode
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "3PL Services" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in edit mode
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 1 and rule 1

  @C46326157
  Scenario: C46326157: [Questionnaire] - Edit - Reviewer Tab:Rules - Saved as Draft - Edit from different pages - Reviewers->Rules
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 1 and rule 1
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "3PL Services" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 1 and rule 1

  @C46326157
  Scenario: C46326157: [Questionnaire] - Edit - Reviewer Tab:Rules - Saved as Draft - Edit from different pages - Any tab except Reviewers
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in edit mode
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 1 and rule 1
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in edit mode
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "3PL Services" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in edit mode
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 1 and rule 1

  @C46326157
  Scenario: C46326157: [Questionnaire] - Edit - Reviewer Tab:Rules - Saved as Draft - Edit from different pages - Subtab Reviewers->Settings
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in edit mode
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 1 and rule 1
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in edit mode
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "3PL Services" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in edit mode
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 1 and rule 1

  @C46333406
  Scenario: C46333406: [Questionnaire] - Edit - Reviewer Tab:Rules - Active/Inactive - Edit from different pages
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 1 and rule 1
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Albania" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    When User selects "Third-party Manager" Reviewer Rules Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    And Reviewer Rules "Third-party Manager" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 1 and rule 1
    When User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "3PL Services" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Inactive"
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    And Reviewer Rules "Third-party Commodity Type" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "3PL Services" is displayed for Reviewer Level 1 and rule 1
    When User selects "Risk Tier" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "Low" as rule type Reviewer Level 1 for rule 1
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Inactive"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire tab displayed in edit mode
    And Reviewer Rules "Risk Tier" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Low" is displayed for Reviewer Level 1 and rule 1

  @C46330085
  Scenario: C46330085: [Questionnaire] - Edit- Reviewer Tab:Rules- Main Reviewer Responsible Party
    When User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User" as Main Reviewer
    And User fills current user name as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / toBeReplaced / EDIT" is displayed
    When User selects "Responsible Party" as Main Reviewer
    Then Questionnaire Rules Main Reviewer input is disabled
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer input is disabled
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User" is selected as Main Reviewer
    When User selects "Responsible Party" as Main Reviewer
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    When User selects "User" as Main Reviewer
    And User fills current user name as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Responsible Party" as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User clicks "Reviewers" questionnaire tab
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "Responsible Party" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer input is disabled
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Responsible Party" as Main Reviewer
    Then Questionnaire Rules Main Reviewer input is disabled

  @C46330723
  Scenario: C46330723: [Questionnaire] - Edit- Reviewer Tab:Rules - Main Reviewer User
    When User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User" as Main Reviewer
    Then Main Reviewer field is displayed as required
    And Questionnaire Rules Main Reviewer drop-down contains active users
    When User fills current user name as Main Reviewer
    Then Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"
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
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules Main Reviewer value is "Admin_AT_FN Admin_AT_LN"

  @C46332272
  Scenario: C46332272: [Questionnaire] - Edit- Reviewer Tab:Rules - Main Reviewer Group
    When User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User Group" as Main Reviewer
    Then Main Reviewer field is displayed as required
    And Questionnaire Rules Main Reviewer drop-down contains active user groups
    When User fills "Assignee Group" value as Main Reviewer
    Then Questionnaire Rules Main Reviewer value is "Assignee Group"
    When User selects "User" as Main Reviewer
    Then Questionnaire Rules Main Reviewer value is ""
    When User selects "User Group" as Main Reviewer
    And User fills "AUTO_GROUP" value as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Inactive"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules Main Reviewer value is "AUTO_GROUP"

  @C46458698
  Scenario: C46458698: [Questionnaire] - Edit- Reviewer Tab:Rules - Main Reviewer - Validations
    When User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User Group" as Main Reviewer
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User Group" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is ""
    When User selects "User" as Main Reviewer
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Rules "User" is selected as Main Reviewer
    And Questionnaire Rules Main Reviewer value is ""
    When User fills current user name as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User Group" as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Questionnaire Rules Main Reviewer input is highlighted
    And Error message "This field is required" is displayed near Questionnaire Rules Main Reviewer input
    When User selects "User" as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Questionnaire Rules Main Reviewer input is highlighted
    And Error message "This field is required" is displayed near Questionnaire Rules Main Reviewer input

  @C46627180
  Scenario Outline: C46627180: [Questionnaire] - Edit- Reviewer Tab:Rules- Reviewers Rules - Level 1 - Rule Type dropdown
    When User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<buttonName>"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Reviewers Rules displays the next Reviewer Levels
      | Level 1 Reviewer |
    And Questionnaire Rules "Responsible Party" is selected as Reviewer
    And Reviewer Rules "" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rules 'Add Rules' button is disabled
    And Questionnaire Rules Rule drop-down contains values
      | Third-party Manager        |
      | Third-party Commodity Type |
      | Third-party Region         |
      | Third-party Country        |
      | Third-party Workflow Group |
      | Questionnaire Score        |
      | Risk Tier                  |
    When User selects "Risk Tier" Reviewer Rules Reviewer Level 1 for rule 1
    Then Reviewer Rules "Risk Tier" is displayed for Reviewer Level 1 and rule 1
    When User deletes Reviewer Rules Rule value for Level 1 for rule 1
    Then Reviewer Rules "" is displayed for Reviewer Level 1 and rule 1
    When User selects "Third-party Manager" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is disabled
    When User selects "Third-party Commodity Type" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Commodity Type" Rule Type drop-down contains expected values
    When User selects "Third-party Region" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Region" Rule Type drop-down contains expected values
    When User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Country" Rule Type drop-down contains expected values
    When User selects "Third-party Workflow Group" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Third-party Workflow Group" Rule Type drop-down contains expected values
    When User selects "Questionnaire Score" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Questionnaire Score" Rule Type drop-down contains expected values
    When User selects "Risk Tier" Reviewer Rules Reviewer Level 1 for rule 1
    Then Questionnaire Rule Type is enabled
    And Questionnaire "Risk Tier" Rule Type drop-down contains expected values
    When User selects "Third-party Region" Reviewer Rules for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User selects "Americas" as rule type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "Asia,Americas" is displayed for Reviewer Level 1 and rule 1
    When User deletes Reviewer Rule Type Reviewer Level 1 for rule 1
    Then Reviewer Rule type "" is displayed for Reviewer Level 1 and rule 1
    Examples:
      | buttonName    |
      | Save          |
      | Save as draft |

  @C46627180
  Scenario Outline: C46627180: [Questionnaire] - Edit- Reviewer Tab:Rules- Reviewers Rules - Level 1 - Radiobutton Reviewer behavior
    When User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<buttonName>"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    When User selects "Third-party Region" Reviewer Rules for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User selects "User" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active users
    When User fills current user name as Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User deletes Questionnaire Rules Reviewer
    Then Reviewer "" is selected
    When User fills current user name as Reviewer
    Then Reviewer "Admin_AT_FN Admin_AT_LN" is selected
    When User selects "User Group" as Reviewer
    Then Reviewer "" is selected
    When User selects "User Group" as Reviewer
    Then Reviewer field is displayed as required
    And Questionnaire Rules Reviewer drop-down contains active user groups
    When User selects "AUTO_GROUP" Reviewer Rules reviewer
    Then Reviewer "AUTO_GROUP" is selected
    When User deletes Questionnaire Rules Reviewer
    Then Reviewer "" is selected
    When User selects "AUTO_GROUP" Reviewer Rules reviewer
    Then Reviewer "AUTO_GROUP" is selected
    When User selects "User" as Reviewer
    Then Reviewer "" is selected
    Examples:
      | buttonName    |
      | Save          |
      | Save as draft |

  @C46627180
  Scenario Outline: C46627180: [Questionnaire] - Edit- Reviewer Tab:Rules- Reviewers Rules - Level 1 - Add rule+ button
    When User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<buttonName>"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    When User selects "Third-party Region" Reviewer Rules for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    And User adds up to 29 random Reviewer Rules for expanded Level
    Then Questionnaire Reviewer Rules contains 30 numerated rules
    When User clicks Questionnaire Reviewer Add Rule button
    Then Alert Icon is displayed with text
      | Cannot Add! Exceed the limit of the number of rules |
    When User clicks Delete icon for Reviewer rule 29
    Then Reviewer Rule with number 30 is not displayed
    And Questionnaire Reviewer Rules contains 29 numerated rules
    And Delete button is displayed for each Reviewer Questionnaire rule
    When User clicks Questionnaire Setup button "<buttonName>"
    Then Questionnaire is displayed on questionnaires table with status - "<status>"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Reviewers Rules displays the next Reviewer Levels
      | Level 1 Reviewer |
    And Questionnaire Reviewer Rules contains 29 numerated rules
    Examples:
      | buttonName    | status         |
      | Save          | Active         |
      | Save as draft | Saved As Draft |

  @C46627206
  Scenario Outline: C46627206: [Questionnaire] - Edit- Reviewer Tab:Rules- Reviewers Rules - Updates in Settings Level 1-5
    Then "Reviewers" Tab is displayed
    And Questionnaire Reviewers subtab "Settings" is displayed
    When User selects Number of Reviewer Levels "2"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "Third-party Region" Reviewer Rules for rule 1
    And User selects "Asia" as rule type Reviewer Level 1 for rule 1
    Then Reviewer Rules 'Add Rules' button is enabled
    When User clicks Reviewer Rules 'Add Rules' button for Reviewer Level 1
    And User selects "Third-party Country" Reviewer Rules Reviewer Level 1 for rule 2
    And User selects "Albania" as rule type Reviewer Level 1 for rule 2
    And User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 2 for rule 1
    And User selects "Eastern Europe" as rule type Reviewer Level 2 for rule 1
    And User clicks Questionnaire Setup button "Next"
    And User adds up to 1 questions with multiply types for active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<buttonName>"
    Then Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    When User clicks Questionnaire Setup button "Next"
    Then "Reviewers" Tab is displayed
    And Questionnaire Reviewers subtab "Settings" is displayed
    And Questionnaire Reviewers Number of Reviewer levels is "2"
    When User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / toBeReplaced / EDIT" is displayed
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 2
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 2
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Reviewer Rules "Third-party Region" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Eastern Europe" is displayed for Reviewer Level 2 and rule 1
    When User clicks Questionnaire Reviewers "Settings" tab
    And User selects Number of Reviewer Levels "5"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Reviewers Rules displays the next Reviewer Levels
      | Level 1 Reviewer |
      | Level 2 Reviewer |
      | Level 3 Reviewer |
      | Level 4 Reviewer |
      | Level 5 Reviewer |
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 3 for rule 1
    And User selects "Eastern Europe" as rule type Reviewer Level 3 for rule 1
    And User clicks Reviewer Rules "Level 4 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    And User selects "Third-party Country" Reviewer Rules Reviewer Level 4 for rule 1
    And User selects "Bolivia" as rule type Reviewer Level 4 for rule 1
    And User clicks Reviewer Rules "Level 5 Reviewer"
    And User clicks Reviewer Rules "Level 4 Reviewer"
    And User selects "Third-party Region" Reviewer Rules Reviewer Level 5 for rule 1
    And User selects "Africa" as rule type Reviewer Level 5 for rule 1
    And User clicks Questionnaire Reviewers "Settings" tab
    And User selects Number of Reviewer Levels "3"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Reviewers Rules displays the next Reviewer Levels
      | Level 1 Reviewer |
      | Level 2 Reviewer |
      | Level 3 Reviewer |
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 2
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 2
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Reviewer Rules "Third-party Region" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Eastern Europe" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Reviewer Rules "Third-party Region" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "Eastern Europe" is displayed for Reviewer Level 3 and rule 1
    When User clicks Reviewer Rules "Level 1 Reviewer"
    And User clicks Reviewer Rules "Level 3 Reviewer"
    And User drags and drops Reviewer Rules rule 2 in Reviewer Level 1
    Then Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 1 and rule 2
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 1 and rule 2
    When User clicks Questionnaire Setup button "Next"
    And User adds up to 1 questions with multiply types for active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<buttonName>"
    Then Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    When User clicks Questionnaire Setup button "Next"
    Then "Reviewers" Tab is displayed
    When User clicks Questionnaire Reviewers "Rules" tab
    Then Questionnaire Reviewers Rules displays the next Reviewer Levels
      | Level 1 Reviewer |
      | Level 2 Reviewer |
      | Level 3 Reviewer |
    And Reviewer Rules "Third-party Country" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "Albania" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rules "Third-party Region" is displayed for Reviewer Level 1 and rule 2
    And Reviewer Rule type "Asia" is displayed for Reviewer Level 1 and rule 2
    When User clicks Reviewer Rules "Level 2 Reviewer"
    And User clicks Reviewer Rules "Level 1 Reviewer"
    Then Reviewer Rules "Third-party Region" is displayed for Reviewer Level 2 and rule 1
    And Reviewer Rule type "Eastern Europe" is displayed for Reviewer Level 2 and rule 1
    When User clicks Reviewer Rules "Level 3 Reviewer"
    And User clicks Reviewer Rules "Level 2 Reviewer"
    Then Reviewer Rules "Third-party Region" is displayed for Reviewer Level 3 and rule 1
    And Reviewer Rule type "Eastern Europe" is displayed for Reviewer Level 3 and rule 1
    Examples:
      | buttonName    |
      | Save          |
      | Save as draft |

  @C46627225
    @RMS-30124
  Scenario Outline: C46627225: [Questionnaire] - Edit- Reviewer Tab:Rules- Reviewers Rules - Validations - Rule Type
    When User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "<rule>" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "<ruleType>" as rule type Reviewer Level 1 for rule 1
    And User selects "<radioButton>" as Reviewer
    And User selects "<reviewerValue>" Reviewer Rules reviewer
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    Then Reviewer Rules "<rule>" is displayed for Reviewer Level 1 and rule 1
    And Reviewer Rule type "<ruleType>" is displayed for Reviewer Level 1 and rule 1
    And Questionnaire Rules "<radioButton>" is selected as Reviewer
    And Reviewer "<reviewerValue>" is selected
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Questionnaire "Reviewers" tab is highlighted
    And Questionnaire "Rules" tab is highlighted
    And Questionnaire Rule level "Level 1 Reviewer" is highlighted
    And Questionnaire Rules "<errorField>" input is highlighted
    And Error message "This field is required" is displayed near Questionnaire Rules rule "<errorField>" input
    When User deletes Reviewer Rules Rule value for Level 1 for rule 1
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User selects "<status>" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "<status>"
    When User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "<rule>" Reviewer Rules Reviewer Level 1 for rule 1
    And User selects "<ruleType>" as rule type Reviewer Level 1 for rule 1
    And User selects "<radioButton>" as Reviewer
    And User selects "<reviewerValue>" Reviewer Rules reviewer
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Questionnaire Rules "<errorField>" input is highlighted
    And Questionnaire "Reviewers" tab is highlighted
    And Questionnaire "Rules" tab is highlighted
    And Questionnaire Rule level "Level 1 Reviewer" is highlighted
    And Error message "This field is required" is displayed near Questionnaire Rules rule "<errorField>" input
    Examples:
      | rule                       | ruleType | radioButton       | reviewerValue           | errorField                 | status   |
      | Third-party Country        |          | User Group        | AUTO_GROUP              | Third-party Country        | Active   |
      | Third-party Commodity Type |          | Responsible Party |                         | Third-party Commodity Type | Inactive |
      | Third-party Region         |          | Responsible Party |                         | Third-party Region         | Active   |
      | Third-party Workflow Group |          | User              | Admin_AT_FN Admin_AT_LN | Third-party Workflow Group | Inactive |
      | Questionnaire Score        |          | User Group        | AUTO_GROUP              | Questionnaire Score        | Active   |
      | Risk Tier                  |          | User              | Admin_AT_FN Admin_AT_LN | Risk Tier                  | Inactive |
      | Third-party Country        | Albania  | User Group        |                         | Reviewer                   | Active   |
      | Third-party Country        | Albania  | User              |                         | Reviewer                   | Inactive |
