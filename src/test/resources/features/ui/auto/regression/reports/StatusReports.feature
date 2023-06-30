@ui @full_regression @statusReports
Feature: Reports - Status Reports

  As a user
  I would like to verify Status Reports test scripts
  So that I can get the accurate Status Reports results.

  @C36155943
  Scenario: C36155943: [Status Report] Overview of the page
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    Then "STATUS REPORT" report page is displayed
    And Search filter fields are expected
      | SHOW              |
      | CREATED DATE FROM |
      | TO                |
    And Export to Excel Label is displayed
    And Report 'No Available Data' is displayed

  @C36156127
  @core_regression
  Scenario: C36156127: [Status Report] Search for All Third-party
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User inputs in Search Filter From "TODAY-7"
    And User inputs text in Search Filter To "TODAY+1"
    Then Search table fields are expected
      | THIRD-PARTY NAME |
      | COUNTRY          |
    And Search Result Field is expected

  @C36156140
  @onlySingleThread
  @core_regression
  Scenario: C36156140: [Status Report] Search for My Third-party
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"
    When User navigates to Reports page
    And User selects report category "My Third-party"
    And User inputs in Search Filter From "TODAY-7"
    And User inputs text in Search Filter To "TODAY+1"
    Then Search table fields are expected
      | THIRD-PARTY NAME |
      | COUNTRY          |
    And Search Result Field is expected
    And Search table contains only list of Responsible Party third-party

  @C36156299
  Scenario: C36156299: [Status Report] Check information for the suppliers with onboarding status - NEW
    Given User logs into RDDC as "Admin"
    And User creates third-party "with random ID name"
    When User navigates to Reports page
    And User selects report category "My Third-party"
    And User inputs in Search Filter From "TODAY-1"
    And User inputs text in Search Filter To "TODAY+1"
    And User clicks on newly created Third-party on Report page
    Then Search result view "Third-party Status" is "NEW"
    And Search result view Workflow information section contains text "NO AVAILABLE WORKFLOW"

  @C36157687
  Scenario: C36157687: [Status Report] Check information for the suppliers with onboarding status - ONBOARDING
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User navigates to Reports page
    And User selects report category "My Third-party"
    And User inputs in Search Filter From "TODAY-1"
    And User inputs text in Search Filter To "TODAY+1"
    And User clicks on newly created Third-party on Report page
    Then Search result view "Third-party Status" is "ONBOARDING"
    And Search result view "Country" is "Norway"
    And Search result view "Total No. of Activity" is "2"
    And Search result view "Total No. of Completed Activity" with "green_report" icon is "0"
    And Search result view "Total No. of Not Relevant Activity" with "grey_report" icon is "0"
    And Search result Wizards block contains expected activities data
      | Assign Questionnaire Component | 1 |
      | NEW COMPONENT                  | 1 |
    And Search result Progress bar contains percentage "0%"

  @C36157692
  Scenario: C36157692: [Status Report] Check information for the suppliers with onboarding status - ONBOARDED
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks on "Assign Questionnaire" activity
    And User approves all activities
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User waits for progress bar to disappear from page
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    When User navigates to Reports page
    And User selects report category "My Third-party"
    And User inputs in Search Filter From "TODAY-1"
    And User inputs text in Search Filter To "TODAY+1"
    And User clicks on newly created Third-party on Report page
    Then Search result view "Third-party Status" is "ONBOARDED"
    And Search result view "Country" is "Norway"
    And Search result view "Total No. of Activity" is "2"
    And Search result view "Total No. of Completed Activity" with "green_report" icon is "2"
    And Search result view "Total No. of Not Relevant Activity" with "grey_report" icon is "0"
    And Search result Wizards block contains expected activities data
      | Assign Questionnaire Component | 1 |
      | NEW COMPONENT                  | 1 |
    And Search result Progress bar contains percentage "100%"
    And Status report completed activity tooltip is "(1) Completed Activities"

  @C36157693
  @onlySingleThread
  @core_regression
  Scenario: C36157693: [Status Report] Check exporting of status report to Excel file (RMS-8809)
    Given User logs into RDDC as "Assignee"
    And User creates third-party "with random ID name"
    When User navigates to Reports page
    And User selects report category "My Third-party"
    And User inputs in Search Filter From "TODAY-1"
    And User inputs text in Search Filter To "TODAY+1"
    And User clicks Report Export button
    Then ".xlsx" File with name "RDDCentre_Third-party_Status-Report_" and date format "MMddYYYY" downloaded
    And Third-party Status report content is expected
    And Third-party Status report contains all searched results

  @C36879118
  Scenario: C36879118: [Status Report] Verify error validation for Invalid Date
    Given User logs into RDDC as "Admin"
    When User navigates to Reports page
    And User inputs in Search Filter From "INVALID"
    Then Report From date input Invalid error id displayed
    When User inputs text in Search Filter To "INVALID"
    Then Report To date input Invalid error id displayed
