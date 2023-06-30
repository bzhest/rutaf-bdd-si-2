@ui @riskReports @full_regression
Feature: Reports

  As a user
  I would like to verify Risk Reports test scripts
  So that I can get the accurate Risk Reports results.

  @C36188809
  Scenario: C36188809 : [Risk Report] Overview of the page
    Given User launches RDDC Login page
    When User "Admin" enters username and password
    And User navigates to Reports page
    And User selects Report Tab "Risk Report"
    And Search filter fields are expected
      | SHOW              |
      | CREATED DATE FROM |
      | TO                |
    And Export to Excel Label is displayed
    And Report 'No Available Data' is displayed

  @C36188872 @C36198133
    @core_regression
  Scenario Outline: C36188872 : [Risk Report] Search for All Third-party
    Given User launches RDDC Login page
    When User "Admin" enters username and password
    And User navigates to Reports page
    And User selects Report Tab "Risk Report"
    And User selects report category "<reportCategory>"
    And User inputs in Search Filter From "TODAY-100"
    And User inputs text in Search Filter To "TODAY+0"
    And User inputs text in Risk Areas "All"
    And User clicks Generate Result Button
    And Risk Area Field is displayed "THIRD-PARTY NAME"
    And Risk Area Field is displayed "INDUSTRY TYPE"
    And Risk Area Field is displayed "COUNTRY"
    And Risk Area Field is displayed "AVERAGE RISK SCORE PER THIRD-PARTY"
    And Risk Area names are showed in tooltips when hover on their icons
    And Pagination section is displayed

    Examples:
      | reportCategory |
      | All            |
      | My Third-party |

  @C36198897
  @core_regression
  Scenario: C36198897: [RiskReport] Check exporting of risk report to Excel file
    Given User launches RDDC Login page
    When User "Admin" enters username and password
    And User navigates to Reports page
    And User selects Report Tab "Risk Report"
    And User inputs in Search Filter From "TODAY-100"
    And User inputs text in Search Filter To "TODAY+0"
    And User inputs text in Risk Areas "All"
    And User clicks Generate Result Button
    And User clicks export xls file
    And ".xlsx" File with name "RDDCentre_Third-party_Risk-Report_" and date format "MMddYYYY" downloaded
    And Report xls file content is the same as report table


  @C36878182
  Scenario: C36878182 : [Risk Report] No Results - Verify that No Available Data is displayed
    Given User launches RDDC Login page
    When User "Admin" enters username and password
    And User navigates to Reports page
    And User selects Report Tab "Risk Report"
    And User inputs in Search Filter From "TODAY+2"
    And User inputs text in Search Filter To "TODAY+2"
    And User inputs text in Risk Areas "All"
    And User clicks Generate Result Button
    Then Report 'No Available Data' is displayed

  @C36878251
  Scenario: C36878251 : [Risk Report] Verify error validation for Invalid Date
    Given User launches RDDC Login page
    When User "Admin" enters username and password
    And User navigates to Reports page
    And User selects Report Tab "Risk Report"
    And User inputs in Search Filter From "INVALID"
    And User inputs text in Search Filter To "INVALID"
    And Report From date input Invalid error id displayed
    And Report To date input Invalid error id displayed