@ui @functional @ordering
Feature: Create Order Report Based on Billing Entity

  As an Admin or Internal User that has access right
  I Want To have the ability to select billing entity before initiating order request
  So that the system can validate or filter relevant scope based on entity and finance team will be able to identify on
  how where to bill the order request depending on client business rules

  Background:
    Given User logs into RDDC as "Admin"
    And User makes sure that Custom field "Billing Entity" is set as required via API

  @C33161547 @C36216152
  @onlySingleThread
  Scenario: C33161547, C36216152: Create Order Individual - Verify that Requestor to select billing entity and proceed on IntegraCheck Create Order page if "Billing Entity" was set as required field (SIDEV-9294 , RMS-1214)
    When User creates third-party "workflowGroupUkraineIndividual" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    Then Create Order button is displayed
    And Decline Order button is displayed
    When User clicks Create Order button
    Then Create Due Diligence Order page should be shown with default values for "Individual" order type

  @C33161375
  Scenario: C33161375: Select Billing Entity - Verify Activity Assignee or System Admin should not be able to proceed on IntegraCheck Create Order page when cancelling select Billing Entity (SIDEV-9293 , RMS-1214)
    When User creates third-party "workflowGroupUkraineIndividual" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information Order Details button should contain expected text "ORDER DETAILS: NO ORDER PLACED"
    When User clicks Edit button for Activity
    And User clicks Decline Order button
    Then Declining confirmation pop-up appears
    And 'Are you sure you want to decline order?' message is displayed
    And Declining confirmation pop-up Cancel button is displayed
    And Proceed button for declining is displayed
    When User clicks Declining confirmation pop-up Cancel button
    Then Activity Information Order Details button should contain expected text "ORDER DETAILS: NO ORDER PLACED"
    And Create Order button is enabled

  @C33161450 @C36216152
  @onlySingleThread
  Scenario: C33161450, C36216152: Create Order Organisation - Verify that Requestor to select billing entity and proceed on Due Diligence Create Order page if "Billing Entity" was set as required field (SIDEV-9294, 7929, RMS-1420, RMS-1414 , RMS-1214)
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User verifies third-party is created
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Edit button for Activity
    Then Create Order button is displayed
    And Decline Order button is displayed
    When User clicks Create Order button
    Then Create Due Diligence Order page should be shown with default values for "Organisation" order type
