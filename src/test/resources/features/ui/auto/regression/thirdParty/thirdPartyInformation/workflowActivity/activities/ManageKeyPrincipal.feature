@ui @full_regression @ordering
Feature: Due Diligence Report Ordering - Manage Key Principal

  Background:
    Given User logs into RDDC as "Admin"

  @C36105536
  Scenario: C36105536: Due Diligence Report Ordering - Order Page - Organisation: Order Due Diligence Report - Manage Key Principal - View Table and Form
    When User creates third-party "workflowGroupUkraine"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Activity Information Edit button is displayed
    And User clicks Edit button for Activity
    And User clicks Create Order button
    Then Due Diligence Order form is opened
    And 'No Available data' is displayed in 'Key Principal' section
    And "Manage Key Principal" button on Due Diligence page is displayed
    When User clicks Back button on Due Diligence Order page
    Then Activity Information page is displayed
    When User creates Associated Party "with Ann contact details"
    And User clicks Associated Party Overview contact button
    And User clicks key principal button for contact "with Ann contact details"
    And User clicks on "Third-party Information" tab on Third-party page
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Order Details button
    Then Create Due Diligence Order page is opened
    And Order Key Principal table contains columns
      | KEY PRINCIPAL NAME |
      | EMAIL              |
      | ADDRESS            |
    And Order Key Principal table contains records
      | KEY PRINCIPAL NAME | EMAIL           | ADDRESS |
      | Ann Lim            | annlim@test.com | Norway  |
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    Then Manage Key Principal page is displayed
    And Manage Key Principal page Add New Contact section is displayed with the following fields
      | Title               |
      | Local Language Name |
      | Email               |
    And Manage Key Principal page Add New Contact section is displayed with the following required fields
      | First Name |
      | Last Name  |
    And Manage Key Principal page Address section is displayed with the following fields
      | Address line    |
      | City            |
      | State/Province  |
      | Zip/Postal Code |
    And Manage Key Principal page Address section is displayed with the following required fields
      | Country |
    And Manage Key Principal page note "(New associated individual / Changes in associated individual details will be reflected on Third-party Associated Parties Tab)" is displayed
    And Manage Key Principal table contains records
      | checked | Title | First Name | Last Name | ADDRESS | Country |
      | true    |       | Ann        | Lim       |         | Norway  |

  @C36105536
  Scenario: C36105536: Due Diligence Report Ordering - Order Page - Organisation: Order Due Diligence Report - Manage Key Principal - Create and Edit Contact
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User creates valid email
    And User creates Associated Party "Individual" "with valid email" via API and open it
    And User checks 'Enabled as User' checkbox on contact screen
    And User clicks Associated Party's General Information section "Edit" button
    And User updates Associated Party's General Information section with values
      | Title | First Name | Last Name | Middle Name      |
      | Title | Active     | User      | Test Middle Name |
    And User clicks Associated Party's General Information section "Save" button
    And User clicks Associated Party's Address section "Edit" button
    And User updates Associated Party's Address section on position 1 with values
      | Address Line      | City      | Zip/Postal Code        | State/Province        | Country |
      | Test Address Line | Test City | Test Zip / Postal code | Test State / Province | Norway  |
    And User clicks Associated Party's Address section "Save" button
    And User clicks on "Third-party Information" tab on Third-party page
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Activity Information Edit button is displayed
    And User clicks Edit button for Activity
    And User clicks Create Order button
    Then Due Diligence Order form is opened
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    Then Manage Key Principal table contains records
      | checked | Title | First Name | Last Name | ADDRESS                                                                  | Country |
      | false   | Title | Active     | User      | Test Address Line Test City Test State / Province Test Zip / Postal code | Norway  |
    When User clicks edit button for key principal with First Name "Active"
    And User populates First Name for Key Principal with "userEditedFirstName"
    And User populates Last Name for Key Principal with "User Last Name"
    And User selects Country "Angola" for Key Principal
    And User clicks "Save" button on Key Principal page
    And User clicks "Proceed" Alert dialog button
    Then Manage Key Principal table contains records
      | checked | Title | First Name          | Last Name      | ADDRESS                                                                  | Country |
      | false   | Title | userEditedFirstName | User Last Name | Test Address Line Test City Test State / Province Test Zip / Postal code | Angola  |
    When User clicks checkbox for key principal with First Name "userEditedFirstName"
    Then Manage Key Principal table contains records
      | checked | Title | First Name          | Last Name      | ADDRESS                                                                  | Country |
      | true    | Title | userEditedFirstName | User Last Name | Test Address Line Test City Test State / Province Test Zip / Postal code | Angola  |
    When User clicks Add to List Key Principle button
    Then Order Key Principal table contains records
      | KEY PRINCIPAL NAME                       | EMAIL        | ADDRESS                                                                         |
      | Title userEditedFirstName User Last Name | toBeReplaced | Test Address Line Test City Test State / Province Test Zip / Postal code Angola |
    When User clicks Back button on Due Diligence Order page
    Then Activity Information page is displayed
    When User clicks on "Associated Parties" tab on Third-party page
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name          | Last Name      | Country | Status |
      | true          | Title | userEditedFirstName | User Last Name | Angola  | Active |
    When User navigates 'Set Up' block 'User' section
    And User searches user by first name
    Then User table contains user with values
      | First Name          | Last Name      | User Name | User Type | Role | Status | Single Sign On |
      | userEditedFirstName | User Last Name | email     | External  |      | ACTIVE | No             |

  @C36105536
  Scenario: C36105536: Due Diligence Report Ordering - Order Page - Organisation: Order Due Diligence Report - Manage Key Principal - Create and edit Key Principal
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Activity Information Edit button is displayed
    And User clicks Edit button for Activity
    And User clicks Create Order button
    Then Due Diligence Order form is opened
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    And User fills Key Principle form data "Key Principle all fields"
    Then Alert Dialog with text is displayed
      | New Key principal                                                                                       |
      | New Key principal will also be added in Third-party Associated Individual list. Do you want to proceed? |
    And Alert Dialog "Proceed" button displayed
    And Alert Dialog "Cancel" button displayed
    When User clicks "Cancel" Alert dialog button
    Then 'No Available data' is displayed in 'Key Principal' section
    When User fills Key Principle form data "Key Principle all fields"
    And User clicks "Proceed" Alert dialog button
    Then Manage Key Principal table contains records
      | checked | Title      | First Name | Last Name | ADDRESS                                | Country |
      | true    | Test title | Key        | Principle | Test address Gotham Gotham state 90210 | Ukraine |
    When User clicks Back button on Due Diligence Order page
    Then Order Key Principal table contains records
      | KEY PRINCIPAL NAME       | EMAIL              | ADDRESS                                        |
      | Test title Key Principle | testEmail@test.com | Test address Gotham Gotham state 90210 Ukraine |
    When User clicks Back button on Due Diligence Order page
    Then Activity Information page is displayed
    When User clicks on "Associated Parties" tab on Third-party page
    Then Associated Party table contains associated party with values
      | Key Principal | Title      | First Name | Last Name | Country | Status   |
      | true          | Test title | Key        | Principle | Ukraine | Inactive |
    When User clicks on Associated Party with name "Key"
    Then Other Name table contains expected values
      | local language   |
      | Locally Known As |
      | MM/dd/YYYY       |
      | MM/dd/YYYY       |
    When User clicks on "Third-party Information" tab on Third-party page
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks Order Details button
    Then Create Due Diligence Order page is opened
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    And User clicks edit button for key principal with First Name "Key"
    And User selects Country " " for Key Principal
    And User populates First Name for Key Principal with ""
    And User populates Last Name for Key Principal with ""
    And User clicks "Save" button on Key Principal page
    Then Alert Icon is displayed with text
      | Cannot Save. Please complete the required field(s). |
    And Error message "This field is required" in red color is displayed near Key Principal fields
      | First Name |
      | Last Name  |
      | Country    |
    And Manage Key Principal table contains records
      | checked | Title      | First Name | Last Name | ADDRESS                                | Country |
      | true    | Test title | Key        | Principle | Test address Gotham Gotham state 90210 | Ukraine |
    When User populates First Name for Key Principal with "Auto"
    And User populates Last Name for Key Principal with "Principal"
    And User selects Country "Albania" for Key Principal
    And User clicks "Cancel" button on Key Principal page
    Then Manage Key Principal table contains records
      | checked | Title      | First Name | Last Name | ADDRESS                                | Country |
      | true    | Test title | Key        | Principle | Test address Gotham Gotham state 90210 | Ukraine |
    When User clicks edit button for key principal with First Name "Key"
    And User populates First Name for Key Principal with "Auto"
    And User populates Last Name for Key Principal with "Principal"
    And User selects Country "Albania" for Key Principal
    And User clicks "Save" button on Key Principal page
    Then Alert Dialog with text is displayed
      | UPDATE KEY PRINCIPAL                                                                                                  |
      | Changes in the following details will update the Third-party Associated Individual Tab. Do you want to apply changes? |
    And Alert Dialog "Proceed" button displayed
    And Alert Dialog "Cancel" button displayed
    When User clicks "Cancel" Alert dialog button
    Then Manage Key Principal table contains records
      | checked | Title      | First Name | Last Name | ADDRESS                                | Country |
      | true    | Test title | Key        | Principle | Test address Gotham Gotham state 90210 | Ukraine |
    When User clicks edit button for key principal with First Name "Key"
    And User populates First Name for Key Principal with "Auto"
    And User populates Last Name for Key Principal with "Principal"
    And User selects Country "Albania" for Key Principal
    And User clicks "Save" button on Key Principal page
    And User clicks "Proceed" Alert dialog button
    Then Manage Key Principal table contains records
      | checked | Title      | First Name | Last Name | ADDRESS                                | Country |
      | true    | Test title | Auto       | Principal | Test address Gotham Gotham state 90210 | Albania |
    When User clicks checkbox for key principal with First Name "Auto"
    Then Manage Key Principal table contains records
      | checked | Title      | First Name | Last Name | ADDRESS                                | Country |
      | false   | Test title | Auto       | Principal | Test address Gotham Gotham state 90210 | Albania |
    When User clicks Add to List Key Principle button
    Then 'No Available data' is displayed in 'Key Principal' section
    When User clicks Back button on Due Diligence Order page
    Then Activity Information page is displayed
    When User clicks on "Associated Parties" tab on Third-party page
    Then Associated Party table contains associated party with values
      | Key Principal | Title      | First Name | Last Name | Country | Status   |
      | false         | Test title | Auto       | Principal | Albania | Inactive |

  @C36115605
  Scenario: C36115605: Due Diligence Report Ordering - Order Page - Individual: Order Due Diligence Report - Manage Key Principal
    When User creates third-party "workflowGroupUkraineIndividual" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And Activity Information Edit button is displayed
    And User clicks Edit button for Activity
    And User clicks Create Order button
    Then Due Diligence Order form is opened
    When User clicks "Manage Key Principal" button on Due Diligence Order page
    Then Manage Key Principal page is displayed
    And Manage Key Principal page Add New Contact section is displayed with the following fields
      | Title               |
      | Local Language Name |
      | Email               |
    And Manage Key Principal page Add New Contact section is displayed with the following required fields
      | First Name |
      | Last Name  |
    And Manage Key Principal page Address section is displayed with the following fields
      | Address line    |
      | City            |
      | State/Province  |
      | Zip/Postal Code |
    And Manage Key Principal page Address section is displayed with the following required fields
      | Country |
    And Manage Key Principal page note "(New associated individual / Changes in associated individual details will be reflected on Third-party Associated Parties Tab)" is displayed
    When User fills Key Principle form data "Key Principle all fields"
    Then Alert Dialog with text is displayed
      | New Key principal                                                                                       |
      | New Key principal will also be added in Third-party Associated Individual list. Do you want to proceed? |
    And Alert Dialog "Proceed" button displayed
    And Alert Dialog "Cancel" button displayed
    When User clicks "Cancel" Alert dialog button
    Then Manage Key Principal table is not displayed
    When User fills Key Principle form data "Key Principle all fields"
    And User clicks "Proceed" Alert dialog button
    Then Due Diligence Subject Full Name is populated with "Key Principle"
    And Create Order page Address section should be shown with expected values
      | Address Line | City   | Code postal | State/Province | Country |
      | Test address | Gotham | 90210       | Gotham state   | Ukraine |
    When User clicks Back button on Due Diligence Order page
    Then Activity Information page is displayed
    When User clicks on "Associated Parties" tab on Third-party page
    Then Associated Party table contains associated party with values
      | Key Principal | Title      | First Name | Last Name | Country | Status   |
      | true          | Test title | Key        | Principle | Ukraine | Inactive |
    When User clicks on Associated Party with name "Key"
    Then Other Name table contains expected values
      | local language   |
      | Locally Known As |
      | MM/dd/YYYY       |
      | MM/dd/YYYY       |