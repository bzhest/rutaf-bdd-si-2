@ui @full_regression @external_user_profile
Feature: External User Portal - Create Contact

  As an External User
  I want I want to be able to create contacts for our organisation
  So that I can create Contact records that should be considered or involved in the Onboarding process


  @C35953368 @C40581878
  Scenario: C35953368, C40581878: External User Portal - add Contact - verify that multiple Contact Addresses ('Address' section) can be added/removed
    Given User logs into RDDC as "External"
    When User clicks My profile tab
    And User clicks "Associated Parties" My Profile tab
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
    When User enters Associated Party first name with value "toBeReplaced"
    And User enters Associated Party last name with value "toBeReplaced"
    And User enters Associated Party email with value "ceo@starkink.com"
    And User clicks on Save Associated Party button
    Then Associated Party page is loaded
    And Associated Party's Address section details are displayed with data
      | Address Line   | City   | Zip/Postal Code   | State/Province   | Region       | Country      |
      |                |        |                   |                  |              | Ukraine      |
      | Address Line 2 | City 2 | Zip/Postal Code 2 |                  |              | Austria      |
      | Address Line 3 | City 3 | Zip/Postal Code 3 | State/Province 3 | toBeReplaced | toBeReplaced |
      | Address Line 4 | City 4 | Zip/Postal Code 4 | State/Province 4 |              | Norway       |
    When User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches third-party with name "Supplier_External_User"
    And User clicks third-party with name "Supplier_External_User"
    And User clicks on "Associated Parties" tab on Third-party page
    And User searches item by "userEditedFirstName" keyword
    And User clicks on Associated Party with name "userEditedFirstName"
    Then Associated Party's Address section details are displayed with data
      | Address Line   | City   | Zip/Postal Code   | State/Province   | Region       | Country      |
      |                |        |                   |                  |              | Ukraine      |
      | Address Line 2 | City 2 | Zip/Postal Code 2 |                  |              | Austria      |
      | Address Line 3 | City 3 | Zip/Postal Code 3 | State/Province 3 | toBeReplaced | toBeReplaced |
      | Address Line 4 | City 4 | Zip/Postal Code 4 | State/Province 4 |              | Norway       |

  @C35969005 @C40581879
  Scenario: C35969005, C40581879: External User Portal - add Contact - verify that multiple Phone Numbers/Websites/Faxes  ('Contact' section) can be added/removed
    Given User creates valid email
    When User logs into RDDC as "External"
    And User clicks My profile tab
    And User clicks "Associated Parties" My Profile tab
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
    When User enters Associated Party first name with value "toBeReplaced"
    And User enters Associated Party last name with value "toBeReplaced"
    And User enters Associated Party email with value "email"
    And User clicks on Save Associated Party button
    And Associated Party page is loaded
    Then Associated Party's Contact section details are displayed with data
      | Phone Number | Fax | Website               | Email Address |
      | 1            | 1   | https://www.test1.com | email         |
      | 3            | 3   | https://www.test3.com |               |
    When User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches third-party with name "Supplier_External_User"
    And User clicks third-party with name "Supplier_External_User"
    And User clicks on "Associated Parties" tab on Third-party page
    And User searches item by "userEditedFirstName" keyword
    And User clicks on Associated Party with name "userEditedFirstName"
    Then Associated Party's Contact section details are displayed with data
      | Phone Number | Fax | Website               | Email Address |
      | 1            | 1   | https://www.test1.com | email         |
      | 3            | 3   | https://www.test3.com |               |

  @C35907790 @C40581873
  Scenario: C35907790, C40581873: External User Portal - check My Profile: Contacts tab
    Given User logs into RDDC as "External"
    When User clicks My profile tab
    And User clicks "Associated Parties" My Profile tab
    Then Contact table contains columns
      | TITLE        |
      | FIRST NAME   |
      | LAST NAME    |
      | COUNTRY      |
      | RELATIONSHIP |
      | STATUS       |
    When User clicks My Profile Contacts "Title" column
    Then My Profile Contacts table is sorted by "TITLE" field in "ASC" order
    When User clicks My Profile Contacts "Title" column
    Then My Profile Contacts table is sorted by "TITLE" field in "DESC" order
    When User clicks My Profile Contacts "First Name" column
    Then My Profile Contacts table is sorted by "FIRST NAME" field in "ASC" order
    When User clicks My Profile Contacts "First Name" column
    Then My Profile Contacts table is sorted by "FIRST NAME" field in "DESC" order
    When User clicks My Profile Contacts "Last Name" column
    Then My Profile Contacts table is sorted by "LAST NAME" field in "ASC" order
    When User clicks My Profile Contacts "Last Name" column
    Then My Profile Contacts table is sorted by "LAST NAME" field in "DESC" order
    When User clicks My Profile Contacts "Country" column
    Then My Profile Contacts table is sorted by "COUNTRY" field in "ASC" order
    When User clicks My Profile Contacts "Country" column
    Then My Profile Contacts table is sorted by "COUNTRY" field in "DESC" order
    When User clicks My Profile Contacts "Status" column
    Then My Profile Contacts table is sorted by "STATUS" field in "DESC" order
    When User clicks My Profile Contacts "Status" column
    Then My Profile Contacts table is sorted by "STATUS" field in "ASC" order
    And Pagination option "10" is selected if pagination is displayed
    And Pagination elements are displayed if table contains more than 10 rows
      | 10 |
      | 25 |
      | 50 |
    When User selects "50" items per page or max value
    Then Table displayed with up to "50" rows
    When User selects "25" items per page
    Then Pagination option "25" is selected
    And Table displayed with up to "25" rows
    When User selects "10" items per page
    Then Table displayed with up to "10" rows
    When User searches item by "External_AT_FN External_AT_LN" keyword
    Then Associated Party table contains associated party with values
      | Title | First Name     | Last Name      | Country | Status |
      |       | External_AT_FN | External_AT_LN |         | Active |
    When User clicks on Associated Party with name "External_AT_FN"
    Then Associated Party page is loaded
    And User can collapse "General Information" section
    And User can collapse "Address" section
    And User can collapse "Contact" section
    And User can collapse "Description" section
    And User can expand "General Information" section
    And User can expand "Address" section
    And User can expand "Contact" section
    And User can expand "Description" section
    Then The Associated Party overview page contains "General Information" sub-section with fields
      | Title        |
      | Last Name    |
      | First Name   |
      | Middle Name  |
      | Position     |
      | Relationship |
    And The Associated Party overview page contains "Address" sub-section with fields
      | Address Line    |
      | City            |
      | Zip/Postal Code |
      | State/Province  |
      | Region          |
      | Country         |
    And The Associated Party overview page contains "Contact" sub-section with fields
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |
    When User clicks Associated Party Overview contact button
    And User searches item by "External_AT_FN" keyword
    Then Associated Party table contains associated party with values
      | Title | First Name     | Last Name      | Country | Status |
      |       | External_AT_FN | External_AT_LN |         | Active |
    When User clears search input field
    And User clicks "3" pagination button
    And User clicks on first Contacts overview row
    And User clicks Associated Party Overview contact button
    Then Pagination page "3" is currently selected
    When User searches item by "non valid" keyword
    Then Empty Associated Parties table with text "NO RECORDS FOUND" is displayed