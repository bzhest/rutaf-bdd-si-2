@ui @contacts @arabica

Feature: Add Associated Individual - Contact section - Phone Number

  As a RDDC user.
  I want to be able to add + ( ) symbols in the phone number field
  So that I can ensure the international numbers are accounted for (country and region codes)

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    When User creates third-party "with random ID name" via API and open it

  @C54379219
  @full_regression
  Scenario: C54379219: Add Associated Individual - Contact section - Verify system should support the + ( ) symbols in the phone number field for the international numbers
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    And User enters Associated Party first name with value "Test_First_Name"
    And User enters Associated Party last name with value "Test_Last_Name"
    And User can expand "Contact" section
    And User updates Associated Party's Contact section "Phone Number" on position 1 with values "1234 6798"
    And User clicks Add "Phone Number" button
    Then Error message "Please enter valid phone number" in red color is displayed on field
      | Phone Number |
    When User updates Associated Party's Contact section "Phone Number" on position 1 with values "(+66)123456789"
    And User clicks Add "Phone Number" button
    And User updates Associated Party's Contact section "Phone Number" on position 2 with values "+66123456789"
    And User clicks Add "Phone Number" button
    And User updates Associated Party's Contact section "Phone Number" on position 3 with values "+(66)123456789"
    And User clicks Add "Phone Number" button
    And User updates Associated Party's Contact section "Phone Number" on position 4 with values "02123456789"
    And User clicks Add "Phone Number" button
    And User updates Associated Party's Contact section "Phone Number" on position 5 with values "123456789"
    And User clicks on Save Associated Party button
    Then All Phone Number of Contact section fields are displayed
      | (+66)123456789 |
      | +66123456789   |
      | +(66)123456789 |
      | 02123456789    |
      | 123456789      |

  @C54379220
  @full_regression
  Scenario: C54379220: Edit Associated Individual - Contact section - Verify system should support the + ( ) symbols in the phone number field for the international numbers
    When User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    And User creates Associated Party "with mandatory fields auto screen off"
    And User clicks Associated Party's Contact section "Edit" button
    And User updates Associated Party's Contact section "Phone Number" on position 1 with values "1234567894536485"
    And User clicks Add "Phone Number" edit contact button
    Then Error message "Please enter valid phone number" in red color is displayed on field
      | Phone Number |
    When User updates Associated Party's Contact section "Phone Number" on position 1 with values "(+66)123456789"
    And User clicks Add "Phone Number" edit contact button
    And User updates Associated Party's Contact section "Phone Number" on position 2 with values "+66123456789"
    And User clicks Add "Phone Number" edit contact button
    And User updates Associated Party's Contact section "Phone Number" on position 3 with values "+(66)123456789"
    And User clicks Add "Phone Number" edit contact button
    And User updates Associated Party's Contact section "Phone Number" on position 4 with values "02123456789"
    And User clicks Add "Phone Number" edit contact button
    And User updates Associated Party's Contact section "Phone Number" on position 5 with values "123456789"
    And User clicks Associated Party's Contact section "Save" button
    Then All Phone Number of Contact section fields are displayed
      | (+66)123456789 |
      | +66123456789   |
      | +(66)123456789 |
      | 02123456789    |
      | 123456789      |