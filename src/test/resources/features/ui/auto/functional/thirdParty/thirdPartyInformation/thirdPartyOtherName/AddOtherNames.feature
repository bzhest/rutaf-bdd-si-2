@ui @functional @wc1 @other_names
Feature: Third-party - Information - Other Name - Add

  As a user,
  I want an ability to screen a supplier using Other Names.
  So that I can see the results from all names.

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"

  @C33592806
  Scenario: C33592806: Supplier - Check that possible to add Other name
    Then Add Name mandatory text field is displayed
    And Add Name Type mandatory drop-down field is displayed with list
      | Local Language Name |
      | Doing Business As   |
      | Former Name         |
      | Subsidiary          |
      | Other Name          |
    And Add "Country of Registration" drop-down field is displayed with list of countries from WC1
    And "Add button" for other name is displayed
    And "Cancel Other Name button" for other name is displayed
    When User fills in Name field value "Test Other Name"
    When User selects Name type "Other Name"
    Then Selected Name type "Other Name" is disabled
    And User clicks on "Other Names Add|Save button"
    And Alert Icon is displayed with text
      | Success!                                  |
      | Other name Test Other Name has been added |
    When User clicks on Screen Other Name Button for "Test Other Name" name
    Then Other Name dialog is loaded
    And User clicks Close Other Name Results button
    When User clicks on Edit Other Name Button for "Test Other Name" name
    And Field "Country of Registration" for other name is empty

  @C33592807
  Scenario: C33592807: Supplier - Check validation for Other Name fields
    Then User clicks on "Other Names Add|Save button"
    And Alert Icon is displayed with text
      | Cannot Save. Please complete the required fields |
    Then Error message "This field is required" in red color is displayed near "Name"
    And Error message "This field is required" in red color is displayed near "Name Type"
    And Optional "Country of Registration" is not highlighted
    And User clicks on "Cancel Other Name button"
    And User fills in Name field value "Test Other Name"
    And User clicks on "Other Names Add|Save button"
    And Alert Icon is displayed with text
      | Cannot Save. Please complete the required fields |
    And Error message "This field is required" in red color is displayed near "Name Type"
    And User clicks on "Cancel Other Name button"
    And User selects Name type "Local Language Name"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required fields |
    And Error message "This field is required" in red color is displayed near "Name"
    And User clicks on "Cancel Other Name button"
    And User creates Other name "with mandatory fields"
    And User fills in Name field value "Test Other Name"
    And User selects Name type "Local Language Name"
    When User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Cannot Save. Test Other Name already exists |
    And User clicks on "Cancel Other Name button"
    When User fills in Name field value "Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other"
    And User selects Name type "Local Language Name"
    And User clicks on "Other Names Add|Save button"
    And User clicks on Screen Other Name Button for "Test Other Name" name
    Then Other Name dialog is loaded
    And User clicks Close Other Name Results button
    Then Other name "Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other Name Test Other" is created
