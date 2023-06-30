@ui @full_regression @core_regression @questionnaires
Feature: Assign Questionnaire Activity

  As as Admin Or Internal User that has access right
  I Want To be able to assign Questionnaire to either Internal or External user
  So That Client should be able to gather relevant information in order to make better decision in onboarding supplier

  Background:
    Given User logs into RDDC as "Admin"
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"

  @C36136245
  @email
  Scenario: C36136245: Questionnaire - Internal User - check attach file in Activity (Assign Questionnaire)
    Then Email notification "Activity Assigned" with following values is received by "Admin" user
      | <Activity_Name> | Auto Activity |
    And Email contains the following text
      | Dear Admin_AT_FN                                                                          |
      | A new activity has been assigned to you. Click on the following link to view the activity |
      | Auto Activity                                                                             |
      | For support please visit                                                                  |
      | https://my.refinitiv.com                                                                  |
      | MyRefinitiv                                                                               |
      | customer support portal                                                                   |
      | Best Regards                                                                              |
      | Refinitiv Due Diligence Centre                                                            |
    When User opens email link
    Then Activity Information page is displayed
    When User adds Activity attachment
      | logo.jpg | Activity description |
    Then Activity information page Attachment table row appears
      | File Name | Description          | Upload Date |
      | logo.jpg  | Activity description | TODAY       |
    When User clicks Back button to return from Activity modal
    Then Activity Information modal is closed
    And Third-party Information tab is loaded
