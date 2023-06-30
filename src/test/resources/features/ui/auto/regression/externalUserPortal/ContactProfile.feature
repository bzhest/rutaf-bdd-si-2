@ui @full_regression @external_user_profile
Feature: External User Portal - Create Contact

  As an External User
  I want I want to be able to create contacts for our organisation
  So that I can create Contact records that should be considered or involved in the Onboarding process

  @C35908919
  @core_regression
  Scenario: C35908919: External User Portal - check Add Contacts functionality on My Profile: Contacts
    Given User logs into RDDC as "External"
    When User clicks My profile tab
    Then Current URL contains "/external/my-profile" endpoint
    And My Profile page contains tabs
      | COMPANY INFORMATION |
      | ASSOCIATED PARTIES  |
    When User clicks "Associated Parties" My Profile tab
    And User clicks 'Add Associated Party' button on Contacts overview page
    Then Associated Party Contact modal is displayed
    And Associated Party Add modal contains a sub-section with fields
      | Title       |
      | Middle Name |
    And Associated Party Add modal contains a sub-section with required indicator fields
      | First Name |
      | Last Name  |
    And User can expand "Address" section
    And Associated Party Add modal contains a sub-section "Address" with fields
      | Address Line    |
      | City            |
      | Zip/Postal Code |
      | State/Province  |
      | Region          |
      | Country         |
    And User can expand "Contact" section
    And Associated Party Add modal contains a sub-section "Contact" with fields
      | Phone Number |
      | Fax          |
      | Website      |
    And User can expand "Description" section
    And Associated Party contains a sub-section Description with input field
    When User clicks Associated Party Overview contact button
    Then Associated Party Contact modal is invisible
    When User clicks 'Add Associated Party' button on Contacts overview page
    And User clicks on Save Associated Party button
    Then Error message "This field is required" in red color is displayed near "First Name" contact field
    And Error message "This field is required" in red color is displayed near "Last Name" contact field
    When User fills in contact data with random data
    And User clicks on Save Associated Party button
    Then Associated Party Contact modal is invisible
    And Associated Party page is loaded
    When User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches third-party with name "Supplier_External_User"
    And User clicks third-party with name "Supplier_External_User"
    And User clicks on "Associated Parties" tab on Third-party page
    And User searches item by "userEditedFirstName" keyword
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name          | Last Name          | Country | Status   |
      | false         |       | userEditedFirstName | userEditedLastName |         | Inactive |

  @C35909009
  Scenario: C35909009: External User Portal - check Add Contacts ('Save and New' approach) functionality on My Profile: Contacts
    Given User logs into RDDC as "External"
    When User clicks My profile tab
    And User clicks "Associated Parties" My Profile tab
    And User clicks 'Add Associated Party' button on Contacts overview page
    Then Associated Party Contact modal is displayed
    When User clicks on Save and New Associated Party button
    Then Error message "This field is required" in red color is displayed on General Information section on field
      | First Name |
      | Last Name  |
    When User fills in contact data with random data
    And User clicks on Save and New Associated Party button
    Then Alert Icon is displayed with text
      | Success! New Associated Party has been saved. |
    And Associated Party Contact modal is displayed
    And Contact Information details are displayed with empty data
    When User clicks Associated Party Overview contact button
    And User searches item by "userEditedFirstName" keyword
    Then Associated Party table contains associated party with values
      | Title | First Name          | Last Name          | Country | Status   |
      |       | userEditedFirstName | userEditedLastName |         | Inactive |
    When User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches third-party with name "Supplier_External_User"
    And User clicks third-party with name "Supplier_External_User"
    And User clicks on "Associated Parties" tab on Third-party page
    And User searches item by "userEditedFirstName" keyword
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name          | Last Name          | Country | Status   |
      | false         |       | userEditedFirstName | userEditedLastName |         | Inactive |