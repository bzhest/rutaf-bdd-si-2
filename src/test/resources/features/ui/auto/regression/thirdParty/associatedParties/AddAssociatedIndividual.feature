@ui @suppliers
Feature: Third-party Contact - Add Contact

  As a Supplier Integrity User creating Supplier Contact Records
  I want I want to have a quick and efficient way of creating multiple Supplier Contact records
  So that I can save time from reopening the Add Contact page every time I create a new Supplier Contact


  @C35709471
  @core_regression
  Scenario: C35709471: Third-party Associated individual - Add single Associated individual.
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    And User checks 'Enabled as User' checkbox on Add contact screen
    And User clicks on Save Associated Party button
    Then Error message "This field is required" in red color is displayed near "First Name" contact field
    And Error message "This field is required" in red color is displayed near "Last Name" contact field
    And Error message "This field is required" in red color is displayed near "Email Address" contact field
    When User clicks Close Add Associated Party button
    And User creates Associated Party "with mandatory fields"
    Then Current URL contains "/thirdparty/" endpoint
    And Associated Parties details are displayed with populated data
    When User clicks Associated Party Overview contact button
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name      | Last Name      | Country | Status   |
      | false         |       | Test_First_Name | Test_Last_Name |         | Inactive |

  @C37108896
  @core_regression
  Scenario: C37108896: Third-party Associated individual - Add multiple Associated individuals
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    And User enters Associated Party first name with value "Test_First_Name_1"
    And User enters Associated Party last name with value "Test_Last_Name_1"
    And User enters Associated Party email with value "test1@test.com"
    And User clicks on Save and New Associated Party button
    And User enters Associated Party first name with value "Test_First_Name_2"
    And User enters Associated Party last name with value "Test_Last_Name_2"
    And User enters Associated Party email with value "test2@test.com"
    And User clicks on Save and New Associated Party button
    And User waits for progress bar to disappear from page
    Then Contact Information details are displayed with empty data
    When User clicks Close Add Associated Party button
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name        | Last Name        | Country | Status   |
      | false         |       | Test_First_Name_1 | Test_Last_Name_1 |         | Inactive |
      | false         |       | Test_First_Name_2 | Test_Last_Name_2 |         | Inactive |

  @C35761326
  @full_regression
  @WSO2email
  Scenario: C35761326: Third-party/Third-party Associated individual- Create Associated individual with already existing user name
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    And User creates valid email
    And User enters Associated Party first name with value "toBeReplaced"
    And User enters Associated Party last name with value "toBeReplaced"
    And User enters Associated Party email with value "email"
    And User clicks on Save Associated Party button
    Then Associated Party page is loaded
    When User checks 'Enabled as User' checkbox on contact screen
    Then Contact status control is set to "Enable" position
    When User clicks Associated Party Overview contact button
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name          | Last Name          | Country | Status |
      | false         |       | userEditedFirstName | userEditedLastName |         | Active |
    When User clicks on ADD ASSOCIATED PARTY button
    And User enters Associated Party first name with value "Test_First_Name"
    And User enters Associated Party last name with value "Test_Last_Name"
    And User enters Associated Party email with value "test@test.com"
    And User clicks on Save Associated Party button
    Then Contact status control is set to "Disabled" position
    When User clicks Associated Party Overview contact button
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name          | Last Name          | Country | Status   |
      | false         |       | userEditedFirstName | userEditedLastName |         | Active   |
      | false         |       | Test_First_Name     | Test_Last_Name     |         | Inactive |
    And Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    And User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    And User navigates to Third-party page
    And User creates third-party "with mandatory fields"
    And User navigates 'Set Up' block 'User' section
    And User searches user by "userEditedFirstName" keyword
    And User clicks edit user button by name
    Then Edit User page is displayed
    When User selects "with mandatory fields" user Third-party
    And User clicks 'Submit' button on User Page
    When User navigates to Third-party page
    And User clicks third-party with reference "with mandatory fields"
    And User clicks on "Associated Parties" tab on Third-party page
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name          | Last Name          | Country | Status |
      | false         |       | userEditedFirstName | userEditedLastName |         | Active |

  @C37108897
  @full_regression
  @RMS-32159
  Scenario: C37108897: Third-party/Third-party Associated individual - Country check during Associated individual creation/editing/viewing
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User creates Country Checklist "Informational with assigned Afghanistan, Zimbabwe" via API
    And User creates Country Checklist "Caution with assigned Afghanistan" via API
    And User creates Country Checklist "Warning with assigned Afghanistan" via API
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    When User enters Associated party Address section on position 1 with values
      | Country      |
      | toBeReplaced |
    Then Address Country alert toast message is not displayed
    When User enters Associated party Address section on position 1 with values
      | Country     |
      | Afghanistan |
    Then Address Country alert toast message is displayed with text
      | AUTO_TEST_Alert_Message_Caution |
      | AUTO_TEST_Alert_Message_Info    |
      | AUTO_TEST_Alert_Message_Warning |
    When User enters Associated party Address section on position 1 with values
      | Country  |
      | Zimbabwe |
    Then Address Country alert toast message is displayed with text
      | AUTO_TEST_Alert_Message_Info |
    And User enters Associated Party first name with value "Peter"
    And User enters Associated Party last name with value "Parker"
    And User enters Associated Party email with value "spider@mail.com"
    And User clicks on Save Associated Party button
    Then Associated Party page is loaded
