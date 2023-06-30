@ui @full_regression @supplier
Feature: Risk Management Overview Reflects Third-party state

  As a Compliance Group User
  I want the system to save the workflow details triggered for Third-parties
  So that I can have a record of the workflows for future references

  Background:
    Given User logs into RDDC as "Admin"

  @C35775404
#    All other states are checked in test cases below
  Scenario: C35775404: Third-party - Risk Management Overview - Check Start and Stopped Date in the Workflow History modal - Onboarding
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name           | Automation Workflow Questionnaire |
      | Status                  | Onboarding                        |
      | Onboarding Start Date   | TODAY+0                           |
      | Onboarded Decision Date |                                   |

  @C35776956
#  As well checks @C35775404
  Scenario: C35776956: Third-party - Risk Management Overview - Check Start and Stopped Date in the Workflow History modal - Stopped Onboarding
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Stop Onboarding" third-party button
    Then Message is displayed on confirmation window
      | Are you sure you want to stop the Onboarding Process? This cannot be undone and you will have to restart the Onboarding Process again. |
    And Confirmation window button with text "Yes" is displayed
    And Confirmation window button with text "No" is displayed
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "NEW"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                              | STATUS             | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Automation Workflow Questionnaire | Stopped Onboarding | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Automation Workflow Questionnaire" and status "Stopped Onboarding" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name           | Automation Workflow Questionnaire |
      | Status                  | Stopped Onboarding                |
      | Onboarding Start Date   | TODAY+0                           |
      | Onboarding Stopped Date | TODAY+0                           |

  @C35777898
    #  As well checks @C35775404
  Scenario: C35777898: Third-party - Risk Management Overview - Check Start and Stopped Date in the Workflow History modal - Declined Onboarding
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Decline Onboarding" third-party button
    Then Message is displayed on confirmation window
      | Are you sure you want to decline the Onboarding Process? This cannot be undone and you will have to restart the Onboarding Process again. |
    And Confirmation window button with text "Yes" is displayed
    And Confirmation window button with text "No" is displayed
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "ONBOARDING DENIED"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                              | STATUS              | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Automation Workflow Questionnaire | Declined Onboarding | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Automation Workflow Questionnaire" and status "Declined Onboarding" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name          | Automation Workflow Questionnaire |
      | Status                 | Declined Onboarding               |
      | Onboarding Start Date  | TODAY+0                           |
      | Onboarding Denied Date | TODAY+0                           |

  @C35778510
    #  As well checks @C35775404
  Scenario: C35778510: Third-party - Risk Management Overview - Check Start and Stopped Date in the Workflow History modal - Onboarded
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User approves all activities
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User waits for progress bar to disappear from page
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "case1"
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                              | STATUS    | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Automation Workflow Questionnaire | Onboarded | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarded" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name           | Automation Workflow Questionnaire |
      | Status                  | Onboarded                         |
      | Onboarding Start Date   | TODAY+0                           |
      | Onboarded Decision Date | TODAY+0                           |

  @C35778890
    #  As well checks @C35775404
  Scenario: C35778890: Third-party - Risk Management Overview - Check Start and Stopped Date in the Workflow History modal - Renewing
    When User creates third-party "with renewal workflow Norway"
    And User clicks Start Onboarding for third-party
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User clicks on created third-party
    And User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                                    | STATUS   | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Auto Workflow Renewal Workflow Low Risk | Renewing | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Auto Workflow Renewal Workflow Low Risk" and status "Renewing" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name           | Auto Workflow Renewal Workflow Low Risk |
      | Status                  | Renewing                                |
      | Renewal Start Date      | TODAY+0                                 |
      | Onboarded Decision Date |                                         |

  @C35778919
    #  As well checks @C35775404
  Scenario: C35778919: Third-party - Risk Management Overview - Check Start and Stopped Date in the Workflow History modal - Stopped Renewal
    When User creates third-party "with renewal workflow Norway"
    And User clicks Start Onboarding for third-party
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User clicks on created third-party
    And User clicks "Renew" for third-party
    And User clicks "Stop Renewal" for third-party
    Then Message is displayed on confirmation window
      | Are you sure you want to stop the Renewal Process?                           |
      | This cannot be undone and you will have to restart the Renewal Process again |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "FOR RENEWAL"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                                    | STATUS          | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Auto Workflow Renewal Workflow Low Risk | Stopped Renewal | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Auto Workflow Renewal Workflow Low Risk" and status "Stopped Renewal" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name        | Auto Workflow Renewal Workflow Low Risk |
      | Status               | Stopped Renewal                         |
      | Renewal Start Date   | TODAY+0                                 |
      | Renewal Stopped Date | TODAY+0                                 |

  @C35778942
    #  As well checks @C35775404
  Scenario: C35778942: Third-party - Risk Management Overview - Check Start and Stopped Date in the Workflow History modal - Renewal Denied
    When User creates third-party "with renewal workflow Norway"
    And User clicks Start Onboarding for third-party
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User clicks on created third-party
    And User clicks "Renew" for third-party
    And User clicks "Decline Renewal" for third-party
    Then Message is displayed on confirmation window
      | Are you sure you want to decline the Renewal Process?                           |
      | This cannot be undone and you will have to restart the Onboarding Process again |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "RENEWAL DENIED"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                                    | STATUS         | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Auto Workflow Renewal Workflow Low Risk | Renewal Denied | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Auto Workflow Renewal Workflow Low Risk" and status "Renewal Denied" on Risk Management tab
    Then Workflow History headers values should be displayed
      | Workflow Name       | Auto Workflow Renewal Workflow Low Risk |
      | Status              | Renewal Denied                          |
      | Renewal Start Date  | TODAY+0                                 |
      | Renewal Denied Date | TODAY+0                                 |
