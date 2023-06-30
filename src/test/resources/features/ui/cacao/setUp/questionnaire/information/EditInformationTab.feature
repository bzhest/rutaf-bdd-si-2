@ui @cacao @functional @questionnaires
Feature: Questionnaire Management - Information Tab - Edit Questionnaire

  As an internal RDDC user,
  I want to be able to edit information about the questionnaire,
  So that I can update the questionnaire when needed

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page

  @C46318642
  Scenario: C46318642: [Questionnaire] - Information Tab - Edit - Internal - Saved as Draft
    When User fills "with completed Internal data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    Then Questionnaire Information contains expected fields types
    When User fills in Questionnaire Language "Zulu"
    Then Remove icon is displayed for each selected language for Questionnaire
    When User clicks remove icon for "Afar" Questionnaire language
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this language? Any translations will be deleted. |
    And Confirmation button Cancel should be displayed
    And Confirmation button Delete should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Questionnaire languages are displayed "English,Afar,Zulu"
    When User clicks remove icon for "Afar" Questionnaire language
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Questionnaire languages are displayed "English,Zulu"
    When User clicks remove icon for "Zulu" Questionnaire language
    And User clicks Delete button on confirmation window
    And User refreshes page
    And User fills "with completed data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Save as draft"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been Saved As Draft |
    When User clicks on added questionnaire
    Then Questionnaire's Setup Information page contains provided details

  @C46319882
  Scenario: C46319882: [Questionnaire] - Information Tab - Edit - External - Saved as Draft
    When User fills "with completed data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    Then Questionnaire Information contains expected fields types
    When User fills in Questionnaire Language "Zulu"
    Then Remove icon is displayed for each selected language for Questionnaire
    When User clicks remove icon for "Afar" Questionnaire language
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this language? Any translations will be deleted. |
    And Confirmation button Cancel should be displayed
    And Confirmation button Delete should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Questionnaire languages are displayed "English,Afar,Zulu"
    When User clicks remove icon for "Afar" Questionnaire language
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Questionnaire languages are displayed "English,Zulu"
    When User clicks remove icon for "Zulu" Questionnaire language
    And User clicks Delete button on confirmation window
    And User refreshes page
    And User fills "with completed Internal data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Save as draft"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been Saved As Draft |
    When User clicks on added questionnaire
    Then Questionnaire's Setup Information page contains provided details

  @C46320096
  Scenario: C46320096: [Questionnaire] - Information Tab - Edit - Saved as Draft - Verify Validations
    When User fills "with completed Internal data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clears Questionnaire Name
    And User clicks Questionnaire Setup button "Save as draft"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Questionnaire Name" field
    When User clicks Questionnaire Setup button "Next"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Questionnaire Name" field
    When User clicks "Reviewers" questionnaire tab
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Questionnaire Name" field
    When User fills in Questionnaire Name with value "AUTO_TEST_EXTERNAL_QUESTIONNAIRE"
    And User clicks Questionnaire Setup button "Save as draft"
    Then Alert Icon is displayed with text
      | Cannot Save. Questionnaire with this name already exists |
    And Error message "Questionnaire with this name already exists" is displayed for Questionnaire "Questionnaire Name" field
    When User fills in Questionnaire Name with value "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Questionnaire with this name already exists |
    And Error message "Questionnaire with this name already exists" is displayed for Questionnaire "Questionnaire Name" field

  @C46320785
  Scenario: C46320785: [Questionnaire] - Information Tab - Edit - External - Published (Active Status)
    When User fills "with completed data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    Then Questionnaire Information contains expected fields types
    When User fills in Questionnaire Language "Zulu"
    Then Remove icon is displayed for each selected language for Questionnaire
    When User clicks remove icon for "Afar" Questionnaire language
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this language? Any translations will be deleted. |
    And Confirmation button Cancel should be displayed
    And Confirmation button Delete should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Questionnaire languages are displayed "English,Afar,Zulu"
    When User clicks remove icon for "Afar" Questionnaire language
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Questionnaire languages are displayed "English,Zulu"
    When User clicks remove icon for "Zulu" Questionnaire language
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Questionnaire languages are displayed "English"
    And User fills "with completed Internal data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    When User clicks on added questionnaire
    Then Questionnaire's Setup Information page contains provided details

  @C46320792
  Scenario: C46320792: [Questionnaire] - Information Tab - Edit - Internal - Published (Inactive Status)
    When User fills "with completed Internal data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User fills in Questionnaire Name with value "Edit Name"
    And User fills in Questionnaire Category with value "AUTO_TEST_CATEGORY"
    And User fills in Questionnaire Description with value "Edit Description"
    And User clears Questionnaire Header
    And User fills in Questionnaire Header text "Edit Description" and click "Bold" Froala button
    And User fills in Questionnaire Language "Afar"
    And User selects in Question Assignee Type "External"
    And User clicks Questionnaire Setup button "Cancel"
    And User clicks on added questionnaire
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Edit questionnaire button
    And User fills "with completed data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks "Information" questionnaire tab
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    And Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    Then Questionnaire's Setup Information page contains provided details

  @C46321342
  Scenario: C46321342: [Questionnaire] - Information Tab - Edit - Published - Verify Validations
    When User fills "with completed Internal data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clears Questionnaire Name
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Questionnaire Name" field
    When User clicks Questionnaire Setup button "Next"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Questionnaire Name" field
    When User clicks "Reviewers" questionnaire tab
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Questionnaire Name" field
    When User fills in Questionnaire Name with value "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Questionnaire with this name already exists |
    And Error message "Questionnaire with this name already exists" is displayed for Questionnaire "Questionnaire Name" field
    When User fills in Questionnaire Name with value "AUTO_TEST_EXTERNAL_QUESTIONNAIRE"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Cannot Save. Questionnaire with this name already exists |
    And Error message "Questionnaire with this name already exists" is displayed for Questionnaire "Questionnaire Name" field

  @C46321084
  Scenario: C46321084: [Questionnaire] - Information Tab - Edit - Published - Activation/Deactivation
    When User fills "with completed Internal data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    Then Questionnaire Management questionnaire status is "Inactive"
    When User selects "Active" questionnaire status
    And User clicks Questionnaire Setup button "Next"
    And User clicks "Information" questionnaire tab
    Then Questionnaire Management questionnaire status is "Active"
    When User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    And Questionnaire is displayed on questionnaires table with status - "Active"
    When User clicks on added questionnaire
    Then Questionnaire Management questionnaire status is "Active"
    When User clicks Edit questionnaire button
    Then Questionnaire Management questionnaire status is "Active"
    When User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table with status - "Inactive"
