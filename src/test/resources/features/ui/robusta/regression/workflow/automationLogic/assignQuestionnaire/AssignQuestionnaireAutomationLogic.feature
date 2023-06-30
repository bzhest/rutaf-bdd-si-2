@ui @robusta @automation_logic
Feature: Add/Edit Questionnaires with Automation Logic

As RDDC User
I want to be able to pre-select the relevant Questionnaires in the Add Activity
So that I can guide the assignment of relevant questionnaires in the Onboarding/Renewal process for my Third parties

  Background:
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Onboarding Workflow" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group"
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed

  @C47360946 @core_regression
  Scenario: C47360946: Workflow Activity - Assign Questionnaire - Automation Logic - Add Assign Questionnaire activity
            - Filter Questionnaire for Internal Questionnaire Type
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks +Add Activity button
    Then Activity "Add Activity" tab is displayed
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Assign Questionnaire"
    And User populates Activity Description with "Assign Questionnaire"
    And User selects "Internal" Questionnaire Type
    Then "Internal" questionnaire type radio button should be selected
    And "External" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "Internal" Relevant Questionnaire dropdown button should be enabled
    And Internal Relevant Questionnaires drop-down contains all internal questionnaires
    When User selects "User" Assignee type
    Then Assignee's drop-down contains only active users
    When User selects Workflow Assignee(s) as "Admin_AT_FN Admin_AT_LN"
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been added. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed

  @C47360947 @core_regression
  Scenario: C47360947: Workflow Activity - Assign Questionnaire - Automation Logic - Add Assign Questionnaire activity
            - Filter Questionnaire for External Questionnaire Type
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks +Add Activity button
    Then Activity "Add Activity" tab is displayed
    When User selects Activity Type as "Assign Questionnaire"
    And User populates Activity Name with "Assign Questionnaire"
    And User populates Activity Description with "Assign Questionnaire"
    And User selects "External" Questionnaire Type
    Then "External" questionnaire type radio button should be selected
    And "Internal" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "External" Relevant Questionnaire dropdown button should be enabled
    And External Relevant Questionnaires drop-down contains all external questionnaires
    When User selects "User" Assignee type
    Then Assignee's drop-down contains only active users
    When User selects Workflow Assignee(s) as "Admin_AT_FN Admin_AT_LN"
    And User populates Due In with "1"
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been added. |
    And Add Wizard page is displayed
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed

  @C47575318
  Scenario: C47575318 - Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity
            - Change Questionnaire Type from Internal to External
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    And User selects "Internal" Questionnaire Type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then "Internal" questionnaire type radio button should be selected
    And "External" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "Internal" Relevant Questionnaire dropdown button should be enabled
    And Internal Relevant Questionnaires drop-down contains all internal questionnaires
    When User selects "External" Questionnaire Type
    Then External Relevant Questionnaires drop-down contains all external questionnaires
    And "External" Relevant Questionnaire dropdown button should be enabled
    When User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |

  @C47575319
  Scenario: C47575319 - Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity
            - Change Questionnaire Type from Internal to All
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    And User selects "Internal" Questionnaire Type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then "Internal" questionnaire type radio button should be selected
    And "External" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "Internal" Relevant Questionnaire dropdown button should be enabled
    And Internal Relevant Questionnaires drop-down contains all internal questionnaires
    When User selects "All" Questionnaire Type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |

  @C47575320
  Scenario: C47575320 - Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity
            - Change Questionnaire Type from External to Internal
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    And User selects "External" Questionnaire Type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then "External" questionnaire type radio button should be selected
    And "Internal" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "External" Relevant Questionnaire dropdown button should be enabled
    And External Relevant Questionnaires drop-down contains all external questionnaires
    When User selects "Internal" Questionnaire Type
    Then Internal Relevant Questionnaires drop-down contains all internal questionnaires
    And "Internal" Relevant Questionnaire dropdown button should be enabled
    When User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |

  @C47575321
  Scenario: C47575321 - Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity
            - Change Questionnaire Type from External to All
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    And User selects "External" Questionnaire Type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then "External" questionnaire type radio button should be selected
    And "Internal" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "External" Relevant Questionnaire dropdown button should be enabled
    And External Relevant Questionnaires drop-down contains all external questionnaires
    When User selects "All" Questionnaire Type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |

  @C47575322
  Scenario: C47575322 - Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity
            - Change Questionnaire Type from All to Internal
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    And User selects "Internal" Questionnaire Type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then "Internal" questionnaire type radio button should be selected
    And "External" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "Internal" Relevant Questionnaire dropdown button should be enabled
    And Internal Relevant Questionnaires drop-down contains all internal questionnaires

  @C47575323
  Scenario: C475753223- Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity
            - Change Questionnaire Type from All to External
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    And User selects "External" Questionnaire Type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    Then "External" questionnaire type radio button should be selected
    And "Internal" questionnaire type radio button should be unselected
    And "All" questionnaire type radio button should be unselected
    And "External" Relevant Questionnaire dropdown button should be enabled
    And External Relevant Questionnaires drop-down contains all external questionnaires

  @C47610416
  Scenario: C47610416- Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity
            - Edit with inactive questionnaire in Internal Questionnaire Type
    When User navigates to Questionnaire Management page
    And User searches questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    And User clicks edit questionnaire with name "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    And User selects "Active" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    When User searches questionnaire "AUTO_TEST_EXTERNAL_QUESTIONNAIRE"
    And User clicks edit questionnaire with name "AUTO_TEST_EXTERNAL_QUESTIONNAIRE"
    And User selects "Active" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    And User selects "Internal" Questionnaire Type
    And User clicks Done button for Activity
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    When User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    And User opens previously created Third-party
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks on Assign Questionnaire button
    Then Assign Questionnaire window is opened
    And Assign Questionnaire modal "Select Type" field value is "Internal"
    And "Select Type" field is not editable on Assign Questionnaire window
    And "Select Questionnaire" field is editable on Assign Questionnaire window
    When User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been assigned |
    When User navigates to Questionnaire Management page
    And User searches questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    And User clicks edit questionnaire with name "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    When User opens previously created Third-party
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User click on 'Assign New' Questionnaire button
    Then Assign Questionnaire window is opened
    And Assign Questionnaire modal "Select Type" field value is "Internal"
    And "Select Type" field is not editable on Assign Questionnaire window
    And "Select Questionnaire" field is editable on Assign Questionnaire window

  @C47610417
  Scenario: C47610417- Workflow Activity - Assign Questionnaire - Automation Logic - Edit Assign Questionnaire activity
            - Edit with inactive questionnaire in External Questionnaire Type
    When User navigates to Questionnaire Management page
    And User searches questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    And User clicks edit questionnaire with name "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    And User selects "Active" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    When User searches questionnaire "AUTO_TEST_EXTERNAL_QUESTIONNAIRE"
    And User clicks edit questionnaire with name "AUTO_TEST_EXTERNAL_QUESTIONNAIRE"
    And User selects "Active" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User opens newly created Workflow
    And User clicks workflow button "Next"
    And User clicks "Edit" icon for Activity "Auto Activity"
    And User selects "External" Questionnaire Type
    And User clicks Done button for Activity
    And User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    And User creates valid email
    And User creates Associated Party "Individual" "with valid email and enabled as user" via API and open it
    And User clicks on Third-party Information tab
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks on Assign Questionnaire button
    Then Assign Questionnaire window is opened
    And Assign Questionnaire modal "Select Type" field value is "External"
    And "Select Type" field is not editable on Assign Questionnaire window
    And "Select Questionnaire" field is editable on Assign Questionnaire window
    When User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Test_First_Name Test_Last_Name" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been assigned |
    When User navigates to Questionnaire Management page
    And User searches questionnaire "AUTO_TEST_EXTERNAL_QUESTIONNAIRE"
    And User clicks edit questionnaire with name "AUTO_TEST_EXTERNAL_QUESTIONNAIRE"
    And User selects "Inactive" questionnaire status
    And User clicks Questionnaire Setup button "Save"
    Then Alert Icon is displayed with text
      | Success! Questionnaire has been updated |
    When User opens previously created Third-party
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User click on 'Assign New' Questionnaire button
    Then Assign Questionnaire window is opened
    And Assign Questionnaire modal "Select Type" field value is "External"
    And "Select Type" field is not editable on Assign Questionnaire window
    And "Select Questionnaire" field is editable on Assign Questionnaire window