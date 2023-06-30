@ui @cacao @functional @questionnaires @questionnaireReviewers
Feature: Questionnaire Management - Settings Reviewers Tab - Edit

  As an RDDC user with permission to manage questionnaires
  I want to be able to manage edit saved questionnaires
  So that I can update the information to actual


  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Questionnaire Management page

  @C46309692
  Scenario: C46309692: [Questionnaire] - Edit from Main page- Reviewer Tab: Settings - Save as Draft
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
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User clicks toggle "Allow total score adjustment by entering a number" option on Reviewers tab
    And User clicks toggle "Require mandatory comment for review and changes" option on Reviewers tab
    And User selects Reviewers Settings "Require mandatory comment for review and changes" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Reviewers Setting toggles are set to "Off" and "disabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |
    And Questionnaire Reviewers Settings "Allow total score adjustment by entering a number" selected values are
      |  |
    And Questionnaire Reviewers Setting toggles are set to "On" and "enabled" drop-down
      | Require mandatory comment for review and changes | Required for |
    And Questionnaire Reviewers Settings "Require mandatory comment for review and changes" selected values are
      | Level 1 |
    When User clicks toggle "Require mandatory comment for review and changes" option on Reviewers tab
    And User clicks toggle "Allow total score adjustment by entering a number" option on Reviewers tab
    And User selects Reviewers Settings "Allow total score adjustment by entering a number" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Reviewers Setting toggles are set to "On" and "enabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |
    And Questionnaire Reviewers Settings "Allow total score adjustment by entering a number" selected values are
      | Level 1 |
    And Questionnaire Reviewers Setting toggles are set to "Off" and "disabled" drop-down
      | Require mandatory comment for review and changes | Required for |
    And Questionnaire Reviewers Settings "Require mandatory comment for review and changes" selected values are
      |  |

  @C46309731 @C46333410
  Scenario: C46309731, C46333410: [Questionnaire] - Edit from View Reviewers tab - Reviewer Tab: Settings - Save as Draft
  [Questionnaire] - Edit - Reviewer Tab: Settings - No Validations - Save as Draft
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Allow total score adjustment by entering a number" option on Reviewers tab
    And User selects Reviewers Settings "Allow total score adjustment by entering a number" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire tab displayed in view mode
    And Questionnaire setup "Settings" tab is selected
    And Questionnaire setup "Reviewers" tab is selected
    When User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |
    And Questionnaire Reviewers Settings "Allow total score adjustment by entering a number" selected values are
      | Level 1 |
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User clicks toggle "Hide total score from reviewers" option on Reviewers tab
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Edit questionnaire button
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Hide total score from reviewers | Hide from |
    And Questionnaire Reviewers Settings "Hide total score from reviewers" selected values are
      |  |
    When User selects Reviewers Settings "Hide total score from reviewers" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Edit questionnaire button
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |
    And Questionnaire Reviewers Settings "Allow total score adjustment by entering a number" selected values are
      | Level 1 |
    And Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Hide total score from reviewers | Hide from |
    And Questionnaire Reviewers Settings "Hide total score from reviewers" selected values are
      | Level 1 |

  @C46309867
  Scenario: C46309867: [Questionnaire] - Edit from other tab - Reviewer Tab: Settings - Saved as Draft
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Allow total score adjustment by entering a number" option on Reviewers tab
    And User selects Reviewers Settings "Allow total score adjustment by entering a number" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire tab displayed in edit mode
    And Questionnaire setup "Settings" tab is selected
    And Questionnaire setup "Reviewers" tab is selected
    And Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |
    And Questionnaire Reviewers Settings "Allow total score adjustment by entering a number" selected values are
      | Level 1 |
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    When User clicks toggle "Hide total score from reviewers" option on Reviewers tab
    And User clicks Questionnaire Setup button "Save as draft"
    Then Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire tab displayed in edit mode
    And Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Hide total score from reviewers | Hide from |
    And Questionnaire Reviewers Settings "Hide total score from reviewers" selected values are
      |  |
    When User selects Reviewers Settings "Hide total score from reviewers" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |
    And Questionnaire Reviewers Settings "Allow total score adjustment by entering a number" selected values are
      | Level 1 |
    And Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Hide total score from reviewers | Hide from |
    And Questionnaire Reviewers Settings "Hide total score from reviewers" selected values are
      | Level 1 |

  @C46309696
  Scenario: C46309696: [Questionnaire] - Edit from Main page - Reviewer Tab: Settings - Save
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Require mandatory comment for review and changes" option on Reviewers tab
    And User selects Reviewers Settings "Require mandatory comment for review and changes" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire tab displayed in edit mode
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Require mandatory comment for review and changes | Required for |
    And Questionnaire Reviewers Settings "Require mandatory comment for review and changes" selected values are
      | Level 1 |

  @C46309861
  Scenario: C46309861: [Questionnaire] - Edit from View Reviewers page- Reviewer Tab: Settings - Save
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Edit questionnaire button
    Then Questionnaire tab displayed in edit mode
    When User clicks toggle "Require mandatory comment for review and changes" option on Reviewers tab
    And User selects Reviewers Settings "Require mandatory comment for review and changes" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Require mandatory comment for review and changes | Required for |
    And Questionnaire Reviewers Settings "Require mandatory comment for review and changes" selected values are
      | Level 1 |

  @C46309736
  Scenario: C46309736: [Questionnaire] - Edit from other tab - Reviewer Tab: Settings - Save
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire tab displayed in edit mode
    When User clicks toggle "Require mandatory comment for review and changes" option on Reviewers tab
    And User selects Reviewers Settings "Require mandatory comment for review and changes" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Require mandatory comment for review and changes | Required for |
    And Questionnaire Reviewers Settings "Require mandatory comment for review and changes" selected values are
      | Level 1 |

  @C46319883
  Scenario: C46319883: [Questionnaire] - Edit from Main page - Reviewer Tab: Settings - Next and Save
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Require mandatory comment for review and changes" option on Reviewers tab
    And User selects Reviewers Settings "Require mandatory comment for review and changes" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Require mandatory comment for review and changes | Required for |
    And Questionnaire Reviewers Settings "Require mandatory comment for review and changes" selected values are
      | Level 1 |

  @C46309702
  Scenario: C46309702: [Questionnaire] - Edit- Reviewer Tab: Settings - Cancel
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Allow total score adjustment by entering a number" option on Reviewers tab
    And User selects Reviewers Settings "Allow total score adjustment by entering a number" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Allow total score adjustment by entering a number" option on Reviewers tab
    Then Questionnaire Reviewers Setting toggles are set to "Off" and "disabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks Edit questionnaire button
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |
    And Questionnaire Reviewers Settings "Allow total score adjustment by entering a number" selected values are
      | Level 1 |
    When User clicks toggle "Allow total score adjustment by entering a number" option on Reviewers tab
    Then Questionnaire Reviewers Setting toggles are set to "Off" and "disabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |
    And Questionnaire Reviewers Settings "Allow total score adjustment by entering a number" selected values are
      | Level 1 |
    When User clicks toggle "Allow total score adjustment by entering a number" option on Reviewers tab
    Then Questionnaire Reviewers Setting toggles are set to "Off" and "disabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |
    When User clicks Questionnaire Setup button "Cancel"
    And User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire Reviewers Setting toggles are set to "ON" and "enabled" drop-down
      | Allow total score adjustment by entering a number | Allowed for |

  @C46333409
  Scenario: C46333409: [Questionnaire] - Edit - Reviewer Tab: Settings - Validations - Save
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Hide total score from reviewers" option on Reviewers tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Hide from" field
    When User selects Reviewers Settings "Hide total score from reviewers" drop-down value "Level 1"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Allow total score adjustment by entering a number" option on Reviewers tab
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Allowed for" field
    When User selects Reviewers Settings "Allow total score adjustment by entering a number" drop-down value "Level 1"
    And User clicks "Information" questionnaire tab
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Setup button "Next"
    And User clicks toggle "Require mandatory comment for review and changes" option on Reviewers tab
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Required for" field

  @C46309877
  Scenario Outline: C46309877: [Questionnaire] - Edit- Reviewer Tab: Settings - Fields behavior
    When User clicks Add Questionnaire button
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Settings" tab is selected
    And Questionnaire setup "Reviewers" tab is selected
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

