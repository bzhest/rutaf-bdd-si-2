@ui @cacao @functional @questionnaires
Feature: Questionnaire Management - Information Tab - Add Questionnaire

  As an internal RDDC user,
  I want to be able to add information about the new questionnaire,
  So that I can configure the questionnaire

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page

  @C46294056 @C46340009
  Scenario: C46294056, C46340009: [Questionnaire] - Information Tab - Add - Internal - Save
  Verify that all expected items on Language list are populated. (SIDEV-9349)
    Then Add Questionnaire setup page displayed
    And Current URL contains "/ui/admin/questionnaire-management/questionnaires/add" endpoint
    And Questionnaire setup "Information" tab is selected
    And Questionnaire setup "Reviewers" tab is disabled
    And Questionnaire setup "Question" tab is disabled
    And Questionnaire setup "Scoring" tab is disabled
    And Questionnaire breadcrumb "QUESTIONNAIRE MANAGEMENT / ADD QUESTIONNAIRE" is displayed
    And Questionnaire Setup button "Cancel" is enabled
    And Questionnaire Setup button "Save as draft" is enabled
    And Questionnaire Setup button "Next" is enabled
    And Questionnaire Name field is displayed as required
    And Questionnaire Information contains expected fields types
    And Questionnaire Information contains expected fields with default data
    When User fills in Questionnaire Language "Afar"
    And User fills in Questionnaire Language "Zulu"
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
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Reviewers" tab is selected
    When User clicks "Information" questionnaire tab
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    Then Questionnaire's Setup Information page contains provided details

  @C46305118
  Scenario: C46305118: [Questionnaire] - Information Tab - Add - External - Save
    Then Add Questionnaire setup page displayed
    When User fills "with completed data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire is not displayed on questionnaires table
    When User clicks Add Questionnaire button
    Then Add Questionnaire setup page displayed
    When User fills "with completed data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    Then Questionnaire setup "Reviewers" tab is selected
    When User clicks "Information" questionnaire tab
    Then Questionnaire's Setup Information page contains provided details
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    Then Questionnaire's Setup Information page contains provided details

  @C46305328
  Scenario: C46305328: [Questionnaire] - Information Tab - Add - Internal - Save as Draft
    Then Add Questionnaire setup page displayed
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    And User fills "with completed Internal data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Save as draft"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been Saved As Draft |
    And Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks on added questionnaire
    Then Questionnaire's Setup Information page contains provided details

  @C46305319
  Scenario: C46305319: [Questionnaire] - Information Tab - Add - External - Save as Draft
    Then Add Questionnaire setup page displayed
    When User clicks Questionnaire Management breadcrumb
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    And User fills "with completed data" required questionnaire setup information
    And User clicks Questionnaire Setup button "Save as draft"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been Saved As Draft |
    And Questionnaire is displayed on questionnaires table with status - "Saved As Draft"
    When User clicks on added questionnaire
    Then Questionnaire's Setup Information page contains provided details

  @C46305332
  Scenario: C46305332: [Questionnaire] - Information Tab - Add - Verify Validations
    When User clicks Questionnaire Setup button "Save as draft"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Questionnaire Name" field
    When User clicks Questionnaire Setup button "Next"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" is displayed for Questionnaire "Questionnaire Name" field
    When User fills in Questionnaire Name with value "Test Name"
    And User clicks Questionnaire Setup button "Next"
    And User clicks "Information" questionnaire tab
    And User clears Questionnaire Name
    And User clicks "Reviewers" questionnaire tab
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

  @C46306006
  Scenario: C46306006: [Questionnaire] - Information Tab - Add/Edit - Verify Froala integration
    Then Questionnaire Header Froala buttons are displayed
      | Bold               |
      | Italic             |
      | Underline          |
      | More text          |
      | Align Left         |
      | Align Center       |
      | Align Right        |
      | More paragraph     |
      | Insert link        |
      | Insert table       |
      | Special characters |
      | Undo               |
      | Redo               |
      | More Misc          |
    When User clicks Questionnaire Header Froala "More text" button
    Then Questionnaire Header Froala buttons are displayed
      | Font family      |
      | Font size        |
      | Subscript        |
      | Text color       |
      | Background color |
      | Inline class     |
      | Inline style     |
      | Clear formatting |
    When User clicks Questionnaire Header Froala "More paragraph" button
    Then Questionnaire Header Froala buttons are displayed
      | Align Justify     |
      | Format O L Simple |
      | Format O L        |
      | Format U L        |
      | Paragraph format  |
      | Paragraph Style   |
      | Outdent           |
      | Indent            |
      | Quote             |
    When User clicks Questionnaire Header Froala "Format O L Options" button
    Then Questionnaire Header Froala "Format O L" options are displayed
      | Default     |
      | Lower Alpha |
      | Lower Greek |
      | Lower Roman |
      | Upper Alpha |
      | Upper Roman |
    When User clicks Questionnaire Header Froala "Format U L Options" button
    Then Questionnaire Header Froala "Format U L" options are displayed
      | Default |
      | Circle  |
      | Disc    |
      | Square  |
    When User clicks Questionnaire Header Froala "Paragraph format" button
    Then Questionnaire Header Froala "Paragraph format" options are displayed
      | Normal    |
      | Heading 1 |
      | Heading 2 |
      | Heading 3 |
      | Heading 4 |
      | Code      |
    When User clicks Questionnaire Header Froala "Paragraph Style" button
    Then Questionnaire Header Froala "Paragraph Style" options are displayed
      | Gray      |
      | Bordered  |
      | Spaced    |
      | Uppercase |
    When User clicks Questionnaire Header Froala "Line Height" button
    Then Questionnaire Header Froala "Line Height" options are displayed
      | Default |
      | Single  |
      | 1.15    |
      | 1.5     |
      | Double  |
    When User clicks Questionnaire Header Froala "Quote" button
    Then Questionnaire Header Froala "Quote" options are displayed
      | Increase |
      | Decrease |
    When User clicks Questionnaire Header Froala "More Misc" button
    Then Questionnaire Header Froala buttons are displayed
      | Fullscreen |
      | Print      |
      | Select all |
      | Html       |
      | Help       |
    And Questionnaire Header Froala Character counter is displayed
    When User clears Questionnaire Header
    And User clicks Froala Quick insert button
    Then Questionnaire Header Froala Quick Insert link buttons are displayed
      | Insert Image           |
      | Insert Video           |
      | Embed URL              |
      | Insert Table           |
      | Unordered List         |
      | Ordered List           |
      | Insert Horizontal Line |
    When User clicks Quick Insert "Insert Table" button
    And User clicks Questionnaire Header "table" content element
    Then Questionnaire Header Froala Table Insert link buttons are displayed
      | Table Header     |
      | Remove Table     |
      | Row              |
      | Column           |
      | Table Style      |
      | Cell             |
      | Cell Background  |
      | Vertical Align   |
      | Horizontal Align |
      | Cell Style       |
    When User clicks Questionnaire Table Insert Froala "Row" button
    Then Questionnaire Header Froala "Table Rows" options are displayed
      | Insert row above |
      | Insert row below |
      | Delete row       |
    When User clicks Questionnaire Table Insert Froala "Column" button
    Then Questionnaire Header Froala "Table Columns" options are displayed
      | Insert column before |
      | Insert column after  |
      | Delete column        |
    When User clicks Questionnaire Table Insert Froala "Table Style" button
    Then Questionnaire Header Froala "Table Style" options are displayed
      | Dashed Borders |
      | Alternate Rows |
    When User clicks Questionnaire Table Insert Froala "Cell" button
    Then Questionnaire Header Froala "Table Cells" options are displayed
      | Merge cells      |
      | Vertical split   |
      | Horizontal split |
    When User clicks Questionnaire Table Insert Froala "Vertical Align" button
    Then Questionnaire Header Froala "Table Cell Vertical Align" options are displayed
      | Top    |
      | Middle |
      | Bottom |
    When User clicks Questionnaire Table Insert Froala "Horizontal Align" button
    Then Questionnaire Header Froala "Table Cell Horizontal Align" options are displayed
      | Align Left    |
      | Align Center  |
      | Align Right   |
      | Align Justify |
    When User clicks Questionnaire Table Insert Froala "Cell Style" button
    Then Questionnaire Header Froala "Table Cell Style" options are displayed
      | Highlighted |
      | Thick       |
    When User fills "with random ID name" required questionnaire setup information
    And User clears Questionnaire Header
    And User fills in Questionnaire Header text "Test Bold" and click "Bold" Froala button
    And User fills in Questionnaire Header text "Test Align Right" and click "Align Right" Froala button
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    Then Questionnaire View Froala text contains strong element with text "Test Bold"
    And Questionnaire View Froala text contains element with text "Test Align Right" and style "text-align: right;"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on "Questionnaire" tab on Third-party page
    Then Questionnaire tab is loaded
    When User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    Then Activity Information page is displayed
    When User for questionnaire "questionnaireNameContext" clicks link "View"
    Then Third-party Questionnaire view page Froala text contains strong element with text "Test Bold"
    And Third-party Questionnaire view page Froala text contains element with text "Test Align Right" and style "text-align: right;"
