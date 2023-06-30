@ui @questionnaires @alamid @full_regression

Feature: Questionnaire Setup - Enhanced Text Entry Plus

  Background:
    Given User logs into RDDC as "Admin"
    And User navigates to Questionnaire Management page
    And Questionnaire Overview page is displayed

  @C44939460
  Scenario: C44939460: Add Questionnaire - ETEP - Auto-screen against WC = ON
    When User clicks Add Questionnaire button
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Mapping icon
    And User toggles "Auto screen against World Check"
    Then Questionnaire Groups field is displayed
    And Questionnaire Groups field value is default to "All"
    When User hovers to Questionnaire Groups dropdown 3
    Then Questionnaire Groups tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed
    When User selects Questionnaire Group 3
    And User hovers to Questionnaire Group field
    Then Questionnaire Groups tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed

  @C44939461
  Scenario: C44939461: Add Questionnaire - ETEP Auto-screen against WC = OFF
    When User clicks Add Questionnaire button
    And User fills "with random ID name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Mapping icon
    Then Questionnaire Groups field is not displayed

  @C44961217
  Scenario: C44961217: Edit Questionnaire - ETEP - Auto-screen against WC = OFF
    When User clicks Add Questionnaire button
    And User creates questionnaire "with random ID name" with 1 "New Tab" tabs
    And Questionnaire is displayed on questionnaires table
    And User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Mapping icon
    Then Questionnaire Groups field is not displayed

  @C44961216
  Scenario: C44961216: Edit Questionnaire - ETEP - Auto-screem against WC = ON
    When User clicks Add Questionnaire button
    And User creates questionnaire "with random ID name" with 1 "New Tab" tabs
    And Questionnaire is displayed on questionnaires table
    And User clicks edit added questionnaire
    Then Add Questionnaire setup page displayed
    When User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "EnhancedTextEntryPlus" to active tab
    And User clicks Mapping icon
    And User toggles "Auto screen against World Check"
    Then Questionnaire Groups field is displayed
    And Questionnaire Groups field value is default to "All"
    When User hovers to Questionnaire Groups dropdown 3
    Then Questionnaire Groups tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed
    When User selects Questionnaire Group 3
    And User hovers to Questionnaire Group field
    Then Questionnaire Groups tooltip "Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only Sanctions Only" is displayed