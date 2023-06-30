@ui @functional @dashboard @dashboardActivityMetrics
Feature: Home/Dashboard - Activity Metrics

  As a user
  I would like to verify Dashboard 'All Activity' Metrics test scripts
  So that I can get the accurate 'All Activity' Metrics results.

  Background:
    Given User logs into RDDC as "Admin"
    When User selects Activity Metrics Tab
    Then Activity Metrics table is displayed with header column names
      | ALL ACTIVITIES | QUESTIONNAIRE | DUE DILIGENCE REPORTS |
    And Activity Metrics table is displayed with major column names
      | ASSIGNED | APPROVALS | REVIEWS | INTERNAL | EXTERNAL |
    And Activity Metrics table is displayed with minor column names
      | TOTAL ACTIVE | PAST DUE | DUE WITHIN 7 DAYS | DUE IN 8-14 DAYS | AVERAGE COMPLETION (DAYS) |
    And Activity Metrics "COUNT OF ACTIVE ACTIVITIES" bar chart is displayed
    And Activity Metrics "COUNT OF ACTIVE QUESTIONNAIRES" bar chart is displayed
    And Activity Metrics "COUNT OF IN-PROGRESS DUE DILIGENCE REPORTS" bar chart is displayed
    And Dashboard Metrics filter drop-down contains options
      | All Third-party |
      | My Third-party  |
    When User selects All Third-party Third-party Metrics show option
    Then Dashboard Metrics filter drop-down option "All Third-party" is selected
    And Activity metrics shows only activities where user assigned as Responsible Party and share Division with logged in user

  @C35714482
  Scenario: C35714482: All Third-party - All Activities - Assigned - Verify count of Active Activities
    Then All Activities are assigned to Assignee and not yet Done or Completed
    And "Assigned activities" group "TOTAL ACTIVE" displays correct count
    And "Assigned activities" group "PAST DUE" displays correct count
    And "Assigned activities" group "DUE WITHIN 7 DAYS" displays correct count
    And "Assigned activities" group "DUE IN 8-14 DAYS" displays correct count

  @C35714483
  Scenario: C35714483: All Third-party - All Activities - Approvals -Verify count of activities in Approval stage
    Then "Approvals activities" group "TOTAL ACTIVE" displays correct count
    And "Approvals activities" group "PAST DUE" displays correct count
    And "Approvals activities" group "DUE WITHIN 7 DAYS" displays correct count
    And "Approvals activities" group "DUE IN 8-14 DAYS" displays correct count

  @C35714484
  Scenario: C35714484: All Third-party - All Activities - Approvals -Verify count of activities in Approval stage
    Then "Reviews activities" group "TOTAL ACTIVE" displays correct count
    And "Reviews activities" group "PAST DUE" displays correct count
    And "Reviews activities" group "DUE WITHIN 7 DAYS" displays correct count
    And "Reviews activities" group "DUE IN 8-14 DAYS" displays correct count

  @C35714485
  Scenario: C35714485: All Third-party - Questionnaire - Internal - Verify count of Internal Questionnaire
    Then Activity matrix Questionnaire shows only "INTERNAL" types
    And "Internal questionnaires" group "TOTAL ACTIVE" displays correct count
    And "Internal questionnaires" group "PAST DUE" displays correct count
    And "Internal questionnaires" group "DUE WITHIN 7 DAYS" displays correct count
    And "Internal questionnaires" group "DUE IN 8-14 DAYS" displays correct count

  @C35714486
  Scenario: C35714486: All Third-party - Questionnaire - External - Verify count of External Questionnaire
    Then Activity matrix Questionnaire shows only "EXTERNAL" types
    And "External questionnaires" group "TOTAL ACTIVE" displays correct count
    And "External questionnaires" group "PAST DUE" displays correct count
    And "External questionnaires" group "DUE WITHIN 7 DAYS" displays correct count
    And "External questionnaires" group "DUE IN 8-14 DAYS" displays correct count

  @C35714487
  Scenario: C35714487: All Third-party - Due Diligence Reports - Verify the count of active Due Diligence Reports
    Then "Due Diligence Reports" group "TOTAL ACTIVE" displays correct count
    And "Due Diligence Reports" group "PAST DUE" displays correct count
    And "Due Diligence Reports" group "DUE WITHIN 7 DAYS" displays correct count
    And "Due Diligence Reports" group "DUE IN 8-14 DAYS" displays correct count

  @C35714488
  Scenario: C35714488: All Third-party - Activity Metrics - Verify that another row named Average Completion (Days) is added below 'Due in 8 to 14 Days'
    Then Activity Metrics - Average Completion table row should be displayed

  @C35714489
  Scenario: C35714489: All Third-party - Verify Average Completion (Days) in All Activities
    Then "All Activities" group "AVERAGE COMPLETION" displays correct count

  @C35714490 @C35714491
  Scenario: C35714490 C35714491: All Third-party - Verify Average Completion (Days) x Internal, External
    Then "Internal questionnaires" group "AVERAGE COMPLETION" displays correct count
    And "External questionnaires" group "AVERAGE COMPLETION" displays correct count

  @C35714492
  Scenario: C35714492: All Third-party - Verify Average Completion (Days) x Due Diligence Reports
    Then "Due Diligence Reports" group "AVERAGE COMPLETION" displays correct count
