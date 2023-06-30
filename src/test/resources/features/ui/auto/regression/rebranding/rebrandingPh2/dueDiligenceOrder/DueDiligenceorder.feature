@ui @full_regression @rebranding
Feature: Rebranding - Due Diligence Order


  As a product owner,
  I want to change domain name to the new one
  So that it is aligned with Refinitiv branding for marketing purposes.


  Background:
    Given User logs into RDDC as "Admin"

  @C37107286
  Scenario: C37107286: DDO - Order Page - Check url and domain when viewing a completed questionnaire to be attached in the order in "Declined to Order" status case order
    When User makes sure that Custom field "Billing Entity" is set as not required via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for"
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    And User clicks review questionnaires
    And User clicks Questionnaire Overall Assessment button "Approve"
    And User clicks Questionnaire Overall Assessment button "Confirm"
    And User clicks on Third-party Information tab
    And User clicks on Create Order under Due Diligence Order section
    And User clicks "Decline Order" button on Due Diligence Order page
    And User clicks on Proceed button on Due Diligence Order page
    And User clicks Order Details button
    And User clicks view questionnaire with name "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/questionnaire\/(.+)\??source=icordering&orderId=(.+)" endpoint regex

  @C37107289
  Scenario: C37107289: DDO - Onboarding - Check url and domain on order saved as draft via activity information modal
    When User creates third-party "workflowGroupUkraineIndividual" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/activity\/(.+)" endpoint regex
    When User clicks Edit button for Activity
    And User clicks Create Order button
    Then Due Diligence Order form is opened
    When User clicks "Save as Draft" button on Due Diligence Order page
    Then Activity Information modal is displayed with details
      | Activity Type              | Order Details                                |
      | Order Due Diligence Report | ORDER DETAILS: toBeReplaced - SAVED AS DRAFT |
    And Current URL matches ".+\/ui\/thirdparty\/(\w+)\/activity\/(.+)" endpoint regex

  @C37107291
  Scenario: C37107291: DDO - Onboarding - Check url and domain when viewing "In Approval case status via Activity Information modal
    When User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User creates third-party "workflowGroupUkraineOrganizationWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks Create Order button
    And User clicks none selected scope
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Current URL matches ".+\/ui\/thirdparty\/(\w+)\/activity\/(.+)" endpoint regex
    When User clicks Order Details button
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/due-diligence-order\/(.+)" endpoint regex
    When User clicks Back button on Due Diligence Order page
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/activity\/(.+)" endpoint regex

  @C37107292
  Scenario: C37107292: DDO - Third-party Information - Ad Hoc: Creating Ad Hoc Due Diligence Report Orders – Organisation Order Type
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page should be shown with default values for "Organisation" order type
    When User clicks none selected scope
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Current URL matches ".+\/ui\/thirdparty\/(\w+)\/risk-management\/adhoc-activity\/(.+)\/view" endpoint regex

  @C37107298
  Scenario: C37107298: DDO - Onboarding - Check url and domain when declining an order via Activity Information Modal
    When User creates third-party "workflowGroupUkraineIndividual" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/activity\/(.+)" endpoint regex
    When User clicks Edit button for Activity
    And User clicks Decline Order button
    And User clicks Proceed button on confirmation window
    And User clicks on "OrderDueDiligenceReport" activity
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/activity\/(.+)" endpoint regex

  @C37107299
  Scenario: C37107299: DDO - Onboarding - Check url and domain when viewing Declined to Order case status
    When User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User creates third-party "workflowGroupUkraineOrganizationWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks "Auto Test Custom Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks Create Order button
    And User clicks none selected scope
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    And User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    And User clicks Activity from 'Pending Order for Approval' table
    And User clicks "Decline Order" button on Due Diligence Order page
    And User clicks on Proceed button on Due Diligence Order page
    Then Activity Information page is displayed
    And Current URL matches ".+\/ui\/thirdparty\/(\w+)\/activity\/(.+)" endpoint regex
    When User clicks Order Details button
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/due-diligence-order\/(.+)" endpoint regex
    When User clicks Back button on Due Diligence Order page
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/activity\/(.+)" endpoint regex

  @C37107301
  Scenario: C37107301: DDO - Third-party Information - Verify external user is not able to direcly access the url for DDO overview
    When User makes sure that Custom field "Billing Entity" is set as not required via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    And User clicks "Decline Order" button on Due Diligence Order page
    And User clicks on Proceed button on Due Diligence Order page
    And User clicks Order Details button
    And User clicks Back button on Due Diligence Order page
    And User saves current URL in context
    And User logs into RDDC as "External"
    And User navigate saved URL in context
    Then Current URL contains "/forbidden" endpoint

  @C37107302
  Scenario: C37107302: DDO - Third-party Information - Check url route and domain when clicking back on "In Approval" case order view page from DDO Section
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    And Create Due Diligence Order page should be shown with default values for "Organisation" order type
    And User clicks none selected scope
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User clicks Order Details button
    And User clicks Back button on Due Diligence Order page
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/risk-management\/adhoc-activity\/(.+)\/view" endpoint regex

  @C37107303
  Scenario: C37107303: DDO - Third-party Information - Check url route and domain when clicking back on "Draft" case order view page from DDO Section
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page should be shown with default values for "Organisation" order type
    When User clicks none selected scope
    And User fills in Po No.
    And User clicks "Save as Draft" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User clicks Order Details button
    And User clicks Back button on Due Diligence Order page
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/risk-management\/adhoc-activity\/(.+)\/view" endpoint regex

  @C37107304
  Scenario: C37107304: DDO - Third-party Information - Check url route and domain when clicking back on "Declined to Order" case order view page from DDO Section
    When User makes sure that Custom field "Billing Entity" is set as not required via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Create Order under Due Diligence Order section
    And User clicks "Decline Order" button on Due Diligence Order page
    And User clicks on Proceed button on Due Diligence Order page
    And User clicks Order Details button
    And User clicks Back button on Due Diligence Order page
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/risk-management\/adhoc-activity\/(.+)\/view" endpoint regex

  @C35739118
  Scenario: C35739118: DDO - Order Page - Check url and domain when viewing a completed questionnaire to be attached in the order in "For Approval" status case order
    When User makes sure that Custom field "Billing Entity" is set as not required via API
    And User creates third-party "with random ID name" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for"
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    And User clicks review questionnaires
    And User clicks Questionnaire Overall Assessment button "Approve"
    And User clicks Questionnaire Overall Assessment button "Confirm"
    And User clicks on Third-party Information tab
    And User clicks on Create Order under Due Diligence Order section
    And User clicks none selected scope
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    And User clicks Order Details button
    And User clicks view questionnaire with name "AUTO_TEST_INTERNAL_QUESTIONNAIRE"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/questionnaire\/(.+)\??source=icordering&orderId=(.+)" endpoint regex
    When User clicks Questionnaire Overall Assessment button "Cancel"
    Then Create Due Diligence Order page is opened

  @C37107277
  Scenario: C37107277: DDO - Onboarding - Check url and domain when creating and placing "New" order - Recommended Scope
    When User creates third-party "workflowGroupUkraine"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And User clicks Create Order button
    Then Order type is "Organisation"
    And Create Order page Available Scope section for "Organisation" should be shown with expected values
    When User fills in Po No.
    And User clicks "Place Order" button on Due Diligence Order page
    Then "THIS IS TO CONFIRM YOUR ORDER DETAILS. WOULD YOU LIKE TO PROCEED?" message for Due Diligence Order is displayed
    When User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed
    When User clicks Back button on Due Diligence Order page
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/activity\/(.+)" endpoint regex