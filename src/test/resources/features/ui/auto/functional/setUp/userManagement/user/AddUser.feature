@ui @functional @user_management
Feature: Set Up - User Management - Add User

  As a RDDC user with appropriate permissions
  I want to create the user accounts of RDDC
  So that I can manage the users and their access as necessary


  @C40231111
  @onlySingleThread
  Scenario: C40231111: [Add User] - Verify page elements - Billing Entity is set as required
    Given User logs into RDDC as "Admin"
    And User makes sure that Custom field "Billing Entity" is set as required via API
    When User clicks Set Up option
    Then Users table is displayed
    When User clicks 'Add New User' button
    Then Add User page is loaded
    And User creation form contains required indicator for fields
      | First Name |
      | Last Name  |
      | Email      |
      | User Type  |
      | Role       |
      | Division   |
    And User creation form doesn't contain required indicator for fields
      | Default Billing Entity |
      | Other Billing Entity   |
    And Create User page is displayed with default values
    And User "Role" drop-down contains expected values
    And User "Group" drop-down contains expected values
    And User "Superior" drop-down contains expected values
    And User "Default Billing Entity" drop-down contains expected values
    And User "Other Billing Entity" drop-down contains expected values
    And User "Division" drop-down contains expected values
    And User "Entity" drop-down contains expected values
    And User "External Organisation" drop-down contains expected values
    And User "Department" drop-down contains expected values
    And User form button "Submit" is displayed
    And User form button "Cancel" is displayed

  @C40231113
  @onlySingleThread
  Scenario: C40231113: [Add User] - Verify page elements - Billing Entity is set as NOT required
    Given User logs into RDDC as "Admin"
    And User makes sure that Custom field "Billing Entity" is set as not required via API
    When User clicks Set Up option
    Then Users table is displayed
    When User clicks 'Add New User' button
    Then Add User page is loaded
    And User creation form contains required indicator for fields
      | First Name |
      | Last Name  |
      | Email      |
      | User Type  |
      | Role       |
      | Division   |
    And User creation form doesn't contain required indicator for fields
      | Default Billing Entity |
      | Other Billing Entity   |
    And Create User page is displayed with default values
    And User "Role" drop-down contains expected values
    And User "Group" drop-down contains expected values
    And User "Superior" drop-down contains expected values
    And User "Division" drop-down contains expected values
    And User "Entity" drop-down contains expected values
    And User "External Organisation" drop-down contains expected values
    And User "Department" drop-down contains expected values
    And User form button "Submit" is displayed
    And User form button "Cancel" is displayed
    And User form "Billing information" section is not displayed

  @C40231114 @C40231114 @C32909450
  @onlySingleThread
  @WSO2email
  Scenario: C40231114, C40231114, C32909450: [Add User] - Add active user with only required fields - Enabled SSO is unticked
  User Management- Verify that upon creating new active internal user, Login Request email notification should be sent to the specific user
    Given User logs into RDDC as "Admin"
    And User creates valid email
    And User makes sure that Custom field "Billing Entity" is set as required via API
    When User clicks Set Up option
    And User clicks 'Add New User' button
    Then User form system notice is displayed "Note: The system will generate and automatically send an email with password."
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Success! User has been added |
    And Users table is displayed
    And User table contains user with values
      | First Name   | Last Name    | User Name    | User Type | Role                 | Status | Single Sign On |
      | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | ACTIVE | No             |
    When User clicks on updated user
    Then User overview is displayed with values
      | First Name   | Last Name    | Email        | User Name    | User Type | Role                 | Status | Organisation | Division   |
      | toBeReplaced | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | Active | RFG          | MyDivision |
    And Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    And User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button

  @C40231152 @C32909417 @C32909473 @C32909497 @C40220518
  @onlySingleThread
  @WSO2email
  Scenario: C40231152, C32909417, C32909473, C32909497, C40220518: [Add User] - Add active user with only required fields - Enabled SSO is ticked
  Add User (Federated) - Verify that user can check and uncheck the Enable Single Sign On button
  Add User (federated) - Verify that user should be able to add internal(federated) user successfully
  Add User (federated)- Verify that internal user can create an active and inactive account
  [Reset Password] - Internal Users - Disabled Reset password from user details view page - SSO is ON
    Given User logs into RDDC as "Admin"
    And User creates valid email
    And User makes sure that Custom field "Billing Entity" is set as required via API
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User checks 'Enable Single Sign On' Edit User checkbox
    Then User form system notice is displayed "Note: The system will not generate or automatically send an email with password."
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Success! User has been added |
    And Users table is displayed
    And User table contains user with values
      | First Name   | Last Name    | User Name    | User Type | Role                 | Status | Single Sign On |
      | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | ACTIVE | Yes            |
    When User clicks on updated user
    Then User overview is displayed with values
      | First Name   | Last Name    | Email        | User Name    | User Type | Role                 | Status | Organisation | Division   | Single Sign On |
      | toBeReplaced | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | Active | RFG          | MyDivision | Yes            |
    And Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is not received
    When User hovers over User overview button "Reset Password"
    Then Tooltip text is displayed
      | You’re not allowed to trigger reset password on this site. Please contact your Organisation admin if you need help. |
    And User form button "Reset Password" is disabled


  @C40231164 @C32909434 @C32909461
  @onlySingleThread
  @WSO2email
  Scenario: C40231164, C32909434, C32909461: [Add User] - Add active user with all fields filled - Enabled SSO is unticked
  Add Internal User - Verify that email with all capital letters and with hypen or underscore should be successfully created
  User Management - Verify that user should be able to populate all fields on Add User modal (active)
    Given User logs into RDDC as "Admin"
    And User creates valid email with special symbols
    And User makes sure that Custom field "Billing Entity" is set as required via API
    When User clicks Set Up option
    And User clicks 'Add New User' button
    Then User form system notice is displayed "Note: The system will generate and automatically send an email with password."
    When User fills in "First Name" Add User value "Ім'я"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User fills in "Position" Add User value "Test position"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Group" Edit User value "AUTO_GROUP"
    And User selects in "Superior" Edit User value "Admin_AT_FN Admin_AT_LN"
    And User selects in "Language" Edit User value "French"
    And User selects in "Division" Edit User value "MyDivision"
    And User selects in "Entity" Edit User value "MyEntity"
    And User selects in "External Organisation" Edit User value "MyOrganisation"
    And User selects in "Department" Edit User value "MyDepartment"
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Success! User has been added |
    And Users table is displayed
    And User table contains user with values
      | First Name | Last Name    | User Name    | User Type | Role                 | Status | Single Sign On |
      | Ім'я       | toBeReplaced | toBeReplaced | Internal  | System Administrator | ACTIVE | No             |
    When User clicks on updated user
    Then User overview is displayed with values
      | First Name | Last Name    | Email        | User Name    | User Type | Role                 | Group      | Superior                | Language | Status | Organisation | Division   | Entity   | External Organisation | Department   |
      | Ім'я       | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | AUTO_GROUP | Admin_AT_FN Admin_AT_LN | French   | Active | RFG          | MyDivision | MyEntity | MyOrganisation        | MyDepartment |
    And Email notification "Refinitiv Due Diligence Centre – Créer un mot de passe pour le nouveau compte" is received
    And Email "Refinitiv Due Diligence Centre – Créer un mot de passe pour le nouveau compte" contains the following text
