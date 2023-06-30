@ui @full_regression @suppliers
Feature: Third-party Associated Party - Associated Party Overview and View

  As a RDDC User
  I want I want to have a page where I can see all the Associated Parties of a Third-party
  So that So that I can start managing the Associated Parties in relation to the Third-party's Onboarding process

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on "Associated Parties" tab on Third-party page

  @C37108890
  Scenario: C37108890: TP Associated individual - Overview of TP Associated parties page - No Associated individual page
    Then Empty Associated Parties table with text "NO ASSOCIATED PARTIES AVAILABLE" is displayed
    And ADD ASSOCIATED PARTY button is displayed

  @C37108892
  @RMS-21840
  Scenario: C37108892: Third-party Associated individual - Searching on Associated parties page
    When User creates Associated Party "with Ann contact details"
    And User clicks Associated Party Overview contact button
    And User creates Associated Party "with matched results"
    And User clicks Associated Party Overview contact button
    And User creates Associated Party "with Marry Lima contact details"
    And User clicks Associated Party Overview contact button
    And User searches item by "qwerty" keyword
    Then Associated Party "with Ann contact details" does not appear in the Associated Parties table
    And Associated Party "with matched results" does not appear in the Associated Parties table
    And Empty Associated Parties table with text "NO RECORDS FOUND" is displayed
    When User searches item by "Vladimir" keyword
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name | Last Name | Country | Status   |
      | false         |       | Vladimir   | P         | Ukraine | Inactive |
    And Associated Party "with Ann contact details" does not appear in the Associated Parties table
    And Associated Party "with Marry Lima contact details" does not appear in the Associated Parties table
    When User searches item by "Lima" keyword
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name | Last Name | Country | Status   |
      | false         |       | Marry      | Lima      |         | Inactive |
    And Associated Party "with matched results" does not appear in the Associated Parties table
    And Associated Party "with Ann contact details" does not appear in the Associated Parties table
    When User searches item by "Ann Lim" keyword
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name | Last Name | Country | Status   |
      | false         |       | Ann        | Lim       | Norway  | Inactive |
    And Associated Party "with matched results" does not appear in the Associated Parties table
    And Associated Party "with Marry Lima contact details" does not appear in the Associated Parties table
    #TODO - Uncomment when RMS-21840 will be fixed
#    When User searches item by "Bob Lima" keyword
#    Then Associated Party table contains associated party with values
#      | Key Principal | Title | First Name | Last Name | Country | Status   |
#      | false         |       | Marry      | Lima      |         | Inactive |
#    And Associated Party "with Ann contact details" does not appear in the Associated Parties table
#    And Associated Party "with matched results" does not appear in the Associated Parties table

  @C35709381
  Scenario: C35709381: Third-party Associated individual -Overview of Third-party Associated parties page - Associated parties page with list of Associated parties
    And User creates Associated Party "Individual" "with Ann contact details" via API and open it
    And User clicks Associated Party Overview contact button
    Then Current URL contains "/thirdparty/" endpoint
    And Show Drop-Down list is displayed with values
      | All            |
      | Recently Added |
    And Search text field is displayed
    And ADD ASSOCIATED PARTY button is displayed
    And Contact table contains columns
      | KEY PRINCIPAL |
      | TITLE         |
      | FIRST NAME    |
      | LAST NAME     |
      | COUNTRY       |
      | RELATIONSHIP  |
      | STATUS        |
    And Associated Party table contains associated party with values
      | Key Principal | Title | First Name | Last Name | Country | Status   |
      | false         |       | Ann        | Lim       | Norway  | Inactive |
    And For each Contact record in the list controls buttons should be displayed
    When User clicks key principal button for contact "with Ann contact details"
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name | Last Name | Country | Status   |
      | true          |       | Ann        | Lim       | Norway  | Inactive |
    And Key Principal for contact "with Ann contact details" is selected

  @C35804221
  Scenario: C35804221: Third-party Associated individual - View Associated parties
    And User creates Associated Party "Individual" "with Ann contact details" via API and open it
    And User clicks Associated Party Overview contact button
    Then "Edit" tooltip is displayed when hover over edit button for contact "with Ann contact details"
    And Edit button is enabled for contact "with Ann contact details"
    When User clicks on Associated Party with name "Ann"
    Then Associated Party page is loaded
    And Current URL contains "/thirdparty/" endpoint
    And Associated Parties details are displayed with populated data
    When User clicks Associated Party's General Information section "Edit" button
    And User updates Associated Party's General Information section with values
      | Title      | First Name      | Last Name      | Middle Name      |
      | Edit Title | Edit First Name | Edit Last Name | Edit Middle Name |
    And User clicks Associated Party's General Information section "Save" button
    Then Associated Party's General Information section details are displayed with populated data
    When User clicks Associated Party's Address section "Edit" button
    And User updates Associated Party's Address section on position 1 with values
      | Address Line      | City      | Zip/Postal Code      | State/Province      | Region       | Country |
      | Edit Address Line | Edit City | Edit Zip/Postal code | Edit State/Province | toBeReplaced |         |
    And User clicks Associated Party's Address section "Save" button
    Then Associated Party's Address section details are displayed with populated data
    When User clicks Associated Party's Contact section "Edit" button
    And User updates Associated Party's Contact section with values
      | Phone Number | Fax      | Website              | Email Address   |
      | 000000000000 | Edit Fax | http://edit.test.com | annlim@test.com |
    And User clicks Associated Party's Contact section "Save" button
    Then Associated Party's Contact section details are displayed with populated data
    When User fills in Name field value "Test Other Name"
    And User selects Name type "Also Known As"
    And User clicks on "Other Names Add|Save button"
    Then Other Name dialog is loaded
    When User clicks Close Other Name Results button
    Then Other Name table contains expected values
      | Test Other Name |
      | Also Known As   |
      | MM/dd/YYYY      |
      | MM/dd/YYYY      |
    When User clicks Associated Party's Description section "Edit" button
    And User waits for progress bar to disappear from page
    And User fills in Associated Party's Description text "Description"
    And User clicks Associated Party's Description section "Save" button
    Then Associated Party's Description section is populated with text "Description"