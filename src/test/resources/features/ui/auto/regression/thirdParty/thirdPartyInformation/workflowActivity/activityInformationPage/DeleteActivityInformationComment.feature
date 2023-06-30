@ui @full_regression @react @activity_information
Feature: Activity Information Page - Delete Comment

  As a RDDC User
  I want to add the comment to activity information
  so that I will be able to all comment related to the activity

  @C38461896
  Scenario: C38461896: Activity Information page - Delete should be availble on each comments
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds comment "Activity comment text N1"
    Then Activity information Comment "Activity comment text N1" delete button is displayed

  @C38461897
  @core_regression
  Scenario: C38461897: Activity Information page - User logged can Delete its own comment
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds comment "Activity comment text N1"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information Comment "Activity comment text N1" delete button is displayed
    When User on Activity information page deletes comment "Activity comment text N1"
    Then Message is displayed on confirmation window
      | DELETE COMMENT                                                              |
      | Are you sure you want to delete this Comment? This change cannot be undone. |
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    When User on Activity information page deletes comment "Activity comment text N1"
    And User clicks Delete button on confirmation window
    Then Confirmation window is disappeared
    And Created comment on Activity Information page is not displayed

  @C38461898
  Scenario: C38461898: Activity Information page - User logged CANNOT Delete other User's comment
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds comment "Activity comment text N1"
    And User logs into RDDC as "Restricted with Edit permissions"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Created comment on Activity Information page is displayed
    And Activity information Comment "Activity comment text N1" delete button is not displayed

  @C38602875
  Scenario: C38602875: Activity Information page - Comments left from previous onboarding activities should be reset after third-party is being stopped from onboarding
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds comment "Activity comment text N1"
    And User clicks Back button to return from Activity modal
    And User clicks on "OrderDueDiligenceReport" activity
    Then Created comment on Activity Information page is displayed
    When User clicks Back button to return from Activity modal
    And User clicks "Stop Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Created comment on Activity Information page is not displayed
