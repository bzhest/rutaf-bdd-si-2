@ui @full_regression @react @wc1 @other_names
Feature: Contact Other Names - Edit Other Name

  As a user,
  I want to an ability to edit the other name.
  So that I can edit it and rerun the search.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"
    And User creates Associated Party "with mandatory fields"

  @C33594072
  @core_regression
  Scenario: C33594072: SI-WC1-Contact-Check that possible to edit Other name
    When User creates Other name "contact other name" for Associated Party
    And User clicks Close Other Name Results button
    Then Edit Other Name button is displayed in the Other Names section after each record
    When User clicks on Edit Other Name Button for "Test Other Name" name
    Then Edit Name Type mandatory drop-down field is displayed with list
      | Also Known As     |
      | Locally Known As  |
      | Formerly Known As |
    And Edit "Country of Location" drop-down field is displayed with list of countries from WC1
    And Edit "Citizenship" drop-down field is displayed with list of countries from WC1
    And Edit "Place of Birth" drop-down field is displayed with list of countries from WC1
    When User fills in Name field value "Trump"
    And User selects Name type "Formerly Known As"
    And User clicks on "Other Names Add|Save button"
    Then Sorted search "World-Check" results for "Trump" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Trump" name
    And User fills in Name field value "Biden"
    And User clicks on "Other Names Add|Save button"
    Then Sorted search "World-Check" results for "Biden" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Biden" name
    And User selects Name type "Also Known As"
    And User clicks on "Other Names Add|Save button"
    Then Sorted search "World-Check" results for "Biden" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Biden" name
    And User edits "Country of Location" field with value "South Africa"
    And User clicks on "Other Names Add|Save button"
    Then Sorted search "World-Check" results for "Biden" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Biden" name
    And User clicks clear "Country of Location" Other Name field
    And User clicks on "Other Names Add|Save button"
    Then Sorted search "World-Check" results for "Biden" "contact" appear in other names screening table for current page

  @C33615044
  Scenario: C33615044: SI-WC1-Contact-Validations-Edit Other name
    When User creates Other name "contact other name for editing" for Associated Party
    And User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Test Other Name For Editing" name
    Then Edit Name Type mandatory drop-down field is displayed with list
      | Also Known As     |
      | Locally Known As  |
      | Formerly Known As |
    And Edit "Country of Location" drop-down field is displayed with list of countries from WC1
    And Edit "Citizenship" drop-down field is displayed with list of countries from WC1
    And Edit "Place of Birth" drop-down field is displayed with list of countries from WC1
    And "Add button" for other name is displayed
    And "Cancel Other Name button" for other name is displayed
    When User clears "Name"
    And User clears "Name Type"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required fields. |
    And Error message "This field is required" in red color is displayed near "Name"
    And Error message "This field is required" in red color is displayed near "Name Type"
    And Optional "Country of Location" is not highlighted
    And Optional "Citizenship" is not highlighted
    And Optional "Place of Birth" is not highlighted
    When User clicks on "Cancel Other Name button"
    And User clicks on Edit Other Name Button for "Test Other Name For Editing" name
    And User clears "Name Type"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required fields. |
    And Error message "This field is required" in red color is displayed near "Name Type"
    When User clicks on "Cancel Other Name button"
    And User clicks on Edit Other Name Button for "Test Other Name For Editing" name
    And User clears "Name"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required fields. |
    And Error message "This field is required" in red color is displayed near "Name"
    When User clicks on "Cancel Other Name button"
    And User creates Other name "contact other name" for Associated Party
    And User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Test Other Name For Editing" name
    And User fills in Name field value "Test Other Name"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Test Other Name already exist |
    When User fills in Name field value "SDaXblpR0CXddpOL3N6yFsTvDSSK59RNFXJxsNfHTFUGs8sDHcevZrjgAdM94ccfdgciLxUWASuMjhhne4rrhuHebUy08ngDVdqZCTy8ie90DLOx0r0NkHxxdMihL81RhazWBa2KxWrxVmSLsbo60MONMqcEbiXbbJO67Tced6eSNBZ3puAodzQoR3k05B8uKBbu9yZjm58toqhdtMRNTmCfUxdoZwBU4IFu7bXaVv2LttbJ9nqOEqTvMWr"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    Then Other name "SDaXblpR0CXddpOL3N6yFsTvDSSK59RNFXJxsNfHTFUGs8sDHcevZrjgAdM94ccfdgciLxUWASuMjhhne4rrhuHebUy08ngDVdqZCTy8ie90DLOx0r0NkHxxdMihL81RhazWBa2KxWrxVmSLsbo60MONMqcEbiXbbJO67Tced6eSNBZ3puAodzQoR3k05B8uKBbu9yZjm58toqhdtMRNTmCfUxdoZwBU4IFu7bXaVv2LttbJ9nqOEqTvMW" is created
