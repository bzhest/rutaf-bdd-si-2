@ui @sanity @country_checklist @multilanguage

Feature: Country Checklist management

  As a user
  I want to setup country checklist
  So that will trigger notifications when onboarding suppliers from different countries

  @C32988217
  Scenario: C32988217: Set Up - Country Checklist - Add List Name
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User clicks Set Up option
    And User clicks Country Checklist in Set Up menu
    Then Country Checklist page is loaded
    When User clicks Add List Name button
    Then "setUp.countryChecklist.add setUp.countryChecklist.countryChecklist" details page is displayed
    When User populates List Name field with "Auto List Multilanguage Name"
    And User selects "Caution" alert type
    And User populates alert message with "Auto Alert Message"
    Then Country Checklist Active checkbox is ticked
    When User clicks Save and Assign button
    Then "setUp.countryChecklist.assignCountryChecklistBreadcrumb" details page is displayed
    When User selects Country "Albania" from "Available Countries" list
    And User clicks ">" move button
    Then Country "Albania" is moved to "Selected Countries" list
    When User clicks Save button for assigning Country
    Then Country "Auto List Multilanguage Name" is displayed with values
      | List Name                    | Alert Type | Status                              | Date Created | Last Update |
      | Auto List Multilanguage Name | Caution    | setUp.countryChecklist.activeStatus | MM/dd/YYYY   |             |
