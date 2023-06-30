@ui @full_regression @ordering
Feature: Due Diligence Report Ordering - Confirmation Order Page

  As RDDC User that has access right
  I Want to display confirmation and preview of Due Diligence Order request before submitting the order
  So That Client will have the option to see the preview of order and be able to make final adjustment before actually placing the order

  @C36157689
  @core_regression
  @onlySingleThread
  Scenario: C36157689: Due Diligence Report Ordering - Confirmation Order Page - Place order confirmation page and display preview of order (w/out QSTT)
    Given User logs into RDDC as "Admin"
    And User makes sure that Custom field "Purchase Order Number" is set as not required via API
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User creates an order for activity "OrderDueDiligenceReport"
    Then Create Due Diligence Order page is opened
    When User clicks "Place Order" button on Due Diligence Order page
    Then "THIS IS TO CONFIRM YOUR ORDER DETAILS. WOULD YOU LIKE TO PROCEED?" message for Due Diligence Order is displayed
    And "proceed" button on Due Diligence page is displayed
    And "cancel" button on Due Diligence page is displayed
    And Order Confirmation 'Order Details' section should be shown with default values for "Organisation" order type
    And Order Confirmation 'Organisation Subject Details' section should be shown with default values
    And Order Confirmation 'Default Due Diligence Scope' section for Organisation type should be shown with default values
    And Order Confirmation 'Additional Add Ons' section should be hidden
    And Order Confirmation 'List Of Key Principals' section for Organisation type should be hidden
    And Order Confirmation 'Attachment' section should be shown with default values
    And Order Confirmation 'Comment' section should be shown with default values
    When User on confirmation block clicks "cancel"
    Then Create Due Diligence Order page is opened
    When User clicks "Place Order" button on Due Diligence Order page
    And User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed

  @C36167205
  @onlySingleThread
  Scenario: C36167205: Due Diligence Report Ordering - Confirmation Order Page / Preview Order Page - Display attached QSTT in Order Confirmation Page / Display QSTT section in Preview Order Page
    Given User logs into RDDC as "Admin"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Ukraine"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User adds new Activity "OrderDueDiligenceReport" with "Order Due Diligence Report Activity with recommended scope" data
    And User adds new Activity "Assign Questionnaire" with "Assign Questionnaire" data
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    When User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "WAITING"
    When User clicks Back button to return from Activity modal
    And User clicks "New Component" component tab
    And User clicks on "Questionnaire Assigned" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted |
    When User clicks Back button to return from Activity modal
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Review"
    And User clicks Questionnaire Overall Assessment button "Approve"
    And User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    And Activity Information "Status" is displayed with "IN PROGRESS"
    And 'Assign New' Questionnaire button should be displayed
    When User click on 'Assign New' Questionnaire button
    Then Assign Questionnaire window is opened
    And "Select Questionnaire" field is editable on Assign Questionnaire window
    When User clicks "Back" Assign Questionnaire dialog button
    Then "Select Type" field is not editable on Assign Questionnaire window
    When User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    Then "Select Assignee" field is not editable on Assign Questionnaire window
    And "Select Due Date" field is editable on Assign Questionnaire window
    When User fills in due date - today +1 day
    And User clicks "Next" Assign Questionnaire dialog button
    Then "Assign Overall Reviewer" field is editable on Assign Questionnaire window
    When User selects "Assignee_AT_FN Assignee_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    | Assignee                | Reviewer                | Overall Assessment | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Completed | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | Approved           | 0     |
    When User clicks Back button to return from Activity modal
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information Edit button is displayed
    When User clicks Edit button for Activity
    And User clicks Create Order button
    Then Due Diligence Order form is opened
    And Create Order Available Questionnaire table contains records
      | Questionnaire Name               | Questionnaire Type | Assignee                | Date Completed | Overall Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Internal           | Admin_AT_FN Admin_AT_LN | MM/dd/YYYY     | 0             |
    And Create Order Questionnaires are sorted by "DATE COMPLETED" in "ASC" order
    When User clicks view questionnaire with name "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    Then Questionnaire details page is displayed
    When User clicks Questionnaire Overall Assessment button "Export to PDF"
    Then Questionnaire PDF is exported successfully
    When User clicks Questionnaire Overall Assessment button "Cancel"
    And User clicks checkbox for "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Add Questionnaire" button on Due Diligence Order page
    Then Order Selected Questionnaire table contains records
      | Questionnaire Name               | Questionnaire Type | Assignee                | Date Completed | Overall Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Internal           | Admin_AT_FN Admin_AT_LN | MM/dd/YYYY     | 0             |
    When User clicks view questionnaire with name "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    Then Questionnaire details page is displayed
    When User clicks Questionnaire Overall Assessment button "Cancel"
    And User fills in Po No.
    And User clicks Questionnaire Overall Assessment button "Place Order"
    Then Confirmation block should be displayed
    And Confirmation Order Selected Questionnaire table contains records
      | Questionnaire Name               | Questionnaire Type | Assignee                | Date Completed | Overall Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Internal           | Admin_AT_FN Admin_AT_LN | MM/dd/YYYY     | 0             |
    And "THIS IS TO CONFIRM YOUR ORDER DETAILS. WOULD YOU LIKE TO PROCEED?" message for Due Diligence Order is displayed
    And "proceed" button on Due Diligence page is displayed
    And "cancel" button on Due Diligence page is displayed
    When User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed
    And Order Confirmation 'Order Details' section should be shown with default values for "Organisation" order type
    And Order Confirmation 'Organisation Subject Details' section should be shown with default values
    And Order Confirmation 'Default Due Diligence Scope' section for Organisation type should be shown with default values
    And Order Confirmation 'List Of Key Principals' section for Organisation type should be hidden
    And Order Confirmation 'Attachment' section should be shown with default values
    And Order Confirmation 'Comment' section should be shown with default values
    When User clicks Back button on Due Diligence Order page
    Then Activity Information page is displayed
