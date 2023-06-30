@ui @full_regression @core_regression @react @notification
Feature: Notification Bell

  As a user,
  I want to see bell notifications in React.
  So that it will align with Refinitiv policy.

  @C46712093
  Scenario: C46712093: "NOTIFICATIONS" window is displayed after clicking the bell icon
    Given User logs into RDDC as "Admin"
    When User clicks Notification Bell
    Then The list with notifications is displayed
    When User clicks Notification Bell
    Then The list with notifications is closed

  @C46712096
  @core_regression
  Scenario: C46712096: Corresponding page is displayed after clicking the notification
    Given User logs into RDDC as "Assignee"
    When User creates third-party "with random ID name" via API and open it
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "Approve Onboarding"
    And User fills in "Activity Name" field with "Approve Onboarding"
    And User fills in "Description" field with "Approve Onboarding"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User navigates to Home page
    And User clicks Notification Bell
    Then The list with notifications is shown
    And "Activity has been Assigned" notification displayed with text
      | Approve Onboarding |
    When User clicks "Activity has been Assigned" "Approve Onboarding" notification
    Then Activity Information modal is displayed with details
      | Activity Type      | Activity Name      | Description        | Due Date | Assignee                      | Status      |
      | Approve Onboarding | Approve Onboarding | Approve Onboarding | TODAY+0  | Assignee_AT_FN Assignee_AT_LN | Not Started |