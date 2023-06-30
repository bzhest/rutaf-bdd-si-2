@ui @cacao @functional @questionnaires @question
Feature: Questionnaire Management - Question Tab - Enhanced Text Entry Plus Question Type

  As a user,
  I want an ability to add custom fields in Questionnaire - Enhanced Text Entry Plus.
  So that I can add additional sub-question that won't be mapped to supplier contact.

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Add Questionnaire Management page
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"


  @C35011111
  Scenario: C35011111: [moved] Add Questionnaire - Question - Configure Question type 'Enhanced Text Entry Plus' - Responder Use
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    Then Questionnaire "EnhancedTextEntryPlus" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "EnhancedTextEntryPlus" configuration section appears with expected elements for "Responder use"
    When User clicks Add button for question "Sub-question #2" choice
    Then EnhancedTextEntryPlus question Add options are displayed
      | Add sub-question |
      | Add field        |
    When User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus "ADD ASSOCIATED INDIVIDUAL" modal is displayed with fields and checkboxes
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    And EnhancedTextEntryPlus modal "Save" button is displayed
    And EnhancedTextEntryPlus modal "Cancel" button is displayed
    When User checks EnhancedTextEntryPlus modal fields
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Questionnaire choices counter is "Sub-questions: 18/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Nationality       |
      | Number            |
      | Website           |
      | Relationship      |
      | Position          |
    And Question EnhancedTextEntryPlus Mandatory field toggle is enabled for each added field
    And Question EnhancedTextEntryPlus field Type input is not displayed for each added field
    And Question EnhancedTextEntryPlus fields are draggable
    When User clicks Delete button for question "Sub-question #18" choice
    And User clicks Delete button for question "Sub-question #17" choice
    Then Question EnhancedTextEntryPlus fields are not displayed
      | Relationship |
      | Position     |
    And Questionnaire choices counter is "Sub-questions: 16/20"
    When User clicks Add button for question "Sub-question #16" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus modal fields are unchecked
      | Relationship |
      | Position     |
    When User unchecks EnhancedTextEntryPlus modal fields
      | Nationality    |
      | Contact Number |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Question EnhancedTextEntryPlus fields are not displayed
      | Nationality |
      | Number      |
    And Questionnaire choices counter is "Sub-questions: 14/20"
    When User clicks Add button for question "Sub-question #14" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    Then Questionnaire choices counter is "Sub-questions: 15/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | Text |
    When User clicks Type input field with label "Sub-question #15"
    Then Question drop-down options are displayed
      | Text   |
      | Number |
    When User clicks Type input field with label "Sub-question #15"
    And User clicks Add button for question "Sub-question #15" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #16" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #17" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #18" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #19" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    Then Questionnaire choices counter is "Sub-questions: 20/20"
    And Questionnaire choices "Sub-question #" Add buttons are not displayed
    And Question EnhancedTextEntryPlus Mandatory field toggle is enabled for each added field
    And Question EnhancedTextEntryPlus fields are draggable
    When User clicks Delete button for question "Sub-question #20" choice
    Then Questionnaire choices counter is "Sub-questions: 19/20"
    And Questionnaire choices "Sub-question #" Add buttons are displayed
    When User clicks Add button for question "Sub-question #19" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus modal "Save" button is enabled
    When User checks EnhancedTextEntryPlus modal fields
      | Nationality    |
      | Contact Number |
    Then EnhancedTextEntryPlus modal "Save" button is disabled
    When User unchecks EnhancedTextEntryPlus modal fields
      | Nationality |
    Then EnhancedTextEntryPlus modal "Save" button is enabled
    When User clicks EnhancedTextEntryPlus modal "Cancel" button
    Then Questionnaire choices counter is "Sub-questions: 19/20"
    And Question EnhancedTextEntryPlus fields are not displayed
      | Number |
    When User clicks Delete button for question "Sub-question #15" choice
    And User clicks Delete button for question "Sub-question #15" choice
    And User clicks Delete button for question "Sub-question #15" choice
    Then Questionnaire choices counter is "Sub-questions: 16/20"
    When User clicks Add button for question "Sub-question #16" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    And User checks EnhancedTextEntryPlus modal fields
      | Nationality    |
      | Contact Number |
      | Relationship   |
      | Position       |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Questionnaire choices counter is "Sub-questions: 20/20"
    And Questionnaire choices "Sub-question #" Add buttons are not displayed
    And Question EnhancedTextEntryPlus Mandatory field toggle is enabled for each added field
    And Question EnhancedTextEntryPlus fields are draggable
    When User clicks Questionnaire question configuration "See less" button
    Then Questionnaire question configuration "See more" button is displayed
    And Questionnaire choices with label "Sub-question #" 3 options are displayed
    When User clicks Questionnaire question configuration "See more" button
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Sub-question #" 20 options are displayed
    When User clicks Configuration icon
    And User clicks Questionnaire question "See more" button
    Then Question fields are
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Website           |
      | Text              |
      | Text              |
      | Nationality       |
      | Number            |
      | Relationship      |
      | Position          |
    When User adds question with type "Text" to active tab
    Then Questionnaire "Text" question on position 1 is displayed with default elements
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon for Question "EnhancedTextEntryPlus"
    Then Question EnhancedTextEntryPlus fields are displayed
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Website           |
      | Text              |
      | Text              |
      | Nationality       |
      | Number            |
      | Relationship      |
      | Position          |

  @C35011111
  Scenario: C35011111: [moved] Add Questionnaire - Question - Configure Question type 'Enhanced Text Entry Plus' - Reviewer Use
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    Then Questionnaire "EnhancedTextEntryPlus" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "EnhancedTextEntryPlus" configuration section appears with expected elements for "Reviewer use"
    When User clicks Add button for question "Sub-question #2" choice
    Then EnhancedTextEntryPlus question Add options are displayed
      | Add sub-question |
      | Add field        |
    When User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus "ADD ASSOCIATED INDIVIDUAL" modal is displayed with fields and checkboxes
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    And EnhancedTextEntryPlus modal "Save" button is displayed
    And EnhancedTextEntryPlus modal "Cancel" button is displayed
    When User checks EnhancedTextEntryPlus modal fields
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Questionnaire choices counter is "Sub-questions: 18/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Nationality       |
      | Number            |
      | Website           |
      | Relationship      |
      | Position          |
    And Question EnhancedTextEntryPlus Mandatory field toggle is enabled for each added field
    And Question EnhancedTextEntryPlus field Type input is not displayed for each added field
    And Question EnhancedTextEntryPlus fields are draggable
    When User clicks Delete button for question "Sub-question #18" choice
    And User clicks Delete button for question "Sub-question #17" choice
    Then Question EnhancedTextEntryPlus fields are not displayed
      | Relationship |
      | Position     |
    And Questionnaire choices counter is "Sub-questions: 16/20"
    When User clicks Add button for question "Sub-question #16" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus modal fields are unchecked
      | Relationship |
      | Position     |
    When User unchecks EnhancedTextEntryPlus modal fields
      | Nationality    |
      | Contact Number |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Question EnhancedTextEntryPlus fields are not displayed
      | Nationality |
      | Number      |
    And Questionnaire choices counter is "Sub-questions: 14/20"
    When User clicks Add button for question "Sub-question #14" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    Then Questionnaire choices counter is "Sub-questions: 15/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | Text |
    When User clicks Type input field with label "Sub-question #15"
    Then Question drop-down options are displayed
      | Text   |
      | Number |
    When User clicks Type input field with label "Sub-question #15"
    And User clicks Add button for question "Sub-question #15" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #16" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #17" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #18" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #19" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    Then Questionnaire choices counter is "Sub-questions: 20/20"
    And Questionnaire choices "Sub-question #" Add buttons are not displayed
    And Question EnhancedTextEntryPlus Mandatory field toggle is enabled for each added field
    And Question EnhancedTextEntryPlus fields are draggable
    When User clicks Delete button for question "Sub-question #20" choice
    Then Questionnaire choices counter is "Sub-questions: 19/20"
    And Questionnaire choices "Sub-question #" Add buttons are displayed
    When User clicks Add button for question "Sub-question #19" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus modal "Save" button is enabled
    When User checks EnhancedTextEntryPlus modal fields
      | Nationality    |
      | Contact Number |
    Then EnhancedTextEntryPlus modal "Save" button is disabled
    When User unchecks EnhancedTextEntryPlus modal fields
      | Nationality |
    Then EnhancedTextEntryPlus modal "Save" button is enabled
    When User clicks EnhancedTextEntryPlus modal "Cancel" button
    Then Questionnaire choices counter is "Sub-questions: 19/20"
    And Question EnhancedTextEntryPlus fields are not displayed
      | Number |
    When User clicks Delete button for question "Sub-question #15" choice
    And User clicks Delete button for question "Sub-question #15" choice
    And User clicks Delete button for question "Sub-question #15" choice
    Then Questionnaire choices counter is "Sub-questions: 16/20"
    When User clicks Add button for question "Sub-question #16" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    And User checks EnhancedTextEntryPlus modal fields
      | Nationality    |
      | Contact Number |
      | Relationship   |
      | Position       |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Questionnaire choices counter is "Sub-questions: 20/20"
    And Questionnaire choices "Sub-question #" Add buttons are not displayed
    And Question EnhancedTextEntryPlus Mandatory field toggle is enabled for each added field
    And Question EnhancedTextEntryPlus fields are draggable
    When User clicks Questionnaire question configuration "See less" button
    Then Questionnaire question configuration "See more" button is displayed
    And Questionnaire choices with label "Sub-question #" 3 options are displayed
    When User clicks Questionnaire question configuration "See more" button
    Then Questionnaire question configuration "See less" button is displayed
    And Questionnaire choices with label "Sub-question #" 20 options are displayed
    When User clicks Configuration icon
    And User clicks Questionnaire question "See more" button
    Then Question fields are
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Website           |
      | Text              |
      | Text              |
      | Nationality       |
      | Number            |
      | Relationship      |
      | Position          |
    When User adds question with type "Text" to active tab
    Then Questionnaire "Text" question on position 1 is displayed with default elements
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon for Question "EnhancedTextEntryPlus"
    Then Question EnhancedTextEntryPlus fields are displayed
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Website           |
      | Text              |
      | Text              |
      | Nationality       |
      | Number            |
      | Relationship      |
      | Position          |

  @C35034070
  Scenario: C35034070: [moved] Edit Questionnaire - Question - Configure Question type 'Enhanced Text Entry Plus' - Responder Use
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    Then Questionnaire "EnhancedTextEntryPlus" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "EnhancedTextEntryPlus" configuration section appears with expected elements for "Responder use"
    When User clicks Add button for question "Sub-question #2" choice
    Then EnhancedTextEntryPlus question Add options are displayed
      | Add sub-question |
      | Add field        |
    When User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus "ADD ASSOCIATED INDIVIDUAL" modal is displayed with fields and checkboxes
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    And EnhancedTextEntryPlus modal "Save" button is displayed
    And EnhancedTextEntryPlus modal "Cancel" button is displayed
    When User checks EnhancedTextEntryPlus modal fields
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Questionnaire choices counter is "Sub-questions: 16/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Nationality       |
      | Number            |
      | Website           |
    And Question EnhancedTextEntryPlus Mandatory field toggle is enabled for each added field
    And Question EnhancedTextEntryPlus field Type input is not displayed for each added field
    And Question EnhancedTextEntryPlus fields are draggable
    When User clicks Add button for question "Sub-question #16" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    Then Questionnaire choices counter is "Sub-questions: 17/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | Text |
    When User clicks Type input field with label "Sub-question #17"
    Then Question drop-down options are displayed
      | Text   |
      | Number |
    When User clicks Add button for question "Sub-question #17" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #18" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #19" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    Then Questionnaire choices counter is "Sub-questions: 20/20"
    And Questionnaire choices "Sub-question #" Add buttons are not displayed
    And Question EnhancedTextEntryPlus Mandatory field toggle is enabled for each added field
    And Question EnhancedTextEntryPlus fields are draggable
    When User clicks Delete button for question "Sub-question #20" choice
    Then Questionnaire choices counter is "Sub-questions: 19/20"
    And Questionnaire choices "Sub-question #" Add buttons are displayed
    When User clicks Add button for question "Sub-question #19" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus modal "Save" button is enabled
    When User checks EnhancedTextEntryPlus modal fields
      | Relationship |
      | Position     |
    Then EnhancedTextEntryPlus modal "Save" button is disabled
    When User unchecks EnhancedTextEntryPlus modal fields
      | Relationship |
    Then EnhancedTextEntryPlus modal "Save" button is enabled
    When User clicks EnhancedTextEntryPlus modal "Cancel" button
    Then Questionnaire choices counter is "Sub-questions: 19/20"
    And Question EnhancedTextEntryPlus fields are not displayed
      | Position |
    When User toggles "Allow attachment"
    Then Attachment label is displayed
    When User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    And User clicks Questionnaire question "See more" button
    Then Question EnhancedTextEntryPlus fields are displayed
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Nationality       |
      | Number            |
      | Website           |
      | Text              |
      | Text              |
      | Text              |
    And Attachment label is displayed
    When User clicks Delete button for question "Sub-question #19" choice
    Then Questionnaire choices counter is "Sub-questions: 18/20"
    When User clicks Delete button for question "Sub-question #16" choice
    And User clicks Delete button for question "Sub-question #15" choice
    Then Questionnaire choices counter is "Sub-questions: 16/20"
    And Question EnhancedTextEntryPlus fields are not displayed
      | Website |
      | Number  |
    When User clicks Add button for question "Sub-question #16" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus modal fields are unchecked
      | Website        |
      | Contact Number |
      | Relationship   |
      | Position       |
    When User unchecks EnhancedTextEntryPlus modal fields
      | State/Province |
      | Nationality    |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Question EnhancedTextEntryPlus fields are not displayed
      | State/Province |
      | Nationality    |
    And Questionnaire choices counter is "Sub-questions: 14/20"
    When User clicks Add button for question "Sub-question #14" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    And User checks EnhancedTextEntryPlus modal fields
      | State/Province |
      | Nationality    |
      | Website        |
      | Contact Number |
      | Relationship   |
      | Position       |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Question EnhancedTextEntryPlus fields are displayed
      | State/Province |
      | Nationality    |
      | Website        |
      | Number         |
      | Relationship   |
      | Position       |
    And Questionnaire choices counter is "Sub-questions: 20/20"
    And Questionnaire choices "Sub-question #" Add buttons are not displayed
    And Question EnhancedTextEntryPlus Mandatory field toggle is enabled for each added field
    And Question EnhancedTextEntryPlus fields are draggable
    When User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Question EnhancedTextEntryPlus fields are displayed
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | Text              |
      | Text              |
      | State/Province    |
      | Nationality       |
      | Website           |
      | Number            |
      | Relationship      |
      | Position          |

  @C35034070
  Scenario: C35034070: [moved] Edit Questionnaire - Question - Configure Question type 'Enhanced Text Entry Plus' - Reviewer Use
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    Then Questionnaire "EnhancedTextEntryPlus" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "EnhancedTextEntryPlus" configuration section appears with expected elements for "Reviewer use"
    When User clicks Add button for question "Sub-question #2" choice
    Then EnhancedTextEntryPlus question Add options are displayed
      | Add sub-question |
      | Add field        |
    When User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus "ADD ASSOCIATED INDIVIDUAL" modal is displayed with fields and checkboxes
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    And EnhancedTextEntryPlus modal "Save" button is displayed
    And EnhancedTextEntryPlus modal "Cancel" button is displayed
    When User checks EnhancedTextEntryPlus modal fields
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Questionnaire choices counter is "Sub-questions: 16/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Nationality       |
      | Number            |
      | Website           |
    And Question EnhancedTextEntryPlus Mandatory field toggle is enabled for each added field
    And Question EnhancedTextEntryPlus field Type input is not displayed for each added field
    And Question EnhancedTextEntryPlus fields are draggable
    When User clicks Add button for question "Sub-question #16" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    Then Questionnaire choices counter is "Sub-questions: 17/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | Text |
    When User clicks Type input field with label "Sub-question #17"
    Then Question drop-down options are displayed
      | Text   |
      | Number |
    When User clicks Add button for question "Sub-question #17" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #18" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #19" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    Then Questionnaire choices counter is "Sub-questions: 20/20"
    And Questionnaire choices "Sub-question #" Add buttons are not displayed
    And Question EnhancedTextEntryPlus Mandatory field toggle is enabled for each added field
    And Question EnhancedTextEntryPlus fields are draggable
    When User clicks Delete button for question "Sub-question #20" choice
    Then Questionnaire choices counter is "Sub-questions: 19/20"
    And Questionnaire choices "Sub-question #" Add buttons are displayed
    When User clicks Add button for question "Sub-question #19" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus modal "Save" button is enabled
    When User checks EnhancedTextEntryPlus modal fields
      | Relationship |
      | Position     |
    Then EnhancedTextEntryPlus modal "Save" button is disabled
    When User unchecks EnhancedTextEntryPlus modal fields
      | Relationship |
    Then EnhancedTextEntryPlus modal "Save" button is enabled
    When User clicks EnhancedTextEntryPlus modal "Cancel" button
    Then Questionnaire choices counter is "Sub-questions: 19/20"
    And Question EnhancedTextEntryPlus fields are not displayed
      | Position |
    When User toggles "Allow attachment"
    Then Attachment label is displayed
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    And User clicks Questionnaire question "See more" button
    Then Question EnhancedTextEntryPlus fields are displayed
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Nationality       |
      | Number            |
      | Website           |
      | Text              |
      | Text              |
      | Text              |
    And Attachment label is displayed
    When User clicks Delete button for question "Sub-question #19" choice
    Then Questionnaire choices counter is "Sub-questions: 18/20"
    When User clicks Delete button for question "Sub-question #16" choice
    And User clicks Delete button for question "Sub-question #15" choice
    Then Questionnaire choices counter is "Sub-questions: 16/20"
    And Question EnhancedTextEntryPlus fields are not displayed
      | Website |
      | Number  |
    When User clicks Add button for question "Sub-question #16" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus modal fields are unchecked
      | Website        |
      | Contact Number |
      | Relationship   |
      | Position       |
    When User unchecks EnhancedTextEntryPlus modal fields
      | State/Province |
      | Nationality    |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Question EnhancedTextEntryPlus fields are not displayed
      | State/Province |
      | Nationality    |
    And Questionnaire choices counter is "Sub-questions: 14/20"
    When User clicks Add button for question "Sub-question #14" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    And User checks EnhancedTextEntryPlus modal fields
      | State/Province |
      | Nationality    |
      | Website        |
      | Contact Number |
      | Relationship   |
      | Position       |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Question EnhancedTextEntryPlus fields are displayed
      | State/Province |
      | Nationality    |
      | Website        |
      | Number         |
      | Relationship   |
      | Position       |
    And Questionnaire choices counter is "Sub-questions: 20/20"
    And Questionnaire choices "Sub-question #" Add buttons are not displayed
    And Question EnhancedTextEntryPlus Mandatory field toggle is enabled for each added field
    And Question EnhancedTextEntryPlus fields are draggable
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question EnhancedTextEntryPlus fields are displayed
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | Text              |
      | Text              |
      | State/Province    |
      | Nationality       |
      | Website           |
      | Number            |
      | Relationship      |
      | Position          |

  @C35063410
  Scenario: C35063410: [moved] Edit Questionnaire - Question - Cancel changes in configured Question type 'Enhanced Text Entry Plus'
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    And User clicks Add button for question "Sub-question #2" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    And User checks EnhancedTextEntryPlus modal fields
      | Email |
      | Title |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Add button for question "Sub-question #4" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User toggles "Allow attachment"
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    And User clicks Add button for question "Sub-question #2" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    And User checks EnhancedTextEntryPlus modal fields
      | Email |
      | Title |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Add button for question "Sub-question #4" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User toggles "Allow attachment"
    And User clicks Questionnaire Setup button "Cancel"
    Then Questionnaire Overview page is displayed
    When User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Questionnaire "EnhancedTextEntryPlus" configuration section appears with expected elements for "Responder use"
    When User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Questionnaire "EnhancedTextEntryPlus" configuration section appears with expected elements for "Reviewer use"

  @C35174113
  Scenario: C35174113: [moved] Add/Edit Questionnaire - Question - Configure&Map Associated Individual for Question type 'Enhanced Text Entry Plus' - Responder use
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Configuration icon
    And User configures question with data "EnhancedTextEntryPlus Responder use configurations"
    And User clicks Mapping icon
    Then Question drop-down "Map To" selected value is "Add Associated Individual"
    And Question Mapping section is displayed with default data for "EnhancedTextEntryPlus Responder use configurations" question type
    And Questionnaire Setup button "Add field" is displayed
    When User clicks Questionnaire Setup button "Add field"
    And User checks EnhancedTextEntryPlus modal fields
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | City            |
      | State/Province  |
      | Nationality     |
      | Website         |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Message is displayed on confirmation window
      | Your selected field has been updated! You can change the settings of the updated item by going to question item |
      | configuration                                                                                                   |
    When User clicks Ok button on confirmation window
    And User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 16/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | First Name      |
      | Last Name       |
      | Text1           |
      | Number1         |
      | Relationship    |
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | City            |
      | State/Province  |
      | Nationality     |
      | Website         |
    And Question EnhancedTextEntryPlus field Type input is not displayed for each added field
    And Questionnaire choices "Sub-question #" Delete buttons are displayed
    When User clicks Delete button for question "Sub-question #14" choice
    And User clicks Delete button for question "Sub-question #14" choice
    And User clicks Add button for question "Sub-question #13" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    And User unchecks EnhancedTextEntryPlus modal fields
      | Website |
      | City    |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Questionnaire choices counter is "Sub-questions: 12/20"
    When User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus modal fields are unchecked
      | City           |
      | State/Province |
      | Nationality    |
      | Website        |
    When User unchecks EnhancedTextEntryPlus modal fields
      | Place of Birth |
      | Fax            |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    When User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 10/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | First Name      |
      | Last Name       |
      | Text1           |
      | Number1         |
      | Relationship    |
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
    When User clicks Add button for question "Sub-question #10" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus modal fields are unchecked
      | Place of Birth |
      | Fax            |
    When User clicks EnhancedTextEntryPlus modal "Cancel" button
    And User clicks Add button for question "Sub-question #10" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #11" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #12" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #13" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #14" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    Then Questionnaire choices counter is "Sub-questions: 15/20"
    When User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    When User checks EnhancedTextEntryPlus modal fields
      | Place of Birth |
      | Fax            |
      | City           |
      | State/Province |
      | Nationality    |
      | Website        |
    Then EnhancedTextEntryPlus modal "Save" button is disabled
    When User unchecks EnhancedTextEntryPlus modal fields
      | Nationality |
    Then EnhancedTextEntryPlus modal "Save" button is enabled
    When User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 20/20"
    And Questionnaire choices "Sub-question #" Add buttons are not displayed
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 20/20"
    When User clicks Delete button for question "Sub-question #15" choice
    And User clicks Delete button for question "Sub-question #14" choice
    And User clicks Delete button for question "Sub-question #13" choice
    And User clicks Delete button for question "Sub-question #12" choice
    And User clicks Delete button for question "Sub-question #11" choice
    And User clicks Delete button for question "Sub-question #4" choice
    Then Questionnaire choices counter is "Sub-questions: 14/20"
    When User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    And User checks EnhancedTextEntryPlus modal fields
      | Key Principal  |
      | Middle Name    |
      | Nationality    |
      | Contact Number |
      | Position       |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 19/20"
    When User clicks Delete button for question "Sub-question #17" choice
    Then Questionnaire choices counter is "Sub-questions: 18/20"
    When User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus modal fields are unchecked
      | Nationality |
    When User clicks EnhancedTextEntryPlus modal "Cancel" button
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 18/20"

  @C35174113
  Scenario: C35174113: [moved] Add/Edit Questionnaire - Question - Configure&Map Associated Individual for Question type 'Enhanced Text Entry Plus' - Reviewer use
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Configuration icon
    And User configures question with data "EnhancedTextEntryPlus Responder use configurations"
    And User clicks Mapping icon
    Then Question drop-down "Map To" selected value is "Add Associated Individual"
    And Question Mapping section is displayed with default data for "EnhancedTextEntryPlus Responder use configurations" question type
    And Questionnaire Setup button "Add field" is displayed
    When User clicks Questionnaire Setup button "Add field"
    And User checks EnhancedTextEntryPlus modal fields
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | City            |
      | State/Province  |
      | Nationality     |
      | Website         |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Message is displayed on confirmation window
      | Your selected field has been updated! You can change the settings of the updated item by going to question item |
      | configuration                                                                                                   |
    When User clicks Ok button on confirmation window
    And User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 16/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | First Name      |
      | Last Name       |
      | Text1           |
      | Number1         |
      | Relationship    |
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | City            |
      | State/Province  |
      | Nationality     |
      | Website         |
    And Question EnhancedTextEntryPlus field Type input is not displayed for each added field
    And Questionnaire choices "Sub-question #" Delete buttons are displayed
    When User clicks Delete button for question "Sub-question #14" choice
    And User clicks Delete button for question "Sub-question #14" choice
    And User clicks Add button for question "Sub-question #13" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    And User unchecks EnhancedTextEntryPlus modal fields
      | Website |
      | City    |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Questionnaire choices counter is "Sub-questions: 12/20"
    When User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus modal fields are unchecked
      | City           |
      | State/Province |
      | Nationality    |
      | Website        |
    When User unchecks EnhancedTextEntryPlus modal fields
      | Place of Birth |
      | Fax            |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    When User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 10/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | First Name      |
      | Last Name       |
      | Text1           |
      | Number1         |
      | Relationship    |
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
    When User clicks Add button for question "Sub-question #10" choice
    And User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus modal fields are unchecked
      | Place of Birth |
      | Fax            |
    When User clicks EnhancedTextEntryPlus modal "Cancel" button
    And User clicks Add button for question "Sub-question #10" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #11" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #12" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #13" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    And User clicks Add button for question "Sub-question #14" choice
    And User clicks "Add sub-question" EnhancedTextEntryPlus option
    Then Questionnaire choices counter is "Sub-questions: 15/20"
    When User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    When User checks EnhancedTextEntryPlus modal fields
      | Place of Birth |
      | Fax            |
      | City           |
      | State/Province |
      | Nationality    |
      | Website        |
    Then EnhancedTextEntryPlus modal "Save" button is disabled
    When User unchecks EnhancedTextEntryPlus modal fields
      | Nationality |
    Then EnhancedTextEntryPlus modal "Save" button is enabled
    When User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 20/20"
    And Questionnaire choices "Sub-question #" Add buttons are not displayed
    When User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 20/20"
    When User clicks Delete button for question "Sub-question #15" choice
    And User clicks Delete button for question "Sub-question #14" choice
    And User clicks Delete button for question "Sub-question #13" choice
    And User clicks Delete button for question "Sub-question #12" choice
    And User clicks Delete button for question "Sub-question #11" choice
    And User clicks Delete button for question "Sub-question #4" choice
    Then Questionnaire choices counter is "Sub-questions: 14/20"
    When User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    And User checks EnhancedTextEntryPlus modal fields
      | Key Principal  |
      | Middle Name    |
      | Nationality    |
      | Contact Number |
      | Position       |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 19/20"
    When User clicks Delete button for question "Sub-question #17" choice
    Then Questionnaire choices counter is "Sub-questions: 18/20"
    When User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus modal fields are unchecked
      | Nationality |
    When User clicks EnhancedTextEntryPlus modal "Cancel" button
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 18/20"

  @C35039779
  Scenario: C35039779: [moved]Add Questionnaire - Question - Add Associated Individual Mapping for Question type 'Enhanced Text Entry Plus' - Responder use
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Mapping icon
    Then Question drop-down "Map To" selected value is "Add Associated Individual"
    And Question Mapping section is displayed with default data for "EnhancedTextEntryPlus Responder use" question type
    When User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus "ADD ASSOCIATED INDIVIDUAL" modal is displayed with fields and checkboxes
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    And EnhancedTextEntryPlus modal "Save" button is displayed
    And EnhancedTextEntryPlus modal "Cancel" button is displayed
    When User checks EnhancedTextEntryPlus modal fields
      | Email |
      | Title |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Message is displayed on confirmation window
      | Your selected field has been updated! You can change the settings of the updated item by going to question item |
      | configuration                                                                                                   |
    When User clicks Ok button on confirmation window
    And User clicks Questionnaire Setup button "Add field"
    And User unchecks EnhancedTextEntryPlus modal fields
      | Email |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Message is displayed on confirmation window
      | Your selected field has been updated! You can change the settings of the updated item by going to question item |
      | configuration                                                                                                   |
    When User clicks Ok button on confirmation window
    And User clicks Mapping icon
    Then Question fields are
      | First Name |
      | Last Name  |
      | Title      |
    When User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus modal fields are checked
      | Title |
    When User checks EnhancedTextEntryPlus modal fields
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus modal fields are checked
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    When User clicks EnhancedTextEntryPlus modal "Cancel" button
    And User toggles "Auto screen against World Check"
    And User toggles "Review is required"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 18/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | Title             |
      | Email             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Nationality       |
      | Number            |
      | Website           |
      | Relationship      |
      | Position          |

  @C35039779
  Scenario: C35039779: [moved]Add Questionnaire - Question - Add Associated Individual Mapping for Question type 'Enhanced Text Entry Plus' - Reviewer use
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Mapping icon
    Then Question drop-down "Map To" selected value is "Add Associated Individual"
    And Question Mapping section is displayed with default data for "EnhancedTextEntryPlus Reviewer use" question type
    When User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus "ADD ASSOCIATED INDIVIDUAL" modal is displayed with fields and checkboxes
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    And EnhancedTextEntryPlus modal "Save" button is displayed
    And EnhancedTextEntryPlus modal "Cancel" button is displayed
    When User checks EnhancedTextEntryPlus modal fields
      | Email |
      | Title |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Message is displayed on confirmation window
      | Your selected field has been updated! You can change the settings of the updated item by going to question item |
      | configuration                                                                                                   |
    When User clicks Ok button on confirmation window
    And User clicks Questionnaire Setup button "Add field"
    And User unchecks EnhancedTextEntryPlus modal fields
      | Email |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Message is displayed on confirmation window
      | Your selected field has been updated! You can change the settings of the updated item by going to question item |
      | configuration                                                                                                   |
    When User clicks Ok button on confirmation window
    And User clicks Mapping icon
    Then Question fields are
      | First Name |
      | Last Name  |
      | Title      |
    When User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus modal fields are checked
      | Title |
    When User checks EnhancedTextEntryPlus modal fields
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus modal fields are checked
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    When User clicks EnhancedTextEntryPlus modal "Cancel" button
    And User toggles "Auto screen against World Check"
    And User toggles "Review is required"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Questionnaire choices counter is "Sub-questions: 18/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | Title             |
      | Email             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Nationality       |
      | Number            |
      | Website           |
      | Relationship      |
      | Position          |

  @C35047126
  Scenario: C35047126: [moved]Edit Questionnaire - Question - Add Associated Individual Mapping for Question type 'Enhanced Text Entry Plus' - Responder use
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    And User checks EnhancedTextEntryPlus modal fields
      | Country     |
      | Nationality |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User toggles "Auto screen against World Check"
    And User toggles "Review is required"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Questionnaire question "See more" button
    Then Questionnaire form "First Name" field is required
    And Questionnaire form "Last Name" field is required
    And Questionnaire form "Country" field is not required
    And Questionnaire form "Nationality" field is not required
    When User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus modal fields are checked
      | Country     |
      | Nationality |
    And EnhancedTextEntryPlus modal fields are unchecked
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    When User checks EnhancedTextEntryPlus modal fields
      | Email          |
      | Title          |
      | Address Line   |
      | Place of Birth |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Questionnaire form "Email" field is not required
    And Questionnaire form "Title" field is not required
    And Questionnaire form "Address Line" field is not required
    And Questionnaire form "Place of Birth" field is not required
    When User clicks Mapping icon
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Mapping icon for Question on position 2
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus "ADD ASSOCIATED INDIVIDUAL" modal is displayed with fields and checkboxes
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    When User checks EnhancedTextEntryPlus modal fields
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Questionnaire Setup button "Add field"
    And User checks EnhancedTextEntryPlus modal fields
      | Country |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus modal fields are checked
      | Country |
    When User clicks EnhancedTextEntryPlus modal "Cancel" button
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon for Question on position 1
    Then Questionnaire choices counter is "Sub-questions: 8/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | First Name     |
      | Last Name      |
      | Country        |
      | Nationality    |
      | Email          |
      | Title          |
      | Address Line   |
      | Place of Birth |
    When User clicks Configuration icon
    And User clicks Configuration icon for Question on position 2
    Then Questionnaire choices counter is "Sub-questions: 18/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Nationality       |
      | Number            |
      | Website           |
      | Relationship      |
      | Position          |

  @C35047126
  Scenario: C35047126: [moved]Edit Questionnaire - Question - Add Associated Individual Mapping for Question type 'Enhanced Text Entry Plus' - Reviewer use
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    And User checks EnhancedTextEntryPlus modal fields
      | Country     |
      | Nationality |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User toggles "Auto screen against World Check"
    And User toggles "Review is required"
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Questionnaire question "See more" button
    Then Questionnaire form "First Name" field is required
    And Questionnaire form "Last Name" field is required
    And Questionnaire form "Country" field is not required
    And Questionnaire form "Nationality" field is not required
    When User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus modal fields are checked
      | Country     |
      | Nationality |
    And EnhancedTextEntryPlus modal fields are unchecked
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    When User checks EnhancedTextEntryPlus modal fields
      | Email          |
      | Title          |
      | Address Line   |
      | Place of Birth |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Questionnaire form "Email" field is not required
    And Questionnaire form "Title" field is not required
    And Questionnaire form "Address Line" field is not required
    And Questionnaire form "Place of Birth" field is not required
    When User clicks Mapping icon
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Mapping icon for Question on position 2
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus "ADD ASSOCIATED INDIVIDUAL" modal is displayed with fields and checkboxes
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    When User checks EnhancedTextEntryPlus modal fields
      | Email           |
      | Title           |
      | Address Line    |
      | Zip/Postal Code |
      | Country         |
      | Place of Birth  |
      | Fax             |
      | Key Principal   |
      | Middle Name     |
      | City            |
      | State/Province  |
      | Nationality     |
      | Contact Number  |
      | Website         |
      | Relationship    |
      | Position        |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Questionnaire Setup button "Add field"
    And User checks EnhancedTextEntryPlus modal fields
      | Country |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus modal fields are checked
      | Country |
    When User clicks EnhancedTextEntryPlus modal "Cancel" button
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon for Question on position 1
    Then Questionnaire choices counter is "Sub-questions: 8/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | First Name     |
      | Last Name      |
      | Country        |
      | Nationality    |
      | Email          |
      | Title          |
      | Address Line   |
      | Place of Birth |
    When User clicks Configuration icon
    And User clicks Configuration icon for Question on position 2
    Then Questionnaire choices counter is "Sub-questions: 18/20"
    And Question EnhancedTextEntryPlus fields are displayed
      | First Name        |
      | Last Name         |
      | Email             |
      | Title             |
      | Address Line      |
      | Zip/Postal Code   |
      | Country           |
      | Place of Birth    |
      | Fax               |
      | Is Key Principal? |
      | Middle name       |
      | City              |
      | State/Province    |
      | Nationality       |
      | Number            |
      | Website           |
      | Relationship      |
      | Position          |

  @C35061199
  Scenario: C35061199: [moved] Add Questionnaire - Question - Delete Question type 'Enhanced Text Entry Plus'
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Configuration icon for Question on position 2
    And User configures question with data "EnhancedTextEntryPlus Responder use configurations"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 2
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Configuration icon for Question on position 2
    And User configures question with data "EnhancedTextEntryPlus Responder use configurations"
    And User clicks Configuration icon
    And User clicks delete question button for question on position 2
    Then Questionnaire question tab counter with value "1" is displayed for tab on position 1
    And Tab on position 1 contains 1 questions
    And Questionnaire question tab counter with value "1" is displayed for tab on position 2
    And Tab on position 2 contains 1 questions
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    Then Questionnaire question tab counter with value "1" is displayed for tab on position 1
    And Tab on position 1 contains 1 questions
    And Questionnaire question tab counter with value "1" is displayed for tab on position 2
    And Tab on position 2 contains 1 questions

  @C35061951
  Scenario: C35061951: [moved] Edit Questionnaire - Question - Delete Question type 'Enhanced Text Entry Plus'
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Configuration icon for Question on position 2
    And User configures question with data "EnhancedTextEntryPlus Responder use configurations"
    And User clicks Configuration icon
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Configuration icon for Question on position 2
    And User configures question with data "EnhancedTextEntryPlus Responder use configurations"
    And User clicks Configuration icon
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks delete question button for question on position 2
    Then Questionnaire question tab counter with value "1" is displayed for tab on position 1
    And Tab on position 1 contains 1 questions
    When User clicks on Question tab with index 1
    And User clicks delete question button for question on position 2
    Then Questionnaire question tab counter with value "1" is displayed for tab on position 2
    And Tab on position 2 contains 1 questions
    When User clicks Questionnaire Setup button "Save"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    Then Questionnaire question tab counter with value "1" is displayed for tab on position 1
    And Tab on position 1 contains 1 questions
    And Questionnaire question tab counter with value "1" is displayed for tab on position 2
    And Tab on position 2 contains 1 questions

  @C35174396
  Scenario: C35174396: [moved] Clone Questionnaire - Question - Clone Question type 'Enhanced Text Entry Plus'
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Configuration icon
    And User configures question with data "EnhancedTextEntryPlus Responder use configurations"
    And User clicks Configuration icon
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks Clone questionnaire button for created Questionnaire
    And User fills in New Questionnaire Name field with "toBeReplaced"
    And User clicks Clone Questionnaire modal "Clone" button
    Then Cloned Questionnaire is displayed on questionnaires table
    And Cloned Questionnaire is the same as Initial one
    When User clicks edit cloned questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks Configuration icon
    Then Question configuration contains expected data "EnhancedTextEntryPlus Responder use configurations"
    When User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question configuration contains expected data "EnhancedTextEntryPlus Reviewer use"

  @C47275881
  Scenario: C47275881: [Questionnaire] - Add/Edit Question - Enhanced Text Entry Plus - Reviewer tab - changed number of reviewers
    When User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Add question tab button
    And User clicks Create tab "Reviewer use" radio button
    And User clicks Create Tab modal "Create" button
    And User clicks on Question tab with index 1
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    Then Questionnaire "EnhancedTextEntryPlus" question on position 1 is displayed with default elements
    When User clicks Configuration icon
    Then Questionnaire Main question section is greyed out
    And Questionnaire "EnhancedTextEntryPlus" configuration section appears with expected elements for "Reviewer use"
    When User clicks "Reviewers" questionnaire tab
    And User selects Number of Reviewer Levels "5"
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question Reviewer level drop-down options are
      | Level 1 |
      | Level 2 |
      | Level 3 |
      | Level 4 |
      | Level 5 |
    When User configures question with data "EnhancedTextEntryPlus question configuration with Level 2 reviewer"
    And User selects Question Reviewer level "Level 3"
    And User clicks "Reviewers" questionnaire tab
    And User selects Number of Reviewer Levels "4"
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question Reviewer level is "Level 3"
    And Question Reviewer level drop-down options are
      | Level 1 |
      | Level 2 |
      | Level 3 |
      | Level 4 |
    When User clicks "Reviewers" questionnaire tab
    And User selects Number of Reviewer Levels "2"
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question Reviewer level is "Level 2"
    And Question Reviewer level drop-down options are
      | Level 1 |
      | Level 2 |
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save as draft"
    And User clicks edit added questionnaire
    And User clicks "Question" questionnaire tab
    And User clicks on Question tab with index 1
    And User clicks Configuration icon
    Then Question configuration contains expected data "EnhancedTextEntryPlus question configuration with Level 2 reviewer"
