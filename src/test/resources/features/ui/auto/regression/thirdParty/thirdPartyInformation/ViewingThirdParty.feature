@ui @full_regression @suppliers
Feature: Third-party Information - Viewing Third-party

  As a RDDC User
  I want I want to view Third-party Records that I have access to
  So that I can see the details that I need to know about the Third-parties to perform my tasks

  Background:
    Given User logs into RDDC as "Admin"

  @C35616866
  Scenario: C35616866: Supplier - View Third-party with complete details
    When User creates third-party "with workflow group and description"
    And User navigates to Third-party page
    And Current URL contains "/thirdparty" endpoint
    And User searches created third-party
    Then Third-party Overview tab is loaded
    When User clicks on created third-party
    And Third-party Information should have status field "Status:"
    Then Third-party's status should be shown - "NEW"
    And Third-party Information should have Assessment Details fields
      | Renewal Cycle |
    And Onboarding Start Date field should be hidden
    And Onboarded Decision Date field should be hidden
    And Third-party Information should have General Information fields
      | Reference No. | Name | Company Type | Organisation Size | Date of Incorporation | Responsible Party | Division | Workflow Group | Currency | Industry Type | Business Category | Revenue | Liquidation Date | Affiliation |
    And Third-party Information should have Third-party Segmentation fields
      | Spend Category | Design Agreement | Relationship Visibility | Commodity Type | Sourcing Method | Sourcing Type | Product Impact |
    And Third-party Information should have all Active Custom Fields fields
    And Third-party Information should have Bank Details fields
      | Bank Name | Account No. | Branch Name | Address Line | City | Country |
    And Third-party Information should have Address fields
      | Address Line | City | Zip/Postal Code | State/Province | Region | Country |
    And Third-party Information should have Contact fields
      | Phone Number | Fax | Website | Email Address |
    And Third-party Information should have Description for data "with workflow group and description"

  @C35637607
  Scenario: C35637607: Supplier - View Supplier - Supplier Overview Link (back button)
    When User creates third-party "with random ID name"
    And User navigates to Third-party page
    And User searches created third-party
    Then Created third-party is displayed in Third-party overview table
    When User clicks on created third-party
    Then Third-party Information tab is loaded
    And Third-party's element "Third-party overview" should be shown
    When User waits and clicks "Third-party overview" third-party button
    Then Third-party Overview tab is loaded
    And Created third-party is displayed in Third-party overview table
    And Current URL contains "/thirdparty" endpoint

  @C50076369
  @core_regression
  Scenario: C50076369: [Configurable TP Fields] - View - General and Other Information section - All fields displayed - Optional
    When User creates third-party "with mandatory fields"
    And User sets up role "AUTO TEST ROLE WITH RESTRICTIONS" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User opens previously created Third-party
    Then General and Other Information section is not allowed for editing, as edit icon is disabled
    And Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    When User expands "Third-party Segmentation" section
    Then Third-Party section should be in correct state
      | General Information      | collapsed |
      | Third-party Segmentation | expanded  |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    When User expands "Other Information" section
    Then Third-Party section should be in correct state
      | General Information      | collapsed |
      | Third-party Segmentation | collapsed |
      | Other Information        | expanded  |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    When User expands "Bank Details" section
    Then Third-Party section should be in correct state
      | General Information      | collapsed |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | expanded  |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    When User expands "Address" section
    Then Third-Party section should be in correct state
      | General Information      | collapsed |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | expanded  |
      | Contact                  | collapsed |
      | Description              | collapsed |
    When User expands "Contact" section
    Then Third-Party section should be in correct state
      | General Information      | collapsed |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | expanded  |
      | Description              | collapsed |
    When User expands "Description" section
    Then Third-Party section should be in correct state
      | General Information      | collapsed |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | expanded  |
    When User collapses "General and Other Information" section
    Then Third-Party section should be in correct state
      | General Information      | hidden |
      | Third-party Segmentation | hidden |
      | Other Information        | hidden |
      | Bank Details             | hidden |
      | Address                  | hidden |
      | Contact                  | hidden |
      | Description              | hidden |
    When User logs into RDDC as "Assignee"
    And User opens previously created Third-party
    And User clicks General and Other Information section "Edit" button
    Then All General Information section input fields are displayed
      | Reference No.         |
      | Name                  |
      | Company Type          |
      | Organisation Size     |
      | Date of Incorporation |
      | Responsible Party     |
      | Division              |
      | Workflow Group        |
      | Currency              |
      | Industry Type         |
      | Business Category     |
      | Revenue               |
      | Liquidation Date      |
      | Affiliation           |

  @C50077038
  @core_regression
  @onlySingleThread
  Scenario: C50077038: [Configurable TP Fields] - View - General and Other Information section - All fields displayed - Required
    When User sets required values for Third-party General Information fields via API
    And User refreshes page
    And User creates third-party "General Information fields + country"
    And User sets up role "AUTO TEST ROLE WITH RESTRICTIONS" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User opens previously created Third-party
    Then General and Other Information section is not allowed for editing, as edit icon is disabled
    And Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    And Third-party Information details are displayed with populated data

  @C50076482
  @core_regression
  @onlySingleThread
  Scenario: C50076482: [Configurable TP Fields] - View - General and Other Information section - All Sub-section does not have active fields
    When User sets all Third-party Fields inactive except default required via API
    And User refreshes page
    And User creates third-party "with mandatory fields"
    And User sets up role "AUTO TEST ROLE WITH RESTRICTIONS" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User opens previously created Third-party
    Then General and Other Information section is not allowed for editing, as edit icon is disabled
    And Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | hidden    |
      | Other Information        | collapsed |
      | Bank Details             | hidden    |
      | Address                  | collapsed |
      | Contact                  | hidden    |
      | Description              | hidden    |

  @C50076375
  @core_regression
  @onlySingleThread
  Scenario: C50076375: [Configurable TP Fields] - View - General and Other Information section - 1 sub-section does not have active fields
    When User inactivates values for Third-party Segmentations Fields via API
    And User refreshes page
    And User creates third-party "with mandatory fields"
    And User sets up role "AUTO TEST ROLE WITH RESTRICTIONS" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User opens previously created Third-party
    Then General and Other Information section is not allowed for editing, as edit icon is disabled
    And Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | hidden    |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |

  @C50077054
  @core_regression
  @onlySingleThread
  Scenario: C50077054: [Configurable TP Fields] - View - General and Other Information section - Sub-section has several active fields
    When User sets custom values for Third-party Fields via API
    And User refreshes page
    And User creates third-party "with random ID name and custom fields"
    And User sets up role "AUTO TEST ROLE WITH RESTRICTIONS" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User opens previously created Third-party
    Then General and Other Information section is not allowed for editing, as edit icon is disabled
    And Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    And Third-party Information should have General Information fields
      | Reference No.         |
      | Name                  |
      | Organisation Size     |
      | Date of Incorporation |
      | Responsible Party     |
      | Division              |
      | Workflow Group        |
    And Third-party Information should have Third-party Segmentation fields
      | Spend Category |
      | Commodity Type |
    And Third-party Information should have all Active Custom Fields fields
    And Third-party Information should have Bank Details fields
      | Bank Name    |
      | Account No.  |
      | Branch Name  |
      | Address Line |
      | City         |
      | Country      |
    And Third-party Information should have Address fields
      | City    |
      | Region  |
      | Country |
    And Third-party Information should have Contact fields
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |

  @C50077045
  @core_regression
  @onlySingleThread
  Scenario: C50077045: [Configurable TP Fields] - View - General and Other Information section - Onboarding/Renewing
    When User sets custom values for Third-party Fields via API
    And User refreshes page
    And User creates third-party "with random ID name and custom fields"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User sets up role "AUTO TEST ROLE WITH RESTRICTIONS" for user with firstname "User_Change_Role_AT_FN" via API
    And User logs into RDDC as "Changing role user"
    And User opens previously created Third-party
    Then General and Other Information section is not allowed for editing, as edit icon is disabled
    And Third-Party section should be in correct state
      | General Information      | expanded  |
      | Third-party Segmentation | collapsed |
      | Other Information        | collapsed |
      | Bank Details             | collapsed |
      | Address                  | collapsed |
      | Contact                  | collapsed |
      | Description              | collapsed |
    And Third-party Information should have General Information fields
      | Reference No.         |
      | Name                  |
      | Organisation Size     |
      | Date of Incorporation |
      | Responsible Party     |
      | Division              |
      | Workflow Group        |
    And Third-party Information should have Third-party Segmentation fields
      | Spend Category |
      | Commodity Type |
    And Third-party Information should have all Active Custom Fields fields
    And Third-party Information should have Bank Details fields
      | Bank Name    |
      | Account No.  |
      | Branch Name  |
      | Address Line |
      | City         |
      | Country      |
    And Third-party Information should have Address fields
      | City    |
      | Region  |
      | Country |
    And Third-party Information should have Contact fields
      | Phone Number  |
      | Fax           |
      | Website       |
      | Email Address |