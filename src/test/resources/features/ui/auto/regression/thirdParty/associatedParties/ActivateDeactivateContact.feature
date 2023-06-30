@ui @suppliers
Feature: Third-party Contact - Activate/Deactivate Contact

  As a Supplier Integrity Administrator
  I want to be able to delete a Supplier Contact
  So that I can delete the Contacts that should no longer be associated with a Supplier


  @C35741302
  @core_regression
  @WSO2email
  Scenario: C35741302: Third-party Associated individual - Activate contacts
    Given User logs into RDDC as "Admin"
    When User creates third-party "with mandatory fields" via API and open it
    And User creates valid email
    And User creates Associated Party "Individual" "with valid email" via API and open it
    Then 'Enabled as User' checkbox is unchecked
    When User checks 'Enabled as User' checkbox on contact screen
    Then Current URL contains "/thirdparty/" endpoint
    When User clicks View External User
    Then External User modal is displayed with data
      | First Name      | Email        | Position | Last Name      | User Name    | Third-party  | User Type |
      | Test_First_Name | toBeReplaced |          | Test_Last_Name | toBeReplaced | toBeReplaced | External  |
    When User clicks close External User modal
    And User clicks Associated Party Overview contact button
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name      | Last Name      | Country | Status |
      | false         |       | Test_First_Name | Test_Last_Name |         | Active |
    And Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received

  @C37108922
  @full_regression
  @WSO2email
  Scenario: C37108922: Third-party Associated individual - Deactivate contacts
    Given User logs into RDDC as "Admin"
    When User navigates to Third-party page
    And User searches third-party with name "SUPPLIER_FOR_EDIT_EXTERNAL_USER"
    And User clicks third-party with name "SUPPLIER_FOR_EDIT_EXTERNAL_USER"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on Associated Party with name "External_User_For_Editing"
    And User checks 'Enabled as User' checkbox on contact screen
    Then Contact status control is set to "Enable" position
    When User clicks Log Out button
    And User clicks Forgot Password? button
    Then Page form is displayed with text
      | Forgot your password?                                                     |
      | Enter your email address and we'll send you a link to reset your password |
      | Back to Login                                                             |
    When User fills email for user "External User for Password Edit"
    And User clicks 'Reset' password button
    Then Confirmation dialog is shown for user "External User for Password Edit"
    When User clicks 'Ok' button
    Then Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "External User for Password Edit" user
    When User opens "Refinitiv Due Diligence Centre - Password Reset" email link
    And User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    And User clicks 'Ok' button
    Then Login page is displayed
    When User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches third-party with name "SUPPLIER_FOR_EDIT_EXTERNAL_USER"
    And User clicks third-party with name "SUPPLIER_FOR_EDIT_EXTERNAL_USER"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on Associated Party with name "External_User_For_Editing"
    And User waits for progress bar to disappear from page
    And User unchecks 'Enabled as User' checkbox on contact screen
    Then Contact status control is set to "Disable" position
    And Email notification "Refinitiv Due Diligence Centre - Your Account has been Disabled" is received by "External User for Password Edit" user
    When User clicks Log Out button
    Then Login page is displayed
    When User fills "External User for Password Edit" Username
    And User fills "password" Password
    And User clicks Sign In button
    Then Error message is displayed with error text
      | Login failed! Please recheck the username and password and try again. |

  @C35773291
  @core_regression
  Scenario: C35773291: Third-party Associated individual - Delete contact
    Given User logs into RDDC as "Admin"
    When User creates third-party "with mandatory fields"
    And User creates Associated Party "with mandatory fields"
    And User clicks Associated Party Overview contact button
    And User clicks delete button for Associated Party "with mandatory fields"
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Associated Individual? |
      | This change cannot be undone                                |
    And Confirmation button Cancel should be displayed
    And Confirmation button Delete should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Associated Party table contains associated party with values
      | Key Principal | Title | First Name      | Last Name      | Country | Status   |
      | false         |       | Test_First_Name | Test_Last_Name |         | Inactive |
    When User clicks delete button for Associated Party "with mandatory fields"
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this Associated Individual? |
      | This change cannot be undone                                |
    When User clicks Delete button on confirmation window
    And Confirmation window is disappeared
    And Associated Party "with random ID name" does not appear in the Associated Parties table
    And Current URL contains "/thirdparty/" endpoint
