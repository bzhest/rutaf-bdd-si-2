@ui @full_regression @value_management @region
Feature: Value Management - Region

  As a RDDC Administrator
  I want see the Region Configured in the system
  So that I can review the Region when needed

  Background:
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User navigates to Value Management page

  @C36105280
  Scenario: C36105280: [Value Management Setup] Overview - Verify that Value Management page has correct content and view
    Then Value Management table displayed with columns
      | FIELDS       |
      | LAST UPDATED |
    And Value Management table contain records in order
      | Region                  |
      | Country                 |
      | Industry Type           |
      | Business Category       |
      | Affiliation             |
      | Revenue                 |
      | Relationship Visibility |
      | Currency                |
      | Sourcing Method         |
      | Sourcing Type           |
      | Spend Category          |
      | Product Impact          |
      | Commodity Type          |
      | Contract Status         |
      | Company Type            |
      | Question Category       |
      | Contract Type           |
      | Questionnaire Category  |
      | Relationship Type       |
      | Design Agreement        |
      | Organisation Size       |
      | Risk Scoring Range      |
      | Activity Type           |
      | Due Diligence Add-Ons   |
    And Value Management record edit button should be displayed only for Values
      | Contract Status        |
      | Question Category      |
      | Contract Type          |
      | Questionnaire Category |
      | Relationship Type      |
      | Risk Scoring Range     |
      | Activity Type          |
      | Due Diligence Add-Ons  |
    And Value Management table does not contain records
      | Activity Priority |

  @C36099311
  Scenario: C36099311: [Value Management Setup] Region: Region Overview - Verify that Region overview page has correct content and view
    When User clicks "Region" value
    Then Value Management "Region" overview page is displayed
    And Value Management table displayed with columns
      | VALUE |
    And Current URL contains "/ui/admin/value-management/" endpoint
    And Items per page drop-down should be displayed
    When User selects "50" items per page
    Then Region table contains all the Regions in the system
    And Value Management table is sorted by "Value" field in "ASC" order
    When User clicks Value Management "Value" column
    Then Value Management table is sorted by "Value" field in "DESC" order

  @C36099372
  Scenario: C36099372: [Value Management Setup] Region: Region Overview Pagination
    When User clicks "Region" value
    Then Value Management "Region" overview page is displayed
    And Pagination option "10" is selected
    And Table displayed with up to 10 "Regions" for first page
    When User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    And Pagination buttons should be visible
      | first | previous | next | last |
    When User selects "10" items per page
    Then Table displayed with up to 10 "Regions" for first page
    When User selects "50" items per page
    Then Table displayed with up to 50 "Regions" for first page
    When User selects "25" items per page
    Then Table displayed with up to 25 "Regions" for first page

  @C36101748
  @RMS-28297
  Scenario: C36101748: [Value Management Setup] Region - Verify that assigned countries are displayed in the Country dropdown when the configured region is selected
    When User opens third-party creation form
    And User selects first Address Region
    Then Add third-party Countries dropdown contains only countries for selected region
    #    TODO update step implementation when RMS-28297 will be fixed
    When User fills third-party creation form with third-party's test data "with Complete Details and country Ukraine"
    And User submits Third-party creation form
    Then User verifies third-party is created
    When User clicks General and Other Information section "Edit" button
    And User expands "Address" section
    Then Add third-party Countries dropdown contains only countries for selected region
    When User creates Associated Party "with key principal"
    And User clicks Associated Party's Address section "Edit" button
    Then Edit Countries for Associated Party dropdown contains only countries for selected region

  @C45614330
  @alamid
  Scenario: C45614330 - [Value Management Setup] Region: Region - Region values-  Verify that Region values  page has correct content and view
    When User clicks "Region" value
    Then Value Management "Region" overview page is displayed
    When User selects "50" items per page or max value
    Then User verifies each region contains countries according to Region List
    And Value Management "Region" overview page is displayed