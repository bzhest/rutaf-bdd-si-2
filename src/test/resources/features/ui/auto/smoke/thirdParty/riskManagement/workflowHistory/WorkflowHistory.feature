@ui @smoke @workflow_history_risk_management
Feature: Risk Management - Workflow History

  @C44131973
  Scenario: C44131973: Risk Management - Workflow History - Export to PDF
    Given User logs into RDDC as "Admin"
    And User creates third-party "with questionnaire workflow" via API and open it
    When User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User uploads "logo.jpg" Attachment on Workflow History page
    And User clicks "UPLOAD" button for Workflow History Activity Attachment
    And User fills in comment field "Test Comment" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    And User refreshes page
    And User clicks "Assign Questionnaire" Activity details on Workflow History page
    And User clicks Export to PDF link
    Then ".pdf" File with name "RDDCentre_WorkflowHistory_" and date format "MMddYYYY" downloaded