@ui @full_regression @country_checklist
Feature: Country Checklist management

  As a RDDC Administrator
  I want to be able to create new Country Checklists
  So that I can save Information about Third-parties that are not pre-configured in RDDC

  @C36064058
  @core_regression
  Scenario: C36064058: [Country Checklist Setup] Adding - Verify that a List Name can be created with assigned countries
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User clicks Country Checklist in Set Up menu
    Then Country Checklist page is loaded
    When User clicks Add List Name button
    Then "Add Country Checklist" details page is displayed
    And Country Checklist "List Name" required blank field is displayed
    And Country Checklist "Alert Message" required blank field is displayed
    And Country Checklist Active checkbox is ticked
    And Country Checklist Alert Type list id displayed with colored options
      | Informational |
      | Caution       |
      | Warning       |
    And Country Checklist Alert Type "Informational" is ticked
    And Country Checklist "Save and Assign" button is displayed
    And Country Checklist "Cancel" button is displayed
    When User populates List Name field with "toBeReplaced"
    And User selects "Caution" alert type
    And User populates alert message with "Auto Alert Message"
    And User clicks Save and Assign button
    Then "Assign Country Checklist" details page is displayed
    And Country Checklist Name is saved in the system
    And Available Countries Container contains all the countries in the system
    And Selected Countries Container is displayed
    And Assign Country "<" button is displayed
    And Assign Country ">" button is displayed
    And Assign Country "Cancel" button is displayed
    And Assign Country "Save" button is displayed
    When User selects Country "Belize" from "Available Countries" list
    And User selects Country "Aruba" from "Available Countries" list
    And User selects Country "Australia" from "Available Countries" list
    And User clicks ">" move button
    Then Country "Belize" is moved to "Selected Countries" list
    And Country "Aruba" is moved to "Selected Countries" list
    And Country "Australia" is moved to "Selected Countries" list
    When User selects Country "Aruba" from "Selected Countries" list
    And User selects Country "Australia" from "Selected Countries" list
    And User clicks "<" move button
    Then Country "Aruba" is moved to "Available Countries" list
    And Country "Australia" is moved to "Available Countries" list
    When User clicks Save button for assigning Country
    Then Country Checklist page is loaded
    And Country "toBeReplaced" is displayed with values
      | List Name    | Alert Type | Status | Date Created | Last Update |
      | toBeReplaced | Caution    | Active | MM/dd/YYYY   |             |
    When User creates third-party "with mandatory fields"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks General and Other Information section "Edit" button
    And User updates Address section with values
      | Country |
      | Belize  |
    And User clicks General and Other Information section "Save" button
    And User clicks General and Other Information section "Edit" button
    And User updates Bank Details on position 1 with values
      | Bank Country |
      | Belize       |
    And User clicks General and Other Information section "Save" button
    Then "Caution" 'i' icon button is displayed beside add "Address" section
    And "Caution" 'i' icon button is displayed beside add "Bank Details" section

  @C36067555
  @core_regression
  Scenario: C36067555: [Country Checklist Setup] - Assign Country from Overview page
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User clicks Country Checklist in Set Up menu
    Then Country Checklist page is loaded
    And For each Country Checklist record in the list controls buttons should be displayed
    When User clicks Add List Name button
    And User populates List Name field with "toBeReplaced"
    And User selects "Caution" alert type
    And User populates alert message with "Auto Alert Message"
    And User clicks Save and Assign button
    And User clicks Save button for assigning Country
    And User clicks assign button for country checklist "toBeReplaced"
    Then "Assign Country Checklist" details page is displayed
    When User selects Country "Albania" from "Available Countries" list
    And User selects Country "Aruba" from "Available Countries" list
    And User selects Country "Australia" from "Available Countries" list
    And User clicks ">" move button
    Then Country "Albania" is moved to "Selected Countries" list
    And Country "Aruba" is moved to "Selected Countries" list
    And Country "Australia" is moved to "Selected Countries" list
    When User selects Country "Albania" from "Selected Countries" list
    And User selects Country "Australia" from "Selected Countries" list
    And User clicks "<" move button
    Then Country "Albania" is moved to "Available Countries" list
    And Country "Australia" is moved to "Available Countries" list
    When User clicks Save button for assigning Country
    And Country Checklist page is loaded
    And User clicks assign button for country checklist "toBeReplaced"
    Then "Assign Country Checklist" details page is displayed
    And Country "Albania" is moved to "Available Countries" list
    And Country "Australia" is moved to "Available Countries" list
    And Country "Aruba" is moved to "Selected Countries" list
    When User selects Country "Algeria" from "Available Countries" list
    And User clicks ">" move button
    And Country "Algeria" is moved to "Selected Countries" list
    And User clicks Cancel Assign Country button
    Then Country Checklist page is loaded
    And User clicks assign button for country checklist "toBeReplaced"
    Then "Assign Country Checklist" details page is displayed
    And Country "Algeria" is moved to "Available Countries" list
    And Country "Aruba" is moved to "Selected Countries" list

  @C36068933
  @core_regression
  Scenario: C36068933: [Country Checklist Setup] Role Implementation - Verify that only the authorized users are able to configure the CCS in the System
    Given User logs into RDDC as "Admin"
    When User saves existing Country Checklist id
    And User logs into RDDC as "user without onboarding and renewal accesses"
    And User clicks Set Up option
    Then Country Checklist option is not displayed
    When User opens Country Checklist page "/ui/admin/country-checklist"
    Then Current URL contains endpoint "/ui/forbidden"
    When User opens Country Checklist page "/ui/admin/country-checklist/add"
    Then Current URL contains endpoint "/ui/forbidden"
    When User opens Country Checklist page "/ui/admin/country-checklist/countryChecklistId"
    Then Current URL contains endpoint "/ui/forbidden"
    When User opens Country Checklist page "/ui/admin/country-checklist/countryChecklistId/edit"
    Then Current URL contains endpoint "/ui/forbidden"
    When User opens Country Checklist page "/ui/admin/country-checklist/countryChecklistId/assign-country"
    Then Current URL contains endpoint "/ui/forbidden"
    And The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    And Back button is displayed

  @C36066444
  Scenario: C36066444: [Country Checklist Setup] Adding - Verify that a List Name can be created without assigned countries and fields validation
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User clicks Country Checklist in Set Up menu
    Then Country Checklist page is loaded
    When User clicks Add List Name button
    And User populates List Name field with "toBeReplaced"
    And User populates alert message with "Auto Alert Message"
    And User clicks Cancel Assign Country List Name form
    Then Country Checklist page is loaded
    And Country Checklist "toBeReplaced" is not displayed
    When User clicks Add List Name button
    Then "Add Country Checklist" details page is displayed
    When User clicks Save and Assign button
    Then Alert Icon is displayed with text
      | Cannot Save.                        |
      | Please complete the required fields |
    And Error message 'This field is required' is displayed for Country Checklist "List Name" field
    And Error message 'This field is required' is displayed for Country Checklist "Alert Message" field
    When User clicks Close Toast message button
    And User populates List Name field with "existing"
    And User populates alert message with "Auto Alert Message"
    And User clicks Save and Assign button
    Then Alert Icon is displayed with text
      | Cannot save.                     |
      | Country checklist already exists |
    When User populates List Name field with "toBeReplaced"
    And User clicks Save and Assign button
    Then "Assign Country Checklist" details page is displayed
    When User selects Country "Albania" from "Available Countries" list
    And User selects Country "Aruba" from "Available Countries" list
    And User selects Country "Australia" from "Available Countries" list
    And User clicks ">" move button
    Then Country "Albania" is moved to "Selected Countries" list
    And Country "Aruba" is moved to "Selected Countries" list
    And Country "Australia" is moved to "Selected Countries" list
    When User selects Country "Albania" from "Selected Countries" list
    And User selects Country "Australia" from "Selected Countries" list
    And User clicks "<" move button
    Then Country "Albania" is moved to "Available Countries" list
    And Country "Australia" is moved to "Available Countries" list
    When User clicks Cancel Assign Country button
    Then Country Checklist page is loaded
    And Country "toBeReplaced" is displayed with values
      | List Name    | Alert Type    | Status | Date Created | Last Update |
      | toBeReplaced | Informational | Active | MM/dd/YYYY   |             |
