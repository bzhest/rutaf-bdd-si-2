@ui @full_regression @core_regression @external_user_profile
Feature: External User Portal - My Profile: Company Information Tab

  As an External User
  I want to have a page where I can see the Supplier Profile of our organisation
  So that I can review the details from time to time and make sure they are up to date

  @C35884409
  Scenario: C35884409: External User Portal - check My Profile: Company Information tab
    Given User logs into RDDC as "Admin"
    When User navigates to Third-party page
    And User searches third-party with name "Supplier_External_User"
    And User clicks third-party with name "Supplier_External_User"
    And User saves third-party data
    And User logs into RDDC as "External"
    And User clicks My profile tab
    Then Current URL contains "/external/my-profile" endpoint
    And My Profile page contains tabs
      | COMPANY INFORMATION |
      | ASSOCIATED PARTIES  |
    And The Company Information tab fields contain expected data
    And The Company Information tab contains a sub-section "General Information" with disabled fields
      | Reference Number      |
      | Name                  |
      | Company Type          |
      | Organisation Size     |
      | Date of Incorporation |
      | Currency              |
      | Affiliation           |
      | Industry Type         |
      | Business Category     |
      | Revenue               |
    And The Company Information sub-section named "General Information" is collapsed
    And The Company Information sub-section named "General Information" cold be uncollapsed
    And The Company Information tab contains a sub-section "Address" with disabled fields
      | Address Line    |
      | City            |
      | Zip/Postal Code |
      | State/Province  |
      | Region          |
      | Country         |
    And The Company Information sub-section named "Address" is collapsed
    And The Company Information sub-section named "Address" cold be uncollapsed
    And The Company Information tab contains a sub-section "Contact" with disabled fields
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |
    And The Company Information sub-section named "Contact" is collapsed
    And The Company Information sub-section named "Contact" cold be uncollapsed
