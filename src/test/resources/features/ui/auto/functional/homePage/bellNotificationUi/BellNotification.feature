@ui @functional @notification
Feature: Bell Notification

  As a user,
  I want to see bell notifications in React.
  So that it will align with Refinitiv policy.


  @C41511417
  Scenario: Bell Notification icon is displayed
    Given User logs into RDDC as "Admin"
    Then Notification Bell is displayed

  @C41511460
  Scenario: C41511460: Amount of unread notifications is displayed in a red counter
    Given User logs into RDDC as "Assignee"
    When User creates third-party "with random ID name" via API and open it
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User navigates to Home page
    Then Notification Bell Icon contains 1 new notification
    When User opens previously created Third-party
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME_2"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION_2"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User navigates to Home page
    Then Notification Bell Icon contains 2 new notification

  @C41512716
  Scenario: C41512716: The read counter disappears after clicking on the bell icon
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Notification Bell
    And User clicks Notification Bell
    And User clicks Start Onboarding for third-party
    And User navigates to Home page
    Then Notification Bell Icon contains 1 new notification
    When User clicks Notification Bell
    Then The list with notifications is shown
    And Notification Bell Icon counter is not displayed
    When User clicks Set Up option
    Then The list with notifications is closed

  @C32904525
  Scenario: C32904525: Home - Verify notifications in Bell icon (DDO order)
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraineIndividual" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    And User clicks Create Order button
    Then Due Diligence Order form is opened
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    And User populates First Name for Key Principal with "Auto"
    And User populates Last Name for Key Principal with "Principal"
    And User selects Country "Albania" for Key Principal
    And User clicks Add Contact Key Principal button
    And User clicks "Proceed" Alert dialog button
    And User fills in Po No.
    And User gets OrderId from Due Diligence Order page URL
    And User clicks "Place Order" button on Due Diligence Order page
    And User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed
    When User navigates to Home page
    And User clicks Notification Bell
    Then "Order Request Placed" notification displayed with text
      | orderId |
    When User clicks "Order Request Placed" "orderId" notification
    Then Due Diligence Order form is opened

  @C32904525
  Scenario: C32904525: Home - Verify notifications in Bell icon (Activity)
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine"
    And User clicks Start Onboarding for third-party
    And User navigates to Home page
    And User clicks Notification Bell
    Then "Activity has been Assigned" notification displayed with text
      | OrderDueDiligenceReport |
    When User clicks "Activity has been Assigned" "OrderDueDiligenceReport" notification
    Then Activity Information modal is displayed with details
      | Activity Type              | Activity Name           | Description              | Order Details                  | Due Date | Assignee                | Status      |
      | Order Due Diligence Report | OrderDueDiligenceReport | Test Automation activity | ORDER DETAILS: NO ORDER PLACED | TODAY+1  | Admin_AT_FN Admin_AT_LN | Not Started |