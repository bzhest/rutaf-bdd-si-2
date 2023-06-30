@ui @full_regression @email_management

Feature: Activating an Email Template

  As a RDDC Administrator
  I want to be able to enable an email sending
  So that manage the details being sent to the recipient of the email

  Background:
    Given User logs into RDDC as "Admin"

  @C41174521
  @onlySingleThread
  @email
  Scenario: C41174521: Activating an Email Template - Questionnaire Cancelled
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
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

  @C41174521
  @onlySingleThread
  Scenario: C41174521: Activating an Email Template - Questionnaire Cancelled - Renew
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "Approve Onboarding Activity"
    And User adds new Activity "Assign Questionnaire"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on "Approve Onboarding" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "toBeReplaced" is updated with type "Renewal"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    When User clicks "Auto_Component_1" tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
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

  @C41174619
  @onlySingleThread
  @email
  Scenario: C41174619: Activating an Email Template - Screening Delegation Completed
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Group_1"
    And User clicks Check button
    And User adds new Activity "AUTO_TEST_WC_ONBOARDING_IN_PROGRESS" with "World Check Screening Activity" data
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group and assignee user responsible party"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    Then Email notification "Screening Delegation Completed" with following values is received by "Assignee" user
      | <WC1_Record_Name> | 1 |

  @C41174619
  @email
  Scenario: C41174619: Activating an Email Template - Screening Delegation Completed - Renew
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Group_1"
    And User clicks Check button
    And User adds new Activity "AUTO_TEST_WC_RENEWAL_IN_PROGRESS" with "World Check Screening Activity" data
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group and assignee user responsible party"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_WC_RENEWAL_IN_PROGRESS" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    Then Workflow "toBeReplaced" is updated with type "Renewal"
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "Renew" for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    Then Email notification "Screening Delegation Completed" with following values is received by "Assignee" user
      | <WC1_Record_Name> | 1 |
