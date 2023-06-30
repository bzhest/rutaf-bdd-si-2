@ui @full_regression @suppliers

Feature: Third-party Risk Management Workflow Activity Overview
  As a Compliance Group User
  I want to see the activities created for a Third-party
  So that I can review them as reference for the Third-party's Onboarding process

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party

  @C35771701
  Scenario: C35771701: Supplier - Risk Management Overview - View and add atttachment/comment at Activity details
    When User clicks on Risk Management tab
    And User clicks workflow with name "Automation Workflow Questionnaire" and status "Onboarding" on Risk Management tab
    Then Workflow History window is displayed
    When User clicks "Assign Questionnaire" Activity details on Workflow History page
    Then Workflow History Activity values should be displayed
      | Activity Type | Assign Questionnaire          |
      | Description   | Description                   |
      | Assessment    | case1                         |
      | Status        | Not Started                   |
      | Assignee      | Assignee_AT_FN Assignee_AT_LN |
      | Risk Area     |                               |
      | Approvers     | Admin_AT_FN Admin_AT_LN       |
      | Reviewers     |                               |
      | Start Date    | TODAY+0                       |
      | Due Date      | TODAY+1                       |
      | Last Update   |                               |
    And Workflow History Activity Attachment Upload field and Browse button are displayed
    And Workflow History Activity Attachment Description field is displayed
    And Workflow History Activity Attachment buttons are displayed
      | CANCEL |
      | UPLOAD |
    And Workflow History Activity Attachment UPLOAD button is disabled
    And Workflow History Activity Comment field is displayed
    And Workflow History Activity Comment buttons are displayed
      | Cancel  |
      | Comment |
    And Workflow History Activity Comment COMMENT button is disabled
    When User uploads "имяФайла.jpg" Attachment on Workflow History page
    Then Workflow History Activity Attachment is displayed
    When User clicks "UPLOAD" button for Workflow History Activity Attachment
    Then Workflow History Activity Attachment table is displayed with headers
      | FILE NAME | DESCRIPTION | UPLOAD DATE |
    And Workflow History Activity Attachment table is displayed with details
      | File Name    | Description | Upload Date |
      | имяФайла.jpg |             | TODAY+      |
    And Workflow History Activity Attachment buttons are available for file "имяФайла"
      | Download |
      | Delete   |
    When User fills in comment field "Auto Activity Comment test" for Workflow History Activity
    And User clicks "Comment" button for Workflow History Activity Comment
    Then Workflow History Activity Comment "Auto Activity Comment test" is added