#    TODO uncomment when RMS-32159 will be fixed
#    And "Informational" 'i' icon button is displayed beside add "Address" section
    When User clicks Associated Party's Address section "Edit" button
    And User updates Associated Party's Address section on position 1 with values
      | Country     |
      | Afghanistan |
    Then Edit Address Country alert toast message is displayed with text
      | AUTO_TEST_Alert_Message_Caution |
      | AUTO_TEST_Alert_Message_Info    |
      | AUTO_TEST_Alert_Message_Warning |
    When User clicks Associated Party's Address section "Save" button
    Then "Informational" 'i' icon button is displayed beside add "Address" section
    And "Caution" 'i' icon button is displayed beside add "Address" section
    And "Warning" 'i' icon button is displayed beside add "Address" section
    #    TODO uncomment when RMS-32159 will be fixed
#    When User clicks Log Out button
#    And User logs into RDDC as "Admin"
#    Then User navigates to Third-party page
#    And User searches created third-party
#    And User clicks on created third-party
#    And User clicks on "Associated Parties" tab on Third-party page
#    And User clicks on Associated Party with name "Peter"
#    Then "Informational" 'i' icon button is displayed beside add "Address" section
#    And "Caution" 'i' icon button is displayed beside add "Address" section
#    And "Warning" 'i' icon button is displayed beside add "Address" section

  @C37108898
  @full_regression
  Scenario: C37108898(1): Third-party Associated individual - Add / Edit: allow adding and deleting of multiple Associated individual Addresses - Add Associated Party
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    Then User can expand "Address" section
    And Add Associated Party modal Add address button is disabled
    When User enters Associated party Address section on position 1 with values
      | Country |
      | Ukraine |
    Then Add Associated Party modal Add address button is enabled
    When User clicks Add Associated Party modal Add address button
    And User enters Associated party Address section on position 2 with values
      | Address Line   | City   | Zip/Postal Code   | Country |
      | Address Line 2 | City 2 | Zip/Postal Code 2 | Austria |
    And User clicks Add Associated Party modal Add address button
    And User enters Associated party Address section on position 3 with values
      | Address Line   | City   | Zip/Postal Code   | State/Province   | Region       | Country |
      | Address Line 3 | City 3 | Zip/Postal Code 3 | State/Province 3 | toBeReplaced |         |
    And User clicks Add Associated Party modal Add address button
    And User enters Associated party Address section on position 4 with values
      | Address Line   | City   | Zip/Postal Code   | State/Province   | Country |
      | Address Line 4 | City 4 | Zip/Postal Code 4 | State/Province 4 | Norway  |
    And User clicks Add Associated Party modal Add address button
    And User enters Associated party Address section on position 5 with values
      | Address Line   | City   | Zip/Postal Code   | State/Province   | Country |
      | Address Line 5 | City 5 | Zip/Postal Code 5 | State/Province 5 | China   |
    Then Add Associated Party modal Add address button is hidden
    When User click Remove Address section on position 5
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Address? |
      | This change cannot be undone.                 |
    When User clicks Delete button on confirmation window
    Then Contact Address section does not contain address
      | Address Line   | City   | Zip/Postal Code   | State/Province   | Country |
      | Address Line 5 | City 5 | Zip/Postal Code 5 | State/Province 5 | China   |
    And User enters Associated Party first name with value "Tony"
    And User enters Associated Party last name with value "Stark"
    And User enters Associated Party email with value "ceo@starkink.com"
    And User clicks on Save Associated Party button
    Then Associated Party page is loaded
    And Associated Party's Address section details are displayed with data
      | Address Line   | City   | Zip/Postal Code   | State/Province   | Region       | Country      |
      |                |        |                   |                  |              | Ukraine      |
      | Address Line 2 | City 2 | Zip/Postal Code 2 |                  |              | Austria      |
      | Address Line 3 | City 3 | Zip/Postal Code 3 | State/Province 3 | toBeReplaced | toBeReplaced |
      | Address Line 4 | City 4 | Zip/Postal Code 4 | State/Province 4 |              | Norway       |

  @C37108898
  @full_regression
  Scenario: C37108898(2): Third-party Associated individual - Add / Edit: allow adding and deleting of multiple Associated individual Addresses - Add Associated Party
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "with mandatory fields"
    And User clicks Associated Party's Address section "Edit" button
    Then Add Associated Party modal Add address button is disabled
    When User updates Associated Party's Address section on position 1 with values
      | Country |
      | Ukraine |
    Then Add Associated Party modal Add address button is enabled
    When User clicks Add Associated Party modal Add address button
    And User updates Associated Party's Address section on position 2 with values
      | Address Line   | City   | Zip/Postal Code   | State/Province   | Region       | Country |
      | Address Line 2 | City 2 | Zip/Postal Code 2 | State/Province 2 | toBeReplaced |         |
    And User clicks Add Associated Party modal Add address button
    And User updates Associated Party's Address section on position 3 with values
      | Address Line   | City   | Zip/Postal Code   | State/Province   | Country |
      | Address Line 3 | City 3 | Zip/Postal Code 3 | State/Province 3 | Austria |
    And User clicks Add Associated Party modal Add address button
    And User updates Associated Party's Address section on position 4 with values
      | Address Line   | City   | Zip/Postal Code   | State/Province   | Country |
      | Address Line 4 | City 4 | Zip/Postal Code 4 | State/Province 4 | China   |
    And User clicks Add Associated Party modal Add address button
    And User updates Associated Party's Address section on position 5 with values
      | Address Line   | City   | Zip/Postal Code   | State/Province   | Country |
      | Address Line 5 | City 5 | Zip/Postal Code 5 | State/Province 5 | India   |
    Then Add Associated Party modal Add address button is hidden
    When User clicks Remove edit Address section on position 5
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Address? |
      | This change cannot be undone.                 |
    When User clicks Delete button on confirmation window
    And User clicks Associated Party's Address section "Save" button
    Then Associated Party's Address section details are displayed with data
      | Address Line   | City   | Zip/Postal Code   | State/Province   | Region       | Country      |
      |                |        |                   |                  |              | Ukraine      |
      | Address Line 2 | City 2 | Zip/Postal Code 2 | State/Province 2 | toBeReplaced | toBeReplaced |
      | Address Line 3 | City 3 | Zip/Postal Code 3 | State/Province 3 |              | Austria      |
      | Address Line 4 | City 4 | Zip/Postal Code 4 | State/Province 4 |              | China        |

  @C37108899
  @full_regression
  Scenario: C37108899: Third-party Associated individual - Add / Edit: allow adding and deleting of multiple Associated individual in Contact section - Crete Associated Party
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User creates valid email
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    And User can expand "Contact" section
    Then Add "Phone Number" contact button is disabled
    And Add "Fax" contact button is disabled
    And Add "Website" contact button is disabled
    When User updates Associated Party's Contact section "Phone Number" on position 1 with values "1"
    Then Add "Phone Number" contact button is enabled
    When User clicks Add "Phone Number" button
    And User updates Associated Party's Contact section "Phone Number" on position 2 with values "2"
    And User clicks Add "Phone Number" button
    And User updates Associated Party's Contact section "Phone Number" on position 3 with values "3"
    And User updates Associated Party's Contact section "Fax" on position 1 with values "1"
    Then Add "Fax" contact button is enabled
    When User clicks Add "Fax" button
    And User updates Associated Party's Contact section "Fax" on position 2 with values "2"
    And User clicks Add "Fax" button
    And User updates Associated Party's Contact section "Fax" on position 3 with values "3"
    And User updates Associated Party's Contact section "Website" on position 1 with values "https://www.test1.com"
    Then Add "Website" contact button is enabled
    When User clicks Add "Website" button
    And User updates Associated Party's Contact section "Website" on position 2 with values "https://www.test2.com"
    And User clicks Add "Website" button
    And User updates Associated Party's Contact section "Website" on position 3 with values "https://www.test3.com"
    And User clicks remove "Phone Number" on position 2
    Then Alert Icon is displayed with text
      | Success!                       |
      | Phone Number has been deleted. |
    And "Phone Number" field on position 2 is not displayed with value "2"
    When User clicks remove "Fax" on position 2
    Then Alert Icon is displayed with text
      | Success!              |
      | Fax has been deleted. |
    And "Fax" field on position 2 is not displayed with value "2"
    When User clicks remove "Website" on position 2
    Then Alert Icon is displayed with text
      | Success!                  |
      | Website has been deleted. |
    And "Website" field on position 2 is not displayed with value "https://www.test2.com"
    When User enters Associated Party first name with value "Robert"
    And User enters Associated Party last name with value "Banner"
    And User enters Associated Party email with value "email"
    And User clicks on Save Associated Party button
    Then Associated Party's Contact section details are displayed with data
      | Phone Number | Fax | Website               | Email Address |
      | 1            | 1   | https://www.test1.com | email         |
      | 3            | 3   | https://www.test3.com |               |

  @C37108899
  @full_regression
  Scenario: C37108899: Third-party Associated individual - Add / Edit: allow adding and deleting of multiple Associated individual in Contact section - Edit Associated Party
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "with mandatory fields"
    And User clicks Associated Party's Contact section "Edit" button
    Then Add "Phone Number" edit contact button is disabled
    And Add "Fax" edit contact button is disabled
    And Add "Website" edit contact button is disabled
    When User updates Associated Party's Contact section "Phone Number" on position 1 with values "1"
    Then Add "Phone Number" edit contact button is enabled
    When User clicks Add "Phone Number" edit contact button
    And User updates Associated Party's Contact section "Phone Number" on position 2 with values "2"
    And User clicks Add "Phone Number" edit contact button
    And User updates Associated Party's Contact section "Phone Number" on position 3 with values "3"
    And User updates Associated Party's Contact section "Fax" on position 1 with values "1"
    Then Add "Fax" edit contact button is enabled
    When User clicks Add "Fax" edit contact button
    And User updates Associated Party's Contact section "Fax" on position 2 with values "2"
    And User clicks Add "Fax" edit contact button
    And User updates Associated Party's Contact section "Fax" on position 3 with values "3"
    And User updates Associated Party's Contact section "Website" on position 1 with values "https://www.test1.com"
    Then Add "Website" edit contact button is enabled
    When User clicks Add "Website" edit contact button
    And User updates Associated Party's Contact section "Website" on position 2 with values "https://www.test2.com"
    And User clicks Add "Website" edit contact button
    And User updates Associated Party's Contact section "Website" on position 3 with values "https://www.test3.com"
    And User clicks remove "Phone Number" on position 2
    Then Alert Icon is displayed with text
      | Success!                       |
      | Phone Number has been deleted. |
    And "Phone Number" field on position 2 is not displayed with value "2"
    When User clicks remove "Fax" on position 2
    Then Alert Icon is displayed with text
      | Success!              |
      | Fax has been deleted. |
    And "Fax" field on position 2 is not displayed with value "2"
    When User clicks remove "Website" on position 2
    Then Alert Icon is displayed with text
      | Success!                  |
      | Website has been deleted. |
    And "Website" field on position 2 is not displayed with value "2"
    And User clicks Associated Party's Contact section "Save" button
    And Contact section "Save" button is not displayed
    And Associated Party's Contact section details are displayed with data
      | Phone Number | Fax | Website               | Email Address    |
      | 1            | 1   | https://www.test1.com | test@example.com |
      | 3            | 3   | https://www.test3.com |                  |

  @C35709465
  @full_regression
  Scenario: C35709465: Third-party Associated individual - Add contact page overview
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on ADD ASSOCIATED PARTY button
    Then Current URL contains "/thirdparty/" endpoint
    And Associated Party Add modal Auto-screen button is displayed
    And Associated Party Add modal Key-principal star button is displayed
    And Associated Party Add modal contains a sub-section with fields
      | Title       |
      | Middle Name |
    And Associated Party Add modal contains a sub-section with required indicator fields
      | First Name |
      | Last Name  |
    When User can expand "Address" section
    Then Associated Party Add modal contains a sub-section "Address" with fields
      | Address Line    |
      | City            |
      | Zip/Postal Code |
      | State/Province  |
      | Region          |
      | Country         |
    When User can expand "Contact" section
    Then Associated Party Add modal contains a sub-section "Contact" with fields
      | Phone Number |
      | Fax          |
      | Website      |
    And Associated Party Add modal contains a sub-section "Contact" with non required indicator field
      | Email Address |
    When User checks 'Enabled as User' checkbox on Add contact screen
    And Associated Party Add modal contains a sub-section "Contact" with required indicator field
      | Email Address |
    When User can expand "Description" section
    And Associated Party contains a sub-section Description with input field
    And User can collapse "Address" section
    And User can collapse "Contact" section
    And User can collapse "Description" section
    And Associated Party Contact modal "Save" button is displayed
    And Associated Party Contact modal "Save and New" button is displayed
    And Associated Party Contact modal "Cancel" button is displayed

  @C35743357
  @full_regression
  Scenario: C35743357: Third-party Associated individual - Associated individual overview page (after adding of contact)
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "with matched results"
    Then Current URL contains "/thirdparty/" endpoint
    And The Associated Party overview page contains "General Information" sub-section with fields
      | Title        |
      | First Name   |
      | Last Name    |
      | Middle Name  |
      | Position     |
      | Relationship |
    And The Associated Party overview page "General Information" edit button is displayed
    And User can collapse "General Information" section
    And User can expand "General Information" section
    And The Associated Party overview page contains "Address" sub-section with fields
      | Address Line    |
      | City            |
      | Zip/Postal Code |
      | State/Province  |
      | Region          |
      | Country         |
    And The Associated Party overview page "Address" edit button is displayed
    And User can collapse "Address" section
    And User can expand "Address" section
    And The Associated Party overview page contains "Contact" sub-section with fields
      | Phone Number    |
      | Fax             |
      | Website         |
      | Email Address   |
      | Enabled As User |
    And The Associated Party overview page "Contact" edit button is displayed
    And User can collapse "Contact" section
    And User can expand "Contact" section
    And Contact 'Enabled as User' checkbox is displayed
    And "Other Names Add|Save button" for other name is displayed
    And Screening section displays Last Screening Date message with date in format: "d MMMM YYYY"
    And Screening section Change Search Criteria button is displayed
    And Screening section Bell icon is displayed
    And Screening section Ongoing Screening slider is displayed
    And Screening section table displays expected columns
      | thirdPartyInformation.screening.columnName              |
      | thirdPartyInformation.screening.columnCountryOfLocation |
      | thirdPartyInformation.screening.columnType              |
      | thirdPartyInformation.screening.columnMatchStrength     |
      | thirdPartyInformation.screening.columnDataProvider      |
      | thirdPartyInformation.screening.columnReferenceId       |
      | thirdPartyInformation.screening.columnResolution        |
    And The Associated Party overview page "Description" edit button is displayed
    And Associated Parties details are displayed with populated data