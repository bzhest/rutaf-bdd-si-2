@ui @full_regression @react @wc1 @other_names
Feature: Contact Other Names - Add Other Name

  As a user,
  I want an ability to add a supplier contact using other names.
  So that I can see the results from all names.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"
    And User creates Associated Party "with mandatory fields"

  @C34144032
  @core_regression
  Scenario: C34144032: SI-WC1-Contact-Check that possible to add Other name-send Countries
    Then Add Name mandatory text field is displayed
    And Add Name Type mandatory drop-down field is displayed with list
      | Also Known As     |
      | Locally Known As  |
      | Formerly Known As |
    And Add "Country of Location" drop-down field is displayed with list of countries from WC1
    And Field "Country of Location" for other name is empty
    And Add "Citizenship" drop-down field is displayed with list of countries from WC1
    And Field "Citizenship" for other name is empty
    And Add "Place of Birth" drop-down field is displayed with list of countries from WC1
    And Field "Place of Birth" for other name is empty
    And Other Name Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    When User fills in Name field value "Muhammed"
    And User selects Name type "Formerly Known As"
    And User edits "Country of Location" field with value "Turkey"
    And User edits "Citizenship" field with value "Canada"
    And User edits "Place of Birth" field with value "Pakistan"
    And User clicks on "Add button"
    Then Other Name dialog is loaded
    And WC1 case contains "Pakistan" provided "POB" for "contact" "Muhammed" other name secondary field
    And WC1 case contains "Canada" provided "NATIONALITY" for "contact" "Muhammed" other name secondary field
    And WC1 case contains "Turkey" provided "LOCATION" for "contact" "Muhammed" other name secondary field
    And Sorted search "World-Check" results for "Muhammed" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Muhammed" name
    Then Other Name field "Country of Location" contains value "Turkey"
    And Other Name field "Citizenship" contains value "Canada"
    And Other Name field "Place of Birth" contains value "Pakistan"
    When User clicks on "Cancel Other Name button"
    And User fills in Name field value "Pedro"
    And User selects Name type "Formerly Known As"
    And User edits "Place of Birth" field with value "Mexico"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    And WC1 case contains "Mexico" provided "POB" for "contact" "Pedro" other name secondary field
    And WC1 case contains "" provided "NATIONALITY" for "contact" "Pedro" other name secondary field
    And WC1 case contains "" provided "LOCATION" for "contact" "Pedro" other name secondary field
    And Sorted search "World-Check" results for "Pedro" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Pedro" name
    Then Field "Country of Location" for other name is empty
    And Field "Citizenship" for other name is empty
    And Other Name field "Place of Birth" contains value "Mexico"
    When User clicks on "Cancel Other Name button"
    And User fills in Name field value "Marco"
    And User selects Name type "Formerly Known As"
    And User edits "Citizenship" field with value "Italy"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    And WC1 case contains "" provided "POB" for "contact" "Marco" other name secondary field
    And WC1 case contains "Italy" provided "NATIONALITY" for "contact" "Marco" other name secondary field
    And WC1 case contains "" provided "LOCATION" for "contact" "Marco" other name secondary field
    And Sorted search "World-Check" results for "Marco" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Marco" name
    Then Field "Country of Location" for other name is empty
    And Field "Place of Birth" for other name is empty
    And Other Name field "Citizenship" contains value "Italy"
    When User clicks on "Cancel Other Name button"
    And User fills in Name field value "Olivia"
    And User selects Name type "Formerly Known As"
    And User edits "Country of Location" field with value "United Kingdom"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    And WC1 case contains "" provided "POB" for "contact" "Olivia" other name secondary field
    And WC1 case contains "" provided "NATIONALITY" for "contact" "Olivia" other name secondary field
    And WC1 case contains "United Kingdom" provided "LOCATION" for "contact" "Olivia" other name secondary field
    And Sorted search "World-Check" results for "Olivia" "contact" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    And User clicks on Edit Other Name Button for "Olivia" name
    Then Field "Citizenship" for other name is empty
    And Field "Place of Birth" for other name is empty
    And Other Name field "Country of Location" contains value "United Kingdom"

  @C33364432
  Scenario: C33364432: SI-WC1-Contact-Check that Other names section is displayed
    Then "Other Names Section" for other name is displayed
    And "Other Names" for contact is displayed between "Contact" and "Screening" sections
    And Section "Other Names" is expanded
    And "Other Names Add|Save button" for other name is displayed
    And "Other Names Table" for other name is disappeared
    When User creates Other name "contact other name" for Associated Party
    Then "Other Names Table" for other name is displayed

  @C33363241
  @core_regression
  Scenario: C33363241: SI-WC1-Contact-Check that possible to add Other name
    Then Add Name mandatory text field is displayed
    And Add Name Type mandatory drop-down field is displayed with list
      | Also Known As     |
      | Locally Known As  |
      | Formerly Known As |
    And Add "Country of Location" drop-down field is displayed with list of countries from WC1
    And Add "Citizenship" drop-down field is displayed with list of countries from WC1
    And Add "Place of Birth" drop-down field is displayed with list of countries from WC1
    And "Add button" for other name is displayed
    And "Cancel Other Name button" for other name is displayed
    And Other Name Check Type checkbox fields are displayed with options
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    And Other Name Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    And Other Name Check Type "World-Check" is disabled
    When User fills in Name field value "Zhāng Chūnqiáo 1"
    And User selects Name type "Also Known As"
    Then Selected Name type "Also Known As" is disabled
    When User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded

  @C33363596
  Scenario: C33363596: SI-WC1-Contact-Validations-Add Other name
    When User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required fields. |
    And Error message "This field is required" in red color is displayed near "Name"
    And Error message "This field is required" in red color is displayed near "Name Type"
    And Optional "Country of Location" is not highlighted
    And Optional "Citizenship" is not highlighted
    And Optional "Place of Birth" is not highlighted
    When User clicks on "Cancel Other Name button"
    And User fills in Name field value "Test Other Name"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required fields. |
    And Error message "This field is required" in red color is displayed near "Name Type"
    When User clicks on "Cancel Other Name button"
    And User selects Name type "Formerly Known As"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required fields. |
    And Error message "This field is required" in red color is displayed near "Name"
    When User clicks on "Cancel Other Name button"
    Then Field "Name" for other name is empty
    And Field "Name Type" for other name is empty
    When User creates Other name "contact other name" for Associated Party
    And User clicks Close Other Name Results button
    And User fills in Name field value "Test Other Name"
    And User selects Name type "Formerly Known As"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Test Other Name already exist |
    When User clicks on "Cancel Other Name button"
    And User fills in Name field value "SDaXblpR0CXddpOL3N6yFsTvDSSK59RNFXJxsNfHTFUGs8sDHcevZrjgAdM94ccfdgciLxUWASuMjhhne4rrhuHebUy08ngDVdqZCTy8ie90DLOx0r0NkHxxdMihL81RhazWBa2KxWrxVmSLsbo60MONMqcEbiXbbJO67Tced6eSNBZ3puAodzQoR3k05B8uKBbu9yZjm58toqhdtMRNTmCfUxdoZwBU4IFu7bXaVv2LttbJ9nqOEqTvMWr"
    And User selects Name type "Formerly Known As"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    And User clicks Close Other Name Results button
    Then Other name "SDaXblpR0CXddpOL3N6yFsTvDSSK59RNFXJxsNfHTFUGs8sDHcevZrjgAdM94ccfdgciLxUWASuMjhhne4rrhuHebUy08ngDVdqZCTy8ie90DLOx0r0NkHxxdMihL81RhazWBa2KxWrxVmSLsbo60MONMqcEbiXbbJO67Tced6eSNBZ3puAodzQoR3k05B8uKBbu9yZjm58toqhdtMRNTmCfUxdoZwBU4IFu7bXaVv2LttbJ9nqOEqTvMW" is created

  @C33570880
  Scenario: C33570880: SI-WC1-Contact-Check that existing Other names displayed in the table
    When User creates Other name "contact other name" for Associated Party
    And User clicks Close Other Name Results button
    And User creates Other name "John" for Associated Party
    And User clicks Close Other Name Results button
    And User creates Other name "Barac Obama" for Associated Party
    And User clicks Close Other Name Results button
    Then "Other Names Table" for other name is displayed
    And Other Name table is displayed with column names
      | NAME | NAME TYPE | DATE CREATED | LAST UPDATE |
    And Delete Other Name button is displayed in the Other Names section after each record
    And Edit Other Name button is displayed in the Other Names section after each record
    And Screening Other Name button is displayed in the Other Names section after each record
    And Other Name table is sorted by Date Created in ascending order