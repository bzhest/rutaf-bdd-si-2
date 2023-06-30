@ui @suppliers

Feature: Third-party Risk Management Workflow Overview
  As a Compliance Group User
  I want the system to save the workflow details triggered for Third-Parties
  So that I can have a record of the workflows for future references

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with questionnaire workflow" via API and open it

  @C35775601
  @core_regression
  Scenario: C35775601: Third-Party - Risk Management Overview - Onboarding Trigger
    When User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                              | STATUS     | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Automation Workflow Questionnaire | Onboarding | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |

  @C35729445
  @full_regression
  Scenario: C35729445: Third-Party - Risk Management Overview - Viewing the details of a Triggered Workflow
    When User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    Then Workflow table is displayed with the next headers and details for the triggered workflow
      | NAME                              | STATUS     | OVERALL RISK SCORE | INITIATED BY            | START DATE | LAST UPDATE |
      | Automation Workflow Questionnaire | Onboarding | 2.4                | Admin_AT_FN Admin_AT_LN | TODAY      | TODAY       |
    When User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    And Workflow History headers titles are displayed
      | Workflow Name | Workflow Type | Description | Initiated By | Status | Onboarding Start Date | Onboarded Decision Date | Overall Risk Score |
    And Workflow History headers values should be displayed
      | Workflow Name           | Automation Workflow Questionnaire             |
      | Workflow Type           | Onboarding                                    |
      | Description             | Automation Workflow Questionnaire Description |
      | Initiated By            | Admin_AT_FN Admin_AT_LN                       |
      | Status                  | Onboarding                                    |
      | Onboarding Start Date   | TODAY+0                                       |
      | Onboarded Decision Date |                                               |
      | Overall Risk Score      | 2.4                                           |
    And Workflow History activity groups titles should be displayed
      | GROUP # | ACTIVITY NAME |
    And Workflow History activity groups values should be displayed
      | 0 | Assign Questionnaire  |
      | 1 | Assign Questionnaire1 |

  @C35775681
  @full_regression
  Scenario: C35775681: Third-Party - Risk Management Overview - Check Third-Party without records
    When User clicks on Risk Management tab
    Then Workflow History table shows 'No Available Data' message

  @C35804326
  @full_regression
  Scenario: C35804326: Third-Party - Risk Management Overview - Export to PDF
    When User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User uploads "logo.jpg" Attachment on Workflow History page
    And User clicks "UPLOAD" button for Workflow History Activity Attachment
    And User fills in comment field "Auto Activity Comment test" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    And User refreshes page
    And User clicks "Assign Questionnaire" Activity details on Workflow History page
    And User clicks Export to PDF link
    Then ".pdf" File with name "RDDCentre_WorkflowHistory_" and date format "MMddYYYY" downloaded