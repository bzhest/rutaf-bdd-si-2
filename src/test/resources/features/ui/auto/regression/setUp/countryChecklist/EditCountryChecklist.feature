@ui @full_regression @country_checklist

Feature: Edit Country Checklist management

  As a Third-party Administrator
  I want to be able to edit Country Checklists
  So that I can change the details of the Country Checklists in Third-party\

  Background:
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User clicks Country Checklist in Set Up menu
    Then Country Checklist page is loaded
    When User clicks Add List Name button
    Then "Add Country Checklist" details page is displayed
    When User populates List Name field with "toBeReplaced"
    And User populates alert message with "Auto Alert Message"
    And User clicks Save and Assign button
    Then "Assign Country Checklist" details page is displayed
    When User clicks Cancel Assign Country button
    Then Country Checklist page is loaded

  @C36067601
  Scenario: C36067601: [Country Checklist Setup] - Edit List Name from Country Checklist Overview page
    When User clicks edit button for country checklist "toBeReplaced"
    Then "Edit Country Checklist" details page is displayed
    And Country Checklist "List Name" required populated field is displayed
    And Country Checklist "Alert Message" required populated field is displayed
    And Country Checklist "List Name" populated with "countryChecklistName"
    And Country Checklist "Alert Message" populated with "countryChecklistAlertMessageContext"
    And Country Checklist Active checkbox is ticked
    And Country Checklist Alert Type list id displayed with colored options
      | Informational |
      | Caution       |
      | Warning       |
    And Country Checklist Alert Type "Informational" is ticked
    And Country Checklist "Save and Assign" button is displayed
    And Country Checklist "Cancel" button is displayed
    And Country Checklist "Save" button is displayed
    When User populates List Name field with "toBeReplaced"
    And User selects "Caution" alert type
    And User populates alert message with "Auto Alert Message Updated"
    And User clicks Save button for edit assigning Country
    Then Country Checklist page is loaded
    And Country "toBeReplaced" is displayed with values
      | List Name    | Alert Type | Status | Date Created | Last Update |
      | toBeReplaced | Caution    | Active | MM/dd/YYYY   | MM/dd/YYYY  |
    When User clicks edit button for country checklist "toBeReplaced"
    Then "Edit Country Checklist" details page is displayed
    When User populates List Name field with "toBeReplaced"
    And User selects "Caution" alert type
    And User populates alert message with "Auto Alert Message Second Update"
    And User clicks Save and Assign button
    Then "Assign Country Checklist" details page is displayed
    When User selects Country "Albania" from "Available Countries" list
    And User selects Country "Belize" from "Available Countries" list
    And User selects Country "Australia" from "Available Countries" list
    And User clicks ">" move button
    Then Country "Albania" is moved to "Selected Countries" list
    And Country "Belize" is moved to "Selected Countries" list
    And Country "Australia" is moved to "Selected Countries" list
    When User selects Country "Albania" from "Selected Countries" list
    And User selects Country "Australia" from "Selected Countries" list
    And User clicks "<" move button
    Then Country "Albania" is moved to "Available Countries" list
    And Country "Australia" is moved to "Available Countries" list
    When User clicks Save button for assigning Country
    Then Country Checklist page is loaded
    And Country "toBeReplaced" is displayed with values
      | List Name    | Alert Type | Status | Date Created | Last Update |
      | toBeReplaced | Caution    | Active | MM/dd/YYYY   | MM/dd/YYYY  |
    When User clicks assign button for country checklist "toBeReplaced"
    Then "Assign Country Checklist" details page is displayed
    And Country "Belize" is moved to "Selected Countries" list
    When User clicks Cancel Assign Country button
    And User clicks edit button for country checklist "toBeReplaced"
    Then "Edit Country Checklist" details page is displayed
    When User populates List Name field with "cancel case"
    And User selects "Caution" alert type
    And User populates alert message with "Auto Alert Message Third Update"
    And User clicks Cancel Assign Country List Name form
    Then Country Checklist page is loaded
    And Country "toBeReplaced" is displayed with values
      | List Name    | Alert Type | Status | Date Created | Last Update |
      | toBeReplaced | Caution    | Active | MM/dd/YYYY   | MM/dd/YYYY  |
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


  @C36068810
  Scenario: C36068810: [Country Checklist Setup] - Edit List Name from View List Name page
    When User clicks on Country Checklist "toBeReplaced"
    And User clicks view Edit Country Checklist button
    Then "Edit Country Checklist" details page is displayed
    And Country Checklist "List Name" required populated field is displayed
    And Country Checklist "Alert Message" required populated field is displayed
    And Country Checklist "List Name" populated with "countryChecklistName"
    And Country Checklist "Alert Message" populated with "countryChecklistAlertMessageContext"
    And Country Checklist Active checkbox is ticked
    And Country Checklist Alert Type list id displayed with colored options
      | Informational |
      | Caution       |
      | Warning       |
    And Country Checklist Alert Type "Informational" is ticked
    And Country Checklist "Save and Assign" button is displayed
    And Country Checklist "Cancel" button is displayed
    And Country Checklist "Save" button is displayed
    When User populates List Name field with "toBeReplaced"
    And User selects "Caution" alert type
    And User populates alert message with "Auto Alert Message Updated"
    And User clicks Save button for edit assigning Country
    Then Country Checklist page is loaded
    And Country "toBeReplaced" is displayed with values
      | List Name    | Alert Type | Status | Date Created | Last Update |
      | toBeReplaced | Caution    | Active | MM/dd/YYYY   | MM/dd/YYYY  |
    When User clicks edit button for country checklist "toBeReplaced"
    Then "Edit Country Checklist" details page is displayed
    When User populates List Name field with "toBeReplaced"
    And User selects "Caution" alert type
    And User populates alert message with "Auto Alert Message Second Update"
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
    When User clicks Save button for assigning Country
    Then Country Checklist page is loaded
    And Country "toBeReplaced" is displayed with values
      | List Name    | Alert Type | Status | Date Created | Last Update |
      | toBeReplaced | Caution    | Active | MM/dd/YYYY   | MM/dd/YYYY  |
    When User clicks assign button for country checklist "toBeReplaced"
    Then "Assign Country Checklist" details page is displayed
    And Country "Aruba" is moved to "Selected Countries" list
    When User clicks Cancel Assign Country button
    And User clicks edit button for country checklist "toBeReplaced"
    Then "Edit Country Checklist" details page is displayed
    When User populates List Name field with "cancel case"
    And User selects "Caution" alert type
    And User populates alert message with "Auto Alert Message Third Update"
    And User clicks Cancel Assign Country List Name form
    Then Country Checklist page is loaded
    And Country "toBeReplaced" is displayed with values
      | List Name    | Alert Type | Status | Date Created | Last Update |
      | toBeReplaced | Caution    | Active | MM/dd/YYYY   | MM/dd/YYYY  |

  @C36628623
  Scenario: C36628623: [Country Checklist Setup] - Edit List Name - Validation for required fields and duplicating List Name
    When User clicks edit button for country checklist "toBeReplaced"
    Then "Edit Country Checklist" details page is displayed
    When User clears Country Checklist "List Name" field
    And User clears Country Checklist "Alert Message" field
    And User clicks Save button for edit assigning Country
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required fields |
    And Toast message is not displayed
    And Error message 'This field is required' is displayed for Country Checklist "List Name" field
    And Error message 'This field is required' is displayed for Country Checklist "Alert Message" field
    When User populates alert message with "Auto Alert Message"
    And User populates List Name field with "existing"
    And User clicks Save button for edit assigning Country
    Then Alert Icon is displayed with text
      | Cannot save.                     |
      | Country checklist already exists |
    And Error message 'Country checklist already exists' is displayed for Country Checklist "List Name" field
    When User clicks Cancel Assign Country List Name form
    And User clicks edit button for country checklist "toBeReplaced"
    Then "Edit Country Checklist" details page is displayed
    When User clears Country Checklist "List Name" field
    And User clears Country Checklist "Alert Message" field
    And User clicks Save and Assign button
    Then Alert Icon is displayed with text
      | Cannot Save                         |
      | Please complete the required fields |
    And Toast message is not displayed
    And Error message 'This field is required' is displayed for Country Checklist "List Name" field
    And Error message 'This field is required' is displayed for Country Checklist "Alert Message" field
    When User populates alert message with "Auto Alert Message"
    And User populates List Name field with "existing"
    And User clicks Save and Assign button
    Then Alert Icon is displayed with text
      | Cannot save.                     |
      | Country checklist already exists |
    And Error message 'Country checklist already exists' is displayed for Country Checklist "List Name" field