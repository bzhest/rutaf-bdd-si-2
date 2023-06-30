@ui @questionnaires @robusta @core_regression

Feature: Questionnaire Setup - Enhanced Text Entry Plus

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Questionnaire Management page
    Then Questionnaire Overview page is displayed
    When User clicks Add Questionnaire button
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "EnhancedTextEntryPlus" to active tab

  @C48939147
  Scenario: C48939147: Questionnaire Setup - ETEP Question Type - Organization Party Type - Edit mapping fields in ETEP via Mapping
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Question"
    And User clicks Edit questionnaire button
    And User clicks Configuration icon
    And User selects questionnaire Part Type configuration "Organisation"
    And User unselects questionnaire Part Type configuration "Individual"
    Then Questionnaire Part Type configuration "Organisation" is selected
    When User clicks Mapping icon
    And User clicks Questionnaire Setup button "Add field"
    Then EnhancedTextEntryPlus "ADD ASSOCIATED ORGANISATION" modal is displayed with fields and checkboxes
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
    When User checks EnhancedTextEntryPlus modal fields
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Ok button on confirmation window
    Then Question EnhancedTextEntryPlus fields are displayed
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
    When User toggles "Auto screen against World Check"
    Then Questionnaire Groups field is displayed
    And Questionnaire Groups field value is default to "All"
    When User toggles "Auto screen against World Check"
    Then Questionnaire Groups field is not displayed
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Question"
    And User clicks Edit questionnaire button
    And User clicks Mapping icon
    Then Question EnhancedTextEntryPlus fields are displayed
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |

  @C48966061
  Scenario: C48966061: Questionnaire Setup - ETEP Question Type - Both Party Type - Add ETEP questionnaire via Mapping
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Question"
    And User clicks Edit questionnaire button
    And User clicks Configuration icon
    And User selects questionnaire Part Type configuration "Individual"
    And User selects questionnaire Part Type configuration "Organisation"
    Then Questionnaire Part Type configuration "Individual" is selected
    And Questionnaire Part Type configuration "Organisation" is selected
    When User clicks Mapping icon
    Then Question Mapping section 'Map To' with value "Add Associated Individual" is displayed
    And Question Mapping section 'Map To' with value "Add Associated Organisation" is displayed
    When User clicks 'Add Field' for "Individual" part type in EnhancedTextEntryPlus mapping
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
    And User clicks Ok button on confirmation window
    Then Question EnhancedTextEntryPlus fields are displayed for part type "Individual"
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
    When User clicks 'Add Field' for "Organisation" part type in EnhancedTextEntryPlus mapping
    Then EnhancedTextEntryPlus "ADD ASSOCIATED ORGANISATION" modal is displayed with fields and checkboxes
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
    When User checks EnhancedTextEntryPlus modal fields
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
    When User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Ok button on confirmation window
    Then Question EnhancedTextEntryPlus fields are displayed for part type "Organisation"
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
    When User toggles "Auto screen against World Check"
    Then Questionnaire Groups field is displayed
    And Questionnaire Groups field value is default to "All"
    When User toggles "Auto screen against World Check"
    Then Questionnaire Groups field is not displayed
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Question"
    And User clicks Edit questionnaire button
    And User clicks Mapping icon
    Then Question EnhancedTextEntryPlus fields are displayed for part type "Individual"
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
    Then Question EnhancedTextEntryPlus fields are displayed for part type "Organisation"
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |

  @C48966063
  Scenario: C48966063: Questionnaire Setup - ETEP Question Type - Both Party Type - Add ETEP questionnaire via Configuration
    When User clicks Configuration icon
    And User selects questionnaire Part Type configuration "Individual"
    And User selects questionnaire Part Type configuration "Organisation"
    Then Questionnaire Part Type configuration "Individual" is selected
    And Questionnaire Part Type configuration "Organisation" is selected
    When User clicks Add button for question "Sub-question #1" choice for part type "Individual"
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
    Then Sub-question EnhancedTextEntryPlus values are displayed for part type "Individual"
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
    When User clicks Add button for question "Sub-question #1" choice for part type "Organisation"
    Then EnhancedTextEntryPlus question Add options are displayed
      | Add sub-question |
      | Add field        |
    When User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus "ADD ASSOCIATED ORGANISATION" modal is displayed with fields and checkboxes
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
    When User checks EnhancedTextEntryPlus modal fields
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Sub-question EnhancedTextEntryPlus values are displayed for part type "Organisation"
      | Name            |
      | Country         |
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Number          |
      | Website         |
      | Relationship    |
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Question"
    And User clicks Edit questionnaire button
    And User clicks Configuration icon
    Then Sub-question EnhancedTextEntryPlus values are displayed for part type "Individual"
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
    Then Sub-question EnhancedTextEntryPlus values are displayed for part type "Organisation"
      | Name            |
      | Country         |
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Number          |
      | Website         |
      | Relationship    |

  @C48966065
  Scenario: C48966065: Questionnaire Setup - ETEP Question Type - Both Party Type - Edit ETEP questionnaire via Mapping
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Question"
    And User clicks Edit questionnaire button
    And User clicks Configuration icon
    And User selects questionnaire Part Type configuration "Individual"
    And User selects questionnaire Part Type configuration "Organisation"
    Then Questionnaire Part Type configuration "Individual" is selected
    And Questionnaire Part Type configuration "Organisation" is selected
    When User clicks Mapping icon
    Then Question Mapping section 'Map To' with value "Add Associated Individual" is displayed
    And Question Mapping section 'Map To' with value "Add Associated Organisation" is displayed
    When User clicks 'Add Field' for "Individual" part type in EnhancedTextEntryPlus mapping
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
    And User clicks Ok button on confirmation window
    Then Question EnhancedTextEntryPlus fields are displayed for part type "Individual"
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
    When User clicks 'Add Field' for "Organisation" part type in EnhancedTextEntryPlus mapping
    Then EnhancedTextEntryPlus "ADD ASSOCIATED ORGANISATION" modal is displayed with fields and checkboxes
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
    When User checks EnhancedTextEntryPlus modal fields
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Ok button on confirmation window
    Then Question EnhancedTextEntryPlus fields are displayed for part type "Organisation"
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
    When User toggles "Auto screen against World Check"
    Then Questionnaire Groups field is displayed
    And Questionnaire Groups field value is default to "All"
    When User toggles "Auto screen against World Check"
    Then Questionnaire Groups field is not displayed
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Question"
    And User clicks Edit questionnaire button
    And User clicks Mapping icon
    Then Question EnhancedTextEntryPlus fields are displayed for part type "Individual"
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
    Then Question EnhancedTextEntryPlus fields are displayed for part type "Organisation"
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |

  @C48966066
  Scenario: C48966066: Questionnaire Setup - ETEP Question Type - Both Party Type - Edit ETEP questionnaire via Configuration
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Question"
    And User clicks Edit questionnaire button
    And User clicks Configuration icon
    And User selects questionnaire Part Type configuration "Individual"
    And User selects questionnaire Part Type configuration "Organisation"
    Then Questionnaire Part Type configuration "Individual" is selected
    And Questionnaire Part Type configuration "Organisation" is selected
    When User clicks Add button for question "Sub-question #1" choice for part type "Individual"
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
    Then Sub-question EnhancedTextEntryPlus values are displayed for part type "Individual"
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
    When User clicks Add button for question "Sub-question #1" choice for part type "Organisation"
    Then EnhancedTextEntryPlus question Add options are displayed
      | Add sub-question |
      | Add field        |
    When User clicks "Add field" EnhancedTextEntryPlus option
    Then EnhancedTextEntryPlus "ADD ASSOCIATED ORGANISATION" modal is displayed with fields and checkboxes
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
    When User checks EnhancedTextEntryPlus modal fields
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Contact Number  |
      | Website         |
      | Relationship    |
    And User clicks EnhancedTextEntryPlus modal "Save" button
    Then Sub-question EnhancedTextEntryPlus values are displayed for part type "Organisation"
      | Name            |
      | Country         |
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Number          |
      | Website         |
      | Relationship    |
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    And User clicks Edit questionnaire button
    And User clicks Questionnaire Setup button "Question"
    And User clicks Configuration icon
    Then Sub-question EnhancedTextEntryPlus values are displayed for part type "Individual"
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
    Then Sub-question EnhancedTextEntryPlus values are displayed for part type "Organisation"
      | Name            |
      | Country         |
      | Email           |
      | Address Line    |
      | Zip/Postal Code |
      | Fax             |
      | City            |
      | State/Province  |
      | Number          |
      | Website         |
      | Relationship    |

  @C51291207
  Scenario: C51291207: Questionnaire Setup - ETEP Question Type - Individual Party Type - Edit mapping fields in ETEP via Mapping
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Question"
    And User clicks Edit questionnaire button
    And User clicks Configuration icon
    And User selects questionnaire Part Type configuration "Individual"
    And User unselects questionnaire Part Type configuration "Organisation"
    Then Questionnaire Part Type configuration "Individual" is selected
    When User clicks Mapping icon
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
    When User clicks EnhancedTextEntryPlus modal "Save" button
    And User clicks Ok button on confirmation window
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
      | Relationship      |
      | Position          |
    When User toggles "Auto screen against World Check"
    Then Questionnaire Groups field is displayed
    And Questionnaire Groups field value is default to "All"
    When User toggles "Auto screen against World Check"
    Then Questionnaire Groups field is not displayed
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    Then Questionnaire is displayed on questionnaires table
    When User clicks on added questionnaire
    And User clicks Questionnaire Setup button "Question"
    And User clicks Edit questionnaire button
    And User clicks Mapping icon
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
      | Relationship      |
      | Position          |