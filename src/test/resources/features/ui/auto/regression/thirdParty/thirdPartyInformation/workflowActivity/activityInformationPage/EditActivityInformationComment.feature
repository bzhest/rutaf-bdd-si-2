@ui @full_regression @react @activity_information @robusta
Feature: Activity Information Page - Edit Comment

  As a RDDC User
  I want to add the comment to activity information
  so that I will be able to all comment related to the activity

  @C38461891
  Scenario: C38461891: Activity Information page - Edit should be availble on each comments
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds comment "Activity comment text N1"
    Then Activity information Comment "Activity comment text N1" edit button is displayed

  @C38461892
  @core_regression
  Scenario: C38461892: Activity Information page - User logged can edit its own comment
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
    And User clicks on Activity information page Edit comment button "Activity comment text N1"
    Then Activity information page comment text area contains "Activity comment text N1"
    And Activity information page comment block button "Cancel" is displayed
    And Activity information page comment block button "Save" is displayed

  @C38461893
  Scenario: C38461893: Activity Information page - User logged CANNOT edit other User's comment
    Given User logs into RDDC as "Assignee"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds comment "Activity comment text N1"
    And User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Created comment on Activity Information page is displayed
    And Activity information Comment "Activity comment text N1" edit button is not displayed

  @C38461894
  @core_regression
  @RMS-20610
  Scenario: C38461894: Activity Information page - Save Edit Comment
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds comment "Activity comment text N1"
    And User on Activity information page edits comment "Activity comment text N1" with 5001 alphanumeric and special characters
    And User clicks Activity Information comment button "Save"
    Then Alert Icon is displayed with text
      | Success! Comment has been updated. |
    When User refreshes page
    Then The 5000-character comment on Activity Information page is displayed

  @C38461895
  Scenario: C38461895: Activity Information page - Cancel Edit Comment
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
    And User clicks on Activity information page Edit comment button "Activity comment text N1"
    Then Activity information page comment text area contains "Activity comment text N1"
    When User clicks Activity Information comment button "Cancel"
    Then Created comment on Activity Information page is displayed
