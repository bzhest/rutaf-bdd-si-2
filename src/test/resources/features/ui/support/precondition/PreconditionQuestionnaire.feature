@ui @precondition @create_questionnaires
Feature: Risk Remediation Precondition Creation

  Scenario: 2: Create Questionnaire IN REVIEW
    Given User logs into RDDC as "Admin"
    Then Questionnaire with "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW" name is not created
    When User navigates to Questionnaire Management page
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW" required questionnaire setup information without context
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds question with type "Boolean" to active tab
    And User adds question with type "Currency" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User clicks Configuration icon for Question "Boolean"
    And User toggles "Allow attachment"
    And User clicks Configuration icon for Question "Boolean"
    And User clicks Configuration icon for Question "Checkbox"
    And User fills choice name "Choice #1" with value "Auto Test Checkbox"
    And User fills choice name "Choice #2" with value "Auto Checkbox Test"
    And User clicks Add question tab button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User clicks to edit Question tab name on position 2
    And User fills tab name "Tab two" for tab and click save
    And User adds question with type "Heading" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Add question tab button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 2
    And User clicks to edit Question tab name on position 3
    And User fills tab name "Tab three" for tab and click save
    And User adds question with type "Currency" to active tab
    And User adds question with type "Boolean" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW" is displayed on questionnaires table

  Scenario: 2: Create Questionnaire External LEVEL 2 IN REVIEW
    Given User logs into RDDC as "Admin"
    Then Questionnaire with "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_2_IN_REVIEW" name is not created
    When User navigates to Questionnaire Management page
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_2_IN_REVIEW" required questionnaire setup information without context
    And User clicks Questionnaire Setup button "Next"
    Then "Reviewers" Tab is displayed
    When User selects Number of Reviewer Levels "2"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User" as Main Reviewer
    And User fills "Assignee_AT_FN Assignee_AT_LN" value as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds question with type "Currency" to active tab
    And User adds question with type "Heading" to active tab
    And User clicks Configuration icon
    And User toggles "Allow attachment"
    And User clicks Add question tab button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User clicks to edit Question tab name on position 2
    And User fills tab name "Tab two" for tab and click save
    And User adds question with type "Boolean" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_2_IN_REVIEW" is displayed on questionnaires table

  Scenario: 2: Create Questionnaire COMPLETED
    Given User logs into RDDC as "Admin"
    Then Questionnaire with "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" name is not created
    When User navigates to Questionnaire Management page
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" required questionnaire setup information without context
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds question with type "Currency" to active tab
    And User adds question with type "Boolean" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED" is displayed on questionnaires table

  Scenario: 2: Create Questionnaire BRANCHING QUESTIONS
    Given User logs into RDDC as "Admin"
    Then Questionnaire with "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS" name is not created
    When User navigates to Questionnaire Management page
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS" required questionnaire setup information without context
    And User clicks Questionnaire Setup button "Next"
    Then "Reviewers" Tab is displayed
    When User selects Number of Reviewer Levels "2"
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds question with type "SingleSelect" to active tab
    And User adds question with type "Boolean" to active tab
    And User clicks Configuration icon for Question "Boolean"
    And User toggles Red Flag for choice "Choice #1"
    And User selects Branch Question tab name "Tab One" for choice "Yes"
    And User selects Branch Question question "SingleSelect" for choice "Yes"
    And User selects Branch Question tab name "Tab One" for choice "No"
    And User selects Branch Question question "SingleSelect" for choice "No"
    And User clicks Configuration icon for Question "Boolean"
    And User clicks Configuration icon for Question "SingleSelect"
    And User fills choice name "Choice #1" with value "Single Select 1"
    And User fills choice name "Choice #2" with value "Single Select 2"
    And User toggles Red Flag for choice "Choice #1"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS" is displayed on questionnaires table

  Scenario: 2: Create Questionnaire MAPPED ASSESSMENT
    Given User logs into RDDC as "Admin"
    Then Questionnaire with "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT" name is not created
    When User navigates to Questionnaire Management page
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT" required questionnaire setup information without context
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds question with type "Boolean" to active tab
    And User clicks Configuration icon for Question "Boolean"
    And User toggles Red Flag for choice "Choice #1"
    And User clicks Configuration icon for Question "Boolean"
    And User adds question with type "Checkbox" to active tab
    And User clicks Configuration icon for Question "Checkbox"
    And User toggles Red Flag for choice "Choice #1"
    And User clicks Configuration icon for Question "Checkbox"
    And User adds question with type "SingleSelect" to active tab
    And User clicks Configuration icon for Question "SingleSelect"
    And User toggles Red Flag for choice "Choice #1"
    And User clicks Configuration icon for Question "SingleSelect"
    And User adds question with type "Multiple Choice" to active tab
    And User clicks Configuration icon for Question "Multiple Choice"
    And User toggles Red Flag for choice "Choice #1"
    And User clicks Configuration icon for Question "Multiple Choice"
    And User adds question with type "MultiSelect" to active tab
    And User clicks Configuration icon for Question "MultiSelect"
    And User toggles Red Flag for choice "Choice #1"
    And User clicks Configuration icon for Question "MultiSelect"
    And User adds question with type "Currency" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT" is displayed on questionnaires table

  Scenario: 2: Create Questionnaire EXTERNAL
    Given User logs into RDDC as "Admin"
    Then Questionnaire with "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" name is not created
    When User navigates to Questionnaire Management page
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" required questionnaire setup information without context
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    Then "Question" Tab is displayed
    When User adds question with type "Currency" to active tab
    And User adds question with type "Boolean" to active tab
    And User adds question with type "Checkbox" to active tab
    And User adds question with type "SingleSelect" to active tab
    And User adds question with type "Multiple Choice" to active tab
    And User adds question with type "MultiSelect" to active tab
    And User adds question with type "Heading" to active tab
    And User adds question with type "Date" to active tab
    And User adds question with type "Text" to active tab
    And User adds question with type "Number" to active tab
    And User adds question with type "TextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Configuration icon
    And User toggles "Allow attachment"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire "AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL" is displayed on questionnaires table