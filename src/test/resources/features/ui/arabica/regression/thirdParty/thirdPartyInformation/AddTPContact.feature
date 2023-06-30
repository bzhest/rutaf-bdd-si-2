@ui @contacts @arabica

Feature: Add TP - Contact section - Phone Number

  As a RDDC user.
  I want to be able to add + ( ) symbols in the phone number field
  So that I can ensure the international numbers are accounted for (country and region codes)

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API

  @C54379173
  @full_regression
  Scenario: C54379173: Add TP - Contact section - Verify  system should support the + ( ) symbols in the phone number field for  the international numbers
    When User opens third-party creation form
    And User fills third-party creation form with third-party's test data "with defined name"
    And User fills Phone number "1234567894536485" Value Row "1" of Contact section
    And User clicks Add Phone Number
    Then Error message "Please enter valid phone number" in red color is displayed on field
      | Phone Number |
    When User fills Phone number "1234 6798" Value Row "1" of Contact section
    And User clicks Add Phone Number
    Then Error message "Please enter valid phone number" in red color is displayed on field
      | Phone Number |
    When User fills Phone number "(+66)123456789" Value Row "1" of Contact section
    And User clicks Add Phone Number
    And User fills Phone number "+66123456789" Value Row "2" of Contact section
    And User clicks Add Phone Number
    And User fills Phone number "+(66)123456789" Value Row "3" of Contact section
    And User clicks Add Phone Number
    And User fills Phone number "02123456789" Value Row "4" of Contact section
    And User clicks Add Phone Number
    And User fills Phone number "123456789" Value Row "5" of Contact section
    And User submits Third-party creation form
    Then Screening results table is loaded
    And All Contact section view fields are displayed
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |
    And All Phone Number of Contact section view fields are displayed
      | (+66)123456789 |
      | +66123456789   |
      | +(66)123456789 |
      | 02123456789    |
      | 123456789      |

  @C54379182
  @full_regression
  Scenario: C54379182: Edit TP - Contact section - Verify  system should support the + ( ) symbols in the phone number field for  the international numbers
    When User creates third-party "with random ID name" via API and open it
    Then All Contact section view fields are displayed
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |
    When User clicks General and Other Information section "Edit" button
    And User fills Phone number "1234567894536485" Value Row "1" of Contact section
    And User clicks Add Phone Number
    Then Error message "Please enter valid phone number" in red color is displayed on field
      | Phone Number |
    When User fills Phone number "(+66)123456789" Value Row "1" of Contact section
    And User clicks Add Phone Number
    And User fills Phone number "+66123456789" Value Row "2" of Contact section
    And User clicks Add Phone Number
    And User fills Phone number "+(66)123456789" Value Row "3" of Contact section
    And User clicks Add Phone Number
    And User fills Phone number "02123456789" Value Row "4" of Contact section
    And User clicks Add Phone Number
    And User fills Phone number "123456789" Value Row "5" of Contact section
    And User clicks General and Other Information section "Save" button
    Then All Phone Number of Contact section view fields are displayed
      | (+66)123456789 |
      | +66123456789   |
      | +(66)123456789 |
      | 02123456789    |
      | 123456789      |