#      | Chère/Cher Ім'я |
#    TODO text in mailHog format
      | Ch=C3=A8re/Cher =D0=86=D0=BC'=D1=8F |

  @C40231179
  @onlySingleThread
  Scenario: C40231179: [Add User] - Add user - Validations
    Given User logs into RDDC as "Admin"
    And User makes sure that Custom field "Billing Entity" is set as required via API
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Cannot save. Please complete the required fields |
    And Add User page is loaded
    And Under User Form "First Name" field there is an error message: "This field is required"
    And Under User Form "Last Name" field there is an error message: "This field is required"
    And Under User Form "Email" field there is an error message: "This field is required"
    And Under User Form "Role" field there is an error message: "This field is required"
    And Under User Form "Division" field there is an error message: "This field is required"
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "supplierintegritysa@gmail.com"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Cannot save. User Profile already exists |

  @C40231184 @C32909417 @C32909431 @C32909437
  @WSO2email
  Scenario: C40231184, C32909417, C32909431, C32909437: [Add User] - Add In-active user - Enabled SSO is unticked
  Add User (Federated) - Verify that user can check and uncheck the Enable Single Sign On button
  User Management - Verify that user should be able to add inactive internal user
  User Management - Verify that LOGIN REQUEST should not be sent to the newly added internal user email when user status is INACTIVE
    Given User logs into RDDC as "Admin"
    And User creates valid email
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User unchecks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Success! User has been added |
    And Users table is displayed
    And User table contains user with values
      | First Name   | Last Name    | User Name    | User Type | Role                 | Status   | Single Sign On |
      | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | INACTIVE | No             |
    When User clicks on updated user
    Then User overview is displayed with values
      | First Name   | Last Name    | Email        | User Name    | User Type | Role                 | Status   | Organisation | Division   |
      | toBeReplaced | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | Inactive | RFG          | MyDivision |
    And Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is not received

  @C40261653
  Scenario: C40261653: [Add User] - Verify user without permission is not able to add user
    Given User logs into RDDC as "Restricted"
    When User clicks Set Up option
    Then Setup navigation option "User" is not displayed
    When User navigates 'Set Up' block 'User' section
    Then Current URL contains "/forbidden" endpoint

  @C40265407
  Scenario: C40265407: [Add User] - Cancel changes
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User creates valid email
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Cancel' button on User Page
    Then Users table is displayed

  @C32909438 @C32909485
  Scenario: C32909438, C32909485: Admin/Internal User- User Management - Add New User- Verify that no option for external type of user in add new user
  Admin/Internal User- User Management - Add New User - Verify that Internal User is selected by default and not editable
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User clicks 'Add New User' button
    Then User Type is "Internal"
    And User Type is not editable

  @C32909486
  Scenario: C32909486: User Management - Verify that username field should be disabled when adding new internal user
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User clicks 'Add New User' button
    Then Username is not editable

  @C32909497
  Scenario: C32909497: Add User (federated)- Verify that internal user can create an active and inactive account
    Given User logs into RDDC as "Admin"
    And User creates valid email
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User unchecks 'Active' Edit User checkbox
    And User checks 'Enable Single Sign On' Edit User checkbox
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Success! User has been added |
    And Users table is displayed
    And User table contains user with values
      | First Name   | Last Name    | User Name    | User Type | Role                 | Status   | Single Sign On |
      | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | INACTIVE | Yes            |
    When User clicks on updated user
    Then User overview is displayed with values
      | First Name   | Last Name    | Email        | User Name    | User Type | Role                 | Status   | Organisation | Division   | Single Sign On |
      | toBeReplaced | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | Inactive | RFG          | MyDivision | Yes            |
