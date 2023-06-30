@ui @functional @wc1 @other_names
Feature: Third-party - Information - Other Name - Overview

  As a user,
  I want an ability to screen a supplier using Other Names.
  So that I can see the results from all names.

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"


  @C33592809
  Scenario: C33592809: Supplier - Check that existing Other Names displayed in the table
    When User creates Other name "with mandatory fields"
    Then "Other Names Table" for other name is displayed
    And Other Name table is displayed with column names
      | NAME | NAME TYPE | DATE CREATED | LAST UPDATE |
    And Other Name table contains expected values
      | Test Other Name     |
      | Local Language Name |
      | MM/dd/YYYY          |
      | MM/dd/YYYY          |

  @C33592810
  Scenario: C33592810: Supplier - Check that Other Names section is displayed
    Then "Other Names Section" for other name is displayed
    Then "Other Names" section for third-party is displayed between "Description" and "Screening" sections
    And "Other Names Add|Save button" for other name is displayed
