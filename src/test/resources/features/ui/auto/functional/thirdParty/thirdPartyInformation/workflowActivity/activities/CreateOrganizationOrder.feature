@ui @functional @ordering
Feature: Create Organisation Order Type Report

  As an SI internal user that has access right to create order
  I want to be able to request an report thru adhoc
  So that Client will have the option to order without going through an onboarding process

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name and Address details"

  @C34656876
  Scenario: C34656876: Create Order via Adhoc - Due Diligence Report with Organisation Order Type
    When User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    And Create Due Diligence Order page should be shown with default values for "Organisation" order type

  @C34594324
  Scenario: C34594324: Create Order via Adhoc - Verify Adhoc Activity will be created once user initiated Order via Adhoc
    When User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    When User clicks Back button on Due Diligence Order page
    Then Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    Then Risk Management page is displayed
    And Ad Hoc Activity with name "Order Due Diligence Report" is created
    When User clicks on the newly created Ad Hoc Activity with name "Order Due Diligence Report"
    Then Ad Hoc Activity Information modal is displayed with details
      | Activity Type              | Activity Name              | Description                                                                               | Order Details                                | Start Date | Due Date | Assignee                | Status  |
      | Order Due Diligence Report | Order Due Diligence Report | This activity was automatically initiated an adhoc order request for due diligence report | ORDER DETAILS: toBeReplaced - SAVED AS DRAFT | TODAY+0    | TODAY+15 | Admin_AT_FN Admin_AT_LN | Waiting |
