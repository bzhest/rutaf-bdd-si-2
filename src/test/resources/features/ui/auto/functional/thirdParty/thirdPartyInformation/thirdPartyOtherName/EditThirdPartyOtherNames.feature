@ui @functional @wc1 @other_names
Feature: Third-party - Information - Other Name - Edit

  As a user,
  I want to an ability to edit the other name.
  So that I can edit it and rerun the search.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"

  @C33592812
  Scenario: C33592812: Supplier - Check that possible to edit Other name
    Given User creates Other name "with mandatory fields"
    Then Edit Other Name button is displayed in the Other Names section after each record
    #  1) Change name and type, click Save
    When User clicks on Edit Other Name Button for "Test Other Name" name
    And User fills in Name field value "Apple"
    And User selects Name type "Former Name"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Success!                          |
      | Other name Apple has been updated |
    When User opens screening results for "Apple" Other name
    Then Sorted search "World-Check" results for "Apple" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    #  2) Change only name, click Save
    And User clicks on Edit Other Name Button for "Apple" name
    And User fills in Name field value "Dell"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Success!                         |
      | Other name Dell has been updated |
    When User opens screening results for "Dell" Other name
    Then Sorted search "World-Check" results for "Dell" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    #  3) Change only type, click Save
    And User clicks on Edit Other Name Button for "Dell" name
    And User selects Name type "Local Language Name"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Success!                         |
      | Other name Dell has been updated |
    When User opens screening results for "Dell" Other name
    Then Sorted search "World-Check" results for "Dell" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    #  4) Change only country to new, click Save
    And User clicks on Edit Other Name Button for "Dell" name
    And User edits "Country of Registration" field with value "South Africa"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Success!                         |
      | Other name Dell has been updated |
    When User opens screening results for "Dell" Other name
    Then Sorted search "World-Check" results for "Dell" "supplier" appear in other names screening table for current page
    When User clicks Close Other Name Results button
    #  5) Change only country to empty, click Save
    And User clicks on Edit Other Name Button for "Dell" name
    And User clicks clear "Country of Registration" Other Name field
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Success!                         |
      | Other name Dell has been updated |
    When User opens screening results for "Dell" Other name
    Then Sorted search "World-Check" results for "Dell" "supplier" appear in other names screening table for current page

  @C33592813
  Scenario: C33592813: Supplier - Check validation for Edit Other Name fields
    Given User creates Other name "with mandatory fields for editing"
    When User clicks on Edit Other Name Button for "Test Other Name For Editing" name
    And User clears "Name"
    And User clears "Name Type"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required fields |
    And Error message "This field is required" in red color is displayed near "Name"
    And Error message "This field is required" in red color is displayed near "Name Type"
    And Optional "Country of Registration" is not highlighted
    When User clicks on "Cancel Other Name button"
    And User clicks on Edit Other Name Button for "Test Other Name For Editing" name
    And User clears "Name Type"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required fields |
    And Error message "This field is required" in red color is displayed near "Name Type"
    When User clicks on "Cancel Other Name button"
    And User clicks on Edit Other Name Button for "Test Other Name For Editing" name
    And User clears "Name"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required fields |
    And Error message "This field is required" in red color is displayed near "Name"
    And User clicks on "Cancel Other Name button"
    When User creates Other name "with mandatory fields"
    And User clicks on Edit Other Name Button for "Test Other Name For Editing" name
    And User fills in Name field value "Test Other Name"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Test Other Name already exists |
    When User creates random 251 characters other name
    And User fills in Name field value "randomGeneratedString"
    And User clicks on "Other Names Add|Save button"
    Then Other name "randomGeneratedString" is created