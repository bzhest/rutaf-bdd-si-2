@ui @functional @ordering
Feature: Create Individual Order Type Report

  As a requestor of DD
  I want to be submit Order IntegraCheck® report
  So that I can receive a due diligence report

  @C33161677
  Scenario: C33161677: Create Order Individual - Verify that user should be able to access Create Order and select Individual as an order type on Request IntegraCheck® Report Activity
    Given User logs into RDDC as "Admin"
    And User makes sure that Custom field "Billing Entity" is set as not required via API
    And User creates third-party "workflowGroupUkraineIndividual"
    When User clicks Start Onboarding for third-party
    And User creates an order for activity "OrderDueDiligenceReport"
    Then Create Due Diligence Order page is opened
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    And User fills Key Principle form data "Key Principle all fields"
    And User accepts Key Principle module window
    And User closes Key Principle creation alert
    Then Create Due Diligence Order page should be shown with default values for "Individual" order type

  @C33161358
  Scenario: C33161358: Placed Order - Verify that Requestor or Approver should be able to add a comment even the case was already placed and sync in PSA
    Given User logs into RDDC as "Admin"
    And User makes sure that Custom field "Billing Entity" is set as not required via API
    And User creates third-party "workflowGroupUkraineIndividual"
    When User clicks Start Onboarding for third-party
    And User creates an order for activity "OrderDueDiligenceReport"
    Then Create Due Diligence Order page is opened
    When User add comment with text "Some short text for comment"
    Then User should see created comment
    When User add comment with text "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of LetrasetLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
    Then User should see created comment


