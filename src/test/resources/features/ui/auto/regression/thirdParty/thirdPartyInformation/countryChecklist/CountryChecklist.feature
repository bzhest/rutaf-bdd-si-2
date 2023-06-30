@ui @suppliers
Feature: Third Party's Country Checklist

  As a Compliance group user using the Advance Search feature
  I want to be notified whenever the country of a Third-Party's Address is included in any checklist
  So that I can manage the risks accordingly

  Background:
    Given User logs into RDDC as "Admin"
    And User creates Country Checklist "Informational with assigned Afghanistan, Zimbabwe" via API
    And User creates Country Checklist "Caution with assigned Afghanistan" via API
    And User creates Country Checklist "Warning with assigned Afghanistan" via API

  @C35652367
  @core_regression
  Scenario: C35652367: Supplier/Country Checklist - Address section: Country alert message and icon - Adding Supplier
    When User navigates to Third-party page
    And User clicks Add Third-party button
    And User selects Country that doesn't belong to any Country Checklist
    Then Address Country alert toast message is not displayed
    When User selects "Afghanistan" country in Country drop-down
    Then Address Country alert toast message is displayed with text
      | AUTO_TEST_Alert_Message_Caution |
      | AUTO_TEST_Alert_Message_Info    |
      | AUTO_TEST_Alert_Message_Warning |
    And Address Country alert toast message is disappeared
    When User selects "Zimbabwe" country in Country drop-down
    Then Address Country alert toast message is displayed with text
      | AUTO_TEST_Alert_Message_Info |
    And Address Country alert toast message is disappeared
    When User fills third-party creation form with third-party's test data "with random ID name and Zimbabwe country"
    And User submits Third-party creation form
    #Then 'i' icon button is displayed beside add "Address" section
    Then "Informational" 'i' icon button is displayed beside add "Address" section

  @C35652367
  @core_regression
  Scenario: C35652367: Supplier/Country Checklist - Address section: Country alert message and icon - Edit Third-Party flow
    When User creates third-party "with random ID name" via API and open it
    And User clicks General and Other Information section "Edit" button
    And User selects "Afghanistan" country in Edit Profile Country drop-down
    Then Address Country alert toast message is displayed with text
      | AUTO_TEST_Alert_Message_Caution |
      | AUTO_TEST_Alert_Message_Info    |
      | AUTO_TEST_Alert_Message_Warning |
    And Address Country alert toast message is disappeared

  @C35652367
  @core_regression
  Scenario: C35652367: Supplier/Country Checklist - Address section: Country alert message and icon - View flow
    When User creates third-party "with mandatory fields" via API and open it
    And User logs into RDDC as "Restricted"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then "Informational" 'i' icon button is displayed beside add "Address" section
    And "Caution" 'i' icon button is displayed beside add "Address" section
    And "Warning" 'i' icon button is displayed beside add "Address" section
#    Login as Admin user to finish data clean up
    And User logs into RDDC as "Admin"

  @C35652891
  @full_regression
  Scenario: C35652891: Supplier/Country Checklist - Bank details section: Country alert message and icon are shown on Supplier details page when user has selected a country that belongs to the country checklist during adding/editing/viewing of Supplier
    When User navigates to Third-party page
    And User clicks Add Third-party button
    And User selects Bank Details Country that doesn't belong to any Country Checklist
    Then Address Country alert toast message is not displayed
    When User selects "Afghanistan" country in Bank Details Country drop-down
    Then Address Country alert toast message is displayed with text
      | AUTO_TEST_Alert_Message_Caution |
      | AUTO_TEST_Alert_Message_Info    |
      | AUTO_TEST_Alert_Message_Warning |
    And Address Country alert toast message is disappeared
    And "Informational" 'i' icon button is displayed beside add "Bank Details" section
    And "Caution" 'i' icon button is displayed beside add "Bank Details" section
    And "Warning" 'i' icon button is displayed beside add "Bank Details" section
    When User selects "Zimbabwe" country in Bank Details Country drop-down
    Then Address Country alert toast message is displayed with text
      | AUTO_TEST_Alert_Message_Info |
    And Address Country alert toast message is disappeared
    And "Informational" 'i' icon button is displayed beside add "Bank Details" section
    And "Caution" 'i' icon button is not displayed beside add "Bank Details" section
    And "Warning" 'i' icon button is not displayed beside add "Bank Details" section
    When User fills third-party creation form with third-party's test data "with random ID name, Zimbabwe country and Bank Details"
    And User submits Third-party creation form
    Then "Informational" 'i' icon button is displayed beside add "Bank Details" section
    And "Caution" 'i' icon button is not displayed beside add "Bank Details" section
    And "Warning" 'i' icon button is not displayed beside add "Bank Details" section
    When User clicks General and Other Information section "Edit" button
    And User waits for progress bar to disappear from page
    And User updates Bank Details on position 1 with values
      | Bank Country |
      | Afghanistan  |
    Then Edit Address Country alert toast message is displayed with text
      | AUTO_TEST_Alert_Message_Caution |
      | AUTO_TEST_Alert_Message_Info    |
      | AUTO_TEST_Alert_Message_Warning |
    And "Informational" 'i' icon button is displayed beside add "Bank Details" section
    And "Caution" 'i' icon button is displayed beside add "Bank Details" section
    And "Warning" 'i' icon button is displayed beside add "Bank Details" section
    Then Address Country alert toast message is disappeared
    When User clicks General and Other Information section "Save" button
    And User waits for progress bar to disappear from page
    And User logs into RDDC as "Restricted"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User waits for progress bar to disappear from page
    Then "Informational" 'i' icon button is displayed beside add "Bank Details" section
    And "Caution" 'i' icon button is displayed beside add "Bank Details" section
    And "Warning" 'i' icon button is displayed beside add "Bank Details" section
#    Login as Admin user to finish data clean up
    And User logs into RDDC as "Admin"
