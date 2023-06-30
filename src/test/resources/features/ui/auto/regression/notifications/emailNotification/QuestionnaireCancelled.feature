@ui @arabica @full_regression @questionnaires
Feature: Email Notifications - Questionnaire Cancelled

  As a product owner
  I want no-reply email address to be configurable per tenant
  So that it is aligned with Refinitiv branding for marketing purposes.


  @C35771704
  @email
  Scenario: C35771704: Email Notification - Questionnaire Cancelled - Verify sender comes from noreply-rddcentre@refinitiv.com
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks "Assign Questionnaire Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
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
    When User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Actions"
    And User clicks Actions 'Cancel' button for Activity "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks "Proceed" Alert dialog button
    Then Activity Information page is displayed
    And Email notification "Questionnaire Cancelled" with following values is received by "Admin" user
      | <Questionnaire_Name> | AUTO_TEST_INTERNAL_QUESTIONNAIRE |
    And Email notification sender is "noreply-rddcentre@refinitiv.com"
