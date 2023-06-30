@ui @cacao @functional @questionnaires @questionnaireReviewers
Feature: Questionnaire Management - Settings Reviewers Tab - Add

  As an internal RDDC user,
  I want to be able to add Reviewer to the new questionnaire,
  So that I can configure the questionnaire

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Questionnaire Management page

  @C46305309
  Scenario: C46305309: [Questionnaire] - Add - Reviewer Tab: Settings - Default values
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / ADD QUESTIONNAIRE" is displayed
    And Questionnaire setup "Settings" tab is selected
    And Questionnaire setup "Reviewers" tab is selected
    And Questionnaire setup "Information" tab is active
    And Questionnaire setup "Question" tab is disabled
    And Questionnaire setup "Scoring" tab is disabled
    And Questionnaire setup "Rules" tab is active
    And Questionnaire setup "Process Flow" tab is active
    And Questionnaire Reviewers Number of Reviewer levels is "1"
    And Questionnaire Reviewers Setting toggles are set to "OFF" and "disabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for  |
      | Hide total score from reviewers                   | Hide from    |
      | Require mandatory comment for review and changes  | Required for |
      | Hide question score from reviewers                | Hide from    |
    And Current URL contains "/ui/admin/questionnaire-management/questionnaires/add" endpoint
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled

  @C46305715
  Scenario: C46305715: [Questionnaire] - Add - Reviewer Tab: Settings - Save as Draft
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Allow total score adjustment by entering a number" option on Reviewers tab
    And User selects Reviewers Settings "Allow total score adjustment by entering a number" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |
    And Questionnaire Reviewers Settings "Allow total score adjustment by entering a number" selected values are
      | Level 1 |
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Hide total score from reviewers" option on Reviewers tab
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Hide total score from reviewers | Hide from |
    And Questionnaire Reviewers Settings "Hide total score from reviewers" selected values are
      |  |

  @C46305964
  Scenario: C46305964: [Questionnaire] - Add - Reviewer Tab: Settings - Save
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Require mandatory comment for review and changes" option on Reviewers tab
    And User selects Reviewers Settings "Require mandatory comment for review and changes" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Require mandatory comment for review and changes | Required for |
    And Questionnaire Reviewers Settings "Require mandatory comment for review and changes" selected values are
      | Level 1 |

  @C46305879
  Scenario: C46305879: [Questionnaire] - Add - Reviewer Tab: Settings - Next
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Hide question score from reviewers" option on Reviewers tab
    And User selects Reviewers Settings "Hide question score from reviewers" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Question" tab is selected
    When User clicks "Reviewers" questionnaire tab
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Hide question score from reviewers | Hide from |
    And Questionnaire Reviewers Settings "Hide question score from reviewers" selected values are
      | Level 1 |

  @C46305596
  Scenario: C46305596: [Questionnaire] - Add - Reviewer Tab: Settings - Click Cancel
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Require mandatory comment for review and changes" option on Reviewers tab
    And User selects Reviewers Settings "Require mandatory comment for review and changes" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table

  @C46308162
  Scenario: C46308162: [Questionnaire] - Add - Reviewer Tab: Settings - Validations
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Hide total score from reviewers" option on Reviewers tab
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Hide from" field

  @C46306008
  Scenario Outline: C46306008: [Questionnaire] - Add - Reviewer Tab: Settings - Fields behavior
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    Then "Reviewers" Tab is displayed
    And Questionnaire Reviewers subtab "Settings" is displayed
    And Questionnaire Reviewers Number of Reviewer levels is "1"
    And Questionnaire Reviewers Settings "<settingsDropDown>" drop-down is not required
    When User clicks toggle "<settingsDropDown>" option on Reviewers tab
    Then Questionnaire Reviewers Settings "<settingsDropDown>" drop-down is required
    And Questionnaire Reviewers Settings "<settingsDropDown>" drop-down contains
      | Level 1 |
    When User selects Number of Reviewer Levels "5"
    Then Questionnaire Reviewers Settings "<settingsDropDown>" drop-down contains
      | Level 1 |
      | Level 2 |
      | Level 3 |
      | Level 4 |
      | Level 5 |
    When User selects Reviewers Settings "<settingsDropDown>" drop-down value "Level 1"
    And User selects Reviewers Settings "<settingsDropDown>" drop-down value "Level 3"
    And User selects Reviewers Settings "<settingsDropDown>" drop-down value "Level 5"
    Then Questionnaire Reviewers Settings "<settingsDropDown>" selected values are
      | Level 1 |
      | Level 3 |
      | Level 5 |
    When User selects Number of Reviewer Levels "3"
    Then Questionnaire Reviewers Settings "<settingsDropDown>" selected values are
      | Level 1 |
      | Level 3 |
    When User clicks Questionnaire Reviewers Settings "<settingsDropDown>" drop-down cross icon for value "Level 1"
    Then Questionnaire Reviewers Settings "<settingsDropDown>" selected values are
      | Level 3 |
    When User selects Reviewers Settings "<settingsDropDown>" drop-down value "Level 1"
    Then Questionnaire Reviewers Settings "<settingsDropDown>" selected values are
      | Level 3 |
      | Level 1 |
    When User clicks Questionnaire Setup button "Next"
    And User adds up to 1 questions with multiply types for active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "<buttonName>"
    Then Questionnaire is displayed on questionnaires table
    When User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    When User clicks Questionnaire Setup button "Next"
    Then Questionnaire Reviewers Settings "<settingsDropDown>" selected values are
      | Level 3 |
      | Level 1 |
    And Questionnaire Reviewers Number of Reviewer levels is "3"
    And User Questionnaire Reviewers Settings toggle "<settingsDropDown>" is enabled
    Examples:
      | settingsDropDown                                  | buttonName    |
      | Allow total score adjustment by entering a number | Save          |
      | Hide total score from reviewers                   | Save          |
      | Require mandatory comment for review and changes  | Save as draft |
      | Hide question score from reviewers                | Save as draft |
