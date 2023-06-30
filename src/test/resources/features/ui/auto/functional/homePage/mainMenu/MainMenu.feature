@ui @functional @main_menu
Feature: Home Page - Main Menu

  As a user,
  I want to see a main menu in React.
  So that it will align with Refinitiv policy.

  @C41611545 @C32904539
  Scenario: C41611545, C32904539: Refinitiv Due Diligence Centre logo is displayed on the top left of the page
    Given User logs into RDDC as "Admin"
    When Refinitiv Logo is displayed

  @C41611589 @C41611613 @C41611625 @C32904539
  Scenario: C41611589, C41611613, C41611625, C32904539: "THIRD-PARTY OVERVIEW" page is displayed after clicking the [THIRD-PARTY] button in the main menu
    Given User logs into RDDC as "Admin"
    When User hovers over "Third-party" home page button
    Then Home Page "Third-party" button color is blue
    When User clicks on "Third-party" home page button
    Then Third-party Overview table should be displayed
    And Home Page "Third-party" button color is blue
    When User hovers over "Reports" home page button
    Then Home Page "Reports" button color is blue
    When User clicks on "Reports" home page button
    Then "STATUS REPORT" report page is displayed
    And Home Page "Reports" button color is blue
    When User hovers over "Home" home page button
    Then Home Page "Home" button color is blue
    When User clicks on "Home" home page button
    Then My Tasks tabs is displayed with the following widget
      | ASSIGNED ACTIVITIES         |
      | ITEMS TO APPROVE            |
      | ITEMS TO REVIEW             |
      | THIRD-PARTY FOR RENEWAL     |
      | DUE DILIGENCE ORDERS        |
      | PENDING ORDERS FOR APPROVAL |
    And Home Page "Home" button color is blue

  @C41611638
  Scenario: C41611638: Tooltip with full name is displayed when hovering over the "Hi, {name}" line
    Given User logs into RDDC as "Admin"
    When User hovers over User Menu
    Then Tooltip with first name of logged in user is displayed

  @C41611832
  Scenario: C41611832: First 8 characters of the user's First Name is displayed in the "Hi, {name}" line when the name has more than 8 characters
    Given User logs into RDDC as "Admin"
    Then First 8 characters of the user's First Name is displayed on Setup menu dropdown after "Hi, "

  @C41613733
  Scenario: C41613733: Default placeholder of the user profile photo is displayed on the left side of "Hi, {name}" line
    Given User logs into RDDC as "admin double"
    Then Profile photo icon on the upper right corner is default one

  @C41616082
  Scenario: C41616082: User profile photo is displayed on the left side of "Hi, {name}" line
    Given User logs into RDDC as "Internal User for Editing"
    When User clicks User Menu
    And User clicks Preferences option
    And User uploads Personal Details "logo.jpg" photo
    And User clicks Save preferences button
    And User waits for progress bar to disappear from page
    Then Personal Details section photo is displayed
    When User navigates to Home page
    And Profile photo icon on the upper right corner of the screen is displayed

  @C32904528
  Scenario: C32904528 : My Tasks - Verify that footer contains privacy link to Refinitiv and background footer is changed to Refinitiv blue
    Given User logs into RDDC as "Admin"
    Then Footer contains text "Refinitiv Due Diligence Centre"
    When User clicks footer link
    Then User should be redirected to "https://www.refinitiv.com/en/policies/privacy-statement"

  @C35738191
  Scenario: C35738191 : Dashboard Role enabled - Verify that previous page is displayed when user clicks Browser Back button
    Given User logs into RDDC as "Admin"
    Then Dashboard of Internal Users is displayed with the following tabs
      | MY TASKS            |
      | THIRD-PARTY METRICS |
      | ACTIVITY METRICS    |
    When User selects Third-party Metrics Tab
    Then Third-party Metrics Onboarding table is displayed with minor column names
      | RISK TIER | COUNT | PERCENT | NEW | IN PROGRESS | (LAST 90 DAYS) | LONGEST | SHORTEST | AVERAGE |
    When User clicks on "Third-party" home page button
    Then Third-party Overview table should be displayed
    When User clicks back browser button
    Then Third-party Metrics Onboarding table is displayed with minor column names
      | RISK TIER | COUNT | PERCENT | NEW | IN PROGRESS | (LAST 90 DAYS) | LONGEST | SHORTEST | AVERAGE |
    When User selects Activity Metrics Tab
    Then Activity Metrics table is displayed with header column names
      | ALL ACTIVITIES | QUESTIONNAIRE | DUE DILIGENCE REPORTS |
    When User clicks on "Third-party" home page button
    Then Third-party Overview table should be displayed
    When User clicks back browser button
    Then Activity Metrics table is displayed with header column names
      | ALL ACTIVITIES | QUESTIONNAIRE | DUE DILIGENCE REPORTS |
    When User selects My Tasks tab
    Then My Tasks tabs is displayed with the following widget
      | ASSIGNED ACTIVITIES         |
      | ITEMS TO APPROVE            |
      | ITEMS TO REVIEW             |
      | THIRD-PARTY FOR RENEWAL     |
      | DUE DILIGENCE ORDERS        |
      | PENDING ORDERS FOR APPROVAL |
    When User clicks on "Third-party" home page button
    Then Third-party Overview table should be displayed
    When User clicks back browser button
    Then My Tasks tabs is displayed with the following widget
      | ASSIGNED ACTIVITIES         |
      | ITEMS TO APPROVE            |
      | ITEMS TO REVIEW             |
      | THIRD-PARTY FOR RENEWAL     |
      | DUE DILIGENCE ORDERS        |
      | PENDING ORDERS FOR APPROVAL